//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

func encodeToJSON(value: some Encodable) throws -> [UInt8] {
  let encoder = JSONEncoding()
  try value.encode(to: encoder)
  return JSONWriter.serialize(encoder.reference ?? .null)
}

/// Intermediate representation for serializing JSON structure.
private final class JSONReference {
  enum Backing {
    case null
    case trueKeyword
    case falseKeyword
    case string(String)
    case number(String)
    case array([JSONReference])
    case object([String: JSONReference])
  }

  var backing: Backing

  init(backing: Backing) {
    self.backing = backing
  }

  var count: Int {
    switch backing {
    case .array(let array): return array.count
    case .object(let dict): return dict.count
    default: preconditionFailure("Count does not apply to scalar")
    }
  }

  func set(key: String, value: JSONReference) {
    guard case .object(var dict) = backing else {
      preconditionFailure()
    }
    backing = .null  // Ensure 'dict' uniquely referenced.
    dict[key] = value
    backing = .object(dict)
  }

  func append(_ value: JSONReference) {
    guard case .array(var arr) = backing else {
      preconditionFailure()
    }
    backing = .null  // Ensure 'arr' uniquely referenced.
    arr.append(value)
    backing = .array(arr)
  }

  #if swift(>=6)
  // nonisolated(unsafe) is fine for these properties because they represent primitives
  // that are never modified.
  nonisolated(unsafe) static let null: JSONReference = .init(backing: .null)
  nonisolated(unsafe) static let trueKeyword: JSONReference = .init(backing: .trueKeyword)
  nonisolated(unsafe) static let falseKeyword: JSONReference = .init(backing: .falseKeyword)
  #else
  static let null: JSONReference = .init(backing: .null)
  static let trueKeyword: JSONReference = .init(backing: .trueKeyword)
  static let falseKeyword: JSONReference = .init(backing: .falseKeyword)
  #endif

  @inline(__always)
  static func newArray() -> JSONReference {
    .init(backing: .array([]))
  }

  @inline(__always)
  static func newObject() -> JSONReference {
    .init(backing: .object([:]))
  }

  @inline(__always)
  static func string(_ str: String) -> JSONReference {
    .init(backing: .string(str))
  }

  @inline(__always)
  static func number(_ integer: some BinaryInteger & LosslessStringConvertible) -> JSONReference {
    .init(backing: .number(String(integer)))
  }

  @inline(__always)
  static func number(_ floating: some BinaryFloatingPoint & LosslessStringConvertible) -> JSONReference {
    // FIXME: Error for NaN, Inf.
    .init(backing: .number(String(floating)))
  }
}

/// Serialize JSONReference to [UInt8] data.
private struct JSONWriter {
  var data: [UInt8]
  init() {
    data = []
  }

  mutating func write(_ ascii: UInt8) {
    data.append(ascii)
  }

  mutating func write(ascii: UnicodeScalar) {
    data.append(UInt8(ascii: ascii))
  }

  mutating func write(string: StaticString) {
    string.withUTF8Buffer { buffer in
      data.append(contentsOf: buffer)
    }
  }

  mutating func write(utf8: some Collection<UInt8>) {
    data.append(contentsOf: utf8)
  }

  mutating func serialize(value: JSONReference) {
    switch value.backing {
    case .null:
      write(string: "null")
    case .trueKeyword:
      write(string: "true")
    case .falseKeyword:
      write(string: "false")
    case .string(let string):
      serialize(string: string)
    case .number(var string):
      string.withUTF8 {
        write(utf8: $0)
      }
    case .array(let array):
      serialize(array: array)
    case .object(let dictionary):
      serialize(object: dictionary)
    }
  }

  mutating func serialize(string: String) {
    var string = string
    string.withUTF8 { utf8 in
      serialize(utf8String: utf8)
    }
  }

  /// Write `utf8` as a JSON string literal, escaping characters as needed.
  mutating func serialize(utf8String utf8: UnsafeBufferPointer<UInt8>) {
    let (escapeCount, controlCount) = Self.countEscapes(utf8)
    if escapeCount == 0 {
      // Fast path: nothing to escape.
      data.reserveCapacity(data.count + utf8.count + 2)
      write(ascii: "\"")
      write(utf8: utf8)
      write(ascii: "\"")
      return
    }

    // Each escaped byte is written as 2 bytes, except for control characters
    // without a short form which are written as 6 bytes ('\u00XX'). This is
    // the upper bound; the excess is removed after writing.
    let maxLength = 2 + utf8.count + escapeCount + controlCount &* 4
    let oldCount = data.count
    data.append(contentsOf: repeatElement(0, count: maxLength))
    let written = data.withUnsafeMutableBufferPointer { buffer in
      Self.writeEscaped(utf8, to: buffer.baseAddress! + oldCount)
    }
    data.removeLast(maxLength - written)
  }

  private typealias Chunk = SIMD16<UInt8>

  /// Returns a mask of the lanes in `chunk` that need escaping, and a mask of
  /// the lanes that are control characters.
  @inline(__always)
  private static func escapeMasks(
    _ chunk: Chunk
  ) -> (escape: SIMDMask<Chunk.MaskStorage>, control: SIMDMask<Chunk.MaskStorage>) {
    let control = chunk .< Chunk(repeating: 0x20)
    let quote = chunk .== Chunk(repeating: UInt8(ascii: "\""))
    let backslash = chunk .== Chunk(repeating: UInt8(ascii: "\\"))
    return (control .| quote .| backslash, control)
  }

  @inline(__always)
  private static func needsEscape(_ byte: UInt8) -> Bool {
    byte == UInt8(ascii: "\"") || byte == UInt8(ascii: "\\") || byte < 0x20
  }

  /// Count the bytes in `utf8` that need escaping, and the control characters
  /// among them.
  private static func countEscapes(_ utf8: UnsafeBufferPointer<UInt8>) -> (escape: Int, control: Int) {
    guard let start = utf8.baseAddress else {
      return (0, 0)
    }
    let end = start + utf8.count
    var cursor = start
    var escapeCount = 0
    var controlCount = 0
    while end - cursor >= Chunk.scalarCount {
      let chunk = UnsafeRawPointer(cursor).loadUnaligned(as: Chunk.self)
      let masks = escapeMasks(chunk)
      escapeCount &+= Int(Chunk().replacing(with: 1, where: masks.escape).wrappedSum())
      controlCount &+= Int(Chunk().replacing(with: 1, where: masks.control).wrappedSum())
      cursor += Chunk.scalarCount
    }
    while cursor < end {
      escapeCount &+= needsEscape(cursor.pointee) ? 1 : 0
      controlCount &+= cursor.pointee < 0x20 ? 1 : 0
      cursor += 1
    }
    return (escapeCount, controlCount)
  }

  /// Write `utf8` with escaping and the surrounding quotes to `dest`, and
  /// return the number of bytes written. `dest` must have enough capacity.
  private static func writeEscaped(
    _ utf8: UnsafeBufferPointer<UInt8>,
    to dest: UnsafeMutablePointer<UInt8>
  ) -> Int {
    var out = dest
    out.pointee = UInt8(ascii: "\"")
    out += 1

    var cursor = utf8.baseAddress!
    let end = cursor + utf8.count
    while cursor < end {
      if end - cursor >= Chunk.scalarCount {
        let chunk = UnsafeRawPointer(cursor).loadUnaligned(as: Chunk.self)
        if !any(escapeMasks(chunk).escape) {
          UnsafeMutableRawPointer(out).storeBytes(of: chunk, as: Chunk.self)
          cursor += Chunk.scalarCount
          out += Chunk.scalarCount
          continue
        }
      }
      // The chunk contains bytes that need escaping, or it's the tail. Write
      // up to a chunk byte by byte.
      let runEnd = min(end, cursor + Chunk.scalarCount)
      while cursor < runEnd {
        let byte = cursor.pointee
        cursor += 1
        let escaped: UInt8
        switch byte {
        case UInt8(ascii: "\""): escaped = UInt8(ascii: "\"")
        case UInt8(ascii: "\\"): escaped = UInt8(ascii: "\\")
        case 0x08: escaped = UInt8(ascii: "b")
        case 0x09: escaped = UInt8(ascii: "t")
        case 0x0A: escaped = UInt8(ascii: "n")
        case 0x0C: escaped = UInt8(ascii: "f")
        case 0x0D: escaped = UInt8(ascii: "r")
        case 0x00...0x1F:
          let hex: StaticString = "0123456789ABCDEF"
          out[0] = UInt8(ascii: "\\")
          out[1] = UInt8(ascii: "u")
          out[2] = UInt8(ascii: "0")
          out[3] = UInt8(ascii: "0")
          out[4] = hex.utf8Start[Int(byte >> 4)]
          out[5] = hex.utf8Start[Int(byte & 0xF)]
          out += 6
          continue
        default:
          out.pointee = byte
          out += 1
          continue
        }
        out[0] = UInt8(ascii: "\\")
        out[1] = escaped
        out += 2
      }
    }

    out.pointee = UInt8(ascii: "\"")
    out += 1
    return out - dest
  }

  mutating func serialize(array: [JSONReference]) {
    write(ascii: "[")
    var first = true
    for elem in array {
      if first {
        first = false
      } else {
        write(ascii: ",")
      }
      serialize(value: elem)
    }
    write(ascii: "]")
  }

  mutating func serialize(object: [String: JSONReference]) {
    write(ascii: "{")
    var first = true
    for key in object.keys.sorted() {
      if first {
        first = false
      } else {
        write(ascii: ",")
      }
      serialize(string: key)
      write(ascii: ":")
      serialize(value: object[key]!)
    }
    write(ascii: "}")
  }

  static func serialize(_ value: JSONReference) -> [UInt8] {
    var writer = JSONWriter()
    writer.serialize(value: value)
    return writer.data
  }
}

private class JSONEncoding {
  /// Storage of the encoded data.
  var reference: JSONReference?

  var codingPathNode: _CodingPathNode

  init(codingPathNode: _CodingPathNode = .root) {
    self.reference = nil
    self.codingPathNode = codingPathNode
  }
}

// MARK: Pure encoding functions.
extension JSONEncoding {
  func _encode(_ value: Bool) -> JSONReference {
    value ? .trueKeyword : .falseKeyword
  }

  func _encode(_ value: some BinaryFloatingPoint & LosslessStringConvertible) -> JSONReference {
    .number(value)
  }

  func _encode(_ value: some BinaryInteger & LosslessStringConvertible) -> JSONReference {
    .number(value)
  }

  func _encode(_ value: String) -> JSONReference {
    .string(value)
  }

  func _encodeGeneric<T: Encodable>(
    _ value: T,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> JSONReference {
    // Temporarily reset the state and perform the encoding.
    let old = (self.reference, self.codingPathNode)
    defer { (self.reference, self.codingPathNode) = old }

    self.reference = nil
    self.codingPathNode = codingPathNode.appending(additionalKey)

    try value.encode(to: self)
    guard let result = self.reference else {
      throw EncodingError.invalidValue(
        T.self,
        .init(
          codingPath: self.codingPathNode.path,
          debugDescription: "nothing was encoded"
        )
      )
    }
    return result
  }
}

// MARK: Encoder conformance.
extension JSONEncoding: Encoder {
  var codingPath: [any CodingKey] {
    codingPathNode.path
  }

  var userInfo: [CodingUserInfoKey: Any] { [:] }

  fileprivate struct KeyedContainer<Key: CodingKey> {
    var encoder: JSONEncoding
    var reference: JSONReference
    var codingPathNode: _CodingPathNode
  }

  fileprivate struct UnkeyedContainer {
    var encoder: JSONEncoding
    var reference: JSONReference
    var codingPathNode: _CodingPathNode
  }

  func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
    reference = .newObject()
    return KeyedEncodingContainer(
      KeyedContainer<Key>(
        encoder: self,
        reference: reference!,
        codingPathNode: codingPathNode
      )
    )
  }

  func unkeyedContainer() -> any UnkeyedEncodingContainer {
    reference = .newArray()
    return UnkeyedContainer(
      encoder: self,
      reference: reference!,
      codingPathNode: codingPathNode
    )
  }

  func singleValueContainer() -> any SingleValueEncodingContainer {
    return self
  }
}

extension JSONEncoding: SingleValueEncodingContainer {
  func encodeNil() throws {
    reference = .null
  }

  func encode(_ value: Bool) throws {
    reference = _encode(value)
  }

  func encode(_ value: String) throws {
    reference = _encode(value)
  }

  func encode(_ value: Double) throws {
    reference = _encode(value)
  }

  func encode(_ value: Float) throws {
    reference = _encode(value)
  }

  func encode(_ value: Int) throws {
    reference = _encode(value)
  }

  func encode(_ value: Int8) throws {
    reference = _encode(value)
  }

  func encode(_ value: Int16) throws {
    reference = _encode(value)
  }

  func encode(_ value: Int32) throws {
    reference = _encode(value)
  }

  func encode(_ value: Int64) throws {
    reference = _encode(value)
  }

  func encode(_ value: UInt) throws {
    reference = _encode(value)
  }

  func encode(_ value: UInt8) throws {
    reference = _encode(value)
  }

  func encode(_ value: UInt16) throws {
    reference = _encode(value)
  }

  func encode(_ value: UInt32) throws {
    reference = _encode(value)
  }

  func encode(_ value: UInt64) throws {
    reference = _encode(value)
  }

  func encode<T: Encodable>(_ value: T) throws {
    reference = try _encodeGeneric(value, codingPathNode: codingPathNode, (_CodingKey)?.none)
  }
}

extension JSONEncoding.KeyedContainer: KeyedEncodingContainerProtocol {
  var codingPath: [any CodingKey] {
    codingPathNode.path
  }

  func _set(key: Key, value: JSONReference) {
    reference.set(key: key.stringValue, value: value)
  }

  mutating func encodeNil(forKey key: Key) throws {
    _set(key: key, value: .null)
  }

  mutating func encode(_ value: Bool, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: String, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: Double, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: Float, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: Int, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: Int8, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: Int16, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: Int32, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: Int64, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: UInt, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: UInt8, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: UInt16, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: UInt32, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode(_ value: UInt64, forKey key: Key) throws {
    _set(key: key, value: encoder._encode(value))
  }

  mutating func encode<T: Encodable>(_ value: T, forKey key: Key) throws {
    _set(key: key, value: try encoder._encodeGeneric(value, codingPathNode: codingPathNode, key))
  }

  mutating func nestedContainer<NestedKey: CodingKey>(
    keyedBy keyType: NestedKey.Type,
    forKey key: Key
  ) -> KeyedEncodingContainer<NestedKey> {
    let ref: JSONReference = .newObject()
    _set(key: key, value: ref)
    return KeyedEncodingContainer(
      JSONEncoding.KeyedContainer<NestedKey>(
        encoder: encoder,
        reference: ref,
        codingPathNode: codingPathNode.appending(key)
      )
    )
  }

  mutating func nestedUnkeyedContainer(forKey key: Key) -> any UnkeyedEncodingContainer {
    let ref: JSONReference = .newArray()
    _set(key: key, value: ref)
    return JSONEncoding.UnkeyedContainer(
      encoder: encoder,
      reference: ref,
      codingPathNode: codingPathNode.appending(key)
    )
  }

  mutating func superEncoder() -> any Encoder {
    fatalError("unimplemented")
  }

  mutating func superEncoder(forKey key: Key) -> any Encoder {
    fatalError("unimplemented")
  }
}

extension JSONEncoding.UnkeyedContainer: UnkeyedEncodingContainer {
  var codingPath: [any CodingKey] {
    codingPathNode.path
  }

  var count: Int {
    reference.count
  }

  func encodeNil() throws {
    reference.append(.null)
  }

  func encode(_ value: Bool) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: String) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: Double) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: Float) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: Int) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: Int8) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: Int16) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: Int32) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: Int64) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: UInt) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: UInt8) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: UInt16) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: UInt32) throws {
    reference.append(encoder._encode(value))
  }

  func encode(_ value: UInt64) throws {
    reference.append(encoder._encode(value))
  }

  func encode<T>(_ value: T) throws where T: Encodable {
    let idx = reference.count
    let ref = try encoder._encodeGeneric(value, codingPathNode: codingPathNode, _CodingKey.index(idx))
    reference.append(ref)
  }

  func nestedContainer<NestedKey: CodingKey>(
    keyedBy keyType: NestedKey.Type
  ) -> KeyedEncodingContainer<NestedKey> {
    let ref: JSONReference = .newObject()
    let idx = count
    reference.append(ref)
    return KeyedEncodingContainer(
      JSONEncoding.KeyedContainer<NestedKey>(
        encoder: encoder,
        reference: ref,
        codingPathNode: codingPathNode.appending(index: idx)
      )
    )
  }

  func nestedUnkeyedContainer() -> any UnkeyedEncodingContainer {
    let ref: JSONReference = .newObject()
    let idx = count
    reference.append(ref)
    return JSONEncoding.UnkeyedContainer(
      encoder: encoder,
      reference: ref,
      codingPathNode: codingPathNode.appending(index: idx)
    )
  }

  func superEncoder() -> any Encoder {
    fatalError("unimplmented")
  }
}
