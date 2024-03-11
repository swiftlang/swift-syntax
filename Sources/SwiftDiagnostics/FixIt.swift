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

/// Types conforming to this protocol represent Fix-It messages that can be
/// shown to the client.
/// The messages should describe the change that the Fix-It will perform
public protocol FixItMessage: Sendable {
  /// The Fix-It message that should be displayed in the client.
  var message: String { get }

  /// See ``MessageID``.
  var fixItID: MessageID { get }
}

/// A Fix-It that can be applied to resolve a diagnostic.
public struct FixIt: Sendable {
  public enum Change: Sendable {
    /// Replace `oldNode` by `newNode`.
    case replace(oldNode: Syntax, newNode: Syntax)
    /// Replace the leading trivia on the given token
    case replaceLeadingTrivia(token: TokenSyntax, newTrivia: Trivia)
    /// Replace the trailing trivia on the given token
    case replaceTrailingTrivia(token: TokenSyntax, newTrivia: Trivia)
  }

  /// A description of what this Fix-It performs.
  public let message: FixItMessage

  /// The changes that need to be performed when the Fix-It is applied.
  public let changes: [Change]

  public init(message: FixItMessage, changes: [Change]) {
    precondition(!changes.isEmpty, "A Fix-It must have at least one change associated with it")
    self.message = message
    self.changes = changes
  }
}

extension FixIt {
  /// The edits represent the non-overlapping textual edits that need to be performed when the Fix-It is applied.
  public var edits: [SourceEdit] {
    var existingEdits = [SourceEdit]()
    for change in changes {
      let edit = change.edit
      let isOverlapping = existingEdits.contains { edit.range.overlaps($0.range) }
      if !isOverlapping {
        // The edit overlaps with the previous edit. We can't apply both
        // without conflicts. Apply the one that's listed first and drop the
        // later edit.
        existingEdits.append(edit)
      }
    }
    return existingEdits
  }
}

private extension FixIt.Change {
  var edit: SourceEdit {
    switch self {
    case .replace(let oldNode, let newNode):
      return SourceEdit(
        range: oldNode.position..<oldNode.endPosition,
        replacement: newNode.description
      )

    case .replaceLeadingTrivia(let token, let newTrivia):
      return SourceEdit(
        range: token.position..<token.positionAfterSkippingLeadingTrivia,
        replacement: newTrivia.description
      )

    case .replaceTrailingTrivia(let token, let newTrivia):
      return SourceEdit(
        range: token.endPositionBeforeTrailingTrivia..<token.endPosition,
        replacement: newTrivia.description
      )
    }
  }
}
