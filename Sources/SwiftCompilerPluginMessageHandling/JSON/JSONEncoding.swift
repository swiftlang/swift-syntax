//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
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
    write(ascii: "\"")
    string.withUTF8 { utf8 in
      let start = utf8.baseAddress!
      let end = start + utf8.count
      var mark = start

      for cursor in start..<end {
        @inline(__always) func flush() {
          write(utf8: UnsafeBufferPointer(start: mark, count: cursor - mark))
          mark = cursor + 1
        }
        switch cursor.pointee {
        case UInt8(ascii: "\""):
          flush()
          write(string: "\\\"")
        case UInt8(ascii: "\\"):
          flush()
          write(string: "\\\\")
        case 0x08:
          flush()
          write(string: "\\b")
        case 0x09:
          flush()
          write(string: "\\t")
        case 0x0A:
          flush()
          write(string: "\\n")
        case 0x0C:
          flush()
          write(string: "\\f")
        case 0x0D:
          flush()
          write(string: "\\r")
        case 0x00...0x1F:
          let c = cursor.pointee
          flush()
          write(string: "\\u00")
          let _0 = UInt8(ascii: "0")
          let _A = UInt8(ascii: "A")
          for shift in stride(from: 4, through: 0, by: -4) {
            let d = (c >> shift) & 0xF
            write(d < 10 ? (_0 + d) : (_A + d - 10))
          }
        default:
          // Accumulate this byte.
          break
        }
      }

      // Append accumulated bytes.
      if end > mark {
        write(utf8: UnsafeBufferPointer(start: mark, count: end - mark))
      }
    }
    write(ascii: "\"")
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
