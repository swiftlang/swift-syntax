//===--- ResultBuilderExtensions.swift ------------------------------------===//
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

import SwiftSyntax

extension CodeBlockItemListBuilder {
  public static func buildExpression<ExprType: ExprSyntaxProtocol>(_ expression: ExprType) -> Component {
    return buildExpression(CodeBlockItemSyntax(item: .expr(ExprSyntax(expression))))
  }

  public static func buildExpression<StmtType: StmtSyntaxProtocol>(_ expression: StmtType) -> Component {
    return buildExpression(CodeBlockItemSyntax(item: .stmt(StmtSyntax(expression))))
  }

  public static func buildExpression<DeclType: DeclSyntaxProtocol>(_ expression: DeclType) -> Component {
    return buildExpression(CodeBlockItemSyntax(item: .decl(DeclSyntax(expression))))
  }
}

extension ConditionElementListBuilder {
  public static func buildExpression<ExprType: ExprSyntaxProtocol>(_ expression: ExprType) -> Component {
    return buildExpression(ConditionElementSyntax(condition: .expression(ExprSyntax(expression))))
  }

  public static func buildExpression(_ expression: AvailabilityConditionSyntax) -> Component {
    return buildExpression(ConditionElementSyntax(condition: .availability(expression)))
  }

  public static func buildExpression(_ expression: MatchingPatternConditionSyntax) -> Component {
    return buildExpression(ConditionElementSyntax(condition: .matchingPattern(expression)))
  }

  public static func buildExpression(_ expression: OptionalBindingConditionSyntax) -> Component {
    return buildExpression(ConditionElementSyntax(condition: .optionalBinding(expression)))
  }
}

extension MemberDeclListBuilder {
  public static func buildExpression<DeclType: DeclSyntaxProtocol>(_ expression: DeclType) -> Component {
    return buildExpression(MemberDeclListItemSyntax(decl: expression))
  }
}
