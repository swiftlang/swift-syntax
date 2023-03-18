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

let lookupTable = ArrayExprSyntax(leftSquare: .leftSquareBracketToken(trailingTrivia: .newline)) {
  for keyword in KEYWORDS {
    ArrayElementSyntax(expression: ExprSyntax("\(literal: keyword.name)"), trailingComma: .commaToken())
  }
}

let keywordFile = SourceFileSyntax(leadingTrivia: generateCopyrightHeader(for: "generate-swiftsyntax")) {
  DeclSyntax(
    """
    /// Make `StaticString` equatable so we can use it as the raw value for Keyword.
    extension StaticString: Equatable {
      public static func == (lhs: StaticString, rhs: StaticString) -> Bool {
        return SyntaxText(lhs) == SyntaxText(rhs)
      }
    }
    """
  )

  try! EnumDeclSyntax(
    """
    @frozen  // FIXME: Not actually stable, works around a miscompile
    public enum Keyword: UInt8, Hashable
    """
  ) {
    for (index, keyword) in KEYWORDS.enumerated() {
      DeclSyntax("case \(raw: keyword.escapedName)")
    }

    try! InitializerDeclSyntax("@_spi(RawSyntax) public init?(_ text: SyntaxText)") {
      try! SwitchExprSyntax("switch text.count") {
        for (length, keywords) in keywordsByLength() {
          SwitchCaseSyntax("case \(raw: length):") {
            try! SwitchExprSyntax("switch text") {
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

    try! VariableDeclSyntax(
      """
      /// Whether the token kind is switched from being an identifier to being a keyword in the lexer.
      /// This is true for keywords that used to be considered non-contextual.
      public var isLexerClassified: Bool
      """
    ) {
      try! SwitchExprSyntax("switch self") {
        for keyword in KEYWORDS {
          if keyword.isLexerClassified {
            SwitchCaseSyntax("case .\(raw: keyword.escapedName): return true")
          }
        }
        SwitchCaseSyntax("default: return false")
      }
    }

    DeclSyntax(
      """
      /// This is really unfortunate. Really, we should have a `switch` in
      /// `Keyword.defaultText` to return the keyword's kind but the constant lookup
      /// table is significantly faster. Ideally, we could also get the compiler to
      /// constant-evaluate `Keyword.spi.defaultText` to a `SyntaxText` but I don't
      /// see how that's possible right now.
      private static let keywordTextLookupTable: [SyntaxText] = \(lookupTable)
      """
    )

    DeclSyntax(
      """
      @_spi(RawSyntax)
      public var defaultText: SyntaxText {
        return Keyword.keywordTextLookupTable[Int(self.rawValue)]
      }
      """
    )
  }
}
