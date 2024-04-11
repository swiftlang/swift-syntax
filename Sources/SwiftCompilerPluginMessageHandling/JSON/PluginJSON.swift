
public enum PluginMessageJSON {
  public static func encode<T: Encodable>(_ value: T) throws -> [UInt8] {
    let encoder = JSONEncoding()
    try value.encode(to: encoder)
    return JSONWriter.serialize(encoder.reference ?? .null)
  }

  /// Decode a JSON data to a Swift value.
  public static func decode<T: Decodable>(_ type: T.Type, from json: UnsafeBufferPointer<UInt8>) throws -> T {
    try withExtendedLifetime(try JSONScanner.scan(buffer: json)) { map in
      let decoder = JSONDecoding(value: map.value, codingPathNode: .root)
      return try T.init(from: decoder)
    }
  }
}
