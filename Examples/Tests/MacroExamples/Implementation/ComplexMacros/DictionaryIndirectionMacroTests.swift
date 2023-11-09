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

final class DictionaryStorageMacroTests: XCTestCase {
  private let macros: [String: Macro.Type] = [
    "DictionaryStorage": DictionaryStorageMacro.self,
    "DictionaryStorageProperty": DictionaryStoragePropertyMacro.self,
  ]

  func testExpansionConvertsStoredProperties() {
    assertMacroExpansion(
      """
      @DictionaryStorage
      struct Point {
        var x: Int = 1
        var y: Int = 2
      }
      """,
      expandedSource: """
        struct Point {
          var x: Int {
            get {
              _storage["x", default: 1] as! Int
            }
            set {
              _storage["x"] = newValue
            }
          }
          var y: Int {
            get {
              _storage["y", default: 2] as! Int
            }
            set {
              _storage["y"] = newValue
            }
          }

          var _storage: [String: Any] = [:]
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionWithoutInitializersEmitsError() {
    assertMacroExpansion(
      """
      @DictionaryStorage
      class Point {
        let x: Int
        let y: Int
      }
      """,
      expandedSource: """
        class Point {
          let x: Int
          let y: Int

          var _storage: [String: Any] = [:]
        }
        """,
      diagnostics: [
        DiagnosticSpec(message: "stored property must have an initializer", line: 3, column: 3),
        DiagnosticSpec(message: "stored property must have an initializer", line: 4, column: 3),
      ],
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }

  func testExpansionIgnoresComputedProperties() {
    assertMacroExpansion(
      """
      @DictionaryStorage
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

          var _storage: [String: Any] = [:]
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
