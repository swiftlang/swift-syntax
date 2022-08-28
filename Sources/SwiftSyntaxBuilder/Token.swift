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

/// Represents `TokenSyntax` in `SwiftSyntaxBuilder`.
/// At the moment, this just wraps `TokenSyntax`, but we can make it store just the information necessary to build a `TokenSyntax` in the future.
public struct Token: SyntaxBuildable, ExpressibleAsTokenList, ExpressibleAsNonEmptyTokenList, ExpressibleAsBinaryOperatorExpr, ExpressibleAsDeclModifier, ExpressibleAsIdentifierExpr {
  let tokenSyntax: TokenSyntax

  var text: String {
    return tokenSyntax.text
  }

  init(tokenSyntax: TokenSyntax) {
    self.tokenSyntax = tokenSyntax
  }

  public func withLeadingTrivia(_ leadingTrivia: Trivia) -> Token {
    return Token(tokenSyntax: tokenSyntax.withLeadingTrivia(leadingTrivia))
  }

  public func withTrailingTrivia(_ leadingTrivia: Trivia) -> Token {
    return Token(tokenSyntax: tokenSyntax.withTrailingTrivia(leadingTrivia))
  }

  public func buildToken() -> TokenSyntax {
    return tokenSyntax
  }

  public func buildSyntax(format: Format, leadingTrivia: Trivia?) -> Syntax {
    return Syntax(tokenSyntax)
  }

  /// Conformance to ExpressibleAsTokenList
  public func createTokenList() -> TokenList {
    return TokenList([self])
  }

  /// Conformance to ExpressibleAsNonEmptyTokenList
  public func createNonEmptyTokenList() -> NonEmptyTokenList {
    return NonEmptyTokenList([self])
  }

  /// Conformance to ExpressibleAsBinaryOperatorExpr
  public func createBinaryOperatorExpr() -> BinaryOperatorExpr {
    return BinaryOperatorExpr(operatorToken: self)
  }

  /// Conformance to ExpressibleAsDeclModifier
  public func createDeclModifier() -> DeclModifier {
    return DeclModifier(name: self)
  }

  /// Conformance to ExpressibleAsIdentifierExpr
  public func createIdentifierExpr() -> IdentifierExpr {
    return IdentifierExpr(identifier: self)
  }

  public func createSyntaxBuildable() -> SyntaxBuildable {
    return createIdentifierExpr()
  }

  public func createExprBuildable() -> ExprBuildable {
    return createIdentifierExpr()
  }
}
