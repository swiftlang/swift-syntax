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
  /// The contents of the last doc comment piece with any comment markers removed and indentation whitespace stripped.
  public var docCommentValue: String? {
    var comments: [Substring] = []

    /// Keep track of whether we have seen a line or block comment trivia piece.
    var hasBlockComment = false

    // Determine if all line comments have a space separating the `///` comment marker and the actual comment.
    lazy var allLineCommentsHaveSpace: Bool = pieces.allSatisfy { piece in
      switch piece {
      case .docLineComment(let text): return text.hasPrefix("/// ")
      default: return true
      }
    }

    // Strips /** */ markers and removes any common indentation between the lines in the block comment.
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

      var indentation: Substring? = nil
      // Find the lowest indentation that is common among all lines in the block comment. Do not consider the first line
      // because it won't have any indentation since it starts with /**
      for line in lines.dropFirst() {
        let lineIndentation = line.prefix(while: { $0 == " " || $0 == "\t" })
        guard let previousIndentation = indentation else {
          indentation = lineIndentation
          continue
        }
        indentation = commonPrefix(previousIndentation, lineIndentation)
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
      return unindentedLines.joined(separator: "\n")[...]
    }

    var currentLineComments: [Substring] = []
    var foundStop = false
    for piece in pieces {
      switch piece {
      case .docBlockComment(let text):
        if let processedComment = processBlockComment(text) {
          if hasBlockComment {
            comments.append(processedComment)
          } else {
            hasBlockComment = true
            comments = [processedComment]
          }
        }
        currentLineComments = [] // Reset line comments when encountering a block comment
      case .docLineComment(let text):
        let prefixToDrop = ("///") + (allLineCommentsHaveSpace ? " " : "")
        if foundStop {
          currentLineComments = [text.dropPrefix(prefixToDrop)]
          foundStop = false
        } else {
          currentLineComments.append(text.dropPrefix(prefixToDrop))
        }
      case .newlines(let count) where count == 1:
        continue
      default:
        if !currentLineComments.isEmpty {
          comments = currentLineComments
        }
        currentLineComments = []
        foundStop = true
      }
    }

    // If there are remaining line comments, use them as the last doc comment block.
    if !currentLineComments.isEmpty {
      comments = currentLineComments
    }

    if comments.isEmpty { return nil }
    return comments.joined(separator: "\n")
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
    let dropLength = self.reversed().prefix(while: predicate)
    return self.dropLast(dropLength.count)
  }
}

fileprivate func commonPrefix(_ lhs: Substring, _ rhs: Substring) -> Substring {
  return lhs[..<lhs.index(lhs.startIndex, offsetBy: zip(lhs, rhs).prefix { $0 == $1 }.count)]
}
