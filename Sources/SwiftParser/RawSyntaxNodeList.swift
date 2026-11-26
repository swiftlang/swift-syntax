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

@_spi(RawSyntax) internal import SwiftSyntax

/// The elements to build a syntax collection from, held contiguously in memory
/// the caller owns.
///
/// This is what a collection's initializer takes, rather than an `Array`. A
/// collection is almost always tiny — over 400 of the parser's own sources, 60%
/// of those a parse builds hold a single element and 94% hold three or fewer — so
/// an `Array` for one is a heap allocation, a reference count and a free to carry
/// one or two pointers.
///
/// Trivially copyable, and owns nothing: whoever gathered the elements owns them
/// and must keep them alive until the collection is built.
struct RawSyntaxNodeList<Element: RawSyntaxNodeProtocol> {
  let buffer: UnsafeBufferPointer<Element>

  /// No elements, which needs no memory from anywhere.
  init() {
    self.buffer = UnsafeBufferPointer(start: nil, count: 0)
  }

  init(buffer: UnsafeBufferPointer<Element>) {
    self.buffer = buffer
  }

  var count: Int {
    return self.buffer.count
  }

  var isEmpty: Bool {
    return self.buffer.isEmpty
  }
}
