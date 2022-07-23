//===-------------------- Utils.swift - Utility Functions -----------------===//
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

public struct ByteSourceRange: Equatable {
  public var offset: Int
  public var length: Int

  public init(offset: Int, length: Int) {
    self.offset = offset
    self.length = length
  }

  public var endOffset: Int {
    return offset+length
  }

  public var isEmpty: Bool {
    return length == 0
  }

  public func intersectsOrTouches(_ other: ByteSourceRange) -> Bool {
    return self.endOffset >= other.offset &&
      self.offset <= other.endOffset
  }

  public func intersects(_ other: ByteSourceRange) -> Bool {
    return self.endOffset > other.offset &&
      self.offset < other.endOffset
  }

  /// Returns the byte range for the overlapping region between two ranges.
  public func intersected(_ other: ByteSourceRange) -> ByteSourceRange {
    let start = max(self.offset, other.offset)
    let end = min(self.endOffset, other.endOffset)
    if start > end {
      return ByteSourceRange(offset: 0, length: 0)
    } else {
      return ByteSourceRange(offset: start, length: end-start)
    }
  }
}
