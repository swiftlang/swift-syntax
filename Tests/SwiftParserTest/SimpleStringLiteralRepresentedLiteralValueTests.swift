//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
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

class SimpleStringLiteralRepresentedLiteralValueTests: ParserTestCase {
  func testBasic() {
    test(###"""
    #sourceLocation(file: "foo.swift", line: 0)
    """###, "foo.swift")
  }

  func testBasicUnicode() {
    test(###"""
    #sourceLocation(file: "foo\u{002E}swift", line: 0)
    """###, "foo.swift")
  }

  func testMultiline() {
    test(###"""
    #sourceLocation(file: """
      foo.swift
      """, line: 0)
    """###, "foo.swift")
  }

  func testMultilineEscaped() {
    test(###"""
    #sourceLocation(file: """
      foo.\
      swift
      """, line: 0)
    """###, "foo.swift")
  }

  func test(_ source: String, _ expectedValue: String, file: StaticString = #filePath, line: UInt = #line) {
    let parsed = Parser.parse(source: source)
    guard let literalExpr: SimpleStringLiteralExprSyntax = parsed.statements.first?.item.as(PoundSourceLocationSyntax.self)?.arguments?.fileName else {
      return XCTFail("target literal expression not found", file: file, line: line)
    }
    XCTAssertEqual(literalExpr.representedLiteralValue, expectedValue, file: file, line: line)
  }
}
