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

let declarationModifierFile = SourceFileSyntax {
  ImportDeclSyntax(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))
    @_spi(RawSyntax) import SwiftSyntax
    
    """
  )
  
  EnumDeclSyntax("enum DeclarationModifier: RawTokenKindSubset") {
    for attribute in DECL_MODIFIER_KINDS {
      EnumCaseDeclSyntax("case \(raw: attribute.swiftName)")
    }
    InitializerDeclSyntax("init?(lexeme: Lexer.Lexeme)") {
      SwitchStmtSyntax(expression: ExprSyntax("lexeme")) {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCaseSyntax("case RawTokenKindMatch(.\(raw: attribute.swiftName)):") {
            SequenceExprSyntax("self = .\(raw: attribute.swiftName)")
          }
        }
        SwitchCaseSyntax("default:") {
          ReturnStmtSyntax("return nil")
        }
      }
    }
    
    VariableDeclSyntax(
      name: IdentifierPatternSyntax("rawTokenKind"),
      type: TypeAnnotationSyntax(
        colon: .colonToken(),
        type: SimpleTypeIdentifierSyntax("RawTokenKind")
      )
    ) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCaseSyntax("case .\(raw: attribute.swiftName):") {
            if attribute.swiftName.hasSuffix("Keyword") {
              ReturnStmtSyntax("return .\(raw: attribute.swiftName)")
            } else {
              ReturnStmtSyntax("return .keyword(.\(raw: attribute.swiftName))")
            }
          }
        }
      }
    }
  }
}
