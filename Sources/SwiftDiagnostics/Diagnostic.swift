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
public import SwiftSyntax
#else
import SwiftSyntax
#endif

public struct Diagnostic: CustomDebugStringConvertible, Sendable {
  /// The message that should be displayed to the user
  public let diagMessage: DiagnosticMessage

  /// The node at whose start location the message should be displayed.
  public let node: Syntax

  /// The position at which the location should be anchored.
  /// By default, this is the start location of `node`.
  public let position: AbsolutePosition

  /// Nodes that should be highlighted in the source code.
  public let highlights: [Syntax]

  /// Notes that point to additional locations which are relevant for this diagnostic.
  public let notes: [Note]

  /// Fix-Its that can be applied to resolve this diagnostic.
  /// Each Fix-It offers a different way to resolve the diagnostic. Usually, there's only one.
  public let fixIts: [FixIt]

  /// If `highlights` is `nil` then `node` will be highlighted. This is a
  /// reasonable default for almost all diagnostics.
  public init(
    node: some SyntaxProtocol,
    position: AbsolutePosition? = nil,
    message: DiagnosticMessage,
    highlights: [Syntax]? = nil,
    notes: [Note] = [],
    fixIts: [FixIt] = []
  ) {
    self.node = Syntax(node)
    self.position = position ?? node.positionAfterSkippingLeadingTrivia
    self.diagMessage = message
    self.highlights = highlights ?? [Syntax(node)]
    self.notes = notes
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
    return converter.location(for: position)
  }

  public var debugDescription: String {
    let locationConverter = SourceLocationConverter(fileName: "", tree: node.root)
    let location = location(converter: locationConverter)
    return "\(location.line):\(location.column): \(message)"
  }
}

public struct DiagnosticsError: Error, Sendable {
  public var diagnostics: [Diagnostic]

  /// The diagnostics must contain at least one with severity == `.error`.
  /// Asserts if this condition is not satisfied.
  public init(diagnostics: [Diagnostic]) {
    self.diagnostics = diagnostics

    precondition(
      diagnostics.contains(where: { $0.diagMessage.severity == .error }),
      "at least one diagnostic must have severity == .error"
    )
  }
}
