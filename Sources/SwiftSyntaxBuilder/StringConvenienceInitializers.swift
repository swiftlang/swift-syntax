//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2021 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

extension String: ExpressibleAsSimpleTypeIdentifier {
  public func createSimpleTypeIdentifier() -> SimpleTypeIdentifier {
    SimpleTypeIdentifier(self)
  }
}

extension String: ExpressibleAsIdentifierPattern {
  public func createIdentifierPattern() -> IdentifierPattern {
    IdentifierPattern(self)
  }
}

extension String: ExpressibleAsIdentifierExpr {
  public func createIdentifierExpr() -> IdentifierExpr {
    IdentifierExpr(self)
  }
}

extension String: ExpressibleAsStringLiteralExpr {
  public func createStringLiteralExpr() -> StringLiteralExpr {
    StringLiteralExpr(self)
  }
}

extension String: ExpressibleAsBinaryOperatorExpr {
  public func createBinaryOperatorExpr() -> BinaryOperatorExpr {
    BinaryOperatorExpr(self)
  }
}

extension String: ExpressibleAsReturnClause {
  public func createReturnClause() -> ReturnClause {
    ReturnClause(returnType: self)
  }
}

/// Default conformance to `ExpressibleByTypeBuildable`
extension String {
  public func createTypeBuildable() -> TypeBuildable {
    SimpleTypeIdentifier(self)
  }
}

/// Default conformance to `ExpressibleByPatternBuildable`
extension String {
  public func createPatternBuildable() -> PatternBuildable {
    IdentifierPattern(self)
  }
}
