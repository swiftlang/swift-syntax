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
@_spi(Experimental) public protocol IdentifiableSyntax: SyntaxProtocol {
  var identifier: TokenSyntax { get }
}

@_spi(Experimental) extension IdentifierPatternSyntax: IdentifiableSyntax {}

@_spi(Experimental) extension ClosureParameterSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    secondName ?? firstName
  }
}

@_spi(Experimental) extension FunctionParameterSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    secondName ?? firstName
  }
}

@_spi(Experimental) extension ClosureShorthandParameterSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    name
  }
}

@_spi(Experimental) extension ClosureCaptureSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    name
  }
}

@_spi(Experimental) extension AccessorParametersSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    name
  }
}

@_spi(Experimental) extension GenericParameterSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    name
  }
}

@_spi(Experimental) extension PrimaryAssociatedTypeSyntax: IdentifiableSyntax {
  @_spi(Experimental) public var identifier: TokenSyntax {
    name
  }
}
