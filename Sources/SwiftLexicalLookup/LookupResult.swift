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

/// Represents resul
@_spi(Experimental) public enum LookupResult {
  /// Scope and the names that matched lookup.
  case fromScope(ScopeSyntax, withNames: [LookupName])
  /// File scope, names that matched lookup and name introduction
  /// strategy used for the lookup.
  case fromFileScope(SourceFileSyntax, withNames: [LookupName], nameIntroductionStrategy: FileScopeNameIntroductionStrategy)

  /// Associated scope.
  @_spi(Experimental) public var scope: ScopeSyntax? {
    switch self {
    case .fromScope(let scopeSyntax, _):
      scopeSyntax
    case .fromFileScope(let fileScopeSyntax, withNames: _, nameIntroductionStrategy: _):
      fileScopeSyntax
    }
  }

  /// Names that matched lookup.
  @_spi(Experimental) public var names: [LookupName] {
    switch self {
    case .fromScope(_, let names):
      names
    case .fromFileScope(_, withNames: let names, nameIntroductionStrategy: _):
      names
    }
  }
}
