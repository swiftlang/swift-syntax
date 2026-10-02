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

#if compiler(>=6)
@_spi(RawSyntax) @_spi(BumpPtrAllocator) internal import SwiftSyntax
#else
@_spi(RawSyntax) @_spi(BumpPtrAllocator) import SwiftSyntax
#endif

/// Owns the memory that ``RawSyntaxNodeList`` gathers into.
///
/// Deliberately not the syntax arena, whose memory lives as long as the tree:
/// what is gathered here is read once, when the collection is built, and is dead
/// from then on. Putting it in the arena would leave a buffer per collection —
/// some hundreds of kilobytes for a large file — alive for as long as anything
/// holds the tree.
///
/// A parser keeps one of these for as long as it parses, which outlasts every
/// list it gathers.
struct RawSyntaxNodeListAllocator {
  let allocator: BumpPtrAllocator

  init() {
    self.allocator = BumpPtrAllocator(initialSlabSize: 4096)
  }
}

/// Gathers the elements of a syntax collection so that building the collection
/// does not go through an `Array`.
///
/// A syntax collection is almost always small: over the parser's own sources 60%
/// of those a parse builds hold a single element and 94% hold three or fewer. An
/// `Array` for one of those is a heap allocation, a reference count and a free,
/// to carry one or two pointers.
///
/// Trivially copyable, which is why the allocator is passed to each `append`
/// rather than held: one stored reference would make every copy of this retain
/// and every destroy release. Passing it is free by comparison, because it comes
/// from a stored property of the parser, which the compiler can see stays alive.
struct RawSyntaxNodeListBuilder<Element: RawSyntaxNodeProtocol> {
  /// Room for elements, of which the first ``count`` are initialized.
  private var buffer: UnsafeMutableBufferPointer<Element>

  private(set) var count: Int

  /// How much room to take when the first element is appended.
  ///
  /// Counted over the collections that hold anything, since one that holds
  /// nothing never takes room at all. Over 400 of the parser's own sources, four
  /// suits a collection of expressions or statements: 2% of labeled expression
  /// lists and 4% of code block item lists hold more.
  ///
  /// A collection that usually holds more should say so. 45% of type member
  /// lists hold more than four and 28% hold more than eight; switch case lists
  /// are 28% and 13%. Growing costs an allocation, a copy and a buffer left
  /// behind, where asking for too much costs only scratch that is freed when the
  /// parse ends, so err upwards.
  private let initialCapacity: Int

  init(initialCapacity: Int = 4) {
    self.buffer = UnsafeMutableBufferPointer(start: nil, count: 0)
    self.count = 0
    self.initialCapacity = initialCapacity
  }

  var isEmpty: Bool {
    return self.count == 0
  }

  /// The element gathered most recently, or `nil` if there is none.
  var last: Element? {
    return self.count == 0 ? nil : self.buffer[self.count - 1]
  }

  subscript(index: Int) -> Element {
    get {
      precondition(index < self.count)
      return self.buffer[index]
    }
    set {
      precondition(index < self.count)
      self.buffer[index] = newValue
    }
  }

  /// The elements gathered so far, to read without building the collection.
  var elements: UnsafeBufferPointer<Element> {
    return self.build().buffer
  }

  mutating func append(_ element: Element, allocator: RawSyntaxNodeListAllocator) {
    self.reserve(self.count + 1, allocator: allocator)
    self.buffer.baseAddress!.advanced(by: self.count).initialize(to: element)
    self.count += 1
  }

  mutating func append(contentsOf source: UnsafeBufferPointer<Element>, allocator: RawSyntaxNodeListAllocator) {
    guard let sourceAddress = source.baseAddress, !source.isEmpty else {
      return
    }
    self.reserve(self.count + source.count, allocator: allocator)
    self.buffer.baseAddress!.advanced(by: self.count).initialize(from: sourceAddress, count: source.count)
    self.count += source.count
  }

  /// Take room for `required` elements, unless there is that much already.
  private mutating func reserve(_ required: Int, allocator: RawSyntaxNodeListAllocator) {
    guard required > self.buffer.count else {
      return
    }
    // Nothing gathered here is ever deinitialized, which is only sound for a
    // trivial element. Folds away for any concrete one.
    precondition(_isPOD(Element.self))
    var capacity = self.buffer.count == 0 ? self.initialCapacity : self.buffer.count
    while capacity < required {
      capacity *= 2
    }
    let grown = allocator.allocator.allocate(Element.self, count: capacity)
    // Only the first `count` of the old buffer hold anything; the rest is room
    // that was never used. What is outgrown is left behind rather than freed,
    // which is what a bump allocator does with everything.
    _ = grown.moveInitialize(fromContentsOf: UnsafeMutableBufferPointer(rebasing: self.buffer[..<self.count]))
    self.buffer = grown
  }

  func build() -> RawSyntaxNodeList<Element> {
    return RawSyntaxNodeList(
      buffer: UnsafeBufferPointer(start: self.buffer.baseAddress, count: self.count)
    )
  }
}

extension RawSyntaxNodeListAllocator {
  /// A list holding only `element`.
  func listOfOne<Element: RawSyntaxNodeProtocol>(_ element: Element) -> RawSyntaxNodeList<Element> {
    var builder = RawSyntaxNodeListBuilder<Element>(initialCapacity: 1)
    builder.append(element, allocator: self)
    return builder.build()
  }
}
