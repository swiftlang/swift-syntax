//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import MacroExamplesImplementation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class URLMacroTests: XCTestCase {
  private let macros = ["URL": URLMacro.self]

  func testExpansionWithMalformedURLEmitsError() {
    assertMacroExpansion(
      """
      let invalid = #URL("https://not a url.com")
      """,
      expandedSource: """
        let invalid = #URL("https://not a url.com")
        """,
      diagnostics: [
        DiagnosticSpec(message: #"malformed url: "https://not a url.com""#, line: 1, column: 15, severity: .error)
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithStringInterpolationEmitsError() {
    assertMacroExpansion(
      #"""
      #URL("https://\(domain)/api/path")
      """#,
      expandedSource: #"""
        #URL("https://\(domain)/api/path")
        """#,
      diagnostics: [
        DiagnosticSpec(message: "#URL requires a static string literal", line: 1, column: 1, severity: .error)
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithValidURL() {
    assertMacroExpansion(
      """
      let valid = #URL("https://swift.org/")
      """,
      expandedSource: """
        let valid = URL(string: "https://swift.org/")!
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
