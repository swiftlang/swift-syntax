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
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

fileprivate extension SyntaxProtocol {
  var contextualClassification: (SyntaxClassification, Bool)? {
    var contextualClassif: (SyntaxClassification, Bool)? = nil
    var curData = Syntax(self)
    repeat {
      guard let parent = curData.parent, let property = curData.propertyInParent else { break }
      contextualClassif = SyntaxClassification.classify(property)
      curData = parent
    } while contextualClassif == nil
    return contextualClassif
  }
}

extension TokenSyntax {
  /// The ``SyntaxClassifiedRange`` for the token text, excluding trivia.
  public var tokenClassification: SyntaxClassifiedRange {
    let contextualClassification = self.contextualClassification
    let relativeOffset = leadingTriviaLength.utf8Length
    let absoluteOffset = position.utf8Offset + relativeOffset
    return TokenKindAndText(kind: tokenView.rawKind, text: tokenView.rawText).classify(
      offset: absoluteOffset,
      contextualClassification: contextualClassification
    )
  }
}

extension RawTriviaPiece {
  func classify(offset: Int) -> SyntaxClassifiedRange {
    let range = AbsolutePosition(utf8Offset: offset)..<AbsolutePosition(utf8Offset: offset + byteLength)
    switch self {
    case .lineComment: return .init(kind: .lineComment, range: range)
    case .blockComment: return .init(kind: .blockComment, range: range)
    case .docLineComment: return .init(kind: .docLineComment, range: range)
    case .docBlockComment: return .init(kind: .docBlockComment, range: range)
    default: return .init(kind: .none, range: range)
    }
  }
}

fileprivate struct TokenKindAndText {
  let kind: RawTokenKind
  let text: SyntaxText

  func classify(
    offset: Int,
    contextualClassification: (SyntaxClassification, Bool)?
  ) -> SyntaxClassifiedRange {
    let range = AbsolutePosition(utf8Offset: offset)..<AbsolutePosition(utf8Offset: offset + text.count)

    if let contextualClassify = contextualClassification {
      let (classify, force) = contextualClassify
      if kind == .identifier || force {
        return .init(kind: classify, range: range)
      }
    }
    return .init(kind: contextFreeClassification(), range: range)
  }

  fileprivate func contextFreeClassification() -> SyntaxClassification {
    if kind == .unknown, text.hasPrefix("\"") {
      return .stringLiteral
    }
    if kind == .identifier,
      text.hasPrefix("<#"),
      text.hasSuffix("#>")
    {
      return .editorPlaceholder
    }
    return kind.classification
  }
}

/// Represents a source range that is associated with a syntax classification.
public struct SyntaxClassifiedRange: Equatable, Sendable {
  public var kind: SyntaxClassification
  public var range: Range<AbsolutePosition>

  @available(*, deprecated, message: "Use range.lowerBound.utf8Offset instead")
  public var offset: Int { return range.offset }

  @available(*, deprecated, message: "Use range.utf8Length instead")
  public var length: Int { return range.length.utf8Length }

  @available(*, deprecated, message: "Use range.upperBound.utf8Offset instead")
  public var endOffset: Int { return range.endOffset }
}

private struct ClassificationVisitor {
  private enum VisitResult {
    case `continue`
    case `break`
  }

  private struct Descriptor {
    var node: RawSyntax
    var byteOffset: Int
    var contextualClassification: (SyntaxClassification, Bool)?
  }

  /// Only tokens within this range will be classified.
  /// No classifications will be reported for tokens out of this range.
  private var targetRange: Range<AbsolutePosition>

  var classifications: [SyntaxClassifiedRange]

  /// Only classify tokens in `range`.
  init(node: Syntax, range: Range<AbsolutePosition>) {
    self.targetRange = range
    self.classifications = []

    // `withExtendedLifetime` to make sure ``SyntaxArena`` for the node alive
    // during the visit.
    withExtendedLifetime(node) {
      _ = self.visit(
        Descriptor(
          node: node.raw,
          byteOffset: node.position.utf8Offset,
          contextualClassification: node.contextualClassification
        )
      )
    }
  }

  private mutating func report(range: SyntaxClassifiedRange) {
    if range.kind == .none && range.range.isEmpty {
      return
    }

    // Merge consecutive classified ranges of the same kind.
    if let last = classifications.last,
      last.kind == range.kind,
      last.range.upperBound == range.range.lowerBound
    {
      classifications[classifications.count - 1].range =
        last.range.lowerBound..<(last.range.upperBound + range.range.length)
      return
    }

    guard range.range.lowerBound <= targetRange.upperBound,
      range.range.upperBound >= targetRange.lowerBound
    else {
      return
    }
    classifications.append(range)
  }

  /// Classifies `triviaPieces` starting from `offset` and returns the number of bytes the trivia took up in the source
  private mutating func classify(triviaPieces: [RawTriviaPiece], at offset: Int) -> Int {
    var classifiedBytes = 0
    for triviaPiece in triviaPieces {
      let range = triviaPiece.classify(offset: offset + classifiedBytes)
      report(range: range)
      classifiedBytes += triviaPiece.byteLength
    }
    return classifiedBytes
  }

  // Report classification ranges in `descriptor.node` that is a token.
  private mutating func handleToken(_ descriptor: Descriptor) -> VisitResult {
    let tokenView = descriptor.node.tokenView!
    var byteOffset = descriptor.byteOffset

    // Leading trivia.
    byteOffset += classify(triviaPieces: tokenView.leadingRawTriviaPieces, at: byteOffset)
    // Token text.
    do {
      let range = TokenKindAndText(kind: tokenView.rawKind, text: tokenView.rawText)
        .classify(offset: byteOffset, contextualClassification: descriptor.contextualClassification)
      report(range: range)
      byteOffset += tokenView.rawText.count
    }
    // Trailing trivia.
    byteOffset += classify(triviaPieces: tokenView.trailingRawTriviaPieces, at: byteOffset)

    precondition(byteOffset == descriptor.byteOffset + descriptor.node.byteLength)
    return .continue
  }

  /// Call `visit()` on all `descriptor.node` non-nil children.
  private mutating func handleLayout(_ descriptor: Descriptor) -> VisitResult {
    let children = descriptor.node.layoutView!.children
    var byteOffset = descriptor.byteOffset

    for case (let index, let child?) in children.enumerated() {

      let classification: (classification: SyntaxClassification, force: Bool)?
      let property = SyntaxLayoutProperty(syntaxKind: descriptor.node.kind, index: .init(index))
      classification = SyntaxClassification.classify(property)

      if let classification, classification.force {
        // Leading trivia.
        if let leadingTriviaPieces = child.leadingTriviaPieces {
          byteOffset += classify(triviaPieces: leadingTriviaPieces, at: byteOffset)
        }
        // Layout node text.
        let layoutNodeTextLength = child.byteLength - child.leadingTriviaByteLength - child.trailingTriviaByteLength
        let range = SyntaxClassifiedRange(
          kind: classification.classification,
          range: AbsolutePosition(
            utf8Offset: byteOffset
          )..<AbsolutePosition(utf8Offset: byteOffset + layoutNodeTextLength)
        )
        report(range: range)
        byteOffset += layoutNodeTextLength

        // Trailing trivia.
        if let trailingTriviaPieces = child.trailingTriviaPieces {
          byteOffset += classify(triviaPieces: trailingTriviaPieces, at: byteOffset)
        }
        continue
      }

      let result = visit(
        .init(
          node: child,
          byteOffset: byteOffset,
          contextualClassification: classification ?? descriptor.contextualClassification
        )
      )
      if result == .break {
        return .break
      }
      byteOffset += child.byteLength
    }
    return .continue
  }

  private mutating func visit(_ descriptor: ClassificationVisitor.Descriptor) -> VisitResult {
    guard descriptor.byteOffset < targetRange.upperBound.utf8Offset else {
      return .break
    }
    guard descriptor.byteOffset + descriptor.node.byteLength > targetRange.lowerBound.utf8Offset else {
      return .continue
    }
    guard SyntaxTreeViewMode.sourceAccurate.shouldTraverse(node: descriptor.node) else {
      return .continue
    }
    if descriptor.node.isToken {
      return handleToken(descriptor)
    } else {
      return handleLayout(descriptor)
    }
  }
}

/// Provides a sequence of ``SyntaxClassifiedRange``s for a syntax node.
public struct SyntaxClassifications: Sequence, Sendable {
  public typealias Iterator = Array<SyntaxClassifiedRange>.Iterator

  var classifications: [SyntaxClassifiedRange]

  public init(_ node: Syntax, in range: Range<AbsolutePosition>) {
    let visitor = ClassificationVisitor(node: node, range: range)
    self.classifications = visitor.classifications
  }

  public func makeIterator() -> Iterator {
    classifications.makeIterator()
  }
}
