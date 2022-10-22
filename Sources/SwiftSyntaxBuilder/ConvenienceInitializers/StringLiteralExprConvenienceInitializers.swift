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
    #""(#*)"#, // Match potential opening delimiters
    #"(#*)""#, // Match potential closing delimiters
    #"\\(#*)\("#, // Match potential interpolations
  ].joined(separator: "|")
)

extension StringLiteralExpr {
  /// Creates a string literal, optionally specifying quotes and delimiters.
  /// If `openDelimiter` and `closeDelimiter` are `nil`, automatically determines
  /// the number of `#`s needed to express the string as-is without any escapes.
  public init(
    openDelimiter: Token? = nil,
    openQuote: Token = .stringQuote,
    content: String,
    closeQuote: Token = .stringQuote,
    closeDelimiter: Token? = nil
  ) {
    let contentToken = Token.stringSegment(content)
    let segment = StringSegment(content: contentToken)
    let segments = StringLiteralSegments([segment])

    var openDelimiter = openDelimiter
    var closeDelimiter = closeDelimiter
    if openDelimiter == nil, closeDelimiter == nil {
      // Match potential escapes in the string
      let matches = rawStringPotentialEscapesPattern.matches(in: content, range: NSRange(content.startIndex..., in: content))

      // Find longest sequence of `#`s by taking the maximum length over all captures
      let poundCount = matches
        .compactMap { match in (1..<match.numberOfRanges).map { match.range(at: $0).length + 1 }.max() }
        .max() ?? 0

      // Use a delimiter that is exactly one longer
      openDelimiter = Token.rawStringDelimiter(String(repeating: "#", count: poundCount))
      closeDelimiter = openDelimiter
    }

    self.init(
      openDelimiter: openDelimiter,
      openQuote: openQuote,
      segments: segments,
      closeQuote: closeQuote,
      closeDelimiter: closeDelimiter
    )
  }
}
