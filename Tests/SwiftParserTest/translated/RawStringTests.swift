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

// This test file has been translated from swift/test/StringProcessing/Parse/raw_string.swift

import XCTest

final class RawStringTests: XCTestCase {
  func testRawString1() {
    AssertParse(
      """
      import Swift
      """
    )
  }

  func testRawString2() {
    AssertParse(
      ##"""
      _ = #"""
      ###################################################################
      ## This source file is part of the Swift.org open source project ##
      ###################################################################
      """#
      """##
    )
  }

  func testRawString3() {
    AssertParse(
      ####"""
      _ = #"""
          # H1 #
          ## H2 ##
          ### H3 ###
          """#
      """####
    )
  }

  func testRawString5() {
    AssertParse(
      ###"""
      _ = ##"""
          One
          ""Alpha""
          """##
      """###
    )
  }

  func testRawString6() {
    AssertParse(
      ###"""
      _ = ##"""
          Two
        Beta
        """##
      """###
    )
  }

  func testRawString7() {
    AssertParse(
      ##"""
      _ = #"""
          Three\r
          Gamma\
        """#
      """##
    )
  }

  func testRawString8() {
    AssertParse(
      ####"""
      _ = ###"""
          Four \(foo)
          Delta
      """###
      """####
    )
  }

  func testRawString9() {
    AssertParse(
      ###"""
      _ = ##"""
        print("""
          Five\##n\##n\##nEpsilon
          """)
        """##
      """###
    )
  }

  func testRawString10() {
    AssertParse(
      """
      // ===---------- Single line --------===
      """
    )
  }

  func testRawString11() {
    AssertParse(
      ##"""
      _ = #""Zeta""#
      """##
    )
  }

  func testRawString12() {
    AssertParse(
      ##"""
      _ = #""Eta"\#n\#n\#n\#""#
      """##
    )
  }

  func testRawString13() {
    AssertParse(
      ##"""
      _ = #""Iota"\n\n\n\""#
      """##
    )
  }

  func testRawString14() {
    AssertParse(
      ##"""
      _ = #"a raw string with \" in it"#
      """##
    )
  }

  func testRawString15() {
    AssertParse(
      ###"""
      _ = ##"""
            a raw string with """ in it
            """##
      """###
    )
  }

  func testRawString16() {
    AssertParse(
      """
      // ===---------- False Multiline Delimiters --------===
      """
    )
  }

  func testRawString17() {
    AssertParse(
      ##"""
      /// Source code contains zero-width character in this format: `#"[U+200B]"[U+200B]"#`
      /// The check contains zero-width character in this format: `"[U+200B]\"[U+200B]"`
      /// If this check fails after you implement `diagnoseZeroWidthMatchAndAdvance`,
      /// then you may need to tweak how to test for single-line string literals that
      /// resemble a multiline delimiter in `advanceIfMultilineDelimiter` so that it
      /// passes again.
      /// See https://github.com/apple/swift/issues/51192.
      _ = #"​"​"#
      """##
    )
  }

  func testRawString18() {
    AssertParse(
      ##"""
      _ = #""""#
      """##
    )
  }

  func testRawString19() {
    AssertParse(
      ##"""
      _ = #"""""#
      """##
    )
  }

  func testRawString20() {
    AssertParse(
      ##"""
      _ = #""""""#
      """##
    )
  }

  func testRawString21() {
    AssertParse(
      ##"""
      _ = #"""#
      """##
    )
  }

  func testRawString22() {
    AssertParse(
      ###"""
      _ = ##""" foo # "# "##
      """###
    )
  }

  func testRawString23() {
    AssertParse(
      ####"""
      _ = ###""" "# "## "###
      """####
    )
  }

  func testRawString24() {
    AssertParse(
      ####"""
      _ = ###"""##"###
      """####
    )
  }

  func testRawString25() {
    AssertParse(
      ##"""
      _ = "interpolating \(#"""false delimiter"#)"
      """##
    )
  }

  func testRawString26() {
    AssertParse(
      ##"""
      _ = """
        interpolating \(#"""false delimiters"""#)
        """
      """##
    )
  }

  func testRawString27() {
    AssertParse(
      ##"""
      let foo = "Interpolation"
      _ = #"\b\b \#(foo)\#(foo) Kappa"#
      """##
    )
  }

  func testRawString28() {
    AssertParse(
      ###"""
      _ = """
        interpolating \(##"""
          delimited \##("string")\#n\##n
          """##)
        """
      """###
    )
  }

  func testRawString30() {
    AssertParse(
      ##"""
      #"unused literal"#
      """##
    )
  }

  func testRawString32() {
    AssertParse(
      ##"""
      _ = #"This is a string"#
      """##
    )
  }

  func testRawString33() {
    AssertParse(
      ######"""
      _ = #####"This is a string"#####
      """######
    )
  }

  func testRawString34() {
    AssertParse(
      ###"""
      _ = #"enum\s+.+\{.*case\s+[:upper:]"#
      _ = #"Alice: "How long is forever?" White Rabbit: "Sometimes, just one second.""#
      _ = #"\#\#1"#
      _ = ##"\#1"##
      _ = #"c:\windows\system32"#
      _ = #"\d{3) \d{3} \d{4}"#
      _ = #"""
          a string with
          """
          in it
          """#
      _ = #"a raw string containing \r\n"#
      _ = #"""
          [
              {
                  "id": "12345",
                  "title": "A title that \"contains\" \\\""
              }
          ]
          """#
      _ = #"# #"#
      """###
    )
  }
}
