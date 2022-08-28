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

extension String: ExpressibleAsSimpleTypeIdentifier {
  public func createSimpleTypeIdentifier() -> SimpleTypeIdentifier {
    return SimpleTypeIdentifier(self)
  }
}

extension String: ExpressibleAsIdentifierPattern {
  public func createIdentifierPattern() -> IdentifierPattern {
    return IdentifierPattern(self)
  }
}

extension String: ExpressibleAsIdentifierExpr {
  public func createIdentifierExpr() -> IdentifierExpr {
    return IdentifierExpr(self)
  }
}

extension String: ExpressibleAsStringLiteralExpr {
  public func createStringLiteralExpr() -> StringLiteralExpr {
    return StringLiteralExpr(self)
  }
}

extension String: ExpressibleAsBinaryOperatorExpr {
  public func createBinaryOperatorExpr() -> BinaryOperatorExpr {
    return BinaryOperatorExpr(self)
  }
}

extension String: ExpressibleAsReturnClause {
  public func createReturnClause() -> ReturnClause {
    return ReturnClause(returnType: self)
  }
}

extension String: ExpressibleAsAccessPathComponent {
  public func createAccessPathComponent() -> AccessPathComponent {
    return AccessPathComponent(name: self)
  }
}

extension String: ExpressibleAsTypeInitializerClause {
  public func createTypeInitializerClause() -> TypeInitializerClause {
    return TypeInitializerClause(value: self)
  }
}

/// Default conformance to `ExpressibleByTypeBuildable`
extension String {
  public func createTypeBuildable() -> TypeBuildable {
    return SimpleTypeIdentifier(self)
  }
}

/// Default conformance to `ExpressibleByPatternBuildable`
extension String {
  public func createPatternBuildable() -> PatternBuildable {
    return IdentifierPattern(self)
  }
}

/// `String` conforms to `SyntaxBuildable` and `ExprBuildable` via different paths, so we need to pick one default conversion path to create an an `ExprSyntax` (and `Syntax`) from a `String`. We choose `IdentifierExpr`.
extension String {
  public func createExprBuildable() -> ExprBuildable {
    return createIdentifierExpr()
  }
  public func createSyntaxBuildable() -> SyntaxBuildable {
    return createIdentifierExpr()
  }
}
