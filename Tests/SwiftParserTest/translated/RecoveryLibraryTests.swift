// This test file has been translated from swift/test/Parse/recovery_library.swift

import XCTest

final class RecoveryLibraryTests: XCTestCase {
  func testRecoveryLibrary1() {
    AssertParse(
      """
      //===--- Recovery for extra braces at top level.
      //===--- Keep this test the first one in the file.
      """
    )
  }

  func testRecoveryLibrary2() {
    AssertParse(
      """
      // Check that we handle multiple consecutive right braces.
      #^DIAG_1^#} 
      } 
      func foo() {}
      // Check that we handle multiple consecutive right braces.
      #^DIAG_2^#} 
      } 
      func bar() {}
      //===--- Recovery for extra braces at top level.
      //===--- Keep this test the last one in the file.
      // Check that we handle multiple consecutive right braces.
      #^DIAG_3^#} 
      }
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: extraneous '}' at top level, Fix-It replacements: 1 - 3 = ''
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text before function"),
        // TODO: Old parser expected error on line 3: extraneous '}' at top level, Fix-It replacements: 1 - 3 = ''
        // TODO: Old parser expected error on line 6: extraneous '}' at top level, Fix-It replacements: 1 - 3 = ''
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text before function"),
        // TODO: Old parser expected error on line 7: extraneous '}' at top level, Fix-It replacements: 1 - 3 = ''
        // TODO: Old parser expected error on line 12: extraneous '}' at top level, Fix-It replacements: 1 - 3 = ''
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 13: extraneous '}' at top level, Fix-It replacements: 1 - 3 = ''
      ]
    )
  }

}
