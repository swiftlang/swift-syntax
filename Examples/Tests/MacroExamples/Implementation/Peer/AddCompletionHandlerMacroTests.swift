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

final class AddCompletionHandlerMacroTests: XCTestCase {
  private let macros = ["AddCompletionHandler": AddCompletionHandlerMacro.self]

  func testExpansionTransformsAsyncFunctionToCompletion() {
    assertMacroExpansion(
      """
      @AddCompletionHandler
      func f(a: Int, for b: String, _ value: Double) async -> String {
        return b
      }
      """,
      expandedSource: """
        func f(a: Int, for b: String, _ value: Double) async -> String {
          return b
        }

        func f(a: Int, for b: String, _ value: Double, completionHandler: @escaping (String) -> Void) {
          Task {
            completionHandler(await f(a: a, for: b, value))
          }

        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionOnStoredPropertyEmitsError() {
    assertMacroExpansion(
      """
      struct Test {
        @AddCompletionHandler
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
          message: "@addCompletionHandler only works on functions",
          line: 2,
          column: 3,
          severity: .error
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionOnNonAsyncFunctionEmitsErrorWithFixItSuggestion() {
    assertMacroExpansion(
      """
      struct Test {
        @AddCompletionHandler
        func fetchData() -> String {
          return "Hello, World!"
        }
      }
      """,
      expandedSource: """
        struct Test {
          func fetchData() -> String {
            return "Hello, World!"
          }
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "can only add a completion-handler variant to an 'async' function",
          line: 3,
          column: 3,
          severity: .error,
          fixIts: [FixItSpec(message: "add 'async'")]
        )
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionOnNonAsyncFunctionAppliesFixIt() {
    assertMacroExpansion(
      """
      struct Test {
        @AddCompletionHandler
        func fetchData() -> String {
          return "Hello, World!"
        }
      }
      """,
      expandedSource: """
        struct Test {
          func fetchData() -> String {
            return "Hello, World!"
          }
        }
        """,
      diagnostics: [
        DiagnosticSpec(
          message: "can only add a completion-handler variant to an 'async' function",
          line: 3,
          column: 3,
          severity: .error,
          fixIts: [FixItSpec(message: "add 'async'")]
        )
      ],
      macros: macros,
      applyFixIts: ["add 'async'"],
      fixedSource: """
        struct Test {
          @AddCompletionHandler
          func fetchData() async -> String {
            return "Hello, World!"
          }
        }
        """,
      indentationWidth: .spaces(2)
    )
  }
}
