// This test file has been translated from swift/test/Parse/typealias.swift

import XCTest

final class TypealiasTests: XCTestCase {
  func testTypealias2a() {
    AssertParse(
      """
      typealias IntPair = (Int, Int)
      """
    )
  }

  func testTypealias2b() {
    AssertParse(
      """
      typealias IntTriple = (Int, Int, Int)
      """
    )
  }

  func testTypealias2c() {
    AssertParse(
      """
      typealias FiveInts = (IntPair, IntTriple)
      """
    )
  }

  func testTypealias2d() {
    AssertParse(
      """
      var fiveInts : FiveInts = ((4,2), (1,2,3))
      """
    )
  }

  // <rdar://problem/13339798> QoI: poor diagnostic in malformed typealias
  func testTypealias3a() {
    AssertParse(
      """
      typealias Foo1 1️⃣: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration"),
      ], fixedSource: "typealias Foo1 = Int"
    )
  }

  func testTypealias3b() {
    AssertParse(
      """
      typealias Foo21️⃣: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration"),
      ], fixedSource: "typealias Foo2= Int"
    )
  }

  func testTypealias3c() {
    AssertParse(
      """
      typealias Foo3 1️⃣:Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration"),
      ], fixedSource: "typealias Foo3 =Int"
    )
  }

  func testTypealias3d() {
    AssertParse(
      """
      typealias Foo41️⃣:/*comment*/Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration"),
      ], fixedSource: "typealias Foo4=/*comment*/Int"
    )
  }

  func testTypealias5() {
    AssertParse(
      """
      typealias Recovery11️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' and value in typealias declaration"),
      ]
    )
  }

  func testTypealias6() {
    AssertParse(
      """
      typealias Recovery2 1️⃣:2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '=' in typealias declaration", fixIts: ["replace ':' by '='"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected value in typealias declaration"),
      ]
    )
  }

  func testTypealias7() {
    AssertParse(
      """
      typealias Recovery3 =1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value in typealias declaration"),
      ]
    )
  }

  func testTypealias8() {
    AssertParse(
      """
      typealias Recovery4 1️⃣: Int
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '=' in typealias declaration", fixIts: ["replace ':' by '='"]),
      ]
    )
  }

  func testTypealias9() {
    AssertParse(
      """
      typealias Recovery5 1️⃣: Int2️⃣, Float
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '=' in typealias declaration", fixIts: ["replace ':' by '='"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous ', Float' at top level"),
      ]
    )
  }

  func testTypealias10() {
    AssertParse(
      """
      typealias Recovery6 = 1️⃣=
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value in typealias declaration"),
        DiagnosticSpec(message: "extraneous '=' at top level"),
      ]
    )
  }

  func testTypealias11() {
    AssertParse(
      """
      typealias1️⃣ 2️⃣switch 3️⃣= Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: keyword 'switch' cannot be used as an identifier here
        // TODO: Old parser expected note on line 1: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 11 - 17 = '`switch`'
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in typealias declaration"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected expression and '{}' to end 'switch' statement"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous '= Int' at top level"),
      ]
    )
  }

}
