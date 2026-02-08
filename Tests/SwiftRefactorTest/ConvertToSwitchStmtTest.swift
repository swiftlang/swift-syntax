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

final class ConvertToSwitchStmtTest: XCTestCase {
  func testConvertToSwitchStmt() throws {
    let tests = [
      (
        """
        if a == 1 {
          print("one")
        } else if a == 2 {
          print("two")
        } else {
          print("other")
        }
        """,
        """
        switch a {
        case 1:
          print("one")
        case 2:
          print("two")
        default:
          print("other")
        }
        """
      ),
      // Implicit default break
      (
        """
        if x == .foo {
          doFoo()
        }
        """,
        """
        switch x {
        case .foo:
          doFoo()
        default:
          break
        }
        """
      ),
      // With comments (Subject)
      (
        """
        if /* c */ x == 1 {
          a()
        }
        """,
        """
        switch x {
        case 1:
          a()
        default:
          break
        }
        """
      )
    ]

    for (input, expected) in tests {
      let inputSyntax = try XCTUnwrap(ExprSyntax._parse(from: input).as(IfExprSyntax.self), "Failed validity check: \(input)")
      let expectedSyntax = try XCTUnwrap(ExprSyntax._parse(from: expected).as(SwitchExprSyntax.self), "Failed validity check: \(expected)")
      
      try assertRefactor(inputSyntax, context: (), provider: ConvertToSwitchStmt.self, expected: expectedSyntax)
    }
  }

  func testConvertToSwitchStmtFails() throws {
    let tests = [
      // Mixed subjects
      """
      if a == 1 {
        a
      } else if b == 1 {
        b
      }
      """,
      // Wrong operator
      """
      if a < 1 {
        a
      }
      """,
      // Multiple conditions
      """
      if a == 1, b == 2 {
        a
      }
      """,
      // Pattern match (supported in future, but V1 assumes strict ==)
      // Actually `if case .foo = bar` is NOT `==`.
    ]

    for input in tests {
      let inputSyntax = try XCTUnwrap(ExprSyntax._parse(from: input).as(IfExprSyntax.self), "Failed validity check: \(input)")
      XCTAssertThrowsError(try ConvertToSwitchStmt.refactor(syntax: inputSyntax, in: ()))
    }
  }
}

// Private helper to avoid redeclaration conflicts
private extension ExprSyntax {
  static func _parse(from source: String) -> ExprSyntax {
    var parser = Parser(source)
    return ExprSyntax.parse(from: &parser)
  }
}
