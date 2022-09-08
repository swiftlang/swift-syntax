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

  /// Allows more flexible rejection of further token kinds based on the token's
  /// contents. Useful to e.g. look for contextual keywords.
  func accepts(lexeme: Lexer.Lexeme) -> Bool
}

extension RawTokenKindSubset {
  var contextualKeyword: SyntaxText? {
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
