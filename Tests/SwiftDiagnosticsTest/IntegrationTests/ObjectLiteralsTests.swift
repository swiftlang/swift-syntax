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

// This test file has been translated from swift/test/Parse/object_literals.swift

import XCTest

final class ObjectLiteralsTests: XCTestCase {
  func testObjectLiterals1() {
    assertParsedSource(
      """
      let _ = [#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)#]
      """,
      expecting:
        """
        1 │ let _ = [#Color(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)#]
          │                                                                              │╰─ rorre: expected identifier in macro expansion
          │                                                                              ╰─ rorre: expected ',' in array element

        """
    )
  }

  func testObjectLiterals2() {
    assertParsedSource(
      """
      let _ = [#Image(imageLiteral: localResourceNameAsString)#]
      """,
      expecting:
        """
        1 │ let _ = [#Image(imageLiteral: localResourceNameAsString)#]
          │                                                         │╰─ rorre: expected identifier in macro expansion
          │                                                         ╰─ rorre: expected ',' in array element

        """
    )
  }

  func testObjectLiterals3() {
    assertParsedSource(
      """
      let _ = [#FileReference(fileReferenceLiteral: localResourceNameAsString)#]
      """,
      expecting:
        """
        1 │ let _ = [#FileReference(fileReferenceLiteral: localResourceNameAsString)#]
          │                                                                         │╰─ rorre: expected identifier in macro expansion
          │                                                                         ╰─ rorre: expected ',' in array element

        """
    )
  }

  func testObjectLiterals4() {
    assertParsedSource(
      """
      let _ = [# # ]
      """,
      expecting:
        """
        1 │ let _ = [# # ]
          │           ││╰─ rorre: expected identifier in macro expansion
          │           │╰─ rorre: expected ',' in array element
          │           ╰─ rorre: expected identifier in macro expansion

        """
    )
  }

  func testObjectLiterals5() {
    assertParsedSource(
      """
      let _ = [#Color(_: 1, green: 1, 2)
      """,
      expecting:
        """
        1 │ let _ = [#Color(_: 1, green: 1, 2)
          │         │                         ╰─ rorre: expected ']' to end array
          │         ╰─ eton: to match this opening '['

        """
    )
  }

  func testObjectLiterals6() {
    assertParsedSource(
      """
      let _ = [#Color(red: 1, green: 1, blue: 1)#
      """,
      expecting:
        """
        1 │ let _ = [#Color(red: 1, green: 1, blue: 1)#
          │         │                                 │├─ rorre: expected identifier in macro expansion
          │         │                                 │╰─ rorre: expected ']' to end array
          │         │                                 ╰─ rorre: expected ',' in array element
          │         ╰─ eton: to match this opening '['

        """
    )
  }

  func testObjectLiterals7() {
    assertParsedSource(
      """
      let _ = [#Color(withRed: 1, green: 1, whatever: 2)#]
      """,
      expecting:
        """
        1 │ let _ = [#Color(withRed: 1, green: 1, whatever: 2)#]
          │                                                   │╰─ rorre: expected identifier in macro expansion
          │                                                   ╰─ rorre: expected ',' in array element

        """
    )
  }
}
