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

import SwiftParser
import SwiftRefactor
import SwiftSyntaxBuilder
import SwiftSyntax

import XCTest
import _SwiftSyntaxTestSupport

final class FormatRawStringLiteralTest: XCTestCase {
  func testDelimiterPlacement() throws {
    let tests = [
      (#line, literal: #" "Hello World" "#, expectation: #" "Hello World" "#),
      (#line, literal: ##" #"Hello World" "##, expectation: #" "Hello World" "#),
      (#line, literal: ##" #"Hello World"# "##, expectation: #" "Hello World" "#),
      (#line, literal: #####" "####" "#####, expectation: #####" "####" "#####),
      (#line, literal: #####" #"####"# "#####, expectation: ######" #####"####"##### "######),
      (#line, literal: #####" #"\####(hello)"# "#####, expectation: ######" #####"\####(hello)"##### "######),
      (#line, literal: #######" #"###### \####(hello) ##"# "#######, expectation: ########" #######"###### \####(hello) ##"####### "########),
      (#line, literal: ########" #######"hello \(world) "####### "########, expectation: #" "hello \(world) " "#),
    ]

    for (line, literal, expectation) in tests {
      let literal = try XCTUnwrap(StringLiteralExpr.parseWithoutDiagnostics(from: literal))
      let expectation = try XCTUnwrap(StringLiteralExpr.parseWithoutDiagnostics(from: expectation))
      let refactored = try XCTUnwrap(FormatRawStringLiteral.refactor(syntax: literal))
      AssertStringsEqualWithDiff(refactored.description, expectation.description, line: UInt(line))
    }
  }
}

extension StringLiteralExpr {
  static func parseWithoutDiagnostics(from source: String) -> StringLiteralExpr? {
    var parser = Parser(source)
    return ExprSyntax.parse(from: &parser).as(StringLiteralExpr.self)
  }
}
