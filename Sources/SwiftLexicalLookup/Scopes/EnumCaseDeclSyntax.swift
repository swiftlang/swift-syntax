//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

@_spi(Experimental) extension EnumCaseDeclSyntax: ScopeSyntax {
  /// Associated-value parameter names introduced by this case declaration.
  ///
  /// Names are position-gated and only visible inside default-value expressions
  /// of subsequent parameters within the same case element, e.g.:
  /// ```swift
  /// enum E {
  ///   case foo(x: Int, y: Int = x) // `x` visible in `y`'s default
  /// }
  /// ```
  /// Parameters from one case element are not visible inside another.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    elements.flatMap { element in
      element.parameterClause?.parameters.flatMap { param in
        LookupName.getNames(from: param)
      } ?? []
    }
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "EnumCaseDeclScope"
  }

  /// Looks up `identifier` from inside this case declaration.
  ///
  /// Only introduces names when lookup originates from a parameter's
  /// default-value expression. Names visible are those of all prior
  /// parameters within the same case element.
  ///
  /// Lookup from outside the declaration (e.g. in the enum body) is
  /// forwarded to the parent scope with no names introduced.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    for element in elements {
      guard let paramClause = element.parameterClause else { continue }

      for (index, param) in paramClause.parameters.enumerated() {
        guard let defaultValue = param.defaultValue,
          defaultValue.range.contains(lookUpPosition)
        else { continue }

        // Collect names from params before this one in the same element.
        let priorNames = paramClause.parameters.prefix(index).flatMap { prior in
          LookupName.getNames(from: prior)
        }.filter { $0.refersTo(identifier) }

        return LookupResult.getResultArray(for: self, withNames: priorNames)
          + lookupInParent(identifier, at: lookUpPosition, with: config)
      }
    }

    return lookupInParent(identifier, at: lookUpPosition, with: config)
  }
}
