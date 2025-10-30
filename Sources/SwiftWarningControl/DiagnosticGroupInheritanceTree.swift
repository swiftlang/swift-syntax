//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// A struct wrapper for a diagnostic group inheritance tree
/// represented with a dictionary of a group identifier to an array
/// of its sub-group identifiers.
@_spi(ExperimentalLanguageFeatures)
public struct DiagnosticGroupInheritanceTree {
  private let subGroups: [DiagnosticGroupIdentifier: [DiagnosticGroupIdentifier]]
  public init(subGroups: [DiagnosticGroupIdentifier: [DiagnosticGroupIdentifier]]) throws {
    self.subGroups = subGroups
    if hasCycle() {
      throw WarningControlError.groupInheritanceCycle
    }
  }
  init() {
    self.subGroups = [:]
  }

  /// Diagnostic groups that inherit from `group`.
  func subgroups(of group: DiagnosticGroupIdentifier) -> [DiagnosticGroupIdentifier] { subGroups[group] ?? [] }
}

extension DiagnosticGroupInheritanceTree {
  // Check the subgroup tree for possible cycles
  func hasCycle() -> Bool {
    var visited: Set<DiagnosticGroupIdentifier> = []
    var recursionStack: Set<DiagnosticGroupIdentifier> = []
    func hasCycleFromGroup(_ group: DiagnosticGroupIdentifier) -> Bool {
      if visited.insert(group).inserted {
        recursionStack.insert(group)
        let subgroups = self.subgroups(of: group)
        for subGroup in subgroups {
          if recursionStack.contains(subGroup) {
            return true
          } else if !visited.contains(subGroup), hasCycleFromGroup(subGroup) {
            return true
          }
        }
      }
      recursionStack.remove(group)
      return false
    }

    for group in subGroups.keys {
      if !visited.contains(group), hasCycleFromGroup(group) {
        return true
      }
    }
    return false
  }
}

/// Describes the kinds of diagnostics that can occur when processing warning
/// group control queries. This is an Error-conforming type so we can throw errors when
/// needed.
@_spi(ExperimentalLanguageFeatures)
public enum WarningControlError: Error, CustomStringConvertible {
  case groupInheritanceCycle

  public var description: String {
    switch self {
    case .groupInheritanceCycle:
      return "cycle detected in the warning group inheritance hierarchy"
    }
  }
}
