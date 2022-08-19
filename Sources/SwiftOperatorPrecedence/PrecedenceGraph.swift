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

    // Keep track of all of the groups we have seen during our exploration of
    // the graph. This detects cycles and prevents extraneous work.
    var groupsSeen: Set<PrecedenceGroupName> = []

    // Walk all of the lower-than relationships from the end group. If we
    // reach the start group, the start has lower precedence than the end.
    var stack: [(PrecedenceGroupName, SyntaxProtocol?)] =
      [(endGroupName, endSyntax)]
    while let (currentGroupName, currentGroupSyntax) = stack.popLast() {
      guard let currentGroup = lookupGroup(currentGroupName) else {
        try errorHandler(
          .missingGroup(currentGroupName, referencedFrom: currentGroupSyntax))
        continue
      }

      for relation in currentGroup.relations {
        if relation.kind == .lowerThan {
          // If we hit our start group, we're done.
          let otherGroupName = relation.groupName
          if otherGroupName == startGroupName {
            return .lowerThan
          }

          if groupsSeen.insert(otherGroupName).inserted {
            stack.append((otherGroupName, relation.syntax))
          }
        }
      }
    }

    // Walk all of the higher-than relationships from the start group. If we
    // reach the end group, the start has higher precedence than the end.
    assert(stack.isEmpty)
    groupsSeen.removeAll()
    stack.append((startGroupName, startSyntax))
    while let (currentGroupName, currentGroupSyntax) = stack.popLast() {
      guard let currentGroup = lookupGroup(currentGroupName) else {
        try errorHandler(
          .missingGroup(currentGroupName, referencedFrom: currentGroupSyntax))
        continue
      }

      for relation in currentGroup.relations {
        if relation.kind == .higherThan {
          // If we hit our end group, we're done.
          let otherGroupName = relation.groupName
          if otherGroupName == endGroupName {
            return .higherThan
          }

          if groupsSeen.insert(otherGroupName).inserted {
            stack.append((otherGroupName, relation.syntax))
          }
        }
      }
    }

    // The two are incomparable.
    return .unrelated
  }
}
