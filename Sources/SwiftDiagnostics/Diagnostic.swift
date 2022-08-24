//===--- Diagnostics.swift ------------------------------------------------===//
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

import SwiftSyntax

public struct Diagnostic: CustomDebugStringConvertible {
  /// The message that should be displayed to the user
  public let diagMessage: DiagnosticMessage

  /// The node at whose start location the message should be displayed.
  public let node: Syntax

  /// Fix-Its that can be applied to resolve this diagnostic.
  /// Each Fix-It offers a different way to resolve the diagnostic. Usually, there's only one.
  public let fixIts: [FixIt]

  public init(node: Syntax, message: DiagnosticMessage, fixIts: [FixIt] = []) {
    self.diagMessage = message
    self.node = node
    self.fixIts = fixIts
  }

  /// The message that should be displayed to the user.
  public var message: String {
    return diagMessage.message
  }

  /// An ID that identifies the diagnostic's message.
  /// See ``MessageID``.
  public var diagnosticID: MessageID {
    return diagMessage.diagnosticID
  }

  /// The location at which the diagnostic should be displayed.
  public func location(converter: SourceLocationConverter) -> SourceLocation {
    return node.startLocation(converter: converter)
  }

  public var debugDescription: String {
    if let root = node.root.as(SourceFileSyntax.self) {
      let locationConverter = SourceLocationConverter(file: "", tree: root)
      let location = location(converter: locationConverter)
      return "\(location): \(message)"
    } else {
      return "<unknown>: \(message)"
    }
  }
}

