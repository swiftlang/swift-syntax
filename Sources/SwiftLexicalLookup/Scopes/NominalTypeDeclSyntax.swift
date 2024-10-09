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

@_spi(Experimental)
public protocol NominalTypeDeclSyntax: LookInMembersScopeSyntax, NamedDeclSyntax, WithGenericParametersScopeSyntax {
  var genericParameterClause: GenericParameterClauseSyntax? { get }
  var genericWhereClause: GenericWhereClauseSyntax? { get }
  var inheritanceClause: InheritanceClauseSyntax? { get }
}

extension NominalTypeDeclSyntax {
  @_spi(Experimental) public var lookupMembersPosition: AbsolutePosition {
    name.positionAfterSkippingLeadingTrivia
  }

  /// Nominal type doesn't introduce any names by itself.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    []
  }

  /// Function used by generic parameter clause
  /// scope on return from it's lookup.
  @_spi(Experimental) public func returningLookupFromGenericParameterScope(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if let inheritanceClause, inheritanceClause.range.contains(lookUpPosition) {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    } else if let genericParameterClause, genericParameterClause.range.contains(lookUpPosition) {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    } else if name.range.contains(lookUpPosition) || genericWhereClause?.range.contains(lookUpPosition) ?? false {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    } else {
      return [.lookInMembers(self)] + lookupInParent(identifier, at: lookUpPosition, with: config)
    }
  }
}
