//===--- LexerDiagnosticMessages.swift ------------------------------------===//
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

import SwiftDiagnostics
@_spi(RawSyntax) import SwiftSyntax

fileprivate let diagnosticDomain: String = "SwiftLexer"

/// A error diagnostic whose ID is determined by the diagnostic's type.
public protocol LexerError: DiagnosticMessage {
  var diagnosticID: MessageID { get }
}

public extension LexerError {
  static var diagnosticID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var diagnosticID: MessageID {
    return Self.diagnosticID
  }

  var severity: DiagnosticSeverity {
    return .error
  }
}

// MARK: - Errors (please sort alphabetically)

/// Please order the cases in this enum alphabetically by case name.
public enum StaticLexerError: String, DiagnosticMessage {
  case expectedBinaryExponentInHexFloatLiteral = "hexadecimal floating point literal must end with an exponent"
  case expectedClosingBraceInUnicodeEscape = #"expected '}' in \u{...} escape sequence"#
  case expectedDigitInFloatLiteral = "expected a digit in floating point exponent"
  case expectedHexCodeInUnicodeEscape = #"expected hexadecimal code in \u{...} escape sequence"#
  case invalidCharacter = "invalid character in source file"
  case invalidEscapeSequenceInStringLiteral = "invalid escape sequence in literal"
  case invalidIdentifierStartCharacter = "an identifier cannot begin with this character"
  case invalidNumberOfHexDigitsInUnicodeEscape = #"\u{...} escape sequence expects between 1 and 8 hex digits"#
  case invalidUtf8 = "invalid UTF-8 found in source file"
  case lexerErrorOffsetOverflow = "the lexer dicovered an error in this token but was not able to represent its offset due to overflow; please split the token"
  case nonBreakingSpace = "non-breaking space (U+00A0) used instead of regular space"
  case nulCharacter = "nul character embedded in middle of file"
  case unexpectedBlockCommentEnd = "unexpected end of block comment"
  case unicodeCurlyQuote = #"unicode curly quote found; use '"' instead"#

  public var message: String { self.rawValue }

  public var diagnosticID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(self)")
  }

  public var severity: DiagnosticSeverity { .error }
}

public struct InvalidFloatingPointExponentDigit: LexerError {
  public enum Kind {
    case digit(Unicode.Scalar)
    case character(Unicode.Scalar)
  }
  public let kind: Self.Kind

  public var message: String {
    switch self.kind {
    case .digit(let digit):
      return "'\(digit)' is not a valid digit in floating point exponent"
    case .character(let char):
      return "'\(char)' is not a valid first character in floating point exponent"
    }
  }
}

public struct InvalidDigitInIntegerLiteral: LexerError {
  public enum Kind {
    case binary(Unicode.Scalar)
    case octal(Unicode.Scalar)
    case decimal(Unicode.Scalar)
    case hex(Unicode.Scalar)
  }

  public let kind: Self.Kind

  public var message: String {
    switch self.kind {
    case .binary(let digit):
      return "'\(digit)' is not a valid binary digit (0 or 1) in integer literal"
    case .octal(let digit):
      return "'\(digit)' is not a valid octal digit (0-7) in integer literal"
    case .decimal(let digit):
      return "'\(digit)' is not a valid digit in integer literal"
    case .hex(let digit):
      return "'\(digit)' is not a valid hexadecimal digit (0-9, A-F) in integer literal"
    }
  }
}

// MARK: - Convert LexerError from SwiftSyntax to error messages

public extension SwiftSyntax.LexerError {
  /// `tokenText` is the entire text of the token in which the `LexerError`
  /// occurred, including trivia.
  @_spi(RawSyntax)
  func diagnosticMessage(wholeTextBytes: [UInt8]) -> DiagnosticMessage {
    var scalarAtErrorOffset: UnicodeScalar {
      // Fall back to the Unicode replacement character U+FFFD in case we can't
      // lex the unicode character at `byteOffset`. It's the best we can do
      Unicode.Scalar.lexing(from: wholeTextBytes[Int(self.byteOffset)...]) ?? UnicodeScalar("�")
    }

    switch self.kind {
    case .expectedBinaryExponentInHexFloatLiteral: return StaticLexerError.expectedBinaryExponentInHexFloatLiteral
    case .expectedClosingBraceInUnicodeEscape: return StaticLexerError.expectedClosingBraceInUnicodeEscape
    case .expectedDigitInFloatLiteral: return StaticLexerError.expectedDigitInFloatLiteral
    case .expectedHexCodeInUnicodeEscape: return StaticLexerError.expectedHexCodeInUnicodeEscape
    case .insufficientIndentationInMultilineStringLiteral:
      // This should be diagnosed when visiting the `StringLiteralExprSyntax`
      // inside `ParseDiagnosticsGenerator` but fall back to an error message
      // here in case the error is not diagnosed.
      return InvalidIndentationInMultiLineStringLiteralError(kind: .insufficientIndentation, lines: 1)
    case .invalidBinaryDigitInIntegerLiteral: return InvalidDigitInIntegerLiteral(kind: .binary(scalarAtErrorOffset))
    case .invalidCharacter: return StaticLexerError.invalidCharacter
    case .invalidDecimalDigitInIntegerLiteral: return InvalidDigitInIntegerLiteral(kind: .decimal(scalarAtErrorOffset))
    case .invalidEscapeSequenceInStringLiteral: return StaticLexerError.invalidEscapeSequenceInStringLiteral
    case .invalidFloatingPointExponentCharacter: return InvalidFloatingPointExponentDigit(kind: .character(scalarAtErrorOffset))
    case .invalidFloatingPointExponentDigit: return InvalidFloatingPointExponentDigit(kind: .digit(scalarAtErrorOffset))
    case .invalidHexDigitInIntegerLiteral: return InvalidDigitInIntegerLiteral(kind: .hex(scalarAtErrorOffset))
    case .invalidIdentifierStartCharacter: return StaticLexerError.invalidIdentifierStartCharacter
    case .invalidNumberOfHexDigitsInUnicodeEscape: return StaticLexerError.invalidNumberOfHexDigitsInUnicodeEscape
    case .invalidOctalDigitInIntegerLiteral: return InvalidDigitInIntegerLiteral(kind: .octal(scalarAtErrorOffset))
    case .invalidUtf8: return StaticLexerError.invalidUtf8
    case .lexerErrorOffsetOverflow: return StaticLexerError.lexerErrorOffsetOverflow
    case .nonBreakingSpace: return StaticLexerError.nonBreakingSpace
    case .nulCharacter: return StaticLexerError.nulCharacter
    case .unexpectedBlockCommentEnd: return StaticLexerError.unexpectedBlockCommentEnd
    case .unicodeCurlyQuote: return StaticLexerError.unicodeCurlyQuote
    }
  }

  func diagnosticMessage(in token: TokenSyntax) -> DiagnosticMessage {
    return self.diagnosticMessage(wholeTextBytes: token.syntaxTextBytes)
  }

  func fixIts(in token: TokenSyntax) -> [FixIt] {
    switch self.kind {
    case .nonBreakingSpace:
      let replaceNonBreakingSpace = { (piece: TriviaPiece) -> TriviaPiece in
        if piece == .unexpectedText("\u{a0}") {
          return .spaces(1)
        } else {
          return piece
        }
      }
      let fixedToken =
        token
        .with(\.leadingTrivia, Trivia(pieces: token.leadingTrivia.map(replaceNonBreakingSpace)))
        .with(\.trailingTrivia, Trivia(pieces: token.trailingTrivia.map(replaceNonBreakingSpace)))
      return [
        FixIt(message: .replaceNonBreakingSpaceBySpace, changes: [[.replace(oldNode: Syntax(token), newNode: Syntax(fixedToken))]])
      ]
    case .unicodeCurlyQuote:
      let (rawKind, text) = token.tokenKind.decomposeToRaw()
      guard let text = text else {
        return []
      }
      let replacedText =
        text
        .replacingFirstOccurance(of: "“", with: #"""#)
        .replacingLastOccurance(of: "”", with: #"""#)

      let fixedToken = token.withKind(TokenKind.fromRaw(kind: rawKind, text: replacedText))
      return [
        FixIt(message: .replaceCurlyQuoteByNormalQuote, changes: [[.replace(oldNode: Syntax(token), newNode: Syntax(fixedToken))]])
      ]
    default:
      return []
    }
  }
}
