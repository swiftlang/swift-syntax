//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

// MARK: - Protocols

public protocol ExprListBuildable: SyntaxListBuildable {
  func buildExprList(format: Format, leadingTrivia: Trivia) -> [ExprSyntax]
}

public protocol ExprBuildable: SyntaxBuildable, ExprListBuildable {
  func buildExpr(format: Format, leadingTrivia: Trivia) -> ExprSyntax
}

extension ExprBuildable {
  public func buildSyntax(format: Format, leadingTrivia: Trivia) -> Syntax {
    buildExpr(format: format, leadingTrivia: leadingTrivia)
  }

  public func buildExprList(format: Format, leadingTrivia: Trivia) -> [ExprSyntax] {
    [buildExpr(format: format, leadingTrivia: leadingTrivia)]
  }
}

// MARK: - Buildables

// MARK: Integer Literal

public struct IntegerLiteral: ExprBuildable {
    let value: Int

    public init(_ value: Int) {
        self.value = value
    }

    public func buildExpr(format: Format, leadingTrivia: Trivia) -> ExprSyntax {
        SyntaxFactory.makeIntegerLiteralExpr(
            digits: SyntaxFactory.makeIntegerLiteral(String(value))
        ).withLeadingTrivia(leadingTrivia)
    }
}

extension IntegerLiteral: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}

// MARK: String Literal

public struct StringLiteral: ExprBuildable {
    let value: String

    public init(_ value: String) {
        self.value = value
    }

    public func buildExpr(format: Format, leadingTrivia: Trivia) -> ExprSyntax {
        SyntaxFactory.makeStringLiteralExpr(value)
          .withLeadingTrivia(leadingTrivia)
    }
}

extension StringLiteral: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
