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

let basicFormatFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(copyrightHeader),
    path: "SwiftSyntax"
  )

  ClassDecl(modifiers: [Token.open], identifier: "BasicFormat", inheritanceClause: TypeInheritanceClause { InheritedType(typeName: "SyntaxRewriter") }) {
    VariableDecl("public var indentationLevel: Int = 0")
    VariableDecl("open var indentation: TriviaPiece { .spaces(indentationLevel * 4) }")
    VariableDecl("public var indentedNewline: Trivia { Trivia(pieces: [.newlines(1), indentation]) }")
    VariableDecl("private var lastRewrittenToken: TokenSyntax?")

    for node in SYNTAX_NODES where !node.isBase {
      if node.isSyntaxCollection {
        makeSyntaxCollectionRewriteFunc(node: node)
      } else {
        makeLayoutNodeRewriteFunc(node: node)
      }
    }

    createTokenFormatFunction()
  }
}

private func makeLayoutNodeRewriteFunc(node: Node) -> FunctionDecl {
  let rewriteResultType: String
  if node.isSyntaxCollection {
    rewriteResultType = "Syntax"
  } else {
    rewriteResultType = node.type.baseType?.syntaxBaseName ?? "Syntax"
  }
  return FunctionDecl(
    leadingTrivia: .newline,
    modifiers: [Token.open, Token(tokenSyntax: TokenSyntax.contextualKeyword("override", trailingTrivia: .space))],
    identifier: .identifier("visit"),
    signature: FunctionSignature(
      input: ParameterClause(parameterList: [
        FunctionParameter(
          firstName: Token.wildcard,
          secondName: .identifier("node"),
          colon: .colon,
          type: node.type.syntaxBaseName

        )
      ]),
      output: rewriteResultType
    )
  ) {
    for child in node.children {
      if child.isIndented {
        SequenceExpr("indentationLevel += 1")
      }
      let variableLetVar = child.requiresLeadingNewline ? "var" : "let"
      if child.isOptional {
        VariableDecl("\(variableLetVar) \(child.swiftName) = node.\(child.swiftName).map(self.visit)?.cast(\(child.type.syntaxBaseName).self)")
      } else {
        VariableDecl("\(variableLetVar) \(child.swiftName) = self.visit(node.\(child.swiftName)).cast(\(child.type.syntaxBaseName).self)")
      }
      if child.requiresLeadingNewline {
        IfStmt(
          """
          if \(child.swiftName).leadingTrivia.first?.isNewline != true {
            \(child.swiftName).leadingTrivia = indentedNewline + \(child.swiftName).leadingTrivia
          }
          """
        )
      }
      if child.isIndented {
        SequenceExpr("indentationLevel -= 1")
      }
    }
    let reconstructed = FunctionCallExpr(calledExpression: "\(node.type.syntaxBaseName)") {
      for child in node.children {
        TupleExprElement(
          label: child.isUnexpectedNodes ? nil : child.swiftName,
          expression: child.swiftName
        )
      }
    }
    ReturnStmt("return \(rewriteResultType)(\(reconstructed))")
  }
}

private func makeSyntaxCollectionRewriteFunc(node: Node) -> FunctionDecl {
  let rewriteResultType: String
  if node.isSyntaxCollection {
    rewriteResultType = "Syntax"
  } else {
    rewriteResultType = node.type.baseType?.syntaxBaseName ?? "Syntax"
  }
  return FunctionDecl(
    leadingTrivia: .newline,
    modifiers: [Token.open, Token(tokenSyntax: TokenSyntax.contextualKeyword("override", trailingTrivia: .space))],
    identifier: .identifier("visit"),
    signature: FunctionSignature(
      input: ParameterClause(parameterList: [
        FunctionParameter(
          firstName: Token.wildcard,
          secondName: .identifier("node"),
          colon: .colon,
          type: node.type.syntaxBaseName

        )
      ]),
      output: rewriteResultType
    )
  ) {
    let formattedChildrenVarLet = node.elementsSeparatedByNewline ? "var" : "let"
    VariableDecl(
      """
      \(formattedChildrenVarLet) formattedChildren = node.children(viewMode: .all).map {
        self.visit($0).cast(\(node.collectionElementType.syntaxBaseName).self)
      }
      """
    )
    if node.elementsSeparatedByNewline {
      SequenceExpr(
        """
        formattedChildren = formattedChildren.map {
          if $0.leadingTrivia?.first?.isNewline == true {
            return $0
          } else {
            return $0.withLeadingTrivia(indentedNewline + ($0.leadingTrivia ?? []))
          }
        }
        """
      )
    }
    ReturnStmt("return Syntax(\(node.type.syntaxBaseName)(formattedChildren))")
  }
}

private func createTokenFormatFunction() -> FunctionDecl {
  return FunctionDecl(
    leadingTrivia: .newline,
    modifiers: [Token.open, Token(tokenSyntax: TokenSyntax.contextualKeyword("override", trailingTrivia: .space))],
    identifier: .identifier("visit"),
    signature: FunctionSignature(
      input: ParameterClause(parameterList: [
        FunctionParameter(
          firstName: Token.wildcard,
          secondName: .identifier("node"),
          colon: .colon,
          type: "TokenSyntax"

        )
      ]),
      output: "Syntax"
    )
  ) {
    VariableDecl("var leadingTrivia = node.leadingTrivia")
    VariableDecl("var trailingTrivia = node.trailingTrivia")
    SwitchStmt(expression: MemberAccessExpr(base: "node", name: "tokenKind")) {
      for token in SYNTAX_TOKENS where token.name != "ContextualKeyword" {
        SwitchCase(label: SwitchCaseLabel(caseItems: CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: token.swiftKind))))) {
          if token.requiresLeadingSpace {
            IfStmt(
              """
              if leadingTrivia.isEmpty && lastRewrittenToken?.trailingTrivia.isEmpty != false {
                leadingTrivia += .space
              }
              """
            )
          }
          if token.requiresTrailingSpace {
            IfStmt(
              """
              if trailingTrivia.isEmpty {
                trailingTrivia += .space
              }
              """
            )
          }
          if !token.requiresLeadingSpace && !token.requiresTrailingSpace {
            BreakStmt("break")
          }
        }
      }
      SwitchCase(label: SwitchCaseLabel(caseItems: CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: "eof"))))) {
        BreakStmt("break")
      }
      SwitchCase(label: SwitchCaseLabel(caseItems: CaseItem(pattern: ExpressionPattern(expression: MemberAccessExpr(name: "contextualKeyword"))))) {
        SwitchStmt(
          """
          switch node.text {
          case "async":
            if trailingTrivia.isEmpty {
              trailingTrivia += .space
            }
          default:
            break
          }
          """
        )
      }
    }
    SequenceExpr("leadingTrivia = leadingTrivia.indented(indentation: indentation)")
    SequenceExpr("trailingTrivia = trailingTrivia.indented(indentation: indentation)")
    VariableDecl(
      """
      let rewritten = TokenSyntax(
        node.tokenKind,
        leadingTrivia: leadingTrivia,
        trailingTrivia: trailingTrivia,
        presence: node.presence
      )
      """
    )
    SequenceExpr("lastRewrittenToken = rewritten")
    ReturnStmt("return Syntax(rewritten)")
  }
}
