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

import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder

import XCTest
import _SwiftSyntaxTestSupport

final class ReformatIntegerLiteralTest: XCTestCase {
  func testSeparatorPlacement() throws {
    let tests = [
      (#line, literal: ExprSyntax("0b101010101").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0b1_0101_0101").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0xFFFFFFFF").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0xFFFF_FFFF").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0xFFFFF").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0xF_FFFF").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0o777777").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0o777_777").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("424242424242").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("424_242_424_242").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("100").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("100").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0xF_F_F_F_F_F_F_F").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0xFFFF_FFFF").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0xFF_F_FF").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0xF_FFFF").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0o7_77777").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0o777_777").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("4_24242424242").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("424_242_424_242").cast(IntegerLiteralExprSyntax.self)),
    ]

    for (line, literal, expectation) in tests {
      try assertRefactor(literal, context: (), provider: AddSeparatorsToIntegerLiteral.self, expected: expectation, line: UInt(line))
    }
  }

  func testSeparatorRemoval() throws {
    let tests = [
      (#line, literal: ExprSyntax("0b1_0_1_0_1_0_1_0_1").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0b101010101").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0xFFF_F_FFFF").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0xFFFFFFFF").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0xFF_FFF").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0xFFFFF").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("0o777_777").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("0o777777").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("424_242_424_242").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("424242424242").cast(IntegerLiteralExprSyntax.self)),
      (#line, literal: ExprSyntax("100").cast(IntegerLiteralExprSyntax.self), expectation: ExprSyntax("100").cast(IntegerLiteralExprSyntax.self)),
    ]

    for (line, literal, expectation) in tests {
      try assertRefactor(literal, context: (), provider: RemoveSeparatorsFromIntegerLiteral.self, expected: expectation, line: UInt(line))
    }
  }
}
