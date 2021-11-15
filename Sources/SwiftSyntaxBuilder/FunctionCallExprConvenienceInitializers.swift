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


import Foundation

extension FunctionCallExpr {
  public init(
    _ calledExpression: IdentifierExpr,
    leftParen: ExpressibleByTokenSyntax? = nil,
    rightParen: ExpressibleByTokenSyntax? = nil,
    trailingClosure: ExpressibleByClosureExpr? = nil,
    @TupleExprElementListBuilder argumentListBuilder: () -> TupleExprElementList = { .empty },
    @MultipleTrailingClosureElementListBuilder additionalTrailingClosuresBuilder: () -> MultipleTrailingClosureElementList? = { nil }
  ) {
    self.init(
      calledExpression: calledExpression,
      leftParen: leftParen,
      argumentList: argumentListBuilder(),
      rightParen: rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosuresBuilder()
    )
  }
}
