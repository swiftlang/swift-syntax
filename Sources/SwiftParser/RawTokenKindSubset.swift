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

/// Allows callers of `at(anyOf:)` to expect being positioned at a subset of all
/// `RawTokenKind`s.
protocol RawTokenKindSubset: CaseIterable {
  var rawTokenKind: RawTokenKind { get }

  /// Creates an instance if `lexeme` satisfy the condition of this subset.
  init?(lexeme: Lexer.Lexeme)

  /// If this returns a non-nil value, only tokens with this token text are matched.
  /// Must only return a non-nil value if `rawTokenKind` is `identifier` or `contextualKeyword`.
  var contextualKeyword: SyntaxText? { get }

  /// If not `nil`, the token's will be remapped to this kind when the handle is eaten.
  var remappedKind: RawTokenKind? { get }

  /// The precedence of this token that determines which tokens can be skipped
  /// trying to reach it. If this returns `nil`, the precedence of `rawTokenKind`
  /// is used. This is mostly overwritten for contextual keywords.
  var precedence: TokenPrecedence? { get }
}

extension RawTokenKindSubset {
  var contextualKeyword: SyntaxText? {
    return nil
  }

  var remappedKind: RawTokenKind? {
    if self.contextualKeyword != nil {
      return .contextualKeyword
    } else {
      return nil
    }
  }

  var precedence: TokenPrecedence? {
    return nil
  }
}

/// A set of contextual keywords.
/// This should be an enum that has `SyntaxText` as its underlying value.
protocol ContextualKeywords: RawRepresentable, RawTokenKindSubset {}

extension ContextualKeywords where RawValue == SyntaxText {
  init?(lexeme: Lexer.Lexeme) {
    guard lexeme.tokenKind == .identifier else { return nil }
    self.init(rawValue: lexeme.tokenText)
  }

  var rawTokenKind: RawTokenKind {
    return .identifier
  }

  var contextualKeyword: SyntaxText? {
    return self.rawValue
  }
}

// MARK: - Subsets

enum AccessorKind: SyntaxText, ContextualKeywords, Equatable {
  case `get` = "get"
  case `set` = "set"
  case `didSet` = "didSet"
  case `willSet` = "willSet"
  case unsafeAddress = "unsafeAddress"
  case addressWithOwner = "addressWithOwner"
  case addressWithNativeOwner = "addressWithNativeOwner"
  case unsafeMutableAddress = "unsafeMutableAddress"
  case mutableAddressWithOwner = "mutableAddressWithOwner"
  case mutableAddressWithNativeOwner = "mutableAddressWithNativeOwner"
  case _read = "_read"
  case _modify = "_modify"
}

enum BinaryOperator: RawTokenKindSubset {
  case spacedBinaryOperator
  case unspacedBinaryOperator

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .spacedBinaryOperator: self = .spacedBinaryOperator
    case .unspacedBinaryOperator: self = .unspacedBinaryOperator
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .spacedBinaryOperator: return .spacedBinaryOperator
    case .unspacedBinaryOperator: return .unspacedBinaryOperator
    }
  }
}

enum CanBeStatementStart: RawTokenKindSubset {
  case breakKeyword
  case continueKeyword
  case deferKeyword
  case doKeyword
  case fallthroughKeyword
  case forKeyword
  case guardKeyword
  case ifKeyword
  case poundAssertKeyword
  case repeatKeyword
  case returnKeyword
  case switchKeyword
  case throwKeyword
  case whileKeyword
  case yield
  case yieldAsIdentifier

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .breakKeyword: self = .breakKeyword
    case .continueKeyword: self = .continueKeyword
    case .deferKeyword: self = .deferKeyword
    case .doKeyword: self = .doKeyword
    case .fallthroughKeyword: self = .fallthroughKeyword
    case .forKeyword: self = .forKeyword
    case .guardKeyword: self = .guardKeyword
    case .ifKeyword: self = .ifKeyword
    case .poundAssertKeyword: self = .poundAssertKeyword
    case .repeatKeyword: self = .repeatKeyword
    case .returnKeyword: self = .returnKeyword
    case .switchKeyword: self = .switchKeyword
    case .throwKeyword: self = .throwKeyword
    case .whileKeyword: self = .whileKeyword
    case .yield: self = .yield
    case .identifier where lexeme.tokenText == "yield": self = .yieldAsIdentifier
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .breakKeyword: return .breakKeyword
    case .continueKeyword: return .continueKeyword
    case .deferKeyword: return .deferKeyword
    case .doKeyword: return .doKeyword
    case .fallthroughKeyword: return .fallthroughKeyword
    case .forKeyword: return .forKeyword
    case .guardKeyword: return .guardKeyword
    case .ifKeyword: return .ifKeyword
    case .poundAssertKeyword: return .poundAssertKeyword
    case .repeatKeyword: return .repeatKeyword
    case .returnKeyword: return .returnKeyword
    case .switchKeyword: return .switchKeyword
    case .throwKeyword: return .throwKeyword
    case .whileKeyword: return .whileKeyword
    case .yield: return .yield
    case .yieldAsIdentifier: return .identifier
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .yieldAsIdentifier: return "yield"
    default: return nil
    }
  }

  var precedence: TokenPrecedence? {
    switch self {
    case .yieldAsIdentifier: return .stmtKeyword
    default: return nil
    }
  }
}

enum ContextualDeclKeyword: SyntaxText, ContextualKeywords {
  case __consuming = "__consuming"
  case _compilerInitialized = "_compilerInitialized"
  case _const = "_const"
  case _local = "_local"
  case actor = "actor"
  case async = "async"
  case convenience = "convenience"
  case distributed = "distributed"
  case dynamic = "dynamic"
  case final = "final"
  case indirect = "indirect"
  case infix = "infix"
  case isolated = "isolated"
  case lazy = "lazy"
  case mutating = "mutating"
  case nonisolated = "nonisolated"
  case nonmutating = "nonmutating"
  case package = "package"
  case open = "open"
  case optional = "optional"
  case override = "override"
  case postfix = "postfix"
  case prefix = "prefix"
  case required = "required"
  case unowned = "unowned"
  case weak = "weak"
}

enum DeclarationStart: RawTokenKindSubset {
  case actorContextualKeyword
  case associatedtypeKeyword
  case caseKeyword
  case classKeyword
  case deinitKeyword
  case enumKeyword
  case extensionKeyword
  case funcKeyword
  case importKeyword
  case initKeyword
  case letKeyword
  case macroContextualKeyword
  case operatorKeyword
  case precedencegroupKeyword
  case protocolKeyword
  case structKeyword
  case subscriptKeyword
  case typealiasKeyword
  case varKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .identifier where lexeme.tokenText == "actor": self = .actorContextualKeyword
    case .identifier where lexeme.tokenText == "macro": self = .macroContextualKeyword
    case .associatedtypeKeyword: self = .associatedtypeKeyword
    case .caseKeyword: self = .caseKeyword
    case .classKeyword: self = .classKeyword
    case .deinitKeyword: self = .deinitKeyword
    case .enumKeyword: self = .enumKeyword
    case .extensionKeyword: self = .extensionKeyword
    case .funcKeyword: self = .funcKeyword
    case .importKeyword: self = .importKeyword
    case .initKeyword: self = .initKeyword
    case .letKeyword: self = .letKeyword
    case .operatorKeyword: self = .operatorKeyword
    case .precedencegroupKeyword: self = .precedencegroupKeyword
    case .protocolKeyword: self = .protocolKeyword
    case .structKeyword: self = .structKeyword
    case .subscriptKeyword: self = .subscriptKeyword
    case .typealiasKeyword: self = .typealiasKeyword
    case .varKeyword: self = .varKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .actorContextualKeyword: return .identifier
    case .associatedtypeKeyword: return .associatedtypeKeyword
    case .caseKeyword: return .caseKeyword
    case .classKeyword: return .classKeyword
    case .deinitKeyword: return .deinitKeyword
    case .enumKeyword: return .enumKeyword
    case .extensionKeyword: return .extensionKeyword
    case .funcKeyword: return .funcKeyword
    case .importKeyword: return .importKeyword
    case .initKeyword: return .initKeyword
    case .letKeyword: return .letKeyword
    case .macroContextualKeyword: return .identifier
    case .operatorKeyword: return .operatorKeyword
    case .precedencegroupKeyword: return .precedencegroupKeyword
    case .protocolKeyword: return .protocolKeyword
    case .structKeyword: return .structKeyword
    case .subscriptKeyword: return .subscriptKeyword
    case .typealiasKeyword: return .typealiasKeyword
    case .varKeyword: return .varKeyword
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .actorContextualKeyword: return "actor"
    case .macroContextualKeyword: return "macro"
    default: return nil
    }
  }

  var precedence: TokenPrecedence? {
    switch self {
    case .actorContextualKeyword: return .declKeyword
    case .caseKeyword: return .declKeyword
    case .macroContextualKeyword: return .declKeyword
    default: return nil
    }
  }
}

enum EffectsSpecifier: RawTokenKindSubset {
  case asyncContextualKeyword
  case awaitContextualKeyword
  case reasyncContextualKeyword
  case rethrowsKeyword
  case throwKeyword
  case throwsKeyword
  case tryKeyword

  init?(lexeme: Lexer.Lexeme) {
    // We'll take 'await', 'throw' and 'try' too for recovery but they have to
    // be on the same line as the declaration they're modifying.
    switch lexeme.tokenKind {
    case .identifier where lexeme.tokenText == "async": self = .asyncContextualKeyword
    case .identifier where lexeme.tokenText == "await" && !lexeme.isAtStartOfLine: self = .awaitContextualKeyword
    case .identifier where lexeme.tokenText == "reasync": self = .reasyncContextualKeyword
    case .rethrowsKeyword: self = .rethrowsKeyword
    case .throwKeyword where !lexeme.isAtStartOfLine: self = .throwKeyword
    case .throwsKeyword: self = .throwsKeyword
    case .tryKeyword where !lexeme.isAtStartOfLine: self = .tryKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .asyncContextualKeyword: return .identifier
    case .awaitContextualKeyword: return .identifier
    case .reasyncContextualKeyword: return .identifier
    case .rethrowsKeyword: return .rethrowsKeyword
    case .throwKeyword: return .throwKeyword
    case .throwsKeyword: return .throwsKeyword
    case .tryKeyword: return .tryKeyword
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .asyncContextualKeyword: return "async"
    case .reasyncContextualKeyword: return "reasync"
    case .awaitContextualKeyword: return "await"
    default: return nil
    }
  }
}

enum IdentifierTokens: RawTokenKindSubset {
  case anyKeyword
  case capitalSelfKeyword
  case identifier
  case initKeyword
  case selfKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .anyKeyword: self = .anyKeyword
    case .capitalSelfKeyword: self = .capitalSelfKeyword
    case .identifier: self = .identifier
    case .initKeyword: self = .initKeyword
    case .selfKeyword: self = .selfKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .anyKeyword: return .anyKeyword
    case .capitalSelfKeyword: return .capitalSelfKeyword
    case .identifier: return .identifier
    case .initKeyword: return .initKeyword
    case .selfKeyword: return .selfKeyword
    }
  }
}

enum IdentifierOrRethrowsTokens: RawTokenKindSubset {
  case anyKeyword
  case capitalSelfKeyword
  case identifier
  case selfKeyword
  case rethrowsKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .anyKeyword: self = .anyKeyword
    case .capitalSelfKeyword: self = .capitalSelfKeyword
    case .identifier: self = .identifier
    case .selfKeyword: self = .selfKeyword
    case .rethrowsKeyword: self = .rethrowsKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .anyKeyword: return .anyKeyword
    case .capitalSelfKeyword: return .capitalSelfKeyword
    case .identifier: return .identifier
    case .selfKeyword: return .selfKeyword
    case .rethrowsKeyword: return .rethrowsKeyword
    }
  }

  var remappedKind: RawTokenKind? {
    switch self {
    case .rethrowsKeyword: return .identifier
    default: return nil
    }
  }

}

enum Operator: RawTokenKindSubset {
  case spacedBinaryOperator
  case unspacedBinaryOperator
  case postfixOperator
  case prefixOperator

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .spacedBinaryOperator: self = .spacedBinaryOperator
    case .unspacedBinaryOperator: self = .unspacedBinaryOperator
    case .postfixOperator: self = .postfixOperator
    case .prefixOperator: self = .prefixOperator
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .spacedBinaryOperator: return .spacedBinaryOperator
    case .unspacedBinaryOperator: return .unspacedBinaryOperator
    case .postfixOperator: return .postfixOperator
    case .prefixOperator: return .prefixOperator
    }
  }
}

/// Tokens that can be used in operator declarations
enum OperatorLike: RawTokenKindSubset {
  case `operator`(Operator)
  case exclamationMark
  case infixQuestionMark
  case postfixQuestionMark
  case equal
  case arrow
  case regexLiteral  // regex literals can look like operators, e.g. '/^/'

  init?(lexeme: Lexer.Lexeme) {
    if let op = Operator(lexeme: lexeme) {
      self = .operator(op)
      return
    }
    switch lexeme.tokenKind {
    case .exclamationMark: self = .exclamationMark
    case .infixQuestionMark: self = .infixQuestionMark
    case .postfixQuestionMark: self = .postfixQuestionMark
    case .equal: self = .equal
    case .arrow: self = .arrow
    case .regexLiteral: self = .regexLiteral
    default: return nil
    }
  }

  static var allCases: [OperatorLike] {
    return Operator.allCases.map(Self.operator) + [
      .exclamationMark,
      .infixQuestionMark,
      .postfixQuestionMark,
      .equal,
      .arrow,
      .regexLiteral,
    ]
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .operator(let op): return op.rawTokenKind
    case .exclamationMark: return .exclamationMark
    case .infixQuestionMark: return .infixQuestionMark
    case .postfixQuestionMark: return .postfixQuestionMark
    case .equal: return .equal
    case .arrow: return .arrow
    case .regexLiteral: return .regexLiteral
    }
  }

  var precedence: TokenPrecedence? {
    switch self {
    case .regexLiteral: return TokenPrecedence(.spacedBinaryOperator)
    default: return nil
    }
  }
}

enum PoundDeclarationStart: RawTokenKindSubset {
  case poundIfKeyword
  case poundWarningKeyword
  case poundErrorKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .poundIfKeyword: self = .poundIfKeyword
    case .poundWarningKeyword: self = .poundWarningKeyword
    case .poundErrorKeyword: self = .poundErrorKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .poundIfKeyword: return .poundIfKeyword
    case .poundWarningKeyword: return .poundWarningKeyword
    case .poundErrorKeyword: return .poundErrorKeyword
    }
  }
}

enum SwitchCaseStart: RawTokenKindSubset {
  case caseKeyword
  case defaultKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .caseKeyword: self = .caseKeyword
    case .defaultKeyword: self = .defaultKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .caseKeyword: return .caseKeyword
    case .defaultKeyword: return .defaultKeyword
    }
  }
}

public enum TypeSpecifier: RawTokenKindSubset {
  case inoutKeyword
  case owned
  case shared

  init?(lexeme: Lexer.Lexeme) {
    switch (lexeme.tokenKind, lexeme.tokenText) {
    case (.inoutKeyword, _): self = .inoutKeyword
    case (.identifier, "__owned"): self = .owned
    case (.identifier, "__shared"): self = .shared
    default: return nil
    }
  }

  public init?(token: TokenSyntax) {
    switch (token.tokenKind, token.text) {
    case (.inoutKeyword, _): self = .inoutKeyword
    case (.contextualKeyword, "__owned"): self = .owned
    case (.contextualKeyword, "__shared"): self = .shared
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .inoutKeyword: return .inoutKeyword
    case .owned: return .identifier
    case .shared: return .identifier
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .inoutKeyword: return nil
    case .owned: return "__owned"
    case .shared: return "__shared"
    }
  }
}

// MARK: Expression start

enum AwaitTryMove: RawTokenKindSubset {
  case awaitContextualKeyword
  case _moveContextualKeyword
  case tryKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch (lexeme.tokenKind, lexeme.tokenText) {
    case (.tryKeyword, _): self = .tryKeyword
    case (.identifier, "await"): self = .awaitContextualKeyword
    case (.identifier, "_move"): self = ._moveContextualKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .awaitContextualKeyword: return .identifier
    case ._moveContextualKeyword: return .identifier
    case .tryKeyword: return .tryKeyword
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .awaitContextualKeyword: return "await"
    case ._moveContextualKeyword: return "_move"
    default: return nil
    }
  }
}

enum ExpressionPrefixOperator: RawTokenKindSubset {
  case backslash
  case prefixAmpersand
  case prefixOperator

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .backslash: self = .backslash
    case .prefixAmpersand: self = .prefixAmpersand
    case .prefixOperator: self = .prefixOperator
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .backslash: return .backslash
    case .prefixAmpersand: return .prefixAmpersand
    case .prefixOperator: return .prefixOperator
    }
  }
}

enum MatchingPatternStart: RawTokenKindSubset {
  case isKeyword
  case letKeyword
  case varKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .isKeyword: self = .isKeyword
    case .letKeyword: self = .letKeyword
    case .varKeyword: self = .varKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .isKeyword: return .isKeyword
    case .letKeyword: return .letKeyword
    case .varKeyword: return .varKeyword
    }
  }
}

enum ParameterModifier: RawTokenKindSubset {
  case _const
  case isolated

  init?(lexeme: Lexer.Lexeme) {
    switch (lexeme.tokenKind, lexeme.tokenText) {
    case (.identifier, "_const"): self = ._const
    case (.identifier, "isolated"): self = .isolated
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    return .identifier
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case ._const: return "_const"
    case .isolated: return "isolated"
    }
  }
}

enum PrimaryExpressionStart: RawTokenKindSubset {
  case anyKeyword
  case capitalSelfKeyword
  case dollarIdentifier
  case falseKeyword
  case floatingLiteral
  case identifier
  case initKeyword
  case integerLiteral
  case leftBrace
  case leftParen
  case leftSquareBracket
  case nilKeyword
  case period
  case pound
  case prefixPeriod
  case regexLiteral
  case selfKeyword
  case stringLiteral
  case superKeyword
  case trueKeyword
  case wildcardKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .anyKeyword: self = .anyKeyword
    case .capitalSelfKeyword: self = .capitalSelfKeyword
    case .dollarIdentifier: self = .dollarIdentifier
    case .falseKeyword: self = .falseKeyword
    case .floatingLiteral: self = .floatingLiteral
    case .identifier: self = .identifier
    case .initKeyword: self = .initKeyword
    case .integerLiteral: self = .integerLiteral
    case .leftBrace: self = .leftBrace
    case .leftParen: self = .leftParen
    case .leftSquareBracket: self = .leftSquareBracket
    case .nilKeyword: self = .nilKeyword
    case .period: self = .period
    case .pound: self = .pound
    case .prefixPeriod: self = .prefixPeriod
    case .regexLiteral: self = .regexLiteral
    case .selfKeyword: self = .selfKeyword
    case .stringLiteral: self = .stringLiteral
    case .superKeyword: self = .superKeyword
    case .trueKeyword: self = .trueKeyword
    case .wildcardKeyword: self = .wildcardKeyword
    default: return nil
    }
  }

  var rawTokenKind: SwiftSyntax.RawTokenKind {
    switch self {
    case .anyKeyword: return .anyKeyword
    case .capitalSelfKeyword: return .capitalSelfKeyword
    case .dollarIdentifier: return .dollarIdentifier
    case .falseKeyword: return .falseKeyword
    case .floatingLiteral: return .floatingLiteral
    case .identifier: return .identifier
    case .initKeyword: return .initKeyword
    case .integerLiteral: return .integerLiteral
    case .leftBrace: return .leftBrace
    case .leftParen: return .leftParen
    case .leftSquareBracket: return .leftSquareBracket
    case .nilKeyword: return .nilKeyword
    case .period: return .period
    case .pound: return .pound
    case .prefixPeriod: return .prefixPeriod
    case .regexLiteral: return .regexLiteral
    case .selfKeyword: return .selfKeyword
    case .stringLiteral: return .stringLiteral
    case .superKeyword: return .superKeyword
    case .trueKeyword: return .trueKeyword
    case .wildcardKeyword: return .wildcardKeyword
    }
  }

  var remappedKind: RawTokenKind? {
    switch self {
    case .period: return .prefixPeriod
    default: return nil
    }
  }
}

/// Union of the following token kind subsets:
///  - `AwaitTry`
///  - `ExpressionPrefixOperator`
///  - `MatchingPatternStart`
///  - `PrimaryExpressionStart`
enum ExpressionStart: RawTokenKindSubset {
  case awaitTryMove(AwaitTryMove)
  case expressionPrefixOperator(ExpressionPrefixOperator)
  case primaryExpressionStart(PrimaryExpressionStart)

  init?(lexeme: Lexer.Lexeme) {
    if let subset = AwaitTryMove(lexeme: lexeme) {
      self = .awaitTryMove(subset)
    } else if let subset = ExpressionPrefixOperator(lexeme: lexeme) {
      self = .expressionPrefixOperator(subset)
    } else if let subset = PrimaryExpressionStart(lexeme: lexeme) {
      self = .primaryExpressionStart(subset)
    } else {
      return nil
    }
  }

  static var allCases: [ExpressionStart] {
    return AwaitTryMove.allCases.map(Self.awaitTryMove)
      + ExpressionPrefixOperator.allCases.map(Self.expressionPrefixOperator)
      + PrimaryExpressionStart.allCases.map(Self.primaryExpressionStart)
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .awaitTryMove(let underlyingKind): return underlyingKind.rawTokenKind
    case .expressionPrefixOperator(let underlyingKind): return underlyingKind.rawTokenKind
    case .primaryExpressionStart(let underlyingKind): return underlyingKind.rawTokenKind
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .awaitTryMove(let underlyingKind): return underlyingKind.contextualKeyword
    case .expressionPrefixOperator(let underlyingKind): return underlyingKind.contextualKeyword
    case .primaryExpressionStart(let underlyingKind): return underlyingKind.contextualKeyword
    }
  }
}
