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

final class TriviaTests: XCTestCase {
  func testLeadingTrivia() {
    let decl = VariableDecl(
      leadingTrivia: .docLineComment("/// A doc comment") + .newline + .blockComment("/* An inline comment */") + .space,
      modifiers: [DeclModifier(name: .static)],
      letOrVarKeyword: .var
    ) {
      PatternBinding(
        // TODO: This is meant to be `Pattern`, but it's ambiguous with XCTest
        // Really we should just remove that method in favor of the regular
        // syntax `init`, though that will mean callers have to wrap in
        // `PatternSyntax`. Changing those inits to be generic would be
        // possible, but then still fails here for the same reason.
        pattern: PatternSyntax("test"),
        typeAnnotation: TypeAnnotation(type: Type("String"))
      )
    }

    AssertBuildResult(
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
    let testCases: [UInt: (VariableDecl, String)] = [
      #line: (
        VariableDecl("let x: Int").withLeadingTrivia(.space),
        " let x: Int"
      ),
      #line: (
        VariableDecl("let x: Int").withTrailingTrivia(.space),
        "let x: Int "
      ),
    ]
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }

  func testAttachedListTrivia() {
    let testCases: [UInt: (AttributeList, String)] = [
      #line: (
        AttributeList {
          CustomAttribute("Test").withLeadingTrivia(.space)
        },
        " @Test"
      ),
      #line: (
        AttributeList {
          CustomAttribute("A").withTrailingTrivia(.space)
          CustomAttribute("B").withTrailingTrivia(.space)
        },
        "@A @B "
      ),
    ]
    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }
}
