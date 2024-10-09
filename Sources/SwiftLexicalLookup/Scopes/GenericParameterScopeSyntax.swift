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

/// Scope that introduces generic parameter names and directs
/// futher lookup to its `WithGenericParametersScopeSyntax`
/// parent scope's parent scope (i.e. on return, bypasses names
/// introduced by its parent).
protocol GenericParameterScopeSyntax: ScopeSyntax {}

@_spi(Experimental) extension GenericParameterScopeSyntax {
  /// Returns names matching lookup and bypasses
  /// `WithGenericParametersScopeSyntax` parent scope in futher lookup.
  ///
  /// ### Example
  /// ```swift
  /// let a = 23
  /// func foo<A>(a: A) {
  ///   a // <-- start lookup here
  /// }
  /// ```
  /// When starting lookup at the `a` reference,
  /// lookup first visits the code block scope associated
  /// with the function's body. Then, it's forwarded to the
  /// function declaration scope and then to generic parameter
  /// scope (`WithGenericParametersScopeSyntax`).
  /// Then, to ensure there is no infinite cycle,
  /// this method passes lookup to function scope's parent scope
  /// (in this case: file scope).
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    return defaultLookupImplementation(
      identifier,
      at: lookUpPosition,
      with: config,
      propagateToParent: false
    )
      + lookupBypassingParentResults(
        identifier,
        at: lookUpPosition,
        with: config
      )
  }

  /// Bypasses names introduced by `WithGenericParametersScopeSyntax` parent scope.
  ///
  /// ### Example
  /// ```swift
  /// let a = 23
  /// func foo<A>(a: A) {
  ///   a // <-- start lookup here
  /// }
  /// ```
  /// When starting lookup at the `a` reference,
  /// lookup first visits the code block scope associated
  /// with the function's body. Then, it's forwarded to the
  /// function declaration scope and then to generic parameter
  /// scope (`WithGenericParametersScopeSyntax`).
  /// Then, to ensure there is no infinite cycle,
  /// we use this method instead of the standard `lookupInParent`
  /// to pass lookup to the function scope's parent scope (in this case: file scope)
  /// and effectively bypass names already looked up before.
  private func lookupBypassingParentResults(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    guard let parentScope else { return [] }

    if let parentScope = Syntax(parentScope).asProtocol(SyntaxProtocol.self)
      as? WithGenericParametersScopeSyntax
    {
      return parentScope.returningLookupFromGenericParameterScope(identifier, at: lookUpPosition, with: config)
    } else {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    }
  }
}
