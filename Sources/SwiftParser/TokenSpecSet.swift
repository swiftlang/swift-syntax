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
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) public import SwiftSyntax
#else
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
#endif

/// A set of `TokenSpecs`. We expect to consume one of the sets specs in the
/// parser.
protocol TokenSpecSet: CaseIterable {
  var spec: TokenSpec { get }

  /// Creates an instance if `lexeme` satisfies the condition of this subset,
  /// taking into account any `experimentalFeatures` active.
  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures)
}

/// A way to combine two token spec sets into an aggregate token spec set.
enum EitherTokenSpecSet<LHS: TokenSpecSet, RHS: TokenSpecSet>: TokenSpecSet {
  case lhs(LHS)
  case rhs(RHS)

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    if let x = LHS(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .lhs(x)
      return
    }
    if let y = RHS(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .rhs(y)
      return
    }

    return nil
  }

  var spec: TokenSpec {
    switch self {
    case .lhs(let x):
      return x.spec
    case .rhs(let y):
      return y.spec
    }
  }

  static var allCases: [EitherTokenSpecSet] {
    return LHS.allCases.map(Self.lhs) + RHS.allCases.map(Self.rhs)
  }
}

// MARK: - Subsets

enum AccessorModifier: TokenSpecSet {
  case __consuming
  case consuming
  case borrowing
  case mutating
  case nonmutating

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.__consuming): self = .__consuming
    case TokenSpec(.consuming): self = .consuming
    case TokenSpec(.borrowing): self = .borrowing
    case TokenSpec(.mutating): self = .mutating
    case TokenSpec(.nonmutating): self = .nonmutating
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .__consuming: return .keyword(.__consuming)
    case .consuming: return .keyword(.consuming)
    case .borrowing: return .keyword(.borrowing)
    case .mutating: return .keyword(.mutating)
    case .nonmutating: return .keyword(.nonmutating)
    }
  }
}

enum CanBeStatementStart: TokenSpecSet {
  case `break`
  case `continue`
  case `defer`
  case `do`
  case `fallthrough`
  case `for`
  case discard
  case `guard`
  case `if`
  case `repeat`
  case `return`
  case `switch`
  case then
  case `throw`
  case `while`
  case yield

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.break): self = .break
    case TokenSpec(.continue): self = .continue
    case TokenSpec(.defer): self = .defer
    case TokenSpec(.do): self = .do
    case TokenSpec(.fallthrough): self = .fallthrough
    case TokenSpec(.for): self = .for
    case TokenSpec(.discard): self = .discard
    case TokenSpec(.guard): self = .guard
    case TokenSpec(.if): self = .if
    case TokenSpec(.repeat): self = .repeat
    case TokenSpec(.return): self = .return
    case TokenSpec(.switch): self = .switch
    case TokenSpec(.then): self = .then
    case TokenSpec(.throw): self = .throw
    case TokenSpec(.while): self = .while
    case TokenSpec(.yield): self = .yield
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .break: return .keyword(.break)
    case .continue: return .keyword(.continue)
    case .defer: return .keyword(.defer)
    case .do: return .keyword(.do)
    case .fallthrough: return .keyword(.fallthrough)
    case .for: return .keyword(.for)
    case .discard: return TokenSpec(.discard, recoveryPrecedence: .stmtKeyword)
    case .guard: return .keyword(.guard)
    case .if: return .keyword(.if)
    case .repeat: return .keyword(.repeat)
    case .return: return .keyword(.return)
    case .switch: return .keyword(.switch)
    case .then: return .keyword(.then)
    case .throw: return .keyword(.throw)
    case .while: return .keyword(.while)
    case .yield: return .keyword(.yield)
    }
  }
}

enum CompilationCondition: TokenSpecSet {
  case swift
  case compiler
  case canImport

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.swift): self = .swift
    case TokenSpec(.compiler): self = .compiler
    case TokenSpec(.canImport): self = .canImport
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .swift: return .keyword(.swift)
    case .compiler: return .keyword(.compiler)
    case .canImport: return .keyword(.canImport)
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

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

/// A `DeclarationKeyword` that is not a `ValueBindingPatternSyntax.BindingSpecifierOptions`.
///
/// `ValueBindingPatternSyntax.BindingSpecifierOptions` are injected into
/// `DeclarationKeyword` via an `EitherTokenSpecSet`.
enum PureDeclarationKeyword: TokenSpecSet {
  case actor
  case `associatedtype`
  case `case`
  case `class`
  case `deinit`
  case `enum`
  case `extension`
  case `func`
  case `import`
  case `init`
  case macro
  case `operator`
  case `precedencegroup`
  case `protocol`
  case `struct`
  case `subscript`
  case `typealias`
  case pound

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.actor): self = .actor
    case TokenSpec(.macro): self = .macro
    case TokenSpec(.associatedtype): self = .associatedtype
    case TokenSpec(.case): self = .case
    case TokenSpec(.class): self = .class
    case TokenSpec(.deinit): self = .deinit
    case TokenSpec(.enum): self = .enum
    case TokenSpec(.extension): self = .extension
    case TokenSpec(.func): self = .func
    case TokenSpec(.import): self = .import
    case TokenSpec(.`init`): self = .`init`
    case TokenSpec(.operator): self = .operator
    case TokenSpec(.precedencegroup): self = .precedencegroup
    case TokenSpec(.protocol): self = .protocol
    case TokenSpec(.struct): self = .struct
    case TokenSpec(.subscript): self = .subscript
    case TokenSpec(.typealias): self = .typealias
    case TokenSpec(.pound): self = .pound
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .actor: return TokenSpec(.actor, recoveryPrecedence: .declKeyword)
    case .associatedtype: return .keyword(.associatedtype)
    case .case: return TokenSpec(.case, recoveryPrecedence: .declKeyword)
    case .class: return .keyword(.class)
    case .deinit: return .keyword(.deinit)
    case .enum: return .keyword(.enum)
    case .extension: return .keyword(.extension)
    case .func: return .keyword(.func)
    case .import: return .keyword(.import)
    case .`init`: return .keyword(.`init`)
    case .macro: return TokenSpec(.macro, recoveryPrecedence: .declKeyword)
    case .operator: return .keyword(.operator)
    case .precedencegroup: return .keyword(.precedencegroup)
    case .protocol: return .keyword(.protocol)
    case .struct: return .keyword(.struct)
    case .subscript: return .keyword(.subscript)
    case .typealias: return .keyword(.typealias)
    case .pound: return TokenSpec(.pound, recoveryPrecedence: .openingPoundIf)
    }
  }
}

typealias DeclarationKeyword = EitherTokenSpecSet<
  PureDeclarationKeyword,
  ValueBindingPatternSyntax.BindingSpecifierOptions
>

enum DeclarationModifier: TokenSpecSet {
  case __consuming
  case __setter_access
  case _const
  case _local
  case async
  case borrowing
  case `class`
  case consuming
  case convenience
  case distributed
  case dynamic
  case `fileprivate`
  case final
  case indirect
  case infix
  case `internal`
  case isolated
  case lazy
  case mutating
  case nonisolated
  case nonmutating
  case open
  case optional
  case override
  case package
  case postfix
  case prefix
  case `private`
  case `public`
  case reasync
  case required
  case `rethrows`
  case `static`
  case transferring
  case unowned
  case weak
  case _resultDependsOn
  case _resultDependsOnSelf

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.__consuming): self = .__consuming
    case TokenSpec(.__setter_access): self = .__setter_access
    case TokenSpec(._const): self = ._const
    case TokenSpec(._local): self = ._local
    case TokenSpec(.async): self = .async
    case TokenSpec(.borrowing): self = .borrowing
    case TokenSpec(.class): self = .class
    case TokenSpec(.consuming): self = .consuming
    case TokenSpec(.convenience): self = .convenience
    case TokenSpec(.distributed): self = .distributed
    case TokenSpec(.dynamic): self = .dynamic
    case TokenSpec(.fileprivate): self = .fileprivate
    case TokenSpec(.final): self = .final
    case TokenSpec(.indirect): self = .indirect
    case TokenSpec(.infix): self = .infix
    case TokenSpec(.internal): self = .internal
    case TokenSpec(.isolated): self = .isolated
    case TokenSpec(.lazy): self = .lazy
    case TokenSpec(.mutating): self = .mutating
    case TokenSpec(.nonisolated): self = .nonisolated
    case TokenSpec(.nonmutating): self = .nonmutating
    case TokenSpec(.open): self = .open
    case TokenSpec(.optional): self = .optional
    case TokenSpec(.override): self = .override
    case TokenSpec(.package): self = .package
    case TokenSpec(.postfix): self = .postfix
    case TokenSpec(.prefix): self = .prefix
    case TokenSpec(.private): self = .private
    case TokenSpec(.public): self = .public
    case TokenSpec(.reasync): self = .reasync
    case TokenSpec(.required): self = .required
    case TokenSpec(.rethrows): self = .rethrows
    case TokenSpec(.static): self = .static
    case TokenSpec(.transferring): self = .transferring
    case TokenSpec(.unowned): self = .unowned
    case TokenSpec(.weak): self = .weak
    case TokenSpec(._resultDependsOn) where experimentalFeatures.contains(.nonescapableTypes): self = ._resultDependsOn
    case TokenSpec(._resultDependsOnSelf) where experimentalFeatures.contains(.nonescapableTypes): self = ._resultDependsOnSelf
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .__consuming: return .keyword(.__consuming)
    case .__setter_access: return .keyword(.__setter_access)
    case ._const: return TokenSpec(._const, recoveryPrecedence: .declKeyword)
    case ._local: return .keyword(._local)
    case .async: return TokenSpec(.async, recoveryPrecedence: .declKeyword)
    case .borrowing: return TokenSpec(.borrowing, recoveryPrecedence: .declKeyword)
    case .class: return .keyword(.class)
    case .consuming: return TokenSpec(.consuming, recoveryPrecedence: .declKeyword)
    case .convenience: return .keyword(.convenience)
    case .distributed: return .keyword(.distributed)
    case .dynamic: return .keyword(.dynamic)
    case .fileprivate: return .keyword(.fileprivate)
    case .final: return .keyword(.final)
    case .indirect: return .keyword(.indirect)
    case .infix: return .keyword(.infix)
    case .internal: return .keyword(.internal)
    case .isolated: return TokenSpec(.isolated, recoveryPrecedence: .declKeyword)
    case .lazy: return .keyword(.lazy)
    case .mutating: return .keyword(.mutating)
    case .nonisolated: return .keyword(.nonisolated)
    case .nonmutating: return .keyword(.nonmutating)
    case .open: return .keyword(.open)
    case .optional: return .keyword(.optional)
    case .override: return .keyword(.override)
    case .package: return .keyword(.package)
    case .postfix: return .keyword(.postfix)
    case .prefix: return .keyword(.prefix)
    case .private: return .keyword(.private)
    case .public: return .keyword(.public)
    case .reasync: return TokenSpec(.reasync, recoveryPrecedence: .declKeyword)
    case .required: return .keyword(.required)
    case .rethrows: return TokenSpec(.rethrows, recoveryPrecedence: .declKeyword)
    case .static: return .keyword(.static)
    case .transferring: return .keyword(.transferring)
    case .unowned: return TokenSpec(.unowned, recoveryPrecedence: .declKeyword)
    case .weak: return TokenSpec(.weak, recoveryPrecedence: .declKeyword)
    case ._resultDependsOn: return TokenSpec(._resultDependsOn, recoveryPrecedence: .declKeyword)
    case ._resultDependsOnSelf: return TokenSpec(._resultDependsOnSelf, recoveryPrecedence: .declKeyword)
    }
  }
}

/// Union of the following token kind subsets:
///  - `DeclarationModifier`
///  - `DeclarationKeyword`
enum DeclarationStart: TokenSpecSet {
  case declarationModifier(DeclarationModifier)
  case declarationKeyword(DeclarationKeyword)

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    if let subset = DeclarationModifier(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .declarationModifier(subset)
    } else if let subset = DeclarationKeyword(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .declarationKeyword(subset)
    } else {
      return nil
    }
  }

  static var allCases: [DeclarationStart] {
    return DeclarationModifier.allCases.map(Self.declarationModifier) + DeclarationKeyword.allCases.map(Self.declarationKeyword)
  }

  var spec: TokenSpec {
    switch self {
    case .declarationModifier(let underlyingKind): return underlyingKind.spec
    case .declarationKeyword(let underlyingKind): return underlyingKind.spec
    }
  }
}

enum Operator: TokenSpecSet {
  case binaryOperator
  case postfixOperator
  case prefixOperator

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    // NOTE: If you ever add any experimental features here,
    // `isContextualPunctuator` will need updating to handle that.
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

/// Tokens that are either binary operators, or can act like binary operators.
enum BinaryOperatorLike: TokenSpecSet {
  case binaryOperator
  case infixQuestionMark
  case equal
  case arrow

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch lexeme.rawTokenKind {
    case .binaryOperator: self = .binaryOperator
    case .infixQuestionMark: self = .infixQuestionMark
    case .equal: self = .equal
    case .arrow: self = .arrow
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .binaryOperator: return .binaryOperator
    case .infixQuestionMark: return TokenSpec(.infixQuestionMark, remapping: .binaryOperator)
    case .equal: return TokenSpec(.equal, remapping: .binaryOperator)
    case .arrow: return TokenSpec(.arrow, remapping: .binaryOperator)
    }
  }
}

/// Tokens that are either postfix operators, or can act like postfix operators.
enum PostfixOperatorLike: TokenSpecSet {
  case postfixOperator
  case exclamationMark
  case postfixQuestionMark

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch lexeme.rawTokenKind {
    case .postfixOperator: self = .postfixOperator
    case .exclamationMark: self = .exclamationMark
    case .postfixQuestionMark: self = .postfixQuestionMark
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .postfixOperator: return .postfixOperator
    case .exclamationMark: return TokenSpec(.exclamationMark, remapping: .postfixOperator)
    case .postfixQuestionMark: return TokenSpec(.postfixQuestionMark, remapping: .postfixOperator)
    }
  }
}

/// Tokens that can be used in operator declarations.
enum OperatorLike: TokenSpecSet {
  case prefixOperator
  case binaryOperatorLike(BinaryOperatorLike)
  case postfixOperatorLike(PostfixOperatorLike)

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    if case .prefixOperator = lexeme.rawTokenKind {
      self = .prefixOperator
      return
    }
    if let binOp = BinaryOperatorLike(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .binaryOperatorLike(binOp)
      return
    }
    if let postfixOp = PostfixOperatorLike(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .postfixOperatorLike(postfixOp)
      return
    }
    return nil
  }

  static var allCases: [OperatorLike] {
    [.prefixOperator] + BinaryOperatorLike.allCases.map(Self.binaryOperatorLike) + PostfixOperatorLike.allCases.map(Self.postfixOperatorLike)
  }

  var spec: TokenSpec {
    switch self {
    case .prefixOperator: return .prefixOperator
    case .binaryOperatorLike(let op): return op.spec
    case .postfixOperatorLike(let op): return op.spec
    }
  }
}

enum SwitchCaseStart: TokenSpecSet {
  case `case`
  case `default`

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.case): self = .case
    case TokenSpec(.default): self = .default
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .case: return .keyword(.case)
    case .default: return .keyword(.default)
    }
  }
}

enum TypeAttribute: TokenSpecSet {
  case _local
  case _noMetadata
  case _opaqueReturnTypeOf
  case async
  case autoclosure
  case convention
  case differentiable
  case escaping
  case noDerivative
  case noescape
  case preconcurrency
  case retroactive
  case Sendable
  case unchecked
  case isolated

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(._local): self = ._local
    case TokenSpec(._noMetadata): self = ._noMetadata
    case TokenSpec(._opaqueReturnTypeOf): self = ._opaqueReturnTypeOf
    case TokenSpec(.async): self = .async
    case TokenSpec(.autoclosure): self = .autoclosure
    case TokenSpec(.convention): self = .convention
    case TokenSpec(.differentiable): self = .differentiable
    case TokenSpec(.escaping): self = .escaping
    case TokenSpec(.noDerivative): self = .noDerivative
    case TokenSpec(.noescape): self = .noescape
    case TokenSpec(.preconcurrency): self = .preconcurrency
    case TokenSpec(.Sendable): self = .Sendable
    case TokenSpec(.retroactive): self = .retroactive
    case TokenSpec(.unchecked): self = .unchecked
    case TokenSpec(.isolated): self = .isolated
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case ._local: return .keyword(._local)
    case ._noMetadata: return .keyword(._noMetadata)
    case ._opaqueReturnTypeOf: return .keyword(._opaqueReturnTypeOf)
    case .async: return .keyword(.async)
    case .autoclosure: return .keyword(.autoclosure)
    case .convention: return .keyword(.convention)
    case .differentiable: return .keyword(.differentiable)
    case .escaping: return .keyword(.escaping)
    case .noDerivative: return .keyword(.noDerivative)
    case .noescape: return .keyword(.noescape)
    case .preconcurrency: return .keyword(.preconcurrency)
    case .retroactive: return .keyword(.retroactive)
    case .Sendable: return .keyword(.Sendable)
    case .unchecked: return .keyword(.unchecked)
    case .isolated: return .keyword(.isolated)
    }
  }
}

// MARK: Expression start

enum ExpressionModifierKeyword: TokenSpecSet {
  case await
  case _move
  case _borrow
  case `try`
  case consume
  case copy
  case `repeat`
  case each
  case any

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.await): self = .await
    case TokenSpec(._move): self = ._move
    case TokenSpec(._borrow): self = ._borrow
    case TokenSpec(.try): self = .try
    case TokenSpec(.consume): self = .consume
    case TokenSpec(.copy): self = .copy
    case TokenSpec(.repeat): self = .repeat
    case TokenSpec(.each): self = .each
    case TokenSpec(.any): self = .any
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .await: return .keyword(.await)
    case ._move: return .keyword(._move)
    case ._borrow: return .keyword(._borrow)
    case .consume: return .keyword(.consume)
    case .copy: return .keyword(.copy)
    case .try: return .keyword(.try)
    case .repeat: return .keyword(.repeat)
    case .each: return .keyword(.each)
    case .any: return .keyword(.any)
    }
  }
}

enum SingleValueStatementExpression: TokenSpecSet {
  case `do`
  case `if`
  case `switch`

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.do) where experimentalFeatures.contains(.doExpressions): self = .do
    case TokenSpec(.if): self = .if
    case TokenSpec(.switch): self = .switch
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .do: return .keyword(.do)
    case .if: return .keyword(.if)
    case .switch: return .keyword(.switch)
    }
  }
}

enum ExpressionPrefixOperator: TokenSpecSet {
  case backslash
  case prefixAmpersand
  case prefixOperator

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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

/// A `MatchingPatternStart` that is not a `ValueBindingPatternSyntax.BindingSpecifierOptions`.
///
/// We use an `EitherTokenSpecSet` to inject `ValueBindingPatternSyntax.BindingSpecifierOptions` into
/// `MatchingPatternStart`.
enum PureMatchingPatternStart: TokenSpecSet {
  case `is`

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.is): self = .is
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .is: return .keyword(.is)
    }
  }
}

typealias MatchingPatternStart = EitherTokenSpecSet<
  PureMatchingPatternStart,
  ValueBindingPatternSyntax.BindingSpecifierOptions
>

enum ParameterModifier: TokenSpecSet {
  case _const
  case isolated

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
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
  case `Any`
  case atSign  // For recovery
  case `Self`
  case `deinit`
  case dollarIdentifier
  case `false`
  case floatLiteral
  case identifier
  case `init`
  case integerLiteral
  case leftBrace
  case leftParen
  case leftSquare
  case `nil`
  case period
  case pound
  case poundAvailable  // For recovery
  case poundUnavailable  // For recovery
  case regexSlash
  case extendedRegexDelimiter
  case `self`
  case `subscript`
  case `super`
  case `true`
  case wildcard
  case rawStringDelimiter
  case stringQuote
  case multilineStringQuote
  case singleQuote

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.Any): self = .Any
    case TokenSpec(.atSign): self = .atSign
    case TokenSpec(.Self): self = .Self
    case TokenSpec(.deinit): self = .`deinit`
    case TokenSpec(.dollarIdentifier): self = .dollarIdentifier
    case TokenSpec(.false): self = .false
    case TokenSpec(.floatLiteral): self = .floatLiteral
    case TokenSpec(.identifier): self = .identifier
    case TokenSpec(.`init`): self = .`init`
    case TokenSpec(.integerLiteral): self = .integerLiteral
    case TokenSpec(.leftBrace): self = .leftBrace
    case TokenSpec(.leftParen): self = .leftParen
    case TokenSpec(.leftSquare): self = .leftSquare
    case TokenSpec(.nil): self = .nil
    case TokenSpec(.period): self = .period
    case TokenSpec(.pound): self = .pound
    case TokenSpec(.poundAvailable): self = .poundAvailable
    case TokenSpec(.poundUnavailable): self = .poundUnavailable
    case TokenSpec(.regexSlash): self = .regexSlash
    case TokenSpec(.regexPoundDelimiter): self = .extendedRegexDelimiter
    case TokenSpec(.self): self = .self
    case TokenSpec(.subscript): self = .`subscript`
    case TokenSpec(.super): self = .super
    case TokenSpec(.true): self = .true
    case TokenSpec(.wildcard): self = .wildcard
    case TokenSpec(.rawStringPoundDelimiter): self = .rawStringDelimiter
    case TokenSpec(.stringQuote): self = .stringQuote
    case TokenSpec(.multilineStringQuote): self = .multilineStringQuote
    case TokenSpec(.singleQuote): self = .singleQuote
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .Any: return .keyword(.Any)
    case .atSign: return .atSign
    case .Self: return .keyword(.Self)
    case .`deinit`: return .keyword(.`deinit`)
    case .dollarIdentifier: return .dollarIdentifier
    case .false: return .keyword(.false)
    case .floatLiteral: return .floatLiteral
    case .identifier: return .identifier
    case .`init`: return .keyword(.`init`)
    case .integerLiteral: return .integerLiteral
    case .leftBrace: return .leftBrace
    case .leftParen: return .leftParen
    case .leftSquare: return .leftSquare
    case .nil: return .keyword(.nil)
    case .period: return .period
    case .pound: return .pound
    case .poundAvailable: return .poundAvailable
    case .poundUnavailable: return .poundUnavailable
    case .regexSlash: return .regexSlash
    case .extendedRegexDelimiter: return .regexPoundDelimiter
    case .self: return .keyword(.self)
    case .`subscript`: return .keyword(.subscript)
    case .super: return .keyword(.super)
    case .true: return .keyword(.true)
    case .wildcard: return .wildcard
    case .rawStringDelimiter: return .rawStringPoundDelimiter
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
  case awaitTryMove(ExpressionModifierKeyword)
  case expressionPrefixOperator(ExpressionPrefixOperator)
  case primaryExpressionStart(PrimaryExpressionStart)
  case singleValueStatement(SingleValueStatementExpression)

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    if let subset = ExpressionModifierKeyword(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .awaitTryMove(subset)
    } else if let subset = ExpressionPrefixOperator(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .expressionPrefixOperator(subset)
    } else if let subset = PrimaryExpressionStart(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .primaryExpressionStart(subset)
    } else if let subset = SingleValueStatementExpression(lexeme: lexeme, experimentalFeatures: experimentalFeatures) {
      self = .singleValueStatement(subset)
    } else {
      return nil
    }
  }

  static var allCases: [ExpressionStart] {
    return ExpressionModifierKeyword.allCases.map(Self.awaitTryMove)
      + ExpressionPrefixOperator.allCases.map(Self.expressionPrefixOperator)
      + PrimaryExpressionStart.allCases.map(Self.primaryExpressionStart)
      + SingleValueStatementExpression.allCases.map(Self.singleValueStatement)
  }

  var spec: TokenSpec {
    switch self {
    case .awaitTryMove(let underlyingKind): return underlyingKind.spec
    case .expressionPrefixOperator(let underlyingKind): return underlyingKind.spec
    case .primaryExpressionStart(let underlyingKind): return underlyingKind.spec
    case .singleValueStatement(let underlyingKind): return underlyingKind.spec
    }
  }
}

enum EffectSpecifiers: TokenSpecSet {
  case async
  case await
  case reasync
  case `rethrows`
  case `throw`
  case `throws`
  case `try`

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch PrepareForKeywordMatch(lexeme) {
    case TokenSpec(.async): self = .async
    case TokenSpec(.await, allowAtStartOfLine: false): self = .await
    case TokenSpec(.reasync): self = .reasync
    case TokenSpec(.rethrows): self = .rethrows
    case TokenSpec(.throw, allowAtStartOfLine: false): self = .throw
    case TokenSpec(.throws): self = .throws
    case TokenSpec(.try, allowAtStartOfLine: false): self = .try
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .async: return .keyword(.async)
    case .await: return TokenSpec(.await, allowAtStartOfLine: false)
    case .reasync: return .keyword(.reasync)
    case .rethrows: return .keyword(.rethrows)
    case .throw: return TokenSpec(.throw, allowAtStartOfLine: false)
    case .throws: return .keyword(.throws)
    case .try: return TokenSpec(.try, allowAtStartOfLine: false)
    }
  }
}
