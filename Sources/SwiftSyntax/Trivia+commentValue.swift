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
  /// The normalized contents of the documentation comment in this trivia.
  ///
  /// Returns the content of the last documentation comment block, which semantically represents
  /// "the one and only" documentation comment associated with this trivia. Comment markers are
  /// removed, common indentation is stripped, and line endings are normalized to `\n`.
  ///
  /// Returns `nil` if no documentation comment is present.
  public var docCommentValue: String? {
    var comments: [Substring] = []
    var currentLineComments: [String] = []  // Reset line comments when encountering a block comment
    var isInsideDocLineCommentSection = false
    var consecutiveNewlines = 0

    for piece in pieces {
      switch piece {
      case .docBlockComment(let text):
        if let processedComment = processBlockComment(text) {
          comments = [processedComment]
        }
        currentLineComments = []
        consecutiveNewlines = 0
      case .docLineComment(let text):
        if isInsideDocLineCommentSection {
          currentLineComments.append(text)
        } else {
          currentLineComments = [text]
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
    func processBlockComment(_ text: String) -> Substring? {
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

      // We canonicalize the line endings to `\n` here. This matches how we concatenate the different line comment
      // pieces using \n as well.
      return Substring(unindentedLines.joined(separator: "\n"))
    }

    /// Processes a section break, which is defined as a sequence of newlines or other trivia pieces that are not comments.
    func processSectionBreak() {
      // If we have a section break, we reset the current line comments.
      if !currentLineComments.isEmpty {
        comments = currentLineComments.map { $0[...] }
        currentLineComments = []
      }
      isInsideDocLineCommentSection = false
    }

    // If there are remaining line comments, use them as the last doc comment block.
    if !currentLineComments.isEmpty {
      comments = currentLineComments.map { $0[...] }
    }

    if comments.isEmpty { return nil }

    let prefix = comments.allSatisfy { $0.hasPrefix("/// ") } ? "/// " : "///"
    return comments.map { $0.dropPrefix(prefix) }.joined(separator: "\n")
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
