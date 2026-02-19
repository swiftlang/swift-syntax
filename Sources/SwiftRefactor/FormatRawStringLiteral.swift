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
public import SwiftSyntax
#else
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
    var maximumHashes = 0
    for segment in lit.segments {
      switch segment {
      case .expressionSegment(let expr):
        if let rawStringDelimiter = expr.pounds {
          // Pick up any delimiters in interpolation segments \#...#(...)
          maximumHashes = max(maximumHashes, rawStringDelimiter.text.longestRun(of: "#"))
        }
      case .stringSegment(let string):
        // Find the longest run of # characters in the content of the literal.
        maximumHashes = max(maximumHashes, string.content.text.longestRun(of: "#"))
      #if RESILIENT_LIBRARIES
      @unknown default:
        fatalError()
      #endif
      }
    }

    // Even if there are no '#' characters in the content, we may still need
    // delimiters if the content contains characters that would be
    // misinterpreted in a non-raw string literal (e.g. `\` would start escape
    // sequences, `"` would close the string prematurely).
    guard maximumHashes > 0 || contentNeedsRawDelimiters(lit) else {
      return
        lit
        .with(\.openingPounds, lit.openingPounds?.with(\.tokenKind, .rawStringPoundDelimiter("")))
        .with(\.closingPounds, lit.closingPounds?.with(\.tokenKind, .rawStringPoundDelimiter("")))
    }

    if maximumHashes == 0 {
      // Content needs delimiters but has no '#' characters, so a single '#'
      // delimiter is sufficient.
      return
        lit
        .with(\.openingPounds, lit.openingPounds?.with(\.tokenKind, .rawStringPoundDelimiter("#")))
        .with(\.closingPounds, lit.closingPounds?.with(\.tokenKind, .rawStringPoundDelimiter("#")))
    }

    let delimiters = String(repeating: "#", count: maximumHashes + 1)
    return
      lit
      .with(\.openingPounds, lit.openingPounds?.with(\.tokenKind, .rawStringPoundDelimiter(delimiters)))
      .with(\.closingPounds, lit.closingPounds?.with(\.tokenKind, .rawStringPoundDelimiter(delimiters)))
  }
}

/// Check whether the content of a string literal contains characters that
/// require raw-string delimiters (i.e. backslashes or quote sequences that
/// would be misinterpreted in a non-raw string).
private func contentNeedsRawDelimiters(_ lit: StringLiteralExprSyntax) -> Bool {
  // Don't flag content from error-recovered (malformed) literals —
  // their segments may contain stray quote characters that are artifacts
  // of parser recovery, not actual content.
  guard lit.closingQuote.presence == .present, lit.closingPounds?.presence != .missing else {
    return false
  }

  let isMultiline = lit.openingQuote.tokenKind == .multilineStringQuote

  for segment in lit.segments {
    switch segment {
    case .stringSegment(let string):
      let text = string.content.text
      if isMultiline {
        // In a multiline string literal, three or more consecutive quotes
        // would terminate the literal prematurely.
        if text.longestRun(of: "\"") >= 3 {
          return true
        }
      } else {
        // In a single-line string literal, any quote `"` would terminate
        // the literal prematurely.
        if text.unicodeScalars.contains(where: { $0 == "\"" }) {
          return true
        }
      }
    case .expressionSegment:
      // Interpolation segments are handled by the '#' counting logic.
      break
    #if RESILIENT_LIBRARIES
    @unknown default:
      fatalError()
    #endif
    }
  }
  return false
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
