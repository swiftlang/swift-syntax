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
protocol IdentifiableSyntax: SyntaxProtocol {
  var identifier: TokenSyntax { get }
}

extension IdentifierPatternSyntax: IdentifiableSyntax {}

extension ClosureParameterSyntax: IdentifiableSyntax {
  var identifier: TokenSyntax {
    secondName ?? firstName
  }
}

extension FunctionParameterSyntax: IdentifiableSyntax {
  var identifier: TokenSyntax {
    secondName ?? firstName
  }
}

extension ClosureShorthandParameterSyntax: IdentifiableSyntax {
  var identifier: TokenSyntax {
    name
  }
}

extension ClosureCaptureSyntax: IdentifiableSyntax {
  var identifier: TokenSyntax {
    name
  }
}

extension AccessorParametersSyntax: IdentifiableSyntax {
  var identifier: TokenSyntax {
    name
  }
}

extension GenericParameterSyntax: IdentifiableSyntax {
  var identifier: TokenSyntax {
    name
  }
}

extension PrimaryAssociatedTypeSyntax: IdentifiableSyntax {
  var identifier: TokenSyntax {
    name
  }
}
