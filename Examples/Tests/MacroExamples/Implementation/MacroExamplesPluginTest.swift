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

import MacroExamplesImplementation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros
import XCTest

var testMacros: [String: Macro.Type] = [
  "stringify": StringifyMacro.self
]

final class MacroExamplesPluginTests: XCTestCase {
  func testStringify() {
    let sf: SourceFileSyntax =
      #"""
      let a = #stringify(x + y)
      let b = #stringify("Hello, \(name)")
      """#
    let context = BasicMacroExpansionContext.init(
      sourceFiles: [sf: .init(moduleName: "MyModule", fullFilePath: "test.swift")]
    )
    let transformedSF = sf.expand(macros: testMacros, in: context)
    XCTAssertEqual(
      transformedSF.description,
      #"""
      let a = (x + y, "x + y")
      let b = ("Hello, \(name)", #""Hello, \(name)""#)
      """#
    )
  }

  func testURL() throws {
    let sf: SourceFileSyntax =
      #"""
      let invalid = #URL("https://not a url.com")
      let valid = #URL("https://swift.org/")
      """#
    let context = BasicMacroExpansionContext.init(
      sourceFiles: [sf: .init(moduleName: "MyModule", fullFilePath: "test.swift")]
    )
    let transformedSF = sf.expand(macros: ["URL": URLMacro.self], in: context)
    XCTAssertEqual(
      transformedSF.description,
      #"""
      let invalid = #URL("https://not a url.com")
      let valid = URL(string: "https://swift.org/")!
      """#
    )
    XCTAssertEqual(context.diagnostics.count, 1)
    let diagnostic = try XCTUnwrap(context.diagnostics.first)
    XCTAssertEqual(diagnostic.message, #"malformed url: "https://not a url.com""#)
    XCTAssertEqual(diagnostic.diagMessage.severity, .error)
  }
}
