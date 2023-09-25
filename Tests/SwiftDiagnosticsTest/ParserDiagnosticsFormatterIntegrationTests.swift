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
    let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: tree)
    return DiagnosticsFormatter.annotatedSource(tree: tree, diags: diagnostics, colorize: colorize)
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
      i = 3
      i = 4
      i = foo(
      i = 6
      i = 7
      i = 8
      i = 9
      i = 10
      i = 11
      i = 12
      i = bar(
      i = 14
      i = 15
      i = 16
      i = 17
      i = 18
      """
    let expectedOutput = """
       3 │ i = 3
       4 │ i = 4
       5 │ i = foo(
         │        ╰─ note: to match this opening '('
       6 │ i = 6
         │      ╰─ error: expected ')' to end function call
       7 │ i = 7
       8 │ i = 8
         ┆
      11 │ i = 11
      12 │ i = 12
      13 │ i = bar(
         │        ╰─ note: to match this opening '('
      14 │ i = 14
         │       ╰─ error: expected ')' to end function call
      15 │ i = 15
      16 │ i = 16

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

  func testCStyleForLoopWithEmojiVariables() {
    let source = """
      for (i = 🐮; i != 👩‍👩‍👦‍👦; i += 1) { }
      """

    let expectedOutput = """
      1 │ for (i = 🐮; i != 👩‍👩‍👦‍👦; i += 1) { }
        │ │   │ ╰─ error: expected ')' to end tuple pattern
        │ │   ╰─ note: to match this opening '('
        │ ╰─ error: C-style for statement has been removed in Swift 3

      """

    assertStringsEqualWithDiff(annotate(source: source, colorize: false), expectedOutput)
  }

  func testClassDefinitionWithInvalidInheritanceAndCStyleForLoop() {
    let source = """
      class Iterator: {
        var counter = 0
        var wasCounterCalled: Bool { counter > 0 }

        init(counter: Int = 0) {
          self.counter = counter
        }

        // Description of the `loopOver` function
        func loopOver() {
          for (i = 🐮; i != 👩‍👩‍👦‍👦; i += 1) { }
        }
      }
      """

    let expectedOutput =
      """
       1 │ class Iterator: {
         │                 ╰─ error: expected type in inherited type
       2 │   var counter = 0
       3 │   var wasCounterCalled: Bool { counter > 0 }
         ┆
       9 │   // Description of the `loopOver` function
      10 │   func loopOver() {
      11 │     for (i = 🐮; i != 👩‍👩‍👦‍👦; i += 1) { }
         │     │   │ ╰─ error: expected ')' to end tuple pattern
         │     │   ╰─ note: to match this opening '('
         │     ╰─ error: C-style for statement has been removed in Swift 3
      12 │   }
      13 │ }

      """

    assertStringsEqualWithDiff(annotate(source: source, colorize: false), expectedOutput)
  }

  func testColoringWithHighlights() {
    let source = """
      for (i = 🐮; i != 👩‍👩‍👦‍👦; i += 1) { }
      """

    let expectedOutput = """
      \u{001B}[0;36m1 │\u{001B}[0;0m for \u{001B}[4;39m(i\u{001B}[0;0m \u{001B}[4;39m= 🐮; i != 👩‍👩‍👦‍👦; i += 1)\u{001B}[0;0m { }
        \u{001B}[0;36m│\u{001B}[0;0m │   │ ╰─ \u{001B}[1;31merror: \u{001B}[1;39mexpected ')' to end tuple pattern\u{001B}[0;0m
        \u{1B}[0;36m│\u{1B}[0;0m │   ╰─ \u{1B}[1;39mnote: \u{1B}[1;39mto match this opening \'(\'\u{1B}[0;0m
        \u{001B}[0;36m│\u{001B}[0;0m ╰─ \u{001B}[1;31merror: \u{001B}[1;39mC-style for statement has been removed in Swift 3\u{001B}[0;0m

      """

    assertStringsEqualWithDiff(annotate(source: source, colorize: true), expectedOutput)
  }

  func testRightParenLocation() {
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
}
