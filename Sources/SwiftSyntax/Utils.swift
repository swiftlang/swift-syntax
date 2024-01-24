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

public struct ByteSourceRange: Equatable, Sendable {
  public var offset: Int
  public var length: Int

  public init(offset: Int, length: Int) {
    self.offset = offset
    self.length = length
  }

  public var endOffset: Int {
    return offset + length
  }

  public var isEmpty: Bool {
    return length == 0
  }

  public func intersectsOrTouches(_ other: ByteSourceRange) -> Bool {
    return self.endOffset >= other.offset && self.offset <= other.endOffset
  }

  public func intersects(_ other: ByteSourceRange) -> Bool {
    return self.endOffset > other.offset && self.offset < other.endOffset
  }

  /// Returns the byte range for the overlapping region between two ranges.
  public func intersected(_ other: ByteSourceRange) -> ByteSourceRange {
    let start = max(self.offset, other.offset)
    let end = min(self.endOffset, other.endOffset)
    if start > end {
      return ByteSourceRange(offset: 0, length: 0)
    } else {
      return ByteSourceRange(offset: start, length: end - start)
    }
  }
}

public struct IncrementalEdit: Equatable, Sendable {
  /// The byte range of the original source buffer that the edit applies to.
  public let range: ByteSourceRange
  /// The length of the edit replacement in UTF8 bytes.
  public let replacementLength: Int

  public var offset: Int { return range.offset }

  public var length: Int { return range.length }

  public var endOffset: Int { return range.endOffset }

  /// After the edit has been applied the range of the replacement text.
  public var replacementRange: ByteSourceRange {
    return ByteSourceRange(offset: offset, length: replacementLength)
  }

  public init(range: ByteSourceRange, replacementLength: Int) {
    self.range = range
    self.replacementLength = replacementLength
  }

  public init(offset: Int, length: Int, replacementLength: Int) {
    self.range = ByteSourceRange(offset: offset, length: length)
    self.replacementLength = replacementLength
  }

  public func intersectsOrTouchesRange(_ other: ByteSourceRange) -> Bool {
    return self.range.intersectsOrTouches(other)
  }

  public func intersectsRange(_ other: ByteSourceRange) -> Bool {
    return self.range.intersects(other)
  }
}

extension RawUnexpectedNodesSyntax {
  /// Construct a ``RawUnexpectedNodesSyntax``with the given `elements`.
  ///
  /// If `isMaximumNestingLevelOverflow` is `true`, the node has the
  /// `isMaximumNestingLevelOverflow` error bit set, indicating that the parser
  /// overflowed its maximum nesting level and thus aborted parsing.
  public init(elements: [RawSyntax], isMaximumNestingLevelOverflow: Bool, arena: __shared SyntaxArena) {
    let raw = RawSyntax.makeLayout(
      kind: .unexpectedNodes,
      uninitializedCount: elements.count,
      isMaximumNestingLevelOverflow: isMaximumNestingLevelOverflow,
      arena: arena
    ) { layout in
      guard var ptr = layout.baseAddress else { return }
      for elem in elements {
        ptr.initialize(to: elem.raw)
        ptr += 1
      }
    }
    self.init(raw: raw)
  }
}
