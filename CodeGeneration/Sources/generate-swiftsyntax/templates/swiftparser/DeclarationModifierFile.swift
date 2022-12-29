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

let declarationModifierFile = SourceFile {
  ImportDecl(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))
    @_spi(RawSyntax) import SwiftSyntax
    
    """
  )
  
  EnumDecl("enum DeclarationModifier: RawTokenKindSubset") {
    for attribute in DECL_MODIFIER_KINDS {
      EnumCaseDecl("case \(raw: attribute.swiftName)")
    }
    InitializerDecl("init?(lexeme: Lexer.Lexeme)") {
      SwitchStmt(expression: Expr("lexeme")) {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCase("case RawTokenKindMatch(.\(raw: attribute.swiftName)):") {
            SequenceExpr("self = .\(raw: attribute.swiftName)")
          }
        }
        SwitchCase("default:") {
          ReturnStmt("return nil")
        }
      }
    }
    
    VariableDecl(
      name: IdentifierPattern("rawTokenKind"),
      type: TypeAnnotation(
        colon: .colon,
        type: SimpleTypeIdentifier("RawTokenKind")
      )
    ) {
      SwitchStmt(expression: Expr("self")) {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCase("case .\(raw: attribute.swiftName):") {
            if attribute.swiftName.hasSuffix("Keyword") {
              ReturnStmt("return .\(raw: attribute.swiftName)")
            } else {
              ReturnStmt("return .contextualKeyword(.\(raw: attribute.swiftName))")
            }
          }
        }
      }
    }
  }
}
