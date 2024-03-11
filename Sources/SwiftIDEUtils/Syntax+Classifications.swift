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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

public extension SyntaxProtocol {

  /// Sequence of ``SyntaxClassifiedRange``s for this syntax node.
  ///
  /// The provided classified ranges are consecutive and cover the full source
  /// text of the node. The ranges may also span multiple tokens, if multiple
  /// consecutive tokens would have the same classification then a single classified
  /// range is provided for all of them.
  var classifications: SyntaxClassifications {
    let fullRange = ByteSourceRange(offset: 0, length: totalLength.utf8Length)
    return SyntaxClassifications(_syntaxNode, in: fullRange)
  }

  /// Sequence of ``SyntaxClassifiedRange``s contained in this syntax node within
  /// a relative range.
  ///
  /// The provided classified ranges may extend beyond the provided `range`.
  /// Active classifications (non-`none`) will extend the range to include the
  /// full classified range (e.g. from the beginning of the comment block), while
  /// `none` classified ranges will extend to the beginning or end of the token
  /// that the `range` touches.
  /// It is guaranteed that no classified range will be provided that doesn't
  /// intersect the provided `range`.
  ///
  /// - Parameters:
  ///   - in: The relative byte range to pull ``SyntaxClassifiedRange``s from.
  /// - Returns: Sequence of ``SyntaxClassifiedRange``s.
  func classifications(in range: ByteSourceRange) -> SyntaxClassifications {
    return SyntaxClassifications(_syntaxNode, in: range)
  }

  /// The ``SyntaxClassifiedRange`` for a relative byte offset.
  /// - Parameters:
  ///   - at: The relative to the node byte offset.
  /// - Returns: The ``SyntaxClassifiedRange`` for the offset or nil if the source text
  ///   at the given offset is unclassified.
  func classification(at offset: Int) -> SyntaxClassifiedRange? {
    let classifications = SyntaxClassifications(_syntaxNode, in: ByteSourceRange(offset: offset, length: 1))
    var iterator = classifications.makeIterator()
    return iterator.next()
  }

  /// The ``SyntaxClassifiedRange`` for an absolute position.
  /// - Parameters:
  ///   - at: The absolute position.
  /// - Returns: The ``SyntaxClassifiedRange`` for the position or nil if the source text
  ///   at the given position is unclassified.
  func classification(at position: AbsolutePosition) -> SyntaxClassifiedRange? {
    let relativeOffset = position.utf8Offset - self.position.utf8Offset
    return self.classification(at: relativeOffset)
  }
}
