//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

extension BooleanLiteralExprSyntax {
  var literalValue: Bool {
    return literal.tokenKind == .keyword(.true)
  }
}

extension TupleExprSyntax {
  /// Whether this tuple is a parenthesized expression, e.g., (x).
  var isParentheses: Bool {
    return elements.singleUnlabeledExpression != nil
  }
}

extension ExprSyntax {
  /// Whether this is a simple identifier expression and, if so, what the identifier string is.
  var simpleIdentifierExpr: Identifier? {
    guard let identExpr = self.as(DeclReferenceExprSyntax.self) else {
      return nil
    }

    return identExpr.simpleIdentifier
  }
}

extension DeclReferenceExprSyntax {
  /// If this declaration reference is a simple identifier, return that
  /// string.
  var simpleIdentifier: Identifier? {
    guard argumentNames == nil else {
      return nil
    }

    return baseName.identifier
  }
}
