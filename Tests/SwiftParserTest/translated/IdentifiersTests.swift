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

  func testIdentifiers8() {
    AssertParse(
      """
      // Keywords as identifiers
      class #^DIAG_1^#switch {} #^DIAG_2^#
      struct Self {} 
      protocol #^DIAG_3^#enum #^DIAG_4^#{} 
      protocol test {
        associatedtype #^DIAG_5^#public 
      #^DIAG_6^#}
      func #^DIAG_7^#_(_ x: Int) {}#^DIAG_8^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: keyword 'switch' cannot be used as an identifier here
        // TODO: Old parser expected note on line 2: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 7 - 13 = '`switch`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in class"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected member block in class"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '{}' in 'switch' statement"),
        // TODO: Old parser expected error on line 3: keyword 'Self' cannot be used as an identifier here
        // TODO: Old parser expected note on line 3: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 8 - 12 = '`Self`'
        // TODO: Old parser expected error on line 4: keyword 'enum' cannot be used as an identifier here
        // TODO: Old parser expected note on line 4: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 10 - 14 = '`enum`'
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected identifier in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected member block in protocol"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected identifier in enum"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected member block in enum"),
        // TODO: Old parser expected error on line 6: keyword 'public' cannot be used as an identifier here
        // TODO: Old parser expected note on line 6: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 18 - 24 = '`public`'
        DiagnosticSpec(locationMarker: "DIAG_5", message: "expected identifier in associatedtype declaration"),
        DiagnosticSpec(locationMarker: "DIAG_6", message: "unexpected text '}' in function"),
        // TODO: Old parser expected note on line 8: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 6 - 7 = '`_`'
        // TODO: Old parser expected error on line 8: keyword '_' cannot be used as an identifier here
        DiagnosticSpec(locationMarker: "DIAG_7", message: "expected identifier in function"),
        DiagnosticSpec(locationMarker: "DIAG_7", message: "unexpected text '_' before parameter clause"),
        DiagnosticSpec(locationMarker: "DIAG_8", message: "expected '}' to end protocol"),
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
