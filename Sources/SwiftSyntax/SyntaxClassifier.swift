//===------------- SyntaxClassifier.swift - Syntax Classifier -------------===//
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

extension SyntaxData {
  var contextualClassification: (SyntaxClassification, Bool)? {
    var contextualClassif: (SyntaxClassification, Bool)? = nil
    var curData = self
    repeat {
      guard let parent = curData.parent else { break }
      contextualClassif = SyntaxClassification.classify(parentKind: parent.raw.syntaxKind,
        indexInParent: curData.indexInParent!, childKind: raw.syntaxKind)
      curData = parent
    } while contextualClassif == nil
    return contextualClassif
  }
}

extension TokenSyntax {
  /// The `SyntaxClassifiedRange` for the token text, excluding trivia.
  public var tokenClassification: SyntaxClassifiedRange {
    let contextualClassification = self.data.contextualClassification
    let relativeOffset = raw.leadingTriviaByteLength
    let absoluteOffset = position.utf8Offset + relativeOffset
    return self.classify(offset: absoluteOffset,
                         contextualClassification: contextualClassification)
  }

  func classify(
    offset: Int, contextualClassification: (SyntaxClassification, Bool)?
  ) -> SyntaxClassifiedRange {
    let kind = self.tokenKind
    let range = ByteSourceRange(offset: offset, length: raw.tokenText!.count)

    if let contextualClassify = contextualClassification {
      let (classify, force) = contextualClassify
      if kind == .identifier || force {
        return .init(kind: classify, range: range)
      }
    }
    return .init(kind: contextFreeClassification(), range: range)
  }

  fileprivate func contextFreeClassification() -> SyntaxClassification {
    let tokText = raw.tokenText!
    if tokenKind == .unknown, raw.tokenText!.hasPrefix("\"") {
      return .stringLiteral
    }
    if tokenKind == .identifier,
       tokText.hasPrefix("<#") &&
       tokText.hasSuffix("#>") {
      return .editorPlaceholder
    }
    return tokenKind.classification
  }
}

extension RawTriviaPiece {
  func classify(offset: Int) -> SyntaxClassifiedRange {
    let kind: SyntaxClassification
    let text: StringRef
    switch self {
    case  .lineComment(let txt):
      kind = .lineComment
      text = txt
    case  .blockComment(let txt):
      kind = .lineComment
      text = txt
    case  .docLineComment(let txt):
      kind = .lineComment
      text = txt
    case  .docBlockComment(let txt):
      kind = .lineComment
      text = txt
    default:
      return .init(kind: .none, range: .init(offset: offset, length: byteLength))
    }
    return .init(kind: kind, range: .init(offset: offset, length: text.count))
  }
}

private func getRawTriviaPieces(token: TokenSyntax, isTrailing: Bool) -> [RawTriviaPiece] {
  let rawTrivia = isTrailing ? token.raw.trailingTrivia : token.raw.leadingTrivia
  switch rawTrivia! {
  case .unparsed(let str):
    return token.raw.arena.parseTrivia(str, isTrailing: false)
  case .materialized(let pieces):
    return Array(pieces)
  }
}

/// Provides a sequence of `SyntaxClassifiedRange`s for a token.
fileprivate struct TokenClassificationIterator: IteratorProtocol {
  enum State {
    case atLeadingTrivia([RawTriviaPiece], Int)
    case atTokenText
    case atTrailingTrivia([RawTriviaPiece], Int)
  }

  let token: TokenSyntax
  var offset: Int
  var state: State

  init(_ token: TokenSyntax) {
    self.token = token
    self.offset = token.byteOffset
    self.state = .atLeadingTrivia(getRawTriviaPieces(token: token, isTrailing: false), 0)
  }

  var relativeOffset: Int { return offset - Int(token.byteOffset) }

  mutating func next() -> SyntaxClassifiedRange? {
    while true {
      switch state {
      case .atLeadingTrivia(let trivia, let index):
        guard index < trivia.count else {
          state = .atTokenText
          break
        }
        let classifiedRange = trivia[index].classify(offset: offset)
        state = .atLeadingTrivia(trivia, index+1)
        offset = classifiedRange.endOffset
        return classifiedRange

      case .atTokenText:
        // FIXME: (performance) token.data.contextualClassification here is slow!
        // Because it traverses the ancestors to root. We should manage some
        // contextual classifycation stuck.
        let classifiedRange = token.classify(
          offset: offset, contextualClassification: token.data.contextualClassification)
        // Move on to trailing trivia.
        state = .atTrailingTrivia(getRawTriviaPieces(token: token, isTrailing: true), 0)
        offset = classifiedRange.endOffset
        return classifiedRange

      case .atTrailingTrivia(let trivia, let index):
        guard index < trivia.count else {
          return nil
        }
        let classifiedRange = trivia[index].classify(offset: offset)
        state = .atTrailingTrivia(trivia, index+1)
        offset = classifiedRange.endOffset
        return classifiedRange
      }
    }
  }
}

/// Provides a sequence of `SyntaxClassifiedRange`s for a syntax node.
public struct SyntaxClassifications: Sequence {
  public struct Iterator: IteratorProtocol {
    fileprivate var tokenIterator: TokenSequence.Iterator
    fileprivate let endOffset: Int
    fileprivate var classifyIter: TokenClassificationIterator?
    fileprivate var pendingClassification: SyntaxClassifiedRange?

    init(
      tokenIterator: TokenSequence.Iterator,
      in absRange: ByteSourceRange,
      contextualClassification: (SyntaxClassification, Bool)?
    ) {
      var tokenIterator = tokenIterator
      while let next = tokenIterator.peek(), next.byteOffset < absRange.offset {
        _ = tokenIterator.next()
      }
      self.tokenIterator = tokenIterator
      self.endOffset = absRange.endOffset
      self.classifyIter = nil
      self.pendingClassification = nil

      self.pendingClassification = nextClassificationPiece()
    }

    /// Returns consecutive classified ranges merging consecutive classified
    /// ranges of the same kind.
    public mutating func next() -> SyntaxClassifiedRange? {
      while true {
        guard let pending = pendingClassification else {
          return nil
        }
        guard let classifiedRange = nextClassificationPiece() else {
          pendingClassification = nil
          return pending
        }
        assert(pending.endOffset == classifiedRange.offset)

        if classifiedRange.kind != pending.kind {
          if classifiedRange.offset < endOffset {
            pendingClassification = classifiedRange
          } else {
            // If the next is out of the range. We are done.
            pendingClassification = nil
          }
          return pending
        }

        // Merge consecutive classified ranges of the same kind.
        let range = ByteSourceRange(
          offset: pending.offset,
          length: pending.length + classifiedRange.length)
        pendingClassification = .init(kind: pending.kind, range: range)
      }
    }

    /// Returns only active (non-`none`) classified ranges. The ranges can be
    /// non-consecutive.
    fileprivate mutating func nextClassificationPiece() -> SyntaxClassifiedRange? {
      while true {
        if classifyIter != nil {
          if let nextClassify = classifyIter!.next() {
            return nextClassify
          }
          classifyIter = nil
        }
        guard let nextToken = tokenIterator.next() else { return nil }
        classifyIter = TokenClassificationIterator(nextToken)
      }
    }
  }

  let node: Syntax
  let relRange: ByteSourceRange

  public init(_ node: Syntax, in relRange: ByteSourceRange) {
    self.node = node
    self.relRange = relRange
  }

  public func makeIterator() -> Iterator {
    // Convert the relative range to an absolute one.
    let nodeOffset = node.byteOffset
    let absRange = ByteSourceRange(offset: nodeOffset + relRange.offset,
      length: relRange.length)
    let tokenIterator = node.tokens.makeIterator()
    return .init(tokenIterator: tokenIterator, in: absRange,
      contextualClassification: node.data.contextualClassification)
  }
}

/// Represents a source range that is associated with a syntax classification.
public struct SyntaxClassifiedRange: Equatable {
  public var kind: SyntaxClassification
  public var range: ByteSourceRange

  public var offset: Int { return range.offset }
  public var length: Int { return range.length }
  public var endOffset: Int { return range.endOffset }
}

extension SyntaxProtocol {
  /// Sequence of `SyntaxClassifiedRange`s contained in this syntax node within
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
  ///   - in: The relative byte range to pull `SyntaxClassifiedRange`s from.
  /// - Returns: Sequence of `SyntaxClassifiedRange`s.
  public func classifications(in range: ByteSourceRange) -> SyntaxClassifications {
    return SyntaxClassifications(self.syntax, in: range)
  }

  /// Sequence of `SyntaxClassifiedRange`s for this syntax node.
  ///
  /// The provided classified ranges are consecutive and cover the full source
  /// text of the node. The ranges may also span multiple tokens, if multiple
  /// consecutive tokens would have the same classification then a single classified
  /// range is provided for all of them.
  public var classifications: SyntaxClassifications {
    classifications(in: .init(offset: 0, length: byteLength))
  }

  /// The `SyntaxClassifiedRange` for a relative byte offset.
  /// - Parameters:
  ///   - at: The relative to the node byte offset.
  /// - Returns: The `SyntaxClassifiedRange` for the offset or nil if the source text
  ///   at the given offset is unclassified.
  public func classification(at offset: Int) -> SyntaxClassifiedRange? {
    var iterator = classifications.makeIterator()
    return iterator.next()
  }
}
