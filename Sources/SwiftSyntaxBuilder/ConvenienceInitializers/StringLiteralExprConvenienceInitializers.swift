//===----------------------------------------------------------------------===//
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

import SwiftSyntax
import Foundation

/// A regular expression matching sequences of `#`s with an adjacent quote or
/// interpolation. Used to determine the number of `#`s for a raw string literal.
private let rawStringPotentialEscapesPattern = try! NSRegularExpression(
  pattern: [
    #""(#+)"#, // Match potential opening delimiters
    #"(#+)""#, // Match potential closing delimiters
    #"\\(#+)\("#, // Match potential interpolations
  ].joined(separator: "|")
)

extension StringLiteralExpr {
  /// Creates a string literal, optionally specifying quotes and delimiters.
  public init(
    openDelimiter: Token? = nil,
    openQuote: Token = .stringQuote,
    _ value: String,
    closeQuote: Token = .stringQuote,
    closeDelimiter: Token? = nil
  ) {
    let content = Token.stringSegment(value)
    let segment = StringSegment(content: content)
    let segments = StringLiteralSegments([segment])

    self.init(
      openDelimiter: openDelimiter,
      openQuote: openQuote,
      segments: segments,
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter
    )
  }

  /// Creates a raw string literal. Automatically determines
  /// the number of `#`s needed to express the string as-is without any escapes.
  public init(raw value: String) {
    // Match potential escapes in the string
    let matches = rawStringPotentialEscapesPattern.matches(in: value, range: NSRange(value.startIndex..., in: value))

    // Find longest sequence of `#`s by taking the maximum length over all captures
    let maxPoundCount = matches
      .compactMap { match in (1..<match.numberOfRanges).map { match.range(at: $0).length }.max() }
      .max() ?? 0

    // Use a delimiter that is exactly one longer
    let delimiter = Token.rawStringDelimiter(String(repeating: "#", count: 1 + maxPoundCount))

    self.init(
      openDelimiter: delimiter,
      value,
      closeDelimiter: delimiter
    )
  }
}
