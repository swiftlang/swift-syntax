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

let typeAttributeFile = SourceFileSyntax {
  ImportDeclSyntax(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))
    @_spi(RawSyntax) import SwiftSyntax
    
    """
  )
  
  ExtensionDeclSyntax("extension Parser") {
    EnumDeclSyntax("enum TypeAttribute: RawTokenKindSubset") {
      for attribute in TYPE_ATTR_KINDS {
        EnumCaseDeclSyntax("case \(raw: attribute.name)")
      }

      InitializerDeclSyntax("init?(lexeme: Lexer.Lexeme)") {
        SwitchStmtSyntax(switchKeyword: .keyword(.switch), expression: ExprSyntax("lexeme")) {
          for attribute in TYPE_ATTR_KINDS {
            SwitchCaseSyntax("case RawTokenKindMatch(.\(raw: attribute.name)):") {
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
        SwitchStmtSyntax(switchKeyword: .keyword(.switch), expression: ExprSyntax("self")) {
          for attribute in TYPE_ATTR_KINDS {
            SwitchCaseSyntax("case .\(raw: attribute.swiftName):") {
              ReturnStmtSyntax("return .keyword(.\(raw: attribute.name))")
            }
          }
        }
      }
    }
  }
}
