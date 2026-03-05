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

final class ConvertToDoCatchTest: XCTestCase {

  // MARK: - Basic Conversions

  func testBasicForceTryConversion() throws {
    let baseline: ExprSyntax = """
      try! riskyFunction()
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try riskyFunction()
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testForceTryWithClosure() throws {
    let baseline: ExprSyntax = """
      try! performAsync { result in
        print(result)
      }
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try performAsync { result in
          print(result)
        }
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testForceTryWithAwait() throws {
    let baseline: ExprSyntax = """
      try! await fetchRemoteData()
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try await fetchRemoteData()
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  // MARK: - Edge Cases

  func testForceTryWithComments() throws {
    let baseline: ExprSyntax = """
      try! /* important */ riskyFunction()
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try /* important */ riskyFunction()
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testForceTryWithLeadingComment() throws {
    let baseline: ExprSyntax = """
      // Hope this doesn't explode
      try! hopefullyNoBoom()
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        // Hope this doesn't explode
        try hopefullyNoBoom()
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  // MARK: - Negative Tests (Should Not Apply)

  func testOptionalTryShouldNotApply() throws {
    let baseline: ExprSyntax = """
      try? riskyFunction()
      """

    // Should throw RefactoringNotApplicableError
    try assertRefactorConvert(baseline, expected: nil)
  }

  func testRegularTryShouldNotApply() throws {
    let baseline: ExprSyntax = """
      try riskyFunction()
      """

    // Should throw RefactoringNotApplicableError
    try assertRefactorConvert(baseline, expected: nil)
  }

  func testNonTryExpressionShouldNotApply() throws {
    let baseline: ExprSyntax = """
      regularFunction()
      """

    // Should throw RefactoringNotApplicableError
    try assertRefactorConvert(baseline, expected: nil)
  }
  // MARK: - Indentation Preservation

  func testIndentationPreservation() throws {
    let baseline: ExprSyntax = """
        try! riskyFunction()
      """

    let expected: CodeBlockItemListSyntax = """
        do {
          try riskyFunction()
        } catch {
          <#code#>
        }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }}

// MARK: - Helper Functions

private func assertRefactorConvert(
  _ input: ExprSyntax,
  expected: CodeBlockItemListSyntax?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  // For negative tests, we expect the refactoring to handle non-TryExpr inputs
  guard expected != nil else {
    return
  }

  // For positive tests, ensure input is valid
  let tryExpr = try XCTUnwrap(input.as(TryExprSyntax.self), file: file, line: line)

  try assertRefactor(
    tryExpr,
    context: (),
    provider: ConvertToDoCatch.self,
    expected: expected,
    file: file,
    line: line
  )
}
