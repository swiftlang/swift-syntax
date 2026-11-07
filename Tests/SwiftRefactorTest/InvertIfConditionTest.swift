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

import SwiftBasicFormat
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class InvertIfConditionTest: XCTestCase {
  func testInvertIfCondition() throws {
    let tests: [(ExprSyntax, ExprSyntax)] = [
      (
        """
        if !x {
          foo()
        } else {
          bar()
        }
        """,
        """
        if x {
          bar()
        } else {
          foo()
        }
        """
      ),
      (
        """
        if !(x == y) {
          return
        } else {
          continue
        }
        """,
        """
        if (x == y) {
          continue
        } else {
          return
        }
        """
      ),
      (
        """
        if /* comment */ !x {
          a
        } else {
          b
        }
        """,
        """
        if /* comment */ x {
          b
        } else {
          a
        }
        """
      ),
      (
        """
        if !x /* comment */ {
          a
        } else {
          b
        }
        """,
        """
        if x /* comment */ {
          b
        } else {
          a
        }
        """
      ),
      (
        """
        if !(/* comment */ x == y) {
          return
        } else {
          continue
        }
        """,
        """
        if (/* comment */ x == y) {
          continue
        } else {
          return
        }
        """
      ),
      (
        """
        if !x {
          // body comment
          foo()
        } else {
          // else comment
          bar()
        }
        """,
        """
        if x {
          // else comment
          bar()
        } else {
          // body comment
          foo()
        }
        """
      ),
    ]

    for (input, expected) in tests {
      try assertInvertIfCondition(input, expected: expected)
    }
  }

  func testInvertIfConditionFails() throws {
    let tests: [ExprSyntax] = [
      // Not negated
      """
      if x {
        a
      } else {
        b
      }
      """,
      // No else
      """
      if !x {
        a
      }
      """,
      // Else if (not a CodeBlock)
      """
      if !x {
        a
      } else if y {
        b
      }
      """,
      // Multiple conditions
      """
      if !x, !y {
        a
      } else {
        b
      }
      """,
      // Binding
      """
      if let x = y {
        a
      } else {
        b
      }
      """,
    ]

    for input in tests {
      try assertInvertIfCondition(input, expected: nil)
    }
  }

  private func assertInvertIfCondition(
    _ input: ExprSyntax,
    expected: ExprSyntax?,
    file: StaticString = #filePath,
    line: UInt = #line
  ) throws {
    let inputSyntax = try XCTUnwrap(input.as(IfExprSyntax.self), "Not an IfExpr: \(input)", file: file, line: line)
    do {
      let result = try InvertIfCondition.refactor(syntax: inputSyntax)
      if let expected {
        let expectedSyntax = try XCTUnwrap(expected.as(IfExprSyntax.self), "Not an IfExpr: \(expected)", file: file, line: line)
        assertStringsEqualWithDiff(result.description, expectedSyntax.description, file: file, line: line)
      } else {
        XCTFail("Expected failure, but refactoring succeeded: \(result.description)", file: file, line: line)
      }
    } catch {
      if expected != nil {
        XCTFail("Refactoring threw error '\(error)' for input:\n\(input)", file: file, line: line)
      }
    }
  }
}
