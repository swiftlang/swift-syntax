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

final class DefaultFatalErrorImplementationMacroTests: XCTestCase {
  private let macros = ["defaultFatalErrorImplementation": DefaultFatalErrorImplementationMacro.self]

  func testExpansionWhenAttachedToProtocolExpandsCorrectly() {
    assertMacroExpansion(
      """
      @defaultFatalErrorImplementation
      protocol MyProtocol {
        func foo()
        func bar() -> Int
      }
      """,
      expandedSource: """
        protocol MyProtocol {
          func foo()
          func bar() -> Int
        }

        extension MyProtocol {
          func foo() {
            fatalError("whoops 😅")
          }
          func bar() -> Int {
            fatalError("whoops 😅")
          }
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWhenNotAttachedToProtocolProducesDiagnostic() {
    assertMacroExpansion(
      """
      @defaultFatalErrorImplementation
      class MyClass {}
      """,
      expandedSource: """
        class MyClass {}
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "Macro `defaultFatalErrorImplementation` can only be applied to a protocol",
          line: 1,
          column: 1
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWhenAttachedToEmptyProtocolDoesNotAddExtension() {
    assertMacroExpansion(
      """
      @defaultFatalErrorImplementation
      protocol EmptyProtocol {}
      """,
      expandedSource: """
        protocol EmptyProtocol {}
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
