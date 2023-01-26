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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class IfStmtTests: XCTestCase {
  func testEmptyIfStmt() {
    // Use the convenience initializer from IfStmtConvenienceInitializers. This is
    // disambiguated by the absence of a labelName parameter and the use of a
    // trailing closure.
    let buildable = IfStmtSyntax(conditions: ConditionElementListSyntax { BooleanLiteralExprSyntax(false) }) {}
    AssertBuildResult(
      buildable,
      """
      if false {
      }
      """
    )
  }

  func testIfStmtyntax() throws {
    let testCases: [UInt: (IfStmtSyntax, String)] = [
      #line: (
        StmtSyntax(
          """
          if foo == x {
            return foo
          }
          """
        ).cast(IfStmtSyntax.self),
        """
        if foo == x {
            return foo
        }
        """
      ),
      #line: (
        try IfStmtSyntax("if foo == x") { StmtSyntax("return foo") },
        """
        if foo == x {
            return foo
        }
        """
      ),
      #line: (
        try IfStmtSyntax("if foo == x") {
          StmtSyntax("return foo")
        } else: {
          StmtSyntax("return bar")
        },
        """
        if foo == x {
            return foo
        }else {
            return bar
        }
        """
      ),
      #line: (
        try IfStmtSyntax("if foo == x", bodyBuilder: { StmtSyntax("return foo") }, elseIf: IfStmtSyntax("if foo == z") { StmtSyntax("return baz") }),
        """
        if foo == x {
            return foo
        }else if foo == z {
            return baz
        }
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }

  func testIfStmtSpacing() {
    let testCases: [UInt: (IfStmtSyntax, String)] = [
      #line: (
        IfStmtSyntax(conditions: ConditionElementListSyntax { ExprSyntax("!(true)") }) {},
        """
        if !(true) {
        }
        """
      ),
      #line: (
        StmtSyntax(
          """
          if !(false) {
          }
          """
        ).cast(IfStmtSyntax.self),
        """
        if !(false) {
        }
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }

  func testIfElseStmt() {
    // Use the convenience initializer from IfStmtConvenienceInitializers
    // with an else branch expressed by a second trailing closure.
    let buildable = IfStmtSyntax(conditions: ConditionElementListSyntax { BooleanLiteralExprSyntax(true) }) {
      FunctionCallExprSyntax(callee: ExprSyntax("print")) {
        TupleExprElementSyntax(expression: StringLiteralExprSyntax(content: "Hello from the if-branch!"))
      }
    } elseBody: {
      FunctionCallExprSyntax(callee: ExprSyntax("print")) {
        TupleExprElementSyntax(expression: StringLiteralExprSyntax(content: "Hello from the else-branch!"))
      }
    }
    AssertBuildResult(
      buildable,
      """
      if true {
          print("Hello from the if-branch!")
      } else {
          print("Hello from the else-branch!")
      }
      """
    )
  }

  func testIfLetStmt() {
    let buildable = IfStmtSyntax(
      conditions: ConditionElementListSyntax {
        OptionalBindingConditionSyntax(
          letOrVarKeyword: .keyword(.let),
          pattern: PatternSyntax("x"),
          initializer: InitializerClauseSyntax(value: ExprSyntax("y"))
        )
      }
    ) {}
    AssertBuildResult(
      buildable,
      """
      if let x = y {
      }
      """
    )
  }

  func testIfCaseStmt() {
    let buildable = IfStmtSyntax(
      conditions: ConditionElementListSyntax {
        MatchingPatternConditionSyntax(
          pattern: ExpressionPatternSyntax(expression: MemberAccessExprSyntax(name: "x")),
          initializer: InitializerClauseSyntax(value: ExprSyntax("y"))
        )
      }
    ) {}
    AssertBuildResult(
      buildable,
      """
      if case .x = y {
      }
      """
    )
  }
}
