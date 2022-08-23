//// Automatically Generated From Trivia.swift.gyb.
//// Do Not Edit Directly!
//===------------------- Trivia.swift - Source Trivia Enum ----------------===//
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

public enum TriviaPosition {
  case leading
  case trailing
}

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
    /// A developer line comment, starting with '//'
    case lineComment(String)
    /// A developer block comment, starting with '/*' and ending with '*/'.
    case blockComment(String)
    /// A documentation line comment, starting with '///'.
    case docLineComment(String)
    /// A documentation block comment, starting with '/**' and ending with '*/'.
    case docBlockComment(String)
    /// Any skipped unexpected text.
    case unexpectedText(String)
    /// A script command, starting with '#!'.
    case shebang(String)
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
    case let .lineComment(text):
      target.write(text)
    case let .blockComment(text):
      target.write(text)
    case let .docLineComment(text):
      target.write(text)
    case let .docBlockComment(text):
      target.write(text)
    case let .unexpectedText(text):
      target.write(text)
    case let .shebang(text):
      target.write(text)
    }
  }
}

extension TriviaPiece: CustomDebugStringConvertible {
  /// Returns a description used by dump.
  public var debugDescription: String {
    switch self {
    case .spaces(let data):
      return "spaces(\(data))"
    case .tabs(let data):
      return "tabs(\(data))"
    case .verticalTabs(let data):
      return "verticalTabs(\(data))"
    case .formfeeds(let data):
      return "formfeeds(\(data))"
    case .newlines(let data):
      return "newlines(\(data))"
    case .carriageReturns(let data):
      return "carriageReturns(\(data))"
    case .carriageReturnLineFeeds(let data):
      return "carriageReturnLineFeeds(\(data))"
    case .lineComment(let name):
      return "lineComment(\(name.debugDescription))"
    case .blockComment(let name):
      return "blockComment(\(name.debugDescription))"
    case .docLineComment(let name):
      return "docLineComment(\(name.debugDescription))"
    case .docBlockComment(let name):
      return "docBlockComment(\(name.debugDescription))"
    case .unexpectedText(let name):
      return "unexpectedText(\(name.debugDescription))"
    case .shebang(let name):
      return "shebang(\(name.debugDescription))"
    }
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

/// A collection of leading or trailing trivia. This is the main data structure
/// for thinking about trivia.
public struct Trivia {
  public let pieces: [TriviaPiece]

  /// Creates Trivia with the provided underlying pieces.
  public init(pieces: [TriviaPiece]) {
    self.pieces = pieces
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

  /// Returns a piece of trivia for some number of ' ' characters.
  public static func spaces(_ count: Int) -> Trivia {
    return [.spaces(count)]
  }

  /// Gets a piece of trivia for ' ' characters.
  public static var space: Trivia {
    return .spaces(1)
  }

  /// Returns a piece of trivia for some number of '\t' characters.
  public static func tabs(_ count: Int) -> Trivia {
    return [.tabs(count)]
  }

  /// Gets a piece of trivia for '\t' characters.
  public static var tab: Trivia {
    return .tabs(1)
  }

  /// Returns a piece of trivia for some number of '\u{2B7F}' characters.
  public static func verticalTabs(_ count: Int) -> Trivia {
    return [.verticalTabs(count)]
  }

  /// Gets a piece of trivia for '\u{2B7F}' characters.
  public static var verticalTab: Trivia {
    return .verticalTabs(1)
  }

  /// Returns a piece of trivia for some number of '\u{240C}' characters.
  public static func formfeeds(_ count: Int) -> Trivia {
    return [.formfeeds(count)]
  }

  /// Gets a piece of trivia for '\u{240C}' characters.
  public static var formfeed: Trivia {
    return .formfeeds(1)
  }

  /// Returns a piece of trivia for some number of '\n' characters.
  public static func newlines(_ count: Int) -> Trivia {
    return [.newlines(count)]
  }

  /// Gets a piece of trivia for '\n' characters.
  public static var newline: Trivia {
    return .newlines(1)
  }

  /// Returns a piece of trivia for some number of '\r' characters.
  public static func carriageReturns(_ count: Int) -> Trivia {
    return [.carriageReturns(count)]
  }

  /// Gets a piece of trivia for '\r' characters.
  public static var carriageReturn: Trivia {
    return .carriageReturns(1)
  }

  /// Returns a piece of trivia for some number of '\r\n' characters.
  public static func carriageReturnLineFeeds(_ count: Int) -> Trivia {
    return [.carriageReturnLineFeeds(count)]
  }

  /// Gets a piece of trivia for '\r\n' characters.
  public static var carriageReturnLineFeed: Trivia {
    return .carriageReturnLineFeeds(1)
  }

  /// Returns a piece of trivia for LineComment.
  public static func lineComment(_ text: String) -> Trivia {
    return [.lineComment(text)]
  }

  /// Returns a piece of trivia for BlockComment.
  public static func blockComment(_ text: String) -> Trivia {
    return [.blockComment(text)]
  }

  /// Returns a piece of trivia for DocLineComment.
  public static func docLineComment(_ text: String) -> Trivia {
    return [.docLineComment(text)]
  }

  /// Returns a piece of trivia for DocBlockComment.
  public static func docBlockComment(_ text: String) -> Trivia {
    return [.docBlockComment(text)]
  }

  /// Returns a piece of trivia for UnexpectedText.
  public static func unexpectedText(_ text: String) -> Trivia {
    return [.unexpectedText(text)]
  }

  /// Returns a piece of trivia for Shebang.
  public static func shebang(_ text: String) -> Trivia {
    return [.shebang(text)]
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

extension Trivia {
  /// Concatenates two collections of `Trivia` into one collection.
  public static func +(lhs: Trivia, rhs: Trivia) -> Trivia {
    return Trivia(pieces: lhs.pieces + rhs.pieces)
  }

  /// Concatenates two collections of `Trivia` into the left-hand side.
  public static func +=(lhs: inout Trivia, rhs: Trivia) {
    lhs = lhs + rhs
  }
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
    case let .lineComment(text):
      return SourceLength(of: text)
    case let .blockComment(text):
      return SourceLength(of: text)
    case let .docLineComment(text):
      return SourceLength(of: text)
    case let .docBlockComment(text):
      return SourceLength(of: text)
    case let .unexpectedText(text):
      return SourceLength(of: text)
    case let .shebang(text):
      return SourceLength(of: text)
    }
  }
}

/// Trivia piece for token RawSyntax.
///
/// In contrast to `TriviaPiece`, a `RawTriviaPiece` does not own the source
/// text of a the trivia.
@_spi(RawSyntax)
public enum RawTriviaPiece: Equatable {
  case spaces(Int)
  case tabs(Int)
  case verticalTabs(Int)
  case formfeeds(Int)
  case newlines(Int)
  case carriageReturns(Int)
  case carriageReturnLineFeeds(Int)
  case lineComment(SyntaxText)
  case blockComment(SyntaxText)
  case docLineComment(SyntaxText)
  case docBlockComment(SyntaxText)
  case unexpectedText(SyntaxText)
  case shebang(SyntaxText)

  static func make(_ piece: TriviaPiece, arena: SyntaxArena) -> RawTriviaPiece {
    switch piece {
    case let .spaces(count): return .spaces(count)
    case let .tabs(count): return .tabs(count)
    case let .verticalTabs(count): return .verticalTabs(count)
    case let .formfeeds(count): return .formfeeds(count)
    case let .newlines(count): return .newlines(count)
    case let .carriageReturns(count): return .carriageReturns(count)
    case let .carriageReturnLineFeeds(count): return .carriageReturnLineFeeds(count)
    case let .lineComment(text): return .lineComment(arena.intern(text))
    case let .blockComment(text): return .blockComment(arena.intern(text))
    case let .docLineComment(text): return .docLineComment(arena.intern(text))
    case let .docBlockComment(text): return .docBlockComment(arena.intern(text))
    case let .unexpectedText(text): return .unexpectedText(arena.intern(text))
    case let .shebang(text): return .shebang(arena.intern(text))
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

extension TriviaPiece {
  init(raw: RawTriviaPiece) {
    switch raw {
    case let .spaces(count): self = .spaces(count)
    case let .tabs(count): self = .tabs(count)
    case let .verticalTabs(count): self = .verticalTabs(count)
    case let .formfeeds(count): self = .formfeeds(count)
    case let .newlines(count): self = .newlines(count)
    case let .carriageReturns(count): self = .carriageReturns(count)
    case let .carriageReturnLineFeeds(count): self = .carriageReturnLineFeeds(count)
    case let .lineComment(text): self = .lineComment(String(syntaxText: text))
    case let .blockComment(text): self = .blockComment(String(syntaxText: text))
    case let .docLineComment(text): self = .docLineComment(String(syntaxText: text))
    case let .docBlockComment(text): self = .docBlockComment(String(syntaxText: text))
    case let .unexpectedText(text): self = .unexpectedText(String(syntaxText: text))
    case let .shebang(text): self = .shebang(String(syntaxText: text))
    }
  }
}

extension RawTriviaPiece {
  public var byteLength: Int {
    switch self {
    case let .spaces(count):
      return count
    case let .tabs(count):
      return count
    case let .verticalTabs(count):
      return count
    case let .formfeeds(count):
      return count
    case let .newlines(count):
      return count * 1
    case let .carriageReturns(count):
      return count * 1
    case let .carriageReturnLineFeeds(count):
      return count * 2
    case let .lineComment(text):
      return text.count
    case let .blockComment(text):
      return text.count
    case let .docLineComment(text):
      return text.count
    case let .docBlockComment(text):
      return text.count
    case let .unexpectedText(text):
      return text.count
    case let .shebang(text):
      return text.count
    }
  }

  var storedText: SyntaxText? {
    switch self {
    case .spaces(_): return nil
    case .tabs(_): return nil
    case .verticalTabs(_): return nil
    case .formfeeds(_): return nil
    case .newlines(_): return nil
    case .carriageReturns(_): return nil
    case .carriageReturnLineFeeds(_): return nil
    case .lineComment(let text): return text
    case .blockComment(let text): return text
    case .docLineComment(let text): return text
    case .docBlockComment(let text): return text
    case .unexpectedText(let text): return text
    case .shebang(let text): return text
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
