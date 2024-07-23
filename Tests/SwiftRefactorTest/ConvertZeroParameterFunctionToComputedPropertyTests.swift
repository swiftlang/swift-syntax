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

final class ConvertZeroParameterFunctionToComputedPropertyTests: XCTestCase {
  func testRefactoringFunctionToComputedProperty() throws {
    let baseline: DeclSyntax = """
      func asJSON() -> String { "" }
      """

    let expected: DeclSyntax = """
      var asJSON: String { "" }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringFunctionToComputedPropertyWithVoidType() throws {
    let baseline: DeclSyntax = """
      func asJSON() { () }
      """

    let expected: DeclSyntax = """
      var asJSON: Void { () }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringFunctionToComputedPropertyWithTuple() throws {
    let baseline: DeclSyntax = """
      func asJSON() -> (String, String) { ("", "") }
      """

    let expected: DeclSyntax = """
      var asJSON: (String, String) { ("", "") }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringFunctionToComputedPropertyWithClosure() throws {
    let baseline: DeclSyntax = """
      func asJSON() -> () -> Void { {} }
      """

    let expected: DeclSyntax = """
      var asJSON: () -> Void { {} }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringFunctionToComputedPropertyWithModifiers() throws {
    let baseline: DeclSyntax = """
      static func  asJSON() -> String  { "" }
      """

    let expected: DeclSyntax = """
      static var  asJSON: String  { "" }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringFunctionToComputedPropertyWithModifiersAndIndentations() throws {
    let baseline: DeclSyntax = """
        static  func  asJSON()  ->  String  { "" }
      """

    let expected: DeclSyntax = """
        static  var  asJSON:  String  { "" }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringFunctionToComputedPropertyWithModifiersAndComments() throws {
    let baseline: DeclSyntax = """
      static func asJSON() -> String { // comment
      /*comment*/ "" /*comment*/
      } // comment
      """

    let expected: DeclSyntax = """
      static var asJSON: String { // comment
      /*comment*/ "" /*comment*/
      } // comment
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringFunctionToComputedPropertyWithReturnStms() throws {
    let baseline: DeclSyntax = """
      static  func  asJSON()  ->  String  {
        return ""
      }
      """

    let expected: DeclSyntax = """
      static  var  asJSON:  String  {
        return ""
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
  }

  func testRefactoringFunctionToComputedPropertyWithMultipleStms() throws {
    let baseline: DeclSyntax = """
      static  func  asJSON()  ->  String  {
        let builder = JSONBuilder()
        return builder.convert()
      }
      """

    let expected: DeclSyntax = """
      static  var  asJSON:  String  {
        let builder = JSONBuilder()
        return builder.convert()
      }
      """

    try assertRefactorConvert(baseline, expected: expected)
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
    provider: ConvertZeroParameterFunctionToComputedProperty.self,
    expected: expected,
    file: file,
    line: line
  )
}
