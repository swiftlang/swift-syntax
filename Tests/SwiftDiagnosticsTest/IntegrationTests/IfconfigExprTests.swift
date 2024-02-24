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

// This test file has been translated from swift/test/Parse/ifConfig_expr.swift

import XCTest

final class IfConfigExprTests: XCTestCase {
  func testIfConfigExpr1() {
    assertParsedSource(
      #"""
      func testInvalidContent(baseExpr: MyStruct, otherExpr: Int) {
        baseExpr
      #if CONDITION_1
          { $0 + 1  }
      #endif
        baseExpr
      #if CONDITION_1
          + otherExpr
      #endif
        baseExpr
      #if CONDITION_1
          .methodOne()
        print("debug")
      #endif
      }
      """#,
      expecting:
        #"""
         6 │   baseExpr
         7 │ #if CONDITION_1
         8 │     + otherExpr
           │     ╰─ rorre: unexpected code '+ otherExpr' in conditional compilation block
         9 │ #endif
        10 │   baseExpr
        11 │ #if CONDITION_1
        12 │     .methodOne()
        13 │   print("debug")
           │   ╰─ rorre: unexpected code 'print("debug")' in conditional compilation block
        14 │ #endif
        15 │ }

        """#
    )
  }

  func testIfConfigExpr2() {
    assertParsedSource(
      """
      func testExprKind(baseExpr: MyStruct, idx: Int) {
        baseExpr
      #if CONDITION_1
        .optionalMember?.optionalMethod()![idx]++
      #else
        .otherMethod(arg) {
          //...
        }
      #endif
        baseExpr
      #if CONDITION_1
        .methodOne() + 12
      #endif
      }
      """,
      expecting:
        """
        10 │   baseExpr
        11 │ #if CONDITION_1
        12 │   .methodOne() + 12
           │                ╰─ rorre: unexpected code '+ 12' in conditional compilation block
        13 │ #endif
        14 │ }

        """
    )
  }

  func testIfConfigExpr3() {
    assertParsedSource(
      """
      func emptyElse(baseExpr: MyStruct) {
        baseExpr
      #if CONDITION_1
          .methodOne()
      #elseif CONDITION_2
          // OK. Do nothing.
      #endif
        baseExpr
      #if CONDITION_1
          .methodOne()
      #elseif CONDITION_2
        return
      #endif
      }
      """,
      expecting:
        """
        10 │     .methodOne()
        11 │ #elseif CONDITION_2
        12 │   return
           │   ╰─ rorre: unexpected 'return' keyword in conditional compilation block
        13 │ #endif
        14 │ }

        """
    )
  }

  func testIfConfigExpr4() {
    assertParsedSource(
      """
      #if canImport(A, _version: 2.2.2.2.2)
        let a = 1
      #endif
      """,
      expecting:
        """
        1 │ #if canImport(A, _version: 2.2.2.2.2)
          │                                   ╰─ gninraw: trailing components of version 2.2.2.2 are ignored
        2 │   let a = 1
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr5() {
    assertParsedSource(
      """
      #if canImport(A, unknown: 2.2)
        let a = 1
      #endif
      """,
      expecting:
        """
        1 │ #if canImport(A, unknown: 2.2)
          │                  ╰─ rorre: 2nd parameter of canImport should be labeled as _version or _underlyingVersion
        2 │   let a = 1
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr6() {
    assertParsedSource(
      """
      #if canImport(A,)
        let a = 1
      #endif
      """,
      expecting:
        """
        1 │ #if canImport(A,)
          │                 ╰─ rorre: 2nd parameter of canImport should be labeled as _version or _underlyingVersion
        2 │   let a = 1
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr7() {
    assertParsedSource(
      """
      #if canImport(A, 2.2)
        let a = 1
      #endif
      """,
      expecting:
        """
        1 │ #if canImport(A, 2.2)
          │                  ╰─ rorre: 2nd parameter of canImport should be labeled as _version or _underlyingVersion
        2 │   let a = 1
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr8() {
    assertParsedSource(
      """
      #if canImport(A, 2.2, 1.1)
        let a = 1
      #endif
      """,
      expecting:
        """
        1 │ #if canImport(A, 2.2, 1.1)
          │                  │  ╰─ rorre: canImport can take only two parameters
          │                  ╰─ rorre: 2nd parameter of canImport should be labeled as _version or _underlyingVersion
        2 │   let a = 1
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr9() {
    assertParsedSource(
      """
      #if canImport(A, _version:)
        let a = 1
      #endif
      """,
      expecting:
        """
        1 │ #if canImport(A, _version:)
          │                           ╰─ rorre: expected version tuple in 'canImport' expression
        2 │   let a = 1
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr10() {
    assertParsedSource(
      #"""
      #if canImport(A, _version: "")
        let a = 1
      #endif
      """#,
      expecting:
        #"""
        1 │ #if canImport(A, _version: "")
          │                            ╰─ rorre: cannot parse version component code '""'
        2 │   let a = 1
        3 │ #endif

        """#
    )
  }

  func testIfConfigExpr11() {
    assertParsedSource(
      """
      #if canImport(A, _version: >=2.2)
        let a = 1
      #endif
      """,
      expecting:
        """
        1 │ #if canImport(A, _version: >=2.2)
          │                            ╰─ rorre: cannot parse version component code '>=2.2'
        2 │   let a = 1
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr12() {
    assertParsedSource(
      """
      #if canImport(A, _version: 20A301)
        let a = 1
      #endif
      """,
      expecting:
        """
        1 │ #if canImport(A, _version: 20A301)
          │                            ╰─ rorre: cannot parse version component code '20A301'
        2 │   let a = 1
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr13() {
    assertParsedSource(
      #"""
      #if canImport(A, _version: "20A301")
        let a = 1
      #endif
      """#,
      expecting:
        #"""
        1 │ #if canImport(A, _version: "20A301")
          │                            ╰─ rorre: cannot parse version component code '"20A301"'
        2 │   let a = 1
        3 │ #endif

        """#
    )
  }

  func testIfConfigExpr14() {
    assertParsedSource(
      """
      #if arch(x86_64)
        debugPrint("x86_64")
      #else if arch(arm64)
        debugPrint("arm64")
      #else
        debugPrint("Some other architecture.")
      #endif
      """,
      expecting:
        """
        1 │ #if arch(x86_64)
        2 │   debugPrint("x86_64")
        3 │ #else if arch(arm64)
          │ ╰─ rorre: unexpected 'if' keyword following '#else' conditional compilation directive; did you mean '#elseif'?
        4 │   debugPrint("arm64")
        5 │ #else

        """
    )
  }

  func testIfConfigExpr15() {
    assertParsedSource(
      """
      #if arch(x86_64)
        debugPrint("x86_64")
      #elif arch(arm64)
        debugPrint("arm64")
      #else
        debugPrint("Some other architecture.")
      #endif
      """,
      expecting:
        """
        1 │ #if arch(x86_64)
        2 │   debugPrint("x86_64")
        3 │ #elif arch(arm64)
          │ ╰─ rorre: use of unknown directive '#elif'
        4 │   debugPrint("arm64")
        5 │ #else

        """
    )
  }

  func testIfConfigExpr16() {
    assertParsedSource(
      """
      #if MY_FLAG
      #
      elif
      #endif
      """,
      expecting:
        """
        1 │ #if MY_FLAG
        2 │ #
          │  ╰─ rorre: expected identifier in macro expansion
        3 │ elif
        4 │ #endif

        """
    )
  }

  func testIfConfigExpr17() {
    assertParsedSource(
      """
      #if MY_FLAG
      # elif
      #endif
      """,
      expecting:
        """
        1 │ #if MY_FLAG
        2 │ # elif
          │  ╰─ rorre: extraneous whitespace after '#' is not permitted
        3 │ #endif

        """
    )
  }

  func testIfConfigExpr18() {
    assertParsedSource(
      """
      switch x {
        #()
      #if true
        bar()
      #endif
        case .A, .B:
          break
      }
      """,
      expecting:
        """
        1 │ switch x {
        2 │   #()
          │   ╰─ rorre: unexpected code '#()' before conditional compilation clause
        3 │ #if true
        4 │   bar()
          │   ╰─ rorre: all statements inside a switch must be covered by a 'case' or 'default' label
        5 │ #endif
        6 │   case .A, .B:

        """
    )
  }
}
