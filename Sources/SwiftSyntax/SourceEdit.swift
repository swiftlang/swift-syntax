//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// A textual edit to the original source represented by a range and a
/// replacement.
public struct SourceEdit: Equatable, Sendable {
  /// The byte range of the original source buffer that the edit applies to.
  public let range: Range<AbsolutePosition>

  /// The UTF-8 bytes that should be inserted as part of the edit
  public let replacementBytes: [UInt8]

  /// A string representation of the replacement
  public var replacement: String { return String(decoding: replacementBytes, as: UTF8.self) }

  /// The length of the edit replacement in UTF8 bytes.
  public var replacementLength: SourceLength { return SourceLength(utf8Length: replacementBytes.count) }

  @available(*, deprecated, renamed: "range.lowerBound.utf8Offset")
  public var offset: Int { return range.offset }

  @available(*, deprecated, renamed: "replacementLength")
  public var length: Int { return range.length.utf8Length }

  @available(*, deprecated, renamed: "range.upperBound.utf8Offset")
  public var endOffset: Int { return range.endOffset }

  /// After the edit has been applied the range of the replacement text.
  public var replacementRange: Range<AbsolutePosition> {
    return Range(position: range.lowerBound, length: replacementLength)
  }

  /// Create an edit to replace `range` in the original source with
  /// `replacement`.
  public init(range: Range<AbsolutePosition>, replacement: String) {
    self.range = range
    self.replacementBytes = Array(replacement.utf8)
  }

  public init(range: Range<AbsolutePosition>, replacement: [UInt8]) {
    self.range = range
    self.replacementBytes = replacement
  }

  @available(*, deprecated, message: "Use SourceEdit(range:replacement:) instead")
  public init(range: ByteSourceRange, replacementLength: Int) {
    self.range = AbsolutePosition(utf8Offset: range.offset)..<AbsolutePosition(utf8Offset: range.endOffset)
    self.replacementBytes = Array(repeating: UInt8(ascii: " "), count: replacementLength)
  }

  @available(*, deprecated, message: "Use SourceEdit(range:replacement:) instead")
  public init(offset: Int, length: Int, replacementLength: Int) {
    self.range = AbsolutePosition(utf8Offset: offset)..<AbsolutePosition(utf8Offset: offset + length)
    self.replacementBytes = Array(repeating: UInt8(ascii: " "), count: replacementLength)
  }

  @available(*, deprecated, message: "Use SourceEdit(range:replacement:) instead")
  public init(offset: Int, length: Int, replacement: [UInt8]) {
    self.range = AbsolutePosition(utf8Offset: offset)..<AbsolutePosition(utf8Offset: offset + length)
    self.replacementBytes = replacement
  }

  @available(*, deprecated, message: "Use SourceEdit(range:replacement:) instead")
  public init(offset: Int, length: Int, replacement: String) {
    self.init(offset: offset, length: length, replacement: Array(replacement.utf8))
  }

  public func intersectsOrTouchesRange(_ other: Range<AbsolutePosition>) -> Bool {
    return self.range.upperBound.utf8Offset >= other.lowerBound.utf8Offset
      && self.range.lowerBound.utf8Offset <= other.upperBound.utf8Offset
  }

  public func intersectsRange(_ other: Range<AbsolutePosition>) -> Bool {
    return self.range.upperBound.utf8Offset > other.lowerBound.utf8Offset
      && self.range.lowerBound.utf8Offset < other.upperBound.utf8Offset
  }

  /// Convenience function to create a textual addition after the given node
  /// and its trivia.
  public static func insert(_ newText: String, after node: some SyntaxProtocol) -> SourceEdit {
    return SourceEdit(range: node.endPosition..<node.endPosition, replacement: newText)
  }

  /// Convenience function to create a textual addition before the given node
  /// and its trivia.
  public static func insert(_ newText: String, before node: some SyntaxProtocol) -> SourceEdit {
    return SourceEdit(range: node.position..<node.position, replacement: newText)
  }

  /// Convenience function to create a textual replacement of the given node,
  /// including its trivia.
  public static func replace(_ node: some SyntaxProtocol, with replacement: String) -> SourceEdit {
    return SourceEdit(range: node.position..<node.endPosition, replacement: replacement)
  }

  /// Convenience function to create a textual deletion the given node and its
  /// trivia.
  public static func remove(_ node: some SyntaxProtocol) -> SourceEdit {
    return SourceEdit(range: node.position..<node.endPosition, replacement: "")
  }
}

extension SourceEdit: CustomDebugStringConvertible {
  public var debugDescription: String {
    let hasNewline = replacement.contains { $0.isNewline }
    if hasNewline {
      return #"""
        \#(range.lowerBound.utf8Offset)-\#(range.upperBound.utf8Offset)
        """
        \#(replacement)
        """
        """#
    }
    return "\(range.lowerBound.utf8Offset)-\(range.upperBound.utf8Offset) \"\(replacement)\""
  }
}
