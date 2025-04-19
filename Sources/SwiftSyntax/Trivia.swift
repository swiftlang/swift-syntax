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

public enum TriviaPosition {
  case leading
  case trailing
}

/// Trivia represent pieces of the source code that are not relevant to represent
/// its semantic structure.
///
/// The standard examples of trivia are spaces, newlines and comments.
///
/// The SwiftSyntax tree retains trivia to maintain round-tripness of the source
/// code, ensuring that printing the entire syntax tree be rendered back into
/// text that is byte-for-byte identical to the original source.
///
/// Each ``TokenSyntax`` can have multiple ``TriviaPiece``s as either leading or
/// trailing trivia, which occur before or after the token’s content, respectively.
/// ``Trivia`` represents a collection of these ``TriviaPiece``s
public struct Trivia: Sendable {
  /// The pieces this trivia consists of. Each ``TriviaPiece`` can represent
  /// multiple characters, such as an entire comment or 4 spaces.
  public let pieces: [TriviaPiece]

  /// Creates Trivia with the provided underlying pieces.
  public init(pieces: some Sequence<TriviaPiece>) {
    self.pieces = Array(pieces)
  }

  /// Whether the Trivia contains no pieces.
  public var isEmpty: Bool {
    pieces.isEmpty
  }

  /// The string contents of all the comment pieces with any comments tokens trimmed.
  public var commentValue: String? {
    var comments = [Substring]()
    var hasBlockComment = false
    var hasLineComment = false

    // Determine if all line comments have a single space
    lazy var allLineCommentsHaveSpace: Bool = {
      return pieces.allSatisfy { piece in
        switch piece {
        case .lineComment(let text):
          return text.hasPrefix("// ")
        case .docLineComment(let text):
          return text.hasPrefix("/// ")
        default:
          return true
        }
      }
    }()

    // Returns a substring with leading and trailing spaces removed.
    func trimWhitespace(_ text: Substring) -> Substring {
      let trimmed = text.drop(while: { $0 == " " })
      let reversed = trimmed.reversed()
      let trimmedEnd = reversed.drop(while: { $0 == " " })
      let final = trimmedEnd.reversed()
      return Substring(final)
    }

    // Strips /* */ markers and aligns content by removing common indentation.
    func processBlockComment(_ text: Substring) -> String {
      var lines = text.split(separator: "\n", omittingEmptySubsequences: false)

      let (minSpaceIndentation, minTabIndentation) =
        lines
        .dropFirst()
        .filter { !$0.isEmpty }
        .reduce((Int.max, Int.max)) { (currentMin, line) in
          var spaceCount = 0, tabCount = 0
          var inLeadingWhitespace = true

          for char in line {
            guard inLeadingWhitespace else { break }

            switch char {
            case " ":
              spaceCount += 1
            case "\t":
              tabCount += 1
            default:
              inLeadingWhitespace = false
            }
          }

          return (Swift.min(currentMin.0, spaceCount), Swift.min(currentMin.1, tabCount))
        }

      var minIndentation = minSpaceIndentation == Int.max ? 0 : minSpaceIndentation
      minIndentation += minTabIndentation == Int.max ? 0 : minTabIndentation

      if let first = lines.first {
        let prefixToDrop = first.hasPrefix("/**") ? 3 : 2
        lines[0] = first.dropFirst(prefixToDrop)
      }

      var firstLineRemoved = false
      if trimWhitespace(lines[0]).isEmpty {
        lines.removeFirst()
        firstLineRemoved = true
      }

      var unindentedLines = lines.enumerated().map { index, line -> Substring in
        if index == 0 && firstLineRemoved == false {
          return line
        }
        return line.count >= minIndentation ? line.dropFirst(minIndentation) : line
      }

      if let last = unindentedLines.last, last.hasSuffix("*/") {
        unindentedLines[unindentedLines.count - 1] = last.dropLast(2)
      }

      if trimWhitespace(unindentedLines[unindentedLines.count - 1]).isEmpty {
        unindentedLines.removeLast()
      }

      return unindentedLines.joined(separator: "\n")
    }

    for piece in pieces {
      switch piece {
      case .blockComment(let text), .docBlockComment(let text):
        if hasBlockComment || hasLineComment {
          return nil
        }
        hasBlockComment = true
        let processedText = processBlockComment(text[...])
        comments.append(processedText[...])

      case .lineComment(let text):
        if hasBlockComment {
          return nil
        }
        hasLineComment = true
        let prefix = allLineCommentsHaveSpace ? "// " : "//"
        comments.append(text.dropFirst(prefix.count))

      case .docLineComment(let text):
        if hasBlockComment {
          return nil
        }
        hasLineComment = true
        let prefix = allLineCommentsHaveSpace ? "/// " : "///"
        comments.append(text.dropFirst(prefix.count))

      default:
        break
      }
    }

    guard !comments.isEmpty else { return nil }

    // If we have multiple line comments, they can be joined with newlines
    if hasLineComment {
      return comments.joined(separator: "\n")
    }

    // In case of block comments, we should only have one
    return comments.first.map(String.init)
  }

  /// The length of all the pieces in this ``Trivia``.
  public var sourceLength: SourceLength {
    return pieces.map({ $0.sourceLength }).reduce(.zero, +)
  }

  /// Get the number of bytes this trivia needs to be represented as UTF-8.
  @available(*, deprecated, renamed: "sourceLength.utf8Length")
  public var byteSize: Int {
    return sourceLength.utf8Length
  }

  /// Creates a new ``Trivia`` by appending the provided ``TriviaPiece`` to the end.
  public func appending(_ piece: TriviaPiece) -> Trivia {
    var copy = pieces
    copy.append(piece)
    return Trivia(pieces: copy)
  }

  /// Creates a new ``Trivia`` by appending the given trivia to the end.
  public func appending(_ trivia: Trivia) -> Trivia {
    var copy = pieces
    copy.append(contentsOf: trivia.pieces)
    return Trivia(pieces: copy)
  }

  /// Creates a new ``Trivia`` by merging in the given trivia. Only includes one
  /// copy of a common prefix of `self` and `trivia`.
  public func merging(_ trivia: Trivia?) -> Trivia {
    guard let trivia else {
      return self
    }

    let lhs = self.decomposed
    let rhs = trivia.decomposed
    for infixLength in (0...Swift.min(lhs.count, rhs.count)).reversed() {
      if lhs.suffix(infixLength) == rhs.suffix(infixLength) {
        return lhs.appending(Trivia(pieces: Array(rhs.dropFirst(infixLength))))
      }
    }
    return lhs.appending(rhs)
  }

  /// Creates a new ``Trivia`` by merging the leading and trailing ``Trivia``
  /// of `triviaOf` into the end of `self`. Only includes one copy of any
  /// common prefixes.
  public func merging(triviaOf node: (some SyntaxProtocol)?) -> Trivia {
    guard let node else {
      return self
    }
    return merging(node.leadingTrivia).merging(node.trailingTrivia)
  }

  /// Concatenates two collections of ``Trivia`` into one collection.
  public static func + (lhs: Trivia, rhs: Trivia) -> Trivia {
    return lhs.appending(rhs)
  }

  /// Concatenates two collections of ``Trivia`` into the left-hand side.
  public static func += (lhs: inout Trivia, rhs: Trivia) {
    lhs = lhs.appending(rhs)
  }
}

extension Trivia: Equatable {}

extension Trivia: Collection {
  /// The index of the first ``TriviaPiece`` within this trivia.
  public var startIndex: Int {
    return pieces.startIndex
  }

  /// The index one after the last ``TriviaPiece`` within this trivia.
  public var endIndex: Int {
    return pieces.endIndex
  }

  /// The index of the trivia piece after the piece at `index`.
  public func index(after index: Int) -> Int {
    return pieces.index(after: index)
  }

  /// The ``TriviaPiece`` at `index`.
  public subscript(_ index: Int) -> TriviaPiece {
    return pieces[index]
  }
}

extension Trivia: ExpressibleByArrayLiteral {
  /// Creates Trivia from the provided pieces.
  public init(arrayLiteral elements: TriviaPiece...) {
    self.pieces = elements
  }
}

extension Trivia: TextOutputStreamable {
  /// Prints the provided trivia as they would be written in a source file.
  ///
  /// - Parameter stream: The stream to which to print the trivia.
  public func write(to stream: inout some TextOutputStream) {
    for piece in pieces {
      piece.write(to: &stream)
    }
  }
}

extension Trivia: CustomStringConvertible {
  /// The trivia’s representation in source code.
  public var description: String {
    var description = ""
    self.write(to: &description)
    return description
  }
}

extension Trivia: CustomDebugStringConvertible {
  /// A debug description that shows the individual trivia pieces.
  ///
  /// Do not rely on this output being stable.
  public var debugDescription: String {
    if count == 1, let first {
      return first.debugDescription
    }
    return "[" + map(\.debugDescription).joined(separator: ", ") + "]"
  }
}

extension Trivia {
  /// Decomposes the trivia into pieces that all have count 1
  @_spi(RawSyntax)
  public var decomposed: Trivia {
    let pieces = self.flatMap({ (piece: TriviaPiece) -> [TriviaPiece] in
      switch piece {
      case .spaces(let count):
        return Array(repeating: TriviaPiece.spaces(1), count: count)
      case .tabs(let count):
        return Array(repeating: TriviaPiece.tabs(1), count: count)
      case .verticalTabs(let count):
        return Array(repeating: TriviaPiece.verticalTabs(1), count: count)
      case .formfeeds(let count):
        return Array(repeating: TriviaPiece.formfeeds(1), count: count)
      case .newlines(let count):
        return Array(repeating: TriviaPiece.newlines(1), count: count)
      case .backslashes(let count):
        return Array(repeating: TriviaPiece.backslashes(1), count: count)
      case .pounds(let count):
        return Array(repeating: TriviaPiece.pounds(1), count: count)
      case .carriageReturns(let count):
        return Array(repeating: TriviaPiece.carriageReturns(1), count: count)
      case .carriageReturnLineFeeds(let count):
        return Array(repeating: TriviaPiece.carriageReturnLineFeeds(1), count: count)
      case .lineComment, .blockComment, .docLineComment, .docBlockComment, .unexpectedText:
        return [piece]
      }
    })
    return Trivia(pieces: pieces)
  }
}

extension RawTriviaPiece: TextOutputStreamable {
  /// Write the source representation of this trivia piece to `target`.
  public func write(to target: inout some TextOutputStream) {
    TriviaPiece(raw: self).write(to: &target)
  }
}

extension RawTriviaPiece: CustomDebugStringConvertible {
  /// A debug description of this trivia piece.
  ///
  /// Do not rely on this output being stable.
  public var debugDescription: String {
    TriviaPiece(raw: self).debugDescription
  }
}
