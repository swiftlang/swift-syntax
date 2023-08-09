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

// This test file has been translated from swift/test/Parse/recovery_library.swift

import XCTest

final class RecoveryLibraryTests: ParserTestCase {
  func testRecoveryLibrary() {
    assertParse(
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
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "unexpected braces before function",
          highlight: """
            // Check that we handle multiple consecutive right braces.
            }
            }
            """
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected braces before function"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous braces at top level"),
      ]
    )
  }

}
