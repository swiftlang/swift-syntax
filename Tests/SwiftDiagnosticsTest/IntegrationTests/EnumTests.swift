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

// This test file has been translated from swift/test/Parse/enum.swift

import XCTest

final class EnumTests: XCTestCase {
  func testEnum1() {
    assertParsedSource(
      """
      // Cases are excluded from non-enums.
      case FloatingCase
      """,
      expecting:
        """
        1 │ // Cases are excluded from non-enums.
        2 │ case FloatingCase
          │ ╰─ error: 'case' can only appear inside a 'switch' statement or 'enum' declaration

        """
    )
  }

  // Recover when a switch 'case' label is spelled inside an enum (or outside).
  func testEnum2() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case X:
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case X:
          │         ╰─ error: unexpected code ':' in enum
        3 │ }

        """
    )
  }

  func testEnum3() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case X(Y):
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case X(Y):
          │            ╰─ error: unexpected code ':' in enum
        3 │ }

        """
    )
  }

  func testEnum4() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case X, Y:
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case X, Y:
          │            ╰─ error: unexpected code ':' in enum
        3 │ }

        """
    )
  }

  func testEnum5() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case X where true:
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case X where true:
          │          ╰─ error: unexpected code 'where true:' in enum
        3 │ }

        """
    )
  }

  func testEnum6() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case X(Y), Z(W):
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case X(Y), Z(W):
          │                  ╰─ error: unexpected code ':' in enum
        3 │ }

        """
    )
  }

  func testEnum7() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case X(Y) where true:
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case X(Y) where true:
          │             ╰─ error: unexpected code 'where true:' in enum
        3 │ }

        """
    )
  }

  func testEnum8() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case 0:
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case 0:
          │        │╰─ error: unexpected code ':' in enum
          │        ╰─ error: identifier can only start with a letter or underscore, not a number
        3 │ }

        """
    )
  }

  func testEnum9() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case _:
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case _:
          │        │╰─ error: unexpected code ':' in enum
          │        ╰─ error: '_' cannot be used as an identifier here
        3 │ }

        """
    )
  }

  func testEnum10() {
    assertParsedSource(
      """
      enum SwitchEnvy {
        case (_, var x, 0):
      }
      """,
      expecting:
        """
        1 │ enum SwitchEnvy {
        2 │   case (_, var x, 0):
          │        │        │ │ ╰─ error: unexpected code ':' in enum
          │        │        │ ╰─ error: unexpected code '0' in parameter clause
          │        │        ╰─ error: expected ':' and type in parameter
          │        ╰─ error: expected identifier in enum case
        3 │ }

        """
    )
  }

  func testEnum11() {
    // We used to crash on this.  rdar://14678675
    assertParsedSource(
      """
      enum rdar14678675 {
        case U1,
        case U2
        case U3
      }
      """,
      expecting:
        """
        1 │ enum rdar14678675 {
        2 │   case U1,
          │           ╰─ error: expected identifier in enum case
        3 │   case U2
        4 │   case U3

        """
    )
  }

  func testEnum12() {
    assertParsedSource(
      """
      enum Recovery1 {
        case:
      }
      """,
      expecting:
        """
        1 │ enum Recovery1 {
        2 │   case:
          │       ├─ error: expected identifier in enum case
          │       ╰─ error: unexpected code ':' in enum
        3 │ }

        """
    )
  }

  func testEnum13() {
    assertParsedSource(
      """
      enum Recovery2 {
        case UE1:
      }
      """,
      expecting:
        """
        1 │ enum Recovery2 {
        2 │   case UE1:
          │           ╰─ error: unexpected code ':' in enum
        3 │ }

        """
    )
  }

  func testEnum14() {
    assertParsedSource(
      """
      enum Recovery3 {
        case UE2(Void):
      }
      """,
      expecting:
        """
        1 │ enum Recovery3 {
        2 │   case UE2(Void):
          │                 ╰─ error: unexpected code ':' in enum
        3 │ }

        """
    )
  }

  func testEnum15() {
    assertParsedSource(
      """
      enum Recovery4 {
        case Self Self
      }
      """,
      expecting:
        """
        1 │ enum Recovery4 {
        2 │   case Self Self
          │        │    ╰─ error: unexpected 'Self' keyword in enum
          │        ╰─ error: keyword 'Self' cannot be used as an identifier here
        3 │ }

        """
    )
  }

  func testEnum16() {
    assertParsedSource(
      """
      enum Recovery5 {
        case .UE3
        case .UE4, .UE5
      }
      """,
      expecting:
        """
        1 │ enum Recovery5 {
        2 │   case .UE3
          │        ╰─ error: unexpected code '.' in enum case
        3 │   case .UE4, .UE5
          │        │     ╰─ error: unexpected code '.' in enum case
          │        ╰─ error: unexpected code '.' in enum case
        4 │ }

        """
    )
  }

  func testEnum17() {
    assertParsedSource(
      """
      enum Recovery6 {
        case Snout, _;
        case _;
        case Tusk,
      }
      """,
      expecting:
        """
        1 │ enum Recovery6 {
        2 │   case Snout, _;
          │               ╰─ error: '_' cannot be used as an identifier here
        3 │   case _;
          │        ╰─ error: '_' cannot be used as an identifier here
        4 │   case Tusk,
          │             ╰─ error: expected identifier in enum case
        5 │ }

        """
    )
  }

  func testEnum18() {
    assertParsedSource(
      """
      enum switch {}
      """,
      expecting:
        """
        1 │ enum switch {}
          │      ╰─ error: keyword 'switch' cannot be used as an identifier here

        """
    )
  }

  func testEnum19() {
    assertParsedSource(
      """
      enum E_53662 {
        case identifier
        case operator
        case identifier2
      }
      """,
      expecting:
        """
        1 │ enum E_53662 {
        2 │   case identifier
        3 │   case operator
          │        ╰─ error: keyword 'operator' cannot be used as an identifier here
        4 │   case identifier2
        5 │ }

        """
    )
  }

  func testEnum20() {
    assertParsedSource(
      """
      enum E_53662_var {
        case identifier
        case var
        case identifier2
      }
      """,
      expecting:
        """
        1 │ enum E_53662_var {
        2 │   case identifier
        3 │   case var
          │        ╰─ error: keyword 'var' cannot be used as an identifier here
        4 │   case identifier2
        5 │ }

        """
    )
  }

  func testEnum21() {
    assertParsedSource(
      """
      enum E_53662_underscore {
        case identifier
        case _
        case identifier2
      }
      """,
      expecting:
        """
        1 │ enum E_53662_underscore {
        2 │   case identifier
        3 │   case _
          │        ╰─ error: '_' cannot be used as an identifier here
        4 │   case identifier2
        5 │ }

        """
    )
  }

  func testEnum22() {
    assertParsedSource(
      """
      enum E_53662_Comma {
        case a, b, c, func, d
      }
      """,
      expecting:
        """
        1 │ enum E_53662_Comma {
        2 │   case a, b, c, func, d
          │                 ╰─ error: keyword 'func' cannot be used as an identifier here
        3 │ }

        """
    )
  }

  func testEnum23() {
    assertParsedSource(
      """
      enum E_53662_Newline {
        case identifier1
        case identifier2
        case
        case identifier
      }
      """,
      expecting:
        """
        2 │   case identifier1
        3 │   case identifier2
        4 │   case
          │       ╰─ error: expected identifier in enum case
        5 │   case identifier
        6 │ }

        """
    )
  }

  func testEnum24() {
    assertParsedSource(
      """
      enum E_53662_Newline2 {
        case
        func foo() {}
      }
      """,
      expecting:
        """
        1 │ enum E_53662_Newline2 {
        2 │   case
          │       ╰─ error: expected identifier in enum case
        3 │   func foo() {}
        4 │ }

        """
    )
  }

  func testEnum25() {
    assertParsedSource(
      """
      enum E_53662_PatternMatching {
        case let .foo(x, y):
      }
      """,
      expecting:
        """
        1 │ enum E_53662_PatternMatching {
        2 │   case let .foo(x, y):
          │        │   ╰─ error: unexpected code '.foo(x, y):' in enum
          │        ╰─ error: keyword 'let' cannot be used as an identifier here
        3 │ }

        """
    )
  }

  func testEnum26() {
    assertParsedSource(
      #"""
      enum CasesWithMissingElement: Int {
        case a = "hello",
        case b = "hello",
      }
      """#,
      expecting:
        """
        1 │ enum CasesWithMissingElement: Int {
        2 │   case a = "hello",
          │                    ╰─ error: expected identifier in enum case
        3 │   case b = "hello",
          │                    ╰─ error: expected identifier in enum case
        4 │ }

        """
    )
  }
}
