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

/// Scope that introduces generic parameter or
/// primary associated type names and directs
/// futher lookup to it's `WithGenericParametersOrAssociatedTypesScopeSyntax`
/// parent scope's parent scope (i.e. on return, bypasses names
/// introduced by it's parent).
@_spi(Experimental) public protocol GenericParameterOrAssociatedTypeScopeSyntax: ScopeSyntax {}

@_spi(Experimental) extension GenericParameterOrAssociatedTypeScopeSyntax {
  /// Returns names matching lookup and bypasses
  /// `WithGenericParametersOrAssociatedTypesScopeSyntax` parent scope in futher lookup.
  ///
  /// example:
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
  /// scope (`WithGenericParametersOrAssociatedTypesScopeSyntax`).
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

  /// Bypasses names introduced by `WithGenericParametersOrAssociatedTypesScopeSyntax` parent scope.
  ///
  /// example:
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
  /// scope (`WithGenericParametersOrAssociatedTypesScopeSyntax`).
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
      as? WithGenericParametersOrAssociatedTypesScopeSyntax
    {
      return parentScope.lookupInParent(identifier, at: lookUpPosition, with: config)
    } else {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    }
  }
}
