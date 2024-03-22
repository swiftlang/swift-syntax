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

// This test file has been translated from swift/test/Parse/identifiers.swift

import XCTest

final class IdentifiersTests: ParserTestCase {
  func testIdentifiers1() {
    assertParse(
      """
      func my_print<T>(_ t: T) {}
      """
    )
  }

  func testIdentifiers2() {
    assertParse(
      #"""
      class 你好 {
        class שלום {
          class வணக்கம் {
            class Γειά {
              class func привет() {
                my_print("hello")
              }
            }
          }
        }
      }
      """#
    )
  }

  func testIdentifiers3() {
    assertParse(
      """
      你好.שלום.வணக்கம்.Γειά.привет()
      """
    )
  }

  func testIdentifiers4() {
    assertParse(
      """
      // Identifiers cannot start with combining chars.
      _ = .́duh()
      """
    )
  }

  func testIdentifiers5() {
    assertParse(
      """
      // Combining characters can be used within identifiers.
      func s̈pin̈al_tap̈() {}
      """
    )
  }

  func testIdentifiers6() {
    // Private-use characters aren't valid in Swift source.
    assertParse(
      """
      1️⃣()
      """,
      diagnostics: [
        DiagnosticSpec(message: "invalid character in source file")
      ]
    )
  }

  func testIdentifiers7() {
    assertParse(
      """
      // Placeholders are recognized as identifiers but with error.
      func 1️⃣<#some name#>() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "editor placeholder in source file")
      ]
    )
  }

  func testIdentifiers8a() {
    assertParse(
      """
      // Keywords as identifiers
      class 1️⃣switch {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'switch' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        // Keywords as identifiers
        class `switch` {}
        """
    )
  }

  func testIdentifiers8b() {
    assertParse(
      """
      struct 1️⃣Self {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Self' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        struct `Self` {}
        """
    )
  }

  func testStructNamedLowercaseAny() {
    assertParse(
      """
      struct any {}
      """
    )
  }

  func testStructNamedCapitalAny() {
    assertParse(
      """
      struct 1️⃣Any {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'Any' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        struct `Any` {}
        """
    )
  }

  func testIdentifiers8c() {
    assertParse(
      """
      protocol 1️⃣enum {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'enum' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: """
        protocol `enum` {}
        """
    )
  }

  func testIdentifiers8d() {
    assertParse(
      """
      protocol test {
        associatedtype 1️⃣public
      }
      func 2️⃣_(_ x: Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "keyword 'public' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'_' cannot be used as an identifier here"),
      ],
      fixedSource: """
        protocol test {
          associatedtype `public`
        }
        func _(_ x: Int) {}
        """
    )
  }

  func testIdentifiers9() {
    assertParse(
      """
      // SIL keywords are tokenized as normal identifiers in non-SIL mode.
      _ = undef
      _ = sil
      _ = sil_stage
      _ = sil_vtable
      _ = sil_global
      _ = sil_witness_table
      _ = sil_default_witness_table
      _ = sil_coverage_map
      _ = sil_scope
      """
    )
  }

  func testIdentifiers10() {
    assertParse(
      """
      // https://github.com/apple/swift/issues/57542
      // Make sure we do not parse the '_' on the newline as being part of the 'variable' identifier on the line before.
      """
    )
  }

  func testIdentifiers11() {
    assertParse(
      """
      @propertyWrapper
      struct Wrapper {
        var wrappedValue = 0
      }
      """
    )
  }

  func testIdentifiers12() {
    assertParse(
      """
      func localScope() {
        @Wrapper var variable
        _ = 0
      }
      """
    )
  }

}
