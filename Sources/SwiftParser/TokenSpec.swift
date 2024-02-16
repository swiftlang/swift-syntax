//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) import SwiftSyntax

/// Pre-computes the keyword a lexeme might represent. This makes matching
/// a lexeme that has been converted into `PrepareForKeyword` match cheaper to
/// match against multiple ``TokenSpec`` that assume a keyword.
struct PrepareForKeywordMatch {
  /// The kind of the lexeme.
  fileprivate let rawTokenKind: RawTokenKind

  fileprivate let rawTokenText: SyntaxText

  /// If the lexeme has the same text as a keyword, that keyword, otherwise `nil`.
  fileprivate let keyword: Keyword?

  /// Whether to lexeme occurred at the start of a line.
  fileprivate let isAtStartOfLine: Bool

  @inline(__always)
  init(_ lexeme: Lexer.Lexeme) {
    self.rawTokenKind = lexeme.rawTokenKind
    self.rawTokenText = lexeme.tokenText
    switch lexeme.rawTokenKind {
    case .keyword, .identifier:
      keyword = Keyword(lexeme.tokenText)
    default:
      keyword = nil
    }
    self.isAtStartOfLine = lexeme.isAtStartOfLine
  }
}

/// Describes a token that should be consumed by the parser.
///
/// All the methods in here and all functions that take a ``TokenSpec`` need to be
/// marked `@inline(__always)` so the compiler inlines the ``RawTokenKind`` we are
/// matching against and is thus able to rule out one of the branches in
/// `matches(rawTokenKind:text:)` based on the matched kind.
@_spi(AlternateTokenIntrospection)
public struct TokenSpec {
  enum Matcher {
    /// A token with a specific text.
    case fixedText(SyntaxText)

    /// The keyword we are expecting.
    case keyword(Keyword)

    /// The kind we expect the token that we want to consume to have.
    /// This can be a keyword, in which case the ``TokenSpec`` will also match an
    /// identifier with the same text as the keyword and remap it to that keyword
    /// when consumed.
    ///
    /// `fileprivate` because only functions in this file should access it since
    /// they know how to handle the identifier -> keyword remapping.
    case tokenKind(RawTokenKind)
  }

  fileprivate let matcher: Matcher

  /// If not nil, the token will be remapped to the provided kind when consumed.
  ///
  /// `fileprivate` because only functions in this file should access it since
  /// they know how to handle the identifier -> keyword remapping.
  fileprivate let remapping: RawTokenKind?

  /// The recovery precedence that should be used when consuming this token. By
  /// default this is the token precedence of `rawTokenKind` but it can be
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
    precondition(rawTokenKind != .keyword, "To create a TokenSpec for a keyword use the initializer that takes a keyword")
    self.matcher = .tokenKind(rawTokenKind)
    self.remapping = remapping
    self.recoveryPrecedence = recoveryPrecedence ?? TokenPrecedence(nonKeyword: rawTokenKind)
    self.allowAtStartOfLine = allowAtStartOfLine
  }

  @inline(__always)
  init(
    _ keyword: Keyword,
    remapping: RawTokenKind? = nil,
    recoveryPrecedence: TokenPrecedence? = nil,
    allowAtStartOfLine: Bool = true
  ) {
    self.matcher = .keyword(keyword)
    self.remapping = remapping
    self.recoveryPrecedence = recoveryPrecedence ?? TokenPrecedence(keyword)
    self.allowAtStartOfLine = allowAtStartOfLine
  }

  @inline(__always)
  init(
    _ text: SyntaxText,
    remapping: RawTokenKind? = nil,
    recoveryPrecedence: TokenPrecedence? = nil,
    allowAtStartOfLine: Bool = true
  ) {
    self.matcher = .fixedText(text)
    self.remapping = remapping
    self.recoveryPrecedence = recoveryPrecedence ?? .identifierLike
    self.allowAtStartOfLine = allowAtStartOfLine
  }

  @inline(__always)
  func matches(
    rawTokenKind: RawTokenKind,
    rawTokenText: SyntaxText,
    keyword: @autoclosure () -> Keyword?,
    atStartOfLine: @autoclosure () -> Bool
  ) -> Bool {
    if !allowAtStartOfLine && atStartOfLine() {
      return false
    }
    switch matcher {
    case .fixedText(let expectedText):
      return rawTokenText == expectedText
    case .keyword(let expectedKeyword):
      return keyword() == expectedKeyword
    case .tokenKind(let expectedRawTokenKind):
      return rawTokenKind == expectedRawTokenKind
    }
  }

  @inline(__always)
  static func ~= (kind: TokenSpec, lexeme: Lexer.Lexeme) -> Bool {
    return kind.matches(
      rawTokenKind: lexeme.rawTokenKind,
      rawTokenText: lexeme.tokenText,
      keyword: Keyword(lexeme.tokenText),
      atStartOfLine: lexeme.isAtStartOfLine
    )
  }

  @inline(__always)
  static func ~= (kind: TokenSpec, token: TokenSyntax) -> Bool {
    return kind.matches(
      rawTokenKind: token.rawTokenKind,
      rawTokenText: token.rawText,
      keyword: Keyword(token.tokenView.rawText),
      atStartOfLine: token.leadingTrivia.contains(where: { $0.isNewline })
    )
  }

  @inline(__always)
  static func ~= (kind: TokenSpec, token: RawTokenSyntax) -> Bool {
    return kind.matches(
      rawTokenKind: token.tokenKind,
      rawTokenText: token.tokenText,
      keyword: Keyword(token.tokenView.rawText),
      atStartOfLine: token.leadingTriviaPieces.contains(where: \.isNewline)
    )
  }

  @inline(__always)
  static func ~= (kind: TokenSpec, lexeme: PrepareForKeywordMatch) -> Bool {
    return kind.matches(
      rawTokenKind: lexeme.rawTokenKind,
      rawTokenText: lexeme.rawTokenText,
      keyword: lexeme.keyword,
      atStartOfLine: lexeme.isAtStartOfLine
    )
  }

  /// Returns a ``TokenKind`` that will most likely be parsed as a token that
  /// matches this ``TokenSpec``.
  ///
  /// IMPORTANT: Should only be used when generating tokens during the
  /// modification of test cases. This should never be used in the parser itself.
  @_spi(AlternateTokenIntrospection)
  public var synthesizedTokenKind: TokenKind {
    switch matcher {
    case .fixedText(let text):
      return .identifier(String(syntaxText: text))
    case .keyword(let keyword):
      return .keyword(keyword)
    case .tokenKind(let kind):
      switch kind {
      case .binaryOperator: return .binaryOperator("+")
      case .dollarIdentifier: return .dollarIdentifier("$0")
      case .floatLiteral: return .floatLiteral("1.0")
      case .identifier: return .identifier("myIdent")
      case .integerLiteral: return .integerLiteral("1")
      case .postfixOperator: return .postfixOperator("++")
      case .prefixOperator: return .prefixOperator("!")
      case .rawStringPoundDelimiter: return .rawStringPoundDelimiter("#")
      case .regexLiteralPattern: return .regexLiteralPattern(".*")
      case .regexPoundDelimiter: return .regexPoundDelimiter("#")
      case .stringSegment: return .stringSegment("abc")
      default: return TokenKind.fromRaw(kind: kind, text: "")
      }
    }
  }

  static func keyword(_ keyword: Keyword) -> TokenSpec {
    return TokenSpec(keyword)
  }

  static func fixedText(_ text: SyntaxText) -> TokenSpec {
    return TokenSpec(text)
  }
}

extension TokenConsumer {
  /// Generates a missing token that has the expected kind of `spec`.
  @inline(__always)
  mutating func missingToken(_ spec: TokenSpec) -> Token {
    switch spec.matcher {
    case .fixedText(let text):
      return missingToken(spec.remapping ?? .identifier, text: text)
    case .keyword(let keyword):
      return missingToken(spec.remapping ?? .keyword, text: keyword.defaultText)
    case .tokenKind(let kind):
      return missingToken(spec.remapping ?? kind, text: kind.defaultText)
    }
  }

  /// Asserts that the current token matches `spec` and consumes it, performing
  /// any necessary token kind remapping.
  ///
  /// This should only be called from parsing primitives like `consume(if:)` and
  /// `eat`. Introduce new users of this very sparingly.
  @inline(__always)
  mutating func eat(_ spec: TokenSpec) -> Token {
    precondition(spec ~= self.currentToken)
    if let remapping = spec.remapping {
      return self.consumeAnyToken(remapping: remapping)
    }
    switch spec.matcher {
    case .keyword(_):
      return self.consumeAnyToken(remapping: .keyword)
    case .fixedText(_), .tokenKind(_):
      return self.consumeAnyToken()
    }
  }
}
