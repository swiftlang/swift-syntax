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

final class NewTypeMacroTests: XCTestCase {
  private let macros = ["NewType": NewTypeMacro.self]

  func testExpansionAddsStringRawType() {
    assertMacroExpansion(
      """
      @NewType(String.self)
      struct Username {
      }
      """,
      expandedSource: """
        struct Username {

          typealias RawValue = String

          var rawValue: RawValue

          init(_ rawValue: RawValue) {
            self.rawValue = rawValue
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithPublicAddsPublicStringRawType() {
    assertMacroExpansion(
      """
      @NewType(String.self)
      public struct MyString {
      }
      """,
      expandedSource: """
        public struct MyString {

          public typealias RawValue = String

          public var rawValue: RawValue

          public init(_ rawValue: RawValue) {
            self.rawValue = rawValue
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionOnClassEmitsError() {
    assertMacroExpansion(
      """
      @NewType(Int.self)
      class NotAUsername {
      }
      """,
      expandedSource: """
        class NotAUsername {
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "@NewType can only be applied to a struct declarations.",
          line: 1,
          column: 1,
          severity: .error
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithMissingRawTypeEmitsError() {
    assertMacroExpansion(
      """
      @NewType
      struct NoRawType {
      }
      """,
      expandedSource: """
        struct NoRawType {
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: #"@NewType requires the raw type as an argument, in the form "RawType.self"."#,
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
