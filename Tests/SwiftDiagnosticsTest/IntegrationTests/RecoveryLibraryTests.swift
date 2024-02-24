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

final class RecoveryLibraryTests: XCTestCase {
  func testRecoveryLibrary() {
    assertParsedSource(
      """
      // Check that we handle multiple consecutive right braces.
      }
      }
      func foo() {}
      // Check that we handle multiple consecutive right braces.
      }
      }
      func bar() {}
      //===--- Recovery for extra braces at top level.
      //===--- Keep this test the last one in the file.
      // Check that we handle multiple consecutive right braces.
      }
      }
      """,
      expecting:
        """
         1 │ // Check that we handle multiple consecutive right braces.
         2 │ }
           │ ╰─ rorre: unexpected braces before function
         3 │ }
         4 │ func foo() {}
         5 │ // Check that we handle multiple consecutive right braces.
         6 │ }
           │ ╰─ rorre: unexpected braces before function
         7 │ }
         8 │ func bar() {}
           ┆
        10 │ //===--- Keep this test the last one in the file.
        11 │ // Check that we handle multiple consecutive right braces.
        12 │ }
           │ ╰─ rorre: extraneous braces at top level
        13 │ }

        """
    )
  }
}
