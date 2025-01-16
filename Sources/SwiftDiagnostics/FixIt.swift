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

#if compiler(>=6)
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

/// Types conforming to this protocol provide the data required for replacing a child node of a parent node.
///
/// Conforming types should ensure the child of ``parent`` to be replaced at ``replacementRange`` is type-compatible
/// with ``newChild``. Conforming types are stored as type-erased existentials (i.e. `any ReplacingChildData`) in
///  ``FixIt/Change/replaceChild(data:)`` to keep ``FixIt`` type-erased.
public protocol ReplacingChildData: Sendable {
  associatedtype Parent: SyntaxProtocol
  associatedtype Child: SyntaxProtocol

  /// The node whose child node at ``replacementRange`` to be replaced by ``newChild``.
  var parent: Parent { get }

  /// The node to replace the child node of ``parent`` at ``replacementRange``.
  var newChild: Child { get }

  /// The absolute position range of the child node to be replaced.
  ///
  /// If a nil child node is to be replaced, conforming types should provide a zero-length range with both bounds
  /// denoting the start position of ``newChild`` in ``parent`` after replacement.
  var replacementRange: Range<AbsolutePosition> { get }
}

/// A Fix-It that can be applied to resolve a diagnostic.
public struct FixIt: Sendable {
  public enum Change: Sendable {
    struct ReplacingOptionalChildData<Parent: SyntaxProtocol, Child: SyntaxProtocol>: ReplacingChildData {
      let parent: Parent
      let newChild: Child
      let keyPath: WritableKeyPath<Parent, Child?> & Sendable

      var replacementRange: Range<AbsolutePosition> {
        // need to upcast keyPath to strip Sendable for older Swift versions
        let keyPath: WritableKeyPath<Parent, Child?> = keyPath
        if let oldChild = parent[keyPath: keyPath] {
          return oldChild.range
        } else {
          let newChild = parent.with(keyPath, newChild)[keyPath: keyPath]!
          return newChild.position..<newChild.position
        }
      }
    }

    /// Replace `oldNode` by `newNode`.
    case replace(oldNode: Syntax, newNode: Syntax)
    /// Replace the leading trivia on the given token
    case replaceLeadingTrivia(token: TokenSyntax, newTrivia: Trivia)
    /// Replace the trailing trivia on the given token
    case replaceTrailingTrivia(token: TokenSyntax, newTrivia: Trivia)
    /// Replace the child node of the given parent node at the given replacement range with the given new child node
    case replaceChild(data: any ReplacingChildData)
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
      guard let edit = change.edit else {
        continue
      }
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
  var edit: SourceEdit? {
    switch self {
    case .replace(let oldNode, let newNode):
      // Replace the whole node including leading/trailing trivia, but if
      // the trivia are the same, don't include them in the replacing range.
      let leadingMatch = oldNode.leadingTrivia == newNode.leadingTrivia
      let trailingMatch = oldNode.trailingTrivia == newNode.trailingTrivia
      let start = leadingMatch ? oldNode.positionAfterSkippingLeadingTrivia : oldNode.position
      let end = trailingMatch ? oldNode.endPositionBeforeTrailingTrivia : oldNode.endPosition
      var newNode = newNode.detached
      if leadingMatch {
        newNode.leadingTrivia = []
      }
      if trailingMatch {
        newNode.trailingTrivia = []
      }
      return SourceEdit(
        range: start..<end,
        replacement: newNode.description
      )

    case .replaceLeadingTrivia(let token, let newTrivia):
      guard token.leadingTrivia != newTrivia else {
        return nil
      }
      return SourceEdit(
        range: token.position..<token.positionAfterSkippingLeadingTrivia,
        replacement: newTrivia.description
      )

    case .replaceTrailingTrivia(let token, let newTrivia):
      guard token.trailingTrivia != newTrivia else {
        return nil
      }
      return SourceEdit(
        range: token.endPositionBeforeTrailingTrivia..<token.endPosition,
        replacement: newTrivia.description
      )

    case .replaceChild(let replacingChildData):
      return SourceEdit(
        range: replacingChildData.replacementRange,
        replacement: replacingChildData.newChild.description
      )
    }
  }
}
