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

final class ForInStmtTests: XCTestCase {
  func testEmptyForInStmtSyntax() throws {
    let buildable = ForInStmtSyntax(pattern: PatternSyntax("foo"), sequenceExpr: ExprSyntax("bar")) {}
    assertBuildResult(
      buildable,
      """
      for foo in bar {
      }
      """
    )
  }

  func testForInStmtSyntax() throws {
    let testCases: [UInt: (ForInStmtSyntax, String)] = [
      #line: (
        StmtSyntax(
          """
          for foo in bar {
            _ = foo
          }
          """
        ).cast(ForInStmtSyntax.self),
        """
        for foo in bar {
          _ = foo
        }
        """
      ),
      #line: (
        try ForInStmtSyntax("for try await foo in bar") { ExprSyntax("print(foo)") },
        """
        for try await foo in bar {
            print(foo)
        }
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }

  func testEffectiveForInStmtSyntax() throws {
    let buildable = ForInStmtSyntax(
      tryKeyword: .keyword(.try),
      awaitKeyword: .keyword(.await),
      pattern: PatternSyntax("foo"),
      sequenceExpr: ExprSyntax("bar"),
      body: CodeBlockSyntax(
        statements: [
          .init(item: .decl("let baz = await foo.baz")),
          .init(item: .expr("print(foo.baz)")),
        ]
      )
    )
    assertBuildResult(
      buildable,
      """
      for try await foo in bar {
          let baz = await foo.baz
          print(foo.baz)
      }
      """
    )
  }
}
