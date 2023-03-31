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

  /// Creates Trivia with no pieces.
  public static var zero: Trivia {
    return Trivia(pieces: [])
  }

  /// Whether the Trivia contains no pieces.
  public var isEmpty: Bool {
    pieces.isEmpty
  }

  /// Creates a new `Trivia` by appending the provided `TriviaPiece` to the end.
  public func appending(_ piece: TriviaPiece) -> Trivia {
    var copy = pieces
    copy.append(piece)
    return Trivia(pieces: copy)
  }

  public var sourceLength: SourceLength {
    return pieces.map({ $0.sourceLength }).reduce(.zero, +)
  }

  /// Get the byteSize of this trivia
  public var byteSize: Int {
    return sourceLength.utf8Length
  }

  /// Concatenates two collections of `Trivia` into one collection.
  public static func +(lhs: Trivia, rhs: Trivia) -> Trivia {
    return Trivia(pieces: lhs.pieces + rhs.pieces)
  }

  /// Concatenates two collections of `Trivia` into the left-hand side.
  public static func +=(lhs: inout Trivia, rhs: Trivia) {
    lhs = lhs + rhs
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

extension TriviaPiece {
  /// Returns true if the trivia is `.newlines`, `.carriageReturns` or `.carriageReturnLineFeeds`
  public var isNewline: Bool {
    switch self {
    case .newlines,
        .carriageReturns,
        .carriageReturnLineFeeds:
      return true
    default:
      return false
    }
  }
}

extension RawTriviaPiece {
  /// Returns true if the trivia is `.newlines`, `.carriageReturns` or `.carriageReturnLineFeeds`
  public var isNewline: Bool {
    switch self {
    case .newlines,
        .carriageReturns,
        .carriageReturnLineFeeds:
      return true
    default:
      return false
    }
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
