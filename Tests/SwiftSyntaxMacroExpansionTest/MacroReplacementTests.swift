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
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import XCTest
import _SwiftSyntaxTestSupport

final class MacroReplacementTests: XCTestCase {
  func testMacroDefinitionGood() throws {
    let macro: DeclSyntax =
      """
      macro expand1(a: Int, b: Int) = #otherMacro(first: b, second: ["a": a], third: [3.14159, 2.71828], fourth: 4)
      """

    let definition = try macro.as(MacroDeclSyntax.self)!.checkDefinition()
    guard case let .expansion(_, replacements, _) = definition else {
      XCTFail("not an expansion definition")
      fatalError()
    }

    XCTAssertEqual(replacements.count, 2)
    XCTAssertEqual(replacements[0].parameterIndex, 1)
    XCTAssertEqual(replacements[1].parameterIndex, 0)
  }

  func testMacroDefinitionBad() throws {
    let macro: DeclSyntax =
      """
      macro expand1(a: Int, b: Int) = #otherMacro(first: b + 1, c)
      """

    let diags: [Diagnostic]
    do {
      _ = try macro.as(MacroDeclSyntax.self)!.checkDefinition()
      XCTFail("should have failed with an error")
      fatalError()
    } catch let diagError as DiagnosticsError {
      diags = diagError.diagnostics
    }

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

  func testMacroUndefined() throws {
    let macro: DeclSyntax =
      """
      macro expand1(a: Int, b: Int)
      """

    let diags: [Diagnostic]
    do {
      _ = try macro.as(MacroDeclSyntax.self)!.checkDefinition()
      XCTFail("should have failed with an error")
      fatalError()
    } catch let diagError as DiagnosticsError {
      diags = diagError.diagnostics
    }

    XCTAssertEqual(diags.count, 1)
    XCTAssertEqual(
      diags[0].diagMessage.message,
      "macro expansion requires a definition"
    )
  }

  func testMacroExpansion() throws {
    let macro: DeclSyntax =
      """
      macro expand1(a: Int, b: Int) = #otherMacro(first: b, second: ["a": a], third: [3.14159, 2.71828], fourth: 4)
      """

    let use: ExprSyntax =
      """
      #expand1(a: 5, b: 17)
      """

    let macroDecl = macro.as(MacroDeclSyntax.self)!
    let definition = try macroDecl.checkDefinition()
    guard case let .expansion(expansion, replacements, genericReplacements) = definition else {
      XCTFail("not a normal expansion")
      fatalError()
    }

    let expandedSyntax = macroDecl.expand(
      use.as(MacroExpansionExprSyntax.self)!,
      definition: expansion,
      replacements: replacements,
      genericReplacements: genericReplacements
    )
    assertStringsEqualWithDiff(
      expandedSyntax.description,
      """
      #otherMacro(first: 17, second: ["a": 5], third: [3.14159, 2.71828], fourth: 4)
      """
    )
  }

  func testMacroGenericArgumentExpansion() throws {
    let macro: DeclSyntax =
      """
      macro gen<A, B>(a: A, b: B) = #otherMacro<A, B>(first: a, second: b)
      """

    let use: ExprSyntax =
      """
      #gen<Int, String>(a: 5, b: "Hello")
      """

    let macroDecl = macro.as(MacroDeclSyntax.self)!
    let definition = try macroDecl.checkDefinition()
    guard case let .expansion(expansion, replacements, genericReplacements) = definition else {
      XCTFail("not a normal expansion")
      return
    }

    let replacementA = try XCTUnwrap(genericReplacements.first)
      XCTFail("Expected generic replacement for A")
      return
    }
    guard let replacementB = genericReplacements.dropFirst().first else {
      XCTFail("Expected generic replacement for B")
      return
    }
    XCTAssertEqual(genericReplacements.count, 2)

    XCTAssertEqual(replacementA.parameterIndex, 0)
    XCTAssertEqual("\(replacementA.reference.argument)", "A")

    XCTAssertEqual(replacementB.parameterIndex, 1)
    XCTAssertEqual("\(replacementB.reference.argument)", "B")

    let expandedSyntax = macroDecl.expand(
      use.as(MacroExpansionExprSyntax.self)!,
      definition: expansion,
      replacements: replacements,
      genericReplacements: genericReplacements
    )
    assertStringsEqualWithDiff(
      expandedSyntax.description,
      """
      #otherMacro<A, B>(first: 5, second: "Hello")
      """
    )
  }

  func testMacroGenericArgumentExpansion_ignoreTrivia() throws {
    let macro: DeclSyntax =
      """
      macro gen<A, B /* some comment */>(a: A, b: B) = #otherMacro<A, B>(first: a, second: b)
      """

    let use: ExprSyntax =
      """
      #gen<Int, String>(a: 5, b: "Hello")
      """

    let macroDecl = macro.as(MacroDeclSyntax.self)!
    let definition = try macroDecl.checkDefinition()
    guard case let .expansion(expansion, replacements, genericReplacements) = definition else {
      XCTFail("not a normal expansion")
      return
    }

    guard let replacementA = genericReplacements.first else {
      XCTFail("Expected generic replacement for A")
      return
    }
    guard let replacementB = genericReplacements.dropFirst().first else {
      XCTFail("Expected generic replacement for B")
      return
    }
    XCTAssertEqual(genericReplacements.count, 2)

    XCTAssertEqual(replacementA.parameterIndex, 0)
    XCTAssertEqual("\(replacementA.reference.argument)", "A")

    XCTAssertEqual(replacementB.parameterIndex, 1)
    XCTAssertEqual("\(replacementB.reference.argument)", "B")

    let expandedSyntax = macroDecl.expand(
      use.as(MacroExpansionExprSyntax.self)!,
      definition: expansion,
      replacements: replacements,
      genericReplacements: genericReplacements
    )
    assertStringsEqualWithDiff(
      expandedSyntax.description,
      """
      #otherMacro<A, B>(first: 5, second: "Hello")
      """
    )
  }

  func testMacroGenericArgumentExpansion_notVisitGenericParameterArguments() throws {
    let macro: DeclSyntax =
      """
      macro gen(a: Array<Int>) = #otherMacro(first: a)
      """

    let use: ExprSyntax =
      """
      #gen(a: [1, 2, 3])
      """

    let macroDecl = macro.as(MacroDeclSyntax.self)!
    let definition = try macroDecl.checkDefinition()
    guard case let .expansion(expansion, replacements, genericReplacements) = definition else {
      XCTFail("not a normal expansion")
      return
    }

    XCTAssertEqual(genericReplacements.count, 0)

    let expandedSyntax = macroDecl.expand(
      use.as(MacroExpansionExprSyntax.self)!,
      definition: expansion,
      replacements: replacements,
      genericReplacements: genericReplacements
    )
    assertStringsEqualWithDiff(
      expandedSyntax.description,
      """
      #otherMacro(first: [1, 2, 3])
      """
    )
  }
}
