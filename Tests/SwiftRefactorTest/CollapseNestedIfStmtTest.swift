//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftParser
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class CollapseNestedIfStmtTest: XCTestCase {
  func testCollapseNestedIfStmt() throws {
    let tests = [
      (
        """
        if a {
          if b {
            print("hello")
          }
        }
        """,
        """
        if a, b {
            print("hello")
          }
        """
      ),
      (
        """
        if let x = y {
          if let z = w {
            body()
          }
        }
        """,
        """
        if let x = y, let z = w {
            body()
          }
        """
      ),
      (
        """
        if a, b {
          if c {
            body()
          }
        }
        """,
        """
        if a, b, c {
            body()
          }
        """
      ),
      (
        """
        if a {
          // comment
          if b {
            body()
          }
        }
        """,
        """
        if a, b {
            body()
          }
        """
      ),
    ]

    for (input, expected) in tests {
      let inputSyntax = try XCTUnwrap(ExprSyntax.parse(from: input).as(IfExprSyntax.self))
      let expectedSyntax = try XCTUnwrap(ExprSyntax.parse(from: expected).as(IfExprSyntax.self))

      try assertRefactor(inputSyntax, context: (), provider: CollapseNestedIfStmt.self, expected: expectedSyntax)
    }
  }

  func testCollapseNestedIfStmtFails() throws {
    let tests = [
      """
      if a {
        print("start")
        if b {
          print("hello")
        }
      }
      """,
      """
      if a {
        if b {
          print("hello")
        } else {
          print("else")
        }
      }
      """,
      """
      if a {
        if b {
          print("hello")
        }
      } else {
        print("outer else")
      }
      """,
    ]

    for input in tests {
      let inputSyntax = try XCTUnwrap(ExprSyntax.parse(from: input).as(IfExprSyntax.self))
      // Expect same output as input (no change)
      try assertRefactor(inputSyntax, context: (), provider: CollapseNestedIfStmt.self, expected: inputSyntax)
    }
  }
}

extension ExprSyntax {
  static func parse(from source: String) -> ExprSyntax {
    var parser = Parser(source)
    return ExprSyntax.parse(from: &parser)
  }
}
