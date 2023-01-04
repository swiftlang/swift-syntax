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

import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder

import XCTest
import _SwiftSyntaxTestSupport

final class ReformatIntegerLiteralTest: XCTestCase {
  func testSeparatorPlacement() throws {
    let tests = [
      (#line, literal: "0b101010101" as IntegerLiteralExprSyntax, expectation: "0b1_0101_0101" as IntegerLiteralExprSyntax),
      (#line, literal: "0xFFFFFFFF" as IntegerLiteralExprSyntax, expectation: "0xFFFF_FFFF" as IntegerLiteralExprSyntax),
      (#line, literal: "0xFFFFF" as IntegerLiteralExprSyntax, expectation: "0xF_FFFF" as IntegerLiteralExprSyntax),
      (#line, literal: "0o777777" as IntegerLiteralExprSyntax, expectation: "0o777_777" as IntegerLiteralExprSyntax),
      (#line, literal: "424242424242" as IntegerLiteralExprSyntax, expectation: "424_242_424_242" as IntegerLiteralExprSyntax),
      (#line, literal: "100" as IntegerLiteralExprSyntax, expectation: "100" as IntegerLiteralExprSyntax),
      (#line, literal: "0xF_F_F_F_F_F_F_F" as IntegerLiteralExprSyntax, expectation: "0xFFFF_FFFF" as IntegerLiteralExprSyntax),
      (#line, literal: "0xFF_F_FF" as IntegerLiteralExprSyntax, expectation: "0xF_FFFF" as IntegerLiteralExprSyntax),
      (#line, literal: "0o7_77777" as IntegerLiteralExprSyntax, expectation: "0o777_777" as IntegerLiteralExprSyntax),
      (#line, literal: "4_24242424242" as IntegerLiteralExprSyntax, expectation: "424_242_424_242" as IntegerLiteralExprSyntax),
    ]

    for (line, literal, expectation) in tests {
      let refactored = try XCTUnwrap(AddSeparatorsToIntegerLiteral.refactor(syntax: literal))
      AssertStringsEqualWithDiff(refactored.description, expectation.description, line: UInt(line))
    }
  }

  func testSeparatorRemoval() throws {
    let tests = [
      (#line, literal: "0b1_0_1_0_1_0_1_0_1" as IntegerLiteralExprSyntax, expectation: "0b101010101" as IntegerLiteralExprSyntax),
      (#line, literal: "0xFFF_F_FFFF" as IntegerLiteralExprSyntax, expectation: "0xFFFFFFFF" as IntegerLiteralExprSyntax),
      (#line, literal: "0xFF_FFF" as IntegerLiteralExprSyntax, expectation: "0xFFFFF" as IntegerLiteralExprSyntax),
      (#line, literal: "0o777_777" as IntegerLiteralExprSyntax, expectation: "0o777777" as IntegerLiteralExprSyntax),
      (#line, literal: "424_242_424_242" as IntegerLiteralExprSyntax, expectation: "424242424242" as IntegerLiteralExprSyntax),
      (#line, literal: "100" as IntegerLiteralExprSyntax, expectation: "100" as IntegerLiteralExprSyntax),
    ]

    for (line, literal, expectation) in tests {
      let refactored = try XCTUnwrap(RemoveSeparatorsFromIntegerLiteral.refactor(syntax: literal))
      AssertStringsEqualWithDiff(refactored.description, expectation.description, line: UInt(line))
    }
  }
}
