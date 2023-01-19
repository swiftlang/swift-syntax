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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class StringLiteralTests: XCTestCase {
  func testStringLiteral() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let testCases: [UInt: (String, String)] = [
      #line: ("", #"␣"""#),
      #line: ("asdf", #"␣"asdf""#),
    ]

    for (line, testCase) in testCases {
      let (value, expected) = testCase
      let string = TokenSyntax.stringSegment(value)
      let segment = StringSegmentSyntax(content: string)
      let builder = StringLiteralExprSyntax(
        leadingTrivia: leadingTrivia,
        openQuote: .stringQuoteToken(),
        segments: StringLiteralSegmentsSyntax([.stringSegment(segment)]),
        closeQuote: .stringQuoteToken()
      )

      AssertBuildResult(builder, expected, line: line)
    }
  }

  func testRegular() {
    AssertBuildResult(
      StringLiteralExprSyntax(content: "foobar"),
      """
      "foobar"
      """
    )

    AssertBuildResult(
      StringLiteralExprSyntax(content: "##foobar"),
      """
      "##foobar"
      """
    )
  }

  func testEscapeLiteral() {
    AssertBuildResult(
      StringLiteralExprSyntax(content: #""""foobar""#),
      ##"""
      #""""foobar""#
      """##
    )
  }

  func testEscapePounds() {
    AssertBuildResult(
      StringLiteralExprSyntax(content: ###"#####"foobar"##foobar"#foobar"###),
      #####"""
      ###"#####"foobar"##foobar"#foobar"###
      """#####
    )
  }

  func testEscapeInteropolation() {
    AssertBuildResult(
      StringLiteralExprSyntax(content: ###"\##(foobar)\#(foobar)"###),
      ####"""
      ###"\##(foobar)\#(foobar)"###
      """####
    )
  }

  func testEscapeBackslash() {
    AssertBuildResult(
      StringLiteralExprSyntax(content: #"\"#),
      ##"""
      #"\"#
      """##
    )

    AssertBuildResult(
      StringLiteralExprSyntax(content: ##"\#n"##),
      ##"""
      ##"\#n"##
      """##
    )

    AssertBuildResult(
      StringLiteralExprSyntax(content: ##"\#\"##),
      ##"""
      ##"\#\"##
      """##
    )

    AssertBuildResult(
      StringLiteralExprSyntax(content: ##"\#"##),
      ##"""
      ##"\#"##
      """##
    )
  }

  func testNewlines() {
    AssertBuildResult(
      StringLiteralExprSyntax(content: "linux\nwindows\r\nunicode\u{2028}a"),
      #""linux\nwindows\r\nunicode\u{2028}a""#
    )

    AssertBuildResult(
      StringLiteralExprSyntax(content: "\\linux\nwindows\r\nunicode\u{2028}a"),
      ##"#"\linux\#nwindows\#r\#nunicode\#u{2028}a"#"##
    )
  }

  func testNul() {
    AssertBuildResult(
      StringLiteralExprSyntax(content: "before\0after"),
      #""before\0after""#
    )

    AssertBuildResult(
      StringLiteralExprSyntax(content: "\\before\0after"),
      ##"#"\before\#0after"#"##
    )
  }

  func testControlChars() {
    // Note that tabs do *not* get escaped.
    AssertBuildResult(
      StringLiteralExprSyntax(content: "before\u{07}\t\u{7f}after"),
      #""before\u{7}\t\u{7f}after""#
    )

    AssertBuildResult(
      StringLiteralExprSyntax(content: "\\before\u{07}\t\u{7f}after"),
      ##"#"\before\#u{7}\#t\#u{7f}after"#"##
    )
  }

  func testEscapeTab() {
    // Tab should be escaped in single-line string literals
    AssertBuildResult(
      StringLiteralExprSyntax(content: "a\tb"),
      #"""
      "a\tb"
      """#
    )

    // Tab should not be escaped in single-line string literals
    AssertBuildResult(
      StringLiteralExprSyntax(
        openQuote: .multilineStringQuoteToken(trailingTrivia: .newline),
        content: "a\tb",
        closeQuote: .multilineStringQuoteToken(leadingTrivia: .newline)
      ),
      #"""
      """
      a\#tb
      """
      """#
    )
  }
}
