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

  /// If not `nil`, the token's will be remapped to this kind when the handle is eaten.
  var remappedKind: RawTokenKind? { get }

  /// The precedence of this token that determines which tokens can be skipped
  /// trying to reach it. If this returns `nil`, the precedence of `rawTokenKind`
  /// is used. This is mostly overwritten for contextual keywords.
  var precedence: TokenPrecedence? { get }
}

extension RawTokenKindSubset {
  var remappedKind: RawTokenKind? {
    if case .contextualKeyword = self.rawTokenKind {
      return self.rawTokenKind
    } else {
      return nil
    }
  }

  var precedence: TokenPrecedence? {
    return nil
  }
}

// MARK: - Subsets

enum AccessorKind: RawTokenKindSubset {
  case `get`
  case `set`
  case `didSet`
  case `willSet`
  case unsafeAddress
  case addressWithOwner
  case addressWithNativeOwner
  case unsafeMutableAddress
  case mutableAddressWithOwner
  case mutableAddressWithNativeOwner
  case _read
  case _modify

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme {
    case RawTokenKindMatch(.get): self = .get
    case RawTokenKindMatch(.set): self = .set
    case RawTokenKindMatch(.didSet): self = .didSet
    case RawTokenKindMatch(.willSet): self = .willSet
    case RawTokenKindMatch(.unsafeAddress): self = .unsafeAddress
    case RawTokenKindMatch(.addressWithOwner): self = .addressWithOwner
    case RawTokenKindMatch(.addressWithNativeOwner): self = .addressWithNativeOwner
    case RawTokenKindMatch(.unsafeMutableAddress): self = .unsafeMutableAddress
    case RawTokenKindMatch(.mutableAddressWithOwner): self = .mutableAddressWithOwner
    case RawTokenKindMatch(.mutableAddressWithNativeOwner): self = .mutableAddressWithNativeOwner
    case RawTokenKindMatch(._read): self = ._read
    case RawTokenKindMatch(._modify): self = ._modify
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .get: return .contextualKeyword(.get)
    case .set: return .contextualKeyword(.set)
    case .didSet: return .contextualKeyword(.didSet)
    case .willSet: return .contextualKeyword(.willSet)
    case .unsafeAddress: return .contextualKeyword(.unsafeAddress)
    case .addressWithOwner: return .contextualKeyword(.addressWithOwner)
    case .addressWithNativeOwner: return .contextualKeyword(.addressWithNativeOwner)
    case .unsafeMutableAddress: return .contextualKeyword(.unsafeMutableAddress)
    case .mutableAddressWithOwner: return .contextualKeyword(.mutableAddressWithOwner)
    case .mutableAddressWithNativeOwner: return .contextualKeyword(.mutableAddressWithNativeOwner)
    case ._read: return .contextualKeyword(._read)
    case ._modify: return .contextualKeyword(._modify)
    }
  }
}

enum BinaryOperator: RawTokenKindSubset {
  case spacedBinaryOperator
  case unspacedBinaryOperator

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.rawTokenKind {
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
    switch lexeme {
    case RawTokenKindMatch(.breakKeyword): self = .breakKeyword
    case RawTokenKindMatch(.continueKeyword): self = .continueKeyword
    case RawTokenKindMatch(.deferKeyword): self = .deferKeyword
    case RawTokenKindMatch(.doKeyword): self = .doKeyword
    case RawTokenKindMatch(.fallthroughKeyword): self = .fallthroughKeyword
    case RawTokenKindMatch(.forKeyword): self = .forKeyword
    case RawTokenKindMatch(.guardKeyword): self = .guardKeyword
    case RawTokenKindMatch(.ifKeyword): self = .ifKeyword
    case RawTokenKindMatch(.poundAssertKeyword): self = .poundAssertKeyword
    case RawTokenKindMatch(.repeatKeyword): self = .repeatKeyword
    case RawTokenKindMatch(.returnKeyword): self = .returnKeyword
    case RawTokenKindMatch(.switchKeyword): self = .switchKeyword
    case RawTokenKindMatch(.throwKeyword): self = .throwKeyword
    case RawTokenKindMatch(.whileKeyword): self = .whileKeyword
    case RawTokenKindMatch(RawTokenKind.yield): self = .yield
    case RawTokenKindMatch(Keyword.yield): self = .yieldAsIdentifier
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
    case .yieldAsIdentifier: return .contextualKeyword(.yield)
    }
  }

  var precedence: TokenPrecedence? {
    switch self {
    case .yieldAsIdentifier: return .stmtKeyword
    default: return nil
    }
  }
}

enum ContextualDeclKeyword: RawTokenKindSubset {
  case __consuming
  case _compilerInitialized
  case _const
  case _local
  case actor
  case async
  case convenience
  case distributed
  case dynamic
  case final
  case indirect
  case infix
  case isolated
  case lazy
  case mutating
  case nonisolated
  case nonmutating
  case package
  case open
  case optional
  case override
  case postfix
  case prefix
  case required
  case unowned
  case weak

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme {
    case RawTokenKindMatch(.__consuming): self = .__consuming
    case RawTokenKindMatch(._compilerInitialized): self = ._compilerInitialized
    case RawTokenKindMatch(._const): self = ._const
    case RawTokenKindMatch(._local): self = ._local
    case RawTokenKindMatch(.actor): self = .actor
    case RawTokenKindMatch(.async): self = .async
    case RawTokenKindMatch(.convenience): self = .convenience
    case RawTokenKindMatch(.distributed): self = .distributed
    case RawTokenKindMatch(.dynamic): self = .dynamic
    case RawTokenKindMatch(.final): self = .final
    case RawTokenKindMatch(.indirect): self = .indirect
    case RawTokenKindMatch(.infix): self = .infix
    case RawTokenKindMatch(.isolated): self = .isolated
    case RawTokenKindMatch(.lazy): self = .lazy
    case RawTokenKindMatch(.mutating): self = .mutating
    case RawTokenKindMatch(.nonisolated): self = .nonisolated
    case RawTokenKindMatch(.nonmutating): self = .nonmutating
    case RawTokenKindMatch(.package): self = .package
    case RawTokenKindMatch(.open): self = .open
    case RawTokenKindMatch(.optional): self = .optional
    case RawTokenKindMatch(.override): self = .override
    case RawTokenKindMatch(.postfix): self = .postfix
    case RawTokenKindMatch(.prefix): self = .prefix
    case RawTokenKindMatch(.required): self = .required
    case RawTokenKindMatch(.unowned): self = .unowned
    case RawTokenKindMatch(.weak): self = .weak
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .__consuming: return .contextualKeyword(.__consuming)
    case ._compilerInitialized: return .contextualKeyword(._compilerInitialized)
    case ._const: return .contextualKeyword(._const)
    case ._local: return .contextualKeyword(._local)
    case .actor: return .contextualKeyword(.actor)
    case .async: return .contextualKeyword(.async)
    case .convenience: return .contextualKeyword(.convenience)
    case .distributed: return .contextualKeyword(.distributed)
    case .dynamic: return .contextualKeyword(.dynamic)
    case .final: return .contextualKeyword(.final)
    case .indirect: return .contextualKeyword(.indirect)
    case .infix: return .contextualKeyword(.infix)
    case .isolated: return .contextualKeyword(.isolated)
    case .lazy: return .contextualKeyword(.lazy)
    case .mutating: return .contextualKeyword(.mutating)
    case .nonisolated: return .contextualKeyword(.nonisolated)
    case .nonmutating: return .contextualKeyword(.nonmutating)
    case .package: return .contextualKeyword(.package)
    case .open: return .contextualKeyword(.open)
    case .optional: return .contextualKeyword(.optional)
    case .override: return .contextualKeyword(.override)
    case .postfix: return .contextualKeyword(.postfix)
    case .prefix: return .contextualKeyword(.prefix)
    case .required: return .contextualKeyword(.required)
    case .unowned: return .contextualKeyword(.unowned)
    case .weak: return .contextualKeyword(.weak)
    }
  }
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
    switch lexeme {
    case RawTokenKindMatch(.actor): self = .actorContextualKeyword
    case RawTokenKindMatch(.macro): self = .macroContextualKeyword
    case RawTokenKindMatch(.associatedtypeKeyword): self = .associatedtypeKeyword
    case RawTokenKindMatch(.caseKeyword): self = .caseKeyword
    case RawTokenKindMatch(.classKeyword): self = .classKeyword
    case RawTokenKindMatch(.deinitKeyword): self = .deinitKeyword
    case RawTokenKindMatch(.enumKeyword): self = .enumKeyword
    case RawTokenKindMatch(.extensionKeyword): self = .extensionKeyword
    case RawTokenKindMatch(.funcKeyword): self = .funcKeyword
    case RawTokenKindMatch(.importKeyword): self = .importKeyword
    case RawTokenKindMatch(.initKeyword): self = .initKeyword
    case RawTokenKindMatch(.letKeyword): self = .letKeyword
    case RawTokenKindMatch(.operatorKeyword): self = .operatorKeyword
    case RawTokenKindMatch(.precedencegroupKeyword): self = .precedencegroupKeyword
    case RawTokenKindMatch(.protocolKeyword): self = .protocolKeyword
    case RawTokenKindMatch(.structKeyword): self = .structKeyword
    case RawTokenKindMatch(.subscriptKeyword): self = .subscriptKeyword
    case RawTokenKindMatch(.typealiasKeyword): self = .typealiasKeyword
    case RawTokenKindMatch(.varKeyword): self = .varKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .actorContextualKeyword: return .contextualKeyword(.actor)
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
    case .macroContextualKeyword: return .contextualKeyword(.macro)
    case .operatorKeyword: return .operatorKeyword
    case .precedencegroupKeyword: return .precedencegroupKeyword
    case .protocolKeyword: return .protocolKeyword
    case .structKeyword: return .structKeyword
    case .subscriptKeyword: return .subscriptKeyword
    case .typealiasKeyword: return .typealiasKeyword
    case .varKeyword: return .varKeyword
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
    switch lexeme {
    case RawTokenKindMatch(.async): self = .asyncContextualKeyword
    case RawTokenKindMatch(.await) where !lexeme.isAtStartOfLine: self = .awaitContextualKeyword
    case RawTokenKindMatch(.reasync): self = .reasyncContextualKeyword
    case RawTokenKindMatch(.rethrowsKeyword): self = .rethrowsKeyword
    case RawTokenKindMatch(.throwKeyword) where !lexeme.isAtStartOfLine: self = .throwKeyword
    case RawTokenKindMatch(.throwsKeyword): self = .throwsKeyword
    case RawTokenKindMatch(.tryKeyword) where !lexeme.isAtStartOfLine: self = .tryKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .asyncContextualKeyword: return .contextualKeyword(.async)
    case .awaitContextualKeyword: return .contextualKeyword(.await)
    case .reasyncContextualKeyword: return .contextualKeyword(.reasync)
    case .rethrowsKeyword: return .rethrowsKeyword
    case .throwKeyword: return .throwKeyword
    case .throwsKeyword: return .throwsKeyword
    case .tryKeyword: return .tryKeyword
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
    switch lexeme.rawTokenKind {
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
    switch lexeme.rawTokenKind {
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
    switch lexeme.rawTokenKind {
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
    switch lexeme.rawTokenKind {
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
    switch lexeme.rawTokenKind {
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
    switch lexeme.rawTokenKind {
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
    switch lexeme {
    case RawTokenKindMatch(.inoutKeyword): self = .inoutKeyword
    case RawTokenKindMatch(.__owned): self = .owned
    case RawTokenKindMatch(.__shared): self = .shared
    default: return nil
    }
  }

  public init?(token: TokenSyntax) {
    switch token {
    case RawTokenKindMatch(.inoutKeyword): self = .inoutKeyword
    case RawTokenKindMatch(.__owned): self = .owned
    case RawTokenKindMatch(.__shared): self = .shared
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .inoutKeyword: return .inoutKeyword
    case .owned: return .contextualKeyword(.__owned)
    case .shared: return .contextualKeyword(.__shared)
    }
  }
}

// MARK: Expression start

enum AwaitTryMove: RawTokenKindSubset {
  case awaitContextualKeyword
  case _moveContextualKeyword
  case _borrowContextualKeyword
  case tryKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme {
    case RawTokenKindMatch(.tryKeyword): self = .tryKeyword
    case RawTokenKindMatch(.await): self = .awaitContextualKeyword
    case RawTokenKindMatch(._move): self = ._moveContextualKeyword
    case RawTokenKindMatch(._borrow): self = ._borrowContextualKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .awaitContextualKeyword: return .contextualKeyword(.await)
    case ._moveContextualKeyword: return .contextualKeyword(._move)
    case ._borrowContextualKeyword: return .contextualKeyword(._borrow)
    case .tryKeyword: return .tryKeyword
    }
  }
}

enum ExpressionPrefixOperator: RawTokenKindSubset {
  case backslash
  case prefixAmpersand
  case prefixOperator

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.rawTokenKind {
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
    switch lexeme.rawTokenKind {
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
    switch lexeme {
    case RawTokenKindMatch(._const): self = ._const
    case RawTokenKindMatch(.isolated): self = .isolated
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case ._const: return .contextualKeyword(._const)
    case .isolated: return .contextualKeyword(.isolated)
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
  case regexLiteral
  case selfKeyword
  case stringLiteral
  case superKeyword
  case trueKeyword
  case wildcardKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.rawTokenKind {
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
    case .regexLiteral: return .regexLiteral
    case .selfKeyword: return .selfKeyword
    case .stringLiteral: return .stringLiteral
    case .superKeyword: return .superKeyword
    case .trueKeyword: return .trueKeyword
    case .wildcardKeyword: return .wildcardKeyword
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
  case matchingPatternStart(MatchingPatternStart)
  case primaryExpressionStart(PrimaryExpressionStart)

  init?(lexeme: Lexer.Lexeme) {
    if let subset = AwaitTryMove(lexeme: lexeme) {
      self = .awaitTryMove(subset)
    } else if let subset = ExpressionPrefixOperator(lexeme: lexeme) {
      self = .expressionPrefixOperator(subset)
    } else if let subset = MatchingPatternStart(lexeme: lexeme) {
      self = .matchingPatternStart(subset)
    } else if let subset = PrimaryExpressionStart(lexeme: lexeme) {
      self = .primaryExpressionStart(subset)
    } else {
      return nil
    }
  }

  static var allCases: [ExpressionStart] {
    return AwaitTryMove.allCases.map(Self.awaitTryMove)
      + ExpressionPrefixOperator.allCases.map(Self.expressionPrefixOperator)
      + MatchingPatternStart.allCases.map(Self.matchingPatternStart)
      + PrimaryExpressionStart.allCases.map(Self.primaryExpressionStart)
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .awaitTryMove(let underlyingKind): return underlyingKind.rawTokenKind
    case .expressionPrefixOperator(let underlyingKind): return underlyingKind.rawTokenKind
    case .matchingPatternStart(let underlyingKind): return underlyingKind.rawTokenKind
    case .primaryExpressionStart(let underlyingKind): return underlyingKind.rawTokenKind
    }
  }
}
