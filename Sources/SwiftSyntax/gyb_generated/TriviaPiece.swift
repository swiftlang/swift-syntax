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
    /// Any skipped garbage text.
    case garbageText(String)
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
      target.write(String(describing: text))
    case let .blockComment(text):
      target.write(String(describing: text))
    case let .docLineComment(text):
      target.write(String(describing: text))
    case let .docBlockComment(text):
      target.write(String(describing: text))
    case let .garbageText(text):
      target.write(String(describing: text))
    case let .shebang(text):
      target.write(String(describing: text))
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
      return "lineComment(\(name))"
    case .blockComment(let name):
      return "blockComment(\(name))"
    case .docLineComment(let name):
      return "docLineComment(\(name))"
    case .docBlockComment(let name):
      return "docBlockComment(\(name))"
    case .garbageText(let name):
      return "garbageText(\(name))"
    case .shebang(let name):
      return "shebang(\(name))"
    }
  }
}

extension Trivia {

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

  /// Returns a piece of trivia for GarbageText.
  public static func garbageText(_ text: String) -> Trivia {
    return [.garbageText(text)]
  }

  /// Returns a piece of trivia for Shebang.
  public static func shebang(_ text: String) -> Trivia {
    return [.shebang(text)]
  }
}

extension TriviaPiece: Equatable {}

extension TriviaPiece {
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
      return text.utf8.count
    case let .blockComment(text):
      return text.utf8.count
    case let .docLineComment(text):
      return text.utf8.count
    case let .docBlockComment(text):
      return text.utf8.count
    case let .garbageText(text):
      return text.utf8.count
    case let .shebang(text):
      return text.utf8.count
    }
  }
}

/// Trivia piece for token RawSyntax.
public enum RawTriviaPiece {
    case spaces(Int)
    case tabs(Int)
    case verticalTabs(Int)
    case formfeeds(Int)
    case newlines(Int)
    case carriageReturns(Int)
    case carriageReturnLineFeeds(Int)
    case lineComment(StringRef)
    case blockComment(StringRef)
    case docLineComment(StringRef)
    case docBlockComment(StringRef)
    case garbageText(StringRef)
    case shebang(StringRef)

  static func make(arena: SyntaxArena, _ piece: TriviaPiece) -> RawTriviaPiece {
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
    case let .garbageText(text): return .garbageText(arena.intern(text))
    case let .shebang(text): return .shebang(arena.intern(text))
    }
  }
}

extension RawTriviaPiece: TextOutputStreamable {
  public func write<Target: TextOutputStream>(to target: inout Target) {
    TriviaPiece(raw: self).write(to: &target)
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
    case let .lineComment(text): self = .lineComment(String(stringRef: text))
    case let .blockComment(text): self = .blockComment(String(stringRef: text))
    case let .docLineComment(text): self = .docLineComment(String(stringRef: text))
    case let .docBlockComment(text): self = .docBlockComment(String(stringRef: text))
    case let .garbageText(text): self = .garbageText(String(stringRef: text))
    case let .shebang(text): self = .shebang(String(stringRef: text))
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
    case let .garbageText(text):
      return text.count
    case let .shebang(text):
      return text.count
    }
  }
}


extension RawTriviaPiece {
  @_spi(RawSyntax)
  public static func fromRawValue(kind: UInt8, text: StringRef) -> RawTriviaPiece {
    switch kind {
    case 0:
      return .spaces(text.count / 1)
    case 1:
      return .tabs(text.count / 1)
    case 2:
      return .verticalTabs(text.count / 1)
    case 3:
      return .formfeeds(text.count / 1)
    case 4:
      return .newlines(text.count / 1)
    case 5:
      return .carriageReturns(text.count / 1)
    case 6:
      return .carriageReturnLineFeeds(text.count / 2)
    case 8:
      return .lineComment(text)
    case 9:
      return .blockComment(text)
    case 10:
      return .docLineComment(text)
    case 11:
      return .docBlockComment(text)
    case 12:
      return .garbageText(text)
    case 13:
      return .shebang(text)
    default:
      fatalError("unexpected trivia piece kind \(kind)")
    }
  }
}
