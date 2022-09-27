//===--- PresenceUtils.swift ----------------------------------------------===//
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
import SwiftBasicFormat

/// Walks a tree and checks whether the tree contained any present tokens.
class PresentNodeChecker: SyntaxAnyVisitor {
  var hasPresentToken: Bool = false

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if hasPresentToken {
      // If we already saw a present token, we don't need to continue.
      return .skipChildren
    } else {
      return .visitChildren
    }
  }

  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    if node.presence == .present {
      hasPresentToken = true
    }
    return .visitChildren
  }
}

extension SyntaxProtocol {
  /// Returns `true` if all tokens nodes in this tree are missing.
  var isMissingAllTokens: Bool {
    let checker = PresentNodeChecker(viewMode: .all)
    checker.walk(Syntax(self))
    return !checker.hasPresentToken
  }
}

/// Transforms a syntax tree by making all missing tokens present.
class PresentMaker: SyntaxRewriter {
  override func visit(_ token: TokenSyntax) -> Syntax {
    if token.presence == .missing {
      let presentToken: TokenSyntax
      let (rawKind, text) = token.tokenKind.decomposeToRaw()
      if let text = text, !text.isEmpty {
        presentToken = TokenSyntax(token.tokenKind, presence: .present)
      } else {
        let newKind = TokenKind.fromRaw(kind: rawKind, text: rawKind.defaultText.map(String.init) ?? "<#\(rawKind.nameForDiagnostics)#>")
        presentToken = TokenSyntax(newKind, presence: .present)
      }
      return Syntax(Format().format(syntax: presentToken))
    } else {
      return Syntax(token)
    }
  }

  override func visit(_ node: MissingDeclSyntax) -> DeclSyntax {
    let leadingTriviaBeforePlaceholder: Trivia
    if node.isMissingAllTokens {
      leadingTriviaBeforePlaceholder = []
    } else if node.modifiers != nil {
      leadingTriviaBeforePlaceholder = .space
    } else {
      leadingTriviaBeforePlaceholder = .newline
    }
    return DeclSyntax(StructDeclSyntax(
      node.unexpectedBeforeAttributes,
      attributes: node.attributes,
      node.unexpectedBetweenAttributesAndModifiers,
      modifiers: node.modifiers,
      structKeyword: .structKeyword(presence: .missing),
      identifier: .identifier("<#declaration#>", leadingTrivia: leadingTriviaBeforePlaceholder),
      genericParameterClause: nil,
      inheritanceClause: nil,
      genericWhereClause: nil,
      members: MemberDeclBlockSyntax(
        leftBrace: .leftBraceToken(presence: .missing),
        members: MemberDeclListSyntax([]),
        rightBrace: .rightBraceToken(presence: .missing)
      )
    ))
  }

  override func visit(_ node: MissingExprSyntax) -> ExprSyntax {
    return ExprSyntax(IdentifierExprSyntax(
      identifier: .identifier("<#expression#>"),
      declNameArguments: nil
    ))
  }

  override func visit(_ node: MissingPatternSyntax) -> PatternSyntax {
    return PatternSyntax(IdentifierPatternSyntax(
      identifier: .identifier("<#pattern#>")
    ))
  }

  override func visit(_ node: MissingStmtSyntax) -> StmtSyntax {
    return StmtSyntax(ExpressionStmtSyntax(
      expression: ExprSyntax(IdentifierExprSyntax(
        identifier: .identifier("<#statement#>"),
        declNameArguments: nil
      ))
    ))
  }

  override func visit(_ node: MissingTypeSyntax) -> TypeSyntax {
    return TypeSyntax(SimpleTypeIdentifierSyntax(
      name: .identifier("<#type#>"),
      genericArgumentClause: nil
    ))
  }

  override func visit(_ node: MissingSyntax) -> Syntax {
    return Syntax(IdentifierExprSyntax(
      identifier: .identifier("<#syntax#>"),
      declNameArguments: nil
    ))
  }
}
