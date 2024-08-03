//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftSyntax

/// Evaluate the condition of an `#if`.
/// - Parameters:
///   - condition: The condition to evaluate, which we assume has already been
///     folded according to the logical operators table.
///   - configuration: The configuration against which the condition will be
///     evaluated.
/// - Throws: Throws if an error occurs occur during evaluation that prevents
///   this function from forming a valid result. The error will
///   also be provided to the diagnostic handler before doing so.
/// - Returns: A pair of Boolean values and any diagnostics produced during the
///   evaluation. The first Boolean describes whether the condition holds with
///   the given build configuration. The second Boolean described whether
///   the build condition's failure implies that we shouldn't
///   diagnose syntax errors in blocks where the check fails.
func evaluateIfConfig(
  condition: ExprSyntax,
  configuration: some BuildConfiguration
) -> (active: Bool, syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
  var extraDiagnostics: [Diagnostic] = []

  /// Record the error before returning the given value.
  func recordError(
    _ error: any Error,
    at node: some SyntaxProtocol
  ) -> (active: Bool, syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
    return (
      active: false,
      syntaxErrorsAllowed: true,
      diagnostics: extraDiagnostics + error.asDiagnostics(at: node)
    )
  }

  /// Record an if-config evaluation error before returning it. Use this for
  /// every 'throw' site in this evaluation.
  func recordError(
    _ error: IfConfigError
  ) -> (active: Bool, syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
    return recordError(error, at: error.syntax)
  }

  /// Check a configuration condition, translating any thrown error into an
  /// appropriate diagnostic for the handler before rethrowing it.
  func checkConfiguration(
    at node: some SyntaxProtocol,
    body: () throws -> (Bool, Bool)
  ) -> (active: Bool, syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
    do {
      let (active, syntaxErrorsAllowed) = try body()
      return (active, syntaxErrorsAllowed, extraDiagnostics)
    } catch let error {
      return recordError(error, at: node)
    }
  }

  // Boolean literals evaluate as-is
  if let boolLiteral = condition.as(BooleanLiteralExprSyntax.self) {
    return (
      active: boolLiteral.literalValue,
      syntaxErrorsAllowed: false,
      diagnostics: extraDiagnostics
    )
  }

  // Integer literals aren't allowed, but we recognize them.
  if let intLiteral = condition.as(IntegerLiteralExprSyntax.self),
    (intLiteral.literal.text == "0" || intLiteral.literal.text == "1")
  {
    let result = intLiteral.literal.text == "1"

    return (
      active: result,
      syntaxErrorsAllowed: false,
      diagnostics: [
        IfConfigError.integerLiteralCondition(
          syntax: condition,
          replacement: result
        ).asDiagnostic
      ]
    )
  }

  // Declaration references are for custom compilation flags.
  if let identExpr = condition.as(DeclReferenceExprSyntax.self) {
    // FIXME: Need a real notion of an identifier.
    let ident = identExpr.baseName.text

    // Evaluate the custom condition. If the build configuration cannot answer this query, fail.
    return checkConfiguration(at: identExpr) {
      (active: try configuration.isCustomConditionSet(name: ident), syntaxErrorsAllowed: false)
    }
  }

  // Logical '!'.
  if let prefixOp = condition.as(PrefixOperatorExprSyntax.self),
    prefixOp.operator.text == "!"
  {
    let (innerActive, innerSyntaxErrorsAllowed, innerDiagnostics) = evaluateIfConfig(
      condition: prefixOp.expression,
      configuration: configuration
    )

    return (active: !innerActive, syntaxErrorsAllowed: innerSyntaxErrorsAllowed, diagnostics: innerDiagnostics)
  }

  // Logical '&&' and '||'.
  if let binOp = condition.as(InfixOperatorExprSyntax.self),
    let op = binOp.operator.as(BinaryOperatorExprSyntax.self),
    (op.operator.text == "&&" || op.operator.text == "||")
  {
    // Evaluate the left-hand side.
    let (lhsActive, lhssyntaxErrorsAllowed, lhsDiagnostics) = evaluateIfConfig(
      condition: binOp.leftOperand,
      configuration: configuration
    )

    // Short-circuit evaluation if we know the answer and the left-hand side
    // was syntaxErrorsAllowed.
    if lhssyntaxErrorsAllowed {
      switch (lhsActive, op.operator.text) {
      case (true, "||"):
        return (active: true, syntaxErrorsAllowed: lhssyntaxErrorsAllowed, diagnostics: lhsDiagnostics)
      case (false, "&&"):
        return (active: false, syntaxErrorsAllowed: lhssyntaxErrorsAllowed, diagnostics: lhsDiagnostics)
      default:
        break
      }
    }

    // Evaluate the right-hand side.
    let (rhsActive, rhssyntaxErrorsAllowed, rhsDiagnostics) = evaluateIfConfig(
      condition: binOp.rightOperand,
      configuration: configuration
    )

    switch op.operator.text {
    case "||":
      return (
        active: lhsActive || rhsActive,
        syntaxErrorsAllowed: lhssyntaxErrorsAllowed && rhssyntaxErrorsAllowed,
        diagnostics: lhsDiagnostics + rhsDiagnostics
      )

    case "&&":
      return (
        active: lhsActive && rhsActive,
        syntaxErrorsAllowed: lhssyntaxErrorsAllowed || rhssyntaxErrorsAllowed,
        diagnostics: lhsDiagnostics + rhsDiagnostics
      )

    default:
      fatalError("prevented by condition for getting here")
    }
  }

  // Look through parentheses.
  if let tuple = condition.as(TupleExprSyntax.self), tuple.isParentheses,
    let element = tuple.elements.first
  {
    return evaluateIfConfig(
      condition: element.expression,
      configuration: configuration
    )
  }

  // Call syntax is for operations.
  if let call = condition.as(FunctionCallExprSyntax.self),
    let fnName = call.calledExpression.simpleIdentifierExpr,
    let fn = IfConfigFunctions(rawValue: fnName)
  {
    /// Perform a check for an operation that takes a single identifier argument.
    func doSingleIdentifierArgumentCheck(
      _ body: (String) throws -> Bool,
      role: String
    ) -> (active: Bool, syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
      // Ensure that we have a single argument that is a simple identifier.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr
      else {
        return recordError(
          .requiresUnlabeledArgument(name: fnName, role: role, syntax: ExprSyntax(call))
        )
      }

      return checkConfiguration(at: argExpr) {
        (active: try body(arg), syntaxErrorsAllowed: fn.syntaxErrorsAllowed)
      }
    }

    /// Perform a check for a version constraint as used in the "swift" or "compiler" version checks.
    func doVersionComparisonCheck(
      _ actualVersion: VersionTuple
    ) -> (active: Bool, syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
      // Ensure that we have a single unlabeled argument that is either >= or < as a prefix
      // operator applied to a version.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let unaryArg = argExpr.as(PrefixOperatorExprSyntax.self)
      else {
        return recordError(
          .requiresUnlabeledArgument(
            name: fnName,
            role: "version comparison (>= or <= a version)",
            syntax: ExprSyntax(call)
          )
        )
      }

      // Parse the version.
      let opToken = unaryArg.operator
      guard let version = VersionTuple(parsing: unaryArg.expression.trimmedDescription) else {
        return recordError(.invalidVersionOperand(name: fnName, syntax: unaryArg.expression))
      }

      switch opToken.text {
      case ">=":
        return (
          active: actualVersion >= version,
          syntaxErrorsAllowed: fn.syntaxErrorsAllowed,
          diagnostics: extraDiagnostics
        )
      case "<":
        return (
          active: actualVersion < version,
          syntaxErrorsAllowed: fn.syntaxErrorsAllowed,
          diagnostics: extraDiagnostics
        )
      default:
        return recordError(.unsupportedVersionOperator(name: fnName, operator: opToken))
      }
    }

    switch fn {
    case .hasAttribute:
      return doSingleIdentifierArgumentCheck(configuration.hasAttribute, role: "attribute")

    case .hasFeature:
      return doSingleIdentifierArgumentCheck(configuration.hasFeature, role: "feature")

    case .os:
      return doSingleIdentifierArgumentCheck(configuration.isActiveTargetOS, role: "operating system")

    case .arch:
      return doSingleIdentifierArgumentCheck(configuration.isActiveTargetArchitecture, role: "architecture")

    case .targetEnvironment:
      return doSingleIdentifierArgumentCheck(configuration.isActiveTargetEnvironment, role: "environment")

    case ._runtime:
      return doSingleIdentifierArgumentCheck(configuration.isActiveTargetRuntime, role: "runtime")

    case ._ptrauth:
      return doSingleIdentifierArgumentCheck(
        configuration.isActiveTargetPointerAuthentication,
        role: "pointer authentication scheme"
      )

    case ._endian:
      // Ensure that we have a single argument that is a simple identifier,
      // either "little" or "big".
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr,
        let expectedEndianness = Endianness(rawValue: arg)
      else {
        return recordError(
          .requiresUnlabeledArgument(
            name: fnName,
            role: "endiannes ('big' or 'little')",
            syntax: ExprSyntax(call)
          )
        )
      }

      return (
        active: configuration.endianness == expectedEndianness,
        syntaxErrorsAllowed: fn.syntaxErrorsAllowed,
        diagnostics: extraDiagnostics
      )

    case ._pointerBitWidth, ._hasAtomicBitWidth:
      // Ensure that we have a single argument that is a simple identifier, which
      // is an underscore followed by an integer.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr,
        let argFirst = arg.first,
        argFirst == "_",
        let expectedBitWidth = Int(arg.dropFirst())
      else {
        return recordError(
          .requiresUnlabeledArgument(
            name: fnName,
            role: "bit width ('_' followed by an integer)",
            syntax: ExprSyntax(call)
          )
        )
      }

      let active: Bool
      if fn == ._pointerBitWidth {
        active = configuration.targetPointerBitWidth == expectedBitWidth
      } else if fn == ._hasAtomicBitWidth {
        active = configuration.targetAtomicBitWidths.contains(expectedBitWidth)
      } else {
        fatalError("extraneous case above not handled")
      }

      return (active: active, syntaxErrorsAllowed: fn.syntaxErrorsAllowed, diagnostics: extraDiagnostics)

    case .swift:
      return doVersionComparisonCheck(configuration.languageVersion)

    case .compiler:
      return doVersionComparisonCheck(configuration.compilerVersion)

    case ._compiler_version:
      // Argument is a single unlabeled argument containing a string
      // literal.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let stringLiteral = argExpr.as(StringLiteralExprSyntax.self),
        stringLiteral.segments.count == 1,
        let segment = stringLiteral.segments.first,
        case .stringSegment(let stringSegment) = segment
      else {
        return doVersionComparisonCheck(configuration.compilerVersion)
      }

      let versionString = stringSegment.content.text
      let expectedVersion: VersionTuple
      do {
        expectedVersion = try VersionTuple(parsingCompilerBuildVersion: versionString, argExpr)
      } catch {
        return recordError(error, at: stringSegment.content)
      }

      return (
        active: configuration.compilerVersion >= expectedVersion,
        syntaxErrorsAllowed: fn.syntaxErrorsAllowed,
        diagnostics: extraDiagnostics
      )

    case .canImport:
      // Retrieve the first argument, which must not have a label. This is
      // the module import path.
      guard let firstArg = call.arguments.first,
        firstArg.label == nil
      else {
        return recordError(.canImportMissingModule(syntax: ExprSyntax(call)))
      }

      // FIXME: This is a gross hack. Actually look at the sequence of
      // `MemberAccessExprSyntax` nodes and pull out the identifiers.
      let importPath = firstArg.expression.trimmedDescription.split(separator: ".")

      // If there is a second argument, it shall have the label _version or
      // _underlyingVersion.
      let version: CanImportVersion
      if let secondArg = call.arguments.dropFirst().first {
        if secondArg.label?.text != "_version" && secondArg.label?.text != "_underlyingVersion" {
          return recordError(.canImportLabel(syntax: secondArg.expression))
        }

        let versionText: String
        if let stringLiteral = secondArg.expression.as(StringLiteralExprSyntax.self),
          stringLiteral.segments.count == 1,
          let firstSegment = stringLiteral.segments.first,
          case .stringSegment(let stringSegment) = firstSegment
        {
          versionText = stringSegment.content.text
        } else {
          versionText = secondArg.expression.trimmedDescription
        }

        guard var versionTuple = VersionTuple(parsing: versionText) else {
          return recordError(
            .invalidVersionOperand(name: "canImport", syntax: secondArg.expression)
          )
        }

        // Remove excess components from the version,
        if versionTuple.components.count > 4 {
          // Remove excess components.
          versionTuple.components.removeSubrange(4...)

          // Warn that we did this.
          extraDiagnostics.append(
            IfConfigError.ignoredTrailingComponents(
              version: versionTuple,
              syntax: secondArg.expression
            ).asDiagnostic
          )
        }

        if secondArg.label?.text == "_version" {
          version = .version(versionTuple)
        } else {
          assert(secondArg.label?.text == "_underlyingVersion")
          version = .underlyingVersion(versionTuple)
        }

        if call.arguments.count > 2 {
          return recordError(.canImportTwoParameters(syntax: ExprSyntax(call)))
        }
      } else {
        version = .unversioned
      }

      return checkConfiguration(at: call) {
        (
          active: try configuration.canImport(
            importPath: importPath.map { String($0) },
            version: version
          ),
          syntaxErrorsAllowed: fn.syntaxErrorsAllowed
        )
      }
    }
  }

  return recordError(.unknownExpression(condition))
}

extension IfConfigClauseSyntax {
  /// Determine whether this condition is "syntaxErrorsAllowed".
  func syntaxErrorsAllowed(
    configuration: some BuildConfiguration
  ) -> (syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
    guard let condition else {
      return (syntaxErrorsAllowed: false, diagnostics: [])
    }

    // Evaluate this condition against the build configuration.
    let (_, syntaxErrorsAllowed, diagnostics) = evaluateIfConfig(
      condition: condition,
      configuration: configuration
    )

    return (syntaxErrorsAllowed, diagnostics)
  }
}
