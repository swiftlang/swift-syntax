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

extension SyntaxProtocol {
  /// Returns all names that `identifier` refers to at this syntax node.
  /// Optional configuration can be passed as `config` to customize the lookup behavior.
  /// Optional cache can be passed as `cache` to significantly speed up large
  /// amounts of subsequent lookups.
  ///
  /// - Note: Even though cache can significantly speed up large amounts of subsequent lookups,
  /// it shouldn't be used for one-off lookups as the initial cost of building up cache could be higher that the total time saved.
  ///
  /// - Returns: An array of `LookupResult` for `identifier`  at this syntax node,
  /// ordered by visibility. If `identifier` is set to `nil`, returns all available names ordered by visibility.
  /// The order is from the innermost to the outermost scope,
  /// and within each result, names are ordered by their introduction
  /// in the source code.
  ///
  /// Example usage:
  /// ```swift
  /// class C {
  ///   var a = 42
  ///
  ///   func a(a: Int) {
  ///     let a = a
  ///     a // <--- lookup here
  ///
  ///     let a = 0
  ///   }
  /// }
  /// ```
  /// When calling this function on the declaration reference `a` within its name,
  /// the function returns the variable declaration `let a = a` first, then the function parameter,
  /// and lastly `LookupResult.lookInMembers` in this exact order.
  /// The second declaration within the function body is omitted
  /// due to the ordering rules within the function body.
  public func lookup(
    _ identifier: Identifier?,
    with config: LookupConfig = LookupConfig(),
    cache: LookupCache? = nil
  ) -> [LookupResult] {
    scope?.lookup(identifier, at: self.position, with: config, cache: cache) ?? []
  }
}

@_spi(Experimental) public protocol ScopeSyntax: SyntaxProtocol {
  /// Parent of this scope, or `nil` if it is the root.
  var parentScope: ScopeSyntax? { get }
  /// Names introduced by default in this scope.
  /// Don't include names that might be added depending on the lookup position (like `self`).
  /// Ordered from first to last introduced.
  var defaultIntroducedNames: [LookupName] { get }
  /// Debug description of this scope.
  var scopeDebugName: String { get }
  /// Finds all declarations `identifier` refers to. `syntax` specifies the node lookup was triggered with.
  /// If `identifier` set to `nil`, returns all available names at the given node.
  func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    cache: LookupCache?
  ) -> [LookupResult]
}

@_spi(Experimental) extension ScopeSyntax {
  @_spi(Experimental) public var parentScope: ScopeSyntax? {
    self.parent?.scope
  }

  /// Returns `LookupResult` of all names introduced in this scope that `identifier`
  /// refers to and is accessible at given syntax node then passes lookup to the parent.
  /// If `identifier` set to `nil`, returns all available names at the given node.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    cache: LookupCache?
  ) -> [LookupResult] {
    defaultLookupImplementation(identifier, at: lookUpPosition, with: config, cache: cache)
  }

  /// Returns `LookupResult` of all names introduced in this scope that `identifier`
  /// refers to and is accessible at given syntax node then passes lookup to the parent.
  /// If `identifier` set to `nil`, returns all available names at the given node.
  func defaultLookupImplementation(
    in names: [LookupName]? = nil,
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    cache: LookupCache?,
    propagateToParent: Bool = true
  ) -> [LookupResult] {
    let filteredNames =
      (names ?? defaultIntroducedNames)
      .filter { introducedName in
        checkIdentifier(identifier, refersTo: introducedName, at: lookUpPosition)
      }

    return LookupResult.getResultArray(for: self, withNames: filteredNames)
      + (propagateToParent ? lookupInParent(identifier, at: lookUpPosition, with: config, cache: cache) : [])
  }

  /// Looks up in parent scope.
  func lookupInParent(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    cache: LookupCache?
  ) -> [LookupResult] {
    guard !config.finishInSequentialScope else {
      return parentScope?.lookup(identifier, at: lookUpPosition, with: config, cache: cache) ?? []
    }

    if let cachedAncestorResults = cache?.getCachedAncestorResults(id: id) {
      return cachedAncestorResults
    }

    let ancestorResults = parentScope?.lookup(identifier, at: lookUpPosition, with: config, cache: cache) ?? []

    if let cache {
      cache.setCachedAncestorResults(id: id, results: ancestorResults)
    }

    return ancestorResults
  }

  func checkIdentifier(
    _ identifier: Identifier?,
    refersTo introducedName: LookupName,
    at lookUpPosition: AbsolutePosition
  ) -> Bool {
    introducedName.isAccessible(at: lookUpPosition) && introducedName.refersTo(identifier)
  }

  var isMember: Bool {
    if parentScope?.is(MemberBlockSyntax.self) ?? false {
      return true
    } else if let parentIfConfig = parentScope?.as(IfConfigDeclSyntax.self) {
      return parentIfConfig.isMember
    } else {
      return false
    }
  }

  /// Debug description of this scope.
  @_spi(Experimental) public var scopeDebugDescription: String {
    scopeDebugName + " " + debugLineWithColumnDescription
  }

  /// Hierarchy of scopes starting from this scope.
  @_spi(Experimental) public var scopeDebugHierarchyDescription: String {
    if let parentScope = parentScope {
      return parentScope.scopeDebugHierarchyDescription + " <-- " + scopeDebugDescription
    } else {
      return scopeDebugDescription
    }
  }
}
