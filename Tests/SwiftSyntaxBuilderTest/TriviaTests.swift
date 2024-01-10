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

final class TriviaTests: XCTestCase {
  func testLeadingTrivia() {
    let decl = VariableDeclSyntax(
      leadingTrivia: """
        /// A doc comment
        /* An inline comment */ \

        """,
      modifiers: [DeclModifierSyntax(name: .keyword(.static))],
      bindingSpecifier: .keyword(.var)
    ) {
      PatternBindingSyntax(
        pattern: PatternSyntax("test"),
        typeAnnotation: TypeAnnotationSyntax(type: TypeSyntax("String"))
      )
    }

    assertBuildResult(
      decl,
      """
      /// A doc comment
      /* An inline comment */ static var test: String
      """
    )
  }

  func testTriviaConcatenation() {
    let x = Trivia.newline
    var y = x
    y += .space
    XCTAssertEqual(y, x + .space)
    XCTAssertEqual(y, [.newlines(1), .spaces(1)])
  }

  func testAttachedTrivia() {
    let testCases: [UInt: (DeclSyntax, String)] = [
      #line: (
        DeclSyntax("let x: Int").with(\.leadingTrivia, .space),
        " let x: Int"
      ),
      #line: (
        DeclSyntax("let x: Int").with(\.trailingTrivia, .space),
        "let x: Int "
      ),
    ]
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }

  func testAttachedListTrivia() {
    let testCases: [UInt: (AttributeListSyntax, String)] = [
      #line: (
        AttributeListSyntax {
          AttributeSyntax(attributeName: TypeSyntax("Test")).with(\.leadingTrivia, .space)
        },
        " @Test"
      ),
      #line: (
        AttributeListSyntax {
          AttributeSyntax(attributeName: TypeSyntax("A")).with(\.trailingTrivia, .space)
          AttributeSyntax(attributeName: TypeSyntax("B")).with(\.trailingTrivia, .space)
        },
        "@A @B "
      ),
    ]
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }
}
