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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

extension CodeBlockItemListBuilder {
  public static func buildExpression(_ expression: some ExprSyntaxProtocol) -> Component {
    buildExpression(CodeBlockItemSyntax(item: .expr(ExprSyntax(expression))))
  }

  public static func buildExpression(_ expression: some Sequence<ExprSyntaxProtocol>) -> Component {
    buildExpression(expression.map { CodeBlockItemSyntax(item: .expr(ExprSyntax($0))) })
  }

  public static func buildExpression(_ expression: some StmtSyntaxProtocol) -> Component {
    buildExpression(CodeBlockItemSyntax(item: .stmt(StmtSyntax(expression))))
  }

  public static func buildExpression(_ expression: some Sequence<StmtSyntaxProtocol>) -> Component {
    buildExpression(expression.map { CodeBlockItemSyntax(item: .stmt(StmtSyntax($0))) })
  }

  public static func buildExpression(_ expression: some DeclSyntaxProtocol) -> Component {
    buildExpression(CodeBlockItemSyntax(item: .decl(DeclSyntax(expression))))
  }

  public static func buildExpression(_ expression: some Sequence<DeclSyntaxProtocol>) -> Component {
    buildExpression(expression.map { CodeBlockItemSyntax(item: .decl(DeclSyntax($0))) })
  }
}

extension ConditionElementListBuilder {
  public static func buildExpression(_ expression: some ExprSyntaxProtocol) -> Component {
    buildExpression(ConditionElementSyntax(condition: .expression(ExprSyntax(expression))))
  }

  public static func buildExpression(_ expression: some Sequence<ExprSyntaxProtocol>) -> Component {
    buildExpression(expression.map { ConditionElementSyntax(condition: .expression(ExprSyntax($0))) })
  }

  public static func buildExpression(_ expression: AvailabilityConditionSyntax) -> Component {
    buildExpression(ConditionElementSyntax(condition: .availability(expression)))
  }

  public static func buildExpression(_ expression: some Sequence<AvailabilityConditionSyntax>) -> Component {
    buildExpression(expression.map { ConditionElementSyntax(condition: .availability($0)) })
  }

  public static func buildExpression(_ expression: MatchingPatternConditionSyntax) -> Component {
    buildExpression(ConditionElementSyntax(condition: .matchingPattern(expression)))
  }

  public static func buildExpression(_ expression: some Sequence<MatchingPatternConditionSyntax>) -> Component {
    buildExpression(expression.map { ConditionElementSyntax(condition: .matchingPattern($0)) })
  }

  public static func buildExpression(_ expression: OptionalBindingConditionSyntax) -> Component {
    buildExpression(ConditionElementSyntax(condition: .optionalBinding(expression)))
  }

  public static func buildExpression(_ expression: some Sequence<OptionalBindingConditionSyntax>) -> Component {
    buildExpression(expression.map { ConditionElementSyntax(condition: .optionalBinding($0)) })
  }
}

extension MemberBlockItemListBuilder {
  public static func buildExpression(_ expression: some DeclSyntaxProtocol) -> Component {
    buildExpression(MemberBlockItemSyntax(decl: expression))
  }

  public static func buildExpression(_ expression: some Sequence<DeclSyntaxProtocol>) -> Component {
    buildExpression(expression.map { MemberBlockItemSyntax(decl: $0) })
  }
}

extension ExprListBuilder {
  public static func buildExpression(_ expression: some ExprSyntaxProtocol) -> Component {
    buildExpression(ExprSyntax(fromProtocol: expression))
  }

  public static func buildExpression(_ expression: some Sequence<ExprSyntaxProtocol>) -> Component {
    buildExpression(expression.map { ExprSyntax(fromProtocol: $0) })
  }
}

extension UnexpectedNodesBuilder {
  public static func buildExpression(_ expression: some SyntaxProtocol) -> Component {
    buildExpression(Syntax(fromProtocol: expression))
  }

  public static func buildExpression(_ expression: some Sequence<SyntaxProtocol>) -> Component {
    buildExpression(expression.map { Syntax(fromProtocol: $0) })
  }
}
