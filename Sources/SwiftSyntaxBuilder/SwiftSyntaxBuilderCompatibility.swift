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

// This file provides compatibility aliases to keep dependents of SwiftSyntaxBuilder building.
// All users of the declarations in this file should transition away from them ASAP.

#if compiler(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

@available(*, deprecated, renamed: "ImportPathComponentListBuilder")
public typealias AccessPathBuilder = ImportPathComponentListBuilder

/// Written here to enable the use of `@LabeledExprListBuilder`.
extension FunctionCallExprSyntax {
  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: ExprSyntaxProtocol,
    unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    @LabeledExprListBuilder argumentsBuilder: () throws -> LabeledExprListSyntax,
    trailingTrivia: Trivia? = nil
  ) rethrows {
    try self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: ExprSyntax(fromProtocol: calledExpression),
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: nil,
      unexpectedBetweenLeftParenAndArguments,
      arguments: argumentsBuilder(),
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: rightParen,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: ExprSyntaxProtocol,
    unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax? = nil,
    unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    @LabeledExprListBuilder argumentsBuilder: () throws -> LabeledExprListSyntax,
    trailingTrivia: Trivia? = nil
  ) rethrows {
    try self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: ExprSyntax(fromProtocol: calledExpression),
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: leftParen,
      unexpectedBetweenLeftParenAndArguments,
      arguments: argumentsBuilder(),
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: nil,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: ExprSyntaxProtocol,
    unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    @LabeledExprListBuilder argumentsBuilder: () throws -> LabeledExprListSyntax,
    trailingTrivia: Trivia? = nil
  ) rethrows {
    try self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: ExprSyntax(fromProtocol: calledExpression),
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: nil,
      unexpectedBetweenLeftParenAndArguments,
      arguments: argumentsBuilder(),
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: nil,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: ExprSyntaxProtocol,
    unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    rightParen: TokenSyntax? = nil,
    unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    @LabeledExprListBuilder argumentListBuilder: () throws -> LabeledExprListSyntax,
    trailingTrivia: Trivia? = nil
  ) rethrows {
    try self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: ExprSyntax(fromProtocol: calledExpression),
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: nil,
      unexpectedBetweenLeftParenAndArguments,
      arguments: argumentListBuilder(),
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: rightParen,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: ExprSyntaxProtocol,
    unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    leftParen: TokenSyntax? = nil,
    unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    @LabeledExprListBuilder argumentListBuilder: () throws -> LabeledExprListSyntax,
    trailingTrivia: Trivia? = nil
  ) rethrows {
    try self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: ExprSyntax(fromProtocol: calledExpression),
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: leftParen,
      unexpectedBetweenLeftParenAndArguments,
      arguments: argumentListBuilder(),
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: nil,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }

  @_disfavoredOverload
  @available(
    *,
    deprecated,
    message: "Use the initializer that does not provide default values for leftParen and rightParen."
  )
  public init(
    leadingTrivia: Trivia? = nil,
    unexpectedBeforeCalledExpression: UnexpectedNodesSyntax? = nil,
    calledExpression: ExprSyntaxProtocol,
    unexpectedBetweenCalledExpressionAndLeftParen: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenLeftParenAndArguments: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenArgumentsAndRightParen: UnexpectedNodesSyntax? = nil,
    unexpectedBetweenRightParenAndTrailingClosure: UnexpectedNodesSyntax? = nil,
    trailingClosure: ClosureExprSyntax? = nil,
    unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    additionalTrailingClosures: MultipleTrailingClosureElementListSyntax = [],
    unexpectedAfterAdditionalTrailingClosures: UnexpectedNodesSyntax? = nil,
    @LabeledExprListBuilder argumentListBuilder: () throws -> LabeledExprListSyntax,
    trailingTrivia: Trivia? = nil
  ) rethrows {
    try self.init(
      leadingTrivia: leadingTrivia,
      unexpectedBeforeCalledExpression,
      calledExpression: ExprSyntax(fromProtocol: calledExpression),
      unexpectedBetweenCalledExpressionAndLeftParen,
      leftParen: nil,
      unexpectedBetweenLeftParenAndArguments,
      arguments: argumentListBuilder(),
      unexpectedBetweenArgumentsAndRightParen,
      rightParen: nil,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures,
      trailingTrivia: trailingTrivia
    )
  }
}

@available(*, deprecated, renamed: "LabeledExprListBuilder")
public typealias TupleExprElementListBuilder = LabeledExprListBuilder

//==========================================================================//
// IMPORTANT: If you are tempted to add a compatibility layer code here     //
// please insert it in alphabetical order above                             //
//==========================================================================//
