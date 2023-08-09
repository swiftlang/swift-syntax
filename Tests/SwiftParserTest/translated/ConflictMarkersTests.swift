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

// This test file has been translated from swift/test/Parse/conflict_markers.swift

import XCTest

final class ConflictMarkersTests: ParserTestCase {
  func testConflictMarkers1() {
    assertParse(
      """
      // Conflict marker parsing should never conflict with operator parsing.
      """
    )
  }

  func testConflictMarkers2() {
    assertParse(
      """
      prefix operator <<<<<<<
      infix operator <<<<<<<
      """
    )
  }

  func testConflictMarkers3() {
    assertParse(
      """
      prefix func <<<<<<< (x : String) {}
      func <<<<<<< (x : String, y : String) {}
      """
    )
  }

  func testConflictMarkers4() {
    assertParse(
      """
      prefix operator >>>>>>>
      infix operator >>>>>>>
      """
    )
  }

  func testConflictMarkers5() {
    assertParse(
      """
      prefix func >>>>>>> (x : String) {}
      func >>>>>>> (x : String, y : String) {}
      """
    )
  }

  func testConflictMarkers6() {
    assertParse(
      """
      // diff3-style conflict markers
      """
    )
  }

  func testConflictMarkers7() {
    assertParse(
      #"""
      1️⃣<<<<<<< HEAD:conflict_markers.swift
      var a : String = "A"
      var b : String = "b"
      =======
      var a : String = "a"
      var b : String = "B"
      >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      print(a + b)
      """#,
      diagnostics: [
        DiagnosticSpec(message: "source control conflict marker in source file")
      ]
    )
  }

  func testConflictMarkers8() {
    assertParse(
      #"""
      1️⃣<<<<<<< HEAD:conflict_markers.swift
      =======
      var d : String = "D"
      >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      print(d)
      """#,
      diagnostics: [
        DiagnosticSpec(message: "source control conflict marker in source file")
      ]
    )
  }

  func testConflictMarkers9() {
    assertParse(
      #"""
      <<<<<<<"HEAD:fake_conflict_markers.swift" // No error
      >>>>>>>"18844bc65229786b96b89a9fc7739c0fc897905e:fake_conflict_markers.swift" // No error
      """#
    )
  }

  func testConflictMarkers10() {
    assertParse(
      #"""
      1️⃣<<<<<<< HEAD:conflict_markers.swift
      <<<<<<<"HEAD:fake_conflict_markers.swift"
      var fake_b : String = "a"
      >>>>>>>"18844bc65229786b96b89a9fc7739c0fc897905e:fake_conflict_markers.swift"
      =======
      <<<<<<<"HEAD:fake_conflict_markers.swift"
      var fake_c : String = "a"
      >>>>>>>"18844bc65229786b96b89a9fc7739c0fc897905e:fake_conflict_markers.swift"
      >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      print(fake_b + fake_c)
      """#,
      diagnostics: [
        DiagnosticSpec(message: "source control conflict marker in source file")
      ]
    )
  }

  func testConflictMarkers11() {
    assertParse(
      """
      // Disambiguating conflict markers from operator applications.
      """
    )
  }

  func testConflictMarkers12() {
    assertParse(
      #"""
      _ = {
      // Conflict marker.
      let a = "a", b = "b"
      a
      1️⃣<<<<<<< b
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
        DiagnosticSpec(message: "source control conflict marker in source file")
      ]
    )
  }

  func testConflictMarkers13() {
    assertParse(
      """
      // Perforce-style conflict markers
      """
    )
  }

  func testConflictMarkers14() {
    assertParse(
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
        DiagnosticSpec(message: "source control conflict marker in source file")
      ]
    )
  }

  func testConflictMarkers15() {
    assertParse(
      #"""
      1️⃣>>>> ORIGINAL
      ==== THEIRS
      ==== YOURS
      var d : String = "D"
      <<<<
      print(d)
      """#,
      diagnostics: [
        DiagnosticSpec(message: "source control conflict marker in source file")
      ]
    )
  }

}
