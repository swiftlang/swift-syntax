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
      contextualClassif = SyntaxClassification.classify(parentKind: parent.raw.kind,
        indexInParent: curData.indexInParent, childKind: raw.kind)
      curData = parent.data
    } while contextualClassif == nil
    return contextualClassif
  }
}

extension TokenSyntax {
  /// The `SyntaxClassifiedRange` for the token text, excluding trivia.
  public var tokenClassification: SyntaxClassifiedRange {
    let contextualClassification = self.data.contextualClassification
    let relativeOffset = raw.tokenLeadingTriviaLength.utf8Length
    let absoluteOffset = position.utf8Offset + relativeOffset
    let classifiedRange = raw.withUnsafeTokenText(
      relativeOffset: relativeOffset
    ) { (tokText: UnsafeTokenText?) -> SyntaxClassifiedRange in
      return tokText!.classify(offset: absoluteOffset,
        contextualClassification: contextualClassification)
    }
    return classifiedRange
  }
}

extension UnsafeTriviaPiece {
  func classify(offset: Int) -> SyntaxClassifiedRange {
    let range = ByteSourceRange(offset: offset, length: length)
    switch self.kind {
      case .lineComment: return .init(kind: .lineComment, range: range)
      case .blockComment: return .init(kind: .blockComment, range: range)
      case .docLineComment: return .init(kind: .docLineComment, range: range)
      case .docBlockComment: return .init(kind: .docBlockComment, range: range)
      default: return .init(kind: .none, range: range)
    }
  }
}

extension UnsafeTokenText {
  func classify(
    offset: Int, contextualClassification: (SyntaxClassification, Bool)?
  ) -> SyntaxClassifiedRange {
    let range = ByteSourceRange(offset: offset, length: length)
    if let contextualClassify = contextualClassification {
      let (classify, force) = contextualClassify
      if kind == .identifier || force {
        return .init(kind: classify, range: range)
      }
    }
    return .init(kind: contextFreeClassification(), range: range)
  }

  fileprivate func contextFreeClassification() -> SyntaxClassification {
    if case .unknown = kind, customText.hasPrefix(.asciiDoubleQuote) {
      return .stringLiteral
    }
    if case .identifier = kind,
        customText.hasPrefix(.asciiLeftAngleBracket, .asciiPound) &&
        customText.hasSuffix(.asciiPound, .asciiRightAngleBracket) {
      return .editorPlaceholder
    }
    return kind.classification
  }
}

/// Represents a syntax node along with its absolute position in the tree and
/// an optional classification.
fileprivate struct AbsoluteNode {
  let raw: RawSyntax
  let position: AbsoluteSyntaxPosition
  /// A psir of classification and whether it is `forced`. If `forced` is true
  /// the classification should apply unconditionally, otherwise it should apply
  /// only for identifiers.
  let classification: (SyntaxClassification, Bool)?

  /// Use this constructor for the root node.
  init(
    raw: RawSyntax,
    position: AbsoluteSyntaxPosition,
    contextualClassification: (SyntaxClassification, Bool)?
  ) {
    self.raw = raw
    self.position = position
    self.classification = contextualClassification
  }

  init(raw: RawSyntax, position: AbsoluteSyntaxPosition, parent: AbsoluteNode) {
    self.raw = raw
    self.position = position
    // Check if this node has a classification otherwise inherit it from the parent.
    self.classification = SyntaxClassification.classify(parentKind: parent.raw.kind,
      indexInParent: Int(position.indexInParent), childKind: raw.kind) ?? parent.classification
  }

  var offset: Int { return Int(position.offset) }

  var endOffset: Int {
    return offset + raw.totalLength.utf8Length
  }

  var firstChild: AbsoluteNode? {
    var curPos = position.advancedToFirstChild()
    for i in 0..<raw.numberOfChildren {
      let childOpt = raw.child(at: i)
      if let child = childOpt, child.isPresent {
        return AbsoluteNode(raw: child, position: curPos, parent: self)
      }
      curPos = curPos.advancedBySibling(childOpt)
    }
    return nil
  }

  func nextSibling(parent: AbsoluteNode) -> AbsoluteNode? {
    var curPos = position.advancedBySibling(raw)
    for i in Int(position.indexInParent+1) ..< parent.raw.numberOfChildren {
      let siblingOpt = parent.raw.child(at: i)
      if let sibling = siblingOpt, sibling.isPresent {
        return AbsoluteNode(raw: sibling, position: curPos, parent: parent)
      }
      curPos = curPos.advancedBySibling(siblingOpt)
    }
    return nil
  }
}

/// Functions as an iterator that walks every node in the tree in sequence.
fileprivate struct SyntaxCursor {
  var parents: [AbsoluteNode]
  var node: AbsoluteNode
  let absRange: ByteSourceRange
  var finished: Bool

  init(
    root: RawSyntax,
    offset: Int,
    in absRange: ByteSourceRange,
    contextualClassification: (SyntaxClassification, Bool)?
  ) {
    self.absRange = absRange
    self.node = AbsoluteNode(raw: root,
      position: .init(offset: UInt32(truncatingIfNeeded: offset), indexInParent: 0),
      contextualClassification: contextualClassification)
    self.parents = []
    self.finished = false
  }

  /// Moves to the first child of the current node.
  /// - Returns: False if the node has no children.
  mutating func advanceToFirstChild() -> Bool {
    guard let child = node.firstChild else { return false }
    parents.append(node)
    node = child
    return true
  }

  /// Moves to the next singling node or the parent's sibling node if this is
  /// the last child.
  /// - Returns: False if it run out of nodes to walk to.
  mutating func advanceToNextSibling() -> Bool {
    while !parents.isEmpty {
      if let sibling = node.nextSibling(parent: parents.last!) {
        node = sibling
        return true
      }
      node = parents.removeLast()
    }

    finished = true
    return false
  }

  /// Moves to the first token in the tree.
  /// - Returns: True if it moved to the first token, false if there are no tokens
  ///   in the requested range.
  mutating func advanceToFirstToken() -> Bool {
    guard node.offset < absRange.endOffset else {
      finished = true
      return false
    }

    while !node.raw.isToken || node.endOffset <= absRange.offset {
      // if the node is out of the requested range we can skip its children.
      if node.endOffset > absRange.offset {
        if advanceToFirstChild() { continue }
      }
      if !advanceToNextSibling() { return false }
    }

    return true
  }

  /// Moves to the next token in the tree. This should be called after `advanceToFirstToken()`.
  /// - Returns: True if it moved to a new token, false if there are no more tokens
  ///   in the requested range.
  mutating func advanceToNextToken() -> Bool {
    repeat {
      if advanceToFirstChild() { continue }
      if !advanceToNextSibling() { return false }

      guard node.offset < absRange.endOffset else {
        finished = true
        return false
      }
    } while !node.raw.isToken

    return true
  }
}

/// Sequence of tokens of a syntax node. This is more efficient than 
/// `TokenSequence` because it avoids casts to `Syntax` protocols.
fileprivate struct FastTokenSequence: Sequence {
  struct Iterator: IteratorProtocol {
    var cursor: SyntaxCursor

    init(
      root: RawSyntax,
      offset: Int,
      in absRange: ByteSourceRange,
      contextualClassification: (SyntaxClassification, Bool)?
    ) {
      self.cursor = SyntaxCursor(root: root, offset: offset, in: absRange,
        contextualClassification: contextualClassification)
      _ = self.cursor.advanceToFirstToken()
    }

    mutating func next() -> AbsoluteNode? {
      guard !cursor.finished else { return nil }

      let node = cursor.node
      _ = cursor.advanceToNextToken()
      return node
    }
  }

  private let root: RawSyntax
  private let offset: Int
  private let absRange: ByteSourceRange
  private let contextualClassification: (SyntaxClassification, Bool)?

  init(
    _ root: RawSyntax,
    offset: Int,
    in absRange: ByteSourceRange,
    contextualClassification: (SyntaxClassification, Bool)?
  ) {
    self.root = root
    self.offset = offset
    self.absRange = absRange
    self.contextualClassification = contextualClassification
  }

  func makeIterator() -> Iterator {
    return .init(root: root, offset: offset, in: absRange,
      contextualClassification: contextualClassification)
  }
}

/// Provides a sequence of `SyntaxClassifiedRange`s for a token.
fileprivate struct TokenClassificationIterator: IteratorProtocol {
  enum State {
    case atLeadingTrivia(Int)
    case atTokenText
    case atTrailingTrivia(Int)
  }

  let token: AbsoluteNode
  var offset: Int
  var state: State

  init(_ token: AbsoluteNode) {
    assert(token.raw.isToken)
    self.token = token
    self.offset = Int(token.position.offset)
    self.state = .atLeadingTrivia(0)
  }

  var relativeOffset: Int { return offset - Int(token.position.offset) }

  mutating func next() -> SyntaxClassifiedRange? {
    while true {
      switch state {
      case .atLeadingTrivia(let index):
        let classifiedRangeOpt = token.raw.withUnsafeLeadingTriviaPiece(
          at: index, relativeOffset: relativeOffset
        ) { (trivia: UnsafeTriviaPiece?) -> SyntaxClassifiedRange? in
          guard let trivia = trivia else { return nil }
          return trivia.classify(offset: offset)
        }
        guard let classifiedRange = classifiedRangeOpt else {
          // Move on to token text.
          state = .atTokenText
          break
        }
        state = .atLeadingTrivia(index+1)
        offset = classifiedRange.endOffset
        guard classifiedRange.kind != .none else { break }
        return classifiedRange

      case .atTokenText:
        let classifiedRange = token.raw.withUnsafeTokenText(
          relativeOffset: relativeOffset
        ) { (tokText: UnsafeTokenText?) -> SyntaxClassifiedRange in
          return tokText!.classify(offset: offset, contextualClassification: token.classification)
        }
        // Move on to trailing trivia.
        state = .atTrailingTrivia(0)
        offset = classifiedRange.endOffset
        guard classifiedRange.kind != .none else { break }
        return classifiedRange

      case .atTrailingTrivia(let index):
        let classifiedRangeOpt = token.raw.withUnsafeTrailingTriviaPiece(
          at: index, relativeOffset: relativeOffset
        ) { (trivia: UnsafeTriviaPiece?) -> SyntaxClassifiedRange? in
          guard let trivia = trivia else { return nil }
          return trivia.classify(offset: offset)
        }
        guard let classifiedRange = classifiedRangeOpt else {
          return nil // Finish iteration.
        }
        state = .atTrailingTrivia(index+1)
        offset = classifiedRange.endOffset
        guard classifiedRange.kind != .none else { break }
        return classifiedRange
      }
    }
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

/// Provides a sequence of `SyntaxClassifiedRange`s for a syntax node.
public struct SyntaxClassifications: Sequence {
  public struct Iterator: IteratorProtocol {
    fileprivate let absRange: ByteSourceRange
    fileprivate var tokenIterator: FastTokenSequence.Iterator
    fileprivate var classifyIter: TokenClassificationIterator?
    fileprivate var pendingClassifiedRange: SyntaxClassifiedRange
    fileprivate var curOffset: Int
    fileprivate var curTokenEndOffset: Int

    init(
      root: RawSyntax,
      offset: Int,
      in absRange: ByteSourceRange,
      contextualClassification: (SyntaxClassification, Bool)?
    ) {
      self.absRange = absRange
      self.tokenIterator = .init(root: root, offset: offset, in: absRange,
        contextualClassification: contextualClassification)
      self.pendingClassifiedRange = .init(kind: .none,
        range: ByteSourceRange(offset: absRange.offset, length: 0))
      self.curOffset = absRange.offset
      self.curTokenEndOffset = curOffset

      guard let classifiedRange = nextActiveClassification() else { return }
      self.pendingClassifiedRange = classifiedRange
      self.curOffset = Int(classifyIter!.token.position.offset)
    }

    /// Updates `curOffset` and returns consecutive classified ranges, excluding
    /// ones that do not intersect with the provided range
    public mutating func next() -> SyntaxClassifiedRange? {
      while true {
        guard let classifiedRange = nextClassification() else { return nil }
        curOffset = classifiedRange.endOffset
        guard classifiedRange.endOffset > absRange.offset else { continue }
        guard classifiedRange.offset < absRange.endOffset else { return nil }
        return classifiedRange
      }
    }

    /// Returns consecutive classified ranges, with `none` classifications interspersed
    /// between non-`none` ones. It also merges consecutive classified ranges of
    /// the same kind.
    fileprivate mutating func nextClassification() -> SyntaxClassifiedRange? {
      func passUnclassified(_ offset: Int, _ length: Int) -> SyntaxClassifiedRange {
        return SyntaxClassifiedRange(kind: .none,
          range: ByteSourceRange(offset: offset, length: length))
      }

      while true {
        let unclassifedLength = pendingClassifiedRange.offset - curOffset
        if unclassifedLength > 0 {
          return passUnclassified(curOffset, unclassifedLength)
        }
        guard let classifiedRange = nextActiveClassification() else {
          if curOffset < pendingClassifiedRange.endOffset {
            return pendingClassifiedRange
          }
          let unclassifedLength = curTokenEndOffset - curOffset
          if unclassifedLength > 0 {
            return passUnclassified(curOffset, unclassifedLength)
          }
          return nil
        }
        // Merge consecutive classified ranges of the same kind.
        if classifiedRange.kind == pendingClassifiedRange.kind &&
           classifiedRange.offset == pendingClassifiedRange.endOffset {
          pendingClassifiedRange.range.length += classifiedRange.length
          continue
        }
        let nextClassifiedRange = pendingClassifiedRange
        pendingClassifiedRange = classifiedRange
        return nextClassifiedRange
      }
    }

    /// Returns only active (non-`none`) classified ranges. The ranges can be
    /// non-consecutive.
    fileprivate mutating func nextActiveClassification() -> SyntaxClassifiedRange? {
      while true {
        if classifyIter != nil {
          if let nextClassify = classifyIter!.next() {
            return nextClassify
          }
          classifyIter = nil
        }
        guard let nextToken = tokenIterator.next() else { return nil }
        curTokenEndOffset = nextToken.endOffset
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
    let nodeOffset = node.position.utf8Offset
    let absRange = ByteSourceRange(offset: nodeOffset + relRange.offset,
      length: relRange.length)
    return .init(root: node.raw, offset: nodeOffset, in: absRange,
      contextualClassification: node.data.contextualClassification)
  }
}
