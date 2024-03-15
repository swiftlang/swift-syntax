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

final class MultilineStringTests: ParserTestCase {
  func testMultilineString1() {
    assertParse(
      """
      import Swift
      """
    )
  }

  func testMultilineString2() {
    assertParse(
      """
      // ===---------- Multiline --------===
      """
    )
  }

  func testMultilineString3() {
    assertParse(
      #"""
      _ = """
          One
          ""Alpha""
          """
      """#
    )
  }

  func testMultilineString4() {
    assertParse(
      #"""
      _ = """
          Two
        Beta
        """
      """#
    )
  }

  func testMultilineString5() {
    assertParse(
      #"""
      _ = """
          Three
          Gamma.
        """
      """#
    )
  }

  func testMultilineString6() {
    assertParse(
      #"""
      _ = """
          Four
          Delta
      """
      """#
    )
  }

  func testMultilineString7() {
    assertParse(
      #"""
      _ = """
          Five\n

          Epsilon
          """
      """#
    )
  }

  func testMultilineString9() {
    assertParse(
      #"""
      _ = """
          Six
          Zeta

          """
      """#
    )
  }

  func testMultilineString11() {
    assertParse(
      #"""
      _ = """
          Seven
          Eta\n
          """
      """#
    )
  }

  func testMultilineString12() {
    assertParse(
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
    assertParse(
      #"""
      _ = """
           \("Nine")
          Kappa
          """
      """#
    )
  }

  func testMultilineString14() {
    assertParse(
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
    assertParse(
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
    assertParse(
      #"""
      _ = """
      \\
      """
      """#
    )
  }

  func testMultilineString17() {
    assertParse(
      #"""
      _ = """
        \\
        """
      """#
    )
  }

  func testMultilineString18() {
    assertParse(
      #"""
      _ = """

        ABC
        """
      """#
    )
  }

  func testMultilineString20() {
    assertParse(
      #"""
      _ = """

      ABC
      """
      """#
    )
  }

  func testMultilineString22() {
    assertParse(
      #"""
      _ = """

        ABC
        """
      """#
    )
  }

  func testMultilineString24() {
    assertParse(
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
    assertParse(
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
    assertParse(
      #"""
      _ = """
        trailing \
        \("""
          substring1 \
          \("""
            substring2 \         \#u{20}
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
    assertParse(
      #"""
      _ = """
          foo

          bar
          """
      """#
    )
  }

  func testMultilineString29() {
    // contains trailing whitespace
    assertParse(
      #"""
      _ = """
          foo\\#u{20}
         \#u{20}
          bar
          """
      """#
    )
  }

  func testMultilineString31() {
    assertParse(
      #"""
      _ = """
          foo \
            bar
          """
      """#
    )
  }

  func testMultilineString32() {
    assertParse(
      #"""
      _ = """

        ABC
        """
      """#
    )
  }

  func testMultilineString34() {
    assertParse(
      #"""
      _ = """

          ABC

          """
      """#
    )
  }

  func testMultilineString37() {
    assertParse(
      #"""
      _ = """


          """
      """#
    )
  }

  func testMultilineString39() {
    assertParse(
      #"""
      _ = """

          """
      """#
    )
  }

  func testMultilineString41() {
    assertParse(
      #"""
      _ = """
          """
      """#
    )
  }

  func testMultilineString42() {
    assertParse(
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
    assertParse(
      #"""
      _ = "hello\("""
        world
        """)"
      """#
    )
  }

  func testMultilineString44() {
    assertParse(
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
    assertParse(
      #"""
      _ = "hello\("""
                  "world'
                  """)abc"
      """#
    )
  }

  func testMultilineString46() {
    assertParse(
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

  func testMultilineString47() {
    assertParse(
      #"""
      _ = """1️⃣"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal closing delimiter must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: #"""
        _ = """
        """
        """#
    )
  }

  func testMultilineString48() {
    assertParse(
      #"""
      _ = """A1️⃣"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal closing delimiter must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: #"""
        _ = """A
        """
        """#
    )
  }

  func testMultilineString49() {
    assertParse(
      #"""
      _ = ℹ️"""1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        )
      ],
      fixedSource: #"""
        _ = """
        """
        """#
    )
  }

  func testMultilineString50() {
    assertParse(
      #"""
      _ = ℹ️"""
      A1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        )
      ],
      fixedSource: #"""
        _ = """
        A
        """
        """#
    )
  }

  func testEscapeNewlineInRawString() {
    assertParse(
      ##"""
      #"""
      Three \#
      Gamma
      """#
      """##,
      substructure: StringLiteralExprSyntax(
        openingPounds: .rawStringPoundDelimiter("#"),
        openingQuote: .multilineStringQuoteToken(trailingTrivia: .newline),
        segments: StringLiteralSegmentListSyntax([
          .stringSegment(
            StringSegmentSyntax(
              content: .stringSegment("Three ", trailingTrivia: [.backslashes(1), .pounds(1), .newlines(1)])
            )
          ),
          .stringSegment(StringSegmentSyntax(content: .stringSegment("Gamma", trailingTrivia: .newline))),
        ]),
        closingQuote: .multilineStringQuoteToken(),
        closingPounds: .rawStringPoundDelimiter("#")
      ),
      options: .substructureCheckTrivia
    )
  }

  func testEscapeLastNewlineInRawString() {
    // We really shouldn't be allow the last newline in the multi-line string
    // literal to be escaped in a multi-line string literal. But since the C++
    // parser accepts this, so does SwiftParser.
    assertParse(
      ##"""
      #"""
      Three \#
      Gamma \#
      """#
      """##,
      substructure: StringLiteralExprSyntax(
        openingPounds: .rawStringPoundDelimiter("#"),
        openingQuote: .multilineStringQuoteToken(trailingTrivia: .newline),
        segments: StringLiteralSegmentListSyntax([
          .stringSegment(
            StringSegmentSyntax(
              content: .stringSegment("Three ", trailingTrivia: [.backslashes(1), .pounds(1), .newlines(1)])
            )
          ),
          .stringSegment(
            StringSegmentSyntax(
              content: .stringSegment("Gamma ", trailingTrivia: [.backslashes(1), .pounds(1), .newlines(1)])
            )
          ),
        ]),
        closingQuote: .multilineStringQuoteToken(),
        closingPounds: .rawStringPoundDelimiter("#")
      ),
      options: .substructureCheckTrivia
    )
  }
}
