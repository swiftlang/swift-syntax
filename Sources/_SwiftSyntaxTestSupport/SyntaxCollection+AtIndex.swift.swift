//===----------------- SyntaxCollection+AtIndex.swift  --------------------===//
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
//
// O(n) test method for grabbing a child at a particular index.
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

public extension SyntaxCollection {
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
