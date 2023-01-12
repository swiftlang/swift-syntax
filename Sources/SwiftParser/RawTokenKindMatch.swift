//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) import SwiftSyntax

/// Allows pattern matching of lexemes and tokens against `RawTokenKind` in a way
/// that considers keywords and identifiers the same if their contents match.
struct RawTokenKindMatch {
  var rawTokenKind: RawTokenKind

  init(_ rawTokenKind: RawTokenKind) {
    self.rawTokenKind = rawTokenKind
  }

  init(_ keyword: Keyword) {
    self.rawTokenKind = .keyword(keyword)
  }

  func matches(rawTokenKind: RawTokenKind, text: SyntaxText) -> Bool {
    if rawTokenKind == self.rawTokenKind {
      return true
    } else if rawTokenKind == .identifier, case .keyword = self.rawTokenKind {
      // We are looking for a contextual keyword but have an identifier.
      // If the contents match, we want to interpret the identifier as a keyword.
      let defaultText = self.rawTokenKind.defaultText
      assert(defaultText != nil)
      return text == defaultText
    } else {
      return false
    }
  }

  static func ~= (kind: RawTokenKindMatch, lexeme: Lexer.Lexeme) -> Bool {
    return kind.matches(rawTokenKind: lexeme.rawTokenKind, text: lexeme.tokenText)
  }

  static func ~= (kind: RawTokenKindMatch, token: TokenSyntax) -> Bool {
    return kind.matches(rawTokenKind: token.rawTokenKind, text: token.tokenView.rawText)
  }
}
