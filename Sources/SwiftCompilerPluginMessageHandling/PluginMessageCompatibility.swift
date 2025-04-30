//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// Old compiler might send '.declaration' as "freeStandingDeclaration".
extension PluginMessage.MacroRole {
  @_spi(PluginMessage) public init(from decoder: Decoder) throws {
    let stringValue = try decoder.singleValueContainer().decode(String.self)
    if let role = Self(rawValue: stringValue) {
      self = role
      return
    }
    // Accept "freeStandingDeclaration" as '.declaration'.
    if stringValue == "freeStandingDeclaration" {
      self = Self.declaration
      return
    }
    throw DecodingError.dataCorrupted(
      DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Invalid string value for MacroRole: \(stringValue)"
      )
    )
  }
}
