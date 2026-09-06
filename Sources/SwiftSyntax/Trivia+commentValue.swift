//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

extension Trivia {
  /// A single output line of a documentation comment's normalized content,
  /// together with the absolute position of that line's first character in
  /// the original source.
  @_spi(SourceKitLSP)
  public struct DocCommentLine {
    /// The normalized text of this line — identical to the corresponding
    /// line `docCommentValue` would produce.
    public let text: Substring
    /// The absolute position of `text`'s first character.
    public let position: AbsolutePosition
  }

  /// The normalized contents of the documentation comment in this trivia.
  ///
  /// Returns the content of the last documentation comment block, which semantically represents
  /// "the one and only" documentation comment associated with this trivia. Comment markers are
  /// removed, common indentation is stripped, and line endings are normalized to `\n`.
  ///
  /// Returns `nil` if no documentation comment is present.
  public var docCommentValue: String? {
    extractDocCommentLines(tokenStart: AbsolutePosition(utf8Offset: 0))?
      .map { String($0.text) }
      .joined(separator: "\n")
  }

  /// Same normalization as `docCommentValue`, but additionally returns the
  /// absolute source position of each resulting line.
  ///
  /// - Parameter tokenStart: The absolute position of the first trivia piece
  ///   in this `Trivia` (e.g. a token's `position` for leading trivia, or its
  ///   `endPositionBeforeTrailingTrivia` for trailing trivia).
  @_spi(SourceKitLSP)
  public func docCommentLines(startingAt tokenStart: AbsolutePosition) -> [DocCommentLine]? {
    extractDocCommentLines(tokenStart: tokenStart)
  }

  /// One doc-comment "entry" as encountered while walking trivia pieces: either a single
  /// raw `///` line, or an entire (possibly multi-line) `/**...*/` block.
  /// A block comment is stripped as a single unit, only ever affecting its
  /// first line, never lines inside it.
  private struct CommentEntry {
    /// This entry's full text, exactly as `docCommentValue` would see it before the
    /// final prefix strip (used only to decide/apply that strip).
    var wholeText: Substring
    /// The individual output lines that make up `wholeText`, with their absolute positions.
    /// For a `///` line this has exactly one element (identical to `wholeText`); for a
    /// `/**...*/` block this has one element per line inside the block.
    var lines: [DocCommentLine]
  }

  /// Shared implementation behind `docCommentValue` and `docCommentLines(startingAt:)`.
  /// Positions are computed unconditionally
  private func extractDocCommentLines(tokenStart: AbsolutePosition) -> [DocCommentLine]? {
    var comments: [CommentEntry] = []
    var currentLineComments: [CommentEntry] = []
    var isInsideDocLineCommentSection = false
    var consecutiveNewlines = 0
    var offset = 0  // UTF-8 byte offset from tokenStart, i.e. from the start of `pieces`

    for piece in pieces {
      defer { offset += piece.sourceLength.utf8Length }

      switch piece {
      case .docBlockComment(let text):
        let pieceStart = AbsolutePosition(utf8Offset: tokenStart.utf8Offset + offset)
        if let entry = processBlockComment(text, pieceStart: pieceStart) {
          comments = [entry]
        }
        currentLineComments = []
        consecutiveNewlines = 0
      case .docLineComment(let text):
        let position = AbsolutePosition(utf8Offset: tokenStart.utf8Offset + offset)
        let entry = CommentEntry(wholeText: text[...], lines: [DocCommentLine(text: text[...], position: position)])
        if isInsideDocLineCommentSection {
          currentLineComments.append(entry)
        } else {
          currentLineComments = [entry]
          isInsideDocLineCommentSection = true
        }
        consecutiveNewlines = 0

      case .newlines(let n), .carriageReturns(let n), .carriageReturnLineFeeds(let n):
        consecutiveNewlines += n

        if consecutiveNewlines != 1 {
          processSectionBreak()
          consecutiveNewlines = 0
        }
      default:
        processSectionBreak()
        consecutiveNewlines = 0
      }
    }

    /// Strips /** */ markers and removes any common indentation between the lines in the block comment.
    func processBlockComment(_ text: String, pieceStart: AbsolutePosition) -> CommentEntry? {
      var lines = text.dropPrefix("/**").dropSuffix("*/")
        .split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)

      // If the comment content starts on the same line as the `/**` marker or ends on the same line as the `*/` marker,
      // it is common to separate the marker and the actual comment using spaces. Strip those spaces if they exists.
      // If there are non no-space characters on the first / last line, then the comment doesn't start / end on the line
      // with the marker, so don't do the stripping.
      if let firstLine = lines.first, firstLine.contains(where: { $0 != " " }) {
        lines[0] = firstLine.drop { $0 == " " }
      }
      if let lastLine = lines.last, lastLine.contains(where: { $0 != " " }) {
        lines[lines.count - 1] = lastLine.dropLast { $0 == " " }
      }

      // Find the lowest indentation that is common among all lines in the block comment. Do not consider the first line
      // because it won't have any indentation since it starts with /**
      let indentation = lines.dropFirst()
        .map { $0.prefix(while: { $0 == " " || $0 == "\t" }) }
        .reduce(nil as Substring?) { (acc: Substring?, element: Substring) in
          guard let acc else {
            return element
          }
          return commonPrefix(acc, element)
        }

      guard let firstLine = lines.first else {
        // We did not have any lines. This should never happen in practice because `split` never returns an empty array
        // but be safe and return `nil` here anyway.
        return nil
      }

      var unindentedLines = [firstLine] + lines.dropFirst().map { $0.dropPrefix(indentation ?? "") }

      // If the first line only contained the comment marker, don't include it. We don't want to start the comment value
      // with a newline if `/**` is on its own line. Same for the end marker.
      if unindentedLines.first?.allSatisfy({ $0 == " " }) ?? false {
        unindentedLines.removeFirst()
      }
      if unindentedLines.last?.allSatisfy({ $0 == " " }) ?? false {
        unindentedLines.removeLast()
      }

      // Each line here is still a Substring sharing storage with the original `text`, so its
      // `startIndex` is a valid UTF-8 offset into `text` even after dropFirst/split/dedent.
      let lineInfos = unindentedLines.map { line -> DocCommentLine in
        let lineOffset = text.utf8.distance(from: text.utf8.startIndex, to: line.startIndex)
        return DocCommentLine(text: line, position: AbsolutePosition(utf8Offset: pieceStart.utf8Offset + lineOffset))
      }

      // We canonicalize the line endings to `\n` here. This matches how we concatenate the different line comment
      // pieces using \n as well.
      let joined = Substring(unindentedLines.joined(separator: "\n"))
      return CommentEntry(wholeText: joined, lines: lineInfos)
    }

    /// Processes a section break, which is defined as a sequence of newlines or other trivia pieces that are not comments.
    func processSectionBreak() {
      // If we have a section break, we reset the current line comments.
      if !currentLineComments.isEmpty {
        comments = currentLineComments
        currentLineComments = []
      }
      isInsideDocLineCommentSection = false
    }

    // If there are remaining line comments, use them as the last doc comment block.
    if !currentLineComments.isEmpty {
      comments = currentLineComments
    }

    if comments.isEmpty { return nil }

    let prefix = comments.allSatisfy { $0.wholeText.hasPrefix("/// ") } ? "/// " : "///"

    // Apply the prefix strip per entry, then flatten each entry's stored lines into the final output.
    // For a multi-line block comment entry, the strip can only ever affect line 0, since it only ever touches the
    // very start of `wholeText` — lines 1..n of a block are always passed through unchanged.
    return comments.flatMap { entry -> [DocCommentLine] in
      guard entry.wholeText.hasPrefix(prefix) else {
        return entry.lines.map { DocCommentLine(text: $0.text, position: $0.position) }
      }
      return entry.lines.enumerated().map { index, line in
        guard index == 0 else {
          return DocCommentLine(text: line.text, position: line.position)
        }
        return DocCommentLine(
          text: line.text.dropFirst(prefix.count),
          position: AbsolutePosition(utf8Offset: line.position.utf8Offset + prefix.utf8.count)
        )
      }
    }
  }
}

fileprivate extension StringProtocol where SubSequence == Substring {
  func dropPrefix(_ prefix: some StringProtocol) -> Substring {
    if self.hasPrefix(prefix) {
      return self.dropFirst(prefix.count)
    }
    return self[...]
  }

  func dropSuffix(_ suffix: some StringProtocol) -> Substring {
    if self.hasSuffix(suffix) {
      return self.dropLast(suffix.count)
    }
    return self[...]
  }

  func dropLast(while predicate: (Self.Element) -> Bool) -> Self.SubSequence {
    let charactersToDrop = self.reversed().prefix(while: predicate)
    return self.dropLast(charactersToDrop.count)
  }
}

private func commonPrefix(_ lhs: Substring, _ rhs: Substring) -> Substring {
  return lhs[..<lhs.index(lhs.startIndex, offsetBy: zip(lhs, rhs).prefix { $0 == $1 }.count)]
}
