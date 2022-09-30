//// Automatically Generated From ResultBuilders.swift.gyb.
//// Do Not Edit Directly!
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

@resultBuilder
public struct CodeBlockItemListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsCodeBlockItem

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsCodeBlockItem]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = CodeBlockItemList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsCodeBlockItemList) -> Component {
    return expression.createCodeBlockItemList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createCodeBlockItem() })
  }
}

public extension CodeBlockItemList {
  init(@CodeBlockItemListBuilder itemsBuilder: () -> CodeBlockItemList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct UnexpectedNodesBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsSyntaxBuildable

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsSyntaxBuildable]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = UnexpectedNodes

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsUnexpectedNodes) -> Component {
    return expression.createUnexpectedNodes().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createSyntaxBuildable() })
  }
}

public extension UnexpectedNodes {
  init(@UnexpectedNodesBuilder itemsBuilder: () -> UnexpectedNodes) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct TupleExprElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsTupleExprElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsTupleExprElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = TupleExprElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsTupleExprElementList) -> Component {
    return expression.createTupleExprElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createTupleExprElement()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension TupleExprElementList {
  init(@TupleExprElementListBuilder itemsBuilder: () -> TupleExprElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct ArrayElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsArrayElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsArrayElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = ArrayElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsArrayElementList) -> Component {
    return expression.createArrayElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createArrayElement()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension ArrayElementList {
  init(@ArrayElementListBuilder itemsBuilder: () -> ArrayElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct DictionaryElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsDictionaryElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsDictionaryElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = DictionaryElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsDictionaryElementList) -> Component {
    return expression.createDictionaryElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createDictionaryElement()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension DictionaryElementList {
  init(@DictionaryElementListBuilder itemsBuilder: () -> DictionaryElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct StringLiteralSegmentsBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsSyntaxBuildable

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsSyntaxBuildable]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = StringLiteralSegments

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsStringLiteralSegments) -> Component {
    return expression.createStringLiteralSegments().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createSyntaxBuildable() })
  }
}

public extension StringLiteralSegments {
  init(@StringLiteralSegmentsBuilder itemsBuilder: () -> StringLiteralSegments) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct DeclNameArgumentListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsDeclNameArgument

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsDeclNameArgument]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = DeclNameArgumentList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsDeclNameArgumentList) -> Component {
    return expression.createDeclNameArgumentList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createDeclNameArgument() })
  }
}

public extension DeclNameArgumentList {
  init(@DeclNameArgumentListBuilder itemsBuilder: () -> DeclNameArgumentList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct ExprListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsExprBuildable

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsExprBuildable]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = ExprList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsExprList) -> Component {
    return expression.createExprList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createExprBuildable() })
  }
}

public extension ExprList {
  init(@ExprListBuilder itemsBuilder: () -> ExprList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct ClosureCaptureItemListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsClosureCaptureItem

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsClosureCaptureItem]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = ClosureCaptureItemList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsClosureCaptureItemList) -> Component {
    return expression.createClosureCaptureItemList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createClosureCaptureItem()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension ClosureCaptureItemList {
  init(@ClosureCaptureItemListBuilder itemsBuilder: () -> ClosureCaptureItemList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct ClosureParamListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsClosureParam

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsClosureParam]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = ClosureParamList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsClosureParamList) -> Component {
    return expression.createClosureParamList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createClosureParam()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension ClosureParamList {
  init(@ClosureParamListBuilder itemsBuilder: () -> ClosureParamList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct MultipleTrailingClosureElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsMultipleTrailingClosureElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsMultipleTrailingClosureElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = MultipleTrailingClosureElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsMultipleTrailingClosureElementList) -> Component {
    return expression.createMultipleTrailingClosureElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createMultipleTrailingClosureElement() })
  }
}

public extension MultipleTrailingClosureElementList {
  init(@MultipleTrailingClosureElementListBuilder itemsBuilder: () -> MultipleTrailingClosureElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct KeyPathComponentListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsKeyPathComponent

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsKeyPathComponent]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = KeyPathComponentList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsKeyPathComponentList) -> Component {
    return expression.createKeyPathComponentList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createKeyPathComponent() })
  }
}

public extension KeyPathComponentList {
  init(@KeyPathComponentListBuilder itemsBuilder: () -> KeyPathComponentList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct ObjcNameBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsObjcNamePiece

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsObjcNamePiece]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = ObjcName

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsObjcName) -> Component {
    return expression.createObjcName().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createObjcNamePiece() })
  }
}

public extension ObjcName {
  init(@ObjcNameBuilder itemsBuilder: () -> ObjcName) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct YieldExprListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsYieldExprListElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsYieldExprListElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = YieldExprList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsYieldExprList) -> Component {
    return expression.createYieldExprList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createYieldExprListElement() })
  }
}

public extension YieldExprList {
  init(@YieldExprListBuilder itemsBuilder: () -> YieldExprList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct FunctionParameterListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsFunctionParameter

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsFunctionParameter]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = FunctionParameterList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsFunctionParameterList) -> Component {
    return expression.createFunctionParameterList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createFunctionParameter()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension FunctionParameterList {
  init(@FunctionParameterListBuilder itemsBuilder: () -> FunctionParameterList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct IfConfigClauseListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsIfConfigClause

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsIfConfigClause]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = IfConfigClauseList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsIfConfigClauseList) -> Component {
    return expression.createIfConfigClauseList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createIfConfigClause() })
  }
}

public extension IfConfigClauseList {
  init(@IfConfigClauseListBuilder itemsBuilder: () -> IfConfigClauseList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct InheritedTypeListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsInheritedType

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsInheritedType]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = InheritedTypeList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsInheritedTypeList) -> Component {
    return expression.createInheritedTypeList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createInheritedType()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension InheritedTypeList {
  init(@InheritedTypeListBuilder itemsBuilder: () -> InheritedTypeList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct MemberDeclListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsMemberDeclListItem

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsMemberDeclListItem]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = MemberDeclList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsMemberDeclList) -> Component {
    return expression.createMemberDeclList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createMemberDeclListItem() })
  }
}

public extension MemberDeclList {
  init(@MemberDeclListBuilder itemsBuilder: () -> MemberDeclList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct ModifierListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsDeclModifier

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsDeclModifier]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = ModifierList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsModifierList) -> Component {
    return expression.createModifierList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createDeclModifier() })
  }
}

public extension ModifierList {
  init(@ModifierListBuilder itemsBuilder: () -> ModifierList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct AccessPathBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsAccessPathComponent

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsAccessPathComponent]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = AccessPath

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsAccessPath) -> Component {
    return expression.createAccessPath().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createAccessPathComponent() })
  }
}

public extension AccessPath {
  init(@AccessPathBuilder itemsBuilder: () -> AccessPath) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct AccessorListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsAccessorDecl

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsAccessorDecl]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = AccessorList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsAccessorList) -> Component {
    return expression.createAccessorList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createAccessorDecl() })
  }
}

public extension AccessorList {
  init(@AccessorListBuilder itemsBuilder: () -> AccessorList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct PatternBindingListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsPatternBinding

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsPatternBinding]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = PatternBindingList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsPatternBindingList) -> Component {
    return expression.createPatternBindingList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createPatternBinding()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension PatternBindingList {
  init(@PatternBindingListBuilder itemsBuilder: () -> PatternBindingList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct EnumCaseElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsEnumCaseElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsEnumCaseElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = EnumCaseElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsEnumCaseElementList) -> Component {
    return expression.createEnumCaseElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createEnumCaseElement()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension EnumCaseElementList {
  init(@EnumCaseElementListBuilder itemsBuilder: () -> EnumCaseElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct DesignatedTypeListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsDesignatedTypeElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsDesignatedTypeElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = DesignatedTypeList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsDesignatedTypeList) -> Component {
    return expression.createDesignatedTypeList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createDesignatedTypeElement() })
  }
}

public extension DesignatedTypeList {
  init(@DesignatedTypeListBuilder itemsBuilder: () -> DesignatedTypeList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct PrecedenceGroupAttributeListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsSyntaxBuildable

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsSyntaxBuildable]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = PrecedenceGroupAttributeList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsPrecedenceGroupAttributeList) -> Component {
    return expression.createPrecedenceGroupAttributeList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createSyntaxBuildable() })
  }
}

public extension PrecedenceGroupAttributeList {
  init(@PrecedenceGroupAttributeListBuilder itemsBuilder: () -> PrecedenceGroupAttributeList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct PrecedenceGroupNameListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsPrecedenceGroupNameElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsPrecedenceGroupNameElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = PrecedenceGroupNameList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsPrecedenceGroupNameList) -> Component {
    return expression.createPrecedenceGroupNameList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createPrecedenceGroupNameElement() })
  }
}

public extension PrecedenceGroupNameList {
  init(@PrecedenceGroupNameListBuilder itemsBuilder: () -> PrecedenceGroupNameList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct TokenListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = Token

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [Token]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = TokenList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsTokenList) -> Component {
    return expression.createTokenList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component)
  }
}

public extension TokenList {
  init(@TokenListBuilder itemsBuilder: () -> TokenList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct NonEmptyTokenListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = Token

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [Token]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = NonEmptyTokenList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsNonEmptyTokenList) -> Component {
    return expression.createNonEmptyTokenList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component)
  }
}

public extension NonEmptyTokenList {
  init(@NonEmptyTokenListBuilder itemsBuilder: () -> NonEmptyTokenList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct AttributeListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsSyntaxBuildable

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsSyntaxBuildable]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = AttributeList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsAttributeList) -> Component {
    return expression.createAttributeList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createSyntaxBuildable() })
  }
}

public extension AttributeList {
  init(@AttributeListBuilder itemsBuilder: () -> AttributeList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct SpecializeAttributeSpecListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsSyntaxBuildable

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsSyntaxBuildable]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = SpecializeAttributeSpecList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsSpecializeAttributeSpecList) -> Component {
    return expression.createSpecializeAttributeSpecList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createSyntaxBuildable() })
  }
}

public extension SpecializeAttributeSpecList {
  init(@SpecializeAttributeSpecListBuilder itemsBuilder: () -> SpecializeAttributeSpecList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct ObjCSelectorBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsObjCSelectorPiece

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsObjCSelectorPiece]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = ObjCSelector

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsObjCSelector) -> Component {
    return expression.createObjCSelector().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createObjCSelectorPiece() })
  }
}

public extension ObjCSelector {
  init(@ObjCSelectorBuilder itemsBuilder: () -> ObjCSelector) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct DifferentiabilityParamListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsDifferentiabilityParam

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsDifferentiabilityParam]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = DifferentiabilityParamList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsDifferentiabilityParamList) -> Component {
    return expression.createDifferentiabilityParamList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createDifferentiabilityParam()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension DifferentiabilityParamList {
  init(@DifferentiabilityParamListBuilder itemsBuilder: () -> DifferentiabilityParamList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct BackDeployVersionListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsBackDeployVersionArgument

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsBackDeployVersionArgument]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = BackDeployVersionList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsBackDeployVersionList) -> Component {
    return expression.createBackDeployVersionList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createBackDeployVersionArgument() })
  }
}

public extension BackDeployVersionList {
  init(@BackDeployVersionListBuilder itemsBuilder: () -> BackDeployVersionList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct SwitchCaseListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsSyntaxBuildable

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsSyntaxBuildable]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = SwitchCaseList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsSwitchCaseList) -> Component {
    return expression.createSwitchCaseList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createSyntaxBuildable() })
  }
}

public extension SwitchCaseList {
  init(@SwitchCaseListBuilder itemsBuilder: () -> SwitchCaseList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct CatchClauseListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsCatchClause

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsCatchClause]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = CatchClauseList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsCatchClauseList) -> Component {
    return expression.createCatchClauseList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createCatchClause() })
  }
}

public extension CatchClauseList {
  init(@CatchClauseListBuilder itemsBuilder: () -> CatchClauseList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct CaseItemListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsCaseItem

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsCaseItem]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = CaseItemList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsCaseItemList) -> Component {
    return expression.createCaseItemList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createCaseItem()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension CaseItemList {
  init(@CaseItemListBuilder itemsBuilder: () -> CaseItemList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct CatchItemListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsCatchItem

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsCatchItem]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = CatchItemList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsCatchItemList) -> Component {
    return expression.createCatchItemList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createCatchItem()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension CatchItemList {
  init(@CatchItemListBuilder itemsBuilder: () -> CatchItemList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct ConditionElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsConditionElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsConditionElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = ConditionElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsConditionElementList) -> Component {
    return expression.createConditionElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createConditionElement()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension ConditionElementList {
  init(@ConditionElementListBuilder itemsBuilder: () -> ConditionElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct GenericRequirementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsGenericRequirement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsGenericRequirement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = GenericRequirementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsGenericRequirementList) -> Component {
    return expression.createGenericRequirementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createGenericRequirement()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension GenericRequirementList {
  init(@GenericRequirementListBuilder itemsBuilder: () -> GenericRequirementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct GenericParameterListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsGenericParameter

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsGenericParameter]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = GenericParameterList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsGenericParameterList) -> Component {
    return expression.createGenericParameterList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createGenericParameter()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension GenericParameterList {
  init(@GenericParameterListBuilder itemsBuilder: () -> GenericParameterList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct PrimaryAssociatedTypeListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsPrimaryAssociatedType

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsPrimaryAssociatedType]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = PrimaryAssociatedTypeList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsPrimaryAssociatedTypeList) -> Component {
    return expression.createPrimaryAssociatedTypeList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createPrimaryAssociatedType()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension PrimaryAssociatedTypeList {
  init(@PrimaryAssociatedTypeListBuilder itemsBuilder: () -> PrimaryAssociatedTypeList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct CompositionTypeElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsCompositionTypeElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsCompositionTypeElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = CompositionTypeElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsCompositionTypeElementList) -> Component {
    return expression.createCompositionTypeElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createCompositionTypeElement() })
  }
}

public extension CompositionTypeElementList {
  init(@CompositionTypeElementListBuilder itemsBuilder: () -> CompositionTypeElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct TupleTypeElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsTupleTypeElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsTupleTypeElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = TupleTypeElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsTupleTypeElementList) -> Component {
    return expression.createTupleTypeElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createTupleTypeElement()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension TupleTypeElementList {
  init(@TupleTypeElementListBuilder itemsBuilder: () -> TupleTypeElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct GenericArgumentListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsGenericArgument

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsGenericArgument]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = GenericArgumentList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsGenericArgumentList) -> Component {
    return expression.createGenericArgumentList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createGenericArgument()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension GenericArgumentList {
  init(@GenericArgumentListBuilder itemsBuilder: () -> GenericArgumentList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct TuplePatternElementListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsTuplePatternElement

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsTuplePatternElement]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = TuplePatternElementList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsTuplePatternElementList) -> Component {
    return expression.createTuplePatternElementList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    let lastIndex = component.count - 1
    return .init(component.enumerated().map({ index, source in
      let element = source.createTuplePatternElement()
      return index < lastIndex ? element.ensuringTrailingComma() : element
    }))
  }
}

public extension TuplePatternElementList {
  init(@TuplePatternElementListBuilder itemsBuilder: () -> TuplePatternElementList) {
    self = itemsBuilder()
  }
}

@resultBuilder
public struct AvailabilitySpecListBuilder {

  /// The type of individual statement expressions in the transformed function,
  /// which defaults to Component if buildExpression() is not provided.
  public typealias Expression = ExpressibleAsAvailabilityArgument

  /// The type of a partial result, which will be carried through all of the
  /// build methods.
  public typealias Component = [ExpressibleAsAvailabilityArgument]

  /// The type of the final returned result, which defaults to Component if
  /// buildFinalResult() is not provided.
  public typealias FinalResult = AvailabilitySpecList

  /// Required by every result builder to build combined results from
  /// statement blocks.
  public static func buildBlock(_ components: Component...) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, provides contextual type information for statement
  /// expressions to translate them into partial results.
  public static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }
  
  /// Add all the elements of `expression` to this result builder, effectively flattening them.
  public static func buildExpression(_ expression: ExpressibleAsAvailabilitySpecList) -> Component {
    return expression.createAvailabilitySpecList().elements
  }
  
  /// Enables support for `if` statements that do not have an `else`.
  public static func buildOptional(_ component: Component?) -> Component {
    return component ?? []
  }

  /// With buildEither(second:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(first component: Component) -> Component {
    return component
  }

  /// With buildEither(first:), enables support for 'if-else' and 'switch'
  /// statements by folding conditional results into a single result.
  public static func buildEither(second component: Component) -> Component {
    return component
  }

  /// Enables support for 'for..in' loops by combining the
  /// results of all iterations into a single result.
  public static func buildArray(_ components: [Component]) -> Component {
    return components.flatMap { $0 }
  }

  /// If declared, this will be called on the partial result of an 'if
  /// #available' block to allow the result builder to erase type
  /// information.
  public static func buildLimitedAvailability(_ component: Component) -> Component {
    return component
  }

  /// If declared, this will be called on the partial result from the outermost
  /// block statement to produce the final returned result.
  public static func buildFinalResult(_ component: Component) -> FinalResult {
    return .init(component.map { $0.createAvailabilityArgument() })
  }
}

public extension AvailabilitySpecList {
  init(@AvailabilitySpecListBuilder itemsBuilder: () -> AvailabilitySpecList) {
    self = itemsBuilder()
  }
}

