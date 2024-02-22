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

final class IdentifiersTests: XCTestCase {
  func testIdentifiers1() {
    // Private-use characters aren't valid in Swift source.
    assertParsedSource(
      """
      ()
      """,
      expecting:
        """
        1 │ ()
          │ ╰─ error: invalid character in source file

        """
    )
  }

  func testIdentifiers2() {
    assertParsedSource(
      """
      // Placeholders are recognized as identifiers but with error.
      func <#some name#>() {}
      """,
      expecting:
        """
        1 │ // Placeholders are recognized as identifiers but with error.
        2 │ func <#some name#>() {}
          │      ╰─ error: editor placeholder in source file

        """
    )
  }

  func testIdentifiers3() {
    assertParsedSource(
      """
      // Keywords as identifiers
      class switch {}
      """,
      expecting:
        """
        1 │ // Keywords as identifiers
        2 │ class switch {}
          │       ╰─ error: keyword 'switch' cannot be used as an identifier here

        """
    )
  }

  func testIdentifiers4() {
    assertParsedSource(
      """
      struct Self {}
      """,
      expecting:
        """
        1 │ struct Self {}
          │        ╰─ error: keyword 'Self' cannot be used as an identifier here

        """
    )
  }

  func testIdentifiers5() {
    assertParsedSource(
      """
      struct Any {}
      """,
      expecting:
        """
        1 │ struct Any {}
          │        ╰─ error: keyword 'Any' cannot be used as an identifier here

        """
    )
  }

  func testIdentifiers6() {
    assertParsedSource(
      """
      protocol enum {}
      """,
      expecting:
        """
        1 │ protocol enum {}
          │          ╰─ error: keyword 'enum' cannot be used as an identifier here

        """
    )
  }

  func testIdentifiers7() {
    assertParsedSource(
      """
      protocol test {
        associatedtype public
      }
      func _(_ x: Int) {}
      """,
      expecting:
        """
        1 │ protocol test {
        2 │   associatedtype public
          │                  ╰─ error: keyword 'public' cannot be used as an identifier here
        3 │ }
        4 │ func _(_ x: Int) {}
          │      ╰─ error: '_' cannot be used as an identifier here

        """
    )
  }
}
