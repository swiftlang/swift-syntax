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

let syntaxKindFile = SourceFile(leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
  EnumDecl("""
    /// Enumerates the known kinds of Syntax represented in the Syntax tree.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum SyntaxKind
    """) {
    EnumCaseDecl("case token")
    for node in NON_BASE_SYNTAX_NODES {
      EnumCaseDecl("case \(raw: node.swiftSyntaxKind)")
    }
    
    VariableDecl(
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("isSyntaxCollection"),
      type: TypeAnnotation(
        colon: .colon,
        type: SimpleTypeIdentifier("Bool")
      )
    ) {
      SwitchStmt(expression: Expr("self")) {
        for node in SYNTAX_NODES where node.baseKind == "SyntaxCollection"{
          SwitchCase("case .\(raw: node.swiftSyntaxKind):") {
            ReturnStmt("return true")
          }
        }
        
        SwitchCase("default:") {
          ReturnStmt("return false")
        }
      }
    }
    
    VariableDecl(
      modifiers: [DeclModifier(name: .public)],
      name: IdentifierPattern("isMissing"),
      type: TypeAnnotation(
        colon: .colon,
        type: SimpleTypeIdentifier("Bool")
      )
    ) {
      SwitchStmt(expression: Expr("self")) {
        for name in SYNTAX_BASE_KINDS where !["Syntax", "SyntaxCollection"].contains(name) {
          SwitchCase("case .missing\(raw: name):") {
            ReturnStmt("return true")
          }
        }
        
        SwitchCase("default:") {
          ReturnStmt("return false")
        }
      }
    }
  }
}
