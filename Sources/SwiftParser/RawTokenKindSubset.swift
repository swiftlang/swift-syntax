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
