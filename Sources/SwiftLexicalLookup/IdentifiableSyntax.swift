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

/// Syntax node that can be refered to with an identifier.
public protocol IdentifiableSyntax: SyntaxProtocol {
  var identifier: TokenSyntax { get }
}

extension IdentifierPatternSyntax: IdentifiableSyntax {}

extension ClosureParameterSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    secondName ?? firstName
  }
}

extension ClosureShorthandParameterSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    name
  }
}

extension ClosureCaptureSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    /* Doesn't work with closures like:
     _ = { [y=1+2] in
       print(y)
     }
     */
    expression.as(DeclReferenceExprSyntax.self)!.baseName
  }
}
