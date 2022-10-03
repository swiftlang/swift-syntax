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

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .associatedtypeKeyword: self = .associatedtypeKeyword
    case .atSign: self = .atSign
    case .caseKeyword: self = .caseKeyword
    case .classKeyword: self = .classKeyword
    case .deinitKeyword: self = .deinitKeyword
    case .enumKeyword: self = .enumKeyword
    case .extensionKeyword: self = .extensionKeyword
    case .fileprivateKeyword: self = .fileprivateKeyword
    case .funcKeyword: self = .funcKeyword
    case .identifier: self = .identifier
    case .importKeyword: self = .importKeyword
    case .initKeyword: self = .initKeyword
    case .internalKeyword: self = .internalKeyword
    case .letKeyword: self = .letKeyword
    case .operatorKeyword: self = .operatorKeyword
    case .poundErrorKeyword: self = .poundErrorKeyword
    case .poundIfKeyword: self = .poundIfKeyword
    case .poundLineKeyword where lexeme.isAtStartOfLine: self = .poundLineKeyword
    case .poundSourceLocationKeyword: self = .poundSourceLocationKeyword
    case .poundWarningKeyword: self = .poundWarningKeyword
    case .precedencegroupKeyword: self = .precedencegroupKeyword
    case .privateKeyword: self = .privateKeyword
    case .protocolKeyword: self = .protocolKeyword
    case .publicKeyword: self = .publicKeyword
    case .staticKeyword: self = .staticKeyword
    case .structKeyword: self = .structKeyword
    case .subscriptKeyword: self = .subscriptKeyword
    case .typealiasKeyword: self = .typealiasKeyword
    case .varKeyword: self = .varKeyword
    default: return nil
    }
  }

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

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .identifier where lexeme.tokenText == "actor": self = .actorContextualKeyword
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
  case selfKeyword

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .anyKeyword: self = .anyKeyword
    case .capitalSelfKeyword: self = .capitalSelfKeyword
    case .identifier: self = .identifier
    case .selfKeyword: self = .selfKeyword
    default: return nil
    }
  }

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
    case (.identifier, "isolate"): self = .isolated
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

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .__column__Keyword: self = .__column__Keyword
    case .__dso_handle__Keyword: self = .__dso_handle__Keyword
    case .__file__Keyword: self = .__file__Keyword
    case .__function__Keyword: self = .__function__Keyword
    case .__line__Keyword: self = .__line__Keyword
    case .anyKeyword: self = .anyKeyword
    case .capitalSelfKeyword: self = .capitalSelfKeyword
    case .dollarIdentifier: self = .dollarIdentifier
    case .falseKeyword: self = .falseKeyword
    case .floatingLiteral: self = .floatingLiteral
    case .identifier: self = .identifier
    case .integerLiteral: self = .integerLiteral
    case .leftBrace: self = .leftBrace
    case .leftParen: self = .leftParen
    case .leftSquareBracket: self = .leftSquareBracket
    case .nilKeyword: self = .nilKeyword
    case .period: self = .period
    case .poundColorLiteralKeyword: self = .poundColorLiteralKeyword
    case .poundColumnKeyword: self = .poundColumnKeyword
    case .poundDsohandleKeyword: self = .poundDsohandleKeyword
    case .poundFileIDKeyword: self = .poundFileIDKeyword
    case .poundFileKeyword: self = .poundFileKeyword
    case .poundFileLiteralKeyword: self = .poundFileLiteralKeyword
    case .poundFilePathKeyword: self = .poundFilePathKeyword
    case .poundFunctionKeyword: self = .poundFunctionKeyword
    case .poundImageLiteralKeyword: self = .poundImageLiteralKeyword
    case .poundKeyPathKeyword: self = .poundKeyPathKeyword
    case .poundLineKeyword: self = .poundLineKeyword
    case .poundSelectorKeyword: self = .poundSelectorKeyword
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

  var contextualKeyword: SyntaxText? {
    switch self {
    case .awaitTryMove(let underlyingKind): return underlyingKind.contextualKeyword
    case .expressionPrefixOperator(let underlyingKind): return underlyingKind.contextualKeyword
    case .matchingPatternStart(let underlyingKind): return underlyingKind.contextualKeyword
    case .primaryExpressionStart(let underlyingKind): return underlyingKind.contextualKeyword
    }
  }
}
