//// Automatically Generated From TokenSyntax.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax


extension TokenSyntax: ExpressibleAsTokenList, ExpressibleAsNonEmptyTokenList, ExpressibleAsBinaryOperatorExpr, ExpressibleAsDeclModifier, ExpressibleAsIdentifierExpr {
  /// Conformance to `ExpressibleAsTokenList`.
  public func createTokenList() -> TokenList {
    return TokenList([self])
  }
  /// Conformance to `ExpressibleAsNonEmptyTokenList`.
  public func createNonEmptyTokenList() -> NonEmptyTokenList {
    return NonEmptyTokenList([self])
  }
  /// Conformance to `ExpressibleAsBinaryOperatorExpr`.
  public func createBinaryOperatorExpr() -> BinaryOperatorExpr {
    return BinaryOperatorExpr(operatorToken: self)
  }
  /// Conformance to `ExpressibleAsDeclModifier`.
  public func createDeclModifier() -> DeclModifier {
    return DeclModifier(name: self)
  }
  /// Conformance to `ExpressibleAsIdentifierExpr`.
  public func createIdentifierExpr() -> IdentifierExpr {
    return IdentifierExpr(identifier: self)
  }
}

/// `TokenSyntax` conforms to `SyntaxBuildable` and `ExprBuildable` via different paths, so we need to pick one default conversion path to create an an `ExprSyntax` (and `Syntax`) from a `String`. We choose `IdentifierExpr`.
extension TokenSyntax {
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return createIdentifierExpr()
  }

  public func createExprBuildable() -> ExprBuildable {
    return createIdentifierExpr()
  }
}
