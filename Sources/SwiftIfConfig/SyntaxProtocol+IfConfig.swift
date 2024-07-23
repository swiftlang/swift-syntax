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
  ///  #elseif B
  ///    func g()
  ///   #endif
  /// #endif
  ///
  /// a call to `isActive` on the syntax node for the function `g` would return `active` when the
  /// configuration options `DEBUG` and `B` are provided, but `A` is not.
  public func isActive(
    in configuration: some BuildConfiguration,
    diagnosticHandler: ((Diagnostic) -> Void)? = nil
  ) throws -> ConfiguredRegionState {
    var currentNode: Syntax = Syntax(self)
    var currentState: ConfiguredRegionState = .active

    while let parent = currentNode.parent {
      // If the parent is an `#if` configuration, check whether our current
      // clause is active. If not, we're in an inactive region. We also
      // need to determine whether
      if let ifConfigClause = currentNode.as(IfConfigClauseSyntax.self),
        let ifConfigDecl = ifConfigClause.parent?.parent?.as(IfConfigDeclSyntax.self)
      {
        let activeClause = ifConfigDecl.activeClause(
          in: configuration,
          diagnosticHandler: diagnosticHandler
        )

        if activeClause != ifConfigClause {
          // This was not the active clause, so we know that we're in an
          // inactive block. However, if the condition is versioned, this is an
          // unparsed region.
          let isVersioned =
            (try? ifConfigClause.isVersioned(
              configuration: configuration,
              diagnosticHandler: diagnosticHandler
            )) ?? true
          if isVersioned {
            return .unparsed
          }

          currentState = .inactive
        }
      }

      currentNode = parent
    }

    return currentState
  }

  /// Determine whether the given syntax node is active given a set of
  /// configured regions as produced by `configuredRegions(in:)`.
  ///
  /// This is
  /// an approximation
  public func isActive(
    inConfiguredRegions regions: [(IfConfigClauseSyntax, ConfiguredRegionState)]
  ) -> ConfiguredRegionState {
    var currentState: ConfiguredRegionState = .active
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
