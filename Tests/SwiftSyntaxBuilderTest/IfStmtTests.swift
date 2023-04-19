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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class IfStmtTests: XCTestCase {
  func testEmptyIfExpr() {
    // Use the convenience initializer from IfStmtConvenienceInitializers. This is
    // disambiguated by the absence of a labelName parameter and the use of a
    // trailing closure.
    let buildable = IfExprSyntax(conditions: ConditionElementListSyntax { BooleanLiteralExprSyntax(false) }) {}
    assertBuildResult(
      buildable,
      """
      if false {
      }
      """
    )
  }

  func testIfStmtSyntax() throws {
    let testCases: [UInt: (IfExprSyntax, String)] = [
      #line: (
        ExprSyntax(
          """
          if foo == x {
            return foo
          }
          """
        ).cast(IfExprSyntax.self),
        """
        if foo == x {
          return foo
        }
        """
      ),
      #line: (
        ExprSyntax(
          """
          if foo == x {
            return foo
          }
          else {
            return bar
          }
          """
        ).cast(IfExprSyntax.self),
        """
        if foo == x {
          return foo
        }
        else {
          return bar
        }
        """
      ),
      #line: (
        try IfExprSyntax("if foo == x") { StmtSyntax("return foo") },
        """
        if foo == x {
            return foo
        }
        """
      ),
      #line: (
        try IfExprSyntax("if foo == x") {
          StmtSyntax("return foo")
        } else: {
          StmtSyntax("return bar")
        },
        """
        if foo == x {
            return foo
        } else {
            return bar
        }
        """
      ),
      #line: (
        try IfExprSyntax("if foo == x", bodyBuilder: { StmtSyntax("return foo") }, elseIf: IfExprSyntax("if foo == z") { StmtSyntax("return baz") }),
        """
        if foo == x {
            return foo
        } else if foo == z {
            return baz
        }
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }

  func testIfStmtSpacing() {
    let testCases: [UInt: (IfExprSyntax, String)] = [
      #line: (
        IfExprSyntax(conditions: ConditionElementListSyntax { ExprSyntax("!(true)") }) {},
        """
        if !(true) {
        }
        """
      ),
      #line: (
        ExprSyntax(
          """
          if !(false) {
          }
          """
        ).cast(IfExprSyntax.self),
        """
        if !(false) {
        }
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }

  func testIfLetStmt() {
    let buildable = IfExprSyntax(
      conditions: ConditionElementListSyntax {
        OptionalBindingConditionSyntax(
          bindingKeyword: .keyword(.let),
          pattern: PatternSyntax("x"),
          initializer: InitializerClauseSyntax(value: ExprSyntax("y"))
        )
      }
    ) {}
    assertBuildResult(
      buildable,
      """
      if let x = y {
      }
      """
    )
  }

  func testIfCaseStmt() {
    let buildable = IfExprSyntax(
      conditions: ConditionElementListSyntax {
        MatchingPatternConditionSyntax(
          pattern: ExpressionPatternSyntax(expression: MemberAccessExprSyntax(name: "x")),
          initializer: InitializerClauseSyntax(value: ExprSyntax("y"))
        )
      }
    ) {}
    assertBuildResult(
      buildable,
      """
      if case .x = y {
      }
      """
    )
  }
}
