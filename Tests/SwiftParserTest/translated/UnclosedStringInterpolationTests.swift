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

// This test file has been translated from swift/test/Parse/unclosed-string-interpolation.swift

import XCTest

final class UnclosedStringInterpolationTests: XCTestCase {
  func testUnclosedStringInterpolation1() {
    AssertParse(
      #"""
      let mid = "pete"
      """#
    )
  }

  func testUnclosedStringInterpolation2() {
    AssertParse(
      ##"""
      _ = 1️⃣"mid == \(pete"
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: #"extraneous code '"mid == \(pete"' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation3() {
    AssertParse(
      ##"""
      let theGoat = 1️⃣"kanye \("
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous code '"kanye \("' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation4() {
    AssertParse(
      ##"""
      let equation1 = 1️⃣"2 + 2 = \(2 + 2"
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous code '"2 + 2 = \(2 + 2"' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation5() {
    AssertParse(
      ##"""
      let s = 1️⃣"\(x"; print(x)
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous code '"\(x"; print(x)' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation6() {
    AssertParse(
      ##"""
      let zzz = 1️⃣"\(x; print(x)
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous code '"\(x; print(x)' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation7() {
    AssertParse(
      ##"""
      let goatedAlbum = 1️⃣"The Life Of \("Pablo"
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: #"extraneous code '"The Life Of \("Pablo"' at top level"#),
      ]
    )
  }

  func testUnclosedStringInterpolation8() {
    AssertParse(
      ##"""
      _ = 1️⃣"""
      \(
      """
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 2: cannot find ')' to match opening '(' in string interpolation
      ]
    )
  }

}
