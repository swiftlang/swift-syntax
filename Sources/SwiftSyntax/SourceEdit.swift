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

/// A textual edit to the original source represented by a range and a
/// replacement.
public struct SourceEdit: Equatable, Sendable {
  /// The half-open range that this edit applies to.
  public let range: Range<AbsolutePosition>
  /// The text to replace the original range with. Empty for a deletion.
  public let replacement: String

  /// Length of the original source range that this edit applies to. Zero if
  /// this is an addition.
  public var length: SourceLength {
    return SourceLength(utf8Length: range.upperBound.utf8Offset - range.lowerBound.utf8Offset)
  }

  /// Create an edit to replace `range` in the original source with
  /// `replacement`.
  public init(range: Range<AbsolutePosition>, replacement: String) {
    self.range = range
    self.replacement = replacement
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
