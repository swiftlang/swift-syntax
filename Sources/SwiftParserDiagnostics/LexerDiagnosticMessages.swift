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

public protocol LexerNote: NoteMessage {
  var fixItID: MessageID { get }
}

public extension LexerNote {
  static var fixItID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var fixItID: MessageID {
    return Self.fixItID
  }
}

public protocol LexerFixIt: FixItMessage {
  var fixItID: MessageID { get }
}

public extension LexerFixIt {
  static var fixItID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var fixItID: MessageID {
    return Self.fixItID
  }
}

// MARK: - Errors (please sort alphabetically)

/// Please order the cases in this enum alphabetically by case name.
public enum StaticLexerError: String, DiagnosticMessage {
  case lex_expected_binary_exponent_in_hex_float_literal = "hexadecimal floating point literal must end with an exponent"
  
  public var message: String { self.rawValue }

  public var diagnosticID: MessageID {
    MessageID(domain: diagnosticDomain, id: "\(type(of: self)).\(self)")
  }

  public var severity: DiagnosticSeverity { .error }
}

