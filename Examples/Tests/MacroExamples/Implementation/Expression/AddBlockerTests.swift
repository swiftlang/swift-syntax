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
import SwiftSyntaxMacrosTestSupport
import XCTest

final class AddBlockerTests: XCTestCase {
  private let macros = ["addBlocker": AddBlocker.self]

  func testExpansionTransformsAdditionToSubtractionAndEmitsWarning() {
    assertMacroExpansion(
      """
      #addBlocker(x * y + z)
      """,
      expandedSource: """
        x * y - z
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "blocked an add; did you mean to subtract?",
          line: 1,
          column: 19,
          severity: .warning,
          fixIts: [FixItSpec(message: "use '-'")]
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithSubtractionAppliesFixIt() {
    assertMacroExpansion(
      """
      #addBlocker(x * y + z)
      """,
      expandedSource: """
        x * y - z
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "blocked an add; did you mean to subtract?",
          line: 1,
          column: 19,
          severity: .warning,
          fixIts: [FixItSpec(message: "use '-'")]
        )
      ],
      macros: macros,
      applyFixIts: ["use '-'"],
      fixedSource:
        """
        #addBlocker(x * y - z)
        """,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionPreservesSubtraction() {
    assertMacroExpansion(
      """
      #addBlocker(x * y - z)
      """,
      expandedSource: """
        x * y - z
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
