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
import SwiftOperators

enum IfConfigError: Error, CustomStringConvertible {
  case unknownExpression(ExprSyntax)
  case unhandledCustomCondition(name: String, syntax: TokenSyntax)
  case unhandledFunction(name: String, syntax: ExprSyntax)

  var description: String {
    switch self {
    case .unknownExpression:
      return "invalid conditional compilation expression"

    case .unhandledCustomCondition(name: let name, syntax: _):
      return "build configuration cannot handle custom condition '\(name)'"

    case .unhandledFunction(name: let name, syntax: _):
      return "build configuration cannot handle '\(name)'"
    }
  }
}

/// Evaluate the condition of an `#if`.
private func evaluateIfConfig(
  condition: ExprSyntax,
  configuration: some BuildConfiguration
) throws -> Bool {
  // Boolean literals evaluate as-is
  if let boolLiteral = condition.as(BooleanLiteralExprSyntax.self) {
    return boolLiteral.literalValue
  }

  // Integer literals evaluate true if that are not "0".
  if let intLiteral = condition.as(IntegerLiteralExprSyntax.self) {
    return intLiteral.digits.text != "0"
  }

  // Declaration references are for custom compilation flags.
  if let identExpr = condition.as(IdentifierExprSyntax.self) {
    // FIXME: Need a real notion of an identifier.
    let ident = identExpr.identifier.text

    // Evaluate the custom condition. If the build configuration cannot answer this query, fail.
    guard let result = configuration.isCustomConditionSet(name: ident, syntax: identExpr.identifier) else {
      throw IfConfigError.unhandledCustomCondition(name: ident, syntax: identExpr.identifier)
    }
    return result
  }

  // Logical '!'.
  if let prefixOp = condition.as(PrefixOperatorExprSyntax.self),
      prefixOp.operatorToken?.text == "!" {
    return try !evaluateIfConfig(condition: prefixOp.postfixExpression, configuration: configuration)
  }

  // Logical '&&' and '||'.
  if let binOp = condition.as(InfixOperatorExprSyntax.self),
      let op = binOp.operatorOperand.as(BinaryOperatorExprSyntax.self),
      (op.operatorToken.text == "&&" || op.operatorToken.text == "||") {
    // Evaluate the left-hand side.
    let lhsResult = try evaluateIfConfig(condition: binOp.leftOperand, configuration: configuration)

    // Short-circuit evaluation if we know the answer.
    switch (lhsResult, op.operatorToken.text) {
    case (true, "||"): return true
    case (false, "&&"): return false
    default: break
    }

    // Evaluate the right-hand side and use that result.
    return try evaluateIfConfig(condition: binOp.rightOperand, configuration: configuration)
  }

  // Look through parentheses.
  if let tuple = condition.as(TupleExprSyntax.self), tuple.isParentheses,
     let element = tuple.elements.first {
    return try evaluateIfConfig(condition: element.expression, configuration: configuration)
  }

  // Calls syntax is for operations.
  if let call = condition.as(FunctionCallExprSyntax.self),
     let fnName = call.calledExpression.simpleIdentifierExpr,
     let fn = IfConfigFunctions(rawValue: fnName) {

    /// Perform a check for an operation that takes a single identifier argument.
    func doSingleIdentifierArgumentCheck(_ body: (String, ExprSyntax) -> Bool?) throws -> Bool? {
      // Ensure that we have a single argument that is a simple identifier.
      guard let argExpr = call.argumentList.singleUnlabeledExpression,
            let arg = argExpr.simpleIdentifierExpr else { return nil }

      guard let result = body(arg, ExprSyntax(argExpr)) else {
        throw IfConfigError.unhandledFunction(name: fnName, syntax: ExprSyntax(call))
      }

      return result
    }

    let result: Bool?
    switch fn {
    case .hasAttribute:
      result = try doSingleIdentifierArgumentCheck(configuration.hasAttribute)

    case .hasFeature:
      result = try doSingleIdentifierArgumentCheck(configuration.hasFeature)

    case .os:
      result = try doSingleIdentifierArgumentCheck(configuration.isActiveTargetOS)

    case .arch:
      result = try doSingleIdentifierArgumentCheck(configuration.isActiveTargetArchitecture)

    case .targetEnvironment:
      result = try doSingleIdentifierArgumentCheck(configuration.isActiveTargetEnvironment)

    case ._runtime:
      result = try doSingleIdentifierArgumentCheck(configuration.isActiveTargetRuntime)

    case ._ptrauth:
      result = try doSingleIdentifierArgumentCheck(configuration.isActiveTargetPointerAuthentication)

    case ._endian:
      // Ensure that we have a single argument that is a simple identifier,
      // either "little" or "big".
      guard let argExpr = call.argumentList.singleUnlabeledExpression,
            let arg = argExpr.simpleIdentifierExpr,
            let expectedEndianness = Endianness(rawValue: arg) else {
        result = nil
        break
      }

      // If the build configuration doesn't know the endianness, fail.
      guard let targetEndianness = configuration.endianness else {
        throw IfConfigError.unhandledFunction(name: fnName, syntax: ExprSyntax(call))
      }

      result = targetEndianness == expectedEndianness

    case ._pointerBitWidth:
      // Ensure that we have a single argument that is a simple identifier, which
      // is an underscore followed by an integer.
      guard let argExpr = call.argumentList.singleUnlabeledExpression,
            let arg = argExpr.simpleIdentifierExpr,
            let argFirst = arg.first,
            argFirst == "_",
            let expectedPointerBitWidth = Int(arg.dropFirst()) else {
        result = nil
        break
      }

      // If the build configuration doesn't know the pointer bit width, fail.
      guard let targetPointerBitWidth = configuration.targetPointerBitWidth else {
        throw IfConfigError.unhandledFunction(name: fnName, syntax: ExprSyntax(call))
      }

      result = targetPointerBitWidth == expectedPointerBitWidth

    default:
      // FIXME: Deal with all of the other kinds of checks we can perform.
      result = nil
      break
    }

    // If we found a result, return it.
    if let result { return result }

    // Otherwise, fall through to diagnose the error
  }

  throw IfConfigError.unknownExpression(condition)
}

extension IfConfigState {
  /// Evaluate the given `#if` condition using the given build configuration, throwing an error if there is
  /// insufficient information to make a determination.
  public init(condition: some ExprSyntaxProtocol, configuration: some BuildConfiguration) throws {
    // Apply operator folding for !/&&/||.
    let foldedCondition = try OperatorTable.logicalOperators.foldAll(condition).as(ExprSyntax.self)!

    let result = try evaluateIfConfig(condition: foldedCondition, configuration: configuration)
    self = result ? .active : .inactive
  }
}
