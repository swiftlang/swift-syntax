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

// This test file has been translated from swift/test/Parse/toplevel_library.swift

import XCTest

final class ToplevelLibraryTests: XCTestCase {
  func testToplevelLibrary1() {
    assertParse(
      """
      // make sure trailing semicolons are valid syntax in toplevel library code.
      var x = 4;
      """
    )
  }

  func testToplevelLibraryInvalid1() {
    assertParse(
      """
      let x = 42
      x + x;
      x + x;
      // Make sure we don't crash on closures at the top level
      ({ })
      ({ 5 }())
      """
    )
  }

  func testToplevelLibraryInvalid2() {
    assertParse(
      """
      for i1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'in', expression, and body in 'for' statement", fixIts: ["insert 'in', expression, and body"])
      ],
      fixedSource: """
        for i in <#expression#> {
        }
        """
    )
  }
}
