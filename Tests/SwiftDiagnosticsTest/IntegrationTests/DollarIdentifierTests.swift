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

// This test file has been translated from swift/test/Parse/dollar_identifier.swift

import XCTest

final class DollarIdentifierTests: XCTestCase {
  func testDollarIdentifier1() {
    assertParsedSource(
      """
      func dollarVar() {
        var $ : Int = 42
        $ += 1
        print($)
      }
      """,
      expecting:
        """
        1 │ func dollarVar() {
        2 │   var $ : Int = 42
          │       ╰─ error: '$' is not a valid identifier
        3 │   $ += 1
        4 │   print($)

        """
    )
  }

  func testDollarIdentifier2() {
    assertParsedSource(
      """
      func dollarLet() {
        let $ = 42
        print($)
      }
      """,
      expecting:
        """
        1 │ func dollarLet() {
        2 │   let $ = 42
          │       ╰─ error: '$' is not a valid identifier
        3 │   print($)
        4 │ }

        """
    )
  }

  func testDollarIdentifier3() {
    assertParsedSource(
      """
      func dollarClass() {
        class $ {}
      }
      """,
      expecting:
        """
        1 │ func dollarClass() {
        2 │   class $ {}
          │         ╰─ error: '$' is not a valid identifier
        3 │ }

        """
    )
  }

  func testDollarIdentifier4() {
    assertParsedSource(
      """
      func dollarEnum() {
        enum $ {}
      }
      """,
      expecting:
        """
        1 │ func dollarEnum() {
        2 │   enum $ {}
          │        ╰─ error: '$' is not a valid identifier
        3 │ }

        """
    )
  }

  func testDollarIdentifier5() {
    assertParsedSource(
      """
      func dollarStruct() {
        struct $ {}
      }
      """,
      expecting:
        """
        1 │ func dollarStruct() {
        2 │   struct $ {}
          │          ╰─ error: '$' is not a valid identifier
        3 │ }

        """
    )
  }

  func testDollarIdentifier6() {
    assertParsedSource(
      """
      func $($ dollarParam: Int) {}
      """,
      expecting:
        """
        1 │ func $($ dollarParam: Int) {}
          │      │ ╰─ error: '$' is not a valid identifier
          │      ╰─ error: '$' is not a valid identifier

        """
    )
  }

  func testDollarIdentifier7() {
    assertParsedSource(
      """
      $($: 24)
      """,
      expecting:
        """
        1 │ $($: 24)
          │   ╰─ error: '$' is not a valid identifier

        """
    )
  }

  func testDollarIdentifier8() {
    assertParsedSource(
      """
      func escapedDollarAnd() {
        `$0` = 1
        `$$` = 2
        `$abc` = 3
      }
      """,
      expecting:
        """
        1 │ func escapedDollarAnd() {
        2 │   `$0` = 1
          │   ╰─ error: unexpected code in function
        3 │   `$$` = 2
        4 │   `$abc` = 3

        """
    )
  }

  func testDollarIdentifier9() {
    // https://github.com/apple/swift/issues/55538
    assertParsedSource(
      """
      infix operator $
      """,
      expecting:
        """
        1 │ infix operator $
          │                ╰─ error: '$' is not allowed in operator names

        """
    )
  }

  func testDollarIdentifier10() {
    // https://github.com/apple/swift/issues/55538
    assertParsedSource(
      """
      infix operator `$`
      """,
      expecting:
        """
        1 │ infix operator `$`
          │                ╰─ error: '`$`' is considered an identifier and must not appear within an operator name

        """
    )
  }
}
