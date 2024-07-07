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
import SwiftOperators
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
private func evaluateIfConfig(
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

    case ._pointerBitWidth:
      // Ensure that we have a single argument that is a simple identifier, which
      // is an underscore followed by an integer.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr,
        let argFirst = arg.first,
        argFirst == "_",
        let expectedPointerBitWidth = Int(arg.dropFirst())
      else {
        throw recordedError(
          .requiresUnlabeledArgument(
            name: fnName,
            role: "pointer bit with ('_' followed by an integer)",
            syntax: ExprSyntax(call)
          )
        )
      }

      return (
        active: configuration.targetPointerBitWidth == expectedPointerBitWidth,
        versioned: fn.isVersioned
      )

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

extension ConfiguredRegionState {
  /// Evaluate the given `#if` condition using the given build configuration, throwing an error if there is
  /// insufficient information to make a determination.
  public init(
    condition: some ExprSyntaxProtocol,
    configuration: some BuildConfiguration,
    diagnosticHandler: ((Diagnostic) -> Void)? = nil
  ) throws {
    // Apply operator folding for !/&&/||.
    let foldedCondition = try OperatorTable.logicalOperators.foldAll(condition) { error in
      diagnosticHandler?(error.asDiagnostic)
      throw error
    }.cast(ExprSyntax.self)

    let (active, versioned) = try evaluateIfConfig(
      condition: foldedCondition,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )

    switch (active, versioned) {
    case (true, _): self = .active
    case (false, false): self = .inactive
    case (false, true): self = .unparsed
    }
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
  /// If an error occurrs while processing any of the `#if` clauses,
  /// that clause will be considered inactive and this operation will
  /// continue to evaluate later clauses.
  public func activeClause(
    in configuration: some BuildConfiguration,
    diagnosticHandler: ((Diagnostic) -> Void)? = nil
  ) -> IfConfigClauseSyntax? {
    for clause in clauses {
      // If there is no condition, we have reached an unconditional clause. Return it.
      guard let condition = clause.condition else {
        return clause
      }

      // If this condition evaluates true, return this clause.
      let isActive =
        (try? evaluateIfConfig(
          condition: condition,
          configuration: configuration,
          diagnosticHandler: diagnosticHandler
        ))?.active ?? false
      if isActive {
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
  ///   #endif
  /// #endif
  ///
  /// a call to `isActive` on the syntax node for the function `g` would return `active` when the
  /// configuration options `DEBUG` and `B` are provided, but `A` is not.
  public func isActive(
    in configuration: some BuildConfiguration,
    diagnosticHandler: ((Diagnostic) -> Void)? = nil
  ) throws -> ConfiguredRegionState {
    var currentNode: Syntax = Syntax(self)
    var currentState: ConfiguredRegionState = .active

    while let parent = currentNode.parent {
      // If the parent is an `#if` configuration, check whether our current
      // clause is active. If not, we're in an inactive region. We also
      // need to determine whether
      if let ifConfigClause = currentNode.as(IfConfigClauseSyntax.self),
        let ifConfigDecl = ifConfigClause.parent?.parent?.as(IfConfigDeclSyntax.self)
      {
        let activeClause = ifConfigDecl.activeClause(
          in: configuration,
          diagnosticHandler: diagnosticHandler
        )

        if activeClause != ifConfigClause {
          // This was not the active clause, so we know that we're in an
          // inactive block. However, if the condition is versioned, this is an
          // unparsed region.
          let isVersioned =
            (try? ifConfigClause.isVersioned(
              configuration: configuration,
              diagnosticHandler: diagnosticHandler
            )) ?? true
          if isVersioned {
            return .unparsed
          }

          currentState = .inactive
        }
      }

      currentNode = parent
    }

    return currentState
  }

  /// Determine whether the given syntax node is active given a set of
  /// configured regions as produced by `configuredRegions(in:)`.
  ///
  /// This is
  /// an approximation
  public func isActive(
    inConfiguredRegions regions: [(IfConfigClauseSyntax, ConfiguredRegionState)]
  ) -> ConfiguredRegionState {
    var currentState: ConfiguredRegionState = .active
    for (ifClause, state) in regions {
      if self.position < ifClause.position {
        return currentState
      }

      if self.position <= ifClause.endPosition {
        currentState = state
      }
    }

    return currentState
  }
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
