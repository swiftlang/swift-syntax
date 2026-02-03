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

final class RemoveRedundantParensTest: XCTestCase {
  func testRemoveRedundantParens() throws {
    let tests = [
      (
        "(10)",
        "10"
      ),
      (
        "((10))",
        "(10)"
      ),
      (
        "(y + z)",
        "y + z"
      ),
      (
        "/* c */ (x)",
        "/* c */ x"
      ),
    ]

    for (input, expected) in tests {
      let inputSyntax = try XCTUnwrap(
        ExprSyntax.parse(from: input).as(TupleExprSyntax.self),
        "Failed validity check: \(input)"
      )
      // For expected, it might not be a TupleExpr (it's the unwrapped expr)
      let expectedSyntax = ExprSyntax.parse(from: expected)

      try assertRefactor(inputSyntax, context: (), provider: RemoveRedundantParens.self, expected: expectedSyntax)
    }
  }

  func testRemoveRedundantParensFails() throws {
    let tests = [
      // Multiple elements
      "(1, 2)",
      // Labeled element
      "(x: 1)",
      // Empty
      "()",
      // Safety: Binary op inside Binary op
      "x * (y + z)",
      "(a + b) / c",
    ]

    for input in tests {
      // Input might be a SequenceExpr containing a TupleExpr, not just a TupleExpr.
      let fullSyntax = ExprSyntax.parse(from: input)

      // Find the first TupleExpr in the tree
      let visitor = FindTupleVisitor(viewMode: .sourceAccurate)
      visitor.walk(fullSyntax)

      guard let tupleExpr = visitor.tupleExpr else {
        // If top level is tuple
        if let tuple = fullSyntax.as(TupleExprSyntax.self) {
          try assertRefactor(tuple, context: (), provider: RemoveRedundantParens.self, expected: ExprSyntax(tuple))
          continue
        }
        XCTFail("Could not find tuple in \(input)")
        continue
      }

      // We expect the refactoring to return the tuple unchanged (as ExprSyntax)
      try assertRefactor(tupleExpr, context: (), provider: RemoveRedundantParens.self, expected: ExprSyntax(tupleExpr))
    }
  }
}

class FindTupleVisitor: SyntaxVisitor {
  var tupleExpr: TupleExprSyntax?
  override func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    if tupleExpr == nil {
      tupleExpr = node
    }
    return .visitChildren
  }
}
