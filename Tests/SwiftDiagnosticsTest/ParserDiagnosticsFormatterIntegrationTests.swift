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

import SwiftDiagnostics
import SwiftParser
import SwiftParserDiagnostics
import XCTest
import _SwiftSyntaxTestSupport

final class ParserDiagnosticsFormatterIntegrationTests: XCTestCase {

  func annotate(source: String, colorize: Bool = false) -> String {
    let tree = Parser.parse(source: source)
    let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
    return DiagnosticsFormatter.annotatedSource(tree: tree, diags: diags, colorize: colorize)
  }

  func testSingleDiagnostic() {
    let source = """
      var foo = bar +
      """
    let expectedOutput = """
      1 │ var foo = bar +
        │                ╰─ error: expected expression after operator

      """
    assertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testMultipleDiagnosticsInOneLine() {
    let source = """
      foo.[].[].[]
      """
    let expectedOutput = """
      1 │ foo.[].[].[]
        │     │  │  ╰─ error: expected name in member access
        │     │  ╰─ error: expected name in member access
        │     ╰─ error: expected name in member access

      """
    assertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testLineSkipping() {
    let source = """
      var i = 1
      i = 2
      i = foo(
      i = 4
      i = 5
      i = 6
      i = 7
      i = 8
      i = 9
      i = 10
      i = bar(
      """
    let expectedOutput = """
       2 │ i = 2
       3 │ i = foo(
       4 │ i = 4
         │      ╰─ error: expected ')' to end function call
       5 │ i = 5
       6 │ i = 6
         ┆
       9 │ i = 9
      10 │ i = 10
      11 │ i = bar(
         │         ╰─ error: expected value and ')' to end function call

      """
    assertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testTwoDiagnosticsAtSameLocation() throws {
    let source = "t as (..)"

    let expectedOutput = """
      1 │ t as (..)
        │       ├─ error: expected type in tuple type
        │       ╰─ error: unexpected code '..' in tuple type

      """

    assertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testAddsColoringToSingleErrorDiagnostic() {
    let source = """
      var foo = bar +
      """

    let expectedOutput = """
      \u{001B}[0;36m1 │\u{001B}[0;0m var foo = bar +
        \u{001B}[0;36m│\u{001B}[0;0m                ╰─ \u{001B}[1;31merror: \u{001B}[1;39mexpected expression after operator\u{001B}[0;0m

      """
    assertStringsEqualWithDiff(annotate(source: source, colorize: true), expectedOutput)
  }

  func testAddsColoringToMultipleDiagnosticsInOneLine() {
    let source = """
      foo.[].[].[]
      """
    let expectedOutput = """
      \u{001B}[0;36m1 │\u{001B}[0;0m foo.[].[].[]
        \u{001B}[0;36m│\u{001B}[0;0m     │  │  ╰─ \u{001B}[1;31merror: \u{001B}[1;39mexpected name in member access\u{001B}[0;0m
        \u{001B}[0;36m│\u{001B}[0;0m     │  ╰─ \u{001B}[1;31merror: \u{001B}[1;39mexpected name in member access\u{001B}[0;0m
        \u{001B}[0;36m│\u{001B}[0;0m     ╰─ \u{001B}[1;31merror: \u{001B}[1;39mexpected name in member access\u{001B}[0;0m

      """
    assertStringsEqualWithDiff(annotate(source: source, colorize: true), expectedOutput)
  }

  func testColoringWithHighlights() {
    let source = """
      for (i = 🐮; i != 👩‍👩‍👦‍👦; i += 1) { }
      """

    let expectedOutput = """
      \u{001B}[0;36m1 │\u{001B}[0;0m for \u{001B}[4;39m(i\u{001B}[0;0m \u{001B}[4;39m= 🐮; i != 👩‍👩‍👦‍👦; i += 1)\u{001B}[0;0m { }
        \u{001B}[0;36m│\u{001B}[0;0m │     ╰─ \u{001B}[1;31merror: \u{001B}[1;39mexpected ')' to end tuple pattern\u{001B}[0;0m
        \u{001B}[0;36m│\u{001B}[0;0m ╰─ \u{001B}[1;31merror: \u{001B}[1;39mC-style for statement has been removed in Swift 3\u{001B}[0;0m

      """

    assertStringsEqualWithDiff(annotate(source: source, colorize: true), expectedOutput)
  }

  func testRighParenLocation() {
    let source = """
      let _ : Float  -> Int
      """

    let expectedOutput = """
      1 │ let _ : Float  -> Int
        │         │    ╰─ error: expected ')' in function type
        │         ╰─ error: expected '(' to start function type

      """

    assertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testDontCrashIfFullLineHighlightContainsEmoji() {
    let source = """
      func o() {
      }👨‍👩‍👧‍👦}
      }
      """

    let expectedOutput = """
      1 │ func o() {
      2 │ }👨‍👩‍👧‍👦}
        │  │╰─ error: extraneous braces at top level
        │  ╰─ error: consecutive statements on a line must be separated by newline or ';'
      3 │ }

      """

    assertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testEmojiInSourceCode() {
    let source = """
      let 👨‍👩‍👧‍👦 = ;
      """

    let expectedOutput = """
      1 │ let 👨‍👩‍👧‍👦 = ;
        │         ╰─ error: expected expression in variable

      """

    assertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }
}
