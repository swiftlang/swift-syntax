//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License 2.0 with Runtime Library Exception
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

final class ConvertZeroParameterFunctionToComputedPropertyTests: XCTestCase {
  func testPreservesLeadingDocumentationComment() throws {
    let baseline: DeclSyntax = """
      /// Some comment
      func foo() -> Int {
        1
      }
      """

    let expected: DeclSyntax = """
      /// Some comment
      var foo: Int {
        1
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testPreservesLeadingCommentWithModifiersAndAttributes() throws {
    let baseline: DeclSyntax = """
      /// Some comment
      @inlinable public static func foo() -> Int {
        1
      }
      """

    let expected: DeclSyntax = """
      /// Some comment
      @inlinable public static var foo: Int {
        1
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testDoesNotConvertFunctionOnlyAttribute() throws {
    let baseline: DeclSyntax = """
      @discardableResult func foo() -> Int {
        1
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }

  func testDoesNotConvertFunctionOnlyModifier() throws {
    let baseline: DeclSyntax = """
      mutating func foo() -> Int {
        1
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }

  func testPreservesTriviaForEffectfulFunction() throws {
    let baseline: DeclSyntax = """
      func foo() async throws -> Int /* before body */ { /* after opening brace */
        1
        /* before closing brace */
      } /* after body */
      """

    let expected: DeclSyntax = """
      var foo: Int /* before body */ {
        get async throws { /* after opening brace */
          1
          /* before closing brace */
        }
      } /* after body */
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testConvertsFunctionWithoutReturnType() throws {
    let baseline: DeclSyntax = """
      func foo() {
        ()
      }
      """

    let expected: DeclSyntax = """
      var foo: Void {
        ()
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testDoesNotConvertGenericFunction() throws {
    let baseline: DeclSyntax = """
      func foo<T>() -> T {
        fatalError()
      }
      """

    try assertRefactorConvert(baseline, expected: nil)
  }
}

private func assertRefactorConvert(
  _ declaration: DeclSyntax,
  expected: DeclSyntax?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  try assertRefactor(
    declaration,
    context: (),
    provider: ConvertZeroParameterFunctionToComputedProperty.self,
    expected: expected,
    file: file,
    line: line
  )
}
