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
public enum TriviaPiece {
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

extension TriviaPiece: CustomDebugStringConvertible {
  /// Returns a description used by dump.
  public var debugDescription: String {
    return "TriviaPiece"
  }
}

/// A collection of leading or trailing trivia. This is the main data structure
/// for thinking about trivia.
public struct Trivia {
  let pieces: [TriviaPiece]

  /// Creates Trivia with the provided underlying pieces.
  public init(pieces: [TriviaPiece]) {
    self.pieces = pieces
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

extension Trivia: Equatable {}

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

extension TriviaPiece: Equatable {}

extension TriviaPiece {
  public var sourceLength: SourceLength {
    switch self {
    case let .spaces(count):
      return SourceLength(utf8Length: count)
    case let .tabs(count):
      return SourceLength(utf8Length: count)
    case let .verticalTabs(count):
      return SourceLength(utf8Length: count)
    case let .formfeeds(count):
      return SourceLength(utf8Length: count)
    case let .newlines(count):
      return SourceLength(utf8Length: count * 1)
    case let .carriageReturns(count):
      return SourceLength(utf8Length: count * 1)
    case let .carriageReturnLineFeeds(count):
      return SourceLength(utf8Length: count * 2)
    case let .backticks(count):
      return SourceLength(utf8Length: count)
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

extension TriviaPiece {
  static func fromRawValue(_ piece: CTriviaPiece,
                           textBuffer: UnsafeBufferPointer<UInt8>) -> TriviaPiece {
    switch piece.kind {
    case 0:
      return .spaces(Int(piece.length)/1)
    case 1:
      return .tabs(Int(piece.length)/1)
    case 2:
      return .verticalTabs(Int(piece.length)/1)
    case 3:
      return .formfeeds(Int(piece.length)/1)
    case 4:
      return .newlines(Int(piece.length)/1)
    case 5:
      return .carriageReturns(Int(piece.length)/1)
    case 6:
      return .carriageReturnLineFeeds(Int(piece.length)/2)
    case 7:
      return .backticks(Int(piece.length)/1)
    case 8:
      return .lineComment(.fromBuffer(textBuffer))
    case 9:
      return .blockComment(.fromBuffer(textBuffer))
    case 10:
      return .docLineComment(.fromBuffer(textBuffer))
    case 11:
      return .docBlockComment(.fromBuffer(textBuffer))
    case 12:
      return .garbageText(.fromBuffer(textBuffer))
    default:
      fatalError("unexpected trivia piece kind \(piece.kind)")
    }
  }

  static func hasText(kind: CTriviaKind) -> Bool {
    switch kind {
    case 0:
      return false
    case 1:
      return false
    case 2:
      return false
    case 3:
      return false
    case 4:
      return false
    case 5:
      return false
    case 6:
      return false
    case 7:
      return false
    case 8:
      return true
    case 9:
      return true
    case 10:
      return true
    case 11:
      return true
    case 12:
      return true
    default:
      fatalError("unexpected trivia piece kind \(kind)")
    }
  }
}

/// Plain trivia piece kind value, without an associated `String` value.
internal enum TriviaPieceKind: CTriviaKind {
    /// A space ' ' character.
    case spaces = 0
    /// A tab '\t' character.
    case tabs = 1
    /// A vertical tab '\v' character.
    case verticalTabs = 2
    /// A form-feed 'f' character.
    case formfeeds = 3
    /// A newline '\n' character.
    case newlines = 4
    /// A newline '\r' character.
    case carriageReturns = 5
    /// A newline consists of contiguous '\r' and '\n' characters.
    case carriageReturnLineFeeds = 6
    /// A backtick '`' character, used to escape identifiers.
    case backticks = 7
    /// A developer line comment, starting with '//'
    case lineComment = 8
    /// A developer block comment, starting with '/*' and ending with '*/'.
    case blockComment = 9
    /// A documentation line comment, starting with '///'.
    case docLineComment = 10
    /// A documentation block comment, starting with '/**' and ending with '*/'.
    case docBlockComment = 11
    /// Any skipped garbage text.
    case garbageText = 12

  static func fromRawValue(_ rawValue: CTriviaKind) -> TriviaPieceKind {
    return TriviaPieceKind(rawValue: rawValue)!
  }
}

extension TriviaPiece {
  internal func withUnsafeTriviaPiece<Result>(
    _ body: (UnsafeTriviaPiece) -> Result
  ) -> Result {
    switch self {
    case let .spaces(count):
      let length = count
      return body(.init(kind: .spaces, length: length))
    case let .tabs(count):
      let length = count
      return body(.init(kind: .tabs, length: length))
    case let .verticalTabs(count):
      let length = count
      return body(.init(kind: .verticalTabs, length: length))
    case let .formfeeds(count):
      let length = count
      return body(.init(kind: .formfeeds, length: length))
    case let .newlines(count):
      let length = count * 1
      return body(.init(kind: .newlines, length: length))
    case let .carriageReturns(count):
      let length = count * 1
      return body(.init(kind: .carriageReturns, length: length))
    case let .carriageReturnLineFeeds(count):
      let length = count * 2
      return body(.init(kind: .carriageReturnLineFeeds, length: length))
    case let .backticks(count):
      let length = count
      return body(.init(kind: .backticks, length: length))
    case var .lineComment(text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .lineComment, length: length, customText: buf))
      })!
    case var .blockComment(text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .blockComment, length: length, customText: buf))
      })!
    case var .docLineComment(text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .docLineComment, length: length, customText: buf))
      })!
    case var .docBlockComment(text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .docBlockComment, length: length, customText: buf))
      })!
    case var .garbageText(text):
      text.makeNativeUTF8IfNeeded()
      let length = text.utf8.count
      return text.utf8.withContiguousStorageIfAvailable({ (buf: UnsafeBufferPointer<UInt8>) in
        return body(.init(kind: .garbageText, length: length, customText: buf))
      })!
    }
  }
}
