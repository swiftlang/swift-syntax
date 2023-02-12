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

/// A set of `TokenSpecs`. We expect to consume one of the sets specs in the
/// parser.
protocol TokenSpecSet: CaseIterable {
  var spec: TokenSpec { get }

  /// Creates an instance if `lexeme` satisfy the condition of this subset.
  init?(lexeme: Lexer.Lexeme)
}

// MARK: - Subsets

enum AccessorKind: TokenSpecSet {
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
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.get): self = .get
    case TokenSpec(.set): self = .set
    case TokenSpec(.didSet): self = .didSet
    case TokenSpec(.willSet): self = .willSet
    case TokenSpec(.unsafeAddress): self = .unsafeAddress
    case TokenSpec(.addressWithOwner): self = .addressWithOwner
    case TokenSpec(.addressWithNativeOwner): self = .addressWithNativeOwner
    case TokenSpec(.unsafeMutableAddress): self = .unsafeMutableAddress
    case TokenSpec(.mutableAddressWithOwner): self = .mutableAddressWithOwner
    case TokenSpec(.mutableAddressWithNativeOwner): self = .mutableAddressWithNativeOwner
    case TokenSpec(._read): self = ._read
    case TokenSpec(._modify): self = ._modify
    default: return nil
    }
  }

  var spec: TokenSpec {
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

enum CanBeStatementStart: TokenSpecSet {
  case breakKeyword
  case continueKeyword
  case deferKeyword
  case doKeyword
  case fallthroughKeyword
  case forKeyword
  case guardKeyword
  case ifKeyword
  case repeatKeyword
  case returnKeyword
  case switchKeyword
  case throwKeyword
  case whileKeyword
  case yield

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.break): self = .breakKeyword
    case TokenSpec(.continue): self = .continueKeyword
    case TokenSpec(.defer): self = .deferKeyword
    case TokenSpec(.do): self = .doKeyword
    case TokenSpec(.fallthrough): self = .fallthroughKeyword
    case TokenSpec(.for): self = .forKeyword
    case TokenSpec(.guard): self = .guardKeyword
    case TokenSpec(.if): self = .ifKeyword
    case TokenSpec(.repeat): self = .repeatKeyword
    case TokenSpec(.return): self = .returnKeyword
    case TokenSpec(.switch): self = .switchKeyword
    case TokenSpec(.throw): self = .throwKeyword
    case TokenSpec(.while): self = .whileKeyword
    case TokenSpec(.yield): self = .yield
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .breakKeyword: return .keyword(.break)
    case .continueKeyword: return .keyword(.continue)
    case .deferKeyword: return .keyword(.defer)
    case .doKeyword: return .keyword(.do)
    case .fallthroughKeyword: return .keyword(.fallthrough)
    case .forKeyword: return .keyword(.for)
    case .guardKeyword: return .keyword(.guard)
    case .ifKeyword: return .keyword(.if)
    case .repeatKeyword: return .keyword(.repeat)
    case .returnKeyword: return .keyword(.return)
    case .switchKeyword: return .keyword(.switch)
    case .throwKeyword: return .keyword(.throw)
    case .whileKeyword: return .keyword(.while)
    case .yield: return .keyword(.yield)
    }
  }
}

enum ContextualDeclKeyword: TokenSpecSet {
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
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.__consuming): self = .__consuming
    case TokenSpec(._compilerInitialized): self = ._compilerInitialized
    case TokenSpec(._const): self = ._const
    case TokenSpec(._local): self = ._local
    case TokenSpec(.actor): self = .actor
    case TokenSpec(.async): self = .async
    case TokenSpec(.convenience): self = .convenience
    case TokenSpec(.distributed): self = .distributed
    case TokenSpec(.dynamic): self = .dynamic
    case TokenSpec(.final): self = .final
    case TokenSpec(.indirect): self = .indirect
    case TokenSpec(.infix): self = .infix
    case TokenSpec(.isolated): self = .isolated
    case TokenSpec(.lazy): self = .lazy
    case TokenSpec(.mutating): self = .mutating
    case TokenSpec(.nonisolated): self = .nonisolated
    case TokenSpec(.nonmutating): self = .nonmutating
    case TokenSpec(.package): self = .package
    case TokenSpec(.open): self = .open
    case TokenSpec(.optional): self = .optional
    case TokenSpec(.override): self = .override
    case TokenSpec(.postfix): self = .postfix
    case TokenSpec(.prefix): self = .prefix
    case TokenSpec(.required): self = .required
    case TokenSpec(.unowned): self = .unowned
    case TokenSpec(.weak): self = .weak
    default: return nil
    }
  }

  var spec: TokenSpec {
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

enum DeclarationStart: TokenSpecSet {
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
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.actor): self = .actorKeyword
    case TokenSpec(.macro): self = .macroKeyword
    case TokenSpec(.associatedtype): self = .associatedtypeKeyword
    case TokenSpec(.case): self = .caseKeyword
    case TokenSpec(.class): self = .classKeyword
    case TokenSpec(.deinit): self = .deinitKeyword
    case TokenSpec(.enum): self = .enumKeyword
    case TokenSpec(.extension): self = .extensionKeyword
    case TokenSpec(.func): self = .funcKeyword
    case TokenSpec(.import): self = .importKeyword
    case TokenSpec(.`init`): self = .initKeyword
    case TokenSpec(.let): self = .letKeyword
    case TokenSpec(.operator): self = .operatorKeyword
    case TokenSpec(.precedencegroup): self = .precedencegroupKeyword
    case TokenSpec(.protocol): self = .protocolKeyword
    case TokenSpec(.struct): self = .structKeyword
    case TokenSpec(.subscript): self = .subscriptKeyword
    case TokenSpec(.typealias): self = .typealiasKeyword
    case TokenSpec(.var): self = .varKeyword
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .actorKeyword: return TokenSpec(.actor, recoveryPrecedence: .declKeyword)
    case .associatedtypeKeyword: return .keyword(.associatedtype)
    case .caseKeyword: return TokenSpec(.case, recoveryPrecedence: .declKeyword)
    case .classKeyword: return .keyword(.class)
    case .deinitKeyword: return .keyword(.deinit)
    case .enumKeyword: return .keyword(.enum)
    case .extensionKeyword: return .keyword(.extension)
    case .funcKeyword: return .keyword(.func)
    case .importKeyword: return .keyword(.import)
    case .initKeyword: return .keyword(.`init`)
    case .letKeyword: return .keyword(.let)
    case .macroKeyword: return TokenSpec(.macro, recoveryPrecedence: .declKeyword)
    case .operatorKeyword: return .keyword(.operator)
    case .precedencegroupKeyword: return .keyword(.precedencegroup)
    case .protocolKeyword: return .keyword(.protocol)
    case .structKeyword: return .keyword(.struct)
    case .subscriptKeyword: return .keyword(.subscript)
    case .typealiasKeyword: return .keyword(.typealias)
    case .varKeyword: return .keyword(.var)
    }
  }
}

enum IdentifierTokens: TokenSpecSet {
  case anyKeyword
  case capitalSelfKeyword
  case identifier
  case initKeyword
  case selfKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.Any): self = .anyKeyword
    case TokenSpec(.Self): self = .capitalSelfKeyword
    case TokenSpec(.identifier): self = .identifier
    case TokenSpec(.`init`): self = .initKeyword
    case TokenSpec(.self): self = .selfKeyword
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .anyKeyword: return .keyword(.Any)
    case .capitalSelfKeyword: return .keyword(.Self)
    case .identifier: return .identifier
    case .initKeyword: return .keyword(.`init`)
    case .selfKeyword: return .keyword(.self)
    }
  }
}

enum IdentifierOrRethrowsTokens: TokenSpecSet {
  case anyKeyword
  case capitalSelfKeyword
  case identifier
  case selfKeyword
  case rethrowsKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.Any): self = .anyKeyword
    case TokenSpec(.Self): self = .capitalSelfKeyword
    case TokenSpec(.identifier): self = .identifier
    case TokenSpec(.self): self = .selfKeyword
    case TokenSpec(.rethrows): self = .rethrowsKeyword
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .anyKeyword: return .keyword(.Any)
    case .capitalSelfKeyword: return .keyword(.Self)
    case .identifier: return .identifier
    case .selfKeyword: return .keyword(.self)
    case .rethrowsKeyword: return TokenSpec(.rethrows, remapping: .identifier)
    }
  }
}

enum Operator: TokenSpecSet {
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

  var spec: TokenSpec {
    switch self {
    case .binaryOperator: return .binaryOperator
    case .postfixOperator: return .postfixOperator
    case .prefixOperator: return .prefixOperator
    }
  }
}

/// Tokens that can be used in operator declarations
enum OperatorLike: TokenSpecSet {
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

  var spec: TokenSpec {
    switch self {
    case .operator(let op): return op.spec
    case .exclamationMark: return TokenSpec(.exclamationMark, remapping: .postfixOperator)
    case .infixQuestionMark: return TokenSpec(.infixQuestionMark, remapping: .binaryOperator)
    case .postfixQuestionMark: return TokenSpec(.postfixQuestionMark, remapping: .postfixOperator)
    case .equal: return TokenSpec(.equal, remapping: .binaryOperator)
    case .arrow: return TokenSpec(.arrow, remapping: .binaryOperator)
    case .regexLiteral: return TokenSpec(.regexLiteral, remapping: .binaryOperator, recoveryPrecedence: TokenPrecedence(nonKeyword: .binaryOperator))
    }
  }
}

enum PoundDeclarationStart: TokenSpecSet {
  case poundIfKeyword
  case pound

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.rawTokenKind {
    case .poundIfKeyword: self = .poundIfKeyword
    case .pound: self = .pound
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .poundIfKeyword: return .poundIfKeyword
    case .pound: return .pound
    }
  }
}

enum SwitchCaseStart: TokenSpecSet {
  case caseKeyword
  case defaultKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.case): self = .caseKeyword
    case TokenSpec(.default): self = .defaultKeyword
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .caseKeyword: return .keyword(.case)
    case .defaultKeyword: return .keyword(.default)
    }
  }
}

public enum TypeSpecifier: TokenSpecSet {
  case inoutKeyword
  case owned
  case shared

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.inout): self = .inoutKeyword
    case TokenSpec(.__owned): self = .owned
    case TokenSpec(.__shared): self = .shared
    default: return nil
    }
  }

  public init?(token: TokenSyntax) {
    switch token {
    case TokenSpec(.inout): self = .inoutKeyword
    case TokenSpec(.__owned): self = .owned
    case TokenSpec(.__shared): self = .shared
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .inoutKeyword: return .keyword(.inout)
    case .owned: return .keyword(.__owned)
    case .shared: return .keyword(.__shared)
    }
  }
}

// MARK: Expression start

enum AwaitTryMove: TokenSpecSet {
  case awaitKeyword
  case _moveKeyword
  case _borrowKeyword
  case tryKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.await): self = .awaitKeyword
    case TokenSpec(._move): self = ._moveKeyword
    case TokenSpec(._borrow): self = ._borrowKeyword
    case TokenSpec(.try): self = .tryKeyword
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .awaitKeyword: return .keyword(.await)
    case ._moveKeyword: return .keyword(._move)
    case ._borrowKeyword: return .keyword(._borrow)
    case .tryKeyword: return .keyword(.try)
    }
  }
}

enum IfOrSwitch: TokenSpecSet {
  case ifKeyword
  case switchKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.if): self = .ifKeyword
    case TokenSpec(.switch): self = .switchKeyword
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .ifKeyword: return .keyword(.if)
    case .switchKeyword: return .keyword(.switch)
    }
  }
}

enum ExpressionPrefixOperator: TokenSpecSet {
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

  var spec: TokenSpec {
    switch self {
    case .backslash: return .backslash
    case .prefixAmpersand: return .prefixAmpersand
    case .prefixOperator: return .prefixOperator
    }
  }
}

enum MatchingPatternStart: TokenSpecSet {
  case isKeyword
  case letKeyword
  case varKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.is): self = .isKeyword
    case TokenSpec(.let): self = .letKeyword
    case TokenSpec(.var): self = .varKeyword
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .isKeyword: return .keyword(.is)
    case .letKeyword: return .keyword(.let)
    case .varKeyword: return .keyword(.var)
    }
  }
}

enum ParameterModifier: TokenSpecSet {
  case _const
  case isolated

  init?(lexeme: Lexer.Lexeme) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(._const): self = ._const
    case TokenSpec(.isolated): self = .isolated
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case ._const: return .keyword(._const)
    case .isolated: return .keyword(.isolated)
    }
  }
}

enum PrimaryExpressionStart: TokenSpecSet {
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
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.Any): self = .anyKeyword
    case TokenSpec(.Self): self = .capitalSelfKeyword
    case TokenSpec(.dollarIdentifier): self = .dollarIdentifier
    case TokenSpec(.false): self = .falseKeyword
    case TokenSpec(.floatingLiteral): self = .floatingLiteral
    case TokenSpec(.identifier): self = .identifier
    case TokenSpec(.`init`): self = .initKeyword
    case TokenSpec(.integerLiteral): self = .integerLiteral
    case TokenSpec(.leftBrace): self = .leftBrace
    case TokenSpec(.leftParen): self = .leftParen
    case TokenSpec(.leftSquareBracket): self = .leftSquareBracket
    case TokenSpec(.nil): self = .nilKeyword
    case TokenSpec(.period): self = .period
    case TokenSpec(.pound): self = .pound
    case TokenSpec(.poundAvailableKeyword): self = .poundAvailableKeyword
    case TokenSpec(.poundUnavailableKeyword): self = .poundUnavailableKeyword
    case TokenSpec(.regexLiteral): self = .regexLiteral
    case TokenSpec(.self): self = .selfKeyword
    case TokenSpec(.super): self = .superKeyword
    case TokenSpec(.true): self = .trueKeyword
    case TokenSpec(.wildcard): self = .wildcard
    case TokenSpec(.rawStringDelimiter): self = .rawStringDelimiter
    case TokenSpec(.stringQuote): self = .stringQuote
    case TokenSpec(.multilineStringQuote): self = .multilineStringQuote
    case TokenSpec(.singleQuote): self = .singleQuote
    default: return nil
    }
  }

  var spec: TokenSpec {
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
enum ExpressionStart: TokenSpecSet {
  case awaitTryMove(AwaitTryMove)
  case expressionPrefixOperator(ExpressionPrefixOperator)
  case matchingPatternStart(MatchingPatternStart)
  case primaryExpressionStart(PrimaryExpressionStart)
  case ifOrSwitch(IfOrSwitch)

  init?(lexeme: Lexer.Lexeme) {
    if let subset = AwaitTryMove(lexeme: lexeme) {
      self = .awaitTryMove(subset)
    } else if let subset = ExpressionPrefixOperator(lexeme: lexeme) {
      self = .expressionPrefixOperator(subset)
    } else if let subset = MatchingPatternStart(lexeme: lexeme) {
      self = .matchingPatternStart(subset)
    } else if let subset = PrimaryExpressionStart(lexeme: lexeme) {
      self = .primaryExpressionStart(subset)
    } else if let subset = IfOrSwitch(lexeme: lexeme) {
      self = .ifOrSwitch(subset)
    } else {
      return nil
    }
  }

  static var allCases: [ExpressionStart] {
    return AwaitTryMove.allCases.map(Self.awaitTryMove)
      + ExpressionPrefixOperator.allCases.map(Self.expressionPrefixOperator)
      + MatchingPatternStart.allCases.map(Self.matchingPatternStart)
      + PrimaryExpressionStart.allCases.map(Self.primaryExpressionStart)
      + IfOrSwitch.allCases.map(Self.ifOrSwitch)
  }

  var spec: TokenSpec {
    switch self {
    case .awaitTryMove(let underlyingKind): return underlyingKind.spec
    case .expressionPrefixOperator(let underlyingKind): return underlyingKind.spec
    case .matchingPatternStart(let underlyingKind): return underlyingKind.spec
    case .primaryExpressionStart(let underlyingKind): return underlyingKind.spec
    case .ifOrSwitch(let underlyingKind): return underlyingKind.spec
    }
  }
}
