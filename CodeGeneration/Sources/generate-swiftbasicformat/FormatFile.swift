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

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let formatFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  StructDecl(modifiers: [Token.public], identifier: "Format") {
    VariableDecl("public let indentWidth: Int")

    VariableDecl("private var indents: Int = 0")

    InitializerDecl(
      """
      public init(indentWidth: Int = 4) {
        self.indentWidth = indentWidth
      }
      """
    )
  }

  ExtensionDecl(extendedType: "Format") {
    VariableDecl(
      """
      public var _indented: Self {
        var copy = self
        copy.indents += 1
        return copy
      }
      """
    )

    VariableDecl(
      """
      public var indentTrivia: Trivia {
        indents == 0 ? .zero : .spaces(indents * indentWidth)
      }
      """
    )

    VariableDecl(
      """
      private var indentedNewline: Trivia {
        .newline + indentTrivia
      }
      """
    )
  }

  ExtensionDecl(extendedType: "Format") {
    for node in SYNTAX_NODES {
      if node.isBuildable {
        createBuildableNodeFormatFunction(node: node)
      } else if node.isSyntaxCollection {
        createBuildableCollectionNodeFormatFunction(node: node)
      }
    }
    createTokenFormatFunction()
  }
}

private func createFormatFunctionSignature(type: SyntaxBuildableType) -> FunctionSignature {
  FunctionSignature(
    input: ParameterClause {
      FunctionParameter(
        firstName: .identifier("syntax"),
        colon: .colon,
        type: type.syntaxBaseName
      )
    },
    output: type.syntaxBaseName
  )
}

/// Generate the format implementation for a buildable node.
private func createBuildableNodeFormatFunction(node: Node) -> FunctionDecl {
  var initializerExpr: ExprBuildable = IdentifierExpr("syntax")
  for child in node.children where child.requiresLeadingNewline {
    initializerExpr = FunctionCallExpr("\(initializerExpr).with\(child.name)(syntax.\(child.swiftName).withLeadingTrivia(indentedNewline + (syntax.\(child.swiftName).leadingTrivia ?? [])))")
  }
  return FunctionDecl(
    """
    public func format(syntax: \(node.type.syntaxBaseName)) -> \(node.type.syntaxBaseName) {
      var result = \(initializerExpr)
      let leadingTrivia = result.leadingTrivia ?? []
      if !leadingTrivia.isEmpty {
        result = result.withLeadingTrivia(leadingTrivia)
      }
      return result
    }
    """
  )
}

/// Generate the format implementation for a collection node.
/// The implementation updates the leading trivia of the elements with their indentation.
private func createBuildableCollectionNodeFormatFunction(node: Node) -> FunctionDecl {
  FunctionDecl(
    modifiers: Token.public,
    identifier: .identifier("format"),
    signature: createFormatFunctionSignature(type: node.type)
  ) {
    if node.elementsSeparatedByNewline {
      FunctionCallExpr(
        """
        \(node.type.syntaxBaseName)(syntax.map {
          $0.withLeadingTrivia((indentedNewline + ($0.leadingTrivia ?? [])))
        })
        """
      )
    } else {
      "syntax"
    }
  }
}

private func createTokenFormatFunction() -> FunctionDecl {
  let tokenType = SyntaxBuildableType(syntaxKind: "Token")
  return FunctionDecl(
    modifiers: Token.public,
    identifier: .identifier("format"),
    signature: createFormatFunctionSignature(type: tokenType)
  ) {
    SwitchStmt(expression: MemberAccessExpr(base: "syntax", name: "tokenKind")) {
      for token in SYNTAX_TOKENS {
        SwitchCase(label: SwitchCaseLabel(caseItems: CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: token.swiftKind))))) {
          createWithLeadingWithTrailingTriviaCall(token: token)
        }
      }
      SwitchCase(label: SwitchCaseLabel(caseItems: CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: "eof"))))) {
        ReturnStmt(expression: "syntax")
      }
    }
  }
}

private func createWithLeadingWithTrailingTriviaCall(token: TokenSpec) -> CodeBlockItem {
  var res: ExprBuildable = IdentifierExpr("syntax")
  if token.requiresLeadingSpace {
    res = FunctionCallExpr("\(res).withLeadingTrivia(.space)")
  }
  if token.requiresTrailingSpace {
    res = FunctionCallExpr("\(res).withTrailingTrivia(.space)")
  }
  return CodeBlockItem(item: ReturnStmt(expression: res))
}
