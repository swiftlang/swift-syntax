// This test file has been translated from swift/test/Parse/foreach.swift

import XCTest

final class ForeachTests: XCTestCase {
  func testForeach1() {
    AssertParse(
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
    AssertParse(
      """
      func for_each(r: Range<Int>, iir: IntRange<Int>) { 
        var sum = 0
        // Simple foreach loop, using the variable in the body
        for i in r {
          sum = sum + i
        }
        // Check scoping of variable introduced with foreach loop
        i = 0 
        // For-each loops with two variables and varying degrees of typedness
        for (i, j) in iir {
          sum = sum + i + j
        }
        for (i, j) in iir {
          sum = sum + i + j
        }
        for (i, j) : (Int, Int) in iir {
          sum = sum + i + j
        }
        // Parse errors
        // FIXME: Bad diagnostics; should be just 'expected 'in' after for-each patter'.
        for i 1️⃣r { 
        }         
        for i in r 2️⃣sum = sum + i;3️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'in' in 'for' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '{' in 'for' statement"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected '}' to end 'for' statement"),
      ]
    )
  }

}
