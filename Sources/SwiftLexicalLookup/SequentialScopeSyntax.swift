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

import SwiftSyntax

/// Scope that, in addition to names introduced by itself,
/// also handles names introduced by
/// `IntroducingToSequentialParentScopeSyntax` children scopes.
protocol SequentialScopeSyntax: ScopeSyntax {
  /// Returns names introduced by `codeBlockItems`
  /// and included `IntroducingToSequentialParentScopeSyntax` children
  /// scopes that match the lookup.
  func sequentialLookup(
    in codeBlockItems: any Collection<CodeBlockItemSyntax>,
    for identifier: Identifier?,
    at syntax: SyntaxProtocol,
    with config: LookupConfig,
    state: LookupState,
    createResultsForThisScopeWith getResults: ([LookupName]) -> (LookupResult)
  ) -> [LookupResult]
}

extension SequentialScopeSyntax {
  func sequentialLookup(
    in codeBlockItems: any Collection<CodeBlockItemSyntax>,
    for identifier: Identifier?,
    at syntax: SyntaxProtocol,
    with config: LookupConfig,
    state: LookupState,
    createResultsForThisScopeWith getResults: ([LookupName]) -> (LookupResult)
  ) -> [LookupResult] {
    var result = [LookupResult]()
    var currentChunk = [LookupName]()

    for codeBlockItem in codeBlockItems {
      if let introducingToParentScope = Syntax(codeBlockItem.item).asProtocol(SyntaxProtocol.self)
        as? IntroducingToSequentialParentScopeSyntax
      {
        // Check if the enocountered scope should be ignored.
        if let scopeToSkip = state.skipSequentialIntroductionFrom,
          scopeToSkip.id == introducingToParentScope.id
        {
          continue
        }

        // If there are some names collected, create a new result for this scope.
        if !currentChunk.isEmpty {
          result.append(getResults(currentChunk))
          currentChunk = []
        }

        // Add names introduced by the encountered scope.
        result.append(
          contentsOf: introducingToParentScope.introducesToSequentialParent(
            for: identifier,
            at: syntax,
            with: config,
            state: state
          )
        )
      } else {
        // Extract new names from encountered node.
        currentChunk.append(
          contentsOf:
            LookupName.getNames(
              from: codeBlockItem.item,
              accessibleAfter: codeBlockItem.endPosition
            ).filter { introducedName in
              checkName(name, refersTo: introducedName, at: syntax)
            }
        )
      }
    }

    // If there are some names collected, create a new result for this scope.
    if !currentChunk.isEmpty {
      result.append(getResults(currentChunk))
      currentChunk = []
    }

    return (result.isEmpty ? [] : result.reversed()) + lookupInParent(for: identifier, at: syntax, with: config, state: state)
  }
}
