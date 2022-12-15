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

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport
import Utils

let basicFormatFile = SourceFile {
  ImportDecl(
    leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftbasicformat")),
    path: [AccessPathComponent(name: "SwiftSyntax")]
  )

  ClassDecl("open class BasicFormat: SyntaxRewriter") {
    VariableDecl("public var indentationLevel: Int = 0")
    VariableDecl("open var indentation: TriviaPiece { .spaces(indentationLevel * 4) }")
    VariableDecl("public var indentedNewline: Trivia { Trivia(pieces: [.newlines(1), indentation]) }")
    VariableDecl("private var lastRewrittenToken: TokenSyntax?")
    VariableDecl("private var putNextTokenOnNewLine: Bool = false")

    FunctionDecl("""
      open override func visitPre(_ node: Syntax) {
        if let keyPath = getKeyPath(node), shouldIndent(keyPath) {
          indentationLevel += 1
        }
        if let parent = node.parent, childrenSeparatedByNewline(parent) {
          putNextTokenOnNewLine = true
        }
      }
      """
    )
    FunctionDecl("""
      open override func visitPost(_ node: Syntax) {
        if let keyPath = getKeyPath(node), shouldIndent(keyPath) {
          indentationLevel -= 1
        }
      }
      """
    )

    FunctionDecl("""
      open override func visit(_ node: TokenSyntax) -> TokenSyntax {
        var leadingTrivia = node.leadingTrivia
        var trailingTrivia = node.trailingTrivia
        if requiresLeadingSpace(node) && leadingTrivia.isEmpty && lastRewrittenToken?.trailingTrivia.isEmpty != false {
          leadingTrivia += .space
        }
        if requiresTrailingSpace(node) && trailingTrivia.isEmpty {
          trailingTrivia += .space
        }
        if let keyPath = getKeyPath(Syntax(node)), requiresLeadingNewline(keyPath), !(leadingTrivia.first?.isNewline ?? false) {
          leadingTrivia = .newline + leadingTrivia
        }
        leadingTrivia = leadingTrivia.indented(indentation: indentation)
        trailingTrivia = trailingTrivia.indented(indentation: indentation)
        let rewritten = TokenSyntax(
          node.tokenKind,
          leadingTrivia: leadingTrivia,
          trailingTrivia: trailingTrivia,
          presence: node.presence
        )
        lastRewrittenToken = rewritten
        putNextTokenOnNewLine = false
        return rewritten
      }
      """
    )

    FunctionDecl("open func shouldIndent(_ keyPath: AnyKeyPath) -> Bool") {
      SwitchStmt(expression: Expr("keyPath")) {
        for node in SYNTAX_NODES where !node.isBase {
          for child in node.children where child.isIndented {
            SwitchCase("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
              ReturnStmt("return true")
            }
          }
        }
        SwitchCase("default:") {
          ReturnStmt("return false")
        }
      }
    }

    FunctionDecl("open func requiresLeadingNewline(_ keyPath: AnyKeyPath) -> Bool") {
      SwitchStmt(expression: Expr("keyPath")) {
        for node in SYNTAX_NODES where !node.isBase {
          for child in node.children where child.requiresLeadingNewline {
            SwitchCase("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
              ReturnStmt("return true")
            }
          }
        }
        SwitchCase("default:") {
          ReturnStmt("return putNextTokenOnNewLine")
        }
      }
    }

    FunctionDecl("open func childrenSeparatedByNewline(_ node: Syntax) -> Bool") {
      SwitchStmt(expression: Expr("node.as(SyntaxEnum.self)")) {
        for node in SYNTAX_NODES where !node.isBase {
          if node.elementsSeparatedByNewline {
            SwitchCase("case .\(raw: node.swiftSyntaxKind):") {
              ReturnStmt("return true")
            }
          }
        }
        SwitchCase("default:") {
          ReturnStmt("return false")
        }
      }
    }

    FunctionDecl("open func requiresLeadingSpace(_ token: TokenSyntax) -> Bool") {
      SwitchStmt(expression: Expr("token.tokenKind")) {
        for token in SYNTAX_TOKENS {
          if token.requiresLeadingSpace {
            SwitchCase("case .\(raw: token.swiftKind):") {
              ReturnStmt("return true")
            }
          }
        }
        SwitchCase("default:") {
          ReturnStmt("return false")
        }
      }
    }

    FunctionDecl("open func requiresTrailingSpace(_ token: TokenSyntax) -> Bool") {
      SwitchStmt("""
        switch (token.tokenKind, token.nextToken(viewMode: .sourceAccurate)?.tokenKind) {
        case (.asKeyword, .exclamationMark),
             (.asKeyword, .postfixQuestionMark),
             (.initKeyword, .leftParen),
             (.initKeyword, .postfixQuestionMark),
             (.tryKeyword, .exclamationMark),
             (.tryKeyword, .postfixQuestionMark):
          return false
        default:
          break
        }
        """)
      
      SwitchStmt(expression: Expr("token.tokenKind")) {
        for token in SYNTAX_TOKENS {
          if token.requiresTrailingSpace {
            SwitchCase("case .\(raw: token.swiftKind):") {
              ReturnStmt("return true")
            }
          }
        }
        SwitchCase(#"case .contextualKeyword("async"):"#) {
          ReturnStmt("return true")
        }
        SwitchCase("default:") {
          ReturnStmt("return false")
        }
      }
    }

    FunctionDecl("""
      private func getKeyPath(_ node: Syntax) -> AnyKeyPath? {
        guard let parent = node.parent else {
          return nil
        }
        guard case .layout(let childrenKeyPaths) = parent.kind.syntaxNodeType.structure else {
          return nil
        }
        return childrenKeyPaths[node.indexInParent]
      }
      """
    )
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
    return FunctionCallExpr("\(optionalChained).cast(\(raw: childType.syntaxBaseName).self)")
  } else {
    return visitCall
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
      \(raw: formattedChildrenVarLet) formattedChildren = node.map {
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
    ReturnStmt("return \(raw: node.type.syntaxBaseName)(formattedChildren)")
  }
}

