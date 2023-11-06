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

fileprivate let closurePlaceholder = ExpandEditorPlaceholder.wrapInPlaceholder("T##closure##() -> Void")
fileprivate let voidPlaceholder = ExpandEditorPlaceholder.wrapInPlaceholder("T##code##Void")
fileprivate let intPlaceholder = ExpandEditorPlaceholder.wrapInPlaceholder("T##Int##Int")

final class ExpandEditorPlaceholdersTest: XCTestCase {
  func testSingleClosureArg() throws {
    let baseline = "call(\(closurePlaceholder))"

    let expected: String = """
      call {
          \(voidPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(baseline, expected: expected)
  }

  func testSingleNonClosureArg() throws {
    try assertRefactorPlaceholderToken("call(\(intPlaceholder))", expected: "Int")
  }

  func testTypeForExpansionPreferred() throws {
    let placeholder = ExpandEditorPlaceholder.wrapInPlaceholder("T##closure##BadType##() -> Int")
    let baseline = "call(\(placeholder))"

    let expected: String = """
      call {
          \(intPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(baseline, expected: expected)
  }

  func testMultipleClosureArgs() throws {
    let baseline = "call(arg1: \(closurePlaceholder), arg2: \(closurePlaceholder))"

    let expected: String = """
      call {
          \(voidPlaceholder)
      } arg2: {
          \(voidPlaceholder)
      }
      """

    try assertRefactorPlaceholderCall(baseline, expected: expected)
    try assertRefactorPlaceholderCall(baseline, placeholder: 1, expected: expected)
  }

  func testNonClosureAfterClosure() throws {
    let baseline = "call(arg1: \(closurePlaceholder), arg2: \(intPlaceholder))"

    let expected: String = """
      {
          \(voidPlaceholder)
      }
      """

    try assertRefactorPlaceholderToken(baseline, expected: expected)
  }

  func testComments() throws {
    let baseline = """
      /*c1*/foo/*c2*/(/*c3*/arg/*c4*/: /*c5*/\(closurePlaceholder)/*c6*/,/*c7*/
          /*c8*/\(closurePlaceholder)/*c9*/)/*c10*/
      """

    // TODO: Should we remove whitespace from the merged trivia? The space
    // between c2 and c3 is the one added for the `{`. The space between c4
    // and c5 is the space between the `:` and c5 (added by merging the
    // colon's trivia since it was removed).
    let expected: String = """
      /*c1*/foo/*c2*/ /*c3*//*c4*/ /*c5*/{
          \(voidPlaceholder)
      }/*c6*//*c7*/ _:
          /*c8*/{
          \(voidPlaceholder)
      }/*c9*//*c10*/
      """

    try assertRefactorPlaceholderCall(baseline, placeholder: 1, expected: expected)
  }
}

fileprivate func assertRefactorPlaceholderCall(
  _ expr: String,
  placeholder: Int = 0,
  expected: String,
  file: StaticString = #file,
  line: UInt = #line
) throws {
  var parser = Parser(expr)
  let call = try XCTUnwrap(ExprSyntax.parse(from: &parser).as(FunctionCallExprSyntax.self), file: file, line: line)
  let arg = call.arguments[call.arguments.index(at: placeholder)]
  let token: TokenSyntax = try XCTUnwrap(arg.expression.as(DeclReferenceExprSyntax.self), file: file, line: line).baseName

  try assertRefactor(token, context: (), provider: ExpandEditorPlaceholders.self, expected: [SourceEdit.replace(call, with: expected)], file: file, line: line)
}

fileprivate func assertRefactorPlaceholderToken(
  _ expr: String,
  placeholder: Int = 0,
  expected: String,
  file: StaticString = #file,
  line: UInt = #line
) throws {
  var parser = Parser(expr)
  let call = try XCTUnwrap(ExprSyntax.parse(from: &parser).as(FunctionCallExprSyntax.self), file: file, line: line)
  let arg = call.arguments[call.arguments.index(at: placeholder)]
  let token: TokenSyntax = try XCTUnwrap(arg.expression.as(DeclReferenceExprSyntax.self), file: file, line: line).baseName

  try assertRefactor(token, context: (), provider: ExpandEditorPlaceholders.self, expected: [SourceEdit.replace(token, with: expected)], file: file, line: line)
}
