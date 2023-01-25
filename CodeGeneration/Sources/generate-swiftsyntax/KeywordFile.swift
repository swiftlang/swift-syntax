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

let lookupTable = ArrayExprSyntax(leftSquare: .leftSquareBracketToken(trailingTrivia: .newline)) {
  for keyword in KEYWORDS {
    ArrayElementSyntax(expression: ExprSyntax("\(literal: keyword.name)"), trailingComma: .commaToken(), trailingTrivia: .newline)
  }
}

let keywordFile = SourceFileSyntax {
  ExtensionDeclSyntax(
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

  EnumDeclSyntax("""
    @frozen  // FIXME: Not actually stable, works around a miscompile
    public enum Keyword: UInt8, Hashable
    """) {
    for (index, keyword) in KEYWORDS.enumerated() {
      EnumCaseDeclSyntax("case \(raw: keyword.escapedName)")
    }

    InitializerDeclSyntax("@_spi(RawSyntax) public init?(_ text: SyntaxText)") {
      SwitchStmtSyntax(expression: ExprSyntax("text.count")) {
        for (length, keywords) in keywordsByLength() {
          SwitchCaseSyntax("case \(raw: length):") {
            SwitchStmtSyntax(expression: ExprSyntax("text")) {
              for keyword in keywords {
                SwitchCaseSyntax(#"case "\#(raw: keyword.name)":"#) {
                  ExprSyntax("self = .\(raw: keyword.escapedName)")
                }
              }
              SwitchCaseSyntax("default: return nil")
            }
          }
        }
        SwitchCaseSyntax("default: return nil")
      }
    }

    VariableDeclSyntax(
      leadingTrivia: [
        .docLineComment("/// Whether the token kind is switched from being an identifier to being an identifier to a keyword in the lexer."),
        .newlines(1),
        .docLineComment("/// This is true for keywords that used to be considered non-contextual."),
        .newlines(1)
      ],
      modifiers: [DeclModifierSyntax(name: .keyword(.public))],
      name: "isLexerClassified",
      type: TypeAnnotationSyntax(type: TypeSyntax("Bool"))) {
      SwitchStmtSyntax(expression: ExprSyntax("self")) {
        for keyword in KEYWORDS {
          if keyword.isLexerClassified {
            SwitchCaseSyntax("case .\(raw: keyword.escapedName): return true")
          }
        }
        SwitchCaseSyntax("default: return false")
      }
    }

    VariableDeclSyntax("""
    /// This is really unfortunate. Really, we should have a `switch` in
    /// `Keyword.defaultText` to return the keyword's kind but the constant lookup
    /// table is significantly faster. Ideally, we could also get the compiler to
    /// constant-evaluate `Keyword.spi.defaultText` to a `SyntaxText` but I don't
    /// see how that's possible right now.
    private static let keywordTextLookupTable: [SyntaxText] = \(lookupTable)
    """)

    VariableDeclSyntax(
      """
      @_spi(RawSyntax)
      public var defaultText: SyntaxText {
        return Keyword.keywordTextLookupTable[Int(self.rawValue)]
      }
      """
    )
  }
}
