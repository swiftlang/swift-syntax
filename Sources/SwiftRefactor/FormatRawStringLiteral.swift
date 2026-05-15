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
import SwiftParser
public import SwiftSyntax
#else
import SwiftParser
import SwiftSyntax
#endif

/// Format a string literal by inserting or removing the appropriate number of
/// raw string `#` delimiters.
///
/// ## Before
///
/// ```swift
/// "The # of values is \(count)"
/// "Hello \#(world)"
/// ###"Hello World"###
/// ```
///
/// ## After
///
/// ```swift
/// ##"The # of values is \(count)"##
/// ##"Hello \#(world)"##
/// "Hello World"
/// ```
public struct FormatRawStringLiteral: SyntaxRefactoringProvider {
  public static func refactor(syntax lit: StringLiteralExprSyntax, in context: Void) -> StringLiteralExprSyntax {
    // The highest number of consecutive `#` characters that appears in any
    // string-segment content or interpolation delimiter. Using one more than
    // this many delimiters always produces a syntactically valid literal, so
    // it serves both as an upper bound for the search below and as a safe
    // count to fall back to when the input is malformed.
    var maximumHashes = 0
    for segment in lit.segments {
      switch segment {
      case .expressionSegment(let expr):
        if let rawStringDelimiter = expr.pounds {
          maximumHashes = max(maximumHashes, rawStringDelimiter.text.longestRun(of: "#"))
        }
      case .stringSegment(let string):
        maximumHashes = max(maximumHashes, string.content.text.longestRun(of: "#"))
      #if RESILIENT_LIBRARIES
      @unknown default:
        fatalError()
      #endif
      }
    }

    let upperBound = maximumHashes + 1

    // For malformed input we can't verify candidates against
    // `representedLiteralValue`, so fall back to the content-safe count.
    if lit.hasError {
      return adjustingDelimiterCount(lit, count: maximumHashes > 0 ? upperBound : 0)
    }

    let originalValue = lit.representedLiteralValue

    // Search for the smallest delimiter count that preserves the meaning of
    // the literal. Removing pounds can flip `\#(...)` into an interpolation,
    // change `\n` from literal to a newline, fuse content quotes with the
    // surrounding quote token, or turn `"""` into a multi-line opener. Each
    // candidate is rebuilt, re-parsed, and accepted only if it has no parse
    // errors and the same `representedLiteralValue` as the original.
    for count in 0...upperBound {
      let candidate = adjustingDelimiterCount(lit, count: count)
      var parser = Parser(candidate.description)
      guard let parsedCandidate = ExprSyntax.parse(from: &parser).as(StringLiteralExprSyntax.self),
        !parsedCandidate.hasError,
        parsedCandidate.representedLiteralValue == originalValue
      else {
        continue
      }
      return candidate
    }

    // Conservative fallback if no candidate verified.
    return adjustingDelimiterCount(lit, count: upperBound)
  }

  private static func adjustingDelimiterCount(_ lit: StringLiteralExprSyntax, count: Int) -> StringLiteralExprSyntax {
    let delimiters = String(repeating: "#", count: count)
    return
      lit
      .with(\.openingPounds, lit.openingPounds?.with(\.tokenKind, .rawStringPoundDelimiter(delimiters)))
      .with(\.closingPounds, lit.closingPounds?.with(\.tokenKind, .rawStringPoundDelimiter(delimiters)))
  }
}

extension String {
  fileprivate func longestRun(of needle: Character) -> Int {
    var longest = 0
    var it = self.makeIterator()
    while let c = it.next() {
      guard c == needle else {
        continue
      }

      var localLongest = 1
      while let c = it.next(), c == needle {
        localLongest += 1
        continue
      }

      longest = max(localLongest, longest)
    }
    return longest
  }
}
