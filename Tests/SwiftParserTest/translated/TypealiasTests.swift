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

final class TypealiasTests: ParserTestCase {
  func testTypealias2a() {
    assertParse(
      """
      typealias IntPair = (Int, Int)
      """
    )
  }

  func testTypealias2b() {
    assertParse(
      """
      typealias IntTriple = (Int, Int, Int)
      """
    )
  }

  func testTypealias2c() {
    assertParse(
      """
      typealias FiveInts = (IntPair, IntTriple)
      """
    )
  }

  func testTypealias2d() {
    assertParse(
      """
      var fiveInts : FiveInts = ((4,2), (1,2,3))
      """
    )
  }

  // <rdar://problem/13339798> QoI: poor diagnostic in malformed typealias
  func testTypealias3a() {
    assertParse(
      """
      typealias Foo1 1️⃣: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration", fixIts: ["replace ':' with '='"])
      ],
      fixedSource: "typealias Foo1 = Int"
    )
  }

  func testTypealias3b() {
    assertParse(
      """
      typealias Foo21️⃣: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration", fixIts: ["replace ':' with '='"])
      ],
      fixedSource: "typealias Foo2 = Int"
    )
  }

  func testTypealias3c() {
    assertParse(
      """
      typealias Foo3 1️⃣:Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration", fixIts: ["replace ':' with '='"])
      ],
      fixedSource: "typealias Foo3 = Int"
    )
  }

  func testTypealias3d() {
    assertParse(
      """
      typealias Foo41️⃣:/*comment*/Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration", fixIts: ["replace ':' with '='"])
      ],
      fixedSource: "typealias Foo4 =/*comment*/Int"
    )
  }

  func testTypealias5() {
    assertParse(
      """
      typealias Recovery11️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' and type in typealias declaration", fixIts: ["insert '=' and type"])
      ],
      fixedSource: """
        typealias Recovery1 = <#type#>
        """
    )
  }

  func testTypealias6() {
    assertParse(
      """
      typealias Recovery2 1️⃣:2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '=' in typealias declaration",
          fixIts: ["replace ':' with '='"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected type in typealias declaration", fixIts: ["insert type"]),
      ],
      fixedSource: """
        typealias Recovery2 = <#type#>
        """
    )
  }

  func testTypealias7() {
    assertParse(
      """
      typealias Recovery3 =1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in typealias declaration", fixIts: ["insert type"])
      ],
      fixedSource: """
        typealias Recovery3 = <#type#>
        """
    )
  }

  func testTypealias8() {
    assertParse(
      """
      typealias Recovery4 1️⃣: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration", fixIts: ["replace ':' with '='"])
      ],
      fixedSource: """
        typealias Recovery4 = Int
        """
    )
  }

  func testTypealias9() {
    assertParse(
      """
      typealias Recovery5 1️⃣: Int2️⃣, Float
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected '=' in typealias declaration",
          fixIts: ["replace ':' with '='"]
        ),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code ', Float' at top level"),
      ],
      fixedSource: """
        typealias Recovery5 = Int, Float
        """
    )
  }

  func testTypealias10() {
    assertParse(
      """
      typealias Recovery6 = 1️⃣=
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type in typealias declaration", fixIts: ["insert type"]),
        DiagnosticSpec(message: "extraneous code '=' at top level"),
      ],
      fixedSource: """
        typealias Recovery6 = <#type#>=
        """
    )
  }

  func testTypealias11() {
    assertParse(
      """
      typealias 1️⃣switch = Int
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "keyword 'switch' cannot be used as an identifier here",
          fixIts: ["if this name is unavoidable, use backticks to escape it"]
        )
      ],
      fixedSource: "typealias `switch` = Int"
    )
  }

}
