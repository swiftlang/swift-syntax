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

/// Count the number of # signs before/after a `#` or between a `\` and a `(`.
private func countPounds(_ string: String) -> Int {
  var afterQuote = false
  var afterBackslash = false

  var consecutivePounds = 0

  var maxPounds = 0

  func updateForAnyCharacter() {
    if afterBackslash {
      maxPounds = max(maxPounds, consecutivePounds + 1)
    }

    if afterQuote {
      maxPounds = max(maxPounds, consecutivePounds)
    }
  }

  for c in string {
    switch c {
    case #"""#:
      maxPounds = max(maxPounds, consecutivePounds)
      afterQuote = true
      afterBackslash = false
      consecutivePounds = 0

    case #"\"#:
      if afterQuote {
        maxPounds = max(maxPounds, consecutivePounds)
        afterQuote = false
      }
      afterBackslash = true
      consecutivePounds = 0

    case "#":
      consecutivePounds += 1

    default:
      updateForAnyCharacter()
      afterQuote = false
      afterBackslash = false
      consecutivePounds = 0
    }
  }

  updateForAnyCharacter()

  return maxPounds
}

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
    let segments = StringLiteralSegments([.stringSegment(segment)])

    var openDelimiter = openDelimiter
    var closeDelimiter = closeDelimiter
    if openDelimiter == nil, closeDelimiter == nil {
      let poundCount = countPounds(content)

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
