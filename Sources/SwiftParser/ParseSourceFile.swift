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
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

extension Parser {
  /// Parse the source code in the given string as Swift source file. See
  /// `Parser.init` for more details.
  public static func parse(
    source: String
  ) -> SourceFileSyntax {
    var parser = Parser(source)
    return SourceFileSyntax.parse(from: &parser)
  }

  /// A compiler interface that allows the enabling of experimental features.
  @_spi(ExperimentalLanguageFeatures)
  public static func parse(
    source: UnsafeBufferPointer<UInt8>,
    swiftVersion: SwiftVersion? = nil,
    experimentalFeatures: ExperimentalFeatures
  ) -> SourceFileSyntax {
    var parser = Parser(source, swiftVersion: swiftVersion, experimentalFeatures: experimentalFeatures)
    return SourceFileSyntax.parse(from: &parser)
  }

  /// Parse the source code in the given buffer as Swift source file. See
  /// `Parser.init` for more details.
  public static func parse(
    source: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int? = nil,
    swiftVersion: SwiftVersion? = nil
  ) -> SourceFileSyntax {
    var parser = Parser(source, maximumNestingLevel: maximumNestingLevel, swiftVersion: swiftVersion)
    return SourceFileSyntax.parse(from: &parser)
  }

  /// Parse the source code in the given string as Swift source file with support
  /// for incremental parsing.
  ///
  /// When parsing a source file for the first time, invoke `parseIncrementally`
  /// with `parseTransition: nil`. This returns the initial tree as well as
  /// ``LookaheadRanges``. If an edit is made to the source file, an
  /// ``IncrementalParseTransition`` can be constructed from the initial tree
  /// and its ``LookaheadRanges``. When invoking `parseIncrementally` again with
  /// the post-edit source and that parse transition, the parser will re-use
  /// nodes that haven’t changed.
  ///
  /// - Parameters:
  ///   - source: The source code to parse
  ///   - parseTransition: If a similar source file has already been parsed, the
  ///     ``IncrementalParseTransition`` that contains the previous tree as well
  ///     as the edits that were performed to it.
  /// - Returns: The parsed tree as well as the ``LookaheadRanges`` that describe
  ///            how far the parser looked ahead while parsing a node, which is
  ///            necessary to construct an ``IncrementalParseTransition`` for a
  ///            subsequent incremental parse
  @available(*, deprecated, message: "Use parseIncrementally with `IncrementalParseResult` return instead")
  @_disfavoredOverload
  public static func parseIncrementally(
    source: String,
    parseTransition: IncrementalParseTransition?
  ) -> (tree: SourceFileSyntax, lookaheadRanges: LookaheadRanges) {
    let parseResult = parseIncrementally(source: source, parseTransition: parseTransition)
    return (parseResult.tree, parseResult.lookaheadRanges)
  }

  /// Parse the source code in the given buffer as Swift source file with support
  /// for incremental parsing.
  ///
  /// See doc comments in ``Parser/parseIncrementally(source:parseTransition:)-2gtt2``
  @available(*, deprecated, message: "Use parseIncrementally with `IncrementalParseResult` return instead")
  @_disfavoredOverload
  public static func parseIncrementally(
    source: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition?
  ) -> (tree: SourceFileSyntax, lookaheadRanges: LookaheadRanges) {
    let parseResult = parseIncrementally(source: source, maximumNestingLevel: maximumNestingLevel, parseTransition: parseTransition)
    return (parseResult.tree, parseResult.lookaheadRanges)
  }

  /// Parse the source code in the given string as Swift source file with support
  /// for incremental parsing.
  ///
  /// When parsing a source file for the first time, invoke `parseIncrementally`
  /// with `parseTransition: nil`. This returns the ``IncrementalParseResult``
  /// If an edit is made to the source file, an ``IncrementalParseTransition``
  /// can be constructed from  the ``IncrementalParseResult``.
  /// When invoking `parseIncrementally` again with
  /// the post-edit source and that parse transition, the parser will re-use
  /// nodes that haven’t changed.
  ///
  /// - Parameters:
  ///   - source: The source code to parse
  ///   - parseTransition: If a similar source file has already been parsed, the
  ///     ``IncrementalParseTransition`` that contains the previous tree as well
  ///     as the edits that were performed to it.
  /// - Returns: The ``IncrementalParseResult``, which is
  ///            necessary to construct an ``IncrementalParseTransition`` for a
  ///            subsequent incremental parse
  public static func parseIncrementally(
    source: String,
    parseTransition: IncrementalParseTransition?
  ) -> IncrementalParseResult {
    var parser = Parser(source, parseTransition: parseTransition)
    return IncrementalParseResult(tree: SourceFileSyntax.parse(from: &parser), lookaheadRanges: parser.lookaheadRanges)
  }

  /// Parse the source code in the given buffer as Swift source file with support
  /// for incremental parsing.
  ///
  /// See doc comments in ``Parser/parseIncrementally(source:parseTransition:)-dj0z``
  public static func parseIncrementally(
    source: UnsafeBufferPointer<UInt8>,
    maximumNestingLevel: Int? = nil,
    parseTransition: IncrementalParseTransition?
  ) -> IncrementalParseResult {
    var parser = Parser(source, maximumNestingLevel: maximumNestingLevel, parseTransition: parseTransition)
    return IncrementalParseResult(tree: SourceFileSyntax.parse(from: &parser), lookaheadRanges: parser.lookaheadRanges)
  }
}

/// The result of incrementally parsing a file.
///
/// This contains the parsed syntax tree and additional information on how far the parser looked ahead to parse each node.
/// This information is required to perform an incremental parse of the tree after applying edits to it.
public struct IncrementalParseResult: Sendable {
  /// The syntax tree from parsing source
  public let tree: SourceFileSyntax
  /// The lookahead ranges for syntax nodes describe
  /// how far the parser looked ahead while parsing a node.
  public let lookaheadRanges: LookaheadRanges

  public init(tree: SourceFileSyntax, lookaheadRanges: LookaheadRanges) {
    self.tree = tree
    self.lookaheadRanges = lookaheadRanges
  }
}

extension Parser {
  mutating func parseRemainder<R: RawSyntaxNodeProtocol>(into: R) -> R {
    guard !into.raw.kind.isSyntaxCollection, let layout = into.raw.layoutView else {
      preconditionFailure("Only support parsing of non-collection layout nodes")
    }

    let remainingTokens = self.consumeRemainingTokens()

    if remainingTokens.isEmpty {
      return R.init(transferTrailingTrivaFromEndOfFileIfPresent(raw: into.raw))!
    }

    let existingUnexpected: [RawSyntax]
    if let unexpectedNode = layout.children[layout.children.count - 1] {
      precondition(unexpectedNode.is(RawUnexpectedNodesSyntax.self))
      existingUnexpected = unexpectedNode.as(RawUnexpectedNodesSyntax.self).elements
    } else {
      existingUnexpected = []
    }
    let unexpected = RawUnexpectedNodesSyntax(elements: existingUnexpected + remainingTokens, arena: self.arena)

    let withUnexpected = layout.replacingChild(at: layout.children.count - 1, with: unexpected.raw, arena: self.arena)

    return R.init(transferTrailingTrivaFromEndOfFileIfPresent(raw: withUnexpected))!
  }

  /// Parses the end-of-file token and appends its leading trivia to the provided `RawSyntax`.
  /// - Parameter raw: The raw syntax node to which the leading trivia of the end-of-file token will be appended.
  /// - Returns: A new `RawSyntax` instance with trailing trivia transferred from the end-of-file token if present, otherwise it will return the raw parameter..
  private mutating func transferTrailingTrivaFromEndOfFileIfPresent(raw: RawSyntax) -> RawSyntax {
    guard let endOfFileToken = self.consume(if: .endOfFile),
      !endOfFileToken.leadingTriviaPieces.isEmpty,
      let raw = raw.withTrailingTrivia(
        Trivia(
          rawPieces: (raw.trailingTriviaPieces ?? []) + endOfFileToken.leadingTriviaPieces
        ),
        arena: self.arena
      )
    else {
      return raw
    }

    return raw
  }
}

private extension Trivia {
  init(rawPieces: [RawTriviaPiece]) {
    let pieces = rawPieces.map(TriviaPiece.init(raw:))
    self.init(pieces: pieces)
  }
}
