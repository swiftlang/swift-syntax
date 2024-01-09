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

import SwiftSyntax

/// Describes the relative precedence of two groups.
enum Precedence: Sendable {
  case unrelated
  case higherThan
  case lowerThan

  /// Flip the precedence order around.
  var flipped: Precedence {
    switch self {
    case .unrelated:
      return .unrelated

    case .higherThan:
      return .lowerThan

    case .lowerThan:
      return .higherThan
    }
  }
}

/// A graph formed from a set of precedence groups, which can be used to
/// determine the relative precedence of two precedence groups.
struct PrecedenceGraph: Sendable {
  /// The known set of precedence groups, found by name.
  var precedenceGroups: [PrecedenceGroupName: PrecedenceGroup] = [:]

  /// Add a new precedence group
  ///
  /// - throws: If there is already a precedence group with the given name,
  ///   throws PrecedenceGraphError.groupAlreadyExists.
  mutating func add(
    _ group: PrecedenceGroup,
    errorHandler: OperatorErrorHandler = { throw $0 }
  ) rethrows {
    if let existing = precedenceGroups[group.name] {
      try errorHandler(
        OperatorError.groupAlreadyExists(
          existing: existing,
          new: group
        )
      )
    } else {
      precedenceGroups[group.name] = group
    }
  }

  /// Look for the precedence group with the given name, or return nil if
  /// no such group is known.
  func lookupGroup(_ groupName: PrecedenceGroupName) -> PrecedenceGroup? {
    return precedenceGroups[groupName]
  }

  /// Search the precedence-group relationships, starting at the given
  /// (fromGroup, fromSyntax) and following precedence groups in the
  /// specified direction.
  private func searchRelationships(
    initialGroupName: PrecedenceGroupName,
    initialSyntax: Syntax,
    targetGroupName: PrecedenceGroupName,
    direction: PrecedenceRelation.Kind,
    errorHandler: OperatorErrorHandler
  ) rethrows -> Precedence? {
    // Keep track of all of the groups we have seen during our exploration of
    // the graph. This detects cycles and prevents extraneous work.
    var groupsSeen: Set<PrecedenceGroupName> = []

    var stack: [(PrecedenceGroupName, Syntax)] =
      [(initialGroupName, initialSyntax)]
    while let (currentGroupName, currentOperatorSyntax) = stack.popLast() {
      guard let currentGroup = lookupGroup(currentGroupName) else {
        try errorHandler(
          .missingGroup(currentGroupName, referencedFrom: currentOperatorSyntax)
        )
        continue
      }

      for relation in currentGroup.relations {
        if relation.kind == direction {
          // If we hit our initial group, we're done.
          let otherGroupName = relation.groupName
          if otherGroupName == targetGroupName {
            switch direction {
            case .lowerThan:
              return .lowerThan

            case .higherThan:
              return .higherThan
            }
          }

          if groupsSeen.insert(otherGroupName).inserted {
            let relationSyntax: Syntax
            if let knownSyntax = relation.syntax {
              relationSyntax = Syntax(knownSyntax)
            } else {
              relationSyntax =
                Syntax(relation.synthesizedSyntax().precedenceGroups.first!.name)
            }
            stack.append((otherGroupName, relationSyntax))
          }
        }
      }
    }

    return nil
  }

  /// Determine the precedence relationship between two precedence groups.
  ///
  /// Follow the precedence relationships among the precedence groups to
  /// determine the precedence of the start group relative to the end group.
  ///
  /// - Returns: Precedence.lowerThan if startGroupName has lower precedence
  /// than endGroupName, Precedence.higherThan if startGroupName has higher
  /// precedence than endGroup name, and Precedence.unrelated otherwise.
  func precedence(
    relating startGroupName: PrecedenceGroupName,
    to endGroupName: PrecedenceGroupName,
    startSyntax: Syntax,
    endSyntax: Syntax,
    errorHandler: OperatorErrorHandler = { throw $0 }
  ) rethrows -> Precedence {
    if startGroupName == endGroupName {
      return .unrelated
    }

    // Walk all of the relationships from the end down, then from the beginning
    // up, to determine whether there is a relation between the two groups.
    return try searchRelationships(
      initialGroupName: endGroupName,
      initialSyntax: endSyntax,
      targetGroupName: startGroupName,
      direction: .lowerThan,
      errorHandler: errorHandler
    ) ?? searchRelationships(
      initialGroupName: startGroupName,
      initialSyntax: startSyntax,
      targetGroupName: endGroupName,
      direction: .higherThan,
      errorHandler: errorHandler
    ) ?? searchRelationships(
      initialGroupName: startGroupName,
      initialSyntax: startSyntax,
      targetGroupName: endGroupName,
      direction: .lowerThan,
      errorHandler: errorHandler
    ).map {
      $0.flipped
    } ?? searchRelationships(
      initialGroupName: endGroupName,
      initialSyntax: endSyntax,
      targetGroupName: startGroupName,
      direction: .higherThan,
      errorHandler: errorHandler
    ).map {
      $0.flipped
    } ?? .unrelated
  }
}
