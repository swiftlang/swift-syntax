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

@_spi(PluginMessage)
public enum JSON {
  /// Encode Swift value to an UInt8 array.
  public static func encode<T: Encodable>(_ value: T) throws -> [UInt8] {
    try encodeToJSON(value: value)
  }

  /// Decode a JSON data to a Swift value.
  public static func decode<T: Decodable>(_ type: T.Type, from json: UnsafeBufferPointer<UInt8>) throws -> T {
    try decodeFromJSON(json: json)
  }
}
