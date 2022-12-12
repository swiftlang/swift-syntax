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


import XCTest

final class VariadicGenericsTests: XCTestCase {
  func testSimple() {
    AssertParse(
      """
      func tuplify<T...>(_ t: (each T)...) -> ((each T)...) {
      }
      """
    )
  }

  func testRequirement() {
    AssertParse(
      """
      func requirement<T...>() where each T: P {
      }
      """
    )
  }

  func testElementOutsideExpansion() {
    // This is valid to parse, and becomes invalid during type resolution.
    AssertParse(
      """
      func invalid<T...>(_ t: each T) -> each T {}
      """
    )
  }

  func testInvalidPackElement() {
    AssertParse(
      """
      func invalid<T...>() -> (each any 1️⃣T) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      func invalid<T...>(_: each T 1️⃣& P) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '& P' in parameter clause")
      ]
    )
  }
}
