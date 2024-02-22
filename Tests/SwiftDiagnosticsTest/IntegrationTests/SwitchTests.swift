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

// This test file has been translated from swift/test/Parse/switch.swift

import XCTest

final class SwitchTests: XCTestCase {
  func testSwitch1() {
    assertParsedSource(
      """
      func parseError1(x: Int) {
        switch func {}
      }
      """,
      expecting:
        """
        1 │ func parseError1(x: Int) {
        2 │   switch func {}
          │          │    ╰─ error: expected identifier and function signature in function
          │          ╰─ error: expected expression and '{}' to end 'switch' statement
        3 │ }

        """
    )
  }

  func testSwitch2() {
    assertParsedSource(
      """
      func parseError2(x: Int) {
        switch x
      }
      """,
      expecting:
        """
        1 │ func parseError2(x: Int) {
        2 │   switch x
          │           ╰─ error: expected '{}' in 'switch' statement
        3 │ }

        """
    )
  }

  func testSwitch3() {
    assertParsedSource(
      """
      func parseError3(x: Int) {
        switch x {
          case
        }
      }
      """,
      expecting:
        """
        1 │ func parseError3(x: Int) {
        2 │   switch x {
        3 │     case
          │         ╰─ error: expected expression and ':' in switch case
        4 │   }
        5 │ }

        """
    )
  }

  func testSwitch4() {
    assertParsedSource(
      """
      func parseError4(x: Int) {
        switch x {
        case var z where
        }
      }
      """,
      expecting:
        """
        1 │ func parseError4(x: Int) {
        2 │   switch x {
        3 │   case var z where
          │                   ├─ error: expected expression in 'where' clause
          │                   ╰─ error: expected ':' in switch case
        4 │   }
        5 │ }

        """
    )
  }

  func testSwitch5() {
    assertParsedSource(
      """
      func parseError5(x: Int) {
        switch x {
        case let z
        }
      }
      """,
      expecting:
        """
        1 │ func parseError5(x: Int) {
        2 │   switch x {
        3 │   case let z
          │             ╰─ error: expected ':' in switch case
        4 │   }
        5 │ }

        """
    )
  }

  func testSwitch6() {
    assertParsedSource(
      """
      func parseError6(x: Int) {
        switch x {
        default
        }
      }
      """,
      expecting:
        """
        1 │ func parseError6(x: Int) {
        2 │   switch x {
        3 │   default
          │          ╰─ error: expected ':' in switch case
        4 │   }
        5 │ }

        """
    )
  }

  func testSwitch7() {
    assertParsedSource(
      """
      switch x {
      case 0:
        ;
      case 1:
        x = 0
      }
      """,
      expecting:
        """
        1 │ switch x {
        2 │ case 0:
        3 │   ;
          │   ╰─ error: standalone ';' statements are not allowed
        4 │ case 1:
        5 │   x = 0

        """
    )
  }

  func testSwitch8() {
    assertParsedSource(
      """
      switch x {
        x = 1
      default:
        x = 0
      case 0:
        x = 0
      case 1:
        x = 0
      }
      """,
      expecting:
        """
        1 │ switch x {
        2 │   x = 1
          │   ╰─ error: all statements inside a switch must be covered by a 'case' or 'default' label
        3 │ default:
        4 │   x = 0

        """
    )
  }

  func testSwitch9() {
    assertParsedSource(
      """
      switch x {
        let x = 1
      case 1:
        x = 0
      }
      """,
      expecting:
        """
        1 │ switch x {
        2 │   let x = 1
          │   ╰─ error: all statements inside a switch must be covered by a 'case' or 'default' label
        3 │ case 1:
        4 │   x = 0

        """
    )
  }

  func testSwitch10() {
    assertParsedSource(
      """
      switch x {
        x = 1
      }
      """,
      expecting:
        """
        1 │ switch x {
        2 │   x = 1
          │   ╰─ error: all statements inside a switch must be covered by a 'case' or 'default' label
        3 │ }

        """
    )
  }

  func testSwitch11() {
    assertParsedSource(
      """
      switch x {
        x = 1
        x = 2
      }
      """,
      expecting:
        """
        1 │ switch x {
        2 │   x = 1
          │   ╰─ error: all statements inside a switch must be covered by a 'case' or 'default' label
        3 │   x = 2
        4 │ }

        """
    )
  }

  func testSwitch12() {
    assertParsedSource(
      """
      switch x {
      default where x == 0:
        x = 0
      }
      """,
      expecting:
        """
        1 │ switch x {
        2 │ default where x == 0:
          │         ╰─ error: 'default' cannot be used with a 'where' guard expression
        3 │   x = 0
        4 │ }

        """
    )
  }

  func testSwitch13() {
    assertParsedSource(
      """
      case 0:
      var y = 0
      default:
      var z = 1
      """,
      expecting:
        """
        1 │ case 0:
          │ ╰─ error: 'case' can only appear inside a 'switch' statement or 'enum' declaration
        2 │ var y = 0
        3 │ default:
          │ ╰─ error: 'default' label can only appear inside a 'switch' statement
        4 │ var z = 1

        """
    )
  }

  func testSwitch14() {
    assertParsedSource(
      """
      switch Whatever.Thing {
      @unknown default where x == 0:
        x = 0
      }
      """,
      expecting:
        """
        1 │ switch Whatever.Thing {
        2 │ @unknown default where x == 0:
          │                  ╰─ error: 'default' cannot be used with a 'where' guard expression
        3 │   x = 0
        4 │ }

        """
    )
  }

  func testSwitch15() {
    assertParsedSource(
      """
      switch Whatever.Thing {
      @unknown default where x == 0:
        break
      }
      """,
      expecting:
        """
        1 │ switch Whatever.Thing {
        2 │ @unknown default where x == 0:
          │                  ╰─ error: 'default' cannot be used with a 'where' guard expression
        3 │   break
        4 │ }

        """
    )
  }

  func testSwitch16() {
    assertParsedSource(
      """
      switch x {
      case 0:
        break
      @garbage @moreGarbage default:
        break
      }
      """,
      expecting:
        """
        2 │ case 0:
        3 │   break
        4 │ @garbage @moreGarbage default:
          │          ╰─ error: unexpected code '@moreGarbage' in switch case
        5 │   break
        6 │ }

        """
    )
  }

  func testSwitch17() {
    assertParsedSource(
      """
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown(garbage) case _:
        break
      }
      switch Whatever.Thing {
      case .Thing:
        break
      @unknown
      @unknown
      case _:
        break
      }
      switch Whatever.Thing {
      @unknown @garbage(foobar)
      case _:
        break
      }
      """,
      expecting:
        """
         2 │ case .Thing:
         3 │   break
         4 │ @unknown(garbage) case _:
           │         ╰─ error: unexpected code '(garbage)' in switch case
         5 │   break
         6 │ }
           ┆
         9 │   break
        10 │ @unknown
        11 │ @unknown
           │ ╰─ error: unexpected code '@unknown' in switch case
        12 │ case _:
        13 │   break
        14 │ }
        15 │ switch Whatever.Thing {
        16 │ @unknown @garbage(foobar)
           │          ╰─ error: unexpected code '@garbage(foobar)' in switch case
        17 │ case _:
        18 │   break

        """
    )
  }

  func testSwitch18() {
    assertParsedSource(
      """
      func testReturnBeforeIncompleteUnknownDefault() {
        switch x {
        case 1:
          return
        @unknown default
        }
      }
      """,
      expecting:
        """
        3 │   case 1:
        4 │     return
        5 │   @unknown default
          │                   ╰─ error: expected ':' in switch case
        6 │   }
        7 │ }

        """
    )
  }

  func testSwitch19() {
    assertParsedSource(
      """
      func testReturnBeforeIncompleteUnknownDefault1() {
        switch x {
        case 1:
          return
        @unknown
        }
      }
      """,
      expecting:
        """
        3 │   case 1:
        4 │     return
        5 │   @unknown
          │           ╰─ error: expected label in switch case
        6 │   }
        7 │ }

        """
    )
  }

  func testSwitch20() {
    assertParsedSource(
      """
      func testIncompleteArrayLiteral() {
        switch x {
        case 1:
          _ = [1
        @unknown default:
          ()
        }
      }
      """,
      expecting:
        """
        2 │   switch x {
        3 │   case 1:
        4 │     _ = [1
          │         │ ╰─ error: expected ']' to end array
          │         ╰─ note: to match this opening '['
        5 │   @unknown default:
        6 │     ()

        """
    )
  }
}
