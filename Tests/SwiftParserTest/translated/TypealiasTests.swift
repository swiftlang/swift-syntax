// This test file has been translated from swift/test/Parse/typealias.swift

import XCTest

final class TypealiasTests: XCTestCase {
  func testTypealias1() {
    AssertParse(
      """
      //===--- Simple positive tests.
      """
    )
  }

  func testTypealias2() {
    AssertParse(
      """
      typealias IntPair = (Int, Int)
      typealias IntTriple = (Int, Int, Int)
      typealias FiveInts = (IntPair, IntTriple)
      var fiveInts : FiveInts = ((4,2), (1,2,3))
      """
    )
  }

  func testTypealias3() {
    AssertParse(
      """
      // <rdar://problem/13339798> QoI: poor diagnostic in malformed typealias
      typealias Foo1 #^DIAG_1^#: Int  
      typealias Foo2#^DIAG_2^#: Int  
      typealias Foo3 #^DIAG_3^#:Int  
      typealias Foo4#^DIAG_4^#:/*comment*/Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 2: expected '=' in type alias declaration, Fix-It replacements: 16 - 17 = '='
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text ': Int' before typealias declaration"),
        // TODO: Old parser expected error on line 3: expected '=' in type alias declaration, Fix-It replacements: 15 - 16 = ' ='
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "unexpected text ': Int' before typealias declaration"),
        // TODO: Old parser expected error on line 4: expected '=' in type alias declaration, Fix-It replacements: 16 - 17 = '= '
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "unexpected text ':Int' before typealias declaration"),
        // TODO: Old parser expected error on line 5: expected '=' in type alias declaration, Fix-It replacements: 15 - 16 = ' = '
        DiagnosticSpec(locationMarker: "DIAG_4", message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(locationMarker: "DIAG_4", message: "extraneous ':/*comment*/Int' at top level"),
      ]
    )
  }

  func testTypealias4() {
    AssertParse(
      """
      //===--- Tests for error recovery.
      """
    )
  }

  func testTypealias5() {
    AssertParse(
      """
      typealias Recovery1#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '=' in type alias declaration
        DiagnosticSpec(message: "expected '=' and value in typealias declaration"),
      ]
    )
  }

  func testTypealias6() {
    AssertParse(
      """
      typealias Recovery2 #^DIAG^#:
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '=' in type alias declaration
        // TODO: Old parser expected error on line 1: expected type in type alias declaration
        DiagnosticSpec(message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(message: "extraneous ':' at top level"),
      ]
    )
  }

  func testTypealias7() {
    AssertParse(
      """
      typealias Recovery3 =#^DIAG^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected type in type alias declaration
        DiagnosticSpec(message: "expected value in typealias declaration"),
      ]
    )
  }

  func testTypealias8() {
    AssertParse(
      """
      typealias Recovery4 #^DIAG^#: Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '=' in type alias declaration
        DiagnosticSpec(message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(message: "extraneous ': Int' at top level"),
      ]
    )
  }

  func testTypealias9() {
    AssertParse(
      """
      typealias Recovery5 #^DIAG^#: Int, Float
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected '=' in type alias declaration
        // TODO: Old parser expected error on line 1: consecutive statements on a line must be separated by ';'
        // TODO: Old parser expected error on line 1: expected expression
        DiagnosticSpec(message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(message: "extraneous ': Int, Float' at top level"),
      ]
    )
  }

  func testTypealias10() {
    AssertParse(
      """
      typealias Recovery6 = #^DIAG^#=
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: expected type in type alias declaration
        DiagnosticSpec(message: "expected value in typealias declaration"),
        DiagnosticSpec(message: "extraneous '=' at top level"),
      ]
    )
  }

  func testTypealias11() {
    AssertParse(
      """
      typealias #^DIAG_1^#switch #^DIAG_2^#= Int
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 1: keyword 'switch' cannot be used as an identifier here
        // TODO: Old parser expected note on line 1: if this name is unavoidable, use backticks to escape it, Fix-It replacements: 11 - 17 = '`switch`'
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected identifier in typealias declaration"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected '=' and value in typealias declaration"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression and '{}' to end 'switch' statement"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "extraneous '= Int' at top level"),
      ]
    )
  }

}
