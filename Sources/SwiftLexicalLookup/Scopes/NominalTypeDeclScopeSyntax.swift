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

/// Helper scope for nominal types (structs, enums, classes, actors, protocols).
@_spi(Experimental)
public protocol NominalTypeDeclScopeSyntax: NominalTypeDeclSyntaxProtocol, ScopeSyntax, LookInMembersScopeSyntax {}

extension NominalTypeDeclScopeSyntax /*: LookInMembersScopeSyntax */ {
  @_spi(Experimental) public var lookupMembersPosition: AbsolutePosition {
    name.positionAfterSkippingLeadingTrivia
  }
}

// Default implementations for structs/enums/classes/actors, which have
// generic parameters instead of primary-associated types.
extension NominalTypeDeclScopeSyntax where Self: WithGenericParametersScopeSyntax, Self: WithGenericParametersSyntax {
  /// Function used by generic parameter clause
  /// scope on return from it's lookup.
  @_spi(Experimental) public func returningLookupFromGenericParameterScope(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    // Don't look for members if we're in the name, generic-parameter clause,
    // inheritance clause, or generic-where clause.
    let lookInMembers: [LookupResult]
    if name.range.contains(lookUpPosition)
      || genericParameterClause?.range.contains(lookUpPosition) == true
      || inheritanceClause?.range.contains(lookUpPosition) == true
      || genericWhereClause?.range.contains(lookUpPosition) == true
    {
      lookInMembers = []
    } else {
      lookInMembers = [LookupResult.lookForMembers(in: Syntax(self))]
    }

    return lookInMembers + lookupInParent(identifier, at: lookUpPosition, with: config)
  }
}
