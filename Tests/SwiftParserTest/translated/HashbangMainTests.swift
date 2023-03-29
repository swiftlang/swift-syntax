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

// This test file has been translated from swift/test/Parse/hashbang_main.swift

import XCTest

final class HashbangMainTests: XCTestCase {
  func testHashbangMain1() {
    assertParse(
      """
      #!/usr/bin/swift
      let x = 42
      x + x
      // Check that we skip the hashbang at the beginning of the file.
      """
    )
  }

}
