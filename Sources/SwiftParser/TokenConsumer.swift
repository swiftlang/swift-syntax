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

/// A type that consumes  instances of ``TokenSyntax``.
protocol TokenConsumer {
  associatedtype Token
  /// The current token syntax being examined by the consumer
  var currentToken: Lexer.Lexeme { get }

  var swiftVersion: Parser.SwiftVersion { get }

  /// The experimental features that have been enabled.
  var experimentalFeatures: Parser.ExperimentalFeatures { get }

  /// Whether the current token matches the given kind.
  mutating func consumeAnyToken() -> Token

  /// Consume the current token and change its token kind to `remappedTokenKind`.
  mutating func consumeAnyToken(remapping remappedTokenKind: RawTokenKind) -> Token

  /// Consumes a given token, or splits the current token into a leading token
  /// matching the given token and a trailing token and consumes the leading
  /// token.
  ///
  ///     <TOKEN> ... -> consumePrefix(<TOK>) -> [ <TOK> ] <EN> ...
  mutating func consumePrefix(_ prefix: SyntaxText, as tokenKind: RawTokenKind) -> Token

  /// Synthesize a missing token with `kind`.
  /// If `text` is not `nil`, use it for the token's text, otherwise use the token's default text.
  mutating func missingToken(_ kind: RawTokenKind, text: SyntaxText?) -> Token

  /// Return the lexeme that will be parsed next.
  func peek() -> Lexer.Lexeme

  func lookahead() -> Parser.Lookahead

  #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
  var shouldRecordAlternativeTokenChoices: Bool { get }

  /// When compiled with `SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION`,
  /// record alternative tokens that the parser was looking for at the offset of
  /// `lexeme`.
  ///
  /// E.g. if at offset 33, we issue an `at(.leftParen)` call, this will record
  /// that `.leftParen` is an interesting token at offset 33. This allows the
  /// test case mutators to prefer replacing the current token at offset 33 by a
  /// left paren, because apparently this would be a code path that the parser
  /// is interested in.
  mutating func recordAlternativeTokenChoice(for lexeme: Lexer.Lexeme, choices: [TokenSpec])
  #endif
}

// MARK: Checking if we are at one specific token (`at`)

/// After calling `consume(ifAnyFrom:)` we know which token we are positioned
/// at based on that function's return type. This handle allows consuming that
/// token.
struct TokenConsumptionHandle {
  /// The kind that is expected to be consumed if the handle is eaten.
  var spec: TokenSpec
  /// If `true`, the token we should consume should be synthesized as a missing token
  /// and no tokens should be consumed.
  var tokenIsMissing: Bool = false
}

extension TokenConsumer {
  /// Returns whether the current token matches `spec`
  @inline(__always)
  mutating func at(_ spec: TokenSpec) -> Bool {
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.currentToken, choices: [spec])
    }
    #endif
    return spec ~= self.currentToken
  }

  /// Returns whether the current token matches one of the two specs.
  @inline(__always)
  mutating func at(
    _ spec1: TokenSpec,
    _ spec2: TokenSpec
  ) -> Bool {
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.currentToken, choices: [spec1, spec2])
    }
    #endif
    switch self.currentToken {
    case spec1: return true
    case spec2: return true
    default: return false
    }
  }

  /// Returns whether the current token matches one of the three specs.
  @inline(__always)
  mutating func at(
    _ spec1: TokenSpec,
    _ spec2: TokenSpec,
    _ spec3: TokenSpec
  ) -> Bool {
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.currentToken, choices: [spec1, spec2, spec3])
    }
    #endif
    switch self.currentToken {
    case spec1: return true
    case spec2: return true
    case spec3: return true
    default: return false
    }
  }

  /// Returns whether the current token is an operator with the given `name`.
  @inline(__always)
  mutating func atContextualPunctuator(_ name: SyntaxText) -> Bool {
    return self.currentToken.isContextualPunctuator(name)
  }

  /// Checks whether the parser is currently positioned at any token in `Subset`.
  /// If this is the case, return the `Subset` case that the parser is positioned in
  /// as well as a handle to consume that token.
  @inline(__always)
  mutating func at<SpecSet: TokenSpecSet>(anyIn specSet: SpecSet.Type) -> (spec: SpecSet, handle: TokenConsumptionHandle)? {
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.currentToken, choices: specSet.allCases.map(\.spec))
    }
    #endif
    if let matchedKind = SpecSet(lexeme: self.currentToken, experimentalFeatures: self.experimentalFeatures) {
      precondition(matchedKind.spec ~= self.currentToken)
      return (
        matchedKind,
        TokenConsumptionHandle(spec: matchedKind.spec)
      )
    }
    return nil
  }

  /// Checks whether the parser's next token is any token in `SpecSet`.
  /// If this is the case, return the corresponding `SpecSet` case.
  @inline(__always)
  func peek<SpecSet: TokenSpecSet>(isAtAnyIn specSet: SpecSet.Type) -> SpecSet? {
    guard let matchedKind = SpecSet(lexeme: self.peek(), experimentalFeatures: self.experimentalFeatures) else {
      return nil
    }
    precondition(matchedKind.spec ~= self.peek())
    return matchedKind
  }

  /// Whether the current token’s text starts with the given prefix.
  @inline(__always)
  mutating func at(prefix: SyntaxText) -> Bool {
    return self.currentToken.tokenText.hasPrefix(prefix)
  }

  /// Whether the current token is at the start of a line.
  @inline(__always)
  var atStartOfLine: Bool {
    return self.currentToken.isAtStartOfLine
  }

  /// Eat a token that we know we are currently positioned at, based on `at(anyIn:)`.
  @inline(__always)
  mutating func eat(_ handle: TokenConsumptionHandle) -> Token {
    if handle.tokenIsMissing {
      return missingToken(handle.spec)
    } else {
      return eat(handle.spec)
    }
  }

  func withLookahead<T>(_ body: (_: inout Parser.Lookahead) -> T) -> T {
    var lookahead = lookahead()
    return body(&lookahead)
  }
}

extension TokenConsumer {
  /// Returns whether the next (peeked) token matches `spec`
  @inline(__always)
  mutating func peek(isAt spec: TokenSpec) -> Bool {
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.peek(), choices: [spec])
    }
    #endif
    return spec ~= self.peek()
  }

  /// Returns whether the next (peeked) token matches one of the two specs.
  @inline(__always)
  mutating func peek(
    isAt spec1: TokenSpec,
    _ spec2: TokenSpec
  ) -> Bool {
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.peek(), choices: [spec1, spec2])
    }
    #endif
    switch self.peek() {
    case spec1: return true
    case spec2: return true
    default: return false
    }
  }

  /// Returns whether the next (peeked) token matches one of the three specs.
  @inline(__always)
  mutating func peek(
    isAt spec1: TokenSpec,
    _ spec2: TokenSpec,
    _ spec3: TokenSpec
  ) -> Bool {
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if shouldRecordAlternativeTokenChoices {
      recordAlternativeTokenChoice(for: self.peek(), choices: [spec1, spec2, spec3])
    }
    #endif
    switch self.peek() {
    case spec1: return true
    case spec2: return true
    case spec3: return true
    default: return false
    }
  }
}

// MARK: Consuming tokens (`consume`)

extension TokenConsumer {
  /// If the current token matches `spec`, consume the token and return it.
  /// Otherwise return `nil`.
  @inline(__always)
  mutating func consume(if spec: TokenSpec) -> Token? {
    if self.at(spec) {
      return self.eat(spec)
    }
    return nil
  }

  /// If the current token matches one of the specs, consume the token and return it.
  /// Otherwise return `nil`.
  @inline(__always)
  mutating func consume(
    if spec1: TokenSpec,
    _ spec2: TokenSpec
  ) -> Token? {
    if let token = consume(if: spec1) {
      return token
    } else if let token = consume(if: spec2) {
      return token
    } else {
      return nil
    }
  }

  /// If the current token matches one of the specs, consume the token and return it.
  /// Otherwise return `nil`.
  @inline(__always)
  mutating func consume(
    if spec1: TokenSpec,
    _ spec2: TokenSpec,
    _ spec3: TokenSpec
  ) -> Token? {
    if let token = consume(if: spec1) {
      return token
    } else if let token = consume(if: spec2) {
      return token
    } else if let token = consume(if: spec3) {
      return token
    } else {
      return nil
    }
  }

  /// Consumes and returns the current token is an operator with the given `name`.
  @inline(__always)
  mutating func consumeIfContextualPunctuator(_ name: SyntaxText, remapping: RawTokenKind? = nil) -> Token? {
    if self.atContextualPunctuator(name) {
      if let remapping = remapping {
        return self.consumeAnyToken(remapping: remapping)
      } else {
        return self.consumeAnyToken()
      }
    }
    return nil
  }

  /// If the current token matches `spec1` and is followed by a token that
  /// matches `spec2` consume both tokens and return them. Otherwise, return `nil`.
  @inline(__always)
  mutating func consume(if spec1: TokenSpec, followedBy spec2: TokenSpec) -> (Token, Token)? {
    if self.at(spec1) && spec2 ~= self.peek() {
      return (consumeAnyToken(), consumeAnyToken())
    } else {
      return nil
    }
  }

  /// If the current token satisfies `condition1` and the next token satisfies
  /// `condition2` consume both tokens and return them.
  /// Otherwise, return `nil`.
  @inline(__always)
  mutating func consume(
    if condition1: (Lexer.Lexeme) -> Bool,
    followedBy condition2: (Lexer.Lexeme) -> Bool
  ) -> (Token, Token)? {
    if condition1(self.currentToken) && condition2(self.peek()) {
      return (consumeAnyToken(), consumeAnyToken())
    } else {
      return nil
    }
  }

  @inline(__always)
  mutating func consume<SpecSet: TokenSpecSet>(ifAnyIn specSet: SpecSet.Type) -> Self.Token? {
    if let (_, handle) = self.at(anyIn: specSet) {
      return self.eat(handle)
    } else {
      return nil
    }
  }

  /// If the current token starts with the given prefix, consume the prefis as the given token kind.
  ///
  /// Otherwise, return `nil`.
  mutating func consume(ifPrefix prefix: SyntaxText, as tokenKind: RawTokenKind) -> Token? {
    if self.at(prefix: prefix) {
      return consumePrefix(prefix, as: tokenKind)
    } else {
      return nil
    }
  }
}

// MARK: Convenience functions

extension TokenConsumer {
  var canHaveParameterSpecifier: Bool {
    // The parameter specifiers like `isolated`, `consuming`, `borrowing` are
    // also valid identifiers and could be the name of a type. Check whether
    // the following token is something that can introduce a type (which,
    // thankfully, doesn't overlap with the set of tokens that can continue
    // a type production), in which case the current token is interpretable
    // as a parameter specifier.
    let lexeme = peek()

    switch lexeme.rawTokenKind {
    case .atSign, .leftParen, .identifier, .leftSquare, .wildcard:
      return true

    case .keyword:
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.inout), TokenSpec(.Any), TokenSpec(.Self), TokenSpec(.var), TokenSpec(.let):
        return true
      default:
        return false
      }

    default:
      return false
    }
  }

  /// Whether the current token can be a function argument label.
  func atArgumentLabel(allowDollarIdentifier: Bool = false) -> Bool {
    return self.currentToken.isArgumentLabel(allowDollarIdentifier: allowDollarIdentifier)
  }
}
