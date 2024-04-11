
/// Intermediate representation for serializing JSON structure.
class JSONReference {
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
    backing = .null
    dict[key] = value
    backing = .object(dict)
  }

  func append(_ value: JSONReference) {
    guard case .array(var arr) = backing else {
      preconditionFailure()
    }
    backing = .null
    arr.append(value)
    backing = .array(arr)
  }

  static let null: JSONReference = .init(backing: .null)
  static let `true`: JSONReference = .init(backing: .trueKeyword)
  static let `false`: JSONReference = .init(backing: .falseKeyword)

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
  static func number(_ integer: some BinaryInteger & CustomStringConvertible) -> JSONReference {
    .init(backing: .number(integer.description))
  }
  @inline(__always)
  static func number(_ floating: some BinaryFloatingPoint & CustomStringConvertible) -> JSONReference {
    .init(backing: .number(floating.description))
  }
}

struct JSONWriter {
  var data: [UInt8]
  init() {
    data = []
  }

  mutating func write(ascii: UInt8) {
    data.append(ascii)
  }
  mutating func write(scalar: UnicodeScalar) {
    data.append(UInt8(ascii: scalar))
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
    write(scalar: "\"")
    string.withUTF8 { utf8 in
      var cursor = utf8.baseAddress!
      let end = utf8.baseAddress! + utf8.count
      var mark = cursor
      func flush() {
        if cursor > mark {
          write(utf8: UnsafeBufferPointer(start: mark, count: cursor - mark))
        }
        cursor += 1
        mark = cursor
      }
      while cursor != end {
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
        case 0x0 ... 0xF:
          flush()
          write(string: "\\u000")
          write(ascii: UInt8(ascii: "0") &+ cursor.pointee)
        case 0x10 ... 0x1F:
          flush()
          write(string: "\\u001")
          write(ascii: UInt8(ascii: "0") &+ (cursor.pointee & 0xF))
        default:
          // Accumulate this byte.
          cursor += 1
          continue
        }
      }

      // Append accumulated bytes.
      if cursor > mark {
        write(utf8: UnsafeBufferPointer(start: mark, count: cursor - mark))
      }
    }
    write(scalar: "\"")
  }

  mutating func serialize(array: [JSONReference]) {
    write(scalar: "[")
    var first = true
    for elem in array {
      if first {
        first = false
      } else {
        write(scalar: ",")
      }
      serialize(value: elem)
    }
    write(scalar: "]")
  }

  mutating func serialize(object: [String: JSONReference]) {
    write(scalar: "{")
    var first = true
    for key in object.keys.sorted() {
      if first {
        first = false
      } else {
        write(scalar: ",")
      }
      serialize(string: key)
      write(scalar: ":")
      serialize(value: object[key]!)
    }
    write(scalar: "}")
  }

  static func serialize(_ value: JSONReference) -> [UInt8] {
    var writer = JSONWriter()
    writer.serialize(value: value)
    return writer.data
  }
}

class JSONEncoding {
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
    value ? .true : .false
  }
  func _encode(_ value: some BinaryFloatingPoint & CustomStringConvertible) -> JSONReference {
    .number(value)
  }
  func _encode(_ value: some BinaryInteger & CustomStringConvertible) -> JSONReference {
    .number(value)
  }
  func _encode(_ value: String) -> JSONReference {
    .string(value)
  }
  func _encodeGeneric(_ value: some Encodable, codingPathNode: _CodingPathNode) throws -> JSONReference {
    // Temporarily reset the state and perform the encoding.
    let old = (self.reference, self.codingPathNode)
    defer { (self.reference, self.codingPathNode) = old }

    self.reference = nil
    self.codingPathNode = codingPathNode

    try value.encode(to: self)
    guard let result = self.reference else {
      throw JSONError()
    }
    return result
  }
}

// MARK: Encoder conformance.
extension JSONEncoding: Encoder {
  var codingPath: [any CodingKey] {
    codingPathNode.path
  }
  var userInfo: [CodingUserInfoKey : Any] { [:] }

  struct KeyedContainer<Key: CodingKey> {
    var encoder: JSONEncoding
    var reference: JSONReference
    var codingPathNode: _CodingPathNode
  }

  struct UnkeyedContainer {
    var encoder: JSONEncoding
    var reference: JSONReference
    var codingPathNode: _CodingPathNode
  }

  func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
    reference = .newObject()
    return KeyedEncodingContainer(KeyedContainer<Key>(
      encoder: self,
      reference: reference!,
      codingPathNode: codingPathNode
    ))
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

  func encode<T>(_ value: T) throws where T : Encodable {
    try value.encode(to: self)
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
    _set(key: key, value: try encoder._encodeGeneric(value, codingPathNode: codingPathNode))
  }

  mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
    let ref: JSONReference = .newObject()
    _set(key: key, value: ref)
    return KeyedEncodingContainer(JSONEncoding.KeyedContainer<NestedKey>(
      encoder: encoder,
      reference: ref,
      codingPathNode: codingPathNode.appending(key)
    ))
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

  func encode<T>(_ value: T) throws where T : Encodable {
    reference.append(try encoder._encodeGeneric(value, codingPathNode: codingPathNode))
  }

  func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
    let ref: JSONReference = .newObject()
    let idx = count
    reference.append(ref)
    return KeyedEncodingContainer(JSONEncoding.KeyedContainer<NestedKey>(
      encoder: encoder,
      reference: ref,
      codingPathNode: codingPathNode.appending(index: idx)
    ))
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
