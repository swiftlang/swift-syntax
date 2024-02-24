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

// This test file has been translated from swift/test/Parse/diagnose_initializer_as_typed_pattern.swift

import XCTest

// https://github.com/apple/swift/issues/44070
final class DiagnoseInitializerAsTypedPatternTests: XCTestCase {
  func testDiagnoseInitializerAsTypedPattern1() {
    assertParsedSource(
      """
      let a:[X]()
      """,
      expecting:
        """
        1 │ let a:[X]()
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern2() {
    assertParsedSource(
      """
      let b: [X]()
      """,
      expecting:
        """
        1 │ let b: [X]()
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern3() {
    assertParsedSource(
      """
      let c :[X]()
      """,
      expecting:
        """
        1 │ let c :[X]()
          │       ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern4() {
    assertParsedSource(
      """
      let d : [X]()
      """,
      expecting:
        """
        1 │ let d : [X]()
          │       ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern5() {
    assertParsedSource(
      """
      let e: X(), ee: Int
      """,
      expecting:
        """
        1 │ let e: X(), ee: Int
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern6() {
    assertParsedSource(
      """
      let f:/*comment*/[X]()
      """,
      expecting:
        """
        1 │ let f:/*comment*/[X]()
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern7() {
    assertParsedSource(
      """
      let f/*comment*/:[X]()
      """,
      expecting:
        """
        1 │ let f/*comment*/:[X]()
          │                 ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern8() {
    assertParsedSource(
      """
      let g: X(x)
      """,
      expecting:
        """
        1 │ let g: X(x)
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern9() {
    assertParsedSource(
      """
      let h: X(x, y)
      """,
      expecting:
        """
        1 │ let h: X(x, y)
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern10() {
    assertParsedSource(
      """
      let i: X() { foo() }
      """,
      expecting:
        """
        1 │ let i: X() { foo() }
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern11() {
    assertParsedSource(
      """
      let j: X(x) { foo() }
      """,
      expecting:
        """
        1 │ let j: X(x) { foo() }
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern12() {
    assertParsedSource(
      """
      let k: X(x, y) { foo() }
      """,
      expecting:
        """
        1 │ let k: X(x, y) { foo() }
          │      ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern13() {
    assertParsedSource(
      """
      func nonTopLevel() {
        let a:[X]()
      }
      """,
      expecting:
        """
        1 │ func nonTopLevel() {
        2 │   let a:[X]()
          │        ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?
        3 │ }

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern14() {
    assertParsedSource(
      """
      func nonTopLevel() {
        let i: X() { foo() }
      }
      """,
      expecting:
        """
        1 │ func nonTopLevel() {
        2 │   let i: X() { foo() }
          │        ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?
        3 │ }

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern15() {
    assertParsedSource(
      """
      func nonTopLevel() {
        let j: X(x) { foo() }
      }
      """,
      expecting:
        """
        1 │ func nonTopLevel() {
        2 │   let j: X(x) { foo() }
          │        ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?
        3 │ }

        """
    )
  }

  func testDiagnoseInitializerAsTypedPattern16() {
    assertParsedSource(
      """
      func nonTopLevel() {
        let k: X(x, y) { foo() }
      }
      """,
      expecting:
        """
        1 │ func nonTopLevel() {
        2 │   let k: X(x, y) { foo() }
          │        ╰─ rorre: unexpected initializer in pattern; did you mean to use '='?
        3 │ }

        """
    )
  }
}
