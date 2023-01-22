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
///
/// All the methods in here need to be marked `@inline(__always)` so the compiler
/// inlines the RawTokenKind we are matching against and is thus able to rule
/// out one of the branches in `matches(rawTokenKind:text:)` based on the
/// matched kind.
struct RawTokenKindMatch {
  private var rawTokenKind: RawTokenKind

  @inline(__always)
  init(_ rawTokenKind: RawTokenKind) {
    self.rawTokenKind = rawTokenKind
  }

  @inline(__always)
  init(_ keyword: Keyword) {
    self.rawTokenKind = .keyword(keyword)
  }

  @inline(__always)
  func matches(rawTokenKind: RawTokenKind, text: SyntaxText) -> Bool {
    if self.rawTokenKind.base == .keyword {
      return rawTokenKind == self.rawTokenKind || (rawTokenKind == .identifier && self.rawTokenKind.keyword.defaultText == text)
    } else {
      return rawTokenKind == self.rawTokenKind
    }
  }

  @inline(__always)
  static func ~= (kind: RawTokenKindMatch, lexeme: Lexer.Lexeme) -> Bool {
    return kind.matches(rawTokenKind: lexeme.rawTokenKind, text: lexeme.tokenText)
  }

  @inline(__always)
  static func ~= (kind: RawTokenKindMatch, token: TokenSyntax) -> Bool {
    return kind.matches(rawTokenKind: token.rawTokenKind, text: token.tokenView.rawText)
  }
}
