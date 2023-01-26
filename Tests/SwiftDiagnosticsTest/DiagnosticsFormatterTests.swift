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

import _SwiftSyntaxTestSupport
import XCTest
import SwiftDiagnostics
import SwiftParser
import SwiftParserDiagnostics

final class DiagnosticsFormatterTests: XCTestCase {

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
        ∣                ╰─ expected expression after operator

      """
    AssertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testMultipleDiagnosticsInOneLine() {
    let source = """
      foo.[].[].[]
      """
    let expectedOutput = """
      1 │ foo.[].[].[]
        ∣     │  │  ╰─ expected name in member access
        ∣     │  ╰─ expected name in member access
        ∣     ╰─ expected name in member access

      """
    AssertStringsEqualWithDiff(annotate(source: source), expectedOutput)
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
         ∣      ╰─ expected ')' to end function call
       5 │ i = 5
       6 │ i = 6
         ┆
       9 │ i = 9
      10 │ i = 10
      11 │ i = bar(
         ∣         ╰─ expected value and ')' to end function call

      """
    AssertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testTwoDiagnosticsAtSameLocation() throws {
    let source = "t as (..)"

    let expectedOutput = """
      1 │ t as (..)
        ∣       ├─ expected type in tuple type
        ∣       ╰─ unexpected code '..' in tuple type

      """

    AssertStringsEqualWithDiff(annotate(source: source), expectedOutput)
  }

  func testAddsColoringToSingleErrorDiagnostic() {
    let source = """
      var foo = bar +
      """

    let expectedOutput = """
      1 │ var foo = bar +
        ∣                ╰─ \u{001B}[1;31merror: expected expression after operator\u{001B}[0;0m

      """
    AssertStringsEqualWithDiff(annotate(source: source, colorize: true), expectedOutput)
  }

  func testAddsColoringToMultipleDiagnosticsInOneLine() {
    let source = """
      foo.[].[].[]
      """
    let expectedOutput = """
      1 │ foo.[].[].[]
        ∣     │  │  ╰─ \u{001B}[1;31merror: expected name in member access\u{001B}[0;0m
        ∣     │  ╰─ \u{001B}[1;31merror: expected name in member access\u{001B}[0;0m
        ∣     ╰─ \u{001B}[1;31merror: expected name in member access\u{001B}[0;0m

      """
    AssertStringsEqualWithDiff(annotate(source: source, colorize: true), expectedOutput)
  }
}
