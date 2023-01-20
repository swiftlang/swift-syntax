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
    if case .keyword = self.rawTokenKind {
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
    case .get: return .keyword(.get)
    case .set: return .keyword(.set)
    case .didSet: return .keyword(.didSet)
    case .willSet: return .keyword(.willSet)
    case .unsafeAddress: return .keyword(.unsafeAddress)
    case .addressWithOwner: return .keyword(.addressWithOwner)
    case .addressWithNativeOwner: return .keyword(.addressWithNativeOwner)
    case .unsafeMutableAddress: return .keyword(.unsafeMutableAddress)
    case .mutableAddressWithOwner: return .keyword(.mutableAddressWithOwner)
    case .mutableAddressWithNativeOwner: return .keyword(.mutableAddressWithNativeOwner)
    case ._read: return .keyword(._read)
    case ._modify: return .keyword(._modify)
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

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme {
    case RawTokenKindMatch(.break): self = .breakKeyword
    case RawTokenKindMatch(.continue): self = .continueKeyword
    case RawTokenKindMatch(.defer): self = .deferKeyword
    case RawTokenKindMatch(.do): self = .doKeyword
    case RawTokenKindMatch(.fallthrough): self = .fallthroughKeyword
    case RawTokenKindMatch(.for): self = .forKeyword
    case RawTokenKindMatch(.guard): self = .guardKeyword
    case RawTokenKindMatch(.if): self = .ifKeyword
    case RawTokenKindMatch(.poundAssertKeyword): self = .poundAssertKeyword
    case RawTokenKindMatch(.repeat): self = .repeatKeyword
    case RawTokenKindMatch(.return): self = .returnKeyword
    case RawTokenKindMatch(.switch): self = .switchKeyword
    case RawTokenKindMatch(.throw): self = .throwKeyword
    case RawTokenKindMatch(.while): self = .whileKeyword
    case RawTokenKindMatch(.yield): self = .yield
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .breakKeyword: return .keyword(.break)
    case .continueKeyword: return .keyword(.continue)
    case .deferKeyword: return .keyword(.defer)
    case .doKeyword: return .keyword(.do)
    case .fallthroughKeyword: return .keyword(.fallthrough)
    case .forKeyword: return .keyword(.for)
    case .guardKeyword: return .keyword(.guard)
    case .ifKeyword: return .keyword(.if)
    case .poundAssertKeyword: return .poundAssertKeyword
    case .repeatKeyword: return .keyword(.repeat)
    case .returnKeyword: return .keyword(.return)
    case .switchKeyword: return .keyword(.switch)
    case .throwKeyword: return .keyword(.throw)
    case .whileKeyword: return .keyword(.while)
    case .yield: return .keyword(.yield)
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
    case .__consuming: return .keyword(.__consuming)
    case ._compilerInitialized: return .keyword(._compilerInitialized)
    case ._const: return .keyword(._const)
    case ._local: return .keyword(._local)
    case .actor: return .keyword(.actor)
    case .async: return .keyword(.async)
    case .convenience: return .keyword(.convenience)
    case .distributed: return .keyword(.distributed)
    case .dynamic: return .keyword(.dynamic)
    case .final: return .keyword(.final)
    case .indirect: return .keyword(.indirect)
    case .infix: return .keyword(.infix)
    case .isolated: return .keyword(.isolated)
    case .lazy: return .keyword(.lazy)
    case .mutating: return .keyword(.mutating)
    case .nonisolated: return .keyword(.nonisolated)
    case .nonmutating: return .keyword(.nonmutating)
    case .package: return .keyword(.package)
    case .open: return .keyword(.open)
    case .optional: return .keyword(.optional)
    case .override: return .keyword(.override)
    case .postfix: return .keyword(.postfix)
    case .prefix: return .keyword(.prefix)
    case .required: return .keyword(.required)
    case .unowned: return .keyword(.unowned)
    case .weak: return .keyword(.weak)
    }
  }
}

enum DeclarationStart: RawTokenKindSubset {
  case actorKeyword
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
  case macroKeyword
  case operatorKeyword
  case precedencegroupKeyword
  case protocolKeyword
  case structKeyword
  case subscriptKeyword
  case typealiasKeyword
  case varKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme {
    case RawTokenKindMatch(.actor): self = .actorKeyword
    case RawTokenKindMatch(.macro): self = .macroKeyword
    case RawTokenKindMatch(.associatedtype): self = .associatedtypeKeyword
    case RawTokenKindMatch(.case): self = .caseKeyword
    case RawTokenKindMatch(.class): self = .classKeyword
    case RawTokenKindMatch(.deinit): self = .deinitKeyword
    case RawTokenKindMatch(.enum): self = .enumKeyword
    case RawTokenKindMatch(.extension): self = .extensionKeyword
    case RawTokenKindMatch(.func): self = .funcKeyword
    case RawTokenKindMatch(.import): self = .importKeyword
    case RawTokenKindMatch(.`init`): self = .initKeyword
    case RawTokenKindMatch(.let): self = .letKeyword
    case RawTokenKindMatch(.operator): self = .operatorKeyword
    case RawTokenKindMatch(.precedencegroup): self = .precedencegroupKeyword
    case RawTokenKindMatch(.protocol): self = .protocolKeyword
    case RawTokenKindMatch(.struct): self = .structKeyword
    case RawTokenKindMatch(.subscript): self = .subscriptKeyword
    case RawTokenKindMatch(.typealias): self = .typealiasKeyword
    case RawTokenKindMatch(.var): self = .varKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .actorKeyword: return .keyword(.actor)
    case .associatedtypeKeyword: return .keyword(.associatedtype)
    case .caseKeyword: return .keyword(.case)
    case .classKeyword: return .keyword(.class)
    case .deinitKeyword: return .keyword(.deinit)
    case .enumKeyword: return .keyword(.enum)
    case .extensionKeyword: return .keyword(.extension)
    case .funcKeyword: return .keyword(.func)
    case .importKeyword: return .keyword(.import)
    case .initKeyword: return .keyword(.`init`)
    case .letKeyword: return .keyword(.let)
    case .macroKeyword: return .keyword(.macro)
    case .operatorKeyword: return .keyword(.operator)
    case .precedencegroupKeyword: return .keyword(.precedencegroup)
    case .protocolKeyword: return .keyword(.protocol)
    case .structKeyword: return .keyword(.struct)
    case .subscriptKeyword: return .keyword(.subscript)
    case .typealiasKeyword: return .keyword(.typealias)
    case .varKeyword: return .keyword(.var)
    }
  }

  var precedence: TokenPrecedence? {
    switch self {
    case .actorKeyword: return .declKeyword
    case .caseKeyword: return .declKeyword
    case .macroKeyword: return .declKeyword
    default: return nil
    }
  }
}

enum EffectsSpecifier: RawTokenKindSubset {
  case asyncKeyword
  case awaitKeyword
  case reasyncKeyword
  case rethrowsKeyword
  case throwKeyword
  case throwsKeyword
  case tryKeyword

  init?(lexeme: Lexer.Lexeme) {
    // We'll take 'await', 'throw' and 'try' too for recovery but they have to
    // be on the same line as the declaration they're modifying.
    switch lexeme {
    case RawTokenKindMatch(.async): self = .asyncKeyword
    case RawTokenKindMatch(.await) where !lexeme.isAtStartOfLine: self = .awaitKeyword
    case RawTokenKindMatch(.reasync): self = .reasyncKeyword
    case RawTokenKindMatch(.rethrows): self = .rethrowsKeyword
    case RawTokenKindMatch(.throw) where !lexeme.isAtStartOfLine: self = .throwKeyword
    case RawTokenKindMatch(.throws): self = .throwsKeyword
    case RawTokenKindMatch(.try) where !lexeme.isAtStartOfLine: self = .tryKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .asyncKeyword: return .keyword(.async)
    case .awaitKeyword: return .keyword(.await)
    case .reasyncKeyword: return .keyword(.reasync)
    case .rethrowsKeyword: return .keyword(.rethrows)
    case .throwKeyword: return .keyword(.throw)
    case .throwsKeyword: return .keyword(.throws)
    case .tryKeyword: return .keyword(.try)
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
    switch lexeme {
    case RawTokenKindMatch(.Any): self = .anyKeyword
    case RawTokenKindMatch(.Self): self = .capitalSelfKeyword
    case RawTokenKindMatch(.identifier): self = .identifier
    case RawTokenKindMatch(.`init`): self = .initKeyword
    case RawTokenKindMatch(.self): self = .selfKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .anyKeyword: return .keyword(.Any)
    case .capitalSelfKeyword: return .keyword(.Self)
    case .identifier: return .identifier
    case .initKeyword: return .keyword(.`init`)
    case .selfKeyword: return .keyword(.self)
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
    switch lexeme {
    case RawTokenKindMatch(.Any): self = .anyKeyword
    case RawTokenKindMatch(.Self): self = .capitalSelfKeyword
    case RawTokenKindMatch(.identifier): self = .identifier
    case RawTokenKindMatch(.self): self = .selfKeyword
    case RawTokenKindMatch(.rethrows): self = .rethrowsKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .anyKeyword: return .keyword(.Any)
    case .capitalSelfKeyword: return .keyword(.Self)
    case .identifier: return .identifier
    case .selfKeyword: return .keyword(.self)
    case .rethrowsKeyword: return .keyword(.rethrows)
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
  case binaryOperator
  case postfixOperator
  case prefixOperator

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.rawTokenKind {
    case .binaryOperator: self = .binaryOperator
    case .postfixOperator: self = .postfixOperator
    case .prefixOperator: self = .prefixOperator
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .binaryOperator: return .binaryOperator
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
    case .regexLiteral: return TokenPrecedence(.binaryOperator)
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
    switch lexeme {
    case RawTokenKindMatch(.case): self = .caseKeyword
    case RawTokenKindMatch(.default): self = .defaultKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .caseKeyword: return .keyword(.case)
    case .defaultKeyword: return .keyword(.default)
    }
  }
}

public enum TypeSpecifier: RawTokenKindSubset {
  case inoutKeyword
  case owned
  case shared

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme {
    case RawTokenKindMatch(.inout): self = .inoutKeyword
    case RawTokenKindMatch(.__owned): self = .owned
    case RawTokenKindMatch(.__shared): self = .shared
    default: return nil
    }
  }

  public init?(token: TokenSyntax) {
    switch token {
    case RawTokenKindMatch(.inout): self = .inoutKeyword
    case RawTokenKindMatch(.__owned): self = .owned
    case RawTokenKindMatch(.__shared): self = .shared
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .inoutKeyword: return .keyword(.inout)
    case .owned: return .keyword(.__owned)
    case .shared: return .keyword(.__shared)
    }
  }
}

// MARK: Expression start

enum AwaitTryMove: RawTokenKindSubset {
  case awaitKeyword
  case _moveKeyword
  case _borrowKeyword
  case tryKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme {
    case RawTokenKindMatch(.await): self = .awaitKeyword
    case RawTokenKindMatch(._move): self = ._moveKeyword
    case RawTokenKindMatch(._borrow): self = ._borrowKeyword
    case RawTokenKindMatch(.try): self = .tryKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .awaitKeyword: return .keyword(.await)
    case ._moveKeyword: return .keyword(._move)
    case ._borrowKeyword: return .keyword(._borrow)
    case .tryKeyword: return .keyword(.try)
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
    switch lexeme {
    case RawTokenKindMatch(.is): self = .isKeyword
    case RawTokenKindMatch(.let): self = .letKeyword
    case RawTokenKindMatch(.var): self = .varKeyword
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .isKeyword: return .keyword(.is)
    case .letKeyword: return .keyword(.let)
    case .varKeyword: return .keyword(.var)
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
    case ._const: return .keyword(._const)
    case .isolated: return .keyword(.isolated)
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
  case poundAvailableKeyword  // For recovery
  case poundUnavailableKeyword  // For recovery
  case regexLiteral
  case selfKeyword
  case superKeyword
  case trueKeyword
  case wildcard
  case rawStringDelimiter
  case stringQuote
  case multilineStringQuote
  case singleQuote

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme {
    case RawTokenKindMatch(.Any): self = .anyKeyword
    case RawTokenKindMatch(.Self): self = .capitalSelfKeyword
    case RawTokenKindMatch(.dollarIdentifier): self = .dollarIdentifier
    case RawTokenKindMatch(.false): self = .falseKeyword
    case RawTokenKindMatch(.floatingLiteral): self = .floatingLiteral
    case RawTokenKindMatch(.identifier): self = .identifier
    case RawTokenKindMatch(.`init`): self = .initKeyword
    case RawTokenKindMatch(.integerLiteral): self = .integerLiteral
    case RawTokenKindMatch(.leftBrace): self = .leftBrace
    case RawTokenKindMatch(.leftParen): self = .leftParen
    case RawTokenKindMatch(.leftSquareBracket): self = .leftSquareBracket
    case RawTokenKindMatch(.nil): self = .nilKeyword
    case RawTokenKindMatch(.period): self = .period
    case RawTokenKindMatch(.pound): self = .pound
    case RawTokenKindMatch(.poundAvailableKeyword): self = .poundAvailableKeyword
    case RawTokenKindMatch(.poundUnavailableKeyword): self = .poundUnavailableKeyword
    case RawTokenKindMatch(.regexLiteral): self = .regexLiteral
    case RawTokenKindMatch(.self): self = .selfKeyword
    case RawTokenKindMatch(.super): self = .superKeyword
    case RawTokenKindMatch(.true): self = .trueKeyword
    case RawTokenKindMatch(.wildcard): self = .wildcard
    case RawTokenKindMatch(.rawStringDelimiter): self = .rawStringDelimiter
    case RawTokenKindMatch(.stringQuote): self = .stringQuote
    case RawTokenKindMatch(.multilineStringQuote): self = .multilineStringQuote
    case RawTokenKindMatch(.singleQuote): self = .singleQuote
    default: return nil
    }
  }

  var rawTokenKind: SwiftSyntax.RawTokenKind {
    switch self {
    case .anyKeyword: return .keyword(.Any)
    case .capitalSelfKeyword: return .keyword(.Self)
    case .dollarIdentifier: return .dollarIdentifier
    case .falseKeyword: return .keyword(.false)
    case .floatingLiteral: return .floatingLiteral
    case .identifier: return .identifier
    case .initKeyword: return .keyword(.`init`)
    case .integerLiteral: return .integerLiteral
    case .leftBrace: return .leftBrace
    case .leftParen: return .leftParen
    case .leftSquareBracket: return .leftSquareBracket
    case .nilKeyword: return .keyword(.nil)
    case .period: return .period
    case .pound: return .pound
    case .poundAvailableKeyword: return .poundAvailableKeyword
    case .poundUnavailableKeyword: return .poundUnavailableKeyword
    case .regexLiteral: return .regexLiteral
    case .selfKeyword: return .keyword(.self)
    case .superKeyword: return .keyword(.super)
    case .trueKeyword: return .keyword(.true)
    case .wildcard: return .wildcard
    case .rawStringDelimiter: return .rawStringDelimiter
    case .stringQuote: return .stringQuote
    case .multilineStringQuote: return .multilineStringQuote
    case .singleQuote: return .singleQuote
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
