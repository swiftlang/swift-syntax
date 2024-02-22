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

final class ConflictMarkersTests: XCTestCase {
  func testConflictMarkers1() {
    assertParsedSource(
      #"""
      <<<<<<< HEAD:conflict_markers.swift
      var a : String = "A"
      var b : String = "b"
      =======
      var a : String = "a"
      var b : String = "B"
      >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      print(a + b)
      """#,
      expecting:
        #"""
        1 │ <<<<<<< HEAD:conflict_markers.swift
          │ ╰─ error: source control conflict marker in source file
        2 │ var a : String = "A"
        3 │ var b : String = "b"

        """#
    )
  }

  func testConflictMarkers2() {
    assertParsedSource(
      #"""
      <<<<<<< HEAD:conflict_markers.swift
      =======
      var d : String = "D"
      >>>>>>> 18844bc65229786b96b89a9fc7739c0fc897905e:conflict_markers.swift
      print(d)
      """#,
      expecting:
        #"""
        1 │ <<<<<<< HEAD:conflict_markers.swift
          │ ╰─ error: source control conflict marker in source file
        2 │ =======
        3 │ var d : String = "D"

        """#
    )
  }

  func testConflictMarkers3() {
    assertParsedSource(
      #"""
      <<<<<<< HEAD:conflict_markers.swift
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
      expecting:
        #"""
         1 │ <<<<<<< HEAD:conflict_markers.swift
           │ ╰─ error: source control conflict marker in source file
         2 │ <<<<<<<"HEAD:fake_conflict_markers.swift"
         3 │ var fake_b : String = "a"

        """#
    )
  }

  func testConflictMarkers4() {
    assertParsedSource(
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
      expecting:
        #"""
         3 │ let a = "a", b = "b"
         4 │ a
         5 │ <<<<<<< b
           │ ╰─ error: source control conflict marker in source file
         6 │ a
         7 │ >>>>>>> b

        """#
    )
  }

  func testConflictMarkers5() {
    assertParsedSource(
      #"""
      >>>> ORIGINAL
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
      expecting:
        #"""
         1 │ >>>> ORIGINAL
           │ ╰─ error: source control conflict marker in source file
         2 │ var a : String = "A"
         3 │ var b : String = "B"

        """#
    )
  }

  func testConflictMarkers6() {
    assertParsedSource(
      #"""
      >>>> ORIGINAL
      ==== THEIRS
      ==== YOURS
      var d : String = "D"
      <<<<
      print(d)
      """#,
      expecting:
        #"""
        1 │ >>>> ORIGINAL
          │ ╰─ error: source control conflict marker in source file
        2 │ ==== THEIRS
        3 │ ==== YOURS

        """#
    )
  }
}
