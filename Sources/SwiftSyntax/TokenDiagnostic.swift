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

/// If the token has an error that's inherent to the token itself and not its
/// surrounding structure, this defines the type of the error.
/// `byteOffset` specifies at which offset the error occurred.
public struct TokenDiagnostic: Hashable {
  public enum Severity: Comparable {
    case warning
    case error
  }

  public enum Kind {
    // Please order these alphabetically

    case editorPlaceholder
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
    case tokenDiagnosticOffsetOverflow
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
    precondition(byteOffset >= 0)
    // `type(of: self.byteOffset).max` gets optimized to a constant
    if byteOffset > type(of: self.byteOffset).max {
      self.kind = .tokenDiagnosticOffsetOverflow
      self.byteOffset = 0
    } else {
      self.kind = kind
      self.byteOffset = UInt16(byteOffset)
    }
  }

  /// Picks the more severe error of `lhs` and `rhs`, preferring `lhs` if they
  /// have the same severity.
  public init?(combining lhs: TokenDiagnostic?, _ rhs: TokenDiagnostic?) {
    switch (lhs, rhs) {
    case (let lhs?, let rhs?):
      if rhs.severity > lhs.severity {
        // Prefer the rhs if it is more severe, otherwise continue using lhs.
        self = rhs
      } else {
        self = lhs
      }
    case (let lhs?, nil):
      self = lhs
    case (nil, let rhs?):
      self = rhs
    case (nil, nil):
      return nil
    }
  }

  public var severity: Severity {
    switch kind {
    case .editorPlaceholder: return .error
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
    case .tokenDiagnosticOffsetOverflow: return .error
    case .nonBreakingSpace: return .warning
    case .nulCharacter: return .warning
    case .sourceConflictMarker: return .error
    case .unexpectedBlockCommentEnd: return .error
    case .unicodeCurlyQuote: return .error
    case .unprintableAsciiCharacter: return .error
    }
  }
}
