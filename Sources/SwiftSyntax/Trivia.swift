//===------------------- Trivia.swift - Source Trivia ---------------------===//
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

/// A collection of leading or trailing trivia. This is the main data structure
/// for thinking about trivia.
public struct Trivia {
  var pieces: [TriviaPiece]

  /// Creates Trivia with the provided underlying pieces.
  public init(pieces: [TriviaPiece]) {
    self.pieces = pieces
  }

  public init() {
    self.init(pieces: [])
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

  /// Get the byte count of this trivia
  public var byteLength: Int {
    return pieces.map({ $0.byteLength }).reduce(.zero, +)
  }

  @available(*, deprecated, renamed: "byteLength")
  public var byteSize: Int {
    byteLength
  }
}

extension Trivia: Equatable {}

/// Conformance for Trivia to the Collection protocol.
extension Trivia: RandomAccessCollection, RangeReplaceableCollection, MutableCollection {
  public var startIndex: Int {
    return pieces.startIndex
  }

  public var endIndex: Int {
    return pieces.endIndex
  }

  public subscript(_ index: Int) -> TriviaPiece {
    get { return pieces[index] }
    set { pieces[index] = newValue }
  }
}

extension Trivia: ExpressibleByArrayLiteral {
  /// Creates Trivia from the provided pieces.
  public init(arrayLiteral elements: TriviaPiece...) {
    self.pieces = elements
  }
}

/// Concatenates two collections of `Trivia` into one collection.
public func +(lhs: Trivia, rhs: Trivia) -> Trivia {
  return Trivia(pieces: lhs.pieces + rhs.pieces)
}
