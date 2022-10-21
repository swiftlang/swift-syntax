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

// This test file has been translated from swift/test/Parse/hashbang_library.swift

import XCTest

final class HashbangLibraryTests: XCTestCase {
  func testHashbangLibrary1() {
    AssertParse(
      """
      #!/usr/bin/swift 
      class Foo {}
      // Check that we diagnose and skip the hashbang at the beginning of the file
      // when compiling in library mode.
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: hashbang line is allowed only in the main file
      ]
    )
  }

}
