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

final class IntegerLiteralUtilitiesTest: XCTestCase {
  func testRadixMatching() {
    XCTAssertEqual(("0b1010101" as IntegerLiteralExpr).radix, .binary)
    XCTAssertEqual(("0xFF" as IntegerLiteralExpr).radix, .hex)
    XCTAssertEqual(("0o777" as IntegerLiteralExpr).radix, .octal)
    XCTAssertEqual(("42" as IntegerLiteralExpr).radix, .decimal)
  }

  func testSplit() {
    XCTAssertEqual(("0b1010101" as IntegerLiteralExpr).split().prefix, "0b")
    XCTAssertEqual(("0xFF" as IntegerLiteralExpr).split().prefix, "0x")
    XCTAssertEqual(("0o777" as IntegerLiteralExpr).split().prefix, "0o")
    XCTAssertEqual(("42" as IntegerLiteralExpr).split().prefix, "")
  }
}
