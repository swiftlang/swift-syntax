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
        for i #^DIAG_1^#r { 
        }         
        for i in r #^DIAG_2^#sum = sum + i; 
      }#^DIAG_3^#
      """,
      diagnostics: [
        // TODO: Old parser expected error on line 21: found an unexpected second identifier in constant declaration
        // TODO: Old parser expected note on line 21: join the identifiers together
        // TODO: Old parser expected note on line 21: join the identifiers together with camel-case
        // TODO: Old parser expected error on line 21: expected 'in' after for-each pattern
        // TODO: Old parser expected error on line 21: expected Sequence expression for for-each loop
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected 'in' in 'for' statement"),
        // TODO: Old parser expected error on line 23: expected '{' to start the body of for-each loop
        DiagnosticSpec(locationMarker: "DIAG_2", message: "expected '{' in 'for' statement"),
        DiagnosticSpec(locationMarker: "DIAG_3", message: "expected '}' to end function"),
      ]
    )
  }

}
