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
#else
import SwiftDiagnostics
#endif

fileprivate let diagnosticDomain: String = "SwiftSyntaxMacros"

/// An error during macro expansion that is described by its message.
///
/// This type allows macro authors to quickly generate error messages based on a
/// string. For any non-trivial error messages, it is encouraged to define a
/// custom type that conforms to `DiagnosticMessage`.
public struct MacroExpansionErrorMessage: Error, DiagnosticMessage {
  public let message: String

  public var severity: SwiftDiagnostics.DiagnosticSeverity { .error }

  public var diagnosticID: SwiftDiagnostics.MessageID {
    .init(domain: diagnosticDomain, id: "\(Self.self)")
  }

  public init(_ message: String) {
    self.message = message
  }
}

/// An warning during macro expansion that is described by its message.
///
/// This type allows macro authors to quickly generate warning messages based on
/// a string. For any non-trivial warning messages, it is encouraged to define a
/// custom type that conforms to `DiagnosticMessage`.
public struct MacroExpansionWarningMessage: DiagnosticMessage {
  public let message: String

  public var severity: SwiftDiagnostics.DiagnosticSeverity { .warning }

  public var diagnosticID: SwiftDiagnostics.MessageID {
    .init(domain: diagnosticDomain, id: "\(Self.self)")
  }

  public init(_ message: String) {
    self.message = message
  }
}

/// The message of a Fix-It that is specified by a string literal
///
/// This type allows macro authors to quickly generate Fix-It messages based on
/// a string. For any non-trivial Fix-It messages, it is encouraged to define a
/// custom type that conforms to `FixItMessage`.
public struct MacroExpansionFixItMessage: FixItMessage {
  public var message: String

  public var fixItID: SwiftDiagnostics.MessageID {
    .init(domain: diagnosticDomain, id: "\(Self.self)")
  }

  public init(_ message: String) {
    self.message = message
  }
}

/// The message of a note that is specified by a string literal
///
/// This type allows macro authors to quickly generate note messages based on
/// a string. For any non-trivial note messages, it is encouraged to define a
/// custom type that conforms to `NoteMessage`.
public struct MacroExpansionNoteMessage: NoteMessage {
  public var message: String

  public var noteID: SwiftDiagnostics.MessageID {
    .init(domain: diagnosticDomain, id: "\(Self.self)")
  }

  public init(_ message: String) {
    self.message = message
  }
}
