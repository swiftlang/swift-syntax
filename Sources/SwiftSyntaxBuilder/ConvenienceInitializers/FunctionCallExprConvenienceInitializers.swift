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
  /// A convenience initializer that allows passing in arguments using a result builder
  /// instead of having to wrap them in a `TupleExprElementList`.
  /// The presence of the parenthesis will be inferred based on the presence of arguments and the trailing closure.
  public init(
    calledExpression: ExpressibleAsExprBuildable,
    trailingClosure: ExpressibleAsClosureExpr? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementList? = nil,
    @TupleExprElementListBuilder argumentList: () -> ExpressibleAsTupleExprElementList = { [] }
  ) {
    let argumentList = argumentList().createTupleExprElementList()
    let shouldOmitParens = argumentList.elements.isEmpty && trailingClosure != nil
    self.init(
      calledExpression: calledExpression.createExprBuildable(),
      leftParen: shouldOmitParens ? nil : .leftParen,
      argumentList: argumentList,
      rightParen: shouldOmitParens ? nil : .rightParen,
      trailingClosure: trailingClosure,
      additionalTrailingClosures: additionalTrailingClosures
    )
  }
}
