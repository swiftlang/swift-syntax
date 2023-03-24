//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
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

let declarationModifierFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  DeclSyntax("@_spi(RawSyntax) import SwiftSyntax")

  try! EnumDeclSyntax("enum DeclarationModifier: TokenSpecSet") {
    for attribute in DECL_MODIFIER_KINDS {
      DeclSyntax("case \(raw: attribute.swiftName)")
    }

    try InitializerDeclSyntax("init?(lexeme: Lexer.Lexeme)") {
      try SwitchExprSyntax("switch PrepareForKeywordMatch(lexeme)") {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCaseSyntax("case TokenSpec(.\(raw: attribute.swiftName)):") {
            ExprSyntax("self = .\(raw: attribute.swiftName)")
          }
        }
        SwitchCaseSyntax("default:") {
          StmtSyntax("return nil")
        }
      }
    }

    try VariableDeclSyntax("var spec: TokenSpec") {
      try SwitchExprSyntax("switch self") {
        for attribute in DECL_MODIFIER_KINDS {
          SwitchCaseSyntax("case .\(raw: attribute.swiftName):") {
            if attribute.swiftName.hasSuffix("Keyword") {
              StmtSyntax("return .\(raw: attribute.swiftName)")
            } else {
              StmtSyntax("return .keyword(.\(raw: attribute.swiftName))")
            }
          }
        }
      }
    }
  }
}
