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
      let (requiresEscaping, poundCount) = requiresEscaping(content)
      if requiresEscaping {
        // Use a delimiter that is exactly one longer
        openDelimiter = Token.rawStringDelimiter(String(repeating: "#", count: poundCount + 1))
        closeDelimiter = openDelimiter
      }
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

private enum PoundState {
  case afterQuote, afterBackslash, none
}

private func requiresEscaping(_ content: String) -> (Bool, poundCount: Int) {
  var state: PoundState = .none
  var consecutivePounds = 0
  var maxPounds = 0
  var requiresEscaping = false

  for c in content {
    switch c {
    case "#":
      consecutivePounds += 1
    case "\"":
      state = .afterQuote
      consecutivePounds = 0
    case "\\":
      state = .afterBackslash
      consecutivePounds = 0
    case "(" where state == .afterBackslash:
      maxPounds = max(maxPounds, consecutivePounds)
      fallthrough
    default:
      consecutivePounds = 0
      state = .none
    }

    if state == .afterQuote {
      maxPounds = max(maxPounds, consecutivePounds)
    }

    requiresEscaping = requiresEscaping || state != .none
  }

  return (requiresEscaping, poundCount: maxPounds)
}
