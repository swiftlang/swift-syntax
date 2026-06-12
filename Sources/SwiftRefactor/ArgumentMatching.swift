//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftSyntax

public struct ArgumentMatchResult {
  public enum ParameterKind {
    case fixed
    case variadic
    case pack
  }

  public struct ParameterMatch {
    public let parameter: FunctionParameterSyntax
    /// Always either:
    /// - A LabeledExprSyntax for regular arguments
    /// - A ClosureExprSyntax for single trailing closures
    /// - A MultipleTrailingClosureElementSyntax for additional trailing closures
    public let arguments: [any SyntaxProtocol]
    public var isDefaulted: Bool {
      arguments.isEmpty
    }
    public var kind: ParameterKind {
      parameter.argumentMatchingKind
    }
  }

  private let matches: [ParameterMatch]

  public init(matches: [ParameterMatch]) {
    self.matches = matches
  }

  /// Returns the match entry for a specific parameter index, if it exists.
  ///
  /// Note that this uses the parameter index (the position of the parameter in the parameter list)
  /// at the declaration site rather than the argument index at the call site.
  public func matchForParameter(at index: Int) -> ParameterMatch? {
    matches[index]
  }

  /// Returns the match entry for a specific parameter name, if it exists.
  ///
  /// Note that this uses the parameter name (the second name in the parameter syntax)
  /// rather than the external argument label. This is because the parameter name is guaranteed
  /// to be unique and always present, while external argument labels may be duplicated or omitted.
  public func matchForParameter(named name: String) -> ParameterMatch? {
    matches.first { $0.parameter.parameterName == name }
  }

  /// Returns the match entry for a specific function parameter syntax node.
  ///
  /// This is useful when iterating over a `FunctionParameterListSyntax` and
  /// querying the associated match result for each parameter.
  ///
  /// - Parameter parameter: the `FunctionParameterSyntax` node to find a match for
  /// - Returns: the `ParameterMatch` associated with the given parameter
  public func match(for parameter: FunctionParameterSyntax) -> ParameterMatch {
    precondition(
      matches.contains(where: { $0.parameter == parameter }),
      "Given parameter does not belong to the declaration associated with this match result"
    )
    return matches.first { $0.parameter == parameter }!
  }
}

extension FunctionCallExprSyntax {
  /// Match call arguments to function parameters using a syntax-only heuristic.
  ///
  /// This intentionally mirrors compiler behavior for many common and tricky
  /// cases (especially trailing-closure fallback behavior) without requiring
  /// type checking.
  public func matchArguments(
    to parameters: FunctionParameterListSyntax
  ) -> ArgumentMatchResult? {
    if self.hasError || parameters.hasError {
      // If there are any syntax errors in the arguments or parameters, we cannot reliably perform matching, so we return nil.
      return nil
    }

    var arguments: [any SyntaxProtocol] = []
    for argument in self.arguments {
      arguments.append(argument)
    }
    if let trailingClosure {
      arguments.append(trailingClosure)
    }
    for additionalTrailingClosure in self.additionalTrailingClosures {
      arguments.append(additionalTrailingClosure)
    }

    return matchArgumentsToParameters(parameters: parameters, arguments: arguments)
  }
}

private func matchArgumentsToParameters(
  parameters: FunctionParameterListSyntax,
  arguments: [any SyntaxProtocol]
) -> ArgumentMatchResult? {
  // Lookahead helpers used by closure-specific compatibility logic.
  // We intentionally keep these syntax-only and cheap.
  func hasLaterClosureParameter(startingAfter index: Int) -> Bool {
    for nextParameter in parameters.dropFirst(index + 1) {
      if nextParameter.expectsClosureArgument {
        return true
      }
    }
    return false
  }

  func hasLaterUnlabeledFunctionParameter(startingAfter index: Int) -> Bool {
    for nextParameter in parameters.dropFirst(index + 1) {
      if nextParameter.expectsClosureArgument && nextParameter.externalArgumentLabelText == nil {
        return true
      }
    }
    return false
  }

  func firstLaterRequiredClosureParameter(startingAfter index: Int) -> FunctionParameterSyntax? {
    for nextParameter in parameters.dropFirst(index + 1) {
      guard
        nextParameter.argumentMatchingKind == .fixed,
        nextParameter.defaultValue == nil,
        nextParameter.expectsClosureArgument
      else {
        continue
      }
      return nextParameter
    }
    return nil
  }

  func hasInterveningClosureParameterBeforeFirstLaterRequiredClosure(startingAfter index: Int) -> Bool {
    var sawClosureParameter = false
    for nextParameter in parameters.dropFirst(index + 1) {
      guard nextParameter.expectsClosureArgument else {
        continue
      }

      if nextParameter.argumentMatchingKind == .fixed && nextParameter.defaultValue == nil {
        return sawClosureParameter
      }

      sawClosureParameter = true
    }
    return false
  }

  /// Returns whether an unlabeled trailing closure should be preserved for a later
  /// required closure parameter instead of being consumed by the current parameter.
  ///
  /// Rationale:
  /// - If the next labeled argument appears to target a different required closure
  ///   parameter later in the list, consuming the unlabeled trailing closure now can
  ///   produce a mismatch compared to compiler behavior.
  /// - If there is an intervening closure parameter before that required one, keeping
  ///   the trailing closure is not always possible, so we allow consuming it now.
  func shouldKeepUnlabeledTrailingClosureForLaterRequiredClosure(
    startingAfter parameterIndex: Int,
    nextArgumentLabel: String?
  ) -> Bool {
    guard
      let firstLaterRequiredClosureParameter = firstLaterRequiredClosureParameter(startingAfter: parameterIndex),
      firstLaterRequiredClosureParameter.externalArgumentLabelText != nextArgumentLabel,
      !hasInterveningClosureParameterBeforeFirstLaterRequiredClosure(startingAfter: parameterIndex)
    else {
      return false
    }

    return true
  }

  func consumeArgument(
    at index: inout Int,
    into matchingArguments: inout [any SyntaxProtocol]
  ) {
    assert(index < arguments.endIndex)
    matchingArguments.append(arguments[index])
    index = arguments.index(after: index)
  }

  func numberOfRemainingParametersRequiringAValue(after parameterIndex: Int) -> Int {
    var count = 0
    for nextParameter in parameters.dropFirst(parameterIndex + 1) {
      if nextParameter.argumentMatchingKind == .fixed && nextParameter.defaultValue == nil {
        count += 1
      }
    }
    return count
  }

  func maxMatchEndIndex(
    for parameterIndex: Int,
    argumentIndex: Int
  ) -> Int {
    // Bound the number of arguments this parameter may consume so later
    // required fixed parameters can still receive one argument each.
    let maxNumberOfArgumentsToMatch =
      arguments.distance(from: argumentIndex, to: arguments.endIndex)
      - numberOfRemainingParametersRequiringAValue(after: parameterIndex)
    return arguments.index(argumentIndex, offsetBy: maxNumberOfArgumentsToMatch)
  }

  // Fixed parameters consume at most one argument.
  // - Required fixed parameters must have a match within `maxMatchEndIndex`.
  // - Defaulted fixed parameters may remain unmatched, and use compatibility
  //   lookahead to decide whether to consume unlabeled closure-shaped arguments
  //   now or leave them for later closure parameters.
  func matchFixedParameter(
    parameterIndex: Int,
    parameter: FunctionParameterSyntax,
    argumentIndex: inout Int,
    matchingArguments: inout [any SyntaxProtocol],
    maxMatchEndIndex: Int
  ) -> Bool {
    if parameter.defaultValue != nil {
      // Defaulted parameters are optional. If consuming one argument here would
      // starve later required parameters, leave this parameter defaulted.
      guard argumentIndex < maxMatchEndIndex else {
        return true
      }

      let currentArgument = arguments[argumentIndex]
      let isUnlabeledTrailingClosure = currentArgument.is(ClosureExprSyntax.self)
      let hasAdditionalArguments = arguments.index(after: argumentIndex) < arguments.endIndex

      // Decide whether an unlabeled trailing closure should bind to this
      // defaulted closure parameter or be deferred to a later closure
      // parameter. This is where we encode most compatibility behavior.
      let shouldConsumeUnlabeledTrailingClosure: Bool = {
        guard isUnlabeledTrailingClosure, parameter.expectsClosureArgument else {
          return false
        }

        guard hasLaterClosureParameter(startingAfter: parameterIndex) else {
          // No later closure parameter exists, so consume here.
          return true
        }

        guard hasAdditionalArguments else {
          // Keep the trailing closure for a later closure parameter.
          return false
        }

        let nextArgument = arguments[arguments.index(after: argumentIndex)]
        let nextArgumentLabel = nextArgument.labelAsString

        if shouldKeepUnlabeledTrailingClosureForLaterRequiredClosure(
          startingAfter: parameterIndex,
          nextArgumentLabel: nextArgumentLabel
        ) {
          return false
        }

        return true
      }()

      // Regular label-based matching for non-trailing-closure arguments.
      let shouldConsumeLabeledArgument =
        !isUnlabeledTrailingClosure
        && currentArgument.labelAsString == parameter.externalArgumentLabelText

      if shouldConsumeLabeledArgument || shouldConsumeUnlabeledTrailingClosure {
        consumeArgument(at: &argumentIndex, into: &matchingArguments)
      }
      return true
    }

    guard argumentIndex < maxMatchEndIndex else {
      return false
    }

    let expectedLabel = parameter.externalArgumentLabelText
    let actualLabel = arguments[argumentIndex].labelAsString
    if expectedLabel == actualLabel || arguments[argumentIndex].is(ClosureExprSyntax.self) {
      consumeArgument(at: &argumentIndex, into: &matchingArguments)
    }
    return true
  }

  // Variadic parameters consume zero or more arguments.
  // - If labeled, the first consumed argument must carry that label (with a
  //   compatibility exception for unlabeled trailing closures on closure
  //   variadics).
  // - After the first element, we greedily consume unlabeled arguments until
  //   the bound `maxMatchEndIndex` or a lookahead rule says to keep an
  //   unlabeled trailing closure for a later closure parameter.
  func matchVariadicParameter(
    parameterIndex: Int,
    parameter: FunctionParameterSyntax,
    argumentIndex: inout Int,
    matchingArguments: inout [any SyntaxProtocol],
    maxMatchEndIndex: Int
  ) -> Bool {
    guard argumentIndex < maxMatchEndIndex else {
      return true
    }

    if let expectedLabel = parameter.externalArgumentLabelText {
      if arguments[argumentIndex].labelAsString == expectedLabel {
        // The label matches, so we consume this argument and then continue with the unlabeled greedy matching below.
        consumeArgument(at: &argumentIndex, into: &matchingArguments)
      } else if parameter.expectsClosureArgument,
        arguments[argumentIndex].is(ClosureExprSyntax.self),
        parameterIndex == parameters.count - 1 || arguments.index(after: argumentIndex) < arguments.endIndex
      {
        let nextIndex = arguments.index(after: argumentIndex)
        let nextArgumentLabel = nextIndex < arguments.endIndex ? arguments[nextIndex].labelAsString : nil
        if shouldKeepUnlabeledTrailingClosureForLaterRequiredClosure(
          startingAfter: parameterIndex,
          nextArgumentLabel: nextArgumentLabel
        ) {
          return true
        }

        consumeArgument(at: &argumentIndex, into: &matchingArguments)
      } else {
        // The label does not match, and it's not an unlabeled trailing closure, so we don't consume any arguments.
        return true
      }
    }

    let expectsClosures = parameter.expectsClosureArgument

    // Greedily consume unlabeled arguments for variadics.
    // For closure variadics, we add lookahead checks so unlabeled trailing
    // closures can be preserved for later closure parameters when needed.
    while argumentIndex < maxMatchEndIndex && arguments[argumentIndex].labelAsString == nil {
      if expectsClosures
        && arguments[argumentIndex].is(ClosureExprSyntax.self)
      {
        let nextIndex = arguments.index(after: argumentIndex)

        if nextIndex < arguments.endIndex {
          let nextArgumentLabel = arguments[nextIndex].labelAsString
          if shouldKeepUnlabeledTrailingClosureForLaterRequiredClosure(
            startingAfter: parameterIndex,
            nextArgumentLabel: nextArgumentLabel
          ) {
            break
          }
        }

        if hasLaterClosureParameter(startingAfter: parameterIndex)
          && nextIndex == arguments.endIndex
        {
          break
        }
      }
      if !expectsClosures && arguments[argumentIndex].is(ClosureExprSyntax.self) {
        // Non-closure variadics should not consume trailing closures
        break
      }
      consumeArgument(at: &argumentIndex, into: &matchingArguments)
    }

    return true
  }

  // Pack parameters follow the same greedy unlabeled consumption strategy as variadics.
  // However, as they don't have to deal with trailing closures their matching logic is simpler.
  func matchPackParameter(
    parameter: FunctionParameterSyntax,
    argumentIndex: inout Int,
    matchingArguments: inout [any SyntaxProtocol],
    maxMatchEndIndex: Int
  ) {
    if let expectedLabel = parameter.externalArgumentLabelText {
      guard argumentIndex < maxMatchEndIndex else {
        return
      }
      guard arguments[argumentIndex].labelAsString == expectedLabel else {
        return
      }

      consumeArgument(at: &argumentIndex, into: &matchingArguments)
    }

    while argumentIndex < maxMatchEndIndex && arguments[argumentIndex].labelAsString == nil {
      consumeArgument(at: &argumentIndex, into: &matchingArguments)
    }
  }

  var argumentIndex = arguments.startIndex
  var parameterMatches: [ArgumentMatchResult.ParameterMatch] = []

  for (parameterIndex, parameter) in parameters.enumerated() {
    var matchingArguments: [any SyntaxProtocol] = []
    let maxMatchEndIndex = maxMatchEndIndex(for: parameterIndex, argumentIndex: argumentIndex)

    switch parameter.argumentMatchingKind {
    case .fixed:
      guard
        matchFixedParameter(
          parameterIndex: parameterIndex,
          parameter: parameter,
          argumentIndex: &argumentIndex,
          matchingArguments: &matchingArguments,
          maxMatchEndIndex: maxMatchEndIndex
        )
      else {
        return nil
      }

    case .variadic:
      guard
        matchVariadicParameter(
          parameterIndex: parameterIndex,
          parameter: parameter,
          argumentIndex: &argumentIndex,
          matchingArguments: &matchingArguments,
          maxMatchEndIndex: maxMatchEndIndex
        )
      else {
        return nil
      }

    case .pack:
      matchPackParameter(
        parameter: parameter,
        argumentIndex: &argumentIndex,
        matchingArguments: &matchingArguments,
        maxMatchEndIndex: maxMatchEndIndex
      )
    }

    let parameterMatch = ArgumentMatchResult.ParameterMatch(
      parameter: parameter,
      arguments: matchingArguments
    )
    parameterMatches.append(parameterMatch)
  }

  if argumentIndex < arguments.endIndex {
    // If there are unmatched arguments remaining after processing all parameters, the match fails.
    return nil
  }

  return ArgumentMatchResult(matches: parameterMatches)
}

extension SyntaxProtocol {
  fileprivate var labelAsString: String? {
    // Labels can come from regular arguments (`foo(a: 1)`) or additional
    // trailing closures (`foo {} a: {}`), so we normalize both here.
    if let labeledExpr = self.as(LabeledExprSyntax.self) {
      return labeledExpr.label?.text
    } else if let multipleTrailingClosure = self.as(MultipleTrailingClosureElementSyntax.self) {
      return multipleTrailingClosure.label.text
    } else {
      return nil
    }
  }
}

extension FunctionParameterSyntax {
  fileprivate var externalArgumentLabelText: String? {
    guard firstName.tokenKind != .wildcard else {
      return nil
    }
    return firstName.text
  }

  fileprivate var parameterName: String? {
    if let secondName {
      return secondName.text
    }
    return firstName.text
  }

  fileprivate var argumentMatchingKind: ArgumentMatchResult.ParameterKind {
    if type.is(PackExpansionTypeSyntax.self) {
      return .pack
    }
    if ellipsis != nil {
      return .variadic
    }
    return .fixed
  }

  fileprivate var expectsClosureArgument: Bool {
    // Syntax-only check for whether a parameter's type can accept closure
    // expressions. This deliberately handles wrappers used in source
    // (`(@Sendable () -> Void)?`, `( () -> Void )`, etc.).
    func containsFunctionType(_ type: TypeSyntax) -> Bool {
      if type.is(FunctionTypeSyntax.self) {
        return true
      }
      if let attributed = type.as(AttributedTypeSyntax.self) {
        return containsFunctionType(attributed.baseType)
      }
      if let someOrAny = type.as(SomeOrAnyTypeSyntax.self) {
        return containsFunctionType(someOrAny.constraint)
      }
      if let optional = type.as(OptionalTypeSyntax.self) {
        return containsFunctionType(optional.wrappedType)
      }
      if let implicitlyUnwrapped = type.as(ImplicitlyUnwrappedOptionalTypeSyntax.self) {
        return containsFunctionType(implicitlyUnwrapped.wrappedType)
      }
      if let tuple = type.as(TupleTypeSyntax.self), tuple.elements.count == 1 {
        return containsFunctionType(tuple.elements.first!.type)
      }
      return false
    }

    return containsFunctionType(type)
  }
}
