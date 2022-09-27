// This test file has been translated from swift/test/Parse/foreach_async.swift

import XCTest

final class ForeachAsyncTests: XCTestCase {
  func testForeachAsync1() {
    AssertParse(
      """
      import _Concurrency
      """
    )
  }

  func testForeachAsync2() {
    AssertParse(
      """
      struct AsyncRange<Bound: Comparable & Strideable>: AsyncSequence, AsyncIteratorProtocol where Bound.Stride : SignedInteger {
        var range: Range<Bound>.Iterator
        typealias Element = Bound
        mutating func next() async -> Element? { return range.next() }
        func cancel() { }
        func makeAsyncIterator() -> Self { return self }
      }
      """
    )
  }

  func testForeachAsync3() {
    AssertParse(
      """
      struct AsyncIntRange<Int> : AsyncSequence, AsyncIteratorProtocol {
        typealias Element = (Int, Int)
        func next() async -> (Int, Int)? {}
        func cancel() { }
        typealias AsyncIterator = AsyncIntRange<Int>
        func makeAsyncIterator() -> AsyncIntRange<Int> { return self }
      }
      """
    )
  }

  func testForeachAsync4() {
    AssertParse(
      """
      func for_each(r: AsyncRange<Int>, iir: AsyncIntRange<Int>) async { 
        var sum = 0
        // Simple foreach loop, using the variable in the body
        for await i in r {
          sum = sum + i
        }
        // Check scoping of variable introduced with foreach loop
        i = 0 
        // For-each loops with two variables and varying degrees of typedness
        for await (i, j) in iir {
          sum = sum + i + j
        }
        for await (i, j) in iir {
          sum = sum + i + j
        }
        for await (i, j) : (Int, Int) in iir {
          sum = sum + i + j
        }
        // Parse errors
        // FIXME: Bad diagnostics; should be just 'expected 'in' after for-each patter'.
        for await i #^DIAG_1^#r { 
        }         
        for await i in r #^DIAG_2^#sum = sum + i; 
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
