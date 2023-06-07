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

// MARK: - TokenSpecSet

@_spi(Diagnostics)
public enum AsyncEffectSpecifier: TokenSpecSet {
  case async
  case await
  case reasync

  init?(lexeme: Lexer.Lexeme) {
    // We'll take 'await' too for recovery but they have to be on the same line
    // as the declaration they're modifying.
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.async): self = .async
    case TokenSpec(.await, allowAtStartOfLine: false): self = .await
    case TokenSpec(.reasync): self = .reasync
    default: return nil
    }
  }

  @_spi(Diagnostics)
  public init?(token: TokenSyntax) {
    switch token.tokenKind {
    case .keyword(.async): self = .async
    case .keyword(.await): self = .await
    case .keyword(.reasync): self = .reasync
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .async: return .keyword(.async)
    case .await: return TokenSpec(.await, allowAtStartOfLine: false)
    case .reasync: return .keyword(.reasync)
    }
  }
}

@_spi(Diagnostics)
public enum ThrowsEffectSpecifier: TokenSpecSet {
  case `rethrows`
  case `throw`
  case `throws`
  case `try`

  init?(lexeme: Lexer.Lexeme) {
    // We'll take 'throw' and 'try' too for recovery but they have to
    // be on the same line as the declaration they're modifying.
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.rethrows): self = .rethrows
    case TokenSpec(.throw, allowAtStartOfLine: false): self = .throw
    case TokenSpec(.throws): self = .throws
    case TokenSpec(.try, allowAtStartOfLine: false): self = .try
    default: return nil
    }
  }

  @_spi(Diagnostics)
  public init?(token: TokenSyntax) {
    switch token.tokenKind {
    case .keyword(.rethrows): self = .rethrows
    case .keyword(.throw): self = .throw
    case .keyword(.throws): self = .throws
    case .keyword(.try): self = .try
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .rethrows: return .keyword(.rethrows)
    case .throw: return TokenSpec(.throw, allowAtStartOfLine: false)
    case .throws: return .keyword(.throws)
    case .try: return TokenSpec(.try, allowAtStartOfLine: false)
    }
  }
}

@_spi(Diagnostics)
public enum EffectSpecifier: TokenSpecSet {
  case asyncSpecifier(AsyncEffectSpecifier)
  case throwsSpecifier(ThrowsEffectSpecifier)

  init?(lexeme: Lexer.Lexeme) {
    if let subset = AsyncEffectSpecifier(lexeme: lexeme) {
      self = .asyncSpecifier(subset)
    } else if let subset = ThrowsEffectSpecifier(lexeme: lexeme) {
      self = .throwsSpecifier(subset)
    } else {
      return nil
    }
  }

  @_spi(Diagnostics)
  public init?(token: TokenSyntax) {
    if let subset = AsyncEffectSpecifier(token: token) {
      self = .asyncSpecifier(subset)
    } else if let subset = ThrowsEffectSpecifier(token: token) {
      self = .throwsSpecifier(subset)
    } else {
      return nil
    }
  }

  @_spi(Diagnostics)
  public static var allCases: [EffectSpecifier] {
    return AsyncEffectSpecifier.allCases.map(Self.asyncSpecifier)
      + ThrowsEffectSpecifier.allCases.map(Self.throwsSpecifier)
  }

  var spec: TokenSpec {
    switch self {
    case .asyncSpecifier(let underlyingKind): return underlyingKind.spec
    case .throwsSpecifier(let underlyingKind): return underlyingKind.spec
    }
  }
}

// MARK: - EffectSpecifiersTrait

/// Raw syntax nodes don't have traits (because usually we don't need them).
/// Specify the effect specifiers trait manually as a one off.
protocol RawEffectSpecifiersTrait {
  /// The token kinds that should be consumed as misspelled `asyncSpecifier`.
  /// Should be a subset of `AsyncEffectSpecifier`.
  associatedtype MisspelledAsyncSpecifiers: TokenSpecSet

  /// The token kinds that we can consume as a correct `asyncSpecifier`.
  /// Should be a subset of `AsyncEffectSpecifier`.
  associatedtype CorrectAsyncTokenKinds: TokenSpecSet

  /// The token kinds that should be consumed as misspelled `throwsSpecifier`.
  /// Should be a subset of `ThrowsEffectSpecifier`.
  associatedtype MisspelledThrowsTokenKinds: TokenSpecSet

  /// The token kinds that we can consume as a correct `throwsSpecifier`.
  /// Should be a subset of `ThrowsEffectSpecifier`.
  associatedtype CorrectThrowsTokenKinds: TokenSpecSet

  var unexpectedBeforeAsyncSpecifier: RawUnexpectedNodesSyntax? { get }
  var asyncSpecifier: RawTokenSyntax? { get }
  var unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: RawUnexpectedNodesSyntax? { get }
  var throwsSpecifier: RawTokenSyntax? { get }
  var unexpectedAfterThrowsSpecifier: RawUnexpectedNodesSyntax? { get }

  init(
    _ unexpectedBeforeAsyncSpecifier: RawUnexpectedNodesSyntax?,
    asyncSpecifier: RawTokenSyntax?,
    _ unexpectedBetweenAsyncSpecifierAndThrowsSpecifier: RawUnexpectedNodesSyntax?,
    throwsSpecifier: RawTokenSyntax?,
    _ unexpectedAfterThrowsSpecifier: RawUnexpectedNodesSyntax?,
    arena: __shared SyntaxArena
  )
}

extension RawEffectSpecifiersTrait {
  func withMisplaced(async misplacedAsyncKeyword: RawTokenSyntax?, throws misplacedThrowsKeyword: RawTokenSyntax?, arena: __shared SyntaxArena) -> Self {
    return Self.init(
      self.unexpectedBeforeAsyncSpecifier,
      asyncSpecifier: self.asyncSpecifier ?? misplacedAsyncKeyword,
      self.unexpectedBetweenAsyncSpecifierAndThrowsSpecifier,
      throwsSpecifier: self.throwsSpecifier ?? misplacedThrowsKeyword,
      self.unexpectedAfterThrowsSpecifier,
      arena: arena
    )
  }
}

extension RawFunctionEffectSpecifiersSyntax: RawEffectSpecifiersTrait {
  enum MisspelledAsyncSpecifiers: TokenSpecSet {
    case await

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.await, allowAtStartOfLine: false): self = .await
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .await: return TokenSpec(.await, allowAtStartOfLine: false)
      }
    }
  }

  enum CorrectAsyncTokenKinds: TokenSpecSet {
    case async
    case reasync

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.async): self = .async
      case TokenSpec(.reasync): self = .reasync
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .async: return .keyword(.async)
      case .reasync: return .keyword(.reasync)
      }
    }
  }

  enum MisspelledThrowsTokenKinds: TokenSpecSet {
    case `try`
    case `throw`

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.try, allowAtStartOfLine: false): self = .try
      case TokenSpec(.throw, allowAtStartOfLine: false): self = .throw
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .try: return TokenSpec(.try, allowAtStartOfLine: false)
      case .throw: return TokenSpec(.throw, allowAtStartOfLine: false)
      }
    }
  }

  enum CorrectThrowsTokenKinds: TokenSpecSet {
    case `rethrows`
    case `throws`

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.rethrows): self = .rethrows
      case TokenSpec(.throws): self = .throws
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .rethrows: return .keyword(.rethrows)
      case .throws: return .keyword(.throws)
      }
    }
  }
}

extension RawTypeEffectSpecifiersSyntax: RawEffectSpecifiersTrait {
  enum MisspelledAsyncSpecifiers: TokenSpecSet {
    case await
    case reasync

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.await, allowAtStartOfLine: false): self = .await
      case TokenSpec(.reasync): self = .reasync
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .await: return TokenSpec(.await, allowAtStartOfLine: false)
      case .reasync: return .keyword(.reasync)
      }
    }
  }

  enum CorrectAsyncTokenKinds: TokenSpecSet {
    case async

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.async): self = .async
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .async: return .keyword(.async)
      }
    }
  }

  enum MisspelledThrowsTokenKinds: TokenSpecSet {
    case `rethrows`
    case `try`
    case `throw`

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.rethrows): self = .rethrows
      case TokenSpec(.try, allowAtStartOfLine: false): self = .try
      case TokenSpec(.throw, allowAtStartOfLine: false): self = .throw
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .rethrows: return .keyword(.rethrows)
      case .try: return TokenSpec(.try, allowAtStartOfLine: false)
      case .throw: return TokenSpec(.throw, allowAtStartOfLine: false)
      }
    }
  }

  enum CorrectThrowsTokenKinds: TokenSpecSet {
    case `throws`

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.throws): self = .throws
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .throws: return .keyword(.throws)
      }
    }
  }
}

extension RawAccessorEffectSpecifiersSyntax: RawEffectSpecifiersTrait {
  enum MisspelledAsyncSpecifiers: TokenSpecSet {
    case await
    case reasync

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.await, allowAtStartOfLine: false): self = .await
      case TokenSpec(.reasync): self = .reasync
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .await: return TokenSpec(.await, allowAtStartOfLine: false)
      case .reasync: return .keyword(.reasync)
      }
    }
  }

  enum CorrectAsyncTokenKinds: TokenSpecSet {
    case async

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.async): self = .async
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .async: return .keyword(.async)
      }
    }
  }

  enum MisspelledThrowsTokenKinds: TokenSpecSet {
    case `rethrows`
    case `try`
    case `throw`

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.rethrows): self = .rethrows
      case TokenSpec(.try, allowAtStartOfLine: false): self = .try
      case TokenSpec(.throw, allowAtStartOfLine: false): self = .throw
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .rethrows: return .keyword(.rethrows)
      case .try: return TokenSpec(.try, allowAtStartOfLine: false)
      case .throw: return TokenSpec(.throw, allowAtStartOfLine: false)
      }
    }
  }

  enum CorrectThrowsTokenKinds: TokenSpecSet {
    case `throws`

    init?(lexeme: Lexer.Lexeme) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.throws): self = .throws
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .throws: return .keyword(.throws)
      }
    }
  }

}

extension TokenConsumer {
  mutating func at<SpecSet1: TokenSpecSet, SpecSet2: TokenSpecSet>(anyIn specSet1: SpecSet1.Type, or specSet2: SpecSet2.Type) -> (spec: TokenSpec, handle: TokenConsumptionHandle, matchedSubset: Any.Type)? {
    if let (spec, handle) = self.at(anyIn: specSet1) {
      return (spec.spec, handle, SpecSet1.self)
    } else if let (spec, handle) = self.at(anyIn: specSet2) {
      return (spec.spec, handle, SpecSet2.self)
    } else {
      return nil
    }
  }
}

// MARK: - Parsing effect specifiers

extension Parser {
  private mutating func parseEffectSpecifiers<S: RawEffectSpecifiersTrait>(_: S.Type) -> S? {
    var unexpectedBeforeAsync: [RawSyntax] = []
    var asyncKeyword: RawTokenSyntax? = nil
    var unexpectedBeforeThrows: [RawSyntax] = []
    var throwsKeyword: RawTokenSyntax?
    var unexpectedAfterThrows: [RawSyntax] = []
    while let misspelledAsync = self.consume(ifAnyIn: S.MisspelledAsyncSpecifiers.self) {
      unexpectedBeforeAsync.append(RawSyntax(misspelledAsync))
      if asyncKeyword == nil {
        // Let's synthesize a missing 'async'. If we find a real async specifier
        // later, we will replace the missing token by the present token.
        asyncKeyword = missingToken(.keyword(.async))
      }
    }
    if let (_, handle) = self.canRecoverTo(anyIn: S.CorrectAsyncTokenKinds.self) {
      let (unexpected, async) = self.eat(handle)
      unexpectedBeforeAsync.append(contentsOf: unexpected?.elements ?? [])
      asyncKeyword = async
    }

    var unexpectedBeforeThrowsLoopProgress = LoopProgressCondition()
    while unexpectedBeforeThrowsLoopProgress.evaluate(self.currentToken) {
      if let misspelledAsync = self.consume(ifAnyIn: S.MisspelledAsyncSpecifiers.self) {
        unexpectedBeforeThrows.append(RawSyntax(misspelledAsync))
      } else if let misspelledThrows = self.consume(ifAnyIn: S.MisspelledThrowsTokenKinds.self) {
        unexpectedBeforeThrows.append(RawSyntax(misspelledThrows))
        if throwsKeyword == nil {
          // Let's synthesize a missing 'throws'. If we find a real throws specifier
          // later, we will replace the missing token by the present token.
          throwsKeyword = missingToken(.keyword(.throws))
        }
      } else {
        break
      }
    }

    if let (_, handle) = self.canRecoverTo(anyIn: S.CorrectThrowsTokenKinds.self) {
      let (unexpected, throwsKw) = self.eat(handle)
      unexpectedBeforeThrows.append(contentsOf: unexpected?.elements ?? [])
      throwsKeyword = throwsKw
    }

    var unexpectedAfterThrowsLoopProgress = LoopProgressCondition()
    while unexpectedAfterThrowsLoopProgress.evaluate(self.currentToken) {
      if let (_, handle, _) = self.at(anyIn: S.MisspelledAsyncSpecifiers.self, or: S.CorrectAsyncTokenKinds.self) {
        let misspelledAsync = self.eat(handle)
        unexpectedAfterThrows.append(RawSyntax(misspelledAsync))
        if asyncKeyword == nil {
          // Handle `async` after `throws`
          asyncKeyword = missingToken(.keyword(.async))
        }
      } else if let (_, handle, _) = self.at(anyIn: S.MisspelledThrowsTokenKinds.self, or: S.CorrectThrowsTokenKinds.self) {
        let misspelledThrows = self.eat(handle)
        unexpectedAfterThrows.append(RawSyntax(misspelledThrows))
      } else {
        break
      }
    }

    if unexpectedBeforeAsync.isEmpty && asyncKeyword == nil && unexpectedBeforeThrows.isEmpty && throwsKeyword == nil && unexpectedAfterThrows.isEmpty {
      return nil
    }

    return S(
      RawUnexpectedNodesSyntax(unexpectedBeforeAsync, arena: self.arena),
      asyncSpecifier: asyncKeyword,
      RawUnexpectedNodesSyntax(unexpectedBeforeThrows, arena: self.arena),
      throwsSpecifier: throwsKeyword,
      RawUnexpectedNodesSyntax(unexpectedAfterThrows, arena: self.arena),
      arena: self.arena
    )
  }

  mutating func parseTypeEffectSpecifiers() -> RawTypeEffectSpecifiersSyntax? {
    return parseEffectSpecifiers(RawTypeEffectSpecifiersSyntax.self)
  }

  mutating func parseFunctionEffectSpecifiers() -> RawFunctionEffectSpecifiersSyntax? {
    return parseEffectSpecifiers(RawFunctionEffectSpecifiersSyntax.self)
  }

  mutating func parseAccessorEffectSpecifiers() -> RawAccessorEffectSpecifiersSyntax? {
    return parseEffectSpecifiers(RawAccessorEffectSpecifiersSyntax.self)
  }

  /// Consume any misplaced effect specifiers and return them in as unexpected tokens.
  /// When a misplaced effect specifier is consumed and `effectSpecifiers`
  /// doesn't have  an effect specifier of that kind, modify `effectSpecifiers`
  /// to have a missing specifier of that kind.
  mutating func parseMisplacedEffectSpecifiers<S: RawEffectSpecifiersTrait>(_ effectSpecifiers: inout S?) -> RawUnexpectedNodesSyntax? {
    var synthesizedAsync: RawTokenSyntax? = nil
    var synthesizedThrows: RawTokenSyntax? = nil
    var unexpected: [RawTokenSyntax] = []
    var loopProgress = LoopProgressCondition()
    while loopProgress.evaluate(self.currentToken) {
      if let (spec, handle, matchedSubset) = self.at(anyIn: S.MisspelledAsyncSpecifiers.self, or: S.CorrectAsyncTokenKinds.self) {
        let misspelledAsync = self.eat(handle)
        unexpected.append(misspelledAsync)
        if effectSpecifiers?.asyncSpecifier == nil {
          if matchedSubset == S.CorrectAsyncTokenKinds.self {
            synthesizedAsync = missingToken(spec)
          } else {
            synthesizedAsync = missingToken(.async)
          }
        }
      } else if let (spec, handle, matchedSubset) = self.at(anyIn: S.MisspelledThrowsTokenKinds.self, or: S.CorrectThrowsTokenKinds.self) {
        let misspelledThrows = self.eat(handle)
        unexpected.append(misspelledThrows)
        if effectSpecifiers?.throwsSpecifier == nil {
          if matchedSubset == S.CorrectThrowsTokenKinds.self {
            synthesizedThrows = missingToken(spec)
          } else {
            synthesizedThrows = missingToken(.throws)
          }
        }
      } else {
        break
      }
    }
    if synthesizedAsync != nil || synthesizedThrows != nil {
      if let specifiers = effectSpecifiers {
        effectSpecifiers = specifiers.withMisplaced(async: synthesizedAsync, throws: synthesizedThrows, arena: self.arena)
      } else {
        effectSpecifiers = S(
          nil,
          asyncSpecifier: synthesizedAsync,
          nil,
          throwsSpecifier: synthesizedThrows,
          nil,
          arena: self.arena
        )
      }
    }
    return RawUnexpectedNodesSyntax(unexpected, arena: self.arena)
  }
}

// MARK: - Parsing `initializes` and `accesses` specifiers in init accessors

extension Parser {
  mutating func parseInitAccessorEffects() -> RawAccessorInitEffectsSyntax? {
    let initializes = self.parseInitializesSpecifier()
    let accesses = self.parseAccessesSpecifier()

    if initializes == nil, accesses == nil {
      return nil
    }

    return RawAccessorInitEffectsSyntax(
      initializesEffect: initializes,
      accessesEffect: accesses,
      arena: self.arena
    )
  }

  mutating func parseInitializesSpecifier() -> RawInitializesEffectSyntax? {
    guard let keyword = self.consume(if: .keyword(.initializes)) else {
      return nil
    }

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let args = parseArgumentListElements(pattern: .none)
    let argumentList = RawTupleExprElementListSyntax(
      elements: args,
      arena: self.arena
    )

    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawInitializesEffectSyntax(
      initializesKeyword: keyword,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      propertyList: argumentList,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  mutating func parseAccessesSpecifier() -> RawAccessesEffectSyntax? {
    guard let keyword = self.consume(if: .keyword(.accesses)) else {
      return nil
    }

    let (unexpectedBeforeLeftParen, leftParen) = self.expect(.leftParen)

    let args = parseArgumentListElements(pattern: .none)
    let argumentList = RawTupleExprElementListSyntax(
      elements: args,
      arena: self.arena
    )

    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)

    return RawAccessesEffectSyntax(
      accessesKeyword: keyword,
      unexpectedBeforeLeftParen,
      leftParen: leftParen,
      propertyList: argumentList,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }
}
