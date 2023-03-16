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

import SwiftDiagnostics
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder
@_spi(Testing) import SwiftSyntaxMacros
import _SwiftSyntaxTestSupport
import XCTest

final class MacroReplacementTests: XCTestCase {
  func testMacroDefinitionGood() {
    let macro: DeclSyntax =
      """
      macro expand1(a: Int, b: Int) = #otherMacro(first: b, second: ["a": a], third: [3.14159, 2.71828], fourth: 4)
      """

    let (replacements, diags) = macro.as(MacroDeclSyntax.self)!
      .expansionParameterReplacements()
    XCTAssertEqual(diags.count, 0)
    XCTAssertEqual(replacements.count, 2)
    XCTAssertEqual(replacements[0].parameterIndex, 1)
    XCTAssertEqual(replacements[1].parameterIndex, 0)
  }

  func testMacroDefinitionBad() {
    let macro: DeclSyntax =
      """
      macro expand1(a: Int, b: Int) = #otherMacro(first: b + 1, c)
      """

    let (_, diags) = macro.as(MacroDeclSyntax.self)!
      .expansionParameterReplacements()
    XCTAssertEqual(diags.count, 2)
    XCTAssertEqual(
      diags[0].diagMessage.message,
      "only literals and macro parameters are permitted in expansion"
    )
    XCTAssertEqual(
      diags[1].diagMessage.message,
      "reference to value 'c' that is not a macro parameter in expansion"
    )
  }

  func testMacroUndefined() {
    let macro: DeclSyntax =
      """
      macro expand1(a: Int, b: Int)
      """

    let (_, diags) = macro.as(MacroDeclSyntax.self)!
      .expansionParameterReplacements()
    XCTAssertEqual(diags.count, 1)
    XCTAssertEqual(
      diags[0].diagMessage.message,
      "macro expansion requires a definition"
    )
  }

  func testMacroExpansion() {
    let macro: DeclSyntax =
      """
      macro expand1(a: Int, b: Int) = #otherMacro(first: b, second: ["a": a], third: [3.14159, 2.71828], fourth: 4)
      """

    let use: ExprSyntax =
      """
      #expand1(a: 5, b: 17)
      """

    let expandedSyntax = try! macro.as(MacroDeclSyntax.self)!
      .expandDefinition(use.as(MacroExpansionExprSyntax.self)!)
    AssertStringsEqualWithDiff(
      expandedSyntax.description,
      """
      #otherMacro(first: 17, second: ["a": 5], third: [3.14159, 2.71828], fourth: 4)
      """
    )
  }
}
