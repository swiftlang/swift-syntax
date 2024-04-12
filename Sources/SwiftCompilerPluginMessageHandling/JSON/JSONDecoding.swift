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

#if swift(>=6.0)
#if canImport(Darwin)
private import Darwin
#elseif canImport(Glibc)
private import Glibc
#elseif canImport(ucrt)
private import ucrt
#endif
#else
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#elseif canImport(ucrt)
import ucrt
#endif
#endif

func decodeFromJSON<T: Decodable>(json: UnsafeBufferPointer<UInt8>) throws -> T {
  try withExtendedLifetime(try JSONScanner.scan(buffer: json)) { map in
    let decoder = JSONDecoding(value: map.value, codingPathNode: .root)
    return try T.init(from: decoder)
  }
}

/*
 JSONMap is inspired by swift-foundation's JSONMap.

 For JSON payload such as:

 ```
 {"array": [-1.3, true], "number": 42}
 ```

 will be scanned by 'JSONScanner' into a map like:

 ```
 <OM> == Object Marker
 <AM> == Array Marker
 <SS> == Simple String (a variant of String that can has no escapes and can be passed directly to a UTF-8 parser)
 <NM> == Number Marker
 <TL> == NULL Marker
 map: [
   0: <OM>,      -- object marker
   1: 15,        |  `- number of *map* elements in this collection
   2: <SS>,      | --- key 1 '"array"'
   3: <int_ptr>, | |   |- pointer in the payload
   4: 7,         | |   `- length
   5: <AM>,      | --- value1 array
   6: 4,         | |   `- number of *map* elements in the array
   7: <NM>,      | | -- arr elm 1 '-1.3'
   8: <int_ptr>, | | |
   9: 4,         | | |
  10: <TL>,      | | -- arr elm 2 'true'
  11: <SS>,      | --- key 2 '"number"'
  12: <int_ptr>, | |
  13: 8,         | |
  14: <NM>       | --- value1: '42'
  15: <int_ptr>, | |
  16: 2,         | |
 ]
 ```
 To decode '<root>.number' value:
 1. Index 0 indicates it's a object.
 2. Parse a key string at index 2, which is not a  match for "number"
 3. Skip the key's value by finding it's an array, then its 'index(afterValue:)' which is 11
 4. Parse a key string at index 11, matching "number"
 5. Parse a value number at the pointer of index 15, length at index 16
*/

private struct JSONMap {
  enum Descriptor: Int {
    case nullKeyword  // [desc]
    case trueKeyword  // [desc]
    case falseKeyword  // [desc]
    case number  // [desc, pointer, length]
    case simpleString  // [desc, pointer, length]
    case string  // [desc, pointer, length]
    case object  // [desc, count, (key, value)...]
    case array  // [desc, count, element...]
  }
  typealias Data = [Int]
  let data: [Int]

  /// Top-level value.
  var value: JSONMapValue {
    JSONMapValue(map: data[...])
  }
}

/// Slice of JSONMap representing a single value.
private struct JSONMapValue {
  typealias Map = JSONMap.Data.SubSequence
  typealias Index = Map.Index
  let map: Map

  var startIndex: Index { map.startIndex }
  var endIndex: Index { map.endIndex }

  /// Index at offset from 'startIndex'.
  func index(offset: Int) -> Index {
    map.index(startIndex, offsetBy: offset)
  }

  /// Assuming 'valueIndex' is a valid descriptor index, returns the index of
  /// the next value in a collection.
  func index(afterValue valueIndex: Index) -> Index {
    switch JSONMap.Descriptor(rawValue: map[valueIndex]) {
    case .nullKeyword, .trueKeyword, .falseKeyword:
      // [desc]
      return map.index(valueIndex, offsetBy: 1)
    case .number, .simpleString, .string:
      // [desc, pointer, length]
      return map.index(valueIndex, offsetBy: 3)
    case .array, .object:
      // [desc, count, element...]
      // [desc, count, (key, value)...]
      let count = map[map.index(valueIndex, offsetBy: 1)]
      assert(count >= 0, "counter must be a positive number");
      return map.index(valueIndex, offsetBy: 2 + count)
    case nil:
      fatalError("invalid value descriptor")
    }
  }

  @inline(__always)
  func `is`(_ kind: JSONMap.Descriptor) -> Bool {
    return map.first == kind.rawValue
  }

  @inline(__always)
  func value(at i: Index) -> JSONMapValue {
    return .init(map: map[i..<index(afterValue: i)])
  }
}

// MARK: Keyword primitives
extension JSONMapValue {
  var isNull: Bool {
    return self.is(.nullKeyword)
  }

  var asBool: Bool? {
    if self.is(.trueKeyword) {
      return true
    }
    if self.is(.falseKeyword) {
      return false
    }
    return nil
  }
}

// MARK: Scalar values
private enum _JSONStringDecoder {
  /// Trim '"' from string literal buffer.
  static func trimQuotes(source: UnsafeBufferPointer<UInt8>) -> UnsafeBufferPointer<UInt8> {
    assert(source.count >= 2)
    assert(source.first == UInt8(ascii: "\"") && source.last! == UInt8(ascii: "\""))
    return .init(rebasing: source.dropFirst().dropLast())
  }

  /// Decode .simpleString value from the buffer.
  static func decodeSimpleString(source: UnsafeBufferPointer<UInt8>) -> String {
    let source = trimQuotes(source: source)
    if source.count <= 0 {
      return ""
    }
    if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
      return String(unsafeUninitializedCapacity: source.count) { buffer in
        buffer.initialize(fromContentsOf: source)
      }
    } else {
      return String(decoding: source, as: UTF8.self)
    }
  }

  static func decodeStringWithEscapes(source: UnsafeBufferPointer<UInt8>) -> String {
    let source = trimQuotes(source: source)
    var string: String = ""
    var iter = source.makeIterator()
    var utf8Decoder = UTF8()
    DECODE: while true {
      switch utf8Decoder.decode(&iter) {
      case .scalarValue(let scalar):
        if scalar == "\\" {
          switch iter.next() {
          case UInt8(ascii: "\""): string.append("\"")
          case UInt8(ascii: "'"): string.append("'")
          case UInt8(ascii: "\\"): string.append("\\")
          case UInt8(ascii: "/"): string.append("/")
          case UInt8(ascii: "b"): string.append("\u{08}")  // \b
          case UInt8(ascii: "f"): string.append("\u{0C}")  // \f
          case UInt8(ascii: "n"): string.append("\u{0A}")  // \n
          case UInt8(ascii: "r"): string.append("\u{0D}")  // \r
          case UInt8(ascii: "t"): string.append("\u{09}")  // \t
          case UInt8(ascii: "u"):
            fatalError("unimplemented")
          default:
            fatalError("invalid")
          }
        } else {
          string.append(Character(scalar))
        }
      case .emptyInput:
        break DECODE
      case .error:
        fatalError("invalid")
      }
    }
    return string
  }
}

private enum _JSONNumberDecoder {
  static func parseInteger<Integer: FixedWidthInteger>(source: UnsafeBufferPointer<UInt8>) -> Integer? {
    var source = source[...]
    let isNegative = source.first == UInt8(ascii: "-")
    if isNegative {
      source = source.dropFirst()
    }
    var value: Integer = 0
    var overflowed: Bool = false
    while let digit = source.popFirst() {
      let digitValue = Integer(truncatingIfNeeded: digit &- UInt8(ascii: "0"))
      guard (0...9).contains(digitValue) else {
        return nil
      }
      (value, overflowed) = value.multipliedReportingOverflow(by: 10)
      guard !overflowed else {
        return nil
      }
      (value, overflowed) =
        isNegative
        ? value.subtractingReportingOverflow(digitValue)
        : value.addingReportingOverflow(digitValue)
      guard !overflowed else {
        return nil
      }
    }
    return value
  }

  static func parseFloatingPoint<Floating: BinaryFloatingPoint>(source: UnsafeBufferPointer<UInt8>) -> Floating? {
    var endPtr: UnsafeMutablePointer<CChar>? = nil
    let value: Floating?
    if (Floating.self == Double.self) {
      value = Floating(exactly: strtod(source.baseAddress!, &endPtr))
    } else if (Floating.self == Float.self) {
      value = Floating(exactly: strtof(source.baseAddress!, &endPtr))
    } else {
      fatalError("unsupported floating point type")
    }
    guard endPtr! == source.baseAddress! + source.count else {
      return nil
    }
    return value
  }
}

extension JSONMapValue {
  /// Get value buffer for .number, .string, and .simpleString.
  func valueBuffer() -> UnsafeBufferPointer<UInt8> {
    UnsafeBufferPointer<UInt8>(
      start: UnsafePointer(bitPattern: map[index(offset: 1)]),
      count: map[index(offset: 2)]
    )
  }

  var asString: String? {
    if self.is(.simpleString) {
      return _JSONStringDecoder.decodeSimpleString(source: valueBuffer())
    }
    if self.is(.string) {
      return _JSONStringDecoder.decodeStringWithEscapes(source: valueBuffer())
    }
    return nil
  }

  func asFloatingPoint<Floating: BinaryFloatingPoint>(_: Floating.Type) -> Floating? {
    return _JSONNumberDecoder.parseFloatingPoint(source: self.valueBuffer())
  }

  func asInteger<Integer: FixedWidthInteger>(_: Integer.Type) -> Integer? {
    // FIXME: Support 42.0 as an integer.
    return _JSONNumberDecoder.parseInteger(source: self.valueBuffer())
  }
}

extension JSONMapValue {
  struct JSONArray: Collection {
    typealias Index = JSONMapValue.Index
    let map: JSONMapValue

    var startIndex: Index { map.index(offset: 2) }
    var endIndex: Index { map.endIndex }
    func index(after i: Index) -> Index { map.index(afterValue: i) }
    subscript(index: Index) -> JSONMapValue { map.value(at: index) }
  }

  var isArray: Bool {
    self.is(.array)
  }

  func asArray() -> JSONArray? {
    guard isArray else {
      return nil
    }
    return JSONArray(map: self)
  }

  struct ObjectIterator {
    let map: JSONMapValue
    var currIndex: Int

    init(map: JSONMapValue) {
      assert(map.is(.object))
      self.map = map
      self.currIndex = map.index(offset: 2)
    }

    mutating func next() -> (key: JSONMapValue, value: JSONMapValue)? {
      guard currIndex != map.endIndex else {
        return nil
      }
      let key = map.value(at: currIndex)
      let val = map.value(at: key.endIndex)
      currIndex = val.endIndex
      return (key, val)
    }
  }

  var isObject: Bool {
    self.is(.object)
  }

  func makeObjectIterator() -> ObjectIterator? {
    guard isObject else {
      return nil
    }
    return ObjectIterator(map: self)
  }
}

private struct JSONMapBuilder {
  var mapData: [Int]
  init() {
    mapData = []
    mapData.reserveCapacity(256)  // TODO: estimate optimal value.d
  }

  @inline(__always)
  mutating func record(_ descriptor: JSONMap.Descriptor) {
    mapData.append(descriptor.rawValue)
  }

  @inline(__always)
  mutating func record(_ descriptor: JSONMap.Descriptor, range: Range<UnsafePointer<UInt8>>) {
    mapData.append(descriptor.rawValue)
    mapData.append(Int(bitPattern: range.lowerBound))
    mapData.append(range.count)
  }

  mutating func startCollection(_ descriptor: JSONMap.Descriptor) -> Int {
    let handle = mapData.count
    mapData.append(descriptor.rawValue)
    mapData.append(0)  // Count, this will be updated in closeCollection()
    return handle
  }

  mutating func closeCollection(handle: Int) {
    // 'handle': descriptor index.
    // 'handle+1': counter index.
    mapData[handle + 1] = mapData.count - handle - 2
  }

  func finalize() -> JSONMap {
    JSONMap(data: mapData)
  }
}

enum JSONError: Error {
  case unexpectedEndOfFile
  case unexpectedCharacter(UInt8, context: String)
}

private struct JSONScanner {
  typealias Cursor = UnsafePointer<UInt8>

  let endPtr: Cursor
  var ptr: Cursor
  var map: JSONMapBuilder

  init(buffer: UnsafeBufferPointer<UInt8>) {
    self.ptr = buffer.baseAddress!
    self.endPtr = buffer.baseAddress! + buffer.count
    self.map = JSONMapBuilder()
  }

  var hasData: Bool {
    ptr != endPtr
  }

  @inline(__always)
  mutating func skipWhilespace() {
    while hasData {
      switch ptr.pointee {
      case UInt8(ascii: " "), UInt8(ascii: "\t"), UInt8(ascii: "\n"), UInt8(ascii: "\r"):
        ptr += 1
      default:
        return
      }
    }
  }

  @inline(__always)
  mutating func advance() throws -> UInt8 {
    guard hasData else {
      throw JSONError.unexpectedEndOfFile
    }
    let value = ptr.pointee
    ptr += 1
    return value
  }

  @inline(__always)
  mutating func advance(if char: UnicodeScalar) -> Bool {
    guard hasData, ptr.pointee == UInt8(ascii: char) else {
      return false
    }
    ptr += 1
    return true
  }

  @inline(__always)
  mutating func advance(if range: ClosedRange<UnicodeScalar>) -> Bool {
    guard hasData, range.contains(UnicodeScalar(ptr.pointee)) else {
      return false
    }
    ptr += 1
    return true
  }

  @inline(__always)
  mutating func expect(_ char: UnicodeScalar) throws {
    guard advance(if: char) else {
      throw JSONError.unexpectedCharacter(ptr.pointee, context: "expected \(char)")
    }
  }

  mutating func scanNull() throws {
    try expect("u")
    try expect("l")
    try expect("l")
    map.record(.nullKeyword)
  }

  mutating func scanTrue() throws {
    try expect("r")
    try expect("u")
    try expect("e")
    map.record(.trueKeyword)
  }

  mutating func scanFalse() throws {
    try expect("a")
    try expect("l")
    try expect("s")
    try expect("e")
    map.record(.falseKeyword)
  }

  mutating func scanString(start: Cursor) throws {
    ptr = start
    try expect("\"")
    var hasEscape = false
    while hasData && ptr.pointee != UInt8(ascii: "\"") {
      if ptr.pointee == UInt8(ascii: "\\") {
        hasEscape = true
        _ = try advance()
      }
      _ = try advance()
    }
    try expect("\"")
    map.record(hasEscape ? .string : .simpleString, range: start..<ptr)
  }

  mutating func scanNumber(start: Cursor) throws {
    ptr = start
    _ = advance(if: "-")
    while advance(if: "0"..."9") {}
    if advance(if: ".") {
      while advance(if: "0"..."9") {}
    }
    if advance(if: "e") || advance(if: "E") {
      _ = advance(if: "-") || advance(if: "+")
      while advance(if: "0"..."9") {}
    }
    map.record(.number, range: start..<ptr)
  }

  mutating func scanObject() throws {
    let handle = map.startCollection(.object)
    skipWhilespace()
    if !advance(if: "}") {
      while hasData {
        try scanString(start: ptr)
        skipWhilespace()
        try expect(":")
        try scanValue()
        if advance(if: ",") {
          skipWhilespace()
          continue
        }
        break
      }
      try expect("}")
    }
    map.closeCollection(handle: handle)
  }

  mutating func scanArray() throws {
    let handle = map.startCollection(.array)
    skipWhilespace()
    if !advance(if: "]") {
      while hasData {
        try scanValue()
        if advance(if: ",") {
          skipWhilespace()
          continue
        }
        break
      }
      try expect("]")
    }
    map.closeCollection(handle: handle)
  }

  mutating func scanValue() throws {
    skipWhilespace()
    let start = ptr
    switch try advance() {
    case UInt8(ascii: "n"):
      try scanNull()
    case UInt8(ascii: "t"):
      try scanTrue()
    case UInt8(ascii: "f"):
      try scanFalse()
    case UInt8(ascii: "\""):
      try scanString(start: start)
    case UInt8(ascii: "-"), UInt8(ascii: "0")...UInt8(ascii: "9"):
      try scanNumber(start: start)
    case UInt8(ascii: "{"):
      try scanObject()
    case UInt8(ascii: "["):
      try scanArray()
    case let chr:
      throw JSONError.unexpectedCharacter(chr, context: "value start")
    }
    skipWhilespace()
  }

  static func scan(buffer: UnsafeBufferPointer<UInt8>) throws -> JSONMap {
    var scanner = JSONScanner(buffer: buffer)
    try scanner.scanValue()
    if scanner.hasData {
      throw JSONError.unexpectedCharacter(scanner.ptr.pointee, context: "after top-level value")
    }

    return scanner.map.finalize()
  }
}

private struct JSONDecoding {
  var value: JSONMapValue
  var codingPathNode: _CodingPathNode
}

extension JSONDecoding {
  @inline(__always)
  static func _unwrapOrThrow<T>(
    _ v: T?,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> T {
    guard let v = v else {
      throw DecodingError.typeMismatch(
        T.self,
        .init(
          codingPath: codingPathNode.path(byAppending: additionalKey),
          debugDescription: "type mismatch"
        )
      )
    }
    return v
  }
  @inline(__always)
  static func _decode(
    _ value: JSONMapValue,
    as _: Bool.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> Bool {
    try _unwrapOrThrow(value.asBool, codingPathNode: codingPathNode, additionalKey)
  }
  @inline(__always)
  static func _decode(
    _ value: JSONMapValue,
    as _: String.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> String {
    try _unwrapOrThrow(value.asString, codingPathNode: codingPathNode, additionalKey)
  }
  @inline(__always)
  static func _decode<Integer: FixedWidthInteger>(
    _ value: JSONMapValue,
    as type: Integer.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> Integer {
    try _unwrapOrThrow(value.asInteger(type), codingPathNode: codingPathNode, additionalKey)
  }
  @inline(__always)
  static func _decode<Floating: BinaryFloatingPoint>(
    _ value: JSONMapValue,
    as type: Floating.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> Floating {
    try _unwrapOrThrow(value.asFloatingPoint(type), codingPathNode: codingPathNode, additionalKey)
  }

  static func _decodeGeneric<T: Decodable>(
    _ value: JSONMapValue,
    as type: T.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> T {
    let decoder = Self(value: value, codingPathNode: codingPathNode.appending(additionalKey))
    return try T.init(from: decoder)
  }
}

extension JSONDecoding: Decoder {
  var codingPath: [any CodingKey] {
    codingPathNode.path
  }
  var userInfo: [CodingUserInfoKey: Any] { [:] }

  fileprivate struct KeyedContainer<Key: CodingKey> {
    var codingPathNode: _CodingPathNode
    var mapping: [String: JSONMapValue]
  }

  fileprivate struct UnkeyedContainer {
    var codingPathNode: _CodingPathNode
    var currentIndex: Int
    var array: JSONMapValue.JSONArray
    var _currMapIdx: JSONMapValue.JSONArray.Index
  }

  func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
    return try KeyedDecodingContainer(
      KeyedContainer<Key>(
        value: value,
        codingPathNode: codingPathNode
      )
    )
  }

  func unkeyedContainer() throws -> any UnkeyedDecodingContainer {
    return try UnkeyedContainer(
      value: value,
      codingPathNode: codingPathNode
    )
  }

  func singleValueContainer() throws -> any SingleValueDecodingContainer {
    return self
  }
}

extension JSONDecoding: SingleValueDecodingContainer {
  func decodeNil() -> Bool {
    value.isNull
  }

  func decode(_ type: Bool.Type) throws -> Bool {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: String.Type) throws -> String {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: Double.Type) throws -> Double {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: Float.Type) throws -> Float {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: Int.Type) throws -> Int {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: Int8.Type) throws -> Int8 {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: Int16.Type) throws -> Int16 {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: Int32.Type) throws -> Int32 {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: Int64.Type) throws -> Int64 {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: UInt.Type) throws -> UInt {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: UInt8.Type) throws -> UInt8 {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: UInt16.Type) throws -> UInt16 {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: UInt32.Type) throws -> UInt32 {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode(_ type: UInt64.Type) throws -> UInt64 {
    try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }

  func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
    try JSONDecoding._decodeGeneric(value, as: type, codingPathNode: codingPathNode, _CodingKey?.none)
  }
}

extension JSONDecoding.KeyedContainer: KeyedDecodingContainerProtocol {
  var codingPath: [any CodingKey] {
    codingPathNode.path
  }

  var allKeys: [Key] {
    mapping.keys.compactMap(Key.init(stringValue:))
  }

  func contains(_ key: Key) -> Bool {
    mapping.keys.contains(key.stringValue)
  }

  @inline(__always)
  func _getOrThrow(forKey key: Key) throws -> JSONMapValue {
    guard let value = mapping[key.stringValue] else {
      throw DecodingError.keyNotFound(
        key,
        .init(
          codingPath: codingPathNode.path,
          debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."
        )
      )
    }
    return value
  }

  func decodeNil(forKey key: Key) throws -> Bool {
    try _getOrThrow(forKey: key).isNull
  }

  func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: String.Type, forKey key: Key) throws -> String {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
    try JSONDecoding._decodeGeneric(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode, key)
  }

  func nestedContainer<NestedKey: CodingKey>(
    keyedBy keyType: NestedKey.Type,
    forKey key: Key
  ) throws -> KeyedDecodingContainer<NestedKey> {
    return try KeyedDecodingContainer(
      JSONDecoding.KeyedContainer<NestedKey>(
        value: try _getOrThrow(forKey: key),
        codingPathNode: codingPathNode.appending(key)
      )
    )
  }

  func nestedUnkeyedContainer(forKey key: Key) throws -> any UnkeyedDecodingContainer {
    return try JSONDecoding.UnkeyedContainer(
      value: _getOrThrow(forKey: key),
      codingPathNode: codingPathNode.appending(key)
    )
  }

  func superDecoder() throws -> any Decoder {
    fatalError("unimplemented")
  }

  func superDecoder(forKey key: Key) throws -> any Decoder {
    fatalError("unimplemented")
  }

  init(value: JSONMapValue, codingPathNode: _CodingPathNode) throws {
    guard value.isObject else {
      throw DecodingError.typeMismatch(
        [String: Any].self,
        .init(
          codingPath: codingPathNode.path,
          debugDescription: "not an array"
        )
      )
    }
    self.codingPathNode = codingPathNode
    self.mapping = [:]
    var iter = value.makeObjectIterator()!
    while let elem = iter.next() {
      guard let keyStr = elem.key.asString else {
        throw DecodingError.typeMismatch(
          String.self,
          .init(
            codingPath: codingPathNode.path,
            debugDescription: "expected a string as a key"
          )
        )
      }
      self.mapping[keyStr] = elem.value
    }
  }
}

extension JSONDecoding.UnkeyedContainer: UnkeyedDecodingContainer {
  var codingPath: [any CodingKey] {
    codingPathNode.path
  }

  var count: Int? {
    array.count
  }

  var isAtEnd: Bool {
    _currMapIdx == array.endIndex
  }

  @inline(__always)
  mutating func advanceToNextValue() {
    _currMapIdx = array.index(after: _currMapIdx)
    currentIndex += 1
  }

  @inline(__always)
  mutating func _getOrThrow() throws -> (index: any CodingKey, value: JSONMapValue) {
    let idx = currentIndex
    guard !isAtEnd else {
      throw DecodingError.valueNotFound(
        Any.self,
        .init(
          codingPath: codingPathNode.path(byAppendingIndex: idx),
          debugDescription: "Unkeyed container is at end"
        )
      )
    }
    let value = array[_currMapIdx]
    advanceToNextValue()
    return (_CodingKey(index: idx), value)
  }

  @inline(__always)
  mutating func _decodeInteger<Integer: FixedWidthInteger>(_ type: Integer.Type) throws -> Integer {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, idx)
  }

  @inline(__always)
  mutating func _decodeFloating<Floating: BinaryFloatingPoint>(_ type: Floating.Type) throws -> Floating {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, idx)
  }

  mutating func decodeNil() throws -> Bool {
    if !isAtEnd && array[_currMapIdx].isNull {
      advanceToNextValue()
    }
    // The protocol states:
    //   If the value is not null, does not increment currentIndex.
    return false
  }

  mutating func decode(_ type: Bool.Type) throws -> Bool {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, idx)
  }

  mutating func decode(_ type: String.Type) throws -> String {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode, idx)
  }

  mutating func decode(_ type: Double.Type) throws -> Double {
    try _decodeFloating(type)
  }

  mutating func decode(_ type: Float.Type) throws -> Float {
    try _decodeFloating(type)
  }

  mutating func decode(_ type: Int.Type) throws -> Int {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: Int8.Type) throws -> Int8 {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: Int16.Type) throws -> Int16 {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: Int32.Type) throws -> Int32 {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: Int64.Type) throws -> Int64 {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: UInt.Type) throws -> UInt {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
    try _decodeInteger(type)
  }

  mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
    try _decodeInteger(type)
  }

  mutating func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decodeGeneric(value, as: type, codingPathNode: codingPathNode, idx)
  }

  mutating func nestedContainer<NestedKey: CodingKey>(
    keyedBy keyType: NestedKey.Type
  ) throws -> KeyedDecodingContainer<NestedKey> {
    let (idx, value) = try _getOrThrow()
    return try KeyedDecodingContainer(
      JSONDecoding.KeyedContainer<NestedKey>(
        value: value,
        codingPathNode: codingPathNode.appending(idx)
      )
    )
  }

  mutating func nestedUnkeyedContainer() throws -> any UnkeyedDecodingContainer {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding.UnkeyedContainer(
      value: value,
      codingPathNode: codingPathNode.appending(idx)
    )
  }

  mutating func superDecoder() throws -> any Decoder {
    fatalError("unimplemented")
  }

  init(value: JSONMapValue, codingPathNode: _CodingPathNode) throws {
    guard value.isArray else {
      throw DecodingError.typeMismatch(
        [Any].self,
        .init(
          codingPath: codingPathNode.path,
          debugDescription: "not an array"
        )
      )
    }
    self.codingPathNode = codingPathNode
    self.currentIndex = 0
    self.array = value.asArray()!
    self._currMapIdx = self.array.startIndex
  }
}
