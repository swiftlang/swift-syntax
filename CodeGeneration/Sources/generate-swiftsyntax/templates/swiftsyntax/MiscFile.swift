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

let miscFile = SourceFile {
  ExtensionDecl("""
    \(generateCopyrightHeader(for: "generate-swiftsyntax"))
    extension Syntax
    """) {
    VariableDecl(
      modifiers: [DeclModifierSyntax(name: Token.public), DeclModifier(name: Token.static)],
      name: IdentifierPattern("structure"),
      type: TypeAnnotation(
        colon: .colon,
        type: SimpleTypeIdentifier("SyntaxNodeStructure")
      )
    ) {
      ReturnStmt(
        expression: FunctionCallExpr(callee: MemberAccessExpr(".choices")) {
          TupleExprElement(
            expression: ArrayExprSyntax {
              ArrayElement(
                expression: FunctionCallExpr("\n.node(TokenSyntax.self)"),
                trailingComma: Token.comma)
              for node in NON_BASE_SYNTAX_NODES {
                ArrayElement(
                  expression: FunctionCallExpr("\n.node(\(raw: node.name).self)"),
                  trailingComma: Token.comma)
              }
            })
        }
      )
    }
  }
  
  ExtensionDecl("extension SyntaxKind") {
    VariableDecl(
      modifiers: [DeclModifier(name: Token.public)],
      name: IdentifierPattern("syntaxNodeType"),
      type: TypeAnnotation(
        colon: .colon,
        type: MemberTypeIdentifier("SyntaxProtocol.Type")
      )
    ) {
      SwitchStmt(expression: Expr("self")) {
        SwitchCase("case .token:") {
          ReturnStmt("return TokenSyntax.self")
        }
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCase("case .\(raw: node.swiftSyntaxKind):") {
            ReturnStmt("return \(raw: node.name).self")
          }
        }
      }
    }
    
    VariableDecl(
      modifiers: [DeclModifier(name: Token.public)],
      name: IdentifierPattern("nameForDiagnostics"),
      type: TypeAnnotation(
        colon: .colon,
        type: OptionalType("String?")
      )
    ) {
      SwitchStmt(expression: Expr("self")) {
        SwitchCase("case .token:") {
          ReturnStmt(#"return "token""#)
        }
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCase("case .\(raw: node.swiftSyntaxKind):") {
            if let nameForDiagnostics = node.nameForDiagnostics {
              ReturnStmt("return \"\(raw: nameForDiagnostics)\"")
            } else {
              ReturnStmt("return nil")
            }
          }
        }
      }
    }
  }
}
