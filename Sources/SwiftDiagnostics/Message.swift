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

/// An identifier that identifies a diagnostic message's type.
/// Fundamentally different diagnostics should have a different `diagnosticID`
/// so that clients may filter/prioritise/highlight/... certain diagnostics.
/// Two diagnostics with the same ID don’t need to necessarily have the exact
/// same wording. Eg. it’s possible that the message contains more context when
/// available.
public struct MessageID: Hashable, Sendable {
  private let domain: String
  private let id: String

  public init(domain: String, id: String) {
    self.domain = domain
    self.id = id
  }
}

public enum DiagnosticSeverity: Sendable {
  case error
  case warning
  case note
  case remark
}

/// Types conforming to this protocol represent diagnostic messages that can be
/// shown to the client.
public protocol DiagnosticMessage: Sendable {
  /// The diagnostic message that should be displayed in the client.
  var message: String { get }

  /// See ``MessageID``.
  var diagnosticID: MessageID { get }

  var severity: DiagnosticSeverity { get }
}
