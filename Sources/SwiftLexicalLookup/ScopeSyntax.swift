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
  /// Returns all names that `for` refers to at this syntax node.
  /// Optional configuration can be passed as `config` to customize the lookup behavior.
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
  ///     a // <--- lookup here
  ///
  ///     let a = 0
  ///   }
  ///
  ///   func a() {
  ///     // ...
  ///   }
  /// }
  /// ```
  /// When calling this function on the declaration reference `a` within its name,
  /// the function returns the parameter first, then the identifier of the variable
  /// declaration, followed by the first function name, and then the second function name,
  /// in this exact order. The constant declaration within the function body is omitted
  /// due to the ordering rules that prioritize visibility within the function body.
  @_spi(Experimental) public func lookup(
    for identifier: Identifier?,
    with config: LookupConfig = LookupConfig()
  ) -> [LookupResult] {
    scope?.lookup(for: identifier, at: self, with: config) ?? []
  }
}

@_spi(Experimental) public protocol ScopeSyntax: SyntaxProtocol {
  /// Parent of this scope, or `nil` if it is the root.
  var parentScope: ScopeSyntax? { get }
  /// Names found in this scope. Ordered from first to last introduced.
  var introducedNames: [LookupName] { get }
  /// Finds all declarations `identifier` refers to. `syntax` specifies the node lookup was triggered with.
  /// If `identifier` set to `nil`, returns all available names at the given node.
  /// `state` represents lookup state passed between lookup methods.
  ///
  /// - Note: This method is intended for internal use only. For public usage, use ``ScopeSyntax/lookup(for:at:with:)`` instead.
  func _lookup(
    for identifier: Identifier?,
    at origin: SyntaxProtocol,
    with config: LookupConfig,
    state: LookupState
  ) -> [LookupResult]
}

@_spi(Experimental) extension ScopeSyntax {
  @_spi(Experimental) public var parentScope: ScopeSyntax? {
    self.parent?.scope
  }

  /// Returns `LookupResult` of all names introduced in this scope that `identifier`
  /// refers to and is accessible at given syntax node then passes lookup to the parent.
  /// If `identifier` set to `nil`, returns all available names at the given node.
  /// `state` represents lookup state passed between lookup methods.
  ///
  /// - Note: This method is intended for internal use only. For public usage, use ``ScopeSyntax/lookup(for:at:with:)`` instead.
  @_spi(Experimental) public func _lookup(
    for identifier: Identifier?,
    at origin: SyntaxProtocol,
    with config: LookupConfig,
    state: LookupState
  ) -> [LookupResult] {
    defaultLookupImplementation(for: identifier, at: origin, with: config, state: state)
  }

  /// Returns `LookupResult` of all names introduced in this scope that `identifier`
  /// refers to and is accessible at given syntax node then passes lookup to the parent.
  /// If `identifier` set to `nil`, returns all available names at the given node.
  @_spi(Experimental) public func lookup(
    for identifier: Identifier?,
    at origin: SyntaxProtocol,
    with config: LookupConfig
  ) -> [LookupResult] {
    _lookup(for: identifier, at: origin, with: config, state: LookupState())
  }

  /// Returns `LookupResult` of all names introduced in this scope that `identifier`
  /// refers to and is accessible at given syntax node then passes lookup to the parent.
  /// If `identifier` set to `nil`, returns all available names at the given node.
  func defaultLookupImplementation(
    for identifier: Identifier?,
    at origin: SyntaxProtocol,
    with config: LookupConfig,
    state: LookupState
  ) -> [LookupResult] {
    let filteredNames =
      introducedNames
      .filter { introducedName in
        checkName(identifier, refersTo: introducedName, at: origin)
      }

    if filteredNames.isEmpty {
      return lookupInParent(for: identifier, at: origin, with: config, state: state)
    } else {
      return [.fromScope(self, withNames: filteredNames)]
        + lookupInParent(for: identifier, at: origin, with: config, state: state)
    }
  }

  /// Looks up in parent scope.
  func lookupInParent(
    for identifier: Identifier?,
    at origin: SyntaxProtocol,
    with config: LookupConfig,
    state: LookupState
  ) -> [LookupResult] {
    parentScope?._lookup(for: identifier, at: origin, with: config, state: state) ?? []
  }

  func checkName(_ name: Identifier?, refersTo introducedName: LookupName, at origin: SyntaxProtocol) -> Bool {
    introducedName.isAccessible(at: origin) && (name == nil || introducedName.refersTo(name!))
  }
}
