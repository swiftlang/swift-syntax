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
    path: [AccessPathComponent(name: "SwiftSyntax")]
  )

  ClassDecl(modifiers: [DeclModifier(name: .open)], identifier: "BasicFormat", inheritanceClause: TypeInheritanceClause { InheritedType(typeName: Type("SyntaxRewriter")) }) {
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

private func createChildVisitCall(childType: SyntaxBuildableType, rewrittenExpr: ExprSyntaxProtocol) -> FunctionCallExpr {
  let visitCall: FunctionCallExpr
  if childType.isOptional {
    visitCall = FunctionCallExpr("\(rewrittenExpr).map(self.visit)")
  } else {
    visitCall = FunctionCallExpr("self.visit(\(rewrittenExpr))")
  }
  if childType.baseType?.baseName != "Syntax", childType.baseType?.isSyntaxCollection != true, childType.baseType != nil {
    let optionalChained = childType.optionalChained(expr: visitCall)
    return FunctionCallExpr("\(optionalChained).cast(\(childType.syntaxBaseName).self)")
  } else {
    return visitCall
  }
}

private func makeLayoutNodeRewriteFunc(node: Node) -> FunctionDecl {
  let rewriteResultType: String
  if node.type.baseType?.syntaxKind == "Syntax" && node.type.syntaxKind != "Missing" {
    rewriteResultType = node.type.syntaxBaseName
  } else {
    rewriteResultType = node.type.baseType?.syntaxBaseName ?? node.type.syntaxBaseName
  }
  return FunctionDecl("""

    open override func visit(_ node: \(node.type.syntaxBaseName)) -> \(rewriteResultType)
    """) {
    for child in node.children {
      if child.isIndented {
        SequenceExpr("indentationLevel += 1")
      }
      let variableLetVar = child.requiresLeadingNewline ? "var" : "let"
      VariableDecl("\(variableLetVar) \(child.swiftName) = \(createChildVisitCall(childType: child.type, rewrittenExpr: MemberAccessExpr("node.\(child.swiftName)")))")
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
    let reconstructed = FunctionCallExpr(callee: node.type.syntaxBaseName) {
      for child in node.children {
        TupleExprElement(
          label: child.isUnexpectedNodes ? nil : child.swiftName,
          expression: Expr(child.swiftName)
        )
      }
    }
    if rewriteResultType != node.type.syntaxBaseName {
      ReturnStmt("return \(rewriteResultType)(\(reconstructed))")
    } else {
      ReturnStmt("return \(reconstructed)")
    }
  }
}

private func makeSyntaxCollectionRewriteFunc(node: Node) -> FunctionDecl {
  let rewriteResultType = node.type.syntaxBaseName
  return FunctionDecl("""

    open override func visit(_ node: \(node.type.syntaxBaseName)) -> \(rewriteResultType)
    """) {
    let formattedChildrenVarLet = node.elementsSeparatedByNewline ? "var" : "let"
    VariableDecl(
      """
      \(formattedChildrenVarLet) formattedChildren = node.map {
        \(createChildVisitCall(childType: node.collectionElementType, rewrittenExpr: IdentifierExpr(identifier: .dollarIdentifier("$0"))))
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
    ReturnStmt("return \(node.type.syntaxBaseName)(formattedChildren)")
  }
}

private func createTokenFormatFunction() -> FunctionDecl {
  return FunctionDecl("""

    open override func visit(_ node: TokenSyntax) -> TokenSyntax
    """) {
    VariableDecl("var leadingTrivia = node.leadingTrivia")
    VariableDecl("var trailingTrivia = node.trailingTrivia")
    SwitchStmt(expression: MemberAccessExpr(base: "node", name: "tokenKind")) {
      for token in SYNTAX_TOKENS where token.name != "ContextualKeyword" {
        SwitchCase("case .\(token.swiftKind):") {
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
      SwitchCase("case .eof:") {
        BreakStmt("break")
      }
      SwitchCase("case .contextualKeyword:") {
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
    ReturnStmt("return rewritten")
  }
}
