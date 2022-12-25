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
      SwitchStmt("""
        switch (token.tokenKind, token.previousToken(viewMode: .sourceAccurate)?.tokenKind) {
        case (.leftAngle, .identifier(_)),
             (.rightAngle, .identifier(_)),
             (.rightAngle, .postfixQuestionMark):
          return false
        case (.spacedBinaryOperator(let `operator`), .leftParen):
          return `operator` != "*"
        default:
          break
        }
        """)
      
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
      IfStmt("""
        // Format `[:]` as-is.
        if token.tokenKind == .colon && token.parent?.kind == .dictionaryExpr {
          return false
        }
        """)

      SwitchStmt("""
        switch (token.tokenKind, token.nextToken(viewMode: .sourceAccurate)?.tokenKind) {
        case (.asKeyword, .exclamationMark),
             (.asKeyword, .postfixQuestionMark),
             (.initKeyword, .leftParen),
             (.initKeyword, .postfixQuestionMark),
             (.leftAngle, .identifier(_)),
             (.rightAngle, .leftParen),
             (.rightAngle, .postfixQuestionMark),
             (.postfixQuestionMark, .leftParen),
             (.postfixQuestionMark, .rightParen),
             (.tryKeyword, .exclamationMark),
             (.tryKeyword, .postfixQuestionMark):
          return false
        case (.spacedBinaryOperator(let `operator`), .comma):
          return `operator` != "*"
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
