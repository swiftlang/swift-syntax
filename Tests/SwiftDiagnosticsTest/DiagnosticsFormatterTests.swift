//===------------------ DiagnosticsFormatterTests.swift -------------------===//
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
import SwiftDiagnostics
import SwiftParser

final class DiagnosticsFormatterTests: XCTestCase {
  
  func annotate(source: String) throws -> String {
    let tree = Parser.parse(source: source)
    let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
    return DiagnosticsFormatter.annotatedSource(tree: tree, diags: diags)
  }
  
  func testSingleDiagnostic() throws {
    let source = """
    var foo = bar +
    """
    let expectedOutput = """
    1 │ var foo = bar +
      ∣                ╰─ expected expression in variable
    
    """
    XCTAssertEqual(expectedOutput, try annotate(source: source))
  }
  
  func testMultipleDiagnosticsInOneLine() throws {
    let source = """
    foo.[].[].[]
    """
    let expectedOutput = """
    1 │ foo.[].[].[]
      ∣     │  │  ╰─ expected identifier in member access
      ∣     │  ╰─ expected identifier in member access
      ∣     ╰─ expected identifier in member access
    
    """
    XCTAssertEqual(expectedOutput, try annotate(source: source))
  }
  
  func testLineSkipping() throws {
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
       ∣         ├─ expected value in function call
       ∣         ╰─ expected ')' to end function call

    """
    XCTAssertEqual(expectedOutput, try annotate(source: source))
  }
}
