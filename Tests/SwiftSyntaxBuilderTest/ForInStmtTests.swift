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

import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

final class ForInStmtTests: XCTestCase {
  func testEmptyForInStmtSyntax() throws {
    let buildable = ForStmtSyntax(pattern: PatternSyntax("foo"), sequence: ExprSyntax("bar")) {}
    assertBuildResult(
      buildable,
      """
      for foo in bar {
      }
      """
    )
  }

  func testForInStmtSyntax() throws {
    let testCases: [UInt: (ForStmtSyntax, String)] = [
      #line: (
        StmtSyntax(
          """
          for foo in bar {
            _ = foo
          }
          """
        ).cast(ForStmtSyntax.self),
        """
        for foo in bar {
          _ = foo
        }
        """
      ),
      #line: (
        try ForStmtSyntax("for try await foo in bar") { ExprSyntax("print(foo)") },
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
    let buildable = ForStmtSyntax(
      tryKeyword: .keyword(.try),
      awaitKeyword: .keyword(.await),
      pattern: PatternSyntax("foo"),
      sequence: ExprSyntax("bar"),
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
