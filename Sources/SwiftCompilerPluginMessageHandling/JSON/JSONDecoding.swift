
import Darwin

struct JSONMap {
  enum Descriptor: Int {
    case nullKeyword   // [desc]
    case trueKeyword   // [desc]
    case falseKeyword  // [desc]
    case number        // [desc, pointer, length]
    case simpleString  // [desc, pointer, length]
    case string        // [desc, pointer, length]
    case object        // [desc, count, (key, value)...]
    case array         // [desc, count, element...]
  }
  let data: [Int]

  var value: JSONMapValue {
    JSONMapValue(map: data[...])
  }
}

struct JSONMapValue {
  typealias Map = Array<Int>.SubSequence
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
    return .init(map: map[i ..< index(afterValue: i)])
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
enum _JSONStringDecoder {
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
          case UInt8(ascii: "b"): string.append("\u{08}") // \b
          case UInt8(ascii: "f"): string.append("\u{0C}") // \f
          case UInt8(ascii: "n"): string.append("\u{0A}") // \n
          case UInt8(ascii: "r"): string.append("\u{0D}") // \r
          case UInt8(ascii: "t"): string.append("\u{09}") // \t
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

enum _JSONNumberDecoder {
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
      (value, overflowed) = isNegative
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
    var map: JSONMapValue

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
    var map: JSONMapValue
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
      currIndex = key.endIndex
      let val = map.value(at: currIndex)
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

struct JSONMapBuilder {
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
    mapData.append(0) // Count, this will be updated in closeCollection()
    return handle
  }

  mutating func closeCollection(handle: Int) {
    // 'handle': descriptor index.
    // 'handle+1': counter index.
    mapData[handle+1] = mapData.count - handle - 2
  }

  func finalize() -> JSONMap {
    JSONMap(data: mapData)
  }
}

struct JSONScanner {
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
      throw JSONError()
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
      throw JSONError(message: "expected \(char)")
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
    map.record(hasEscape ? .string : .simpleString, range: start ..< ptr)
  }

  mutating func scanNumber(start: Cursor) throws {
    ptr = start
    _ = advance(if: "-")
    while advance(if: "0" ... "9") {}
    if advance(if: ".") {
      while advance(if: "0" ... "9") {}
    }
    if advance(if: "e") || advance(if: "E") {
      _ = advance(if: "-") || advance(if: "+")
      while advance(if: "0" ... "9") {}
    }
    map.record(.number, range: start ..< ptr)
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
    case UInt8(ascii: "-"), UInt8(ascii: "0") ... UInt8(ascii: "9"):
      try scanNumber(start: start)
    case UInt8(ascii: "{"):
      try scanObject()
    case UInt8(ascii: "["):
      try scanArray()
    case let chr:
      throw JSONError(message: "invalid value start: \(chr)")
    }
    skipWhilespace()
  }

  static func scan(buffer: UnsafeBufferPointer<UInt8>) throws -> JSONMap {
    var scanner = JSONScanner(buffer: buffer)
    try scanner.scanValue()
    if scanner.hasData {
      throw JSONError()
    }

    return scanner.map.finalize()
  }
}

struct JSONDecoding {
  var value: JSONMapValue
  var codingPathNode: _CodingPathNode
}

extension JSONDecoding {
  @inline(__always)
  static func _unwrapOrThrow<T>(_ v: T?, codingPathNode: _CodingPathNode) throws -> T {
    guard let v = v else {
      throw JSONError(message: "type mismatch")
    }
    return v
  }
  @inline(__always)
  static func _decode(_ value: JSONMapValue, as _: Bool.Type, codingPathNode: _CodingPathNode) throws -> Bool {
    try _unwrapOrThrow(value.asBool, codingPathNode: codingPathNode)
  }
  @inline(__always)
  static func _decode(_ value: JSONMapValue, as _: String.Type, codingPathNode: _CodingPathNode) throws -> String {
    try _unwrapOrThrow(value.asString, codingPathNode: codingPathNode)
  }
  @inline(__always)
  static func _decode<Integer: FixedWidthInteger>(_ value: JSONMapValue, as type: Integer.Type, codingPathNode: _CodingPathNode) throws -> Integer {
    try _unwrapOrThrow(value.asInteger(type), codingPathNode: codingPathNode)
  }
  @inline(__always)
  static func _decode<Floating: BinaryFloatingPoint>(_ value: JSONMapValue, as type: Floating.Type, codingPathNode: _CodingPathNode) throws -> Floating {
    try _unwrapOrThrow(value.asFloatingPoint(type), codingPathNode: codingPathNode)
  }

  static func _decodeGeneric<T: Decodable>(_ value: JSONMapValue, as type: T.Type, codingPathNode: _CodingPathNode) throws -> T {
    let decoder = Self(value: value, codingPathNode: codingPathNode)
    return try T.init(from: decoder)
  }
}

extension JSONDecoding: Decoder {
  var codingPath: [any CodingKey] {
    codingPathNode.path
  }
  var userInfo: [CodingUserInfoKey : Any] { [:] }

  struct KeyedContainer<Key: CodingKey> {
    var codingPathNode: _CodingPathNode
    var mapping: [String: JSONMapValue]
  }

  struct UnkeyedContainer {
    var codingPathNode: _CodingPathNode
    var array: JSONMapValue.JSONArray
    var currentIndex: JSONMapValue.JSONArray.Index
    var currentNumber: Int
  }

  func container<Key: CodingKey>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
    return try KeyedDecodingContainer(KeyedContainer<Key>(
      value: value,
      codingPathNode: codingPathNode
    ))
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
  @inline(__always)
  func _unwrapOrThrow<T>(_ value: T?) throws -> T {
    guard let value = value else {
      throw JSONError()
    }
    return value
  }

  func decodeNil() -> Bool {
    value.isNull
  }

  func decode(_ type: Bool.Type) throws -> Bool {
    try _unwrapOrThrow(value.asBool)
  }

  func decode(_ type: String.Type) throws -> String {
    try _unwrapOrThrow(value.asString)
  }

  func decode(_ type: Double.Type) throws -> Double {
    try _unwrapOrThrow(value.asFloatingPoint(Double.self))
  }

  func decode(_ type: Float.Type) throws -> Float {
    try _unwrapOrThrow(value.asFloatingPoint(Float.self))
  }

  func decode(_ type: Int.Type) throws -> Int {
    try _unwrapOrThrow(value.asInteger(Int.self))
  }

  func decode(_ type: Int8.Type) throws -> Int8 {
    try _unwrapOrThrow(value.asInteger(Int8.self))
  }

  func decode(_ type: Int16.Type) throws -> Int16 {
    try _unwrapOrThrow(value.asInteger(Int16.self))
  }

  func decode(_ type: Int32.Type) throws -> Int32 {
    try _unwrapOrThrow(value.asInteger(Int32.self))
  }

  func decode(_ type: Int64.Type) throws -> Int64 {
    try _unwrapOrThrow(value.asInteger(Int64.self))
  }

  func decode(_ type: UInt.Type) throws -> UInt {
    try _unwrapOrThrow(value.asInteger(UInt.self))
  }

  func decode(_ type: UInt8.Type) throws -> UInt8 {
    try _unwrapOrThrow(value.asInteger(UInt8.self))
  }

  func decode(_ type: UInt16.Type) throws -> UInt16 {
    try _unwrapOrThrow(value.asInteger(UInt16.self))
  }

  func decode(_ type: UInt32.Type) throws -> UInt32 {
    try _unwrapOrThrow(value.asInteger(UInt32.self))
  }

  func decode(_ type: UInt64.Type) throws -> UInt64 {
    try _unwrapOrThrow(value.asInteger(UInt64.self))
  }

  func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
    return try T.init(from: self)
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
      throw JSONError(message: "missing key")
    }
    return value
  }

  func decodeNil(forKey key: Key) throws -> Bool {
    try _getOrThrow(forKey: key).isNull
  }

  func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: String.Type, forKey key: Key) throws -> String {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
    try JSONDecoding._decode(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func decode<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
    try JSONDecoding._decodeGeneric(_getOrThrow(forKey: key), as: type, codingPathNode: codingPathNode)
  }

  func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
    return try KeyedDecodingContainer(JSONDecoding.KeyedContainer<NestedKey>(
      value: try _getOrThrow(forKey: key),
      codingPathNode: codingPathNode.appending(key)
    ))
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
      throw JSONError(message: "not an object")
    }
    self.codingPathNode = codingPathNode
    self.mapping = [:]
    var iter = value.makeObjectIterator()!
    while let elem = iter.next() {
      guard let keyStr = elem.key.asString else {
        throw JSONError()
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
    currentIndex == array.endIndex
  }

  @inline(__always)
  mutating func _getOrThrow() throws -> (index: Int, value: JSONMapValue) {
    let idx = currentNumber
    guard !isAtEnd else {
      throw JSONError()
    }
    let value = array[currentIndex]
    currentIndex = array.index(after: currentIndex)
    currentNumber += 1
    return (idx, value)
  }

  @inline(__always)
  mutating func _decodeInteger<Integer: FixedWidthInteger>(_ type: Integer.Type) throws -> Integer {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode.appending(index: idx))
  }

  @inline(__always)
  mutating func _decodeFloating<Floating: BinaryFloatingPoint>(_ type: Floating.Type) throws -> Floating {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode.appending(index: idx))
  }

  mutating func decode(_ type: Bool.Type) throws -> Bool {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode.appending(index: idx))
  }

  mutating func decodeNil() throws -> Bool {
    try _getOrThrow().value.isNull
  }

  mutating func decode(_ type: String.Type) throws -> String {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decode(value, as: type, codingPathNode: codingPathNode.appending(index: idx))
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

  mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding._decodeGeneric(value, as: type, codingPathNode: codingPathNode.appending(index: idx))
  }

  mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
    let (idx, value) = try _getOrThrow()
    return try KeyedDecodingContainer(JSONDecoding.KeyedContainer<NestedKey>(
      value: value,
      codingPathNode: codingPathNode.appending(index: idx)
    ))
  }

  mutating func nestedUnkeyedContainer() throws -> any UnkeyedDecodingContainer {
    let (idx, value) = try _getOrThrow()
    return try JSONDecoding.UnkeyedContainer(
      value: value,
      codingPathNode: codingPathNode.appending(index: idx)
    )
  }

  mutating func superDecoder() throws -> any Decoder {
    fatalError("unimplemented")
  }

  init(value: JSONMapValue, codingPathNode: _CodingPathNode) throws {
    guard value.isArray else {
      throw JSONError(message: "not an array")
    }
    self.array = value.asArray()!
    self.currentIndex = self.array.startIndex
    self.currentNumber = 0
    self.codingPathNode = codingPathNode
  }
}
