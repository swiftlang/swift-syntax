//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/Parse/identifiers.swift

import XCTest

final class IdentifiersTests: XCTestCase {
  func testIdentifiers1() {
    AssertParse(
      """
      func my_print<T>(_ t: T) {}
      """
    )
  }

  func testIdentifiers2() {
    AssertParse(
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
    AssertParse(
      """
      你好.שלום.வணக்கம்.Γειά.привет()
      """
    )
  }

  func testIdentifiers4() {
    AssertParse(
      """
      // Identifiers cannot start with combining chars.
      _ = .́duh()
      """
    )
  }

  func testIdentifiers5() {
    AssertParse(
      """
      // Combining characters can be used within identifiers.
      func s̈pin̈al_tap̈() {}
      """
    )
  }

  func testIdentifiers6() {
    AssertParse(
      """
      // Private-use characters aren't valid in Swift source.
      ()
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: invalid character in source file, Fix-It replacements: 1 - 4 = ' '
      ]
    )
  }

  func testIdentifiers7() {
    AssertParse(
      """
      // Placeholders are recognized as identifiers but with error.
      func <#some name#>() {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: editor placeholder in source file
      ]
    )
  }

  func testIdentifiers8a() {
    AssertParse(
      """
      // Keywords as identifiers
      class 1️⃣switch {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'switch' cannot be used as an identifier here", fixIts: ["if this name is unavoidable, use backticks to escape it"])
      ],
      fixedSource: """
        // Keywords as identifiers
        class `switch` {}
        """
    )
  }

  func testIdentifiers8b() {
    AssertParse(
      """
      struct Self {}
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 3: keyword 'Self' cannot be used as an identifier here
        // TODO: Old parser expected note on line 3: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 8 - 12 = '`Self`'
      ]
    )
  }

  func testIdentifiers8c() {
    AssertParse(
      """
      protocol 1️⃣enum {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "keyword 'enum' cannot be used as an identifier here")
      ]
    )
  }

  func testIdentifiers8d() {
    AssertParse(
      """
      protocol test {
        associatedtype 1️⃣public
      }
      func 2️⃣_(_ x: Int) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "keyword 'public' cannot be used as an identifier here"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'_' cannot be used as an identifier here"),
      ]
    )
  }

  func testIdentifiers9() {
    AssertParse(
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
    AssertParse(
      """
      // https://github.com/apple/swift/issues/57542
      // Make sure we do not parse the '_' on the newline as being part of the 'variable' identifier on the line before.
      """
    )
  }

  func testIdentifiers11() {
    AssertParse(
      """
      @propertyWrapper 
      struct Wrapper {
        var wrappedValue = 0
      }
      """
    )
  }

  func testIdentifiers12() {
    AssertParse(
      """
      func localScope() {
        @Wrapper var variable
        _ = 0
      }
      """
    )
  }

}
