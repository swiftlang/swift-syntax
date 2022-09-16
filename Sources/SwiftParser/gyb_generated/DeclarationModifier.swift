//// Automatically Generated From DeclarationModifier.swift.gyb.
//// Do Not Edit Directly!
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

enum DeclarationModifier: SyntaxText, ContextualKeywords, RawTokenKindSubset {
  case staticKeyword = "static"
  case classKeyword = "class"
  case final = "final"
  case required = "required"
  case optional = "optional"
  case lazy = "lazy"
  case dynamic = "dynamic"
  case infix = "infix"
  case prefix = "prefix"
  case postfix = "postfix"
  case __consuming = "__consuming"
  case mutating = "mutating"
  case nonmutating = "nonmutating"
  case convenience = "convenience"
  case override = "override"
  case privateKeyword = "private"
  case fileprivateKeyword = "fileprivate"
  case internalKeyword = "internal"
  case publicKeyword = "public"
  case open = "open"
  case __setter_access = "__setter_access"
  case weak = "weak"
  case unowned = "unowned"
  case `rethrows` = "rethrows"
  case indirect = "indirect"
  case isolated = "isolated"
  case async = "async"
  case reasync = "reasync"
  case nonisolated = "nonisolated"
  case distributed = "distributed"
  case _const = "_const"
  case _local = "_local"

  init?(lexeme: Lexer.Lexeme) {
    switch lexeme.tokenKind {
    case .staticKeyword: self = .staticKeyword
    case .classKeyword: self = .classKeyword
    case .privateKeyword: self = .privateKeyword
    case .fileprivateKeyword: self = .fileprivateKeyword
    case .internalKeyword: self = .internalKeyword
    case .publicKeyword: self = .publicKeyword
    case .identifier: self.init(rawValue: lexeme.tokenText)
    default: return nil
    }
  }

  var rawTokenKind: RawTokenKind {
    switch self {
    case .staticKeyword: return .staticKeyword
    case .classKeyword: return .classKeyword
    case .final: return .identifier
    case .required: return .identifier
    case .optional: return .identifier
    case .lazy: return .identifier
    case .dynamic: return .identifier
    case .infix: return .identifier
    case .prefix: return .identifier
    case .postfix: return .identifier
    case .__consuming: return .identifier
    case .mutating: return .identifier
    case .nonmutating: return .identifier
    case .convenience: return .identifier
    case .override: return .identifier
    case .privateKeyword: return .privateKeyword
    case .fileprivateKeyword: return .fileprivateKeyword
    case .internalKeyword: return .internalKeyword
    case .publicKeyword: return .publicKeyword
    case .open: return .identifier
    case .__setter_access: return .identifier
    case .weak: return .identifier
    case .unowned: return .identifier
    case .`rethrows`: return .identifier
    case .indirect: return .identifier
    case .isolated: return .identifier
    case .async: return .identifier
    case .reasync: return .identifier
    case .nonisolated: return .identifier
    case .distributed: return .identifier
    case ._const: return .identifier
    case ._local: return .identifier
    }
  }

  var contextualKeyword: SyntaxText? {
    switch self {
    case .final: return "final"
    case .required: return "required"
    case .optional: return "optional"
    case .lazy: return "lazy"
    case .dynamic: return "dynamic"
    case .infix: return "infix"
    case .prefix: return "prefix"
    case .postfix: return "postfix"
    case .__consuming: return "__consuming"
    case .mutating: return "mutating"
    case .nonmutating: return "nonmutating"
    case .convenience: return "convenience"
    case .override: return "override"
    case .open: return "open"
    case .__setter_access: return "__setter_access"
    case .weak: return "weak"
    case .unowned: return "unowned"
    case .`rethrows`: return "rethrows"
    case .indirect: return "indirect"
    case .isolated: return "isolated"
    case .async: return "async"
    case .reasync: return "reasync"
    case .nonisolated: return "nonisolated"
    case .distributed: return "distributed"
    case ._const: return "_const"
    case ._local: return "_local"
    default: return nil
    }
  }
}
