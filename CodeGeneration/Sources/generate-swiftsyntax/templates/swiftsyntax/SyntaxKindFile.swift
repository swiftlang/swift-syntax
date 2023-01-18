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

let syntaxKindFile = SourceFileSyntax(leadingTrivia: .docLineComment(generateCopyrightHeader(for: "generate-swiftsyntax"))) {
  EnumDeclSyntax("""
    /// Enumerates the known kinds of Syntax represented in the Syntax tree.
    @frozen // FIXME: Not actually stable, works around a miscompile
    public enum SyntaxKind
    """) {
    EnumCaseDeclSyntax("case token")
    for node in NON_BASE_SYNTAX_NODES {
      EnumCaseDeclSyntax("case \(raw: node.swiftSyntaxKind)")
    }
    
    VariableDeclSyntax(
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("isSyntaxCollection"),
      type: TypeAnnotationSyntax(
        colon: .colonToken(),
        type: SimpleTypeIdentifierSyntax("Bool")
      )
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        for node in SYNTAX_NODES where node.baseKind == "SyntaxCollection"{
          SwitchCaseSyntax("case .\(raw: node.swiftSyntaxKind):") {
            ReturnStmtSyntax("return true")
          }
        }
        
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return false")
        }
      }
    }
    
    VariableDeclSyntax(
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: IdentifierPatternSyntax("isMissing"),
      type: TypeAnnotationSyntax(
        colon: .colonToken(),
        type: SimpleTypeIdentifierSyntax("Bool")
      )
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        for name in SYNTAX_BASE_KINDS where !["Syntax", "SyntaxCollection"].contains(name) {
          SwitchCaseSyntax("case .missing\(raw: name):") {
            ReturnStmtSyntax("return true")
          }
        }
        
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return false")
        }
      }
    }
  }
}
