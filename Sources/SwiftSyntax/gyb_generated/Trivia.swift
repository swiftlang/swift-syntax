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
    case "Space":
      let value = try container.decode(Int.self, forKey: .value)
      self = .spaces(value)
    case "Tab":
      let value = try container.decode(Int.self, forKey: .value)
      self = .tabs(value)
    case "VerticalTab":
      let value = try container.decode(Int.self, forKey: .value)
      self = .verticalTabs(value)
    case "Formfeed":
      let value = try container.decode(Int.self, forKey: .value)
      self = .formfeeds(value)
    case "Newline":
      let value = try container.decode(Int.self, forKey: .value)
      self = .newlines(value)
    case "CarriageReturn":
      let value = try container.decode(Int.self, forKey: .value)
      self = .carriageReturns(value)
    case "CarriageReturnLineFeed":
      let value = try container.decode(Int.self, forKey: .value)
      self = .carriageReturnLineFeeds(value)
    case "Backtick":
      let value = try container.decode(Int.self, forKey: .value)
      self = .backticks(value)
    case "LineComment":
      let value = try container.decode(String.self, forKey: .value)
      self = .lineComment(value)
    case "BlockComment":
      let value = try container.decode(String.self, forKey: .value)
      self = .blockComment(value)
    case "DocLineComment":
      let value = try container.decode(String.self, forKey: .value)
      self = .docLineComment(value)
    case "DocBlockComment":
      let value = try container.decode(String.self, forKey: .value)
      self = .docBlockComment(value)
    case "GarbageText":
      let value = try container.decode(String.self, forKey: .value)
      self = .garbageText(value)
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
    case .spaces(let count):
      try container.encode("Space", forKey: .kind)
      try container.encode(count, forKey: .value)
    case .tabs(let count):
      try container.encode("Tab", forKey: .kind)
      try container.encode(count, forKey: .value)
    case .verticalTabs(let count):
      try container.encode("VerticalTab", forKey: .kind)
      try container.encode(count, forKey: .value)
    case .formfeeds(let count):
      try container.encode("Formfeed", forKey: .kind)
      try container.encode(count, forKey: .value)
    case .newlines(let count):
      try container.encode("Newline", forKey: .kind)
      try container.encode(count, forKey: .value)
    case .carriageReturns(let count):
      try container.encode("CarriageReturn", forKey: .kind)
      try container.encode(count, forKey: .value)
    case .carriageReturnLineFeeds(let count):
      try container.encode("CarriageReturnLineFeed", forKey: .kind)
      try container.encode(count, forKey: .value)
    case .backticks(let count):
      try container.encode("Backtick", forKey: .kind)
      try container.encode(count, forKey: .value)
    case .lineComment(let text):
      try container.encode("LineComment", forKey: .kind)
      try container.encode(text, forKey: .value)
    case .blockComment(let text):
      try container.encode("BlockComment", forKey: .kind)
      try container.encode(text, forKey: .value)
    case .docLineComment(let text):
      try container.encode("DocLineComment", forKey: .kind)
      try container.encode(text, forKey: .value)
    case .docBlockComment(let text):
      try container.encode("DocBlockComment", forKey: .kind)
      try container.encode(text, forKey: .value)
    case .garbageText(let text):
      try container.encode("GarbageText", forKey: .kind)
      try container.encode(text, forKey: .value)
    }
  }

    /// A space ' ' character.
    case spaces(Int)
    /// A tab '\t' character.
    case tabs(Int)
    /// A vertical tab '\v' character.
    case verticalTabs(Int)
    /// A form-feed 'f' character.
    case formfeeds(Int)
    /// A newline '\n' character.
    case newlines(Int)
    /// A newline '\r' character.
    case carriageReturns(Int)
    /// A newline consists of contiguous '\r' and '\n' characters.
    case carriageReturnLineFeeds(Int)
    /// A backtick '`' character, used to escape identifiers.
    case backticks(Int)
    /// A developer line comment, starting with '//'
    case lineComment(String)
    /// A developer block comment, starting with '/*' and ending with '*/'.
    case blockComment(String)
    /// A documentation line comment, starting with '///'.
    case docLineComment(String)
    /// A documentation block comment, starting with '/**' and ending with '*/'.
    case docBlockComment(String)
    /// Any skipped garbage text.
    case garbageText(String)
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
    case let .spaces(count):
      printRepeated(" ", count: count)
    case let .tabs(count):
      printRepeated("\t", count: count)
    case let .verticalTabs(count):
      printRepeated("\u{2B7F}", count: count)
    case let .formfeeds(count):
      printRepeated("\u{240C}", count: count)
    case let .newlines(count):
      printRepeated("\n", count: count)
    case let .carriageReturns(count):
      printRepeated("\r", count: count)
    case let .carriageReturnLineFeeds(count):
      printRepeated("\r\n", count: count)
    case let .backticks(count):
      printRepeated("`", count: count)
    case let .lineComment(text):
      target.write(text)
    case let .blockComment(text):
      target.write(text)
    case let .docLineComment(text):
      target.write(text)
    case let .docBlockComment(text):
      target.write(text)
    case let .garbageText(text):
      target.write(text)
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

    /// Return a piece of trivia for some number of ' ' characters.
    public static func spaces(_ count: Int) -> Trivia {
      return [.spaces(count)]
    }
    /// Return a piece of trivia for some number of '\t' characters.
    public static func tabs(_ count: Int) -> Trivia {
      return [.tabs(count)]
    }
    /// Return a piece of trivia for some number of '\u{2B7F}' characters.
    public static func verticalTabs(_ count: Int) -> Trivia {
      return [.verticalTabs(count)]
    }
    /// Return a piece of trivia for some number of '\u{240C}' characters.
    public static func formfeeds(_ count: Int) -> Trivia {
      return [.formfeeds(count)]
    }
    /// Return a piece of trivia for some number of '\n' characters.
    public static func newlines(_ count: Int) -> Trivia {
      return [.newlines(count)]
    }
    /// Return a piece of trivia for some number of '\r' characters.
    public static func carriageReturns(_ count: Int) -> Trivia {
      return [.carriageReturns(count)]
    }
    /// Return a piece of trivia for some number of '\r\n' characters.
    public static func carriageReturnLineFeeds(_ count: Int) -> Trivia {
      return [.carriageReturnLineFeeds(count)]
    }
    /// Return a piece of trivia for some number of '`' characters.
    public static func backticks(_ count: Int) -> Trivia {
      return [.backticks(count)]
    }
    /// Return a piece of trivia for LineComment.
    public static func lineComment(_ text: String) -> Trivia {
      return [.lineComment(text)]
    }
    /// Return a piece of trivia for BlockComment.
    public static func blockComment(_ text: String) -> Trivia {
      return [.blockComment(text)]
    }
    /// Return a piece of trivia for DocLineComment.
    public static func docLineComment(_ text: String) -> Trivia {
      return [.docLineComment(text)]
    }
    /// Return a piece of trivia for DocBlockComment.
    public static func docBlockComment(_ text: String) -> Trivia {
      return [.docBlockComment(text)]
    }
    /// Return a piece of trivia for GarbageText.
    public static func garbageText(_ text: String) -> Trivia {
      return [.garbageText(text)]
    }
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
    case let .spaces(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
    case let .tabs(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
    case let .verticalTabs(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
    case let .formfeeds(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
    case let .newlines(count):
      return SourceLength(newlines: count, columnsAtLastLine: 0, 
                          utf8Length: count * 1)
    case let .carriageReturns(count):
      return SourceLength(newlines: count, columnsAtLastLine: 0, 
                          utf8Length: count * 1)
    case let .carriageReturnLineFeeds(count):
      return SourceLength(newlines: count, columnsAtLastLine: 0, 
                          utf8Length: count * 2)
    case let .backticks(count):
      return SourceLength(newlines: 0, columnsAtLastLine: count, 
                          utf8Length: count)
    case let .lineComment(text):
      return SourceLength(of: text)
    case let .blockComment(text):
      return SourceLength(of: text)
    case let .docLineComment(text):
      return SourceLength(of: text)
    case let .docBlockComment(text):
      return SourceLength(of: text)
    case let .garbageText(text):
      return SourceLength(of: text)
    }
  }
}
