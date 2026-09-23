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

let lookupTable = ArrayExprSyntax(leftSquare: .leftSquareToken(trailingTrivia: .newline)) {
  for keyword in Keyword.allCases {
    ArrayElementSyntax(expression: ExprSyntax("\(literal: keyword.spec.name)"), trailingComma: .commaToken())
  }
}

let keywordFile = SourceFileSyntax(leadingTrivia: copyrightHeader) {
  try! EnumDeclSyntax(
    """
    public enum Keyword: UInt8, Hashable, Sendable
    """
  ) {
    for keyword in Keyword.allCases {
      DeclSyntax(
        """
        \(keyword.spec.apiAttributes)\
        case \(keyword.spec.enumCaseDeclName)
        """
      )
    }

    try! InitializerDeclSyntax("@_spi(RawSyntax) public init?(_ text: SyntaxText)") {
      try! SwitchExprSyntax("switch text.count") {
        for (length, keywords) in keywordsByLength() {
          SwitchCaseSyntax("case \(raw: length):") {
            ExprSyntax("self.init(_length\(raw: length): text)")
          }
        }
        SwitchCaseSyntax("default: return nil")
      }
    }

    // Split into individual initializers by length to reduce stack use, and to keep
    // each search shallow: one table of every short keyword measures half as well.
    for (length, keywords) in keywordsByLength() {
      try! InitializerDeclSyntax("private init?(_length\(raw: length) text: SyntaxText)") {
        if length <= 8 {
          // Switch on the bytes as one integer, which the compiler searches. A switch
          // over `SyntaxText` walks a chain, reloading the bytes for each candidate.
          let terms = (0..<length).map { i in
            i == 0 ? "UInt64(text[0])" : "UInt64(text[\(i)]) << \(i * 8)"
          }
          DeclSyntax("let packed = \(raw: terms.joined(separator: " | "))")
          try! SwitchExprSyntax("switch packed") {
            for keyword in keywords {
              let packed = Array(keyword.name.utf8).enumerated()
                .reduce(UInt64(0)) { $0 | UInt64($1.element) << (8 * $1.offset) }
              SwitchCaseSyntax("case \(raw: "0x" + String(packed, radix: 16)):  // \(raw: keyword.name)") {
                ExprSyntax("self = .\(keyword.enumCaseCallName)")
              }
            }
            SwitchCaseSyntax("default: return nil")
          }
        } else {
          // Too long for a word; the text comparison checks the length as it goes.
          try! SwitchExprSyntax("switch text") {
            for keyword in keywords {
              SwitchCaseSyntax("case \(literal: keyword.name):") {
                ExprSyntax("self = .\(keyword.enumCaseCallName)")
              }
            }
            SwitchCaseSyntax("default: return nil")
          }
        }
      }
    }

    DeclSyntax(
      """
      /// This is really unfortunate. Really, we should have a `switch` in
      /// `Keyword.defaultText` to return the keyword's kind but the constant lookup
      /// table is significantly faster. Ideally, we could also get the compiler to
      /// constant-evaluate `Keyword.spi.defaultText` to a ``SyntaxText`` but I don't
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
