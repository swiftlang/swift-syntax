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

@available(*, deprecated, renamed: "SourceEdit")
public typealias IncrementalEdit = SourceEdit

@available(*, deprecated, message: "Use Range<AbsolutePosition> instead")
public typealias ByteSourceRange = Range<AbsolutePosition>

extension Range<AbsolutePosition> {
  @available(*, deprecated, message: "Use lowerBound.utf8Offset instead")
  public var offset: Int { lowerBound.utf8Offset }

  @available(*, deprecated, message: "Construct a Range<AbsolutePosition> instead")
  public init(offset: Int, length: Int) {
    self = AbsolutePosition(utf8Offset: offset)..<AbsolutePosition(utf8Offset: offset + length)
  }

  @available(*, deprecated, message: "Use upperBound.utf8Offset instead")
  public var endOffset: Int {
    return upperBound.utf8Offset
  }

  /// Returns the range for the overlapping region between two ranges.
  ///
  /// If the intersection is empty, this returns a range starting at offset 0 and having length 0.
  public func intersected(_ other: Range<AbsolutePosition>) -> Range<AbsolutePosition> {
    return self.clamped(to: other)
  }
}

extension Range<AbsolutePosition> {
  /// The number of bytes between the range's lower bound and its upper bound
  public var length: SourceLength { return SourceLength(utf8Length: upperBound.utf8Offset - lowerBound.utf8Offset) }

  public init(position: AbsolutePosition, length: SourceLength) {
    self = position..<(position + length)
  }

  // Returns `true` if the intersection between this range and `other` is non-empty or if the two ranges are directly
  /// adjacent to each other.
  public func overlapsOrTouches(_ other: Range<AbsolutePosition>) -> Bool {
    return self.upperBound >= other.lowerBound && self.lowerBound <= other.upperBound
  }

  /// Returns `true` if the intersection between this range and `other` is non-empty or if the two ranges are directly
  /// adjacent to each other.
  @available(*, deprecated, renamed: "overlapsOrTouches(_:)")
  public func intersectsOrTouches(_ other: Range<AbsolutePosition>) -> Bool {
    return self.upperBound >= other.lowerBound && self.lowerBound <= other.upperBound
  }

  /// Returns `true` if the intersection between this range and `other` is non-empty.
  @available(*, deprecated, renamed: "overlaps(_:)")
  public func intersects(_ other: Range<AbsolutePosition>) -> Bool {
    return self.upperBound > other.lowerBound && self.lowerBound < other.upperBound
  }

  /// Returns the range for the overlapping region between two ranges.
  ///
  /// If the intersection is empty, this returns `nil`.
  @available(*, deprecated, message: "Use clamped(to:) instead")
  public func intersecting(_ other: Range<AbsolutePosition>) -> Range<AbsolutePosition>? {
    let lowerBound = Swift.max(self.lowerBound, other.lowerBound)
    let upperBound = Swift.min(self.upperBound, other.upperBound)
    if lowerBound > upperBound {
      return nil
    } else {
      return lowerBound..<upperBound
    }
  }
}

extension RawUnexpectedNodesSyntax {
  /// Construct a ``RawUnexpectedNodesSyntax``with the given `elements`.
  ///
  /// If `isMaximumNestingLevelOverflow` is `true`, the node has the
  /// `isMaximumNestingLevelOverflow` error bit set, indicating that the parser
  /// overflowed its maximum nesting level and thus aborted parsing.
  public init(elements: [RawSyntax], isMaximumNestingLevelOverflow: Bool, arena: __shared RawSyntaxArena) {
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
