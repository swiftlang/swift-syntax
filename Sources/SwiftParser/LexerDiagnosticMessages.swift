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
  case expectedDigitInFloatLiteral = "expected a digit in floating point exponent"

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
