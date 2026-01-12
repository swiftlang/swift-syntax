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
    var comments: [String] = []
    var currentLineComments: [String] = []
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
          currentLineComments.append(text[...])
        } else {
          currentLineComments = [text[...]]
          isInsideDocLineCommentSection = true
        }
        consecutiveNewlines = 0

      case .newlines(let n), .carriageReturns(let n), .carriageReturnLineFeeds(let n):
        if n == 1 {
          consecutiveNewlines += 1
        } else {
          consecutiveNewlines = 0
        }

        if consecutiveNewlines != 1 {
          processSectionBreak()
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

      if let firstLine = lines.first, firstLine.contains(where: { $0 != " " }) {
        lines[0] = firstLine.drop { $0 == " " }
      }
      if let lastLine = lines.last, lastLine.contains(where: { $0 != " " }) {
        lines[lines.count - 1] = lastLine.dropLast { $0 == " " }
      }

      let indentation = lines.dropFirst()
        .map { $0.prefix(while: { $0 == " " || $0 == "\t" }) }
        .reduce(nil as Substring?) { (acc: Substring?, element: Substring.SubSequence) in
          acc.map { commonPrefix($0, element) } ?? element
        }

      guard let firstLine = lines.first else {
        return nil
      }

      var unindentedLines = [firstLine] + lines.dropFirst().map { $0.dropPrefix(indentation ?? "") }

      while unindentedLines.first?.allSatisfy({ $0 == " " }) == true {
        unindentedLines.removeFirst()
      }
      while unindentedLines.last?.allSatisfy({ $0 == " " }) == true {
        unindentedLines.removeLast()
      }

      return unindentedLines.joined(separator: "\n")
    }

    func processSectionBreak() {
      if !currentLineComments.isEmpty {
        comments = currentLineComments
        currentLineComments = []
      }
      isInsideDocLineCommentSection = false
    }

    if !currentLineComments.isEmpty {
      comments = currentLineComments
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

fileprivate func commonPrefix(_ lhs: Substring, _ rhs: Substring) -> Substring {
  return lhs[..<lhs.index(lhs.startIndex, offsetBy: zip(lhs, rhs).prefix { $0 == $1 }.count)]
}
