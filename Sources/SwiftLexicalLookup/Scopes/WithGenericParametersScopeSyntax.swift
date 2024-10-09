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

@_spi(Experimental) public protocol WithGenericParametersScopeSyntax: ScopeSyntax {
  var genericParameterClause: GenericParameterClauseSyntax? { get }

  func returningLookupFromGenericParameterScope(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult]
}

@_spi(Experimental) extension WithGenericParametersScopeSyntax {
  /// Returns names matching lookup and passes lookup to
  /// the generic parameter clause scopes.
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
  /// scope (`WithGenericParametersScopeSyntax`)
  /// instead of it's actual parent scope (in this case: file scope).
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    return defaultLookupImplementation(
      identifier,
      at: position,
      with: config,
      propagateToParent: false
    )
      + lookupThroughGenericParameterScope(
        identifier,
        at: lookUpPosition,
        with: config
      )
  }

  /// Passes lookup to this scope's generic parameter or
  /// primary associated type clause scope (`WithGenericParametersScopeSyntax`).
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
  /// scope (`WithGenericParametersScopeSyntax`)
  /// with this method (instead of using standard `lookupInParent`).
  @_spi(Experimental) public func lookupThroughGenericParameterScope(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if let genericParameterClause {
      return genericParameterClause.lookup(identifier, at: lookUpPosition, with: config)
    } else {
      return returningLookupFromGenericParameterScope(identifier, at: lookUpPosition, with: config)
    }
  }

  @_spi(Experimental) public func returningLookupFromGenericParameterScope(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    lookupInParent(identifier, at: lookUpPosition, with: config)
  }
}
