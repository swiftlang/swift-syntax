// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 6)
//// Automatically Generated From Trivia.swift.gyb.
//// Do Not Edit Directly!
//===------------------- Trivia.swift - Source Trivia Enum ----------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

/// A contiguous stretch of a single kind of trivia. The constituent part of
/// a `Trivia` collection.
///
/// For example, four spaces would be represented by
/// `.spaces(4)`
///
/// In general, you should deal with the actual Trivia collection instead
/// of individual pieces whenever possible.
public enum TriviaPiece: Codable {
  enum CodingKeys: CodingKey {
    case kind, value
  }
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let kind = try container.decode(String.self, forKey: .kind)
    switch kind {
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "Space":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 41)
      let value = try container.decode(Int.self, forKey: .value)
      self = .spaces(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "Tab":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 41)
      let value = try container.decode(Int.self, forKey: .value)
      self = .tabs(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "VerticalTab":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 41)
      let value = try container.decode(Int.self, forKey: .value)
      self = .verticalTabs(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "Formfeed":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 41)
      let value = try container.decode(Int.self, forKey: .value)
      self = .formfeeds(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "Newline":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 41)
      let value = try container.decode(Int.self, forKey: .value)
      self = .newlines(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "CarriageReturn":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 41)
      let value = try container.decode(Int.self, forKey: .value)
      self = .carriageReturns(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "CarriageReturnLineFeed":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 41)
      let value = try container.decode(Int.self, forKey: .value)
      self = .carriageReturnLineFeeds(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "Backtick":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 41)
      let value = try container.decode(Int.self, forKey: .value)
      self = .backticks(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "LineComment":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 44)
      let value = try container.decode(String.self, forKey: .value)
      self = .lineComment(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "BlockComment":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 44)
      let value = try container.decode(String.self, forKey: .value)
      self = .blockComment(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "DocLineComment":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 44)
      let value = try container.decode(String.self, forKey: .value)
      self = .docLineComment(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "DocBlockComment":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 44)
      let value = try container.decode(String.self, forKey: .value)
      self = .docBlockComment(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 39)
    case "GarbageText":
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 44)
      let value = try container.decode(String.self, forKey: .value)
      self = .garbageText(value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 48)
    default:
      let context =
        DecodingError.Context(codingPath: [CodingKeys.kind],
                              debugDescription: "invalid TriviaPiece kind \(kind)")
      throw DecodingError.valueNotFound(String.self, context)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    switch self {
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 61)
    case .spaces(let count):
      try container.encode("Space", forKey: .kind)
      try container.encode(count, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 61)
    case .tabs(let count):
      try container.encode("Tab", forKey: .kind)
      try container.encode(count, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 61)
    case .verticalTabs(let count):
      try container.encode("VerticalTab", forKey: .kind)
      try container.encode(count, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 61)
    case .formfeeds(let count):
      try container.encode("Formfeed", forKey: .kind)
      try container.encode(count, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 61)
    case .newlines(let count):
      try container.encode("Newline", forKey: .kind)
      try container.encode(count, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 61)
    case .carriageReturns(let count):
      try container.encode("CarriageReturn", forKey: .kind)
      try container.encode(count, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 61)
    case .carriageReturnLineFeeds(let count):
      try container.encode("CarriageReturnLineFeed", forKey: .kind)
      try container.encode(count, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 61)
    case .backticks(let count):
      try container.encode("Backtick", forKey: .kind)
      try container.encode(count, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 65)
    case .lineComment(let text):
      try container.encode("LineComment", forKey: .kind)
      try container.encode(text, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 65)
    case .blockComment(let text):
      try container.encode("BlockComment", forKey: .kind)
      try container.encode(text, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 65)
    case .docLineComment(let text):
      try container.encode("DocLineComment", forKey: .kind)
      try container.encode(text, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 65)
    case .docBlockComment(let text):
      try container.encode("DocBlockComment", forKey: .kind)
      try container.encode(text, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 65)
    case .garbageText(let text):
      try container.encode("GarbageText", forKey: .kind)
      try container.encode(text, forKey: .value)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 70)
    }
  }

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A space ' ' character.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 76)
    case spaces(Int)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A tab '\t' character.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 76)
    case tabs(Int)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A vertical tab '\v' character.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 76)
    case verticalTabs(Int)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A form-feed 'f' character.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 76)
    case formfeeds(Int)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A newline '\n' character.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 76)
    case newlines(Int)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A newline '\r' character.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 76)
    case carriageReturns(Int)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A newline consists of contiguous '\r' and '\n' characters.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 76)
    case carriageReturnLineFeeds(Int)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A backtick '`' character, used to escape identifiers.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 76)
    case backticks(Int)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A developer line comment, starting with '//'
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 78)
    case lineComment(String)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A developer block comment, starting with '/*' and ending with '*/'.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 78)
    case blockComment(String)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A documentation line comment, starting with '///'.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 78)
    case docLineComment(String)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// A documentation block comment, starting with '/**' and ending with '*/'.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 78)
    case docBlockComment(String)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 74)
    /// Any skipped garbage text.
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 78)
    case garbageText(String)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 81)
}

extension TriviaPiece: TextOutputStreamable {
  /// Prints the provided trivia as they would be written in a source file.
  ///
  /// - Parameter stream: The stream to which to print the trivia.
  public func write<Target>(to target: inout Target)
    where Target: TextOutputStream {
    func printRepeated(_ character: String, count: Int) {
      for _ in 0..<count { target.write(character) }
    }
    switch self {
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 96)
    case let .spaces(count):
      printRepeated(" ", count: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 96)
    case let .tabs(count):
      printRepeated("\t", count: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 96)
    case let .verticalTabs(count):
      printRepeated("\u{2B7F}", count: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 96)
    case let .formfeeds(count):
      printRepeated("\u{240C}", count: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 96)
    case let .newlines(count):
      printRepeated("\n", count: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 96)
    case let .carriageReturns(count):
      printRepeated("\r", count: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 96)
    case let .carriageReturnLineFeeds(count):
      printRepeated("\r\n", count: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 96)
    case let .backticks(count):
      printRepeated("`", count: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 99)
    case let .lineComment(text):
      target.write(text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 99)
    case let .blockComment(text):
      target.write(text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 99)
    case let .docLineComment(text):
      target.write(text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 99)
    case let .docBlockComment(text):
      target.write(text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 99)
    case let .garbageText(text):
      target.write(text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 103)
    }
  }
}

/// A collection of leading or trailing trivia. This is the main data structure
/// for thinking about trivia.
public struct Trivia: Codable {
  let pieces: [TriviaPiece]

  /// Creates Trivia with the provided underlying pieces.
  public init(pieces: [TriviaPiece]) {
    self.pieces = pieces
  }

  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    var pieces = [TriviaPiece]()
    while let piece = try container.decodeIfPresent(TriviaPiece.self) {
      pieces.append(piece)
    }
    self.pieces = pieces
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    for piece in pieces {
      try container.encode(piece)
    }
  }

  /// Creates Trivia with no pieces.
  public static var zero: Trivia {
    return Trivia(pieces: [])
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

// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 157)
    /// Return a piece of trivia for some number of ' ' characters.
    public static func spaces(_ count: Int) -> Trivia {
      return [.spaces(count)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 157)
    /// Return a piece of trivia for some number of '\t' characters.
    public static func tabs(_ count: Int) -> Trivia {
      return [.tabs(count)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 157)
    /// Return a piece of trivia for some number of '\u{2B7F}' characters.
    public static func verticalTabs(_ count: Int) -> Trivia {
      return [.verticalTabs(count)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 157)
    /// Return a piece of trivia for some number of '\u{240C}' characters.
    public static func formfeeds(_ count: Int) -> Trivia {
      return [.formfeeds(count)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 157)
    /// Return a piece of trivia for some number of '\n' characters.
    public static func newlines(_ count: Int) -> Trivia {
      return [.newlines(count)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 157)
    /// Return a piece of trivia for some number of '\r' characters.
    public static func carriageReturns(_ count: Int) -> Trivia {
      return [.carriageReturns(count)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 157)
    /// Return a piece of trivia for some number of '\r\n' characters.
    public static func carriageReturnLineFeeds(_ count: Int) -> Trivia {
      return [.carriageReturnLineFeeds(count)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 157)
    /// Return a piece of trivia for some number of '`' characters.
    public static func backticks(_ count: Int) -> Trivia {
      return [.backticks(count)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 162)
    /// Return a piece of trivia for LineComment.
    public static func lineComment(_ text: String) -> Trivia {
      return [.lineComment(text)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 162)
    /// Return a piece of trivia for BlockComment.
    public static func blockComment(_ text: String) -> Trivia {
      return [.blockComment(text)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 162)
    /// Return a piece of trivia for DocLineComment.
    public static func docLineComment(_ text: String) -> Trivia {
      return [.docLineComment(text)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 162)
    /// Return a piece of trivia for DocBlockComment.
    public static func docBlockComment(_ text: String) -> Trivia {
      return [.docBlockComment(text)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 162)
    /// Return a piece of trivia for GarbageText.
    public static func garbageText(_ text: String) -> Trivia {
      return [.garbageText(text)]
    }
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 168)
}

/// Conformance for Trivia to the Collection protocol.
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

/// Concatenates two collections of `Trivia` into one collection.
public func +(lhs: Trivia, rhs: Trivia) -> Trivia {
  return Trivia(pieces: lhs.pieces + rhs.pieces)
}

extension TriviaPiece {
  public var sourceLength: SourceLength {
    switch self {
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 211)
    case let .spaces(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 211)
    case let .tabs(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 211)
    case let .verticalTabs(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 211)
    case let .formfeeds(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 207)
    case let .newlines(count):
      return SourceLength(newlines: count, columnsAtLastLine: 0, 
                          utf8Length: count * 1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 207)
    case let .carriageReturns(count):
      return SourceLength(newlines: count, columnsAtLastLine: 0, 
                          utf8Length: count * 1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 207)
    case let .carriageReturnLineFeeds(count):
      return SourceLength(newlines: count, columnsAtLastLine: 0, 
                          utf8Length: count * 2)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 211)
    case let .backticks(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 215)
    case let .lineComment(text):
      return SourceLength(of: text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 215)
    case let .blockComment(text):
      return SourceLength(of: text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 215)
    case let .docLineComment(text):
      return SourceLength(of: text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 215)
    case let .docBlockComment(text):
      return SourceLength(of: text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 215)
    case let .garbageText(text):
      return SourceLength(of: text)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 219)
    }
  }
}

extension Trivia: ByteTreeObjectDecodable {
  static func read(from reader: UnsafeMutablePointer<ByteTreeObjectReader>, 
                   numFields: Int, 
                   userInfo: UnsafePointer<[ByteTreeUserInfoKey: Any]>
  ) throws -> Trivia {
    let pieces = try [TriviaPiece].read(from: reader, numFields: numFields,
                                        userInfo: userInfo)
    return Trivia(pieces: pieces)
  }
}

extension TriviaPiece: ByteTreeObjectDecodable {
  static func read(from reader: UnsafeMutablePointer<ByteTreeObjectReader>, 
                   numFields: Int, 
                   userInfo: UnsafePointer<[ByteTreeUserInfoKey: Any]>
  ) throws -> TriviaPiece {
    let kind = try reader.pointee.readField(UInt8.self, index: 0)
    switch kind {
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 0:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 244)
      let count = Int(try reader.pointee.readField(UInt32.self, index: 1))
      return .spaces(count)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 1:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 244)
      let count = Int(try reader.pointee.readField(UInt32.self, index: 1))
      return .tabs(count)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 2:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 244)
      let count = Int(try reader.pointee.readField(UInt32.self, index: 1))
      return .verticalTabs(count)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 3:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 244)
      let count = Int(try reader.pointee.readField(UInt32.self, index: 1))
      return .formfeeds(count)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 4:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 244)
      let count = Int(try reader.pointee.readField(UInt32.self, index: 1))
      return .newlines(count)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 5:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 244)
      let count = Int(try reader.pointee.readField(UInt32.self, index: 1))
      return .carriageReturns(count)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 6:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 244)
      let count = Int(try reader.pointee.readField(UInt32.self, index: 1))
      return .carriageReturnLineFeeds(count)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 7:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 244)
      let count = Int(try reader.pointee.readField(UInt32.self, index: 1))
      return .backticks(count)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 8:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 247)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .lineComment(text)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 9:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 247)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .blockComment(text)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 10:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 247)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .docLineComment(text)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 11:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 247)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .docBlockComment(text)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 242)
    case 12:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 247)
      let text = try reader.pointee.readField(String.self, index: 1)
      return .garbageText(text)      
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 251)
    default:
      throw ByteTreeDecodingError.invalidEnumRawValue(type: "\(self)", 
                                                      value: Int(kind))
    }
  }
}

extension TriviaPiece {
  static func fromRawValue(kind: CTriviaKind, length: Int,
                           text: Substring) throws -> TriviaPiece {
    switch kind {
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 0:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 265)
      return .spaces(length/1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 1:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 265)
      return .tabs(length/1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 2:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 265)
      return .verticalTabs(length/1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 3:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 265)
      return .formfeeds(length/1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 4:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 265)
      return .newlines(length/1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 5:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 265)
      return .carriageReturns(length/1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 6:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 265)
      return .carriageReturnLineFeeds(length/2)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 7:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 265)
      return .backticks(length/1)
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 8:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 267)
      return .lineComment(String(text))
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 9:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 267)
      return .blockComment(String(text))
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 10:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 267)
      return .docLineComment(String(text))
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 11:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 267)
      return .docBlockComment(String(text))
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 263)
    case 12:
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 267)
      return .garbageText(String(text))
// ###sourceLocation(file: "/Users/argiris/proj/opensource/swift-syntax/Sources/SwiftSyntax/Trivia.swift.gyb", line: 270)
    default:
      throw ByteTreeDecodingError.invalidEnumRawValue(type: "\(self)",
                                                      value: Int(kind))
    }
  }
}
