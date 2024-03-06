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

extension Diagnostic {
  /// Construct a new diagnostic that has exactly one Fix-It.
  public init(
    node: some SyntaxProtocol,
    position: AbsolutePosition? = nil,
    message: DiagnosticMessage,
    highlights: [Syntax]? = nil,
    notes: [Note] = [],
    fixIt: FixIt
  ) {
    self.init(
      node: node,
      position: position,
      message: message,
      highlights: highlights,
      notes: notes,
      fixIts: [fixIt]
    )
  }
}

extension FixIt {
  /// A Fix-It that replaces `oldNode` by `newNode`.
  public static func replace(
    message: FixItMessage,
    oldNode: some SyntaxProtocol,
    newNode: some SyntaxProtocol
  ) -> Self {
    return FixIt(
      message: message,
      changes: [
        .replace(oldNode: Syntax(oldNode), newNode: Syntax(newNode))
      ]
    )
  }
}
