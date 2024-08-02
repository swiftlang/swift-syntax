//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftSyntax

extension SyntaxProtocol {
  /// Determine whether the given syntax node is active within the given build configuration.
  ///
  /// This function evaluates the enclosing stack of `#if` conditions to determine whether the
  /// given node is active in the program when it is compiled with the given build configuration.
  ///
  /// For example, given code like the following:
  /// #if DEBUG
  ///   #if A
  ///    func f()
  ///   #elseif B
  ///     func g()
  ///   #elseif compiler(>= 12.0)
  ///     please print the number after 41
  ///   #endif
  /// #endif
  ///
  /// a call to `isActive` on the syntax node for the function `g` would return `active` when the
  /// configuration options `DEBUG` and `B` are provided, but `A` is not.
  ///
  /// If the compiler version is smaller than 12.0, then `isActive` on any of the tokens within
  /// that `#elseif` block would return "unparsed", because that syntax should not (conceptually)
  /// be parsed.
  public func isActive(
    in configuration: some BuildConfiguration
  ) -> (state: IfConfigRegionState, diagnostics: [Diagnostic]) {
    var currentNode: Syntax = Syntax(self)
    var currentState: IfConfigRegionState = .active
    var diagnostics: [Diagnostic] = []

    while let parent = currentNode.parent {
      // If the parent is an `#if` configuration, check whether our current
      // clause is active. If not, we're in an inactive region. We also
      // need to determine whether an inactive region should be parsed or not.
      if let ifConfigClause = currentNode.as(IfConfigClauseSyntax.self),
        let ifConfigDecl = ifConfigClause.parent?.parent?.as(IfConfigDeclSyntax.self)
      {
        let (activeClause, localDiagnostics) = ifConfigDecl.activeClause(in: configuration)
        diagnostics.append(contentsOf: localDiagnostics)

        if activeClause != ifConfigClause {
          // This was not the active clause, so we know that we're in an
          // inactive block. If syntax errors aren't allowable, this is an
          // unparsed region.
          let (syntaxErrorsAllowed, localDiagnostics) = ifConfigClause.syntaxErrorsAllowed(
            configuration: configuration
          )
          diagnostics.append(contentsOf: localDiagnostics)

          if syntaxErrorsAllowed {
            return (.unparsed, diagnostics)
          }

          currentState = .inactive
        }
      }

      currentNode = parent
    }

    return (currentState, diagnostics)
  }

  /// Determine whether the given syntax node is active given a set of
  /// configured regions as produced by `configuredRegions(in:)`.
  ///
  /// If you are querying whether many syntax nodes in a particular file are
  /// active, consider calling `configuredRegions(in:)` once and using
  /// this function. For occasional queries, use `isActive(in:)`.
  public func isActive(
    inConfiguredRegions regions: [(IfConfigClauseSyntax, IfConfigRegionState)]
  ) -> IfConfigRegionState {
    var currentState: IfConfigRegionState = .active
    for (ifClause, state) in regions {
      if self.position < ifClause.position {
        return currentState
      }

      if self.position <= ifClause.endPosition {
        currentState = state
      }
    }

    return currentState
  }
}
