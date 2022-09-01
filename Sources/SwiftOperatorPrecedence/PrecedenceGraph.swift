//
//  File.swift
//  
//
//  Created by Doug Gregor on 8/18/22.
//

import SwiftSyntax

/// Describes the relative precedence of two groups.
enum Precedence {
  case unrelated
  case higherThan
  case lowerThan
}

/// A graph formed from a set of precedence groups, which can be used to
/// determine the relative precedence of two precedence groups.
struct PrecedenceGraph {
  /// The known set of precedence groups, found by name.
  var precedenceGroups: [PrecedenceGroupName : PrecedenceGroup] = [:]

  /// Add a new precedence group
  ///
  /// - throws: If there is already a precedence group with the given name,
  ///   throws PrecedenceGraphError.groupAlreadyExists.
  mutating func add(
    _ group: PrecedenceGroup,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows {
    if let existing = precedenceGroups[group.name] {
      try errorHandler(
        OperatorPrecedenceError.groupAlreadyExists(
          existing: existing, new: group))
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
    initialGroupName: PrecedenceGroupName, initialSyntax: SyntaxProtocol?,
    targetGroupName: PrecedenceGroupName,
    direction: PrecedenceRelation.Kind,
    errorHandler: OperatorPrecedenceErrorHandler
  ) rethrows -> Precedence? {
    // Keep track of all of the groups we have seen during our exploration of
    // the graph. This detects cycles and prevents extraneous work.
    var groupsSeen: Set<PrecedenceGroupName> = []

    var stack: [(PrecedenceGroupName, SyntaxProtocol?)] =
      [(initialGroupName, initialSyntax)]
    while let (currentGroupName, currentGroupSyntax) = stack.popLast() {
      guard let currentGroup = lookupGroup(currentGroupName) else {
        try errorHandler(
          .missingGroup(currentGroupName, referencedFrom: currentGroupSyntax))
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
            stack.append((otherGroupName, relation.syntax))
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
  func precedence(
    relating startGroupName: PrecedenceGroupName,
    to endGroupName: PrecedenceGroupName,
    startSyntax: SyntaxProtocol?,
    endSyntax: SyntaxProtocol?,
    errorHandler: OperatorPrecedenceErrorHandler = { throw $0 }
  ) rethrows -> Precedence {
    if startGroupName == endGroupName {
      return .unrelated
    }

    // Walk all of the relationships from the end down, then from the beginning
    // up, to determine whether there is a relation between the two groups.
    return try searchRelationships(
      initialGroupName: endGroupName, initialSyntax: endSyntax,
      targetGroupName: startGroupName, direction: .lowerThan,
      errorHandler: errorHandler
    ) ?? searchRelationships(
      initialGroupName: startGroupName, initialSyntax: startSyntax,
      targetGroupName: endGroupName, direction: .higherThan,
      errorHandler: errorHandler
    ) ?? .unrelated
  }
}
