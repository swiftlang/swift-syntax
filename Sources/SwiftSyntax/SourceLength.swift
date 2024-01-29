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

/// The length a syntax node spans in the source code. From any AbsolutePosition
/// you reach a node's end location by adding its UTF-8 length.
public struct SourceLength: Comparable, Sendable {
  /// The length in bytes when the text is represented as UTF-8.
  public let utf8Length: Int

  /// Construct the source length of a given text
  public init(of text: String) {
    self.utf8Length = text.utf8.count
  }

  /// Construct a source length that takes up `utf8Length` bytes when represented as UTF-8.
  public init(utf8Length: Int) {
    self.utf8Length = utf8Length
  }

  /// A zero-length source length
  public static let zero: SourceLength =
    SourceLength(utf8Length: 0)

  /// Returns `true` if `lhs` is shorter than `rhs`.
  public static func < (lhs: SourceLength, rhs: SourceLength) -> Bool {
    return lhs.utf8Length < rhs.utf8Length
  }

  /// Combine the length of two source length.
  public static func + (lhs: SourceLength, rhs: SourceLength) -> SourceLength {
    let utf8Length = lhs.utf8Length + rhs.utf8Length
    return SourceLength(utf8Length: utf8Length)
  }

  /// Extend `lhs` by `rhs` bytes.
  public static func += (lhs: inout SourceLength, rhs: SourceLength) {
    lhs = lhs + rhs
  }

  /// Return a source length that's `rhs` bytes shorter than `lhs`.
  public static func - (lhs: SourceLength, rhs: SourceLength) -> SourceLength {
    let utf8Length = lhs.utf8Length - rhs.utf8Length
    return SourceLength(utf8Length: utf8Length)
  }

  /// Change `lhs` to be `rhs` bytes shorter than `lhs`.
  public static func -= (lhs: inout SourceLength, rhs: SourceLength) {
    lhs = lhs - rhs
  }
}

extension AbsolutePosition {
  /// Determine the AbsolutePosition by advancing the `lhs` by the given source
  /// length.
  public static func + (lhs: AbsolutePosition, rhs: SourceLength) -> AbsolutePosition {
    let utf8Offset = lhs.utf8Offset + rhs.utf8Length
    return AbsolutePosition(utf8Offset: utf8Offset)
  }

  /// Advance `lhs` by `rhs`, i.e. changing it to the position `rhs` bytes after `lhs`.
  public static func += (lhs: inout AbsolutePosition, rhs: SourceLength) {
    lhs = lhs + rhs
  }

  /// Return the position `rhs` bytes before `lhs`.
  public static func - (
    lhs: AbsolutePosition,
    rhs: SourceLength
  ) -> AbsolutePosition {
    let utf8Offset = lhs.utf8Offset - rhs.utf8Length
    return AbsolutePosition(utf8Offset: utf8Offset)
  }

  /// Reverse `lhs` by `rhs`, i.e. changing it `lhs` to the position `rhs` bytes before `lhs`.
  public static func -= (lhs: inout AbsolutePosition, rhs: SourceLength) {
    lhs = lhs - rhs
  }
}
