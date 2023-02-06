//===----------------------------------------------------------------------===//
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

/// If the token has a lexical error, this defines the type of the error.
/// `lexerErrorOffset` in the token will specify at which offset the error
/// occurred.
public struct LexerError: Hashable {
  public enum Severity {
    case error
    case warning
  }

  public enum Kind {
    // Please order these alphabetically

    case expectedBinaryExponentInHexFloatLiteral
    case expectedClosingBraceInUnicodeEscape
    case expectedDigitInFloatLiteral
    case expectedHexCodeInUnicodeEscape
    case expectedHexDigitInHexLiteral
    case insufficientIndentationInMultilineStringLiteral
    case invalidBinaryDigitInIntegerLiteral
    case invalidCharacter
    case invalidDecimalDigitInIntegerLiteral
    case invalidEscapeSequenceInStringLiteral
    case invalidFloatingPointExponentCharacter
    case invalidFloatingPointExponentDigit
    case invalidHexDigitInIntegerLiteral
    case invalidIdentifierStartCharacter
    case invalidNumberOfHexDigitsInUnicodeEscape
    case invalidOctalDigitInIntegerLiteral
    case invalidUtf8
    /// The lexer dicovered an error but was not able to represent the offset of the error because it would overflow `LexerErrorOffset`.
    case lexerErrorOffsetOverflow
    case nonBreakingSpace
    case nulCharacter
    case sourceConflictMarker
    case unexpectedBlockCommentEnd
    case unicodeCurlyQuote
    case unprintableAsciiCharacter
  }

  public let kind: Kind

  /// The offset at which the error is, in bytes relative to the token's leading
  /// trivia start (i.e. relative to the token's `position`)
  public let byteOffset: UInt16

  public init(_ kind: Kind, byteOffset: UInt16) {
    self.kind = kind
    self.byteOffset = byteOffset
  }

  public init(_ kind: Kind, byteOffset: Int) {
    assert(byteOffset >= 0)
    // `type(of: self.byteOffset).max` gets optimized to a constant
    if byteOffset > type(of: self.byteOffset).max {
      self.kind = .lexerErrorOffsetOverflow
      self.byteOffset = 0
    } else {
      self.kind = kind
      self.byteOffset = UInt16(byteOffset)
    }
  }

  public var severity: Severity {
    switch kind {
    case .expectedBinaryExponentInHexFloatLiteral: return .error
    case .expectedClosingBraceInUnicodeEscape: return .error
    case .expectedDigitInFloatLiteral: return .error
    case .expectedHexCodeInUnicodeEscape: return .error
    case .expectedHexDigitInHexLiteral: return .error
    case .insufficientIndentationInMultilineStringLiteral: return .error
    case .invalidBinaryDigitInIntegerLiteral: return .error
    case .invalidCharacter: return .error
    case .invalidDecimalDigitInIntegerLiteral: return .error
    case .invalidEscapeSequenceInStringLiteral: return .error
    case .invalidFloatingPointExponentCharacter: return .error
    case .invalidFloatingPointExponentDigit: return .error
    case .invalidHexDigitInIntegerLiteral: return .error
    case .invalidIdentifierStartCharacter: return .error
    case .invalidNumberOfHexDigitsInUnicodeEscape: return .error
    case .invalidOctalDigitInIntegerLiteral: return .error
    case .invalidUtf8: return .error
    case .lexerErrorOffsetOverflow: return .error
    case .nonBreakingSpace: return .warning
    case .nulCharacter: return .warning
    case .sourceConflictMarker: return .error
    case .unexpectedBlockCommentEnd: return .error
    case .unicodeCurlyQuote: return .error
    case .unprintableAsciiCharacter: return .error
    }
  }
}
