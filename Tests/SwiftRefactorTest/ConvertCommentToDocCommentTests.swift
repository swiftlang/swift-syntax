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

import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class ConvertCommentToDocCommentTests: XCTestCase {

  func testMultipleLineComments() throws {
    let baseline: DeclSyntax = """
      // Returns the full name of the user
      // by combining first and last name.
      func fullName() -> String {
          return "\\(firstName) \\(lastName)"
      }
      """

    let expected: DeclSyntax = """
      /// Returns the full name of the user
      /// by combining first and last name.
      func fullName() -> String {
          return "\\(firstName) \\(lastName)"
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testBlockComment() throws {
    let baseline: DeclSyntax = """
      /* A block comment describing the class. */
      class MyClass {}
      """

    let expected: DeclSyntax = """
      /** A block comment describing the class. */
      class MyClass {}
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testAlreadyDocCommentIsNotApplicable() throws {
    let baseline: DeclSyntax = """
      /// Already a doc comment.
      func bar() {}
      """

    try assertRefactorConvert(baseline, expected: nil)
  }

  func testNoCommentIsNotApplicable() throws {
    let baseline: DeclSyntax = """
      func baz() {}
      """

    try assertRefactorConvert(baseline, expected: nil)
  }

  func testMixedDocAndLineComment() throws {
    let baseline: DeclSyntax = """
      /// Doc comment.
      // Regular comment.
      func mixed() {}
      """

    let expected: DeclSyntax = """
      /// Doc comment.
      /// Regular comment.
      func mixed() {}
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testEmptyLineComment() throws {
    let baseline: DeclSyntax = """
      // First line.
      //
      // After blank comment line.
      func foo() {}
      """

    let expected: DeclSyntax = """
      /// First line.
      ///
      /// After blank comment line.
      func foo() {}
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testCommentSeparatedByBlankLine() throws {
    let baseline: DeclSyntax = """
      // This comment is separated by a blank line.

      func foo() {}
      """

    let expected: DeclSyntax = """
      /// This comment is separated by a blank line.

      func foo() {}
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testLineCommentWithoutSpace() throws {
    let baseline: DeclSyntax = """
      //No space after slashes.
      func foo() {}
      """

    let expected: DeclSyntax = """
      ///No space after slashes.
      func foo() {}
      """

    try assertRefactorConvert(baseline, expected: expected)
  }
}

private func assertRefactorConvert(
  _ callDecl: DeclSyntax,
  expected: DeclSyntax?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  try assertRefactor(
    callDecl,
    context: (),
    provider: ConvertCommentToDocComment.self,
    expected: expected,
    file: file,
    line: line
  )
}
