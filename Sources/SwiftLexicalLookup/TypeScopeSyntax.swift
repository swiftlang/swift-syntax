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

@_spi(Experimental) public protocol TypeScopeSyntax: ScopeSyntax, DeclSyntaxProtocol {}

extension TypeScopeSyntax {
  @_spi(Experimental) public var implicitInstanceAndTypeNames: [LookupName] {
    [.implicit(.self(self)), .implicit(.Self(self))]
  }

  @_spi(Experimental) public var introducedNames: [LookupName] {
    implicitInstanceAndTypeNames
  }
}
