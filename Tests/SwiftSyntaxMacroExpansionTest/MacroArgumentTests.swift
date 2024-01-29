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

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import XCTest
import _SwiftSyntaxTestSupport

final class MacroArgumentTests: XCTestCase {
  func testDefaultArgumentMacroExprGood() throws {
    let macro: ExprSyntax =
      """
      #otherMacro(first: (/foo/, 0x42), second: ["a": nil], third: [3.14159, -2.71828], fourth: true)
      """

    XCTAssertNoThrow(try macro.as(MacroExpansionExprSyntax.self)!
      .checkDefaultArgumentMacroExpression())
  }

  func testDefaultArgumentMacroExprNonLiteral() throws {
    let macro: ExprSyntax =
      #"""
      #otherMacro(first: b, second: "\(false)", third: 1 + 2)
      """#

    let diags: [Diagnostic]
    do {
      try macro.as(MacroExpansionExprSyntax.self)!
        .checkDefaultArgumentMacroExpression()
      XCTFail("should have failed with an error")
      fatalError()
    } catch let diagError as DiagnosticsError {
      diags = diagError.diagnostics
    }

    XCTAssertEqual(diags.count, 3)
    for diag in diags {
      XCTAssertEqual(
        diag.diagMessage.message,
        "only literals are permitted"
      )
    }
  }
}
