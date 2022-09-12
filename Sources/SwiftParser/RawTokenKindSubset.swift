//===--- RawTokenKindSubset.swift -----------------------------------------===//
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

  /// If this returns a non-nil value, only tokens with this token text are matched.
  /// Must only return a non-nil value if `rawTokenKind` is `identifier` or `contextualKeyword`.
  var contextualKeyword: SyntaxText? { get }

  /// If not `nil`, the token's will be remapped to this kind when the handle is eaten.
  var remappedKind: RawTokenKind? { get }

  /// The precedence of this token that determines which tokens can be skipped
  /// trying to reach it. If this returns `nil`, the precedence of `rawTokenKind`
  /// is used. This is mostly overwritten for contextual keywords.
  var precedence: TokenPrecedence? { get }

  /// Allows more flexible rejection of further token kinds based on the token's
  /// contents. Useful to e.g. look for contextual keywords.
  func accepts(lexeme: Lexer.Lexeme) -> Bool
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

  func accepts(lexeme: Lexer.Lexeme) -> Bool {
    return true
  }

  static var allRawTokenKinds: [RawTokenKind] {
    return self.allCases.map { $0.rawTokenKind }
  }

  init?(_ lexeme: Lexer.Lexeme) {
    for kind in Self.allCases {
      if let contextualKeyword = kind.contextualKeyword {
        if lexeme.isContextualKeyword(contextualKeyword) && kind.accepts(lexeme: lexeme) {
          assert(kind.rawTokenKind == .identifier || kind.rawTokenKind == .contextualKeyword, "contextualKeyword must only return a non-nil value for tokens of identifer or contextualKeyword kind")
          self = kind
          return
        }
      } else if lexeme.tokenKind == kind.rawTokenKind && kind.accepts(lexeme: lexeme) {
        self = kind
        return
      }
    }
    return nil
  }
}

/// A set of contextual keywords.
/// This should be an enum that has `SyntaxText` as its underlying value.
protocol ContextualKeywords: RawRepresentable, RawTokenKindSubset {}

extension ContextualKeywords where RawValue == SyntaxText {
  var rawTokenKind: RawTokenKind {
    return .identifier
  }

  var contextualKeyword: SyntaxText? {
    return self.rawValue
  }
}

// MARK: - Subsets

enum BinaryOperator: RawTokenKindSubset {
  case spacedBinaryOperator
  case unspacedBinaryOperator

  var rawTokenKind: RawTokenKind {
    switch self {
    case .spacedBinaryOperator: return .spacedBinaryOperator
    case .unspacedBinaryOperator: return .unspacedBinaryOperator
    }
  }
}

enum CanBeDeclaratinStart: RawTokenKindSubset {
  case associatedtypeKeyword
  case atSign
  case caseKeyword
  case classKeyword
  case deinitKeyword
  case enumKeyword
  case extensionKeyword
  case fileprivateKeyword
  case funcKeyword
  case identifier
  case importKeyword
  case initKeyword
  case internalKeyword
  case letKeyword
  case operatorKeyword
  case poundErrorKeyword
  case poundIfKeyword
  case poundLineKeyword
  case poundSourceLocationKeyword
  case poundWarningKeyword
  case precedencegroupKeyword
  case privateKeyword
  case protocolKeyword
  case publicKeyword
  case staticKeyword
  case structKeyword
  case subscriptKeyword
  case typealiasKeyword
  case varKeyword

  var rawTokenKind: RawTokenKind {
    switch self {
    case .associatedtypeKeyword: return .associatedtypeKeyword
    case .atSign: return .atSign
    case .caseKeyword: return .caseKeyword
    case .classKeyword: return .classKeyword
    case .deinitKeyword: return .deinitKeyword
    case .enumKeyword: return .enumKeyword
    case .extensionKeyword: return .extensionKeyword
    case .fileprivateKeyword: return .fileprivateKeyword
    case .funcKeyword: return .funcKeyword
    case .identifier: return .identifier
    case .importKeyword: return .importKeyword
    case .initKeyword: return .initKeyword
    case .internalKeyword: return .internalKeyword
    case .letKeyword: return .letKeyword
    case .operatorKeyword: return .operatorKeyword
    case .poundErrorKeyword: return .poundErrorKeyword
    case .poundIfKeyword: return .poundIfKeyword
    case .poundLineKeyword: return .poundLineKeyword
    case .poundSourceLocationKeyword: return .poundSourceLocationKeyword
    case .poundWarningKeyword: return .poundWarningKeyword
    case .precedencegroupKeyword: return .precedencegroupKeyword
    case .privateKeyword: return .privateKeyword
    case .protocolKeyword: return .protocolKeyword
    case .publicKeyword: return .publicKeyword
    case .staticKeyword: return .staticKeyword
    case .structKeyword: return .structKeyword
    case .subscriptKeyword: return .subscriptKeyword
    case .typealiasKeyword: return .typealiasKeyword
    case .varKeyword: return .varKeyword
    }
  }

  func accepts(lexeme: Lexer.Lexeme) -> Bool {
    switch self {
    case .poundLineKeyword:
      return lexeme.isAtStartOfLine
    default:
      return true
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
  case operatorKeyword
  case precedencegroupKeyword
  case protocolKeyword
  case structKeyword
  case subscriptKeyword
  case typealiasKeyword
  case varKeyword

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
    default: return nil
    }
  }

  var precedence: TokenPrecedence? {
    switch self {
    case .actorContextualKeyword: return .declKeyword
    case .caseKeyword: return .declKeyword
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

  func accepts(lexeme: Lexer.Lexeme) -> Bool {
    switch self {
    // We'll take 'throw' and 'try' too for recovery but they have to be on the
    // same line as the declaration they're modifying.
    case .awaitContextualKeyword, .throwKeyword, .tryKeyword:
      return !lexeme.isAtStartOfLine
    default:
      return true
    }
  }
}

enum IdentifierTokens: RawTokenKindSubset {
  case anyKeyword
  case capitalSelfKeyword
  case identifier
  case selfKeyword

  var rawTokenKind: RawTokenKind {
    switch self {
    case .anyKeyword: return .anyKeyword
    case .capitalSelfKeyword: return .capitalSelfKeyword
    case .identifier: return .identifier
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

  var rawTokenKind: RawTokenKind {
    switch self {
    case .anyKeyword: return .anyKeyword
    case .capitalSelfKeyword: return .capitalSelfKeyword
    case .identifier: return .identifier
    case .selfKeyword: return .selfKeyword
    case .rethrowsKeyword: return .rethrowsKeyword
    }
  }
}

enum Operator: RawTokenKindSubset {
  case spacedBinaryOperator
  case unspacedBinaryOperator
  case postfixOperator
  case prefixOperator

  var rawTokenKind: RawTokenKind {
    switch self {
    case .spacedBinaryOperator: return .spacedBinaryOperator
    case .unspacedBinaryOperator: return .unspacedBinaryOperator
    case .postfixOperator: return .postfixOperator
    case .prefixOperator: return .prefixOperator
    }
  }
}

enum PoundDeclarationStart: RawTokenKindSubset {
  case poundIfKeyword
  case poundWarningKeyword
  case poundErrorKeyword

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

  var rawTokenKind: RawTokenKind {
    switch self {
    case .caseKeyword: return .caseKeyword
    case .defaultKeyword: return .defaultKeyword
    }
  }
}

// MARK: Expression start

enum AwaitTry: RawTokenKindSubset {
  case awaitContextualKeyword
  case tryKeyword

  var rawTokenKind: RawTokenKind {
    switch self {
    case .awaitContextualKeyword: return .identifier
    case .tryKeyword: return .tryKeyword
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .awaitContextualKeyword: return "await"
    default: return nil
    }
  }
}

enum ExpressionPrefixOperator: RawTokenKindSubset {
  case backslash
  case prefixAmpersand
  case prefixOperator

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

  var rawTokenKind: RawTokenKind {
    switch self {
    case .isKeyword: return .isKeyword
    case .letKeyword: return .letKeyword
    case .varKeyword: return .varKeyword
    }
  }
}

enum PrimaryExpressionStart: RawTokenKindSubset {
  case __column__Keyword
  case __dso_handle__Keyword
  case __file__Keyword
  case __function__Keyword
  case __line__Keyword
  case anyKeyword
  case capitalSelfKeyword
  case dollarIdentifier
  case falseKeyword
  case floatingLiteral
  case identifier
  case integerLiteral
  case leftBrace
  case leftParen
  case leftSquareBracket
  case nilKeyword
  case period
  case poundColorLiteralKeyword
  case poundColumnKeyword
  case poundDsohandleKeyword
  case poundFileIDKeyword
  case poundFileKeyword
  case poundFileLiteralKeyword
  case poundFilePathKeyword
  case poundFunctionKeyword
  case poundImageLiteralKeyword
  case poundKeyPathKeyword
  case poundLineKeyword
  case poundSelectorKeyword
  case prefixPeriod
  case regexLiteral
  case selfKeyword
  case stringLiteral
  case superKeyword
  case trueKeyword
  case wildcardKeyword

  var rawTokenKind: SwiftSyntax.RawTokenKind {
    switch self {
    case .__column__Keyword: return .__column__Keyword
    case .__dso_handle__Keyword: return .__dso_handle__Keyword
    case .__file__Keyword: return .__file__Keyword
    case .__function__Keyword: return .__function__Keyword
    case .__line__Keyword: return .__line__Keyword
    case .anyKeyword: return .anyKeyword
    case .capitalSelfKeyword: return .capitalSelfKeyword
    case .dollarIdentifier: return .dollarIdentifier
    case .falseKeyword: return .falseKeyword
    case .floatingLiteral: return .floatingLiteral
    case .identifier: return .identifier
    case .integerLiteral: return .integerLiteral
    case .leftBrace: return .leftBrace
    case .leftParen: return .leftParen
    case .leftSquareBracket: return .leftSquareBracket
    case .nilKeyword: return .nilKeyword
    case .period: return .period
    case .poundColorLiteralKeyword: return .poundColorLiteralKeyword
    case .poundColumnKeyword: return .poundColumnKeyword
    case .poundDsohandleKeyword: return .poundDsohandleKeyword
    case .poundFileIDKeyword: return .poundFileIDKeyword
    case .poundFileKeyword: return .poundFileKeyword
    case .poundFileLiteralKeyword: return .poundFileLiteralKeyword
    case .poundFilePathKeyword: return .poundFilePathKeyword
    case .poundFunctionKeyword: return .poundFunctionKeyword
    case .poundImageLiteralKeyword: return .poundImageLiteralKeyword
    case .poundKeyPathKeyword: return .poundKeyPathKeyword
    case .poundLineKeyword: return .poundLineKeyword
    case .poundSelectorKeyword: return .poundSelectorKeyword
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
  case awaitTry(AwaitTry)
  case expressionPrefixOperator(ExpressionPrefixOperator)
  case matchingPatternStart(MatchingPatternStart)
  case primaryExpressionStart(PrimaryExpressionStart)

  static var allCases: [ExpressionStart] {
    return AwaitTry.allCases.map(Self.awaitTry)
    + ExpressionPrefixOperator.allCases.map(Self.expressionPrefixOperator)
    + MatchingPatternStart.allCases.map(Self.matchingPatternStart)
    + PrimaryExpressionStart.allCases.map(Self.primaryExpressionStart)
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .awaitTry(let underlyingKind): return underlyingKind.rawTokenKind
    case .expressionPrefixOperator(let underlyingKind): return underlyingKind.rawTokenKind
    case .matchingPatternStart(let underlyingKind): return underlyingKind.rawTokenKind
    case .primaryExpressionStart(let underlyingKind): return underlyingKind.rawTokenKind
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .awaitTry(let underlyingKind): return underlyingKind.contextualKeyword
    case .expressionPrefixOperator(let underlyingKind): return underlyingKind.contextualKeyword
    case .matchingPatternStart(let underlyingKind): return underlyingKind.contextualKeyword
    case .primaryExpressionStart(let underlyingKind): return underlyingKind.contextualKeyword
    }
  }
}
