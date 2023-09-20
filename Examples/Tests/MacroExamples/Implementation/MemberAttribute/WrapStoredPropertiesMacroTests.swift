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
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class WrapStoredPropertiesMacroTests: XCTestCase {
  private let macros = ["wrapStoredProperties": WrapStoredPropertiesMacro.self]

  func testExpansionAddsPublished() {
    assertMacroExpansion(
      """
      @wrapStoredProperties("Published")
      struct Test {
        var value: Int
      }
      """,
      expandedSource: """
        struct Test {
          @Published
          var value: Int
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionAddsDeprecationAttribute() {
    assertMacroExpansion(
      """
      @wrapStoredProperties(#"available(*, deprecated, message: "hands off my data")"#)
      struct Test {
        var value: Int
      }
      """,
      expandedSource: """
        struct Test {
          @available(*, deprecated, message: "hands off my data")
          var value: Int
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionIgnoresComputedProperty() {
    assertMacroExpansion(
      """
      @wrapStoredProperties("Published")
      struct Test {
        var value: Int {
          get { return 0 }
          set {}
        }
      }
      """,
      expandedSource: """
        struct Test {
          var value: Int {
            get { return 0 }
            set {}
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithInvalidAttributeEmitsError() {
    assertMacroExpansion(
      """
      @wrapStoredProperties(12)
      struct Test {
        var value: Int
      }
      """,
      expandedSource: """
        struct Test {
          var value: Int
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "macro requires a string literal containing the name of an attribute",
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
