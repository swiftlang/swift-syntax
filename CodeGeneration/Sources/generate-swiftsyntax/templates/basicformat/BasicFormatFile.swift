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

let basicFormatFile = SourceFileSyntax {
  ImportDeclSyntax(
    leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftbasicformat")),
    path: [AccessPathComponentSyntax(name: "SwiftSyntax")]
  )

  ClassDeclSyntax("open class BasicFormat: SyntaxRewriter") {
    VariableDeclSyntax("public var indentationLevel: Int = 0")
    VariableDeclSyntax("open var indentation: TriviaPiece { .spaces(indentationLevel * 4) }")
    VariableDeclSyntax("public var indentedNewline: Trivia { Trivia(pieces: [.newlines(1), indentation]) }")
    VariableDeclSyntax("private var lastRewrittenToken: TokenSyntax?")
    VariableDeclSyntax("private var putNextTokenOnNewLine: Bool = false")

    FunctionDeclSyntax("""
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
    FunctionDeclSyntax("""
      open override func visitPost(_ node: Syntax) {
        if let keyPath = getKeyPath(node), shouldIndent(keyPath) {
          indentationLevel -= 1
        }
      }
      """
    )

    FunctionDeclSyntax("""
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

    FunctionDeclSyntax("open func shouldIndent(_ keyPath: AnyKeyPath) -> Bool") {
      SwitchStmtSyntax(expression: ExprSyntax("keyPath")) {
        for node in SYNTAX_NODES where !node.isBase {
          for child in node.children where child.isIndented {
            SwitchCaseSyntax("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
              ReturnStmtSyntax("return true")
            }
          }
        }
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return false")
        }
      }
    }

    FunctionDeclSyntax("open func requiresLeadingNewline(_ keyPath: AnyKeyPath) -> Bool") {
      SwitchStmtSyntax(expression: ExprSyntax("keyPath")) {
        for node in SYNTAX_NODES where !node.isBase {
          for child in node.children where child.requiresLeadingNewline {
            SwitchCaseSyntax("case \\\(raw: node.type.syntaxBaseName).\(raw: child.swiftName):") {
              ReturnStmtSyntax("return true")
            }
          }
        }
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return putNextTokenOnNewLine")
        }
      }
    }

    FunctionDeclSyntax("open func childrenSeparatedByNewline(_ node: Syntax) -> Bool") {
      SwitchStmtSyntax(expression: ExprSyntax("node.as(SyntaxEnum.self)")) {
        for node in SYNTAX_NODES where !node.isBase {
          if node.elementsSeparatedByNewline {
            SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
              ReturnStmtSyntax("return true")
            }
          }
        }
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return false")
        }
      }
    }

    FunctionDeclSyntax("open func requiresLeadingSpace(_ token: TokenSyntax) -> Bool") {
      SwitchStmtSyntax("""
        switch (token.previousToken(viewMode: .sourceAccurate)?.tokenKind, token.tokenKind) {
        case (.leftParen, .binaryOperator):  // Ensures there is no space in @available(*, deprecated)
          return false
        default:
          break
        }
        """)
      
      SwitchStmtSyntax(expression: ExprSyntax("token.tokenKind")) {
        for token in SYNTAX_TOKENS {
          if token.requiresLeadingSpace {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmtSyntax("return true")
            }
          }
        }
        for keyword in KEYWORDS where keyword.requiresLeadingSpace {
          SwitchCaseSyntax("case .keyword(.\(raw: keyword.escapedName)):") {
            ReturnStmtSyntax("return true")
          }
        }
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return false")
        }
      }
    }

    FunctionDeclSyntax("open func requiresTrailingSpace(_ token: TokenSyntax) -> Bool") {
        SwitchStmtSyntax("""
        switch (token.tokenKind, token.parent?.kind) {
        case (.colon, .dictionaryExpr): // Ensures there is not space in `[:]`
          return false
        case (.exclamationMark, .tryExpr), // Ensures there is a space in `try! foo`
             (.postfixQuestionMark, .tryExpr): // Ensures there is a space in `try? foo`
          return true
        default:
          break
        }
        """)

      SwitchStmtSyntax("""
        switch (token.tokenKind, token.nextToken(viewMode: .sourceAccurate)?.tokenKind) {
        case (.keyword(.as), .exclamationMark), // Ensures there is not space in `as!`
             (.keyword(.as), .postfixQuestionMark), // Ensures there is not space in `as?`
             (.exclamationMark, .leftParen), // Ensures there is not space in `myOptionalClosure!()`
             (.exclamationMark, .period), // Ensures there is not space in `myOptionalBar!.foo()`
             (.keyword(.`init`), .leftParen), // Ensures there is not space in `init()`
             (.keyword(.`init`), .postfixQuestionMark), // Ensures there is not space in `init?`
             (.postfixQuestionMark, .leftParen), // Ensures there is not space in `init?()`
             (.postfixQuestionMark, .rightAngle), // Ensures there is not space in `ContiguousArray<RawSyntax?>`
             (.postfixQuestionMark, .rightParen), // Ensures there is not space in `myOptionalClosure?()`
             (.keyword(.try), .exclamationMark), // Ensures there is not space in `try!`
             (.keyword(.try), .postfixQuestionMark), // Ensures there is not space in `try?`
             (.binaryOperator, .comma): // Ensures there is no space in `@available(*, deprecated)`
          return false
        default:
          break
        }
        """)

      SwitchStmtSyntax(expression: ExprSyntax("token.tokenKind")) {
        for token in SYNTAX_TOKENS {
          if token.requiresTrailingSpace {
            SwitchCaseSyntax("case .\(raw: token.swiftKind):") {
              ReturnStmtSyntax("return true")
            }
          }
        }
        for keyword in KEYWORDS where keyword.requiresTrailingSpace {
          SwitchCaseSyntax("case .keyword(.\(raw: keyword.escapedName)):") {
            ReturnStmtSyntax("return true")
          }
        }
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return false")
        }
      }
    }

    FunctionDeclSyntax("""
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
