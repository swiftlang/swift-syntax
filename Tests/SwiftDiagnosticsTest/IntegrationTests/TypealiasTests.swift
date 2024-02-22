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

// This test file has been translated from swift/test/Parse/typealias.swift

import XCTest

final class TypealiasTests: XCTestCase {
  // <rdar://problem/13339798> QoI: poor diagnostic in malformed typealias
  func testTypealias1() {
    assertParsedSource(
      """
      typealias Foo1 : Int
      """,
      expecting:
        """
        1 │ typealias Foo1 : Int
          │                ╰─ error: expected '=' in typealias declaration

        """
    )
  }

  func testTypealias2() {
    assertParsedSource(
      """
      typealias Foo2: Int
      """,
      expecting:
        """
        1 │ typealias Foo2: Int
          │               ╰─ error: expected '=' in typealias declaration

        """
    )
  }

  func testTypealias3() {
    assertParsedSource(
      """
      typealias Foo3 :Int
      """,
      expecting:
        """
        1 │ typealias Foo3 :Int
          │                ╰─ error: expected '=' in typealias declaration

        """
    )
  }

  func testTypealias4() {
    assertParsedSource(
      """
      typealias Foo4:/*comment*/Int
      """,
      expecting:
        """
        1 │ typealias Foo4:/*comment*/Int
          │               ╰─ error: expected '=' in typealias declaration

        """
    )
  }

  func testTypealias5() {
    assertParsedSource(
      """
      typealias Recovery1
      """,
      expecting:
        """
        1 │ typealias Recovery1
          │                    ╰─ error: expected '=' and type in typealias declaration

        """
    )
  }

  func testTypealias6() {
    assertParsedSource(
      """
      typealias Recovery2 :
      """,
      expecting:
        """
        1 │ typealias Recovery2 :
          │                     │╰─ error: expected type in typealias declaration
          │                     ╰─ error: expected '=' in typealias declaration

        """
    )
  }

  func testTypealias7() {
    assertParsedSource(
      """
      typealias Recovery3 =
      """,
      expecting:
        """
        1 │ typealias Recovery3 =
          │                      ╰─ error: expected type in typealias declaration

        """
    )
  }

  func testTypealias8() {
    assertParsedSource(
      """
      typealias Recovery4 : Int
      """,
      expecting:
        """
        1 │ typealias Recovery4 : Int
          │                     ╰─ error: expected '=' in typealias declaration

        """
    )
  }

  func testTypealias9() {
    assertParsedSource(
      """
      typealias Recovery5 : Int, Float
      """,
      expecting:
        """
        1 │ typealias Recovery5 : Int, Float
          │                     │    ╰─ error: extraneous code ', Float' at top level
          │                     ╰─ error: expected '=' in typealias declaration

        """
    )
  }

  func testTypealias10() {
    assertParsedSource(
      """
      typealias Recovery6 = =
      """,
      expecting:
        """
        1 │ typealias Recovery6 = =
          │                       ├─ error: expected type in typealias declaration
          │                       ╰─ error: extraneous code '=' at top level

        """
    )
  }

  func testTypealias11() {
    assertParsedSource(
      """
      typealias switch = Int
      """,
      expecting:
        """
        1 │ typealias switch = Int
          │           ╰─ error: keyword 'switch' cannot be used as an identifier here

        """
    )
  }
}
