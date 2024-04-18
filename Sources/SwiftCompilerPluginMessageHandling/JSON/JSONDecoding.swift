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
  let map: JSONMap
  do {
    map = try JSONScanner.scan(buffer: json)
  } catch let err as JSONError {
    throw DecodingError.dataCorrupted(
      DecodingError.Context(
        codingPath: [],
        debugDescription: "Corrupted JSON",
        underlyingError: err
      )
    )
  }
  return try map.withValue { value in
    let decoder = JSONDecoding(value: value, codingPathNode: .root)
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
   2: <SS>,      | --- key 1: 'array'
   3: <int_ptr>, | |   |- pointer in the payload
   4: 5,         | |   `- length
   5: <AM>,      | --- value 1: array
   6: 4,         | |   `- number of *map* elements in the array
   7: <NM>,      | | -- arr elm 1: '-1.3'
   8: <int_ptr>, | | |
   9: 4,         | | |
  10: <TL>,      | | -- arr elm 2: 'true'
  11: <SS>,      | --- key 2: 'number'
  12: <int_ptr>, | |
  13: 6,         | |
  14: <NM>       | --- value 2: '42'
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
  let data: [Int]

  /// Top-level value.
  func withValue<T>(_ fn: (JSONMapValue) throws -> T) rethrows -> T {
    try withExtendedLifetime(data) {
      try data.withUnsafeBufferPointer { buf in
        try fn(JSONMapValue(data: buf.baseAddress!))
      }
    }
  }
}

private struct JSONMapBuilder {
  var mapData: [Int]

  init() {
    mapData = []
    mapData.reserveCapacity(128)  // 128 is good enough for most PluginMessage.
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

  @inline(__always)
  mutating func startCollection(_ descriptor: JSONMap.Descriptor) -> Int {
    let handle = mapData.count
    mapData.append(descriptor.rawValue)
    mapData.append(0)  // Count, this will be updated in closeCollection()
    return handle
  }

  @inline(__always)
  mutating func closeCollection(handle: Int) {
    // 'handle': descriptor index.
    // 'handle+1': counter index.
    mapData[handle + 1] = mapData.count - handle - 2
  }

  func finalize() -> JSONMap {
    JSONMap(data: mapData)
  }
}

enum JSONError: Error, CustomDebugStringConvertible {
  case unexpectedEndOfFile
  case unexpectedCharacter(UInt8, context: String)

  var debugDescription: String {
    switch self {
    case .unexpectedEndOfFile:
      return "unexpected end of file"
    case .unexpectedCharacter(let c, let ctxt):
      let char = c < 0x80 ? String(UnicodeScalar(c)) : "0x" + String(c, radix: 16, uppercase: true)
      return "unexpected character '\(char)'; \(ctxt)"
    }
  }
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
    guard hasData else {
      throw JSONError.unexpectedEndOfFile
    }
    guard ptr.pointee == UInt8(ascii: char) else {
      throw JSONError.unexpectedCharacter(ptr.pointee, context: "expected '\(char)'")
    }
    ptr += 1
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
    map.record(hasEscape ? .string : .simpleString, range: (start + 1)..<(ptr - 1))
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

/// Represents a single value in a JSONMap.
private struct JSONMapValue {
  typealias Pointer = UnsafePointer<Int>
  /// Pointer to an element descriptor in the map.
  let data: Pointer

  @inline(__always)
  var endPtr: Pointer {
    data.advanced(by: mapSize)
  }

  /// The size of this value data in the map.
  @inline(__always)
  var mapSize: Int {
    switch JSONMap.Descriptor(rawValue: data[0]) {
    case .nullKeyword, .trueKeyword, .falseKeyword:
      return 1
    case .number, .simpleString, .string:
      return 3
    case .array, .object:
      return 2 &+ data[1]
    case nil:
      fatalError("invalid value descriptor")
    }
  }

  @inline(__always)
  func `is`(_ kind: JSONMap.Descriptor) -> Bool {
    return data[0] == kind.rawValue
  }
}

// MARK: Keyword primitives
extension JSONMapValue {
  @inline(__always)
  var isNull: Bool {
    return self.is(.nullKeyword)
  }

  @inline(__always)
  func asBool() -> Bool? {
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
private enum _JSONStringParser {
  /// Decode .simpleString value from the buffer.
  static func decodeSimpleString(source: UnsafeBufferPointer<UInt8>) -> String {
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

  /// Helper iterator decoding UTF8 sequence to UnicodeScalar stream.
  struct ScalarIterator<S: Sequence>: IteratorProtocol where S.Element == UInt8 {
    var backing: S.Iterator
    var decoder: UTF8
    init(_ source: S) {
      self.backing = source.makeIterator()
      self.decoder = UTF8()
    }
    mutating func next() -> UnicodeScalar? {
      switch decoder.decode(&backing) {
      case .scalarValue(let scalar): return scalar
      case .emptyInput: return nil
      case .error: fatalError("invalid")
      }
    }
  }

  static func decodeStringWithEscapes(source: UnsafeBufferPointer<UInt8>) -> String? {
    var string: String = ""
    string.reserveCapacity(source.count)
    var iter = ScalarIterator(source)
    while let scalar = iter.next() {
      // NOTE: We don't report detailed errors because we only care well-formed
      // payloads from the compiler.
      if scalar == "\\" {
        switch iter.next() {
        case "\"": string.append("\"")
        case "'": string.append("'")
        case "\\": string.append("\\")
        case "/": string.append("/")
        case "b": string.append("\u{08}")
        case "f": string.append("\u{0C}")
        case "n": string.append("\u{0A}")
        case "r": string.append("\u{0D}")
        case "t": string.append("\u{09}")
        case "u":
          // We don't care performance of this because \uFFFF style escape is
          // pretty rare. We only do it for control characters.
          let buffer: [UInt8] = [iter.next(), iter.next(), iter.next(), iter.next()]
            .compactMap { $0 }
            .compactMap { UInt8(exactly: $0.value) }

          guard
            buffer.count == 4,
            let result: UInt16 = buffer.withUnsafeBufferPointer(_JSONNumberParser.parseHexIntegerDigits(source:)),
            let scalar = UnicodeScalar(result)
          else {
            return nil
          }
          string.append(Character(scalar))
        default:
          // invalid escape sequence
          return nil
        }
      } else {
        string.append(Character(scalar))
      }
    }
    return string
  }
}

private enum _JSONNumberParser {
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

  static func parseHexIntegerDigits<Integer: FixedWidthInteger>(source: UnsafeBufferPointer<UInt8>) -> Integer? {
    var source = source[...]
    var value: Integer = 0
    var overflowed: Bool = false
    while let digit = source.popFirst() {
      let digitValue: Integer
      switch digit {
      case UInt8(ascii: "0")...UInt8(ascii: "9"):
        digitValue = Integer(truncatingIfNeeded: digit &- UInt8(ascii: "0"))
      case UInt8(ascii: "a")...UInt8(ascii: "f"):
        digitValue = Integer(truncatingIfNeeded: digit &- UInt8(ascii: "a") &+ 10)
      case UInt8(ascii: "A")...UInt8(ascii: "F"):
        digitValue = Integer(truncatingIfNeeded: digit &- UInt8(ascii: "A") &+ 10)
      default:
        return nil
      }
      (value, overflowed) = value.multipliedReportingOverflow(by: 16)
      guard !overflowed else {
        return nil
      }
      (value, overflowed) = value.addingReportingOverflow(digitValue)
      guard !overflowed else {
        return nil
      }
    }
    return value
  }
}

extension JSONMapValue {
  /// Get value buffer for .number, .string, and .simpleString.
  @inline(__always)
  func valueBuffer() -> UnsafeBufferPointer<UInt8> {
    UnsafeBufferPointer<UInt8>(
      start: UnsafePointer(bitPattern: data[1]),
      count: data[2]
    )
  }

  @inline(__always)
  func asString() -> String? {
    if self.is(.simpleString) {
      return _JSONStringParser.decodeSimpleString(source: valueBuffer())
    }
    if self.is(.string) {
      return _JSONStringParser.decodeStringWithEscapes(source: valueBuffer())
    }
    return nil
  }

  /// Returns true if this value represents a string, and it equals to 'str'.
  ///
  /// This is faster than 'value.asString() == str' because this doesn't
  /// instantiate 'Swift.String' unless there are escaped characters.
  func equals(to str: String) -> Bool {
    if self.is(.simpleString) {
      let buffer = valueBuffer()
      var str = str
      return str.withUTF8 { utf8 in
        utf8.count == buffer.count && memcmp(utf8.baseAddress, buffer.baseAddress, utf8.count) == 0
      }
    }
    return self.asString() == str
  }

  @inline(__always)
  func asFloatingPoint<Floating: BinaryFloatingPoint>(_: Floating.Type) -> Floating? {
    return _JSONNumberParser.parseFloatingPoint(source: self.valueBuffer())
  }

  @inline(__always)
  func asInteger<Integer: FixedWidthInteger>(_: Integer.Type) -> Integer? {
    // FIXME: Support 42.0 as an integer.
    return _JSONNumberParser.parseInteger(source: self.valueBuffer())
  }
}

// MARK: Collection values
extension JSONMapValue {
  struct JSONArray: Collection {
    let map: JSONMapValue

    var startIndex: Pointer { map.data.advanced(by: 2) }
    var endIndex: Pointer { map.endPtr }
    func index(after pointer: Pointer) -> Pointer {
      self[pointer].endPtr
    }
    subscript(pointer: Pointer) -> JSONMapValue {
      JSONMapValue(data: pointer)
    }
  }

  @inline(__always)
  func asArray() -> JSONArray? {
    guard self.is(.array) else {
      return nil
    }
    return JSONArray(map: self)
  }

  struct JSONObject {
    let map: JSONMapValue

    struct Iterator: IteratorProtocol {
      var currPtr: Pointer
      let endPtr: Pointer

      @inline(__always)
      init(map: JSONMapValue) {
        self.currPtr = map.data.advanced(by: 2)
        self.endPtr = map.endPtr
      }

      mutating func next() -> (key: JSONMapValue, value: JSONMapValue)? {
        guard currPtr != endPtr else {
          return nil
        }
        let key = JSONMapValue(data: currPtr)
        let val = JSONMapValue(data: key.endPtr)
        currPtr = val.endPtr
        return (key, val)
      }
    }

    @inline(__always)
    func makeIterator() -> Iterator {
      return Iterator(map: map)
    }

    @inline(__always)
    func find(_ key: String) -> JSONMapValue? {
      // Linear search because, unless there are many keys, creating dictionary
      // costs more for preparation. I.e. key string allocation and  dictionary
      // construction.
      var iter = makeIterator()
      while let elem = iter.next() {
        if elem.key.equals(to: key) {
          return elem.value
        }
      }
      return nil
    }

    @inline(__always)
    func contains(key: String) -> Bool {
      return find(key) != nil
    }

    @inline(__always)
    subscript(_ key: String) -> JSONMapValue? {
      return find(key)
    }
  }

  @inline(__always)
  func asObject() -> JSONObject? {
    guard self.is(.object) else {
      return nil
    }
    return JSONObject(map: self)
  }
}

private struct JSONDecoding {
  var value: JSONMapValue
  var codingPathNode: _CodingPathNode
}

// MARK: Pure decoding functions.
extension JSONDecoding {
  @inline(__always)
  static func _checkNotNull<T>(
    _ value: JSONMapValue,
    expectedType: T.Type,
    for codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws {
    guard !value.isNull else {
      throw DecodingError.valueNotFound(
        expectedType,
        DecodingError.Context(
          codingPath: codingPathNode.path(byAppending: additionalKey),
          debugDescription: "Cannot get value of type \(expectedType) -- found null value instead"
        )
      )
    }
  }

  @inline(__always)
  static func _unwrapOrThrow<T>(
    _ result: T?,
    decoding value: JSONMapValue,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> T {
    if let result = result {
      return result
    }
    try _checkNotNull(value, expectedType: T.self, for: codingPathNode, additionalKey)
    throw DecodingError.typeMismatch(
      T.self,
      .init(
        codingPath: codingPathNode.path(byAppending: additionalKey),
        debugDescription: "type mismatch"
      )
    )
  }
  @inline(__always)
  static func _decode(
    _ value: JSONMapValue,
    as _: Bool.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> Bool {
    try _unwrapOrThrow(value.asBool(), decoding: value, codingPathNode: codingPathNode, additionalKey)
  }
  @inline(__always)
  static func _decode(
    _ value: JSONMapValue,
    as _: String.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> String {
    try _unwrapOrThrow(value.asString(), decoding: value, codingPathNode: codingPathNode, additionalKey)
  }
  @inline(__always)
  static func _decode<Integer: FixedWidthInteger>(
    _ value: JSONMapValue,
    as type: Integer.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> Integer {
    try _unwrapOrThrow(value.asInteger(type), decoding: value, codingPathNode: codingPathNode, additionalKey)
  }
  @inline(__always)
  static func _decode<Floating: BinaryFloatingPoint>(
    _ value: JSONMapValue,
    as type: Floating.Type,
    codingPathNode: _CodingPathNode,
    _ additionalKey: (some CodingKey)?
  ) throws -> Floating {
    try _unwrapOrThrow(value.asFloatingPoint(type), decoding: value, codingPathNode: codingPathNode, additionalKey)
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
    var mapping: JSONMapValue.JSONObject
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
    var iter = mapping.makeIterator()
    var keys: [Key] = []
    while let elem = iter.next() {
      if let key = Key(stringValue: elem.key.asString()!) {
        keys.append(key)
      }
    }
    return keys
  }

  func contains(_ key: Key) -> Bool {
    return mapping.contains(key: key.stringValue)
  }

  @inline(__always)
  func _getOrThrow(forKey key: Key) throws -> JSONMapValue {
    if let value = mapping[key.stringValue] {
      return value
    }
    throw DecodingError.keyNotFound(
      key,
      .init(
        codingPath: codingPathNode.path,
        debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."
      )
    )
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
    guard let mapping = value.asObject() else {
      throw DecodingError.typeMismatch(
        [String: Any].self,
        .init(
          codingPath: codingPathNode.path,
          debugDescription: "not an object"
        )
      )
    }
    self.codingPathNode = codingPathNode
    self.mapping = mapping
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
      return true
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
    guard let array = value.asArray() else {
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
    self.array = array
    self._currMapIdx = array.startIndex
  }
}
