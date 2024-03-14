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
public import SwiftDiagnostics
@_spi(Diagnostics) import SwiftParser
@_spi(RawSyntax) public import SwiftSyntax
#else
import SwiftDiagnostics
@_spi(Diagnostics) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
#endif

fileprivate let diagnosticDomain: String = "SwiftLexer"

/// An error diagnostic whose ID is determined by the diagnostic's type.
public protocol TokenError: DiagnosticMessage {
  var diagnosticID: MessageID { get }
}

public extension TokenError {
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

/// A warning diagnostic whose ID is determined by the diagnostic's type.
public protocol TokenWarning: DiagnosticMessage {
  var diagnosticID: MessageID { get }
}

public extension TokenWarning {
  static var diagnosticID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var diagnosticID: MessageID {
    return Self.diagnosticID
  }

  var severity: DiagnosticSeverity {
    return .warning
  }
}

// MARK: - Errors (please sort alphabetically)

/// Please order the cases in this enum alphabetically by case name.
public enum StaticTokenError: String, DiagnosticMessage {
  case editorPlaceholder = "editor placeholder in source file"
  case equalMustHaveConsistentWhitespaceOnBothSides = "'=' must have consistent whitespace on both sides"
  case expectedBinaryExponentInHexFloatLiteral = "hexadecimal floating point literal must end with an exponent"
  case expectedClosingBraceInUnicodeEscape = #"expected '}' in \u{...} escape sequence"#
  case expectedDigitInFloatLiteral = "expected a digit in floating point exponent"
  case expectedHexCodeInUnicodeEscape = #"expected hexadecimal code in \u{...} escape sequence"#
  case expectedHexDigitInHexLiteral = "expected hexadecimal digit (0-9, A-F) in integer literal"
  case invalidCharacter = "invalid character in source file"
  case invalidEscapeSequenceInStringLiteral = "invalid escape sequence in literal"
  case invalidIdentifierStartCharacter = "an identifier cannot begin with this character"
  case invalidNumberOfHexDigitsInUnicodeEscape = #"\u{...} escape sequence expects between 1 and 8 hex digits"#
  case invalidUtf8 = "invalid UTF-8 found in source file"
  case tokenDiagnosticOffsetOverflow =
    "the lexer discovered an error in this token but was not able to represent its offset due to overflow; please split the token"
  case sourceConflictMarker = "source control conflict marker in source file"
  case unexpectedBlockCommentEnd = "unexpected end of block comment"
  case unicodeCurlyQuote = #"unicode curly quote found; use '"' instead"#
  case spaceAtStartOfRegexLiteral = "bare slash regex literal may not start with space"
  case spaceAtEndOfRegexLiteral = "bare slash regex literal may not end with space"
  case multilineRegexClosingNotOnNewline = "multi-line regex closing delimiter must appear on new line"
  case unprintableAsciiCharacter = "unprintable ASCII character found in source file"
  case unterminatedBlockComment = "unterminated '/*' comment"

  public var message: String { self.rawValue }

  public var diagnosticID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(self)")
  }

  public var severity: DiagnosticSeverity { .error }
}

/// Please order the cases in this enum alphabetically by case name.
public enum StaticTokenWarning: String, DiagnosticMessage {
  case nonBreakingSpace = "non-breaking space (U+00A0) used instead of regular space"
  case nulCharacter = "nul character embedded in middle of file"

  public var message: String { self.rawValue }

  public var diagnosticID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(self)")
  }

  public var severity: DiagnosticSeverity { .warning }
}

@_spi(SyntaxText)
public struct ExtraneousLeadingWhitespaceError: TokenError {
  public let tokenText: SyntaxText

  public var message: String {
    return "extraneous whitespace before '\(tokenText)' is not permitted"
  }
}

@_spi(SyntaxText)
public struct ExtraneousTrailingWhitespaceError: TokenError {
  public let tokenText: SyntaxText

  public var message: String {
    return "extraneous whitespace after '\(tokenText)' is not permitted"
  }
}

public struct InvalidFloatingPointExponentDigit: TokenError {
  public enum Kind: Sendable {
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

public struct InvalidDigitInIntegerLiteral: TokenError {
  public enum Kind: Sendable {
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

/// Downgrades a ``TokenError`` to a ``TokenWarning`` until Swift 6.
public struct ErrorToWarningDowngrade: TokenWarning {
  public let error: TokenError

  public var message: String {
    return "\(error.message); this is an error in Swift 6"
  }
}

// MARK: - Convert TokenDiagnostic from SwiftSyntax to error messages

public extension SwiftSyntax.TokenDiagnostic {
  /// `tokenText` is the entire text of the token in which the ``TokenDiagnostic``
  /// occurred, including trivia.
  @_spi(RawSyntax)
  func diagnosticMessage(in token: TokenSyntax) -> DiagnosticMessage {
    var scalarAtErrorOffset: UnicodeScalar {
      // Fall back to the Unicode replacement character U+FFFD in case we can't
      // lex the unicode character at `byteOffset`. It's the best we can do
      Unicode.Scalar.lexing(from: token.syntaxTextBytes[Int(self.byteOffset)...]) ?? UnicodeScalar("�")
    }

    switch self.kind {
    case .editorPlaceholder: return StaticTokenError.editorPlaceholder
    case .equalMustHaveConsistentWhitespaceOnBothSides: return StaticTokenError.equalMustHaveConsistentWhitespaceOnBothSides
    case .expectedBinaryExponentInHexFloatLiteral: return StaticTokenError.expectedBinaryExponentInHexFloatLiteral
    case .expectedClosingBraceInUnicodeEscape: return StaticTokenError.expectedClosingBraceInUnicodeEscape
    case .expectedDigitInFloatLiteral: return StaticTokenError.expectedDigitInFloatLiteral
    case .expectedHexCodeInUnicodeEscape: return StaticTokenError.expectedHexCodeInUnicodeEscape
    case .expectedHexDigitInHexLiteral: return StaticTokenError.expectedHexDigitInHexLiteral
    case .extraneousLeadingWhitespaceError: return ExtraneousLeadingWhitespaceError(tokenText: token.rawText)
    case .extraneousLeadingWhitespaceWarning: return ErrorToWarningDowngrade(error: ExtraneousLeadingWhitespaceError(tokenText: token.rawText))
    case .extraneousTrailingWhitespaceError: return ExtraneousTrailingWhitespaceError(tokenText: token.rawText)
    case .extraneousTrailingWhitespaceWarning: return ErrorToWarningDowngrade(error: ExtraneousTrailingWhitespaceError(tokenText: token.rawText))
    case .insufficientIndentationInMultilineStringLiteral:
      // This should be diagnosed when visiting the `StringLiteralExprSyntax`
      // inside `ParseDiagnosticsGenerator` but fall back to an error message
      // here in case the error is not diagnosed.
      return InvalidIndentationInMultiLineStringLiteralError(kind: .insufficientIndentation, lines: 1)
    case .invalidBinaryDigitInIntegerLiteral: return InvalidDigitInIntegerLiteral(kind: .binary(scalarAtErrorOffset))
    case .invalidCharacter: return StaticTokenError.invalidCharacter
    case .invalidDecimalDigitInIntegerLiteral: return InvalidDigitInIntegerLiteral(kind: .decimal(scalarAtErrorOffset))
    case .invalidEscapeSequenceInStringLiteral: return StaticTokenError.invalidEscapeSequenceInStringLiteral
    case .invalidFloatingPointExponentCharacter: return InvalidFloatingPointExponentDigit(kind: .character(scalarAtErrorOffset))
    case .invalidFloatingPointExponentDigit: return InvalidFloatingPointExponentDigit(kind: .digit(scalarAtErrorOffset))
    case .invalidHexDigitInIntegerLiteral: return InvalidDigitInIntegerLiteral(kind: .hex(scalarAtErrorOffset))
    case .invalidIdentifierStartCharacter: return StaticTokenError.invalidIdentifierStartCharacter
    case .invalidNumberOfHexDigitsInUnicodeEscape: return StaticTokenError.invalidNumberOfHexDigitsInUnicodeEscape
    case .invalidOctalDigitInIntegerLiteral: return InvalidDigitInIntegerLiteral(kind: .octal(scalarAtErrorOffset))
    case .invalidUtf8: return StaticTokenError.invalidUtf8
    case .multilineRegexClosingNotOnNewline: return StaticTokenError.multilineRegexClosingNotOnNewline
    case .nonBreakingSpace: return StaticTokenWarning.nonBreakingSpace
    case .nulCharacter: return StaticTokenWarning.nulCharacter
    case .sourceConflictMarker: return StaticTokenError.sourceConflictMarker
    case .spaceAtEndOfRegexLiteral: return StaticTokenError.spaceAtEndOfRegexLiteral
    case .spaceAtStartOfRegexLiteral: return StaticTokenError.spaceAtStartOfRegexLiteral
    case .tokenDiagnosticOffsetOverflow: return StaticTokenError.tokenDiagnosticOffsetOverflow
    case .unexpectedBlockCommentEnd: return StaticTokenError.unexpectedBlockCommentEnd
    case .unicodeCurlyQuote: return StaticTokenError.unicodeCurlyQuote
    case .unprintableAsciiCharacter: return StaticTokenError.unprintableAsciiCharacter
    case .unterminatedBlockComment: return StaticTokenError.unterminatedBlockComment
    #if RESILIENT_LIBRARIES
    @unknown default:
      fatalError()
    #endif
    }
  }

  func position(in token: TokenSyntax) -> AbsolutePosition {
    switch kind {
    case .extraneousLeadingWhitespaceError, .extraneousLeadingWhitespaceWarning:
      if let previousToken = token.previousToken(viewMode: .all) {
        return previousToken.endPositionBeforeTrailingTrivia
      }
    default:
      break
    }
    return token.position.advanced(by: Int(byteOffset))
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
        FixIt(message: .replaceNonBreakingSpaceBySpace, changes: [.replace(oldNode: Syntax(token), newNode: Syntax(fixedToken))])
      ]
    case .unicodeCurlyQuote:
      let (rawKind, text) = token.tokenKind.decomposeToRaw()
      guard let text = text else {
        return []
      }
      let replacedText =
        text
        .replacingFirstOccurrence(of: "“", with: #"""#)
        .replacingLastOccurrence(of: "”", with: #"""#)

      let fixedToken = token.with(\.tokenKind, TokenKind.fromRaw(kind: rawKind, text: replacedText))
      return [
        FixIt(message: .replaceCurlyQuoteByNormalQuote, changes: [.replace(oldNode: Syntax(token), newNode: Syntax(fixedToken))])
      ]
    case .equalMustHaveConsistentWhitespaceOnBothSides:
      let hasLeadingSpace = token.previousToken(viewMode: .all)?.trailingTrivia.contains(where: { $0.isSpaceOrTab }) ?? false
      let hasTrailingSpace = token.trailingTrivia.contains { $0.isSpaceOrTab }
      var changes: [FixIt.Change] = []

      if !hasLeadingSpace {
        changes += [
          .replaceLeadingTrivia(token: token, newTrivia: .space)
        ]
      }

      if !hasTrailingSpace {
        changes += [
          .replaceTrailingTrivia(token: token, newTrivia: .space)
        ]
      }

      return [
        FixIt(message: .insertWhitespace, changes: changes)
      ]
    case .extraneousLeadingWhitespaceError, .extraneousLeadingWhitespaceWarning:
      var changes: [FixIt.Change] = []
      changes.append(.replaceLeadingTrivia(token: token, newTrivia: []))
      if let previousToken = token.previousToken(viewMode: .sourceAccurate) {
        changes.append(.replaceTrailingTrivia(token: previousToken, newTrivia: []))
      }
      return [FixIt(message: .removeExtraneousWhitespace, changes: changes)]
    case .extraneousTrailingWhitespaceError, .extraneousTrailingWhitespaceWarning:
      var changes: [FixIt.Change] = []
      changes.append(.replaceTrailingTrivia(token: token, newTrivia: []))
      if let nextToken = token.nextToken(viewMode: .sourceAccurate) {
        changes.append(.replaceLeadingTrivia(token: nextToken, newTrivia: []))
      }
      return [FixIt(message: .removeExtraneousWhitespace, changes: changes)]
    default:
      return []
    }
  }
}
