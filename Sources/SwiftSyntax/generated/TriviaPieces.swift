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
// Automatically generated by generate-swift-syntax
// Do not edit directly!
// swift-format-ignore-file

/// A contiguous stretch of a single kind of trivia. The constituent part of
/// a ``Trivia`` collection.
///
/// For example, four spaces would be represented by
/// `.spaces(4)`
///
/// In general, you should deal with the actual Trivia collection instead
/// of individual pieces whenever possible.
public enum TriviaPiece: Sendable {
  /// A backslash that is at the end of a line in a multi-line string literal to escape the newline.
  case backslashes(Int)
  /// A developer block comment, starting with '/*' and ending with '*/'.
  case blockComment(String)
  /// A newline '\r' character.
  case carriageReturns(Int)
  /// A newline consists of contiguous '\r' and '\n' characters.
  case carriageReturnLineFeeds(Int)
  /// A documentation block comment, starting with '/**' and ending with '*/'.
  case docBlockComment(String)
  /// A documentation line comment, starting with '///' and excluding the trailing newline.
  case docLineComment(String)
  /// A form-feed 'f' character.
  case formfeeds(Int)
  /// A developer line comment, starting with '//' and excluding the trailing newline.
  case lineComment(String)
  /// A newline '\n' character.
  case newlines(Int)
  /// A '#' that is at the end of a line in a multi-line string literal to escape the newline.
  case pounds(Int)
  /// A space ' ' character.
  case spaces(Int)
  /// A tab '\t' character.
  case tabs(Int)
  /// Any skipped unexpected text.
  case unexpectedText(String)
  /// A vertical tab '\v' character.
  case verticalTabs(Int)
  /// Box-drawing characters which have no syntactic significance.
  case boxDrawing(String)
}

extension TriviaPiece: TextOutputStreamable {
  /// Prints the provided trivia as they would be written in a source file.
  ///
  /// - Parameter stream: The stream to which to print the trivia.
  public func write(to stream: inout some TextOutputStream) {
    func printRepeated(_ character: String, count: Int) {
      for _ in 0 ..< count {
        stream.write(character)
      }
    }
    switch self {
    case let .backslashes(count):
      printRepeated(#"\"#, count: count)
    case let .blockComment(text):
      stream.write(text)
    case let .carriageReturns(count):
      printRepeated("\r", count: count)
    case let .carriageReturnLineFeeds(count):
      printRepeated("\r\n", count: count)
    case let .docBlockComment(text):
      stream.write(text)
    case let .docLineComment(text):
      stream.write(text)
    case let .formfeeds(count):
      printRepeated("\u{c}", count: count)
    case let .lineComment(text):
      stream.write(text)
    case let .newlines(count):
      printRepeated("\n", count: count)
    case let .pounds(count):
      printRepeated("#", count: count)
    case let .spaces(count):
      printRepeated(" ", count: count)
    case let .tabs(count):
      printRepeated("\t", count: count)
    case let .unexpectedText(text):
      stream.write(text)
    case let .verticalTabs(count):
      printRepeated("\u{b}", count: count)
    case let .boxDrawing(text):
      stream.write(text)
    }
  }
}

extension TriviaPiece: CustomDebugStringConvertible {
  /// Returns a description used by dump.
  public var debugDescription: String {
    switch self {
    case .backslashes(let data):
      return "backslashes(\(data))"
    case .blockComment(let name):
      return "blockComment(\(name.debugDescription))"
    case .carriageReturns(let data):
      return "carriageReturns(\(data))"
    case .carriageReturnLineFeeds(let data):
      return "carriageReturnLineFeeds(\(data))"
    case .docBlockComment(let name):
      return "docBlockComment(\(name.debugDescription))"
    case .docLineComment(let name):
      return "docLineComment(\(name.debugDescription))"
    case .formfeeds(let data):
      return "formfeeds(\(data))"
    case .lineComment(let name):
      return "lineComment(\(name.debugDescription))"
    case .newlines(let data):
      return "newlines(\(data))"
    case .pounds(let data):
      return "pounds(\(data))"
    case .spaces(let data):
      return "spaces(\(data))"
    case .tabs(let data):
      return "tabs(\(data))"
    case .unexpectedText(let name):
      return "unexpectedText(\(name.debugDescription))"
    case .verticalTabs(let data):
      return "verticalTabs(\(data))"
    case .boxDrawing(let name):
      return "boxDrawing(\(name.debugDescription))"
    }
  }
}

extension Trivia {
  /// Returns a piece of trivia for some number of #"\"# characters.
  public static func backslashes(_ count: Int) -> Trivia {
    return [.backslashes(count)]
  }

  /// Gets a piece of trivia for #"\"# characters.
  public static var backslash: Trivia {
    return .backslashes(1)
  }

  /// Returns a piece of trivia for BlockComment.
  public static func blockComment(_ text: String) -> Trivia {
    return [.blockComment(text)]
  }

  /// Returns a piece of trivia for some number of "\r" characters.
  public static func carriageReturns(_ count: Int) -> Trivia {
    return [.carriageReturns(count)]
  }

  /// Gets a piece of trivia for "\r" characters.
  public static var carriageReturn: Trivia {
    return .carriageReturns(1)
  }

  /// Returns a piece of trivia for some number of "\r\n" characters.
  public static func carriageReturnLineFeeds(_ count: Int) -> Trivia {
    return [.carriageReturnLineFeeds(count)]
  }

  /// Gets a piece of trivia for "\r\n" characters.
  public static var carriageReturnLineFeed: Trivia {
    return .carriageReturnLineFeeds(1)
  }

  /// Returns a piece of trivia for DocBlockComment.
  public static func docBlockComment(_ text: String) -> Trivia {
    return [.docBlockComment(text)]
  }

  /// Returns a piece of trivia for DocLineComment.
  public static func docLineComment(_ text: String) -> Trivia {
    return [.docLineComment(text)]
  }

  /// Returns a piece of trivia for some number of "\u{c}" characters.
  public static func formfeeds(_ count: Int) -> Trivia {
    return [.formfeeds(count)]
  }

  /// Gets a piece of trivia for "\u{c}" characters.
  public static var formfeed: Trivia {
    return .formfeeds(1)
  }

  /// Returns a piece of trivia for LineComment.
  public static func lineComment(_ text: String) -> Trivia {
    return [.lineComment(text)]
  }

  /// Returns a piece of trivia for some number of "\n" characters.
  public static func newlines(_ count: Int) -> Trivia {
    return [.newlines(count)]
  }

  /// Gets a piece of trivia for "\n" characters.
  public static var newline: Trivia {
    return .newlines(1)
  }

  /// Returns a piece of trivia for some number of "#" characters.
  public static func pounds(_ count: Int) -> Trivia {
    return [.pounds(count)]
  }

  /// Gets a piece of trivia for "#" characters.
  public static var pound: Trivia {
    return .pounds(1)
  }

  /// Returns a piece of trivia for some number of " " characters.
  public static func spaces(_ count: Int) -> Trivia {
    return [.spaces(count)]
  }

  /// Gets a piece of trivia for " " characters.
  public static var space: Trivia {
    return .spaces(1)
  }

  /// Returns a piece of trivia for some number of "\t" characters.
  public static func tabs(_ count: Int) -> Trivia {
    return [.tabs(count)]
  }

  /// Gets a piece of trivia for "\t" characters.
  public static var tab: Trivia {
    return .tabs(1)
  }

  /// Returns a piece of trivia for UnexpectedText.
  public static func unexpectedText(_ text: String) -> Trivia {
    return [.unexpectedText(text)]
  }

  /// Returns a piece of trivia for some number of "\u{b}" characters.
  public static func verticalTabs(_ count: Int) -> Trivia {
    return [.verticalTabs(count)]
  }

  /// Gets a piece of trivia for "\u{b}" characters.
  public static var verticalTab: Trivia {
    return .verticalTabs(1)
  }

  /// Returns a piece of trivia for BoxDrawing.
  public static func boxDrawing(_ text: String) -> Trivia {
    return [.boxDrawing(text)]
  }
}

extension TriviaPiece: Equatable {}

extension TriviaPiece {
  public var sourceLength: SourceLength {
    switch self {
    case let .backslashes(count):
      return SourceLength(utf8Length: count)
    case let .blockComment(text):
      return SourceLength(of: text)
    case let .carriageReturns(count):
      return SourceLength(utf8Length: count)
    case let .carriageReturnLineFeeds(count):
      return SourceLength(utf8Length: count * 2)
    case let .docBlockComment(text):
      return SourceLength(of: text)
    case let .docLineComment(text):
      return SourceLength(of: text)
    case let .formfeeds(count):
      return SourceLength(utf8Length: count)
    case let .lineComment(text):
      return SourceLength(of: text)
    case let .newlines(count):
      return SourceLength(utf8Length: count)
    case let .pounds(count):
      return SourceLength(utf8Length: count)
    case let .spaces(count):
      return SourceLength(utf8Length: count)
    case let .tabs(count):
      return SourceLength(utf8Length: count)
    case let .unexpectedText(text):
      return SourceLength(of: text)
    case let .verticalTabs(count):
      return SourceLength(utf8Length: count)
    case let .boxDrawing(text):
      return SourceLength(of: text)
    }
  }
}

/// Trivia piece for token RawSyntax.
///
/// In contrast to ``TriviaPiece``, a ``RawTriviaPiece`` does not own the source
/// text of the trivia.
@_spi(RawSyntax)
public enum RawTriviaPiece: Equatable, Sendable {
  case backslashes(Int)
  case blockComment(SyntaxText)
  case carriageReturns(Int)
  case carriageReturnLineFeeds(Int)
  case docBlockComment(SyntaxText)
  case docLineComment(SyntaxText)
  case formfeeds(Int)
  case lineComment(SyntaxText)
  case newlines(Int)
  case pounds(Int)
  case spaces(Int)
  case tabs(Int)
  case unexpectedText(SyntaxText)
  case verticalTabs(Int)
  case boxDrawing(SyntaxText)

  static func make(_ piece: TriviaPiece, arena: RawSyntaxArena) -> RawTriviaPiece {
    switch piece {
    case let .backslashes(count):
      return .backslashes(count)
    case let .blockComment(text):
      return .blockComment(arena.intern(text))
    case let .carriageReturns(count):
      return .carriageReturns(count)
    case let .carriageReturnLineFeeds(count):
      return .carriageReturnLineFeeds(count)
    case let .docBlockComment(text):
      return .docBlockComment(arena.intern(text))
    case let .docLineComment(text):
      return .docLineComment(arena.intern(text))
    case let .formfeeds(count):
      return .formfeeds(count)
    case let .lineComment(text):
      return .lineComment(arena.intern(text))
    case let .newlines(count):
      return .newlines(count)
    case let .pounds(count):
      return .pounds(count)
    case let .spaces(count):
      return .spaces(count)
    case let .tabs(count):
      return .tabs(count)
    case let .unexpectedText(text):
      return .unexpectedText(arena.intern(text))
    case let .verticalTabs(count):
      return .verticalTabs(count)
    case let .boxDrawing(text):
      return .boxDrawing(arena.intern(text))
    }
  }
}

extension TriviaPiece {
  @_spi(RawSyntax) public init(raw: RawTriviaPiece) {
    switch raw {
    case let .backslashes(count):
      self = .backslashes(count)
    case let .blockComment(text):
      self = .blockComment(String(syntaxText: text))
    case let .carriageReturns(count):
      self = .carriageReturns(count)
    case let .carriageReturnLineFeeds(count):
      self = .carriageReturnLineFeeds(count)
    case let .docBlockComment(text):
      self = .docBlockComment(String(syntaxText: text))
    case let .docLineComment(text):
      self = .docLineComment(String(syntaxText: text))
    case let .formfeeds(count):
      self = .formfeeds(count)
    case let .lineComment(text):
      self = .lineComment(String(syntaxText: text))
    case let .newlines(count):
      self = .newlines(count)
    case let .pounds(count):
      self = .pounds(count)
    case let .spaces(count):
      self = .spaces(count)
    case let .tabs(count):
      self = .tabs(count)
    case let .unexpectedText(text):
      self = .unexpectedText(String(syntaxText: text))
    case let .verticalTabs(count):
      self = .verticalTabs(count)
    case let .boxDrawing(text):
      self = .boxDrawing(String(syntaxText: text))
    }
  }
}

extension RawTriviaPiece {
  public var byteLength: Int {
    switch self {
    case let .backslashes(count):
      return count
    case let .blockComment(text):
      return text.count
    case let .carriageReturns(count):
      return count
    case let .carriageReturnLineFeeds(count):
      return count * 2
    case let .docBlockComment(text):
      return text.count
    case let .docLineComment(text):
      return text.count
    case let .formfeeds(count):
      return count
    case let .lineComment(text):
      return text.count
    case let .newlines(count):
      return count
    case let .pounds(count):
      return count
    case let .spaces(count):
      return count
    case let .tabs(count):
      return count
    case let .unexpectedText(text):
      return text.count
    case let .verticalTabs(count):
      return count
    case let .boxDrawing(text):
      return text.count
    }
  }

  var storedText: SyntaxText? {
    switch self {
    case .backslashes(_):
      return nil
    case .blockComment(let text):
      return text
    case .carriageReturns(_):
      return nil
    case .carriageReturnLineFeeds(_):
      return nil
    case .docBlockComment(let text):
      return text
    case .docLineComment(let text):
      return text
    case .formfeeds(_):
      return nil
    case .lineComment(let text):
      return text
    case .newlines(_):
      return nil
    case .pounds(_):
      return nil
    case .spaces(_):
      return nil
    case .tabs(_):
      return nil
    case .unexpectedText(let text):
      return text
    case .verticalTabs(_):
      return nil
    case .boxDrawing(let text):
      return text
    }
  }
}

extension TriviaPiece {
  /// Returns `true` if this piece is a whitespace.
  public var isWhitespace: Bool {
    switch self {
    case .carriageReturns:
      return true
    case .carriageReturnLineFeeds:
      return true
    case .formfeeds:
      return true
    case .newlines:
      return true
    case .spaces:
      return true
    case .tabs:
      return true
    case .verticalTabs:
      return true
    default:
      return false
    }
  }

  /// Returns `true` if this piece is a newline.
  public var isNewline: Bool {
    switch self {
    case .carriageReturns:
      return true
    case .carriageReturnLineFeeds:
      return true
    case .newlines:
      return true
    default:
      return false
    }
  }

  /// Returns `true` if this piece is a space or tab.
  public var isSpaceOrTab: Bool {
    switch self {
    case .spaces:
      return true
    case .tabs:
      return true
    default:
      return false
    }
  }

  /// Returns `true` if this piece is a comment.
  public var isComment: Bool {
    switch self {
    case .blockComment:
      return true
    case .docBlockComment:
      return true
    case .docLineComment:
      return true
    case .lineComment:
      return true
    default:
      return false
    }
  }
}

extension RawTriviaPiece {
  /// Returns `true` if this piece is a whitespace.
  public var isWhitespace: Bool {
    switch self {
    case .carriageReturns:
      return true
    case .carriageReturnLineFeeds:
      return true
    case .formfeeds:
      return true
    case .newlines:
      return true
    case .spaces:
      return true
    case .tabs:
      return true
    case .verticalTabs:
      return true
    default:
      return false
    }
  }

  /// Returns `true` if this piece is a newline.
  public var isNewline: Bool {
    switch self {
    case .carriageReturns:
      return true
    case .carriageReturnLineFeeds:
      return true
    case .newlines:
      return true
    default:
      return false
    }
  }

  /// Returns `true` if this piece is a space or tab.
  public var isSpaceOrTab: Bool {
    switch self {
    case .spaces:
      return true
    case .tabs:
      return true
    default:
      return false
    }
  }

  /// Returns `true` if this piece is a comment.
  public var isComment: Bool {
    switch self {
    case .blockComment:
      return true
    case .docBlockComment:
      return true
    case .docLineComment:
      return true
    case .lineComment:
      return true
    default:
      return false
    }
  }
}
