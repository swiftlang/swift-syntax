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

import SwiftBasicFormat
import SwiftParser
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class ExpandEditorPlaceholderTest: XCTestCase {
  func testSimple() throws {
    try assertRefactorPlaceholder("displayOnly", expected: "displayOnly")
    try assertRefactorPlaceholder("T##typed", expected: "typed")
    try assertRefactorPlaceholder("T##displayAndType##Int", expected: "Int")
    try assertRefactorPlaceholder("T##bothTypes##Int##BetterInt", expected: "BetterInt")
    try assertRefactorPlaceholder("T##bothTypesFirstEmpty####BetterInt", expected: "BetterInt")
  }

  func testEmpty() throws {
    try assertRefactorPlaceholder("", expected: "")
    try assertRefactorPlaceholder("T##", expected: "")
    try assertRefactorPlaceholder("T##displayEmptyType##", expected: "displayEmptyType")
    try assertRefactorPlaceholder("T####EmptyDisplay", expected: "EmptyDisplay")
    try assertRefactorPlaceholder("T######EmptyTypeAndDisplay", expected: "EmptyTypeAndDisplay")
    try assertRefactorPlaceholder("T##bothTypesFirstNotEmpty##Int##", expected: "Int")
    try assertRefactorPlaceholder("T##bothTypesEmpty####", expected: "bothTypesEmpty")
  }

  func testVoidClosure() throws {
    let expected = """
      {
          \(ExpandEditorPlaceholder.wrapInPlaceholder("T##code##Void"))
      }
      """
    try assertRefactorPlaceholder("T##display##() -> Void", expected: expected)
  }

  func testTypedReturnClosure() throws {
    let expected = """
      {
          \(ExpandEditorPlaceholder.wrapInPlaceholder("T##Int##Int"))
      }
      """
    try assertRefactorPlaceholder("T##display##() -> Int", expected: expected)
  }

  func testClosureWithArg() throws {
    let expected = """
      { arg in
          \(ExpandEditorPlaceholder.wrapInPlaceholder("T##Int##Int"))
      }
      """
    try assertRefactorPlaceholder("T##display##(arg: String) -> Int", expected: expected)
    try assertRefactorPlaceholder("T##display##(_ arg: String) -> Int", expected: expected)
  }

  func testClosureWithMultipleArgs() throws {
    let expected = """
      { arg, arg2 in
          \(ExpandEditorPlaceholder.wrapInPlaceholder("T##Int##Int"))
      }
      """
    try assertRefactorPlaceholder("T##display##(arg: String, arg2: String) -> Int", expected: expected)
  }

  func testSimpleComments() throws {
    let placeholder = ExpandEditorPlaceholder.wrapInPlaceholder("simple")
    try assertRefactorPlaceholder("/*c1*/\(placeholder)/*c2*/", wrap: false, expected: "/*c1*/simple/*c2*/")
  }

  func testClosureComments() throws {
    let placeholder = ExpandEditorPlaceholder.wrapInPlaceholder("T##display##(arg: String) -> Int")
    let expected = """
      /*c1*/{ arg in
          \(ExpandEditorPlaceholder.wrapInPlaceholder("T##Int##Int"))
      }/*c2*/
      """
    try assertRefactorPlaceholder("/*c1*/\(placeholder)/*c2*/", wrap: false, expected: expected)
  }
}

fileprivate func assertRefactorPlaceholder(
  _ placeholder: String,
  wrap: Bool = true,
  expected: String,
  file: StaticString = #file,
  line: UInt = #line
) throws {
  let token: TokenSyntax
  if wrap {
    token = "\(raw: ExpandEditorPlaceholder.wrapInPlaceholder(placeholder))"
  } else {
    var parser = Parser(placeholder)
    let expr = ExprSyntax.parse(from: &parser)
    token = try XCTUnwrap(expr.as(DeclReferenceExprSyntax.self)?.baseName, file: file, line: line)
  }

  try assertRefactor(token, context: (), provider: ExpandEditorPlaceholder.self, expected: [SourceEdit.replace(token, with: expected)], file: file, line: line)
}
