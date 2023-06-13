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
  case unsupportedVersionOperator(name: String, operator: TokenSyntax)
  case invalidVersionOperand(name: String, syntax: ExprSyntax)

  var description: String {
    switch self {
    case .unknownExpression:
      return "invalid conditional compilation expression"

    case .unhandledCustomCondition(name: let name, syntax: _):
      return "build configuration cannot handle custom condition '\(name)'"

    case .unhandledFunction(name: let name, syntax: _):
      return "build configuration cannot handle '\(name)'"

    case .unsupportedVersionOperator(name: let name, operator: let op):
      return "'\(name)' version check does not support operator '\(op.trimmedDescription)'"

    case .invalidVersionOperand(name: let name, syntax: let version):
      return "'\(name)' version check has invalid version '\(version.trimmedDescription)'"
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

    /// Perform a check for a version constraint as used in the "swift" or "compiler" version checks.
    func doVersionComparisonCheck(_ actualVersion: VersionTuple?) throws -> Bool? {
      // Ensure that we have a single unlabeled argument that is either >= or < as a prefix
      // operator applied to a version.
      guard let argExpr = call.argumentList.singleUnlabeledExpression,
            let unaryArg = argExpr.as(PrefixOperatorExprSyntax.self),
            let opToken = unaryArg.operatorToken else {
        return nil
      }

      guard let version = VersionTuple(parsing: unaryArg.postfixExpression.trimmedDescription) else {
        throw IfConfigError.invalidVersionOperand(name: fnName, syntax: unaryArg.postfixExpression)
      }

      guard let actualVersion else {
        throw IfConfigError.unhandledFunction(name: fnName, syntax: argExpr)
      }

      switch opToken.text {
      case ">=":
        return actualVersion >= version
      case "<":
        return actualVersion < version
      default:
        throw IfConfigError.unsupportedVersionOperator(name: fnName, operator: opToken)
      }
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

    case .swift:
      result = try doVersionComparisonCheck(configuration.languageVersion)

    case .compiler:
      result = try doVersionComparisonCheck(configuration.compilerVersion)

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

extension IfConfigDeclSyntax {
  /// Given a particular build configuration, determine which clause (if any) is the "active" clause.
  ///
  /// For example, for code like the following:
  /// ```
  /// #if A
  ///  func f()
  /// #elseif B
  ///  func g()
  /// #endif
  /// ```
  ///
  /// If the `A` configuration option was passed on the command line (e.g. via `-DA`), the first clause
  /// (containing `func f()`) would be returned. If not, and if the `B`configuration was passed on the
  /// command line, the second clause (containing `func g()`) would be returned. If neither was
  /// passed, this function will return `nil` to indicate that none of the regions are active.
  ///
  /// If an error occurred while processing any of the `#if` clauses, this function will throw that error.
  public func activeClause(in configuration: some BuildConfiguration) throws -> IfConfigClauseSyntax? {
    for clause in clauses {
      // If there is no condition, we have reached an unconditional clause. Return it.
      guard let condition = clause.condition else {
        return clause
      }

      // If this condition evaluates true, return this clause.
      if try evaluateIfConfig(condition: condition, configuration: configuration) {
        return clause
      }
    }

    return nil
  }
}

extension SyntaxProtocol {
  /// Determine whether the given syntax node is active within the given build configuration.
  ///
  /// This function evaluates the enclosing stack of `#if` conditions to determine whether the
  /// given node is active in the program when it is compiled with the given build configuration.
  ///
  /// For example, given code like the following:
  /// #if DEBUG
  ///   #if A
  ///    func f()
  ///  #elseif B
  ///    func g()
  /// #endif
  /// #endif
  ///
  /// a call to `isActive` on the syntax node for the function `g` would return `true` when the
  /// configuration options `DEBUG` and `B` are provided, but `A` is not.
  public func isActive(in configuration: some BuildConfiguration) throws -> Bool {
    var currentNode: Syntax = Syntax(self)
    var currentClause = currentNode.as(IfConfigClauseSyntax.self)

    while let parent = currentNode.parent {
      // If the parent is an `#if` configuration, check whether our current
      // clause is active. If not, we're in an inactive region.
      if let parentIfConfig = parent.as(IfConfigDeclSyntax.self) {
        if try currentClause != nil && parentIfConfig.activeClause(in: configuration) != currentClause {
          return false
        }

        currentClause = nil
      }

      // If the parent node is an if configuration clause, store it.
      if let parentClause = parent.as(IfConfigClauseSyntax.self) {
        currentClause = parentClause
      }

      currentNode = parent
    }

    // No more enclosing nodes; this code is active.
    return true
  }
}
