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

import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

/// Test ``StringLiteralExprSyntax/representedLiteralValue``.
///
/// Most tests are expressed by a single function call that compares the
/// run-time String value against the parsed node's `representedLiteralValue`.
class StringLiteralRepresentedLiteralValueTests: ParserTestCase {

  func testIntro() {
    test(
      #"""
      This test suite verifies the correctness of ``StringLiteralExprSyntax/\
      representedLiteralValue.`` It does so by comparing the run-time String
      value of various string literals to the value returned from
      `representedLiteralValue`.

      The SwiftSyntax parsed representation `StringLiteralExprSyntax` contains
      the source-accurate representation of the string literal. This
      representation differs from the runtime value:

        - Escaped character sequences (\n, \u{1F600}) are not evaluated.
        - Some strings are split into segments (i.e. multiline strings).

      The idea of `representedLiteralValue` is to create the run-time value of a
      string literal during parse time. Obviously this is only possible for
      static Strings so interpolated strings do not work.
      """#
    )
  }

  // MARK: double quoted string literal

  func testDoubleQuoted_emptyString() {
    test("")
  }

  func testDoubleQuoted_singleSpace() {
    test(" ")
  }

  func testDoubleQuoted_singleQuote() {
    test("'")
  }

  func testDoubleQuoted_emoji() {
    test("😀")
  }

  func testDoubleQuoted_escapedNul() {
    test("\0")
  }

  func testDoubleQuoted_escapedNL() {
    test("\n")
  }

  func testDoubleQuoted_escapedCR() {
    test("\r")
  }

  func testDoubleQuoted_escapedTab() {
    test("\t")
  }

  func testDoubleQuoted_escapedDoubleQuote() {
    test("\"")
  }

  func testDoubleQuoted_escapedSingleQuote() {
    test("\'")
  }

  func testDoubleQuoted_escapedEscape() {
    test("\\")
  }

  func testDoubleQuoted_escapedUnicodeDot() {
    test("\u{2e}")
  }

  func testDoubleQuoted_escapedEmoji() {
    test("\u{1F600}")
  }

  // MARK: raw double quoted string literal

  func testRawDoubleQuoted_emptyString() {
    test(#""#)
  }

  func testRawDoubleQuoted_singleSpace() {
    test(#" "#)
  }

  func testRawDoubleQuoted_unescapedDoubleQuote() {
    test(#"""#)
  }

  func testRawDoubleQuoted_unescapedBackslash() {
    test(#"\"#)
  }

  func testRawDoubleQuoted_emoji() {
    test(#"😀"#)
  }

  func testRawDoubleQuoted_escapedNul() {
    test(#"\#0"#)
  }

  func testRawDoubleQuoted_escapedNL() {
    test(#"\#n"#)
  }

  func testRawDoubleQuoted_escapedCR() {
    test(#"\#r"#)
  }

  func testRawDoubleQuoted_escapedTab() {
    test(#"\#t"#)
  }

  func testRawDoubleQuoted_escapedDoubleQuote() {
    test(#"\#""#)
  }

  func testRawDoubleQuoted_escapedSingleQuote() {
    test(#"\#'"#)
  }

  func testRawDoubleQuoted_escapedEscape() {
    test(#"\#\#"#)
  }

  func testRawDoubleQuoted_escapedUnicodeDot() {
    test(#"\#u{2e}"#)
  }

  func testRawDoubleQuoted_escapedEmoji() {
    test(#"\#u{1F600}"#)
  }

  // MARK: multi line string literal

  func testMultiLine_emptyString() {
    test(
      """

      """
    )
  }

  func testMultiLine_emptyLine() {
    test(
      """


      """
    )
  }

  func testMultiLine_helloWorld() {
    test(
      """
      Hello, world!
      """
    )
  }

  func testMultiLine_indentedLines() {
    test(
      """
      not indented
        2 spaces indented
          4 spaces indented
      """
    )
  }

  func testMultiLine_escapedLine() {
    test(
      """
      Line 1\
      .still on Line 1
      """
    )
  }

  // MARK: raw multi line string literal

  func testRawMultiLine_emptyString() {
    test(
      #"""

      """#
    )
  }

  func testRawMultiLine_emptyLine() {
    test(
      #"""


      """#
    )
  }

  func testRawMultiLine_helloWorld() {
    test(
      #"""
      Hello, world!
      """#
    )
  }

  func testRawMultiLine_indentedLines() {
    test(
      #"""
      not indented
        2 spaces indented
          4 spaces indented
      """#
    )
  }

  func testRawMultiLine_escapedLine() {
    test(
      #"""
      Line 1\
      .still on Line 1
      """#
    )
  }

  // MARK: literal value not available

  func testMissingQuoteStringLiteral() throws {
    var parser = Parser(#""a"#)
    let stringLiteral = StringLiteralExprSyntax(ExprSyntax.parse(from: &parser))!
    XCTAssertNil(stringLiteral.representedLiteralValue, "only fully parsed string literals should produce a literal value")
  }

  func testInterpolatedStringLiteral() throws {
    let stringLiteral = StringLiteralExprSyntax(#""abc\(1)""# as ExprSyntax)!
    XCTAssertNil(stringLiteral.representedLiteralValue, "interpolated string literals cannot produce a literal value")
  }

  func testMalformedMultiLineStringLiteral() throws {
    var parser = Parser(#""""a""""#)
    let stringLiteral = StringLiteralExprSyntax(ExprSyntax.parse(from: &parser))!
    XCTAssertNil(stringLiteral.representedLiteralValue, "missing newline in multiline string literal cannot produce a literal value")
  }

  // MARK: supporting code

  /// This helper function takes a string literal argument and compares its
  /// value with the parsed node of type StringLiteralExprSyntax. To produce the
  /// node it parses the contents of this source file and matches the literal by
  /// position in source.
  func test(_ expected: StaticString, file: StaticString = #filePath, line: UInt = #line) {
    guard let literal = literals[at: line] else {
      fatalError("string literal not found at line \(line)")
    }

    guard let representedLiteralValue = literal.representedLiteralValue else {
      XCTFail("literal unexpectedly product nil value", file: file, line: line)
      return
    }

    XCTAssertEqual(representedLiteralValue, expected.description, file: file, line: line)
  }

  let literals = try! StringLiteralCollector()

  /// Helper class to find string literals in this source file
  class StringLiteralCollector: SyntaxVisitor {
    var locationConverter: SourceLocationConverter? = nil
    var literals: [UInt: [StringLiteralExprSyntax]] = [:]

    init(file: String = #filePath) throws {
      let url = URL(fileURLWithPath: file)
      let fileData = try Data(contentsOf: url)
      let source = fileData.withUnsafeBytes {
        String(decoding: $0.bindMemory(to: UInt8.self), as: UTF8.self)
      }
      let syntax = Parser.parse(source: source)

      super.init(viewMode: .sourceAccurate)

      self.locationConverter = SourceLocationConverter(fileName: "", tree: syntax)
      self.walk(syntax)
      self.locationConverter = nil
    }

    subscript(at line: UInt, index: Int = 0) -> StringLiteralExprSyntax? {
      literals[line]?[index]
    }

    override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
      let line = UInt(locationConverter?.location(for: node.position).line ?? 0)
      literals[line, default: []].append(node)
      return .visitChildren
    }
  }
}
