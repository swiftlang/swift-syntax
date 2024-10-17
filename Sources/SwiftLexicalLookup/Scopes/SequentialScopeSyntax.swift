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
protocol SequentialScopeSyntax: ScopeSyntax {}

extension SequentialScopeSyntax {
  /// Returns names introduced by `codeBlockItems`
  /// and included `IntroducingToSequentialParentScopeSyntax` children
  /// scopes that match the lookup.
  ///
  /// ### Example
  /// ```swift
  /// func foo() {
  ///   let a = 1
  ///   guard let a = x else { return }
  ///   let a = a // <-- 1
  ///   guard let a = y else { return }
  ///   a // <-- 2
  /// }
  /// ```
  /// For the first `a` reference, sequential lookup returns
  /// two results: from `guard` scope and from code block scope
  /// in this exact order. For the second `a` reference,
  /// sequential lookup yields results from four scopes starting
  /// from the bottom: `guard`, code block, `guard` and
  /// code block scope in this exact order.
  func sequentialLookup(
    in codeBlockItems: some Collection<CodeBlockItemSyntax>,
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    ignoreNamedDecl: Bool = false,
    propagateToParent: Bool = true
  ) -> [LookupResult] {
    // Sequential scope needs to ensure all type declarations are
    // available in the whole scope (first loop) and
    // then that results from IntroducingToSequentialParentScopeSyntax
    // are properly interleaved with the results produced by this scope.
    var results: [LookupResult] = []
    // We need to use currentChunk because we
    // can't add the names directly to results
    // as we need to partition them based on results
    // obtained from IntroducingToSequentialParentScopeSyntax
    var currentChunk: [LookupName] = []
    // During first iteration, the algorithm collects all named
    // decls from the code block and (nested) active clauses
    // of if config declarations. After the first pass, performs
    // name matching on these and appends as a separate result to the results.
    var collectedNamedDecls: [NamedDeclSyntax] = []

    for codeBlockItem in codeBlockItems.reversed() {
      if let namedDecl = codeBlockItem.item.asProtocol(NamedDeclSyntax.self) {
        guard !ignoreNamedDecl else { continue }

        collectedNamedDecls.append(namedDecl)
        continue
      } else if let ifConfigDecl = codeBlockItem.item.as(IfConfigDeclSyntax.self),
        !ignoreNamedDecl
      {
        collectedNamedDecls += ifConfigDecl.getNamedDecls(for: config)
      }

      if let introducingToParentScope = Syntax(codeBlockItem.item).asProtocol(SyntaxProtocol.self)
        as? IntroducingToSequentialParentScopeSyntax
      {
        // Get results from encountered scope.
        let introducedResults = introducingToParentScope.lookupFromSequentialParent(
          identifier,
          at: lookUpPosition,
          with: config
        )

        // Skip, if no results were found.
        guard !introducedResults.isEmpty else { continue }

        // If there are some names collected, create a new result for this scope.
        if !currentChunk.isEmpty {
          results.append(LookupResult.getResult(for: self, withNames: currentChunk))
          currentChunk = []
        }

        results += introducedResults
      } else {
        // Extract new names from encountered node.
        currentChunk += LookupName.getNames(
          from: codeBlockItem.item,
          accessibleAfter: codeBlockItem.item.endPosition
        ).filter { introducedName in
          checkIdentifier(identifier, refersTo: introducedName, at: lookUpPosition)
        }
      }
    }

    // If there are some names collected, create a new result for this scope.
    if !currentChunk.isEmpty {
      results.append(LookupResult.getResult(for: self, withNames: currentChunk))
      currentChunk = []
    }

    // Filter named decls to be appended to the results.
    for namedDecl in collectedNamedDecls.reversed() {
      currentChunk += LookupName.getNames(
        from: namedDecl,
        accessibleAfter: namedDecl.endPosition
      ).filter { introducedName in
        checkIdentifier(identifier, refersTo: introducedName, at: lookUpPosition)
      }
    }

    results += LookupResult.getResultArray(for: self, withNames: currentChunk)

    return results
      + (config.finishInSequentialScope || !propagateToParent
        ? [] : lookupInParent(identifier, at: lookUpPosition, with: config))
  }
}
