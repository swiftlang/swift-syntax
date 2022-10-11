// This test file has been translated from swift/test/Parse/recovery_library.swift

import XCTest

final class RecoveryLibraryTests: XCTestCase {
  func testRecoveryLibrary() {
    AssertParse(
      """
      // Check that we handle multiple consecutive right braces.
      1️⃣} 
      } 
      func foo() {}
      // Check that we handle multiple consecutive right braces.
      2️⃣} 
      } 
      func bar() {}
      //===--- Recovery for extra braces at top level.
      //===--- Keep this test the last one in the file.
      // Check that we handle multiple consecutive right braces.
      3️⃣} 
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected braces before function", highlight: """
        // Check that we handle multiple consecutive right braces.
        }
        }
        """),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected braces before function"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous braces at top level"),
      ]
    )
  }

}
