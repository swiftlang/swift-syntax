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

let keywordFile = SourceFile {
  ExtensionDecl(
    """
    \(raw: generateCopyrightHeader(for: "generate-swiftparser"))

    /// Make `StaticString` equatable so we can use it as the raw value for Keyword.
    extension StaticString: Equatable {
      public static func == (lhs: StaticString, rhs: StaticString) -> Bool {
        return SyntaxText(lhs) == SyntaxText(rhs)
      }
    }
    """
  )

  EnumDecl("""
    @frozen  // FIXME: Not actually stable, works around a miscompile
    public enum Keyword: StaticString
    """) {
    for keyword in KEYWORDS {
      EnumCaseDecl("case \(raw: keyword.escapedName)")
    }

    InitializerDecl("@_spi(RawSyntax) public init?(_ text: SyntaxText)") {
      SwitchStmt(expression: Expr("text.count")) {
        for (length, keywords) in keywordsByLength() {
          SwitchCaseSyntax("case \(raw: length):") {
            SwitchStmt(expression: Expr("text")) {
              for keyword in keywords {
                SwitchCaseSyntax(#"case "\#(raw: keyword.name)":"#) {
                  Expr("self = .\(raw: keyword.escapedName)")
                }
              }
              SwitchCaseSyntax("default: return nil")
            }
          }
        }
        SwitchCaseSyntax("default: return nil")
      }
    }

    VariableDecl(
      leadingTrivia: [
        .docLineComment("/// Whether the token kind is switched from being an identifier to being an identifier to a keyword in the lexer."),
        .newlines(1),
        .docLineComment("/// This is true for keywords that used to be considered non-contextual."),
        .newlines(1)
      ],
      modifiers: [DeclModifier(name: .public)],
      name: "isLexerClassified",
      type: TypeAnnotation(type: Type("Bool"))) {
      SwitchStmt(expression: Expr("self")) {
        for keyword in KEYWORDS {
          if keyword.isLexerClassified {
            SwitchCaseSyntax("case .\(raw: keyword.escapedName): return true")
          }
        }
        SwitchCaseSyntax("default: return false")
      }
    }

    VariableDecl(
      """
      var defaultText: SyntaxText {
        return SyntaxText(self.rawValue)
      }
      """
    )
  }
}
