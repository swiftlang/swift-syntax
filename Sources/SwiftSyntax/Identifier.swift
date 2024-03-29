//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// An abstraction for sanitized values on a token.
public struct Identifier: Equatable, Hashable, Sendable {
  /// The sanitized `text` of a token.
  public let name: String

  public init?(_ token: TokenSyntax) {
    guard case .identifier(let text) = token.tokenKind else {
      return nil
    }

    self.name =
      if text.contains("`") {
        String(text.trimmingCharacters(in: "`"))
      } else {
        text
      }
  }
}
