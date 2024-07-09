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
///   - diagnosticHandler: Receives any diagnostics that are produced by the
///     evaluation, whether from errors in the source code or produced by the
///     build configuration itself.
/// - Throws: Throws if an error occurs occur during evaluation that prevents
///   this function from forming a valid result. The error will
///   also be provided to the diagnostic handler before doing so.
/// - Returns: A pair of Boolean values. The first describes whether the
///   condition holds with the given build configuration. The second whether
///   the build condition is a "versioned" check that implies that we shouldn't
///   diagnose syntax errors in blocks where the check fails.
func evaluateIfConfig(
  condition: ExprSyntax,
  configuration: some BuildConfiguration,
  diagnosticHandler: ((Diagnostic) -> Void)?
) throws -> (active: Bool, versioned: Bool) {
  /// Record the error before returning it. Use this for every 'throw' site
  /// in this evaluation.
  func recordedError(_ error: any Error, at node: some SyntaxProtocol) -> any Error {
    if let diagnosticHandler {
      error.asDiagnostics(at: node).forEach { diagnosticHandler($0) }
    }

    return error
  }

  /// Record an if-config evaluation error before returning it. Use this for
  /// every 'throw' site in this evaluation.
  func recordedError(_ error: IfConfigError) -> any Error {
    return recordedError(error, at: error.syntax)
  }

  /// Check a configuration condition, translating any thrown error into an
  /// appropriate diagnostic for the handler before rethrowing it.
  func checkConfiguration(
    at node: some SyntaxProtocol,
    body: () throws -> (Bool, Bool)
  ) throws -> (active: Bool, versioned: Bool) {
    do {
      return try body()
    } catch let error {
      throw recordedError(error, at: node)
    }
  }

  // Boolean literals evaluate as-is
  if let boolLiteral = condition.as(BooleanLiteralExprSyntax.self) {
    return (active: boolLiteral.literalValue, versioned: false)
  }

  // Integer literals aren't allowed, but we recognize them.
  if let intLiteral = condition.as(IntegerLiteralExprSyntax.self),
    (intLiteral.literal.text == "0" || intLiteral.literal.text == "1")
  {
    let result = intLiteral.literal.text == "1"

    diagnosticHandler?(
      IfConfigError.integerLiteralCondition(
        syntax: condition,
        replacement: result
      ).asDiagnostic
    )

    return (active: result, versioned: false)
  }

  // Declaration references are for custom compilation flags.
  if let identExpr = condition.as(DeclReferenceExprSyntax.self) {
    // FIXME: Need a real notion of an identifier.
    let ident = identExpr.baseName.text

    // Evaluate the custom condition. If the build configuration cannot answer this query, fail.
    return try checkConfiguration(at: identExpr) {
      (active: try configuration.isCustomConditionSet(name: ident), versioned: false)
    }
  }

  // Logical '!'.
  if let prefixOp = condition.as(PrefixOperatorExprSyntax.self),
    prefixOp.operator.text == "!"
  {
    let (innerActive, innerVersioned) = try evaluateIfConfig(
      condition: prefixOp.expression,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )

    return (active: !innerActive, versioned: innerVersioned)
  }

  // Logical '&&' and '||'.
  if let binOp = condition.as(InfixOperatorExprSyntax.self),
    let op = binOp.operator.as(BinaryOperatorExprSyntax.self),
    (op.operator.text == "&&" || op.operator.text == "||")
  {
    // Evaluate the left-hand side.
    let (lhsActive, lhsVersioned) = try evaluateIfConfig(
      condition: binOp.leftOperand,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )

    // Short-circuit evaluation if we know the answer and the left-hand side
    // was versioned.
    if lhsVersioned {
      switch (lhsActive, op.operator.text) {
      case (true, "||"): return (active: true, versioned: lhsVersioned)
      case (false, "&&"): return (active: false, versioned: lhsVersioned)
      default: break
      }
    }

    // Evaluate the right-hand side.
    let (rhsActive, rhsVersioned) = try evaluateIfConfig(
      condition: binOp.rightOperand,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )

    switch op.operator.text {
    case "||":
      return (
        active: lhsActive || rhsActive,
        versioned: lhsVersioned && rhsVersioned
      )

    case "&&":
      return (
        active: lhsActive && rhsActive,
        versioned: lhsVersioned || rhsVersioned
      )

    default:
      fatalError("prevented by condition for getting here")
    }
  }

  // Look through parentheses.
  if let tuple = condition.as(TupleExprSyntax.self), tuple.isParentheses,
    let element = tuple.elements.first
  {
    return try evaluateIfConfig(
      condition: element.expression,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
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
    ) throws -> (active: Bool, versioned: Bool) {
      // Ensure that we have a single argument that is a simple identifier.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr
      else {
        throw recordedError(
          .requiresUnlabeledArgument(name: fnName, role: role, syntax: ExprSyntax(call))
        )
      }

      return try checkConfiguration(at: argExpr) {
        (active: try body(arg), versioned: fn.isVersioned)
      }
    }

    /// Perform a check for a version constraint as used in the "swift" or "compiler" version checks.
    func doVersionComparisonCheck(
      _ actualVersion: VersionTuple
    ) throws -> (active: Bool, versioned: Bool) {
      // Ensure that we have a single unlabeled argument that is either >= or < as a prefix
      // operator applied to a version.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let unaryArg = argExpr.as(PrefixOperatorExprSyntax.self)
      else {
        throw recordedError(
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
        throw recordedError(.invalidVersionOperand(name: fnName, syntax: unaryArg.expression))
      }

      switch opToken.text {
      case ">=":
        return (active: actualVersion >= version, versioned: fn.isVersioned)
      case "<":
        return (active: actualVersion < version, versioned: fn.isVersioned)
      default:
        throw recordedError(.unsupportedVersionOperator(name: fnName, operator: opToken))
      }
    }

    switch fn {
    case .hasAttribute:
      return try doSingleIdentifierArgumentCheck(configuration.hasAttribute, role: "attribute")

    case .hasFeature:
      return try doSingleIdentifierArgumentCheck(configuration.hasFeature, role: "feature")

    case .os:
      return try doSingleIdentifierArgumentCheck(configuration.isActiveTargetOS, role: "operating system")

    case .arch:
      return try doSingleIdentifierArgumentCheck(configuration.isActiveTargetArchitecture, role: "architecture")

    case .targetEnvironment:
      return try doSingleIdentifierArgumentCheck(configuration.isActiveTargetEnvironment, role: "environment")

    case ._runtime:
      return try doSingleIdentifierArgumentCheck(configuration.isActiveTargetRuntime, role: "runtime")

    case ._ptrauth:
      return try doSingleIdentifierArgumentCheck(
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
        throw recordedError(
          .requiresUnlabeledArgument(
            name: fnName,
            role: "endiannes ('big' or 'little')",
            syntax: ExprSyntax(call)
          )
        )
      }

      return (
        active: configuration.endianness == expectedEndianness,
        versioned: fn.isVersioned
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
        throw recordedError(
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

      return (active: active, versioned: fn.isVersioned)

    case .swift:
      return try doVersionComparisonCheck(configuration.languageVersion)

    case .compiler:
      return try doVersionComparisonCheck(configuration.compilerVersion)

    case ._compiler_version:
      // Argument is a single unlabeled argument containing a string
      // literal.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let stringLiteral = argExpr.as(StringLiteralExprSyntax.self),
        stringLiteral.segments.count == 1,
        let segment = stringLiteral.segments.first,
        case .stringSegment(let stringSegment) = segment
      else {
        throw recordedError(
          .requiresUnlabeledArgument(
            name: "_compiler_version",
            role: "version",
            syntax: ExprSyntax(call)
          )
        )
      }

      let versionString = stringSegment.content.text
      let expectedVersion = try VersionTuple(parsingCompilerBuildVersion: versionString, argExpr)

      return (
        active: configuration.compilerVersion >= expectedVersion,
        versioned: fn.isVersioned
      )

    case .canImport:
      // Retrieve the first argument, which must not have a label. This is
      // the module import path.
      guard let firstArg = call.arguments.first,
        firstArg.label == nil
      else {
        throw recordedError(.canImportMissingModule(syntax: ExprSyntax(call)))
      }

      // FIXME: This is a gross hack. Actually look at the sequence of
      // `MemberAccessExprSyntax` nodes and pull out the identifiers.
      let importPath = firstArg.expression.trimmedDescription.split(separator: ".")

      // If there is a second argument, it shall have the label _version or
      // _underlyingVersion.
      let version: CanImportVersion
      if let secondArg = call.arguments.dropFirst().first {
        if secondArg.label?.text != "_version" && secondArg.label?.text != "_underlyingVersion" {
          throw recordedError(.canImportLabel(syntax: secondArg.expression))
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
          throw recordedError(
            .invalidVersionOperand(name: "canImport", syntax: secondArg.expression)
          )
        }

        // Remove excess components from the version,
        if versionTuple.components.count > 4 {
          // Remove excess components.
          versionTuple.components.removeSubrange(4...)

          // Warn that we did this.
          diagnosticHandler?(
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
          throw recordedError(.canImportTwoParameters(syntax: ExprSyntax(call)))
        }
      } else {
        version = .unversioned
      }

      return try checkConfiguration(at: call) {
        (
          active: try configuration.canImport(
            importPath: importPath.map { String($0) },
            version: version
          ),
          versioned: fn.isVersioned
        )
      }
    }
  }

  throw recordedError(.unknownExpression(condition))
}

extension IfConfigClauseSyntax {
  /// Determine whether this condition is "versioned".
  func isVersioned(
    configuration: some BuildConfiguration,
    diagnosticHandler: ((Diagnostic) -> Void)?
  ) throws -> Bool {
    guard let condition else { return false }

    // Evaluate this condition against the build configuration.
    let (_, versioned) = try evaluateIfConfig(
      condition: condition,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )

    return versioned
  }
}
