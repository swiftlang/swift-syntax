//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

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
      1️⃣<<<<<<< HEAD:conflict_markers.swift 
      var a : String = "A"
      var b : String = "b"
      =======2️⃣
      var a : String = "a"
      var b : String = "B"
      >>>>>>> 188443️⃣bc65229786b96b89a9fc7739c0fc897905e4️⃣:conflict_markers.swift
      print(a + b)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '<<<<<<< HEAD:conflict_markers.swift' before variable"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression in variable"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "'b' is not a valid digit in integer literal"),
        DiagnosticSpec(locationMarker: "4️⃣", message: "extraneous code at top level"),
      ]
    )
  }

  func testConflictMarkers8() {
    AssertParse(
      #"""
      1️⃣<<<<<<< HEAD:conflict_markers.swift 
      ======= 
      var d : String = "D"
      >>>>>>> 188442️⃣bc65229786b96b89a9fc7739c0fc897905e3️⃣:conflict_markers.swift
      print(d)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code before variable"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'b' is not a valid digit in integer literal"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous code at top level"),
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
      1️⃣<<<<<<< HEAD:conflict_markers.swift 
      <<<<<<<"HEAD:fake_conflict_markers.swift"
      var fake_b : String = "a"
      >>>>>>>"18844bc65229786b96b89a9fc7739c0fc897905e:fake_conflict_markers.swift"
      =======
      <<<<<<<"HEAD:fake_conflict_markers.swift"
      var fake_c : String = "a"
      >>>>>>>"18844bc65229786b96b89a9fc7739c0fc897905e:fake_conflict_markers.swift"
      >>>>>>> 188442️⃣bc65229786b96b89a9fc7739c0fc897905e3️⃣:conflict_markers.swift
      print(fake_b + fake_c)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code before variable"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "'b' is not a valid digit in integer literal"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous code at top level"),
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
      1️⃣>>>> ORIGINAL 
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
        DiagnosticSpec(message: "unexpected code '>>>> ORIGINAL' before variable")
      ]
    )
  }

  func testConflictMarkers15() {
    AssertParse(
      #"""
      1️⃣>>>> ORIGINAL 
      ==== THEIRS
      ==== YOURS
      var d : String = "D"
      <<<<
      print(d)
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: source control conflict marker in source file
        DiagnosticSpec(message: "unexpected code before variable")
      ]
    )
  }

}
