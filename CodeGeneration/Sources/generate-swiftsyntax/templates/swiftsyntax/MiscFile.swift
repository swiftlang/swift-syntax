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

let miscFile = SourceFileSyntax {
  ExtensionDeclSyntax("""
    \(raw: generateCopyrightHeader(for: "generate-swiftsyntax"))
    extension Syntax
    """) {
    VariableDeclSyntax(
      modifiers: [DeclModifierSyntax(name: .keyword(.public)), DeclModifierSyntax(name: .keyword(.static))],
      name: IdentifierPatternSyntax("structure"),
      type: TypeAnnotationSyntax(
        colon: .colonToken(),
        type: SimpleTypeIdentifierSyntax("SyntaxNodeStructure")
      )
    ) {
      ReturnStmtSyntax(
        expression: FunctionCallExprSyntax(callee: MemberAccessExprSyntax(".choices")) {
          TupleExprElementSyntax(
            expression: ArrayExprSyntax {
              ArrayElementSyntax(
                expression: FunctionCallExprSyntax("\n.node(TokenSyntax.self)")
              )
              for node in NON_BASE_SYNTAX_NODES {
                ArrayElementSyntax(
                  expression: FunctionCallExprSyntax("\n.node(\(raw: node.name).self)")
                )
              }
            })
        }
      )
    }
  }
  
  ExtensionDeclSyntax("extension SyntaxKind") {
    VariableDeclSyntax(
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("syntaxNodeType"),
      type: TypeAnnotationSyntax(
        colon: .colonToken(),
        type: MetatypeTypeSyntax("SyntaxProtocol.Type")
      )
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .token:") {
          ReturnStmtSyntax("return TokenSyntax.self")
        }
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            ReturnStmtSyntax("return \(raw: node.name).self")
          }
        }
      }
    }
    
    VariableDeclSyntax(
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("nameForDiagnostics"),
      type: TypeAnnotationSyntax(
        colon: .colonToken(),
        type: OptionalTypeSyntax("String?")
      )
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        SwitchCaseSyntax("case .token:") {
          ReturnStmtSyntax(#"return "token""#)
        }
        for node in NON_BASE_SYNTAX_NODES {
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            if let nameForDiagnostics = node.nameForDiagnostics {
              ReturnStmtSyntax("return \"\(raw: nameForDiagnostics)\"")
            } else {
              ReturnStmtSyntax("return nil")
            }
          }
        }
      }
    }
  }
}
