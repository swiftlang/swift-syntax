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
import SwiftDiagnostics
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class WarningMacroTests: XCTestCase {
  private let macros = ["myWarning": WarningMacro.self]

  func testExpansionWithValidStringLiteralEmitsWarning() {
    assertMacroExpansion(
      """
      #myWarning("This is a warning")
      """,
      expandedSource: """
        ()
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "This is a warning",
          line: 1,
          column: 1,
          severity: .warning
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithInvalidExpressionEmitsError() {
    assertMacroExpansion(
      """
      #myWarning(42)
      """,
      expandedSource: """
        #myWarning(42)
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "#myWarning macro requires a string literal",
          line: 1,
          column: 1,
          severity: .error
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithStringInterpolationEmitsError() {
    assertMacroExpansion(
      #"""
      #myWarning("Say hello \(number) times!")
      """#,
      expandedSource: #"""
        #myWarning("Say hello \(number) times!")
        """#,
      diagnostics: [
        DiagnosticSpec(
          message: "#myWarning macro requires a string literal",
          line: 1,
          column: 1,
          severity: .error
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
