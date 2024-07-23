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

final class ConvertStoredPropertyToComputedTest: XCTestCase {
  func testRefactoringStoredPropertyWithInitializer1() throws {
    let baseline: DeclSyntax = """
      static let defaultColor: Color = .red
      """

    let expected: DeclSyntax = """
      static var defaultColor: Color { .red }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializer1AndLeadingComments() throws {
    let baseline: DeclSyntax = """
      static let defaultColor: Color = /* red */ .red
      """

    let expected: DeclSyntax = """
      static var defaultColor: Color { /* red */ .red }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializer1AndLeadingComments2() throws {
    let baseline: DeclSyntax = """
      static let defaultColor: Color = 
        /* red */ .red
      """

    let expected: DeclSyntax = """
      static var defaultColor: Color { 
        /* red */ .red }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializer1AndTrailingComments() throws {
    let baseline: DeclSyntax = """
      static let defaultColor: Color = .red /* red */
      """

    let expected: DeclSyntax = """
      static var defaultColor: Color { .red /* red */ }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializer1AndTrailingComments2() throws {
    let baseline: DeclSyntax = """
      static let defaultColor: Color = .red
        /* red */
      """

    let expected: DeclSyntax = """
      static var defaultColor: Color { .red
        /* red */ }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializerAndComments() throws {
    let baseline: DeclSyntax = """
      static /* one */ let defaultColor: Color = .red
      """

    let expected: DeclSyntax = """
      static /* one */ var defaultColor: Color { .red }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializerAndCommentsInBinding() throws {
    let baseline: DeclSyntax = """
      static let /* binding */ defaultColor: Color = .red
      """

    let expected: DeclSyntax = """
      static var /* binding */ defaultColor: Color { .red }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializer2() throws {
    let baseline: DeclSyntax = """
      static let defaultColor: Color = Color.red
      """

    let expected: DeclSyntax = """
      static var defaultColor: Color { Color.red }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializer3() throws {
    let baseline: DeclSyntax = """
      var defaultColor: Color = Color.red
      """

    let expected: DeclSyntax = """
      var defaultColor: Color { Color.red }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithInitializer4() throws {
    let baseline: DeclSyntax = """
      var defaultColor: Color = Color()
      """

    let expected: DeclSyntax = """
      var defaultColor: Color { Color() }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithMultipleStatements() throws {
    let baseline: DeclSyntax = """
      var three: Int = {
        let one = 1
        let two = 2
        return 1 + 2
      }()
      """

    let expected: DeclSyntax = """
      var three: Int {
        let one = 1
        let two = 2
        return 1 + 2
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringStoredPropertyWithFunctionCallAndArguments() throws {
    let baseline: DeclSyntax = """
      let myVar = { value in
        return value
      }(1)
      """

    try assertRefactorConvert(baseline, expected: nil)
  }
}

fileprivate func assertRefactorConvert(
  _ callDecl: DeclSyntax,
  expected: DeclSyntax?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  try assertRefactor(
    callDecl,
    context: (),
    provider: ConvertStoredPropertyToComputed.self,
    expected: expected,
    file: file,
    line: line
  )
}
