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

public protocol ListBuilder {
  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  associatedtype FinalResult: SyntaxCollection

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  typealias Expression = FinalResult.Element

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  typealias Component = [Expression]

  /// Required by every result builder to build combined results from
  /// statement blocks.
  static func buildBlock(_ components: Component...) -> Component

  /// Provides contextual type information for statement
  /// expressions to translate them into partial results.
  static func buildExpression(_ expression: Expression) -> Component
  static func buildExpression(_ expression: some Sequence<Expression>) -> Component

  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  ///
  /// - Note: This overload is disfavored to resolve an ambiguity when both the final result and
  ///   the elements are expressible by string interpolation. In that case we favor creating a
  ///   single element from the string literal.
  @_disfavoredOverload
  static func buildExpression(_ expression: FinalResult) -> Component

  /// Enables support for `if` statements that do not have an `else`.
  static func buildOptional(_ component: Component?) -> Component

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  static func buildEither(first component: Component) -> Component

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  static func buildEither(second component: Component) -> Component

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  static func buildArray(_ components: [Component]) -> Component

  /// This will be called on the partial result of an 'if'
  /// #available' block to allow the result builder to erase type
  /// information.
  static func buildLimitedAvailability(_ component: Component) -> Component

  /// This will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  static func buildFinalResult(_ component: Component) -> FinalResult
}

extension ListBuilder {
  public static func buildBlock(_ components: Component...) -> Component {
    components.flatMap { $0 }
  }
  public static func buildExpression(_ expression: Expression) -> Component {
    [expression]
  }
  public static func buildExpression(_ expression: some Sequence<Expression>) -> Component {
    .init(expression)
  }
  @_disfavoredOverload
  public static func buildExpression(_ expression: FinalResult) -> Component {
    expression.map { $0 }
  }
  public static func buildOptional(_ component: Component?) -> Component {
    component ?? []
  }
  public static func buildEither(first component: Component) -> Component {
    component
  }
  public static func buildEither(second component: Component) -> Component {
    component
  }
  public static func buildArray(_ components: [Component]) -> Component {
    components.flatMap { $0 }
  }
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    component
  }
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    .init(component)
  }
}

extension ListBuilder where Expression: WithTrailingCommaSyntax {
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    .init(
      component.enumerated().map { index, expression in
        index < component.endIndex - 1 ? expression.ensuringTrailingComma() : expression
      }
    )
  }
}
