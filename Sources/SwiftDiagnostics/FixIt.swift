//===--- FixIt.swift ------------------------------------------------------===//
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

/// Types conforming to this protocol represent Fix-It messages that can be
/// shown to the client.
/// The messages should describe the change that the Fix-It will perform
public protocol FixItMessage {
  /// The Fix-It message that should be displayed in the client.
  var message: String { get }

  /// See ``MessageID``.
  var fixItID: MessageID { get }
}


/// A Fix-It that can be applied to resolve a diagnostic.
public struct FixIt {
  public enum Change {
    /// Replace `oldNode` by `newNode`.
    case replace(oldNode: Syntax, newNode: Syntax)
  }

  /// A description of what this Fix-It performs.
  public let message: FixItMessage

  /// The changes that need to be performed when the Fix-It is applied.
  public let changes: [Change]

  public init(message: FixItMessage, changes: [Change]) {
    assert(!changes.isEmpty, "A Fix-It must have at least one change associated with it")
    self.message = message
    self.changes = changes
  }
}

