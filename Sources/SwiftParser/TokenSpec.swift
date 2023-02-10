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

/// Describes a token that should be consumed by the parser.
///
/// All the methods in here and all functions that take a `TokenSpec` need to be
/// marked `@inline(__always)` so the compiler inlines the `RawTokenKind` we are
/// matching against and is thus able to rule out one of the branches in
/// `matches(rawTokenKind:text:)` based on the matched kind.
struct TokenSpec {
  /// The kind we expect the token that we want to consume to have.
  /// This can be a keyword, in which case the `TokenSpec` will also match an
  /// identifier with the same text as the keyword and remap it to that keyword
  /// when consumed.
  ///
  /// `fileprivate` because only functions in this file should access it since
  /// they know how to handle the identifier -> keyword remapping.
  fileprivate let rawTokenKind: RawTokenKind

  /// If not nil, the token will be remapped to the provided kind when consumed.
  ///
  /// `fileprivate` because only functions in this file should access it since
  /// they know how to handle the identifier -> keyword remapping.
  fileprivate let remapping: RawTokenKind?

  /// The recovery precedence that should be used when consuming this token. By
  /// default this is the token precendece of `rawTokenKind` but it can be
  /// overridden.
  let recoveryPrecedence: TokenPrecedence

  /// Whether the token is allowed to be at the start of a line. Defaults to
  /// `true` but can be set to `false` to consume a token for recovery purposes
  /// that is not allowed to start a new line.
  let allowAtStartOfLine: Bool

  @inline(__always)
  init(
    _ rawTokenKind: RawTokenKind,
    remapping: RawTokenKind? = nil,
    recoveryPrecedence: TokenPrecedence? = nil,
    allowAtStartOfLine: Bool = true
  ) {
    self.rawTokenKind = rawTokenKind
    self.remapping = remapping
    self.recoveryPrecedence = recoveryPrecedence ?? TokenPrecedence(rawTokenKind)
    self.allowAtStartOfLine = allowAtStartOfLine
  }

  @inline(__always)
  init(
    _ keyword: Keyword,
    remapping: RawTokenKind? = nil,
    recoveryPrecedence: TokenPrecedence? = nil,
    allowAtStartOfLine: Bool = true
  ) {
    self.rawTokenKind = .keyword(keyword)
    self.remapping = remapping
    self.recoveryPrecedence = recoveryPrecedence ?? TokenPrecedence(rawTokenKind)
    self.allowAtStartOfLine = allowAtStartOfLine
  }

  @inline(__always)
  func matches(rawTokenKind: RawTokenKind, text: SyntaxText, atStartOfLine: @autoclosure () -> Bool) -> Bool {
    if !allowAtStartOfLine && atStartOfLine() {
      return false
    }
    if self.rawTokenKind.base == .keyword {
      return rawTokenKind == self.rawTokenKind || (rawTokenKind == .identifier && self.rawTokenKind.keyword.defaultText == text)
    } else {
      return rawTokenKind == self.rawTokenKind
    }
  }

  @inline(__always)
  static func ~= (kind: TokenSpec, lexeme: Lexer.Lexeme) -> Bool {
    return kind.matches(
      rawTokenKind: lexeme.rawTokenKind,
      text: lexeme.tokenText,
      atStartOfLine: lexeme.isAtStartOfLine
    )
  }

  @inline(__always)
  static func ~= (kind: TokenSpec, token: TokenSyntax) -> Bool {
    return kind.matches(
      rawTokenKind: token.rawTokenKind,
      text: token.tokenView.rawText,
      atStartOfLine: token.leadingTrivia.contains(where: { $0.isNewline })
    )
  }

  @inline(__always)
  static func ~= (kind: TokenSpec, token: RawTokenSyntax) -> Bool {
    return kind.matches(
      rawTokenKind: token.tokenKind,
      text: token.tokenView.rawText,
      atStartOfLine: token.leadingTriviaPieces.contains(where: \.isNewline)
    )
  }
}

extension TokenConsumer {
  /// Generates a missing token that has the expected kind of `spec`.
  @inline(__always)
  mutating func missingToken(_ spec: TokenSpec) -> Token {
    return missingToken(spec.remapping ?? spec.rawTokenKind, text: spec.rawTokenKind.defaultText)
  }

  /// Asserts that the current token matches `spec` and consumes it, performing
  /// any necessary token kind remappings.
  ///
  /// This should only be called from parsing primitives like `consume(if:)` and
  /// `eat`. Introduce new users of this very sparingly.
  @inline(__always)
  mutating func eat(_ spec: TokenSpec) -> Token {
    assert(spec ~= self.currentToken)
    if let remapping = spec.remapping {
      return self.consumeAnyToken(remapping: remapping)
    } else if spec.rawTokenKind.base == .keyword {
      return self.consumeAnyToken(remapping: spec.rawTokenKind)
    } else {
      return self.consumeAnyToken()
    }
  }
}
