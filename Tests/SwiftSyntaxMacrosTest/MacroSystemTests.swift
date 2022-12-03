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
@_spi(Testing) import _SwiftSyntaxMacros
import _SwiftSyntaxTestSupport

/// Macro whose only purpose is to ensure that we cannot see "out" of the
/// macro expansion syntax node we were given.
struct CheckContextIndependenceMacro: ExpressionMacro {
  static func expand(
    _ macro: MacroExpansionExprSyntax,
    in context: inout MacroExpansionContext) -> ExprSyntax {

    // Should not have a parent.
    XCTAssertNil(macro.parent)

    // Absolute starting position should be zero.
    XCTAssertEqual(macro.position.utf8Offset, 0)

    return ExprSyntax(macro)
  }
}

final class MacroSystemTests: XCTestCase {
  func testExpressionExpansion() {
    let sf: SourceFileSyntax =
      """
      let b = #stringify(x + y)
      #colorLiteral(red: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
      """
    var context = MacroExpansionContext(
      moduleName: "MyModule", fileName: "test.swift"
    )
    let transformedSF = MacroSystem.exampleSystem.evaluateMacros(
      node: sf, in: &context
    )
    AssertStringsEqualWithDiff(
      transformedSF.description,
      """
      let b = (x + y, "x + y")
      .init(_colorLiteralRed: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
      """
    )
  }

  func testStringifyExpression() {
    let sf: SourceFileSyntax =
      """
      _ = #stringify({ () -> Bool in
        print("hello")
        return true
      })
      """
    var context = MacroExpansionContext(
      moduleName: "MyModule", fileName: "test.swift"
    )
    let transformedSF = MacroSystem.exampleSystem.evaluateMacros(
      node: sf, in: &context
    )
    AssertStringsEqualWithDiff(
      transformedSF.description,
      """
      _ = ({ () -> Bool in
        print("hello")
        return true
      }, #"{ () -> Bool in\\#n  print("hello")\\#n  return true\\#n}"#)
      """
    )
  }

  func testFileExpansions() {
    let sf: SourceFileSyntax =
      """
      let b = #fileID
      """
    var context = MacroExpansionContext(
      moduleName: "MyModule", fileName: "taylor.swift"
    )
    let transformedSF = MacroSystem.exampleSystem.evaluateMacros(
      node: sf, in: &context
    )
    AssertStringsEqualWithDiff(
      transformedSF.description,
      """
      let b = "MyModule/taylor.swift"
      """
    )
  }

  func testContextUniqueLocalNames() {
    var context = MacroExpansionContext(
      moduleName: "MyModule", fileName: "taylor.swift"
    )

    let t1 = context.createUniqueLocalName()
    let t2 = context.createUniqueLocalName()
    XCTAssertNotEqual(t1.description, t2.description)
    XCTAssertEqual(t1.description, "__macro_local_0")
  }

  func testContextIndependence() {
    var system = MacroSystem()
    try! system.add(CheckContextIndependenceMacro.self, name: "checkContext")

    let sf: SourceFileSyntax =
      """
      let b = #checkContext
      """
    var context = MacroExpansionContext(
      moduleName: "MyModule", fileName: "taylor.swift"
    )
    let transformedSF = system.evaluateMacros(
      node: sf, in: &context
    )
    AssertStringsEqualWithDiff(
      transformedSF.description,
      """
      let b = #checkContext
      """
    )

  }
}
