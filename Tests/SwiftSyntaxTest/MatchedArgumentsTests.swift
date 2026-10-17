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
import SwiftSyntax
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import _SwiftSyntaxTestSupport

final class MatchedArgumentsTests: XCTestCase {
  func testWithSingleName() {
    let arg = LabeledExprListSyntax {
      LabeledExprSyntax(label: "x", expression: ExprSyntax("2"))
    }

    let arguments = arg.matchArguments(against: "(x: Int)")

    XCTAssertEqual(arguments.argument(for: "x")?.first?.description, "2")
  }

  func testWithTwoNames() {
    let arg = LabeledExprListSyntax {
      LabeledExprSyntax(
        label: "x",
        expression: ExprSyntax("2")
      )
    }

    let arguments = arg.matchArguments(against: "(x y: Int)")

    XCTAssertEqual(arguments.argument(for: "y")?.first?.description, "2")
    XCTAssertNil(arguments.argument(for: "x"))
  }

  func testWithMultipleArguments() {
    let arg = LabeledExprListSyntax {
      LabeledExprSyntax(
        label: "x",
        expression: ExprSyntax("2")
      )

      LabeledExprSyntax(
        label: "x",
        expression: ExprSyntax("3")
      )
    }

    let arguments = arg.matchArguments(against: "(x y: Int, x z: Int)")

    XCTAssertEqual(arguments.argument(for: "y")?.first?.description, "2")
    XCTAssertEqual(arguments.argument(for: "z")?.first?.description, "3")
  }

  func testWithVariadicArguments() {
    let arg = LabeledExprListSyntax {
      LabeledExprSyntax(
        label: "x",
        expression: ExprSyntax("2")
      )

      LabeledExprSyntax(
        expression: ExprSyntax("3")
      )
    }

    let arguments = arg.matchArguments(against: "(x: Int...)")

    XCTAssertEqual(arguments.argument(for: "x")?.first?.description, "2")
    XCTAssertEqual(arguments.argument(for: "x")?.last?.description, "3")
  }

  func testWithSubscript() {
    let arg = LabeledExprListSyntax {
      LabeledExprSyntax(
        label: "x",
        expression: ExprSyntax("2")
      )
    }

    let arguments = arg.matchArguments(against: "(x: Int)", isSubscript: true)

    XCTAssertEqual(arguments.argument(for: "x")?.first?.description, "2")
  }

  func testWithMultipleArgumentsWithNoLabel() {
    let arg = LabeledExprListSyntax {
      LabeledExprSyntax(
        expression: ExprSyntax("2")
      )

      LabeledExprSyntax(
        expression: ExprSyntax("3")
      )
    }

    let arguments = arg.matchArguments(against: "(_ x: Int, _ y: Int)")

    XCTAssertEqual(arguments.argument(for: "y")?.first?.description, "2")
    XCTAssertEqual(arguments.argument(for: "z")?.first?.description, "3")
  }
}
