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
  
  EnumDecl("enum DeclarationModifier: SyntaxText, ContextualKeywords, RawTokenKindSubset") {
    for attribute in DECL_MODIFIER_KINDS {
      EnumCaseDecl("case \(raw: attribute.swiftName) = \"\(raw: attribute.name)\"")
    }
    InitializerDecl("init?(lexeme: Lexer.Lexeme)") {
      SwitchStmt(switchKeyword: .switch, expression: Expr("lexeme.tokenKind")) {
        for attribute in DECL_MODIFIER_KINDS where attribute.swiftName.hasSuffix("Keyword") {
          SwitchCase("case .\(raw: attribute.swiftName):") {
            SequenceExpr("self = .\(raw: attribute.swiftName)")
          }
        }
        SwitchCase("case .identifier:") {
          FunctionCallExpr("self.init(rawValue: lexeme.tokenText)")
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
      SwitchStmt(switchKeyword: .switch, expression: Expr("self")) {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCase("case .\(raw: attribute.swiftName):") {
            if attribute.swiftName.hasSuffix("Keyword") {
              ReturnStmt("return .\(raw: attribute.swiftName)")
            } else {
              ReturnStmt("return .identifier")
            }
          }
        }
      }
    }
    
    
    VariableDecl(
      name: IdentifierPattern("contextualKeyword"),
      type: TypeAnnotation(
        colon: .colon,
        type: OptionalType("SyntaxText?")
      )
    ) {
      SwitchStmt(switchKeyword: .switch, expression: Expr("self")) {
        for attribute in DECL_MODIFIER_KINDS where !attribute.swiftName.hasSuffix("Keyword") {
          SwitchCase("case .\(raw: attribute.swiftName):") {
            ReturnStmt("return \"\(raw: attribute.name)\"")
          }
        }
        
        SwitchCase("default:") {
          ReturnStmt("return nil")
        }
      }
    }
  }
}
