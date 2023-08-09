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

// This test file has been translated from swift/test/Parse/foreach.swift

import XCTest

final class ForeachTests: ParserTestCase {
  func testForeach1() {
    assertParse(
      """
      struct IntRange<Int> : Sequence, IteratorProtocol {
        typealias Element = (Int, Int)
        func next() -> (Int, Int)? {}
        typealias Iterator = IntRange<Int>
        func makeIterator() -> IntRange<Int> { return self }
      }
      """
    )
  }

  func testForeach2() {
    // Simple foreach loop, using the variable in the body
    assertParse(
      """
      func for_each(r: Range<Int>, iir: IntRange<Int>) {
        var sum = 0
        for i in r {
          sum = sum + i
        }
      }
      """
    )

    // Check scoping of variable introduced with foreach loop
    // For-each loops with two variables and varying degrees of typedness
    assertParse(
      """
      func for_each(r: Range<Int>, iir: IntRange<Int>) {
        var sum = 0
        for (i, j) in iir {
          sum = sum + i + j
        }
      }
      """
    )

    assertParse(
      """
      func for_each(r: Range<Int>, iir: IntRange<Int>) {
        var sum = 0
        for (i, j) : (Int, Int) in iir {
          sum = sum + i + j
        }
      }
      """
    )
  }

  // Parse errors
  func testForeach3() {
    assertParse(
      """
      func for_each(r: Range<Int>, iir: IntRange<Int>) {
        var sum = 0
        for i 1️⃣r {
        }
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected 'in' in 'for' statement", fixIts: ["insert 'in'"])
      ],
      fixedSource: """
        func for_each(r: Range<Int>, iir: IntRange<Int>) {
          var sum = 0
          for i in r {
          }
        }
        """
    )

    assertParse(
      """
      func for_each(r: Range<Int>, iir: IntRange<Int>) {
        var sum = 0
        for i in r 1️⃣sum = sum + i;2️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '{' in 'for' statement", fixIts: ["insert '{'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end 'for' statement", fixIts: ["insert '}'"]),
      ],
      fixedSource: """
        func for_each(r: Range<Int>, iir: IntRange<Int>) {
          var sum = 0
          for i in r { sum = sum + i;
        }
        }
        """
    )
  }
}
