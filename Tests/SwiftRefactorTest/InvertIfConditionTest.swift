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

final class InvertIfConditionTest: XCTestCase {
  func testInvertIfCondition() throws {
    let tests = [
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
      // Trivia preservation
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
    ]

    for (input, expected) in tests {
      let inputSyntax = try XCTUnwrap(
        ExprSyntax.parse(from: input).as(IfExprSyntax.self),
        "Failed validity check: \(input)"
      )
      let expectedSyntax = try XCTUnwrap(ExprSyntax.parse(from: expected), "Failed validity check: \(expected)")

      try assertRefactor(inputSyntax, context: (), provider: InvertIfCondition.self, expected: expectedSyntax)
    }
  }

  func testInvertIfConditionFails() throws {
    let tests = [
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
      let inputSyntax = try XCTUnwrap(
        ExprSyntax.parse(from: input).as(IfExprSyntax.self),
        "Failed validity check: \(input)"
      )
      try assertRefactor(inputSyntax, context: (), provider: InvertIfCondition.self, expected: inputSyntax)
    }
  }
}

// Private helper to avoid redeclaration conflicts
private extension ExprSyntax {
  static func parse(from source: String) -> ExprSyntax {
    var parser = Parser(source)
    return ExprSyntax.parse(from: &parser)
  }
}
