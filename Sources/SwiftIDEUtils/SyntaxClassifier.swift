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

@_spi(RawSyntax) import SwiftSyntax

fileprivate extension SyntaxProtocol {
  var contextualClassification: (SyntaxClassification, Bool)? {
    var contextualClassif: (SyntaxClassification, Bool)? = nil
    var curData = Syntax(self)
    repeat {
      guard let parent = curData.parent, let keyPath = curData.keyPathInParent else { break }
      contextualClassif = SyntaxClassification.classify(keyPath)
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
  
  fileprivate func contextFreeClassification() -> SyntaxClassification {
    let kind = tokenKind.decomposeToRaw().rawKind
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

extension RawTriviaPiece {
  func classify(offset: Int) -> SyntaxClassifiedRange {
    let range = ByteSourceRange(offset: offset, length: byteLength)
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
    let range = ByteSourceRange(offset: offset, length: text.count)

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
public struct SyntaxClassifiedRange: Equatable {
  public var kind: SyntaxClassification
  public var range: ByteSourceRange

  public var offset: Int { return range.offset }
  public var length: Int { return range.length }
  public var endOffset: Int { return range.endOffset }
}

class ClassificationGenerator: SyntaxVisitor {
  var classifications: [SyntaxClassifiedRange] = []
  
  private init() {
    super.init(viewMode: .sourceAccurate)
  }
  
  public static func classify(for tree: some SyntaxProtocol, in range: ByteSourceRange?) -> [SyntaxClassifiedRange] {
    let generator = ClassificationGenerator()
    generator.walk(tree)
    return generator.classifications
  }
  
  private func classify(triviaPieces: [RawTriviaPiece], at offset: Int) {
    var classifiedBytes = 0
    for triviaPiece in triviaPieces {
      let range = triviaPiece.classify(offset: offset + classifiedBytes)
      report(range: range)
      classifiedBytes += triviaPiece.byteLength
    }
  }
  
  private func classify(offset: Int, length: Int, as kind: SyntaxClassification) {
    let range = SyntaxClassifiedRange(kind: kind, range: ByteSourceRange(offset: offset, length: length))
    report(range: range)
  }

  public func classify(_ node: some SyntaxProtocol, as kind: SyntaxClassification) {
    guard let token = node.as(TokenSyntax.self),
          token.tokenKind.decomposeToRaw().rawKind == .identifier else {
      return
    }
    let range = SyntaxClassifiedRange(kind: kind, range: ByteSourceRange(offset: node.positionAfterSkippingLeadingTrivia.utf8Offset, length: node.trimmedLength.utf8Length))
    report(range: range)
  }
  
  private func report(range: SyntaxClassifiedRange) {
    // TODO: we should not report the ranges that have been reported already
    //if classifications.contains(where: { $0.range.contains(range.range)}) {
    //  return
    //}
    
    if range.length == 0 {
      return
    }


    // Merge consecutive classified ranges of the same kind.
    if let last = classifications.last,
      last.kind == range.kind,
      last.endOffset == range.offset
    {
      classifications[classifications.count - 1].range = ByteSourceRange(
        offset: last.offset,
        length: last.length + range.length
      )
      return
    }
    
    // TODO: add targetRange for ClassificationGenerator
    /*
      guard range.offset <= targetRange.endOffset,
            range.endOffset >= targetRange.offset
      else {
        return
      }
    */
    //classifications.sort(by: {$0.offset < $1.offset})
    classifications.append(range)
  }
  
  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    let tokenView = node.tokenView
    // Leading trivia
    classify(triviaPieces: tokenView.leadingRawTriviaPieces, at: node.position.utf8Offset)
    // Token text
    let range = SyntaxClassifiedRange(kind: node.contextFreeClassification(), range: ByteSourceRange(offset: node.positionAfterSkippingLeadingTrivia.utf8Offset, length: node.trimmedLength.utf8Length))
    report(range: range)
    // Trailing trivia
    classify(triviaPieces: tokenView.trailingRawTriviaPieces, at: node.endPositionBeforeTrailingTrivia.utf8Offset)
    return .visitChildren
  }
  
  override func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    let atSignOffset = node.atSign.position.utf8Offset
    let length = node.atSign.totalLength - node.atSign.leadingTriviaLength + node.attributeName.totalLength - node.attributeName.trailingTriviaLength
    classify(offset: atSignOffset, length: length.utf8Length, as: .attribute)
    return .visitChildren
  }

  override func visit(_ node: DeclModifierSyntax) -> SyntaxVisitorContinueKind {
    classify(node.name, as: .attribute)
    return .visitChildren
  }

  override func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    classify(node.poundKeyword, as: .ifConfigDirective)
    if let condition = node.condition {
      classify(condition, as: .ifConfigDirective)
    }
    return .visitChildren
  }

  override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    classify(node.poundEndif, as: .ifConfigDirective)
    return .visitChildren
  }

  override func visit(_ node: MemberTypeSyntax) -> SyntaxVisitorContinueKind {
    classify(node.name, as: .type)
    return .visitChildren
  }

  override func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    classify(node.name, as: .operator)
    return .visitChildren
  }

  override func visit(_ node: PlatformVersionSyntax) -> SyntaxVisitorContinueKind {
    classify(node.platform, as: .keyword)
    return .visitChildren
  }

  override func visit(_ node: PlatformVersionItemSyntax) -> SyntaxVisitorContinueKind {
    classify(node.platformVersion, as: .keyword)
    return .visitChildren
  }

  override func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    classify(node.associativityLabel, as: .keyword)
    return .visitChildren
  }

  override func visit(_ node: PrecedenceGroupRelationSyntax) -> SyntaxVisitorContinueKind {
    classify(node.higherThanOrLowerThanLabel, as: .keyword)
    return .visitChildren
  }

  override func visit(_ node: IdentifierTypeSyntax) -> SyntaxVisitorContinueKind {
    classify(node.name, as: .type)
    return .visitChildren
  }
}


/// Provides a sequence of ``SyntaxClassifiedRange``s for a syntax node.
public struct SyntaxClassifications: Sequence {
  public typealias Iterator = Array<SyntaxClassifiedRange>.Iterator

  var classifications: [SyntaxClassifiedRange]

  public init(_ node: Syntax, in relRange: ByteSourceRange) {
    self.classifications = ClassificationGenerator.classify(for: node, in: relRange)
  }

  public func makeIterator() -> Iterator {
    classifications.makeIterator()
  }
}
