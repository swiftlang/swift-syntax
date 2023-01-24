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

// MARK: - RawTokenKindSubset

public enum AsyncEffectSpecifier: RawTokenKindSubset {
  case async
  case await
  case reasync

  init?(lexeme: Lexer.Lexeme) {
    // We'll take 'await' too for recovery but they have to be on the same line
    // as the declaration they're modifying.
    switch lexeme {
    case RawTokenKindMatch(.async): self = .async
    case RawTokenKindMatch(.await) where !lexeme.isAtStartOfLine: self = .await
    case RawTokenKindMatch(.reasync): self = .reasync
    default: return nil
    }
  }

  public init?(token: TokenSyntax) {
    switch token.tokenKind {
    case .keyword(.async): self = .async
    case .keyword(.await): self = .await
    case .keyword(.reasync): self = .reasync
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .async: return .keyword(.async)
    case .await: return .keyword(.await)
    case .reasync: return .keyword(.reasync)
    }
  }
}

public enum ThrowsEffectSpecifier: RawTokenKindSubset {
  case `rethrows`
  case `throw`
  case `throws`
  case `try`

  init?(lexeme: Lexer.Lexeme) {
    // We'll take 'throw' and 'try' too for recovery but they have to
    // be on the same line as the declaration they're modifying.
    switch lexeme {
    case RawTokenKindMatch(.rethrows): self = .rethrows
    case RawTokenKindMatch(.throw) where !lexeme.isAtStartOfLine: self = .throw
    case RawTokenKindMatch(.throws): self = .throws
    case RawTokenKindMatch(.try) where !lexeme.isAtStartOfLine: self = .try
    default: return nil
    }
  }

  public init?(token: TokenSyntax) {
    switch token.tokenKind {
    case .keyword(.rethrows): self = .rethrows
    case .keyword(.throw): self = .throw
    case .keyword(.throws): self = .throws
    case .keyword(.try): self = .try
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .rethrows: return .keyword(.rethrows)
    case .throw: return .keyword(.throw)
    case .throws: return .keyword(.throws)
    case .try: return .keyword(.try)
    }
  }
}

public enum EffectSpecifier: RawTokenKindSubset {
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

  public init?(token: TokenSyntax) {
    if let subset = AsyncEffectSpecifier(token: token) {
      self = .asyncSpecifier(subset)
    } else if let subset = ThrowsEffectSpecifier(token: token) {
      self = .throwsSpecifier(subset)
    } else {
      return nil
    }
  }

  public static var allCases: [EffectSpecifier] {
    return AsyncEffectSpecifier.allCases.map(Self.asyncSpecifier)
      + ThrowsEffectSpecifier.allCases.map(Self.throwsSpecifier)
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .asyncSpecifier(let underlyingKind): return underlyingKind.rawTokenKind
    case .throwsSpecifier(let underlyingKind): return underlyingKind.rawTokenKind
    }
  }
}

// MARK: - EffectSpecifiersTrait

/// Raw syntax nodes don't have traits (because usually we don't need them).
/// Specify the effect specifiers trait manually as a one off.
protocol RawEffectSpecifiersTrait {
  /// The token kinds that should be consumed as misspelled `asyncSpecifier`.
  /// Should be a subset of `AsyncEffectSpecifier`.
  associatedtype MisspelledAsyncSpecifiers: RawTokenKindSubset

  /// The token kinds that we can consume as a correct `asyncSpecifier`.
  /// Should be a subset of `AsyncEffectSpecifier`.
  associatedtype CorrectAsyncTokenKinds: RawTokenKindSubset

  /// The token kinds that should be consumed as misspelled `throwsSpecifier`.
  /// Should be a subset of `ThrowsEffectSpecifier`.
  associatedtype MisspelledThrowsTokenKinds: RawTokenKindSubset

  /// The token kinds that we can consume as a correct `throwsSpecifier`.
  /// Should be a subset of `ThrowsEffectSpecifier`.
  associatedtype CorrectThrowsTokenKinds: RawTokenKindSubset

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

extension RawDeclEffectSpecifiersSyntax: RawEffectSpecifiersTrait {
  enum MisspelledAsyncSpecifiers: RawTokenKindSubset {
    case await

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.await) where !lexeme.isAtStartOfLine: self = .await
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .await: return .keyword(.await)
      }
    }
  }

  enum CorrectAsyncTokenKinds: RawTokenKindSubset {
    case async
    case reasync

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.async): self = .async
      case RawTokenKindMatch(.reasync): self = .reasync
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .async: return .keyword(.async)
      case .reasync: return .keyword(.reasync)
      }
    }
  }

  enum MisspelledThrowsTokenKinds: RawTokenKindSubset {
    case `try`
    case `throw`

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.try) where !lexeme.isAtStartOfLine: self = .try
      case RawTokenKindMatch(.throw) where !lexeme.isAtStartOfLine: self = .throw
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .try: return .keyword(.try)
      case .throw: return .keyword(.throw)
      }
    }
  }

  enum CorrectThrowsTokenKinds: RawTokenKindSubset {
    case `rethrows`
    case `throws`

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.rethrows): self = .rethrows
      case RawTokenKindMatch(.throws): self = .throws
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .rethrows: return .keyword(.rethrows)
      case .throws: return .keyword(.throws)
      }
    }
  }
}

extension RawTypeEffectSpecifiersSyntax: RawEffectSpecifiersTrait {
  enum MisspelledAsyncSpecifiers: RawTokenKindSubset {
    case await
    case reasync

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.await) where !lexeme.isAtStartOfLine: self = .await
      case RawTokenKindMatch(.reasync): self = .reasync
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .await: return .keyword(.await)
      case .reasync: return .keyword(.reasync)
      }
    }
  }

  enum CorrectAsyncTokenKinds: RawTokenKindSubset {
    case async

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.async): self = .async
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .async: return .keyword(.async)
      }
    }
  }

  enum MisspelledThrowsTokenKinds: RawTokenKindSubset {
    case `rethrows`
    case `try`
    case `throw`

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.rethrows): self = .rethrows
      case RawTokenKindMatch(.try) where !lexeme.isAtStartOfLine: self = .try
      case RawTokenKindMatch(.throw) where !lexeme.isAtStartOfLine: self = .throw
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .rethrows: return .keyword(.rethrows)
      case .try: return .keyword(.try)
      case .throw: return .keyword(.throw)
      }
    }
  }

  enum CorrectThrowsTokenKinds: RawTokenKindSubset {
    case `throws`

    init?(lexeme: Lexer.Lexeme) {
      switch lexeme {
      case RawTokenKindMatch(.throws): self = .throws
      default: return nil
      }
    }

    var rawTokenKind: RawTokenKind {
      switch self {
      case .throws: return .keyword(.throws)
      }
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
      if let misspelledAsync = self.consume(ifAnyIn: S.MisspelledAsyncSpecifiers.self) ?? self.consume(ifAnyIn: S.CorrectAsyncTokenKinds.self) {
        unexpectedAfterThrows.append(RawSyntax(misspelledAsync))
        if asyncKeyword == nil {
          // Handle `async` after `throws`
          asyncKeyword = missingToken(.keyword(.async))
        }
      } else if let misspelledThrows = self.consume(ifAnyIn: S.MisspelledThrowsTokenKinds.self) ?? self.consume(ifAnyIn: S.CorrectThrowsTokenKinds.self) {
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

  mutating func parseDeclEffectSpecifiers() -> RawDeclEffectSpecifiersSyntax? {
    return parseEffectSpecifiers(RawDeclEffectSpecifiersSyntax.self)
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
      if let misspelledAsync = self.consume(ifAnyIn: S.MisspelledAsyncSpecifiers.self) ?? self.consume(ifAnyIn: S.CorrectAsyncTokenKinds.self) {
        unexpected.append(misspelledAsync)
        if effectSpecifiers?.asyncSpecifier == nil {
          synthesizedAsync = missingToken(misspelledAsync.tokenKind)
        }
      } else if let misspelledThrows = self.consume(ifAnyIn: S.MisspelledThrowsTokenKinds.self) ?? self.consume(ifAnyIn: S.CorrectThrowsTokenKinds.self) {
        unexpected.append(misspelledThrows)
        if effectSpecifiers?.throwsSpecifier == nil {
          synthesizedThrows = missingToken(misspelledThrows.tokenKind)
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
