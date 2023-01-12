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

let typeAttributeFile = SourceFile {
  ImportDecl(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))
    @_spi(RawSyntax) import SwiftSyntax
    
    """
  )
  
  ExtensionDecl("extension Parser") {
    EnumDecl("enum TypeAttribute: RawTokenKindSubset") {
      for attribute in TYPE_ATTR_KINDS {
        EnumCaseDecl("case \(raw: attribute.name)")
      }

      InitializerDecl("init?(lexeme: Lexer.Lexeme)") {
        SwitchStmt(switchKeyword: .switch, expression: Expr("lexeme")) {
          for attribute in TYPE_ATTR_KINDS {
            SwitchCase("case RawTokenKindMatch(.\(raw: attribute.name)):") {
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
        SwitchStmt(switchKeyword: .switch, expression: Expr("self")) {
          for attribute in TYPE_ATTR_KINDS {
            SwitchCase("case .\(raw: attribute.swiftName):") {
              ReturnStmt("return .keyword(.\(raw: attribute.name))")
            }
          }
        }
      }
    }
  }
}
