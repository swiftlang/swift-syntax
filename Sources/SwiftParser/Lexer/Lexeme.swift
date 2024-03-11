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

#if swift(>=6)
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

extension Lexer {
  /// A trivia-delimited region of source text.
  ///
  /// A lexeme is the fundamental output unit of lexical analysis. Each lexeme
  /// represents a fully identified, meaningful part of the input text that
  /// will can be consumed by a ``Parser``.
  @_spi(Testing)
  public struct Lexeme: CustomDebugStringConvertible {
    @_spi(Testing)
    public struct Flags: OptionSet, CustomDebugStringConvertible, Sendable {
      @_spi(Testing)
      public var rawValue: UInt8

      @_spi(Testing)
      public init(rawValue: UInt8) {
        self.rawValue = rawValue
      }

      @_spi(Testing)
      public static let isAtStartOfLine = Flags(rawValue: 1 << 0)

      @_spi(Testing)
      public var debugDescription: String {
        var descriptionComponents: [String] = []
        if self.contains(.isAtStartOfLine) {
          descriptionComponents.append("isAtStartOfLine")
        }
        return "[\(descriptionComponents.joined(separator: ", "))]"
      }
    }

    @_spi(Testing)
    public var rawTokenKind: RawTokenKind

    @_spi(Testing)
    public var flags: Lexeme.Flags

    @_spi(Testing)
    public var diagnostic: TokenDiagnostic?

    var start: UnsafePointer<UInt8>

    var leadingTriviaByteLength: Int

    var textByteLength: Int

    var trailingTriviaByteLength: Int

    /// The cursor that produces this lexeme by calling `nextToken` on it.
    /// Used if the token needs to be re-lexed in a different lexer state.
    var cursor: Lexer.Cursor

    var isAtStartOfLine: Bool {
      return self.flags.contains(.isAtStartOfLine)
    }

    var isEditorPlaceholder: Bool {
      return self.rawTokenKind == .identifier && self.tokenText.isEditorPlaceholder
    }

    init(
      tokenKind: RawTokenKind,
      flags: Flags,
      diagnostic: TokenDiagnostic?,
      start: UnsafePointer<UInt8>,
      leadingTriviaLength: Int,
      textLength: Int,
      trailingTriviaLength: Int,
      cursor: Lexer.Cursor
    ) {
      self.rawTokenKind = tokenKind
      self.flags = flags
      self.diagnostic = diagnostic
      self.start = start
      self.leadingTriviaByteLength = leadingTriviaLength
      self.textByteLength = textLength
      self.trailingTriviaByteLength = trailingTriviaLength
      self.cursor = cursor
    }

    @_spi(Testing)
    public var byteLength: Int {
      leadingTriviaByteLength + textByteLength + trailingTriviaByteLength
    }

    @_spi(Testing)
    public var wholeText: SyntaxText {
      SyntaxText(baseAddress: start, count: byteLength)
    }

    @_spi(Testing)
    public var textRange: Range<SyntaxText.Index> {
      leadingTriviaByteLength..<leadingTriviaByteLength + textByteLength
    }

    @_spi(Testing)
    public var tokenText: SyntaxText {
      SyntaxText(
        baseAddress: start.advanced(by: leadingTriviaByteLength),
        count: textByteLength
      )
    }

    @_spi(Testing)
    public var leadingTriviaText: SyntaxText {
      SyntaxText(
        baseAddress: start,
        count: leadingTriviaByteLength
      )
    }

    @_spi(Testing)
    public var trailingTriviaText: SyntaxText {
      SyntaxText(
        baseAddress: start.advanced(by: leadingTriviaByteLength + textByteLength),
        count: trailingTriviaByteLength
      )
    }

    @_spi(Testing)
    public var debugDescription: String {
      return String(syntaxText: SyntaxText(baseAddress: start, count: byteLength))
    }
  }
}
