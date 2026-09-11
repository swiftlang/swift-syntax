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

#if compiler(>=6)
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) internal import SwiftSyntax
#else
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
#endif

/// A set of `TokenSpecs`. We expect to consume one of the sets specs in the
/// parser.
protocol TokenSpecSet: CaseIterable {
  var spec: TokenSpec { get }

  /// Creates an instance if `lexeme` satisfies the condition of this subset,
  /// taking into account any `languageFeatures` active.
  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures)
}

/// A way to combine two token spec sets into an aggregate token spec set.
enum EitherTokenSpecSet<LHS: TokenSpecSet, RHS: TokenSpecSet>: TokenSpecSet {
  case lhs(LHS)
  case rhs(RHS)

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    if let x = LHS(lexeme: lexeme, languageFeatures: languageFeatures) {
      self = .lhs(x)
      return
    }
    if let y = RHS(lexeme: lexeme, languageFeatures: languageFeatures) {
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
  case yielding

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    let keyword = lexeme.keyword
    switch keyword {
    case .__consuming: self = .__consuming
    case .consuming: self = .consuming
    case .borrowing: self = .borrowing
    case .mutating: self = .mutating
    case .nonmutating: self = .nonmutating
    case .yielding: self = .yielding
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
    case .yielding: return .keyword(.yielding)
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    guard let keyword = lexeme.keyword else { return nil }
    switch keyword {
    case .break: self = .break
    case .continue: self = .continue
    case .defer: self = .defer
    case .do: self = .do
    case .fallthrough: self = .fallthrough
    case .for: self = .for
    case .discard: self = .discard
    case .guard: self = .guard
    case .if: self = .if
    case .repeat: self = .repeat
    case .return: self = .return
    case .switch: self = .switch
    case .then where languageFeatures.contains(.thenStatements): self = .then
    case .throw: self = .throw
    case .while: self = .while
    case .yield: self = .yield
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    let keyword = lexeme.keyword
    switch keyword {
    case .swift: self = .swift
    case .compiler: self = .compiler
    case .canImport: self = .canImport
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    switch lexeme.keyword {
    case .__consuming: self = .__consuming
    case ._compilerInitialized: self = ._compilerInitialized
    case ._const: self = ._const
    case ._local: self = ._local
    case .actor: self = .actor
    case .async: self = .async
    case .convenience: self = .convenience
    case .distributed: self = .distributed
    case .dynamic: self = .dynamic
    case .final: self = .final
    case .indirect: self = .indirect
    case .infix: self = .infix
    case .isolated: self = .isolated
    case .lazy: self = .lazy
    case .mutating: self = .mutating
    case .nonisolated: self = .nonisolated
    case .nonmutating: self = .nonmutating
    case .package: self = .package
    case .open: self = .open
    case .optional: self = .optional
    case .override: self = .override
    case .postfix: self = .postfix
    case .prefix: self = .prefix
    case .required: self = .required
    case .unowned: self = .unowned
    case .weak: self = .weak
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

/// A `DeclarationKeyword` that is not a `VariableDeclSyntax.BindingSpecifierOptions`.
///
/// `VariableDeclSyntax.BindingSpecifierOptions` are injected into
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
  case using

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    func token() -> Self? {
      // `pound` is a token kind rather than a keyword.
      return switch lexeme.rawTokenKind {
      case .pound: .pound
      default: nil
      }
    }

    func keyword() -> Self? {
      guard let keyword = lexeme.keyword else {
        return nil
      }
      return switch keyword {
      case .actor: .actor
      case .macro: .macro
      case .associatedtype: .associatedtype
      case .case: .case
      case .class: .class
      case .deinit: .deinit
      case .enum: .enum
      case .extension: .extension
      case .func: .func
      case .import: .import
      case .`init`: .`init`
      case .operator: .operator
      case .precedencegroup: .precedencegroup
      case .protocol: .protocol
      case .struct: .struct
      case .subscript: .subscript
      case .typealias: .typealias
      case .using where languageFeatures.contains(.defaultIsolationPerFile): .using
      default: nil
      }
    }

    guard let match = token() ?? keyword() else {
      return nil
    }
    self = match
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
    case .using: return TokenSpec(.using)
    }
  }
}

typealias DeclarationKeyword = EitherTokenSpecSet<
  PureDeclarationKeyword,
  VariableDeclSyntax.BindingSpecifierOptions
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
  case sending
  case `static`
  case unowned
  case weak

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    switch lexeme.keyword {
    case .__consuming: self = .__consuming
    case .__setter_access: self = .__setter_access
    case ._const: self = ._const
    case ._local: self = ._local
    case .async: self = .async
    case .borrowing: self = .borrowing
    case .class: self = .class
    case .consuming: self = .consuming
    case .convenience: self = .convenience
    case .distributed: self = .distributed
    case .dynamic: self = .dynamic
    case .fileprivate: self = .fileprivate
    case .final: self = .final
    case .indirect: self = .indirect
    case .infix: self = .infix
    case .internal: self = .internal
    case .isolated: self = .isolated
    case .lazy: self = .lazy
    case .mutating: self = .mutating
    case .nonisolated: self = .nonisolated
    case .nonmutating: self = .nonmutating
    case .open: self = .open
    case .optional: self = .optional
    case .override: self = .override
    case .package: self = .package
    case .postfix: self = .postfix
    case .prefix: self = .prefix
    case .private: self = .private
    case .public: self = .public
    case .reasync: self = .reasync
    case .required: self = .required
    case .rethrows: self = .rethrows
    case .static: self = .static
    case .sending: self = .sending
    case .unowned: self = .unowned
    case .weak: self = .weak
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
    case .sending: return .keyword(.sending)
    case .unowned: return TokenSpec(.unowned, recoveryPrecedence: .declKeyword)
    case .weak: return TokenSpec(.weak, recoveryPrecedence: .declKeyword)
    }
  }
}

/// Union of the following token kind subsets:
///  - `DeclarationModifier`
///  - `DeclarationKeyword`
enum DeclarationStart: TokenSpecSet {
  case declarationModifier(DeclarationModifier)
  case declarationKeyword(DeclarationKeyword)

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    if let subset = DeclarationModifier(lexeme: lexeme, languageFeatures: languageFeatures) {
      self = .declarationModifier(subset)
    } else if let subset = DeclarationKeyword(lexeme: lexeme, languageFeatures: languageFeatures) {
      self = .declarationKeyword(subset)
    } else {
      return nil
    }
  }

  static var allCases: [DeclarationStart] {
    return DeclarationModifier.allCases.map(Self.declarationModifier)
      + DeclarationKeyword.allCases.map(Self.declarationKeyword)
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    if case .prefixOperator = lexeme.rawTokenKind {
      self = .prefixOperator
    } else if let binOp = BinaryOperatorLike(lexeme: lexeme, languageFeatures: languageFeatures) {
      self = .binaryOperatorLike(binOp)
    } else if let postfixOp = PostfixOperatorLike(lexeme: lexeme, languageFeatures: languageFeatures) {
      self = .postfixOperatorLike(postfixOp)
    } else {
      return nil
    }
  }

  static var allCases: [OperatorLike] {
    [.prefixOperator] + BinaryOperatorLike.allCases.map(Self.binaryOperatorLike)
      + PostfixOperatorLike.allCases.map(Self.postfixOperatorLike)
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    let keyword = lexeme.keyword
    switch keyword {
    case .case: self = .case
    case .default: self = .default
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    let keyword = lexeme.keyword
    switch keyword {
    case ._local: self = ._local
    case ._noMetadata: self = ._noMetadata
    case ._opaqueReturnTypeOf: self = ._opaqueReturnTypeOf
    case .async: self = .async
    case .autoclosure: self = .autoclosure
    case .convention: self = .convention
    case .differentiable: self = .differentiable
    case .escaping: self = .escaping
    case .noDerivative: self = .noDerivative
    case .noescape: self = .noescape
    case .preconcurrency: self = .preconcurrency
    case .Sendable: self = .Sendable
    case .retroactive: self = .retroactive
    case .unchecked: self = .unchecked
    case .isolated: self = .isolated
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
  case borrow
  case consume
  case copy
  case `repeat`
  case each
  case any
  case unsafe

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    guard let keyword = lexeme.keyword else { return nil }
    switch keyword {
    case .await: self = .await
    case ._move where languageFeatures.contains(.oldOwnershipOperatorSpellings): self = ._move
    case ._borrow where languageFeatures.contains(.oldOwnershipOperatorSpellings): self = ._borrow
    case .try: self = .try
    case .borrow: self = .borrow
    case .consume: self = .consume
    case .copy: self = .copy
    case .repeat: self = .repeat
    case .each: self = .each
    case .any: self = .any
    case .unsafe: self = .unsafe
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .await: return .keyword(.await)
    case ._move: return .keyword(._move)
    case ._borrow: return .keyword(._borrow)
    case .borrow: return .keyword(.borrow)
    case .consume: return .keyword(.consume)
    case .copy: return .keyword(.copy)
    case .try: return .keyword(.try)
    case .repeat: return .keyword(.repeat)
    case .each: return .keyword(.each)
    case .any: return .keyword(.any)
    case .unsafe: return .keyword(.unsafe)
    }
  }
}

enum SingleValueStatementExpression: TokenSpecSet {
  case `do`
  case `if`
  case `switch`

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    let keyword = lexeme.keyword
    switch keyword {
    case .do where languageFeatures.contains(.doExpressions): self = .do
    case .if: self = .if
    case .switch: self = .switch
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    let keyword = lexeme.keyword
    switch keyword {
    case .is: self = .is
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    let keyword = lexeme.keyword
    switch keyword {
    case ._const: self = ._const
    case .isolated: self = .isolated
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
  case colonColon
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    func token() -> Self? {
      return switch lexeme.rawTokenKind {
      case .atSign: .atSign
      case .colonColon: .colonColon
      case .dollarIdentifier: .dollarIdentifier
      case .floatLiteral: .floatLiteral
      case .identifier: .identifier
      case .integerLiteral: .integerLiteral
      case .leftBrace: .leftBrace
      case .leftParen: .leftParen
      case .leftSquare: .leftSquare
      case .period: .period
      case .pound: .pound
      case .poundAvailable: .poundAvailable
      case .poundUnavailable: .poundUnavailable
      case .regexSlash: .regexSlash
      case .regexPoundDelimiter: .extendedRegexDelimiter
      case .wildcard: .wildcard
      case .rawStringPoundDelimiter: .rawStringDelimiter
      case .stringQuote: .stringQuote
      case .multilineStringQuote: .multilineStringQuote
      case .singleQuote: .singleQuote
      default: nil
      }
    }

    func keyword() -> Self? {
      guard let keyword = lexeme.keyword else {
        return nil
      }
      return switch keyword {
      case .Any: .Any
      case .Self: .Self
      case .deinit: .`deinit`
      case .false: .false
      case .`init`: .`init`
      case .nil: .nil
      case .self: .self
      case .subscript: .`subscript`
      case .super: .super
      case .true: .true
      default: nil
      }
    }

    guard let match = token() ?? keyword() else {
      return nil
    }
    self = match
  }

  var spec: TokenSpec {
    switch self {
    case .Any: return .keyword(.Any)
    case .atSign: return .atSign
    case .Self: return .keyword(.Self)
    case .colonColon: return .colonColon
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    if let subset = ExpressionModifierKeyword(lexeme: lexeme, languageFeatures: languageFeatures) {
      self = .awaitTryMove(subset)
    } else if let subset = ExpressionPrefixOperator(lexeme: lexeme, languageFeatures: languageFeatures) {
      self = .expressionPrefixOperator(subset)
    } else if let subset = PrimaryExpressionStart(lexeme: lexeme, languageFeatures: languageFeatures) {
      self = .primaryExpressionStart(subset)
    } else if let subset = SingleValueStatementExpression(lexeme: lexeme, languageFeatures: languageFeatures) {
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

  init?(lexeme: Lexer.Lexeme, languageFeatures: Parser.LanguageFeatures) {
    let atStartOfLine = lexeme.isAtStartOfLine
    let keyword = lexeme.keyword
    switch keyword {
    case .async: self = .async
    case .await where !atStartOfLine: self = .await
    case .reasync: self = .reasync
    case .rethrows: self = .rethrows
    case .throw where !atStartOfLine: self = .throw
    case .throws: self = .throws
    case .try where !atStartOfLine: self = .try
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
