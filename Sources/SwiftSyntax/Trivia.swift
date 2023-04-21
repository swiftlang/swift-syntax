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

/// A collection of leading or trailing trivia. This is the main data structure
/// for thinking about trivia.
public struct Trivia {
  public let pieces: [TriviaPiece]

  /// Creates Trivia with the provided underlying pieces.
  public init<S: Sequence>(pieces: S) where S.Element == TriviaPiece {
    self.pieces = Array(pieces)
  }

  /// Whether the Trivia contains no pieces.
  public var isEmpty: Bool {
    pieces.isEmpty
  }

  public var sourceLength: SourceLength {
    return pieces.map({ $0.sourceLength }).reduce(.zero, +)
  }

  /// Get the byteSize of this trivia
  public var byteSize: Int {
    return sourceLength.utf8Length
  }

  /// Creates a new `Trivia` by appending the provided `TriviaPiece` to the end.
  public func appending(_ piece: TriviaPiece) -> Trivia {
    var copy = pieces
    copy.append(piece)
    return Trivia(pieces: copy)
  }

  /// Creates a new `Trivia` by appending the given trivia to the end.
  public func appending(_ trivia: Trivia) -> Trivia {
    var copy = pieces
    copy.append(contentsOf: trivia.pieces)
    return Trivia(pieces: copy)
  }

  /// Creates a new `Trivia` by merging in the given trivia. Only includes one
  /// copy of a common prefix of `self` and `trivia`.
  public func merging(_ trivia: Trivia) -> Trivia {
    let lhs = self.decomposed
    let rhs = trivia.decomposed
    for infixLength in (0...Swift.min(lhs.count, rhs.count)).reversed() {
      if lhs.suffix(infixLength) == rhs.suffix(infixLength) {
        return lhs.appending(Trivia(pieces: Array(rhs.dropFirst(infixLength))))
      }
    }
    return lhs.appending(rhs)
  }

  /// Creates a new `Trivia` by merging the leading and trailing `Trivia`
  /// of `triviaOf` into the end of `self`. Only includes one copy of any
  /// common prefixes.
  public func merging<T: SyntaxProtocol>(triviaOf node: T) -> Trivia {
    return merging(node.leadingTrivia).merging(node.trailingTrivia)
  }

  /// Concatenates two collections of `Trivia` into one collection.
  public static func + (lhs: Trivia, rhs: Trivia) -> Trivia {
    return lhs.appending(rhs)
  }

  /// Concatenates two collections of `Trivia` into the left-hand side.
  public static func += (lhs: inout Trivia, rhs: Trivia) {
    lhs = lhs.appending(rhs)
  }
}

extension Trivia: Equatable {}

extension Trivia: Collection {
  public var startIndex: Int {
    return pieces.startIndex
  }

  public var endIndex: Int {
    return pieces.endIndex
  }

  public func index(after i: Int) -> Int {
    return pieces.index(after: i)
  }

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
  public func write<Target>(to target: inout Target)
  where Target: TextOutputStream {
    for piece in pieces {
      piece.write(to: &target)
    }
  }
}

extension Trivia: CustomStringConvertible {
  public var description: String {
    var description = ""
    self.write(to: &description)
    return description
  }
}

extension Trivia: CustomDebugStringConvertible {
  public var debugDescription: String {
    if count == 1, let first = first {
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
      case .lineComment, .blockComment, .docLineComment, .docBlockComment, .unexpectedText, .shebang:
        return [piece]
      }
    })
    return Trivia(pieces: pieces)
  }
}

extension RawTriviaPiece: TextOutputStreamable {
  public func write<Target: TextOutputStream>(to target: inout Target) {
    TriviaPiece(raw: self).write(to: &target)
  }
}

extension RawTriviaPiece: CustomDebugStringConvertible {
  public var debugDescription: String {
    TriviaPiece(raw: self).debugDescription
  }
}
