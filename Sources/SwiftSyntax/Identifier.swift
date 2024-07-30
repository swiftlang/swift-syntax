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

/// A canonicalized representation of an identifier that strips away backticks.
public struct Identifier: Equatable, Hashable, Sendable {
  enum IdentifierKind: Hashable {
    case token(raw: RawIdentifier, arena: SyntaxArenaRef)
    case string(String)

    static func sanitize(string: String) -> IdentifierKind {
      let backtick = "`"
      if string.count > 2 && string.hasPrefix(backtick) && string.hasSuffix(backtick) {
        let startIndex = string.index(after: string.startIndex)
        let endIndex = string.index(before: string.endIndex)
        return .string(String(string[startIndex..<endIndex]))
      } else {
        return .string(string)
      }
    }
  }

  /// The sanitized name of the identifier.
  public var name: String {
    switch identifier {
    case .token(let raw, _):
      String(syntaxText: raw.name)
    case .string(let string):
      string
    }
  }

  @_spi(RawSyntax)
  public var raw: RawIdentifier? {
    switch identifier {
    case .token(let raw, _):
      raw
    default:
      nil
    }
  }

  let identifier: IdentifierKind

  public init?(_ token: TokenSyntax) {
    guard case .identifier = token.tokenKind else {
      return nil
    }

    self.identifier = .token(raw: RawIdentifier(token.tokenView), arena: token.tokenView.raw.arenaReference)
  }

  public init(_ string: String) {
    self.identifier = IdentifierKind.sanitize(string: string)
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.name == rhs.name
  }
}

@_spi(RawSyntax)
public struct RawIdentifier: Equatable, Hashable, Sendable {
  public let name: SyntaxText

  @_spi(RawSyntax)
  fileprivate init(_ raw: RawSyntaxTokenView) {
    let backtick = SyntaxText("`")
    if raw.rawText.count > 2 && raw.rawText.hasPrefix(backtick) && raw.rawText.hasSuffix(backtick) {
      let startIndex = raw.rawText.index(after: raw.rawText.startIndex)
      let endIndex = raw.rawText.index(before: raw.rawText.endIndex)
      self.name = SyntaxText(rebasing: raw.rawText[startIndex..<endIndex])
    } else {
      self.name = raw.rawText
    }
  }
}
