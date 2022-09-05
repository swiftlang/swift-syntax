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
  associatedtype ParserType = Parser

  var rawTokenKind: RawTokenKind { get }

  /// If this returns a non-nil value, only tokens with this token text are matched.
  /// Must only return a non-nil value if `rawTokenKind` is `identifier` or `contextualKeyword`.
  var contextualKeyword: SyntaxText? { get }

  /// Allows more flexible rejection of further token kinds based on the token's
  /// contents or lookahead. Useful to e.g. look for contextual keywords.
  func accepts(lexeme: Lexer.Lexeme, parser: ParserType) -> Bool
}

extension RawTokenKindSubset {
  var contextualKeyword: SyntaxText? {
    return nil
  }

  func accepts(lexeme: Lexer.Lexeme, parser: ParserType) -> Bool {
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

enum ContextualDeclKeyword: RawTokenKindSubset {
  typealias ParserType = Parser.Lookahead
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
  case open
  case optional
  case override
  case postfix
  case prefix
  case required
  case unowned
  case weak

  var rawTokenKind: RawTokenKind {
    return .identifier
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .__consuming: return "__consuming"
    case ._compilerInitialized: return "_compilerInitialized"
    case ._const: return "_const"
    case ._local: return "_local"
    case .actor: return "actor"
    case .async: return "async"
    case .convenience: return "convenience"
    case .distributed: return "distributed"
    case .dynamic: return "dynamic"
    case .final: return "final"
    case .indirect: return "indirect"
    case .infix: return "infix"
    case .isolated: return "isolated"
    case .lazy: return "lazy"
    case .mutating: return "mutating"
    case .nonisolated: return "nonisolated"
    case .nonmutating: return "nonmutating"
    case .open: return "open"
    case .optional: return "optional"
    case .override: return "override"
    case .postfix: return "postfix"
    case .prefix: return "prefix"
    case .required: return "required"
    case .unowned: return "unowned"
    case .weak: return "weak"
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
