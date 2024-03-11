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

#if swift(>=6)
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

// MARK: - TokenSpecSet

@_spi(Diagnostics)
public enum AsyncEffectSpecifier: TokenSpecSet {
  case async
  case await
  case reasync

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    if let subset = AsyncEffectSpecifier(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .asyncSpecifier(subset)
    } else if let subset = ThrowsEffectSpecifier(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
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

  var isThrowsSpecifier: Bool {
    switch self {
    case .asyncSpecifier: return false
    case .throwsSpecifier: return true
    }
  }
}

// MARK: - EffectSpecifiersTrait

/// Raw syntax nodes don't have traits (because usually we don't need them).
/// Specify the effect specifiers trait manually as a one off.
protocol RawMisplacedEffectSpecifiersTrait {
  /// The token kinds that should be consumed as misspelled `asyncSpecifier`.
  /// Should be a subset of ``AsyncEffectSpecifier``.
  associatedtype MisspelledAsyncTokenKinds: TokenSpecSet

  /// The token kinds that we can consume as a correct `asyncSpecifier`.
  /// Should be a subset of ``AsyncEffectSpecifier``.
  associatedtype CorrectAsyncTokenKinds: TokenSpecSet

  /// The token kinds that should be consumed as misspelled `throwsSpecifier`.
  /// Should be a subset of ``ThrowsEffectSpecifier``.
  associatedtype MisspelledThrowsTokenKinds: TokenSpecSet

  /// The token kinds that we can consume as a correct `throwsSpecifier`.
  /// Should be a subset of ``ThrowsEffectSpecifier``.
  associatedtype CorrectThrowsTokenKinds: TokenSpecSet

  var asyncSpecifier: RawTokenSyntax? { get }
  var throwsClause: RawThrowsClauseSyntax? { get }

  init(
    asyncSpecifier: RawTokenSyntax?,
    throwsClause: RawThrowsClauseSyntax?,
    arena: __shared SyntaxArena
  )

  func withMisplaced(async misplacedAsyncKeyword: RawTokenSyntax?, throws misplacedThrowsClause: RawThrowsClauseSyntax?, arena: __shared SyntaxArena) -> Self
}

protocol RawEffectSpecifiersTrait: RawMisplacedEffectSpecifiersTrait {
  var unexpectedBeforeAsyncSpecifier: RawUnexpectedNodesSyntax? { get }
  var unexpectedBetweenAsyncSpecifierAndThrowsClause: RawUnexpectedNodesSyntax? { get }
  var unexpectedAfterThrowsClause: RawUnexpectedNodesSyntax? { get }
  init(
    _ unexpectedBeforeAsyncSpecifier: RawUnexpectedNodesSyntax?,
    asyncSpecifier: RawTokenSyntax?,
    _ unexpectedBetweenAsyncSpecifierAndThrowsClause: RawUnexpectedNodesSyntax?,
    throwsClause: RawThrowsClauseSyntax?,
    _ unexpectedAfterThrowsClause: RawUnexpectedNodesSyntax?,
    arena: __shared SyntaxArena
  )
}

extension RawEffectSpecifiersTrait {
  init(
    asyncSpecifier: RawTokenSyntax?,
    throwsClause: RawThrowsClauseSyntax?,
    arena: __shared SyntaxArena
  ) {
    self.init(
      nil,
      asyncSpecifier: asyncSpecifier,
      nil,
      throwsClause: throwsClause,
      nil,
      arena: arena
    )
  }

  func withMisplaced(async misplacedAsyncKeyword: RawTokenSyntax?, throws misplacedThrowsClause: RawThrowsClauseSyntax?, arena: __shared SyntaxArena) -> Self {
    return Self.init(
      self.unexpectedBeforeAsyncSpecifier,
      asyncSpecifier: self.asyncSpecifier ?? misplacedAsyncKeyword,
      self.unexpectedBetweenAsyncSpecifierAndThrowsClause,
      throwsClause: self.throwsClause ?? misplacedThrowsClause,
      self.unexpectedAfterThrowsClause,
      arena: arena
    )
  }
}

extension RawFunctionEffectSpecifiersSyntax: RawEffectSpecifiersTrait {
  enum MisspelledAsyncTokenKinds: TokenSpecSet {
    case await

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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
  enum MisspelledAsyncTokenKinds: TokenSpecSet {
    case await
    case reasync

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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
  enum MisspelledAsyncTokenKinds: TokenSpecSet {
    case await
    case reasync

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

extension RawDeinitializerEffectSpecifiersSyntax: RawMisplacedEffectSpecifiersTrait {
  enum MisspelledAsyncTokenKinds: TokenSpecSet {
    case await
    case reasync

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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
    case `throws`

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
      switch PrepareForKeywordMatch(lexeme) {
      case TokenSpec(.rethrows): self = .rethrows
      case TokenSpec(.try, allowAtStartOfLine: false): self = .try
      case TokenSpec(.throw, allowAtStartOfLine: false): self = .throw
      case TokenSpec(.throws): self = .throws
      default: return nil
      }
    }

    var spec: TokenSpec {
      switch self {
      case .rethrows: return .keyword(.rethrows)
      case .try: return TokenSpec(.try, allowAtStartOfLine: false)
      case .throw: return TokenSpec(.throw, allowAtStartOfLine: false)
      case .throws: return .keyword(.throws)
      }
    }
  }

  enum CorrectThrowsTokenKinds: TokenSpecSet {
    // Uninhabited

    init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
      return nil
    }

    var spec: TokenSpec {
      switch self {
      }
    }
  }

  var throwsClause: RawThrowsClauseSyntax? { nil }

  init(
    asyncSpecifier: RawTokenSyntax?,
    throwsClause: RawThrowsClauseSyntax?,
    arena: __shared SwiftSyntax.SyntaxArena
  ) {
    // `throwsSpecifier` should never be present because `parseMisplacedEffectSpecifiers()` only creates missing tokens
    // and `CorrectThrowsTokenKinds` is an empty `TokenSpecSet`.
    //
    // We don't want to insert missing `throws` for deinit case,
    // so if `parseMisplacedEffectSpecifiers()` creates one it will be discarded here.
    precondition(throwsClause?.throwsSpecifier.isMissing ?? true)
    self.init(
      nil,
      asyncSpecifier: asyncSpecifier,
      arena: arena
    )
  }

  func withMisplaced(async misplacedAsyncKeyword: RawTokenSyntax?, throws misplacedThrowsClause: RawThrowsClauseSyntax?, arena: SyntaxArena)
    -> RawDeinitializerEffectSpecifiersSyntax
  {
    // `throwsClause` should never be present because `parseMisplacedEffectSpecifiers()` only creates missing tokens
    // and `CorrectThrowsTokenKinds` is an empty `TokenSpecSet`.
    //
    // We don't want to insert missing `throws` for deinit case,
    // so if `parseMisplacedEffectSpecifiers()` creates one it will be discarded here.
    precondition(throwsClause?.throwsSpecifier.isMissing ?? true)
    return Self.init(
      self.unexpectedBeforeAsyncSpecifier,
      asyncSpecifier: self.asyncSpecifier ?? misplacedAsyncKeyword,
      self.unexpectedAfterAsyncSpecifier,
      arena: arena
    )
  }
}

extension TokenConsumer {
  mutating func at<SpecSet1: TokenSpecSet, SpecSet2: TokenSpecSet>(
    anyIn specSet1: SpecSet1.Type,
    or specSet2: SpecSet2.Type
  ) -> (spec: TokenSpec, handle: TokenConsumptionHandle, matchedSubset: Any.Type)? {
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
  /// Parse a throws clause after we've already parsed the 'throws' keyword to introduce it.
  mutating func parseThrowsClause(after throwsKeyword: RawTokenSyntax) -> RawThrowsClauseSyntax {
    guard let leftParen = self.consume(if: .leftParen) else {
      return RawThrowsClauseSyntax(
        throwsSpecifier: throwsKeyword,
        leftParen: nil,
        type: nil,
        rightParen: nil,
        arena: self.arena
      )
    }

    let type = self.parseType()
    let (unexpectedBeforeRightParen, rightParen) = self.expect(.rightParen)
    return RawThrowsClauseSyntax(
      throwsSpecifier: throwsKeyword,
      leftParen: leftParen,
      type: type,
      unexpectedBeforeRightParen,
      rightParen: rightParen,
      arena: self.arena
    )
  }

  private mutating func parseEffectSpecifiers<S: RawEffectSpecifiersTrait>(_: S.Type) -> S? {
    var unexpectedBeforeAsync: [RawSyntax] = []
    var asyncKeyword: RawTokenSyntax? = nil
    var unexpectedBeforeThrows: [RawSyntax] = []
    var throwsClause: RawThrowsClauseSyntax?
    var unexpectedAfterThrowsClause: [RawSyntax] = []

    while let misspelledAsync = self.consume(ifAnyIn: S.MisspelledAsyncTokenKinds.self) {
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
    while self.hasProgressed(&unexpectedBeforeThrowsLoopProgress) {
      if let misspelledAsync = self.consume(ifAnyIn: S.MisspelledAsyncTokenKinds.self) {
        unexpectedBeforeThrows.append(RawSyntax(misspelledAsync))
      } else if let misspelledThrows = self.consume(ifAnyIn: S.MisspelledThrowsTokenKinds.self) {
        unexpectedBeforeThrows.append(RawSyntax(misspelledThrows))
        if throwsClause == nil {
          // Let's synthesize a missing 'throws'. If we find a real throws specifier
          // later, we will replace the missing token by the present token.
          throwsClause = RawThrowsClauseSyntax(throwsSpecifier: missingToken(.keyword(.throws)), leftParen: nil, type: nil, rightParen: nil, arena: self.arena)
        }
      } else {
        break
      }
    }

    if let (_, handle) = self.canRecoverTo(anyIn: S.CorrectThrowsTokenKinds.self) {
      let (unexpected, throwsKw) = self.eat(handle)
      unexpectedBeforeThrows.append(contentsOf: unexpected?.elements ?? [])

      throwsClause = parseThrowsClause(after: throwsKw)
    }

    var unexpectedAfterThrownErrorLoopProgress = LoopProgressCondition()
    while self.hasProgressed(&unexpectedAfterThrownErrorLoopProgress) {
      if let (_, handle, _) = self.at(anyIn: S.MisspelledAsyncTokenKinds.self, or: S.CorrectAsyncTokenKinds.self) {
        let misspelledAsync = self.eat(handle)
        unexpectedAfterThrowsClause.append(RawSyntax(misspelledAsync))
        if asyncKeyword == nil {
          // Handle `async` after `throws`
          asyncKeyword = missingToken(.keyword(.async))
        }
      } else if let (_, handle, _) = self.at(anyIn: S.MisspelledThrowsTokenKinds.self, or: S.CorrectThrowsTokenKinds.self) {
        let misspelledThrows = self.eat(handle)
        unexpectedAfterThrowsClause.append(RawSyntax(misspelledThrows))
      } else {
        break
      }
    }

    if unexpectedBeforeAsync.isEmpty && asyncKeyword == nil && unexpectedBeforeThrows.isEmpty && throwsClause == nil
      && unexpectedAfterThrowsClause.isEmpty
    {
      return nil
    }

    return S(
      RawUnexpectedNodesSyntax(unexpectedBeforeAsync, arena: self.arena),
      asyncSpecifier: asyncKeyword,
      RawUnexpectedNodesSyntax(unexpectedBeforeThrows, arena: self.arena),
      throwsClause: throwsClause,
      RawUnexpectedNodesSyntax(unexpectedAfterThrowsClause, arena: self.arena),
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

  mutating func parseDeinitEffectSpecifiers() -> RawDeinitializerEffectSpecifiersSyntax? {
    // Note that parseEffectSpecifiers() consumes deinit name as unexpected token
    // But we want it to be handled on the higher level.
    // So we parseEffectSpecifiers() is not reused here.

    var unexpectedBeforeAsync: [RawSyntax?] = []
    var asyncKeyword: RawTokenSyntax?
    var unexpectedAfterAsync: [RawSyntax?] = []

    while let (specifier, handle) = self.at(anyIn: EffectSpecifiers.self) {
      let beforeAsync = asyncKeyword?.isMissing ?? true
      switch specifier {
      case .async:
        if beforeAsync {
          asyncKeyword = self.eat(handle)
        } else {
          unexpectedAfterAsync.append(RawSyntax(self.eat(handle)))
        }
      case .await, .reasync:
        if beforeAsync {
          // Let's synthesize a missing 'async'. If we find a real async specifier
          // later, we will replace the missing token by the present token.
          asyncKeyword = missingToken(.async)
        }
        fallthrough
      default:
        if beforeAsync {
          unexpectedBeforeAsync.append(RawSyntax(self.eat(handle)))
        } else {
          unexpectedAfterAsync.append(RawSyntax(self.eat(handle)))
        }
      }
    }

    if unexpectedBeforeAsync.isEmpty && asyncKeyword == nil && unexpectedAfterAsync.isEmpty {
      return nil
    }

    return RawDeinitializerEffectSpecifiersSyntax(
      RawUnexpectedNodesSyntax(unexpectedBeforeAsync, arena: self.arena),
      asyncSpecifier: asyncKeyword,
      RawUnexpectedNodesSyntax(unexpectedAfterAsync, arena: self.arena),
      arena: self.arena
    )
  }

  /// Consume any misplaced effect specifiers and return them in as unexpected tokens.
  /// When a misplaced effect specifier is consumed and `effectSpecifiers`
  /// doesn't have an effect specifier of that kind, modify `effectSpecifiers`
  /// to have a missing specifier of that kind.
  mutating func parseMisplacedEffectSpecifiers<S: RawMisplacedEffectSpecifiersTrait>(_ effectSpecifiers: inout S?) -> RawUnexpectedNodesSyntax? {
    var synthesizedAsync: RawTokenSyntax? = nil
    var synthesizedThrows: RawTokenSyntax? = nil
    var unexpected: [RawTokenSyntax] = []
    var loopProgress = LoopProgressCondition()
    while self.hasProgressed(&loopProgress) {
      if let (spec, handle, matchedSubset) = self.at(anyIn: S.MisspelledAsyncTokenKinds.self, or: S.CorrectAsyncTokenKinds.self) {
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
        if effectSpecifiers?.throwsClause == nil {
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
      let synthesizedThrowsClause = synthesizedThrows.map {
        RawThrowsClauseSyntax(throwsSpecifier: $0, leftParen: nil, type: nil, rightParen: nil, arena: self.arena)
      }

      if let specifiers = effectSpecifiers {
        effectSpecifiers = specifiers.withMisplaced(async: synthesizedAsync, throws: synthesizedThrowsClause, arena: self.arena)
      } else {
        effectSpecifiers = S(
          asyncSpecifier: synthesizedAsync,
          throwsClause: synthesizedThrowsClause,
          arena: self.arena
        )
      }
    }
    return RawUnexpectedNodesSyntax(unexpected, arena: self.arena)
  }
}
