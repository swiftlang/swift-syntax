//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
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

  func testForceTryWithVariableBinding() throws {
    let baseline: ExprSyntax = """
      try! fetchData()
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try fetchData()
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testForceTryWithArguments() throws {
    let baseline: ExprSyntax = """
      try! processFile(at: path, with: options)
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try processFile(at: path, with: options)
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testForceTryWithChaining() throws {
    let baseline: ExprSyntax = """
      try! getData().process().save()
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try getData().process().save()
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testForceTryWithPropertyAccess() throws {
    let baseline: ExprSyntax = """
      try! object.riskyProperty.value
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try object.riskyProperty.value
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  // MARK: - Complex Expressions

  func testForceTryWithSubscript() throws {
    let baseline: ExprSyntax = """
      try! array[index]
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try array[index]
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

  func testForceTryWithMultilineExpression() throws {
    let baseline: ExprSyntax = """
      try! complexFunction(
        parameter1: value1,
        parameter2: value2
      )
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try complexFunction(
          parameter1: value1,
          parameter2: value2
        )
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

  // MARK: - Real-World Examples

  func testJSONDecodingExample() throws {
    let baseline: ExprSyntax = """
      try! JSONDecoder().decode(User.self, from: data)
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try JSONDecoder().decode(User.self, from: data)
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testFileReadingExample() throws {
    let baseline: ExprSyntax = """
      try! String(contentsOf: url, encoding: .utf8)
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try String(contentsOf: url, encoding: .utf8)
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testDataWritingExample() throws {
    let baseline: ExprSyntax = """
      try! data.write(to: fileURL)
      """

    let expected: CodeBlockItemListSyntax = """
      do {
        try data.write(to: fileURL)
      } catch {
        <#code#>
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }
}

// MARK: - Helper Functions

private func assertRefactorConvert(
  _ input: ExprSyntax,
  expected: CodeBlockItemListSyntax?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  guard let tryExpr = input.as(TryExprSyntax.self) else {
    if expected != nil {
      XCTFail("Input is not a TryExprSyntax", file: file, line: line)
    }
    return
  }

  try assertRefactor(
    tryExpr,
    context: (),
    provider: ConvertToDoCatch.self,
    expected: expected,
    file: file,
    line: line
  )
}
