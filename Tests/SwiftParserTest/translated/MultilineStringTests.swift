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

// This test file has been translated from swift/test/StringProcessing/Parse/multiline_string.swift

import SwiftSyntax

import XCTest

final class MultilineStringTests: XCTestCase {
  func testMultilineString1() {
    AssertParse(
      """
      import Swift
      """
    )
  }

  func testMultilineString2() {
    AssertParse(
      """
      // ===---------- Multiline --------===
      """
    )
  }

  func testMultilineString3() {
    AssertParse(
      #"""
      _ = """
          One
          ""Alpha""
          """
      """#
    )
  }

  func testMultilineString4() {
    AssertParse(
      #"""
      _ = """
          Two
        Beta
        """
      """#
    )
  }

  func testMultilineString5() {
    AssertParse(
      #"""
      _ = """
          Three
          Gamma.
        """
      """#
    )
  }

  func testMultilineString6() {
    AssertParse(
      #"""
      _ = """
          Four
          Delta
      """
      """#
    )
  }

  func testMultilineString7() {
    AssertParse(
      #"""
      _ = """
          Five\n

          Epsilon
          """
      """#
    )
  }

  func testMultilineString9() {
    AssertParse(
      #"""
      _ = """
          Six
          Zeta

          """
      """#
    )
  }

  func testMultilineString11() {
    AssertParse(
      #"""
      _ = """
          Seven
          Eta\n
          """
      """#
    )
  }

  func testMultilineString12() {
    AssertParse(
      #"""
      _ = """
          \"""
          "\""
          ""\"
          Iota
          """
      """#
    )
  }

  func testMultilineString13() {
    AssertParse(
      #"""
      _ = """
           \("Nine")
          Kappa
          """
      """#
    )
  }

  func testMultilineString14() {
    AssertParse(
      #"""
      _ = """
      	first
      	 second
      	third
      	"""
      """#
    )
  }

  func testMultilineString15() {
    AssertParse(
      #"""
      _ = """
       first
       	second
       third
       """
      """#
    )
  }

  func testMultilineString16() {
    AssertParse(
      #"""
      _ = """
      \\
      """
      """#
    )
  }

  func testMultilineString17() {
    AssertParse(
      #"""
      _ = """
        \\
        """
      """#
    )
  }

  func testMultilineString18() {
    AssertParse(
      #"""
      _ = """

        ABC
        """
      """#
    )
  }

  func testMultilineString20() {
    AssertParse(
      #"""
      _ = """

      ABC
      """
      """#
    )
  }

  func testMultilineString22() {
    AssertParse(
      #"""
      _ = """

        ABC
        """
      """#
    )
  }

  func testMultilineString24() {
    AssertParse(
      #"""
      // contains tabs
      _ = """
      	Twelve
      	Nu
      	"""
      """#
    )
  }

  func testMultilineString25() {
    AssertParse(
      #"""
      _ = """
        newline \
        elided
        """
      """#
    )
  }

  func testMultilineString26() {
    // contains trailing whitespace
    AssertParse(
      #"""
      _ = """
        trailing \
        \("""
          substring1 \
          \("""
            substring2 \          
            substring3
            """)
          """) \
        whitespace
        """
      """#
    )
  }

  func testMultilineString27() {
    // contains trailing whitespace
    AssertParse(
      #"""
      _ = """
          foo\ 

          bar
          """
      """#
    )
  }

  func testMultilineString29() {
    // contains trailing whitespace
    AssertParse(
      #"""
      _ = """
          foo\ 
          
          bar
          """
      """#
    )
  }

  func testMultilineString31() {
    AssertParse(
      #"""
      _ = """
          foo \
            bar
          """
      """#
    )
  }

  func testMultilineString32() {
    AssertParse(
      #"""
      _ = """

        ABC
        """
      """#
    )
  }

  func testMultilineString34() {
    AssertParse(
      #"""
      _ = """

          ABC

          """
      """#
    )
  }

  func testMultilineString37() {
    AssertParse(
      #"""
      _ = """


          """
      """#
    )
  }

  func testMultilineString39() {
    AssertParse(
      #"""
      _ = """

          """
      """#
    )
  }

  func testMultilineString41() {
    AssertParse(
      #"""
      _ = """
          """
      """#
    )
  }

  func testMultilineString42() {
    AssertParse(
      #"""
      _ = "\("""
        \("a" + """
         valid
        """)
        """) literal"
      """#
    )
  }

  func testMultilineString43() {
    AssertParse(
      #"""
      _ = "hello\("""
        world
        """)"
      """#
    )
  }

  func testMultilineString44() {
    AssertParse(
      #"""
      _ = """
        hello\("""
           world
           """)
        abc
        """
      """#
    )
  }

  func testMultilineString45() {
    AssertParse(
      #"""
      _ = "hello\("""
                  "world'
                  """)abc"
      """#
    )
  }

  func testMultilineString46() {
    AssertParse(
      #"""
      _ = """
          welcome
          \(
            /*
              ')' or '"""' in comment.
              """
            */
            "to\("""
                 Swift
                 """)"
            // ) or """ in comment.
          )
          !
          """
      """#
    )
  }

  func testEscapeNewlineInRawString() {
    AssertParse(
      ##"""
      #"""
      Three \#
      Gamma
      """#
      """##,
      substructure: Syntax(
        StringLiteralExprSyntax(
          openDelimiter: .rawStringDelimiter("#"),
          openQuote: .multilineStringQuoteToken(trailingTrivia: .newline),
          segments: StringLiteralSegmentsSyntax([
            .stringSegment(
              StringSegmentSyntax(content: .stringSegment("Three ", trailingTrivia: [.backslashes(1), .pounds(1), .newlines(1)]))
            ),
            .stringSegment(StringSegmentSyntax(content: .stringSegment("Gamma", trailingTrivia: .newline))),
          ]),
          closeQuote: .multilineStringQuoteToken(),
          closeDelimiter: .rawStringDelimiter("#")
        )
      ),
      options: .substructureCheckTrivia
    )
  }

  func testEscapeLastNewlineInRawString() {
    // We really shouldn't be allow the last newline in the multi-line string
    // literal to be escaped in a multi-line string literal. But since the C++
    // parser accepts this, so does SwiftParser.
    AssertParse(
      ##"""
      #"""
      Three \#
      Gamma \#
      """#
      """##,
      substructure: Syntax(
        StringLiteralExprSyntax(
          openDelimiter: .rawStringDelimiter("#"),
          openQuote: .multilineStringQuoteToken(trailingTrivia: .newline),
          segments: StringLiteralSegmentsSyntax([
            .stringSegment(
              StringSegmentSyntax(content: .stringSegment("Three ", trailingTrivia: [.backslashes(1), .pounds(1), .newlines(1)]))
            ),
            .stringSegment(StringSegmentSyntax(content: .stringSegment("Gamma ", trailingTrivia: [.backslashes(1), .pounds(1), .newlines(1)]))),
          ]),
          closeQuote: .multilineStringQuoteToken(),
          closeDelimiter: .rawStringDelimiter("#")
        )
      ),
      options: .substructureCheckTrivia
    )
  }
}
