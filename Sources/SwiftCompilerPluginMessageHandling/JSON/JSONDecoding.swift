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

#if compiler(>=6)
@_implementationOnly private import _SwiftSyntaxCShims
#else
@_implementationOnly import _SwiftSyntaxCShims
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
 {"foo": [-1.3, true], "barz": 42}
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
   1: 17,        |  `- number of *map* elements this object occupies
   2: <SS>,      | --- key 1: 'foo'
   3: <int_ptr>, | |   |- pointer in the payload
   4: 3,         | |   `- length
   5: <AM>,      | --- value 1: array
   6: 6,         | |   `- number of *map* elements this array occupies
   7: <NM>,      | | -- arr elm 1: '-1.3'
   8: <int_ptr>, | | |
   9: 4,         | | |
  10: <TL>,      | | -- arr elm 2: 'true'
  11: <SS>,      | --- key 2: 'barz'
  12: <int_ptr>, | |
  13: 4,         | |
  14: <NM>       | --- value 2: '42'
  15: <int_ptr>, | |
  16: 2,         | |
 ]
 ```
 To decode '<root>.barz' value:
 1. Index 0 indicates it's a object.
 2. Parse a key string at index 2, which is "foo", not a match for "barz"
 3. Skip the key and the value by advancing the index by 'mapSize' of them, 3 and 6.
 4. Parse a key string at index 11, matching "barz"
 5. Parse a value number at the pointer of index 15, length at index 16
*/

private struct JSONMap {
  enum Descriptor: Int {

    // MARK: - Keywords; mapSize:1 [desc]
    //   desc: Descriptor.rawValue

    /// 'null'
    case nullKeyword
    /// 'true' size:1
    case trueKeyword
    /// 'false' size:1
    case falseKeyword

    // MARK: - Scalar values; mapSize:3 [desc, pointer, length]
    //   desc: Descriptor.rawValue
    //   pointer: pointer to the start of the value in the source UTF-8 JSON buffer.
    //   length: the length of the value in the source UTF-8 JSON buffer.

    /// Integer and floating number.
    case number
    /// ASCII non-escaped string.
    case asciiSimpleString
    /// Non escaped string.
    case simpleString
    /// String with escape sequences.
    case string

    // MARK: - Collections; mapSize: 2 + variable [desc, size, element...]
    //   desc: Descriptor.rawValue
    //   size: the map size this collection occupies.
    //   element * n: JSON values in this collection. For collections, sequence of key/value pairs.

    /// Object '{ ... }'. Elements are (key, value)...
    case object
    /// Array '[ ... ]'.
    case array
  }
  let data: [Int]

  /// Top-level value.
  func withValue<T>(_ body: (JSONMapValue) throws -> T) rethrows -> T {
    try data.withUnsafeBufferPointer { buf in
      try body(JSONMapValue(data: buf.baseAddress!))
    }
  }
}

private struct JSONMapBuilder {
  var mapData: [Int]

  init() {
    mapData = []
    mapData.reserveCapacity(128)  // 128 is good enough for most PluginMessage.
  }

  /// Record .nullKeyword, .trueKeyword, or .falseKeyword.
  @inline(__always)
  mutating func record(_ descriptor: JSONMap.Descriptor) {
    mapData.append(descriptor.rawValue)
  }

  /// Record literal values i.e. numbers and strings, with a range in the source buffer.
  @inline(__always)
  mutating func record(_ descriptor: JSONMap.Descriptor, range: Range<UnsafePointer<UInt8>>) {
    mapData.append(descriptor.rawValue)
    mapData.append(Int(bitPattern: range.lowerBound))
    mapData.append(range.count)
  }

  /// Record starting of a collection i.e. .array or .object. Must be paired with
  /// closeCollection(handle:) call using the returned handle.
  @inline(__always)
  mutating func startCollection(_ descriptor: JSONMap.Descriptor) -> Int {
    let handle = mapData.count
    mapData.append(descriptor.rawValue)
    mapData.append(0)  // Count, this will be updated in closeCollection()
    return handle
  }

  /// Close the collection. Accepts a "handle" returned from startCollection(_:).
  @inline(__always)
  mutating func closeCollection(handle: Int) {
    // 'handle': descriptor index.
    // 'handle+1': counter index.
    mapData[handle + 1] = mapData.count - handle
  }

  func finalize() -> JSONMap {
    JSONMap(data: mapData)
  }
}

private enum JSONError: Error, CustomStringConvertible {
  case unexpectedEndOfFile
  case unexpectedCharacter(UInt8, context: String)

  var description: String {
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
  mutating func skipWhitespace() {
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
  mutating func expect(ascii char: UnicodeScalar) throws {
    guard hasData else {
      throw JSONError.unexpectedEndOfFile
    }
    guard ptr.pointee == UInt8(ascii: char) else {
      throw JSONError.unexpectedCharacter(ptr.pointee, context: "expected '\(char)'")
    }
    ptr += 1
  }

  mutating func scanNull() throws {
    try expect(ascii: "u")
    try expect(ascii: "l")
    try expect(ascii: "l")
    map.record(.nullKeyword)
  }

  mutating func scanTrue() throws {
    try expect(ascii: "r")
    try expect(ascii: "u")
    try expect(ascii: "e")
    map.record(.trueKeyword)
  }

  mutating func scanFalse() throws {
    try expect(ascii: "a")
    try expect(ascii: "l")
    try expect(ascii: "s")
    try expect(ascii: "e")
    map.record(.falseKeyword)
  }

  mutating func scanString(start: Cursor) throws {
    ptr = start
    try expect(ascii: "\"")

    var hasEscape = false
    var hasNonASCII = false
    while hasData && ptr.pointee != UInt8(ascii: "\"") {
      // FIXME: Error for non-escaped control characters.
      // FIXME: Error for invalid UTF8 sequences.
      if ptr.pointee == UInt8(ascii: "\\") {
        hasEscape = true
        // eat '\'. Rest of the escape sequence are all ASCII. We just skip them
        // ignoring how many bytes are actually for the escape sequence. For
        // decoding, they are revisited in _JSONStingDecoder.decodeStringWithEscapes()
        _ = try advance()
      } else if ptr.pointee >= 0x80 {
        hasNonASCII = true
      }
      _ = try advance()
    }
    try expect(ascii: "\"")

    let kind: JSONMap.Descriptor
    if hasEscape {
      kind = .string
    } else if hasNonASCII {
      kind = .simpleString
    } else {
      kind = .asciiSimpleString
    }
    map.record(kind, range: (start + 1)..<(ptr - 1))
  }

  mutating func scanNumber(start: Cursor) throws {
    // FIXME: Error for invalid literal e.g. 'e-', '.e+'
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
    skipWhitespace()
    if !advance(if: "}") {
      while hasData {
        try scanString(start: ptr)
        skipWhitespace()
        try expect(ascii: ":")
        try scanValue()
        if advance(if: ",") {
          skipWhitespace()
          continue
        }
        break
      }
      try expect(ascii: "}")
    }
    map.closeCollection(handle: handle)
  }

  mutating func scanArray() throws {
    let handle = map.startCollection(.array)
    skipWhitespace()
    if !advance(if: "]") {
      while hasData {
        try scanValue()
        if advance(if: ",") {
          skipWhitespace()
          continue
        }
        break
      }
      try expect(ascii: "]")
    }
    map.closeCollection(handle: handle)
  }

  mutating func scanValue() throws {
    skipWhitespace()
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
    skipWhitespace()
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
    case .number, .asciiSimpleString, .simpleString, .string:
      return 3
    case .array, .object:
      return data[1]
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
  /// Decode a non-escaped string value from the buffer.
  @inline(__always)
  static func decodeSimpleString(source: UnsafeBufferPointer<UInt8>) -> String {
    if source.count <= 0 {
      return ""
    }
    return _makeString(unsafeUninitializedCapacity: source.count) { buffer in
      buffer.initialize(fromContentsOf: source)
    }
  }

  /// Decode a string value that includes escape sequences.
  static func decodeStringWithEscapes(source: UnsafeBufferPointer<UInt8>) -> String? {
    // JSON string with escape sequences must be== 0 2 bytes or longer.
    assert(!source.isEmpty)

    // Decode 'source' UTF-8 JSON string literal into the uninitialized
    // UTF-8 buffer. Upon error, return 0 and make an empty string.
    let decoded = _makeString(unsafeUninitializedCapacity: source.count) { buffer in

      var cursor = source.baseAddress!
      let end = cursor + source.count
      var mark = cursor

      var dest = buffer.baseAddress!

      @inline(__always) func flush() {
        let count = mark.distance(to: cursor)
        dest.initialize(from: mark, count: count)
        dest += count
      }

      while cursor != end {
        if cursor.pointee != UInt8(ascii: "\\") {
          cursor += 1
          continue
        }

        // Found an escape sequence. Flush the skipped source into the buffer.
        flush()

        let hadError = decodeEscapeSequence(cursor: &cursor, end: end) {
          dest.initialize(to: $0)
          dest += 1
        }
        guard !hadError else { return 0 }

        // Mark the position of the end of the escape sequence.
        mark = cursor
      }

      // Flush the remaining non-escaped characters.
      flush()

      return buffer.baseAddress!.distance(to: dest)
    }

    // If any error is detected, empty string is created.
    return decoded.isEmpty ? nil : decoded
  }

  /// Decode a JSON escape sequence, advance 'cursor' to end of the escape
  /// sequence, and call 'processCodeUnit' with the decoded value.
  /// Returns 'true' on error.
  ///
  ///  - Note: We don't report detailed errors for now because we only care
  ///          well-formed payloads from the compiler.
  private static func decodeEscapeSequence(
    cursor: inout UnsafePointer<UInt8>,
    end: UnsafePointer<UInt8>,
    into processCodeUnit: (UInt8) -> Void
  ) -> Bool {
    assert(cursor.pointee == UInt8(ascii: "\\"))
    guard cursor.distance(to: end) >= 2 else { return true }

    // Eat backslash and the next character.
    cursor += 2
    switch cursor[-1] {
    case UInt8(ascii: "\""): processCodeUnit(UInt8(ascii: "\""))
    case UInt8(ascii: "'"): processCodeUnit(UInt8(ascii: "'"))
    case UInt8(ascii: "\\"): processCodeUnit(UInt8(ascii: "\\"))
    case UInt8(ascii: "/"): processCodeUnit(UInt8(ascii: "/"))
    case UInt8(ascii: "b"): processCodeUnit(0x08)
    case UInt8(ascii: "f"): processCodeUnit(0x0C)
    case UInt8(ascii: "n"): processCodeUnit(0x0A)
    case UInt8(ascii: "r"): processCodeUnit(0x0D)
    case UInt8(ascii: "t"): processCodeUnit(0x09)
    case UInt8(ascii: "u"):
      guard cursor.distance(to: end) >= 4 else { return true }

      // Parse 4 hex digits into a UTF-16 code unit.
      let result: UInt16? = _JSONNumberParser.parseHexIntegerDigits(
        source: UnsafeBufferPointer(start: cursor, count: 4)
      )
      guard let result else { return true }

      // Transcode UTF-16 code unit to UTF-8.
      // FIXME: Support surrogate pairs.
      let hadError = transcode(
        CollectionOfOne(result).makeIterator(),
        from: UTF16.self,
        to: UTF8.self,
        stoppingOnError: true,
        into: processCodeUnit
      )
      guard !hadError else { return true }
      cursor += 4
    default:
      // invalid escape sequence.
      return true
    }
    return false
  }

  /// SwiftStdlib 5.3 compatibility shim for
  /// 'String.init(unsafeUninitializedCapacity:initializingUTF8With:)'
  private static func _makeString(
    unsafeUninitializedCapacity capacity: Int,
    initializingUTF8With initializer: (UnsafeMutableBufferPointer<UInt8>) throws -> Int
  ) rethrows -> String {
    if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
      return try String(unsafeUninitializedCapacity: capacity, initializingUTF8With: initializer)
    } else {
      let buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: capacity)
      let count = try initializer(buffer)
      return String(decoding: buffer[..<count], as: UTF8.self)
    }
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
    // Since source is not NUL terminated, we need to make a temporary storage.
    // Depending on the length of the source, prepare the buffer on stack or heap,
    // then call 'impl(_:)' (defined below) for the actual operation.
    if source.count + 1 <= MemoryLayout<UInt64>.size {
      var stash: UInt64 = 0
      return withUnsafeMutableBytes(of: &stash) {
        $0.withMemoryRebound(to: UInt8.self, impl)
      }
    } else {
      let stash = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: source.count + 1)
      defer { stash.deallocate() }
      return impl(stash)
    }

    func impl(_ stash: UnsafeMutableBufferPointer<UInt8>) -> Floating? {
      // Create a NUL terminated string in the stash.
      assert(stash.count >= source.count + 1)
      let end = stash.initialize(fromContentsOf: source)
      stash.initializeElement(at: end, to: 0)

      var endPtr: UnsafeMutablePointer<CChar>? = nil
      let value: Floating?
      if Floating.self == Double.self {
        value = Floating(exactly: strtod(stash.baseAddress!, &endPtr))
      } else if Floating.self == Float.self {
        value = Floating(exactly: strtof(stash.baseAddress!, &endPtr))
      } else {
        preconditionFailure("unsupported floating point type")
      }
      guard let endPtr, endPtr == stash.baseAddress! + source.count else {
        return nil
      }
      return value
    }
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
    if self.is(.asciiSimpleString) || self.is(.simpleString) {
      return _JSONStringParser.decodeSimpleString(source: valueBuffer())
    }
    if self.is(.string) {
      return _JSONStringParser.decodeStringWithEscapes(source: valueBuffer())
    }
    return nil
  }

  /// Returns true if this value represents a string and equals to 'str'.
  ///
  /// This is faster than 'value.asString() == str' because this doesn't
  /// instantiate 'Swift.String' unless there are escaped characters or
  /// non-ASCII characters.
  func equals(to str: String) -> Bool {
    if self.is(.asciiSimpleString) {
      let lhs = valueBuffer()
      var str = str
      return str.withUTF8 { rhs in
        if lhs.count != rhs.count {
          return false
        }
        guard let lBase = lhs.baseAddress, let rBase = rhs.baseAddress else {
          // If either `baseAddress` is `nil`, both are empty so returns `true`.
          return true
        }
        return memcmp(lBase, rBase, lhs.count) == 0
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
  private static func _checkNotNull<T>(
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
    if let value = mapping.find(key.stringValue) {
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
  mutating func _getOrThrow() throws -> (index: _CodingKey, value: JSONMapValue) {
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

// Compatibility shim for SE-0370
#if swift(<5.8)
extension UnsafeMutableBufferPointer {
  fileprivate func initialize(
    fromContentsOf source: some Collection<Element>
  ) -> Index {
    let count = source.withContiguousStorageIfAvailable {
      guard let sourceAddress = $0.baseAddress, !$0.isEmpty else {
        return 0
      }
      precondition(
        $0.count <= self.count,
        "buffer cannot contain every element from source."
      )
      baseAddress?.initialize(from: sourceAddress, count: $0.count)
      return $0.count
    }
    if let count {
      return startIndex.advanced(by: count)
    }

    var (iterator, copied) = self.initialize(from: source)
    precondition(
      iterator.next() == nil,
      "buffer cannot contain every element from source."
    )
    return startIndex.advanced(by: copied)
  }

  fileprivate func initializeElement(at index: Index, to value: Element) {
    precondition(startIndex <= index && index < endIndex)
    let p = baseAddress!.advanced(by: index)
    p.initialize(to: value)
  }
}
#endif
