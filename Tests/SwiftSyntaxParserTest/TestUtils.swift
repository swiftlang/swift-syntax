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
