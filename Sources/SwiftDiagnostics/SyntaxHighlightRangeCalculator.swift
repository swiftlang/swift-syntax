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

import SwiftSyntax

/// Serves as a namespace for methods related to computing
/// highlight ranges within syntax trees, considering trivia and other syntax nuances.
@_spi(Testing) public enum SyntaxHighlightRangeCalculator {
  /// Captures details about a specific highlight region within a line of code.
  ///
  /// This struct is used to manage how leading and trailing trivia are treated for each highlight.
  /// It stores the actual syntax highlight and two Boolean flags for trivia settings.
  ///
  /// - Important:
  ///   - `afterLeadingTrivia`: When `true`, the starting column will be computed after considering leading trivia.
  ///   - `afterTrailingTrivia`: When `false`, the ending column will be computed before considering trailing trivia.
  private struct ExtendedHighlight {
    /// The syntax element to be highlighted.
    let highlight: Syntax
    /// Flag to indicate whether leading trivia should be included in the highlight range.
    var afterLeadingTrivia = true
    /// Flag to indicate whether trailing trivia should be included in the highlight range.
    var afterTrailingTrivia = false
  }

  /// Computes the ranges of highlightable regions on a specific line of source code.
  ///
  /// This method computes the start and end columns for each highlight in the line,
  /// taking into account whether the leading or trailing trivia should be included for each highlight.
  /// After computing these ranges, they are sorted based on their starting columns.
  /// Finally, any overlapping ranges are merged into single contiguous ranges.
  ///
  /// - Parameters:
  ///   - annotatedSourceLine: A tuple containing an array of Syntax highlights and the source string for the line.
  ///   - lineNumber: The line number for which highlight ranges are to be computed.
  ///   - tree: The Syntax tree containing the entire source code.
  ///   - sourceLocationConverter: An instance for converting source locations.
  ///
  /// - Returns: An array of highlight ranges, represented by `Range<Int>` instances for the start and end columns.
  ///
  /// - Note:
  ///   1. If the highlight is the first in the line, its leading trivia is always excluded.
  ///   2. If a highlight's end aligns with the start of the next highlight, their shared trivia settings are adjusted.
  ///   3. The last highlight in the line never includes trailing trivia.
  @_spi(Testing) public static func computeHighlightRanges(
    forLine annotatedSourceLine: (highlights: [Syntax], sourceString: String),
    at lineNumber: Int,
    fromTree tree: some SyntaxProtocol,
    usingSourceLocationConverter sourceLocationConverter: SourceLocationConverter
  ) -> [Range<Int>] {
    // Initialize an array of extended highlights, based on provided Syntax highlights.
    var extendedHighlights = annotatedSourceLine.highlights.map { ExtendedHighlight(highlight: $0) }

    // Loop through each extended highlight to fine-tune its trivia settings.
    for extendedHighlightsIndex in extendedHighlights.indices {
      adjustTriviaSettingsForHighlight(
        atIndex: extendedHighlightsIndex,
        in: &extendedHighlights,
        usingSourceLocationConverter: sourceLocationConverter
      )
    }

    // Compute the highlight ranges, one for each extended highlight.
    let highlightRanges: [Range<Int>] =
      extendedHighlights
      .compactMap { extendedHighlight in
        if extendedHighlight.highlight.root != Syntax(tree) {
          return nil
        }

        // Start and end locations considering the adjusted trivia settings.
        let startLoc = extendedHighlight.highlight.startLocation(converter: sourceLocationConverter, afterLeadingTrivia: extendedHighlight.afterLeadingTrivia)
        let endLoc = extendedHighlight.highlight.endLocation(converter: sourceLocationConverter, afterTrailingTrivia: extendedHighlight.afterTrailingTrivia)

        // Compute starting column based on the line number and start location.
        let startColumn: Int
        if startLoc.line < lineNumber {
          startColumn = 1
        } else if startLoc.line == lineNumber {
          startColumn = startLoc.column
        } else {
          return nil
        }

        // Compute ending column based on the line number and end location.
        let endColumn: Int
        if endLoc.line > lineNumber {
          endColumn = annotatedSourceLine.sourceString.count
        } else if endLoc.line == lineNumber {
          endColumn = endLoc.column
        } else {
          return nil
        }

        // Skip highlights with identical start and end columns.
        if startColumn == endColumn {
          return nil
        }

        return startColumn..<endColumn
      }
      .sorted { (lhs, rhs) in lhs.lowerBound < rhs.lowerBound }
      .mergingOverlappingRanges()

    return highlightRanges
  }

  /// Adjusts trivia settings for a specific highlight in the collection.
  ///
  /// This function ensures proper inclusion or exclusion of leading and trailing trivia for a highlight element.
  /// Special handling is applied for the first and last elements as well as consecutive highlights that share the same line
  /// and column positions.
  ///
  /// - Parameters:
  ///   - index: The index of the `ExtendedHighlight` in the `extendedHighlights` array to adjust.
  ///   - extendedHighlights: A mutable array containing all `ExtendedHighlight` objects.
  ///   - sourceLocationConverter: An instance of `SourceLocationConverter` used for position conversions.
  ///
  /// - Note: Trivia settings refer to whether or not leading or trailing trivia should be included with a highlight.
  ///   Leading trivia includes spaces, comments, etc., that appear before a syntax element.
  ///   Trailing trivia includes similar elements but appear after the syntax element.
  private static func adjustTriviaSettingsForHighlight(
    atIndex index: [ExtendedHighlight].Index,
    in extendedHighlights: inout [ExtendedHighlight],
    usingSourceLocationConverter sourceLocationConverter: SourceLocationConverter
  ) {
    // Default trivia settings.
    var afterLeadingTrivia = true
    var afterTrailingTrivia = false

    // Define indices for the first and last elements for easier comparison.
    let firstIndex = extendedHighlights.startIndex
    let lastIndex = extendedHighlights.index(before: extendedHighlights.endIndex)

    // Special case: The first highlight should always include leading trivia.
    if index == firstIndex {
      afterLeadingTrivia = true
    }

    // Special case: The last highlight should never include trailing trivia.
    if index == lastIndex {
      afterTrailingTrivia = false
    }

    // For intermediate highlights, adjust trivia settings based on adjacent highlights.
    if index > firstIndex {
      let previousIndex = extendedHighlights.index(before: index)
      // Get end location of the previous highlight.
      let previousEndLoc = extendedHighlights[previousIndex].highlight.endLocation(converter: sourceLocationConverter, afterTrailingTrivia: true)
      // Get start location of the current highlight without leading trivia.
      let currentStartLoc = extendedHighlights[index].highlight.startLocation(converter: sourceLocationConverter, afterLeadingTrivia: false)

      // If the end of the previous highlight aligns with the start of the current, adjust trivia settings.
      if previousEndLoc == currentStartLoc {
        extendedHighlights[previousIndex].afterTrailingTrivia = true
        afterLeadingTrivia = false
      }
    }

    // Check if the current highlight's end aligns with the start of the next highlight.
    if index < lastIndex {
      let nextIndex = extendedHighlights.index(after: index)
      // Get end location of the current highlight with trailing trivia.
      let currentEndLoc = extendedHighlights[index].highlight.endLocation(converter: sourceLocationConverter, afterTrailingTrivia: true)
      // Get start location of the next highlight without leading trivia.
      let nextStartLoc = extendedHighlights[nextIndex].highlight.startLocation(converter: sourceLocationConverter, afterLeadingTrivia: false)

      // If the end of the current highlight aligns with the start of the next, adjust trivia settings.
      if currentEndLoc == nextStartLoc {
        afterTrailingTrivia = true
        extendedHighlights[nextIndex].afterLeadingTrivia = false
      }
    }

    // Update the trivia settings for the current highlight.
    extendedHighlights[index].afterLeadingTrivia = afterLeadingTrivia
    extendedHighlights[index].afterTrailingTrivia = afterTrailingTrivia
  }
}

extension Sequence where Element == Range<Int> {
  /// Given a set of ranges that are sorted in order of nondecreasing lower
  /// bound, merge any overlapping ranges to produce a sequence of
  /// nonoverlapping ranges.
  fileprivate func mergingOverlappingRanges() -> [Range<Int>] {
    var result: [Range<Int>] = []

    var prior: Range<Int>? = nil
    for range in self {
      // If this is the first range we've seen, note it as the prior and
      // continue.
      guard let priorRange = prior else {
        prior = range
        continue
      }

      // If the ranges overlap, expand the prior range.
      precondition(priorRange.lowerBound <= range.lowerBound)
      if priorRange.overlaps(range) {
        let lower = priorRange.lowerBound
        let upper = Swift.max(priorRange.upperBound, range.upperBound)
        prior = lower..<upper
        continue
      }

      // Append the prior range, then take this new range as the prior
      result.append(priorRange)
      prior = range
    }

    if let priorRange = prior {
      result.append(priorRange)
    }
    return result
  }
}
