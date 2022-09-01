//===--- TokenClassification.swift ----------------------------------------===//
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

/// A grabbag of token kind classifications for specific use cases
enum TokenClassification {
  // MARK: Declaration start

  static var declarationStartKeywords: [RawTokenKind] = [
    .associatedtypeKeyword,
    .classKeyword,
    // We don't consider caseKeyword a declStartKeyword because it cannot start a
    // top-level decl - it can only occur in an `enum`.
    .deinitKeyword,
    .enumKeyword,
    .extensionKeyword,
    .funcKeyword,
    .importKeyword,
    .initKeyword,
    .letKeyword,
    .operatorKeyword,
    .precedencegroupKeyword,
    .protocolKeyword,
    .structKeyword,
    .subscriptKeyword,
    .typealiasKeyword,
    .varKeyword
  ]

  static var contextualDeclarationStartKeywords: [SyntaxText] = [
    "actor"
  ]

  static func isDeclarationStart(_ lexeme: Lexer.Lexeme) -> Bool {
    if declarationStartKeywords.contains(lexeme.tokenKind) {
      return true
    } else if lexeme.isContextualKeyword(contextualDeclarationStartKeywords) {
      return true
    } else {
      return false
    }
  }

  // MARK: Declaration modifier

  static func isDeclarationModifier(_ lexeme: Lexer.Lexeme) -> Bool {
    switch lexeme.tokenKind {
    case .privateKeyword, .fileprivateKeyword, .internalKeyword, .publicKeyword, .staticKeyword:
      fallthrough
    case .identifier where Parser.DeclModifier(rawValue: lexeme.tokenText) != nil:
      return true
    default:
      return false
    }
  }

  // MARK: Pound declaration

  static func isPoundDeclarationKeyword(_ lexeme: Lexer.Lexeme) -> Bool {
    switch lexeme.tokenKind {
    case .poundIfKeyword, .poundWarningKeyword, .poundErrorKeyword:
      return true
    default:
      return false
    }
  }
}
