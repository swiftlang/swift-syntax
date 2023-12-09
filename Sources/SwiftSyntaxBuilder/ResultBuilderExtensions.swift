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

import SwiftSyntax

extension CodeBlockItemListBuilder {
  public static func buildExpression(_ expression: some ExprSyntaxProtocol) -> Component {
    return buildExpression(CodeBlockItemSyntax(item: .expr(ExprSyntax(expression))))
  }

  public static func buildExpression(_ expression: some StmtSyntaxProtocol) -> Component {
    return buildExpression(CodeBlockItemSyntax(item: .stmt(StmtSyntax(expression))))
  }

  public static func buildExpression(_ expression: some DeclSyntaxProtocol) -> Component {
    return buildExpression(CodeBlockItemSyntax(item: .decl(DeclSyntax(expression))))
  }
}

extension ConditionElementListBuilder {
  public static func buildExpression(_ expression: some ExprSyntaxProtocol) -> Component {
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

extension MemberBlockItemListBuilder {
  public static func buildExpression(_ expression: some DeclSyntaxProtocol) -> Component {
    return buildExpression(MemberBlockItemSyntax(decl: expression))
  }
}

// MARK: Initializing collections from protocols
// These initializers allow the creation of syntax collections that have a base
// node as their element from the corresponding protocol type.
// These are used by the result builders.
// Since we only have two of these, it doesn’t make sense to generate them.

extension ExprListSyntax {
  init(_ elements: [ExprSyntaxProtocol]) {
    self = ExprListSyntax(elements.map { ExprSyntax(fromProtocol: $0) } as [ExprSyntax])
  }
}

extension UnexpectedNodesSyntax {
  public init(_ elements: [SyntaxProtocol]) {
    self = UnexpectedNodesSyntax(elements.map { Syntax(fromProtocol: $0) } as [Syntax])
  }
}
