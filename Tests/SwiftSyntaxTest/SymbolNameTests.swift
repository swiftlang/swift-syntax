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

import SwiftSyntax
import XCTest

final class SymbolNameTests: XCTestCase {

  // MARK: - Functions

  func testFunctionNameWithoutParameters() {
    assertSymbolName(ofFunction: "func name() {}", expecting: "name()")
  }

  func testFunctionNameWithSingleNamedParameter() {
    assertSymbolName(ofFunction: "func name(one: Int) {}", expecting: "name(one:)")
  }

  func testFunctionNameWithSingleUnnamedParameter() {
    assertSymbolName(ofFunction: "func name(_: Int) {}", expecting: "name(_:)")
  }

  func testFunctionNameWithExternalParameterName() {
    assertSymbolName(ofFunction: "func name(one two: Int) {}", expecting: "name(one:)")
  }

  func testFunctionNameWithExplicitExternalParameterName() {
    assertSymbolName(ofFunction: "func name(one _: Int) {}", expecting: "name(one:)")
  }

  func testFunctionNameWithImplicitExternalParameterName() {
    assertSymbolName(ofFunction: "func name(_ two: Int) {}", expecting: "name(_:)")
  }

  func testFunctionNameWithOnlyAnonymousParameters() {
    assertSymbolName(ofFunction: "func name(_ _: Int) {}", expecting: "name(_:)")
  }

  func testFunctionNameWithMultipleNamedParameters() {
    assertSymbolName(ofFunction: "func name(one two: Int, three: Int) {}", expecting: "name(one:three:)")
  }

  func testFunctionNameWithAllParametersHavingExternalNames() {
    assertSymbolName(ofFunction: "func name(one two: Int, three four: Int) {}", expecting: "name(one:three:)")
  }

  func testFunctionNameWithMixedNamedAndAnonymousParameters() {
    assertSymbolName(ofFunction: "func name(one two: Int, _ four: Int) {}", expecting: "name(one:_:)")
  }

  func testFunctionNameWithAllAnonymousParameters() {
    assertSymbolName(ofFunction: "func name(_ two: Int, _ four: Int) {}", expecting: "name(_:_:)")
  }

  func testFunctionNameWithBackticks() {
    assertSymbolName(ofFunction: "func `name`() {}", expecting: "`name`()")
  }

  func testFunctionNameWithParameterNameInBackticks() {
    assertSymbolName(ofFunction: "func name(`one`: Int) {}", expecting: "name(`one`:)")
  }

  func testOperatorFunctionName() {
    assertSymbolName(ofFunction: "func == (one: Int, two: Int)", expecting: "==(one:two:)")
  }

  // MARK: - Initializer

  func testInitializerWithoutParameters() {
    assertSymbolName(ofInitializer: "init() {}", expecting: "init()")
  }

  func testInitializerWithSingleNamedParameter() {
    assertSymbolName(ofInitializer: "init(one: Int) {}", expecting: "init(one:)")
  }

  func testInitializerWithSingleUnnamedParameter() {
    assertSymbolName(ofInitializer: "init(_: Int) {}", expecting: "init(_:)")
  }

  func testInitializerWithExternalParameterName() {
    assertSymbolName(ofInitializer: "init(one two: Int) {}", expecting: "init(one:)")
  }

  func testInitializerWithExplicitExternalParameterName() {
    assertSymbolName(ofInitializer: "init(one _: Int) {}", expecting: "init(one:)")
  }

  func testInitializerWithImplicitExternalParameterName() {
    assertSymbolName(ofInitializer: "init(_ two: Int) {}", expecting: "init(_:)")
  }

  func testInitializerWithOnlyAnonymousParameters() {
    assertSymbolName(ofInitializer: "init(_ _: Int) {}", expecting: "init(_:)")
  }

  func testInitializerWithMultipleNamedParameters() {
    assertSymbolName(ofInitializer: "init(one two: Int, three: Int) {}", expecting: "init(one:three:)")
  }

  func testInitializerWithAllParametersHavingExternalNames() {
    assertSymbolName(ofInitializer: "init(one two: Int, three four: Int) {}", expecting: "init(one:three:)")
  }

  func testInitializerWithMixedNamedAndAnonymousParameters() {
    assertSymbolName(ofInitializer: "init(one two: Int, _ four: Int) {}", expecting: "init(one:_:)")
  }

  func testInitializerWithAllAnonymousParameters() {
    assertSymbolName(ofInitializer: "init(_ two: Int, _ four: Int) {}", expecting: "init(_:_:)")
  }

  func testInitializerWithNameInBackticks() {
    assertSymbolName(ofInitializer: "init(`one`: Int) {}", expecting: "init(`one`:)")
  }

  // MARK: - Subscript

  func testSubscriptNameWithoutParameters() {
    assertSymbolName(ofSubscript: "subscript() -> Int { 0 }", expecting: "subscript()")
  }

  func testSubscriptNameWithSingleNamedParameter() {
    assertSymbolName(ofSubscript: "subscript(index: Int) -> Int { 0 }", expecting: "subscript(_:)")
  }

  func testSubscriptNameWithSingleUnnamedParameter() {
    assertSymbolName(ofSubscript: "subscript(_: Int) -> Int { 0 }", expecting: "subscript(_:)")
  }

  func testSubscriptNameWithExternalParameterName() {
    assertSymbolName(ofSubscript: "subscript(index i: Int) -> Int { 0 }", expecting: "subscript(index:)")
  }

  func testSubscriptNameWithExplicitExternalParameterName() {
    assertSymbolName(ofSubscript: "subscript(index _: Int) -> Int { 0 }", expecting: "subscript(index:)")
  }

  func testSubscriptNameWithImplicitExternalParameterName() {
    assertSymbolName(ofSubscript: "subscript(_ i: Int) -> Int { 0 }", expecting: "subscript(_:)")
  }

  func testSubscriptNameWithOnlyAnonymousParameters() {
    assertSymbolName(ofSubscript: "subscript(_ _: Int) -> Int { 0 }", expecting: "subscript(_:)")
  }

  func testSubscriptNameWithMultipleNamedParameters() {
    assertSymbolName(ofSubscript: "subscript(x: Int, y: Int) -> Int { 0 }", expecting: "subscript(_:_:)")
  }

  func testSubscriptNameWithMultipleParametersAndExternalNames() {
    assertSymbolName(
      ofSubscript: "subscript(indexX x: Int, indexY y: Int) -> Int { 0 }",
      expecting: "subscript(indexX:indexY:)"
    )
  }

  func testSubscriptNameWithParameterNameInBackticks() {
    assertSymbolName(ofSubscript: "subscript(`index` i: Int) -> Int { 0 }", expecting: "subscript(`index`:)")
  }

  // MARK: - Enum Case Element

  func testEnumCaseElementWithoutAssociatedValues() {
    assertSymbolName(ofEnumCase: "case a", expecting: "a")
  }

  func testEnumCaseElementWithSingleNamedAssociatedValue() {
    assertSymbolName(ofEnumCase: "case b(c: Int)", expecting: "b(c:)")
  }

  func testEnumCaseElementWithSingleUnnamedAssociatedValue() {
    assertSymbolName(ofEnumCase: "case d(Int)", expecting: "d(_:)")
  }

  func testEnumCaseElementWithSingleUnnamedAssociatedValueWithUnderscore() {
    assertSymbolName(ofEnumCase: "case e(_: Int)", expecting: "e(_:)")
  }

  func testEnumCaseElementWithMultipleNamedAssociatedValues() {
    assertSymbolName(ofEnumCase: "case f(g: Int, h: Int)", expecting: "f(g:h:)")
  }

  func testEnumCaseElementNameWithBackticks() {
    assertSymbolName(ofEnumCase: "case `i`", expecting: "`i`")
  }

  func testEnumCaseElementWithAssociatedValueNameInBackticks() {
    assertSymbolName(ofEnumCase: "case j(`k`: Int)", expecting: "j(`k`:)")
  }

  // MARK: - Macro

  func testMacroDeclWithoutParameters() {
    assertSymbolName(ofMacroDecl: "macro myMacro()", expecting: "myMacro()")
  }

  func testMacroDeclWithSingleNamedParameter() {
    assertSymbolName(ofMacroDecl: "macro myMacro(x: Int)", expecting: "myMacro(x:)")
  }

  func testMacroDeclWithSingleUnnamedParameter() {
    assertSymbolName(ofMacroDecl: "macro myMacro(_: Int)", expecting: "myMacro(_:)")
  }

  func testMacroDeclWithExternalParameterName() {
    assertSymbolName(ofMacroDecl: "macro myMacro(external internal: Int)", expecting: "myMacro(external:)")
  }

  func testMacroDeclWithExplicitExternalParameterName() {
    assertSymbolName(ofMacroDecl: "macro myMacro(external _: Int)", expecting: "myMacro(external:)")
  }

  func testMacroDeclWithImplicitExternalParameterName() {
    assertSymbolName(ofMacroDecl: "macro myMacro(_ internal: Int)", expecting: "myMacro(_:)")
  }

  func testMacroDeclWithMultipleNamedParameters() {
    assertSymbolName(ofMacroDecl: "macro myMacro(x: Int, y: String)", expecting: "myMacro(x:y:)")
  }

  func testMacroDeclWithAllParametersHavingExternalNames() {
    assertSymbolName(
      ofMacroDecl: "macro myMacro(external1 internal1: Int, external2 internal2: String)",
      expecting: "myMacro(external1:external2:)"
    )
  }

  func testMacroDeclWithMixedNamedAndUnnamedParameters() {
    assertSymbolName(ofMacroDecl: "macro myMacro(x: Int, _: String)", expecting: "myMacro(x:_:)")
  }

  func testMacroDeclWithNameInBackticks() {
    assertSymbolName(ofMacroDecl: "macro `myMacro`()", expecting: "`myMacro`()")
  }

  func testMacroDeclWithParameterNameInBackticks() {
    assertSymbolName(ofMacroDecl: "macro myMacro(`x`: Int)", expecting: "myMacro(`x`:)")
  }

  func testMacroDeclWithExternalParameterNameInBackticks() {
    assertSymbolName(ofMacroDecl: "macro myMacro(`external` internal: Int)", expecting: "myMacro(`external`:)")
  }
}

// MARK: - Assertions

private func assertSymbolName(
  ofFunction function: DeclSyntax,
  expecting expectedSymbolName: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  guard let functionDecl = function.as(FunctionDeclSyntax.self) else {
    XCTFail("Expected function declaration not found.", file: file, line: line)
    return
  }

  XCTAssertEqual(functionDecl.symbolName, expectedSymbolName, file: file, line: line)
}

private func assertSymbolName(
  ofInitializer initializer: DeclSyntax,
  expecting expectedSymbolName: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  guard let initializerDecl = initializer.as(InitializerDeclSyntax.self) else {
    XCTFail("Expected initializer declaration not found.", file: file, line: line)
    return
  }

  XCTAssertEqual(initializerDecl.symbolName, expectedSymbolName, file: file, line: line)
}

private func assertSymbolName(
  ofSubscript subscriptDeclaration: DeclSyntax,
  expecting expectedSymbolName: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  guard let subscriptDecl = subscriptDeclaration.as(SubscriptDeclSyntax.self) else {
    XCTFail("Expected subscript declaration not found.", file: file, line: line)
    return
  }

  XCTAssertEqual(subscriptDecl.symbolName, expectedSymbolName, file: file, line: line)
}

private func assertSymbolName(
  ofEnumCase enumCaseDeclaration: DeclSyntax,
  expecting expectedSymbolName: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  guard let enumCaseDecl = enumCaseDeclaration.as(EnumCaseDeclSyntax.self),
    let enumCaseElement = enumCaseDecl.elements.first
  else {
    XCTFail("Expected enum case element declaration not found.", file: file, line: line)
    return
  }
  XCTAssertEqual(enumCaseElement.symbolName, expectedSymbolName, file: file, line: line)
}

private func assertSymbolName(
  ofMacroDecl macroDecl: DeclSyntax,
  expecting expectedSymbolName: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  guard let macroDeclSyntax = macroDecl.as(MacroDeclSyntax.self) else {
    XCTFail("Expected macro declaration not found.", file: file, line: line)
    return
  }

  XCTAssertEqual(macroDeclSyntax.symbolName, expectedSymbolName, file: file, line: line)
}
