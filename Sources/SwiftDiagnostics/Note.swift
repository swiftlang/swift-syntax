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

/// Types conforming to this protocol represent note messages that can be
/// shown to the client.
/// The messages should describe what the note is pointing at.
public protocol NoteMessage: Sendable {
  /// The message that should be displayed in the client.
  var message: String { get }

  /// See ``MessageID``.
  var noteID: MessageID { get }
}

extension NoteMessage {
  @available(*, deprecated, message: "Use noteID instead.", renamed: "noteID")
  public var fixItID: MessageID {
    return noteID
  }
}

/// A note that points to another node that's relevant for a Diagnostic.
public struct Note: CustomDebugStringConvertible, Sendable {
  /// The node whose location the node is pointing.
  public let node: Syntax

  /// The position at which the location should be anchored.
  /// By default, this is the start location of `node`.
  public let position: AbsolutePosition

  /// A description of what this note is pointing at.
  public let noteMessage: NoteMessage

  public init(
    node: Syntax,
    position: AbsolutePosition? = nil,
    message: NoteMessage
  ) {
    self.node = node
    self.position = position ?? node.positionAfterSkippingLeadingTrivia
    self.noteMessage = message
  }

  /// The message that should be displayed to the user.
  public var message: String {
    return noteMessage.message
  }

  /// The location at which the note should be displayed.
  public func location(converter: SourceLocationConverter) -> SourceLocation {
    return converter.location(for: position)
  }

  public var debugDescription: String {
    if let root = node.root.as(SourceFileSyntax.self) {
      let locationConverter = SourceLocationConverter(fileName: "", tree: root)
      let location = location(converter: locationConverter)
      return "\(location): \(message)"
    } else {
      return "<unknown>: \(message)"
    }
  }
}
