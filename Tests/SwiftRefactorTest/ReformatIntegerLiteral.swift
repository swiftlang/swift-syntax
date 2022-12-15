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
      (#line, literal: "0b101010101" as IntegerLiteralExpr, expectation: "0b1_0101_0101" as IntegerLiteralExpr),
      (#line, literal: "0xFFFFFFFF" as IntegerLiteralExpr, expectation: "0xFFFF_FFFF" as IntegerLiteralExpr),
      (#line, literal: "0xFFFFF" as IntegerLiteralExpr, expectation: "0xF_FFFF" as IntegerLiteralExpr),
      (#line, literal: "0o777777" as IntegerLiteralExpr, expectation: "0o777_777" as IntegerLiteralExpr),
      (#line, literal: "424242424242" as IntegerLiteralExpr, expectation: "424_242_424_242" as IntegerLiteralExpr),
      (#line, literal: "100" as IntegerLiteralExpr, expectation: "100" as IntegerLiteralExpr),
      (#line, literal: "0xF_F_F_F_F_F_F_F" as IntegerLiteralExpr, expectation: "0xFFFF_FFFF" as IntegerLiteralExpr),
      (#line, literal: "0xFF_F_FF" as IntegerLiteralExpr, expectation: "0xF_FFFF" as IntegerLiteralExpr),
      (#line, literal: "0o7_77777" as IntegerLiteralExpr, expectation: "0o777_777" as IntegerLiteralExpr),
      (#line, literal: "4_24242424242" as IntegerLiteralExpr, expectation: "424_242_424_242" as IntegerLiteralExpr),
    ]

    for (line, literal, expectation) in tests {
      let refactored = try XCTUnwrap(AddSeparatorsToIntegerLiteral.refactor(syntax: literal))
      AssertStringsEqualWithDiff(refactored.description, expectation.description, line: UInt(line))
    }
  }

  func testSeparatorRemoval() throws {
    let tests = [
      (#line, literal: "0b1_0_1_0_1_0_1_0_1" as IntegerLiteralExpr, expectation: "0b101010101" as IntegerLiteralExpr),
      (#line, literal: "0xFFF_F_FFFF" as IntegerLiteralExpr, expectation: "0xFFFFFFFF" as IntegerLiteralExpr),
      (#line, literal: "0xFF_FFF" as IntegerLiteralExpr, expectation: "0xFFFFF" as IntegerLiteralExpr),
      (#line, literal: "0o777_777" as IntegerLiteralExpr, expectation: "0o777777" as IntegerLiteralExpr),
      (#line, literal: "424_242_424_242" as IntegerLiteralExpr, expectation: "424242424242" as IntegerLiteralExpr),
      (#line, literal: "100" as IntegerLiteralExpr, expectation: "100" as IntegerLiteralExpr),
    ]

    for (line, literal, expectation) in tests {
      let refactored = try XCTUnwrap(RemoveSeparatorsFromIntegerLiteral.refactor(syntax: literal))
      AssertStringsEqualWithDiff(refactored.description, expectation.description, line: UInt(line))
    }
  }
}
