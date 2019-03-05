import Foundation
import SwiftSyntax
import XCTest

func getInput(_ file: String) -> URL {
  var result = URL(fileURLWithPath: #file)
  result.deleteLastPathComponent()
  result.appendPathComponent("Inputs")
  result.appendPathComponent(file)
  return result
}

/// Verifies that there is a next item returned by the iterator and that it
/// satisfies the given predicate.
func XCTAssertNext<Iterator: IteratorProtocol>(
  _ iterator: inout Iterator,
  satisfies predicate: (Iterator.Element) throws -> Bool
  ) rethrows {
  let next = iterator.next()
  XCTAssertNotNil(next)
  XCTAssertTrue(try predicate(next!))
}

/// Verifies that the iterator is exhausted.
func XCTAssertNextIsNil<Iterator: IteratorProtocol>(_ iterator: inout Iterator) {
  XCTAssertNil(iterator.next())
}

extension SyntaxCollection {
  /// Gets the child at the provided index in this node's present children.
  /// This is not provided by the Syntax API because its performance is O(n).
  /// We add it here in `SyntaxCollection` for testing purposes.
  func child(at index: Int) -> Element? {
    guard index >= 0 && index < self.count else { return nil }
    var iter = self.makeIterator()
    for _ in 0..<index { _ = iter.next() }
    return iter.next()!
  }

  subscript(_ index: Int) -> Element {
    return child(at: index)!
  }
}
