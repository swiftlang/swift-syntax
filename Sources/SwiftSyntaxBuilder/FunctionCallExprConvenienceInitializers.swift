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

extension FunctionCallExpr {
  public init(
    _ calledExpression: ExpressibleAsExprBuildable,
    leftParen: TokenSyntax? = .leftParen,
    rightParen: TokenSyntax? = .rightParen,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> ExpressibleAsTupleExprElementList = { TupleExprElementList([]) },
    @MultipleTrailingClosureElementListBuilder additionalTrailingClosuresBuilder: () -> MultipleTrailingClosureElementList? = { nil }
  ) {
    self.init(
      calledExpression: calledExpression.createExprBuildable(),
      leftParen: leftParen,
      argumentList: argumentListBuilder(),
      rightParen: rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosuresBuilder()
    )
  }
}
