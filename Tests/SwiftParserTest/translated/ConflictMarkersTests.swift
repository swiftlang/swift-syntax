// This test file has been translated from swift/test/Parse/conflict_markers.swift

import XCTest

final class ConflictMarkersTests: XCTestCase {
  func testConflictMarkers1() {
    AssertParse(
      """
      // Conflict marker parsing should never conflict with operator parsing.
      """
    )
  }

  func testConflictMarkers2() {
    AssertParse(
      """
      prefix operator <<<<<<<
      infix operator <<<<<<<
      """
    )
  }

  func testConflictMarkers3() {
    AssertParse(
      """
      prefix func <<<<<<< (x : String) {}
      func <<<<<<< (x : String, y : String) {}
      """
    )
  }

  func testConflictMarkers4() {
    AssertParse(
      """
      prefix operator >>>>>>>
      infix operator >>>>>>>
      """
    )
  }

  func testConflictMarkers5() {
    AssertParse(
      """
      prefix func >>>>>>> (x : String) {}
      func >>>>>>> (x : String, y : String) {}
      """
    )
  }

  func testConflictMarkers6() {
    AssertParse(
      """
      // diff3-style conflict markers
      """
    )
  }

  func testConflictMarkers7() {
    AssertParse(
      #"""
      #^DIAG_1^#<<<<<<< HEAD:conflict_markers.swift 
      var a : String = "A"
      var b : String = "b"
      =======#^DIAG_2^#
      var a : String = "a"
      var b : String = "B"
      >>>>>>> #^DIAG_3^#18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      print(a + b)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '<<<<<<< HEAD:conflict_markers.swift' before variable"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "extraneous code at top level"),
      ]
    )
  }

  func testConflictMarkers8() {
    AssertParse(
      #"""
      #^DIAG_1^#<<<<<<< HEAD:conflict_markers.swift 
      ======= 
      var d : String = "D"
      >>>>>>> #^DIAG_2^#18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      print(d)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text before variable"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "extraneous code at top level"),
      ]
    )
  }

  func testConflictMarkers9() {
    AssertParse(
      #"""
      <<<<<<<"HEAD:fake_conflict_markers.swift" // No error
      >>>>>>>"18844bc65229786b96b89a9fc7739c0fc897905e:fake_conflict_markers.swift" // No error
      """#
    )
  }

  func testConflictMarkers10() {
    AssertParse(
      #"""
      #^DIAG_1^#<<<<<<< HEAD:conflict_markers.swift 
      <<<<<<<"HEAD:fake_conflict_markers.swift"
      var fake_b : String = "a"
      >>>>>>>"18844bc65229786b96b89a9fc7739c0fc897905e:fake_conflict_markers.swift"
      =======
      <<<<<<<"HEAD:fake_conflict_markers.swift"
      var fake_c : String = "a"
      >>>>>>>"18844bc65229786b96b89a9fc7739c0fc897905e:fake_conflict_markers.swift"
      >>>>>>> #^DIAG_2^#18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      print(fake_b + fake_c)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text before variable"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected expression"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "extraneous code at top level"),
      ]
    )
  }

  func testConflictMarkers11() {
    AssertParse(
      """
      // Disambiguating conflict markers from operator applications.
      """
    )
  }

  func testConflictMarkers12() {
    AssertParse(
      #"""
      _ = {
      // Conflict marker.
      let a = "a", b = "b"
      a 
      <<<<<<< b 
      a
      >>>>>>> b
      // Not a conflict marker.
      a
        <<<<<<< b
      a
        >>>>>>> b
      }()
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 5: source control conflict marker in source file
      ]
    )
  }

  func testConflictMarkers13() {
    AssertParse(
      """
      // Perforce-style conflict markers
      """
    )
  }

  func testConflictMarkers14() {
    AssertParse(
      #"""
      #^DIAG^#>>>> ORIGINAL 
      var a : String = "A"
      var b : String = "B"
      ==== THEIRS
      var a : String = "A"
      var b : String = "b"
      ==== YOURS
      var a : String = "a"
      var b : String = "B"
      <<<<
      print(a + b)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(message: "unexpected text '>>>> ORIGINAL' before variable"),
      ]
    )
  }

  func testConflictMarkers15() {
    AssertParse(
      #"""
      #^DIAG^#>>>> ORIGINAL 
      ==== THEIRS
      ==== YOURS
      var d : String = "D"
      <<<<
      print(d)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(message: "unexpected text before variable"),
      ]
    )
  }

}
