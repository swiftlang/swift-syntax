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
@_spi(Experimental) public protocol SequentialScopeSyntax: ScopeSyntax {
  /// Returns names introduced by `codeBlockItems`
  /// and included `IntroducingToSequentialParentScopeSyntax` children
  /// scopes that match the lookup.
  func sequentialLookup(
    in codeBlockItems: any Collection<CodeBlockItemSyntax>,
    for name: String?,
    at syntax: SyntaxProtocol,
    with config: LookupConfig,
    createResultsForThisScopeWith getResults: ([LookupName]) -> (LookupResult)
  ) -> [LookupResult]
}

@_spi(Experimental) extension SequentialScopeSyntax {
  public func sequentialLookup(
    in codeBlockItems: any Collection<CodeBlockItemSyntax>,
    for name: String?,
    at syntax: SyntaxProtocol,
    with config: LookupConfig,
    createResultsForThisScopeWith getResults: ([LookupName]) -> (LookupResult)
  ) -> [LookupResult] {
    var result = [LookupResult]()
    var currentChunk = [LookupName]()

    for codeBlockItem in codeBlockItems {
      if let introducingToParentScope = Syntax(codeBlockItem.item).asProtocol(SyntaxProtocol.self)
        as? IntroducingToSequentialParentScopeSyntax
      {
        guard
          !config.ignoreChildrenToSequentialParentIntroductionsFrom.contains(where: {
            $0.id == introducingToParentScope.id
          })
        else {
          continue
        }

        if !currentChunk.isEmpty {
          result.append(getResults(currentChunk))
          currentChunk = []
        }

        result.append(
          contentsOf: introducingToParentScope.introducesToSequentialParent(for: name, at: syntax, with: config)
        )
      } else {
        currentChunk.append(
          contentsOf:
            LookupName.getNames(
              from: codeBlockItem.item,
              accessibleAfter: codeBlockItem.endPosition
            ).filter { introducedName in
              does(name: name, referTo: introducedName, at: syntax)
            }
        )
      }
    }

    if !currentChunk.isEmpty {
      result.append(getResults(currentChunk))
      currentChunk = []
    }

    return (result.isEmpty ? [] : result.reversed()) + lookupInParent(for: name, at: syntax, with: config)
  }
}
