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
    _ error: IfConfigDiagnostic
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
        IfConfigDiagnostic.integerLiteralCondition(
          syntax: condition,
          replacement: result
        ).asDiagnostic
      ]
    )
  }

  // Declaration references are for custom compilation flags.
  if let identExpr = condition.as(DeclReferenceExprSyntax.self),
    let ident = identExpr.simpleIdentifier?.name
  {
    if let targetOSDiagnostic = diagnoseLikelyTargetOSTest(at: identExpr, name: ident) {
      extraDiagnostics.append(targetOSDiagnostic)
    }
    // Evaluate the custom condition. If the build configuration cannot answer this query, fail.
    return checkConfiguration(at: identExpr) {
      (active: try configuration.isCustomConditionSet(name: ident), syntaxErrorsAllowed: false)
    }
  }

  // Logical '!'.
  if let prefixOp = condition.as(PrefixOperatorExprSyntax.self) {
    // If this isn't '!', complain.
    guard prefixOp.operator.text == "!" else {
      return recordError(.badPrefixOperator(syntax: condition))
    }

    let (innerActive, innerSyntaxErrorsAllowed, innerDiagnostics) = evaluateIfConfig(
      condition: prefixOp.expression,
      configuration: configuration
    )

    return (active: !innerActive, syntaxErrorsAllowed: innerSyntaxErrorsAllowed, diagnostics: innerDiagnostics)
  }

  // Logical '&&' and '||'.
  if let binOp = condition.as(InfixOperatorExprSyntax.self),
    let op = binOp.operator.as(BinaryOperatorExprSyntax.self)
  {
    // If this is neither && nor ||, it was already diagnosed as part of
    // operator folding. Just return this as inactive.
    guard op.operator.text == "&&" || op.operator.text == "||" else {
      return (active: false, syntaxErrorsAllowed: true, diagnostics: extraDiagnostics)
    }

    // Check whether this was likely to be a check for targetEnvironment(simulator).
    if binOp.isOutermostIfCondition,
      let targetEnvironmentDiag = diagnoseLikelySimulatorEnvironmentTest(binOp)
    {
      extraDiagnostics.append(targetEnvironmentDiag)
    }

    // Evaluate the left-hand side.
    let (lhsActive, lhsSyntaxErrorsAllowed, lhsDiagnostics) = evaluateIfConfig(
      condition: binOp.leftOperand,
      configuration: configuration
    )

    // Determine whether we already know the result. We might short-circuit the
    // evaluation, depending on whether we need to produce validation
    // diagnostics for the right-hand side.
    let shortCircuitResult: Bool?
    switch (lhsActive, op.operator.text) {
    case (true, "||"): shortCircuitResult = true
    case (false, "&&"): shortCircuitResult = false
    default: shortCircuitResult = nil
    }

    // If we are supposed to short-circuit and the left-hand side of this
    // operator permits syntax errors when it fails, stop now: we shouldn't
    // process the right-hand side at all.
    if let isActive = shortCircuitResult, lhsSyntaxErrorsAllowed {
      return (
        active: isActive,
        syntaxErrorsAllowed: lhsSyntaxErrorsAllowed,
        diagnostics: extraDiagnostics + lhsDiagnostics
      )
    }

    // Process the right-hand side. If we already know the answer, then
    // avoid performing any build configuration queries that might cause
    // side effects.
    let rhsActive: Bool
    let rhsSyntaxErrorsAllowed: Bool
    let rhsDiagnostics: [Diagnostic]
    if shortCircuitResult != nil {
      (rhsActive, rhsSyntaxErrorsAllowed, rhsDiagnostics) = evaluateIfConfig(
        condition: binOp.rightOperand,
        configuration: CanImportSuppressingBuildConfiguration(other: configuration)
      )
    } else {
      (rhsActive, rhsSyntaxErrorsAllowed, rhsDiagnostics) = evaluateIfConfig(
        condition: binOp.rightOperand,
        configuration: configuration
      )
    }

    switch op.operator.text {
    case "||":
      return (
        active: lhsActive || rhsActive,
        syntaxErrorsAllowed: lhsSyntaxErrorsAllowed && rhsSyntaxErrorsAllowed,
        diagnostics: extraDiagnostics + lhsDiagnostics + rhsDiagnostics
      )

    case "&&":
      return (
        active: lhsActive && rhsActive,
        syntaxErrorsAllowed: lhsSyntaxErrorsAllowed || rhsSyntaxErrorsAllowed,
        diagnostics: extraDiagnostics + lhsDiagnostics + rhsDiagnostics
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
    let fnName = call.calledExpression.simpleIdentifierExpr?.name,
    let fn = IfConfigFunctions(rawValue: fnName)
  {
    /// Perform a check for an operation that takes a single identifier argument.
    func doSingleIdentifierArgumentCheck(
      _ body: (String) throws -> Bool,
      role: String
    ) -> (active: Bool, syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
      // Ensure that we have a single argument that is a simple identifier.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        var arg = argExpr.simpleIdentifierExpr?.name
      else {
        return recordError(
          .requiresUnlabeledArgument(name: fnName, role: role, syntax: ExprSyntax(call))
        )
      }

      // The historical "macabi" environment has been renamed to "macCatalyst".
      if role == "environment" && arg == "macabi" {
        extraDiagnostics.append(
          IfConfigDiagnostic.macabiIsMacCatalyst(syntax: argExpr)
            .asDiagnostic
        )

        arg = "macCatalyst"
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

    case .defined:
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr?.name
      else {
        return recordError(.unknownExpression(condition))
      }
      extraDiagnostics.append(
        IfConfigDiagnostic.unexpectedDefined(syntax: condition, argument: arg).asDiagnostic
      )
      return checkConfiguration(at: condition) {
        (active: try configuration.isCustomConditionSet(name: arg), syntaxErrorsAllowed: false)
      }

    case ._endian:
      // Ensure that we have a single argument that is a simple identifier.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr?.name
      else {
        return recordError(
          .requiresUnlabeledArgument(
            name: fnName,
            role: "endianness ('big' or 'little')",
            syntax: ExprSyntax(call)
          )
        )
      }

      // The argument needs to be either "little" or "big". Otherwise, we assume
      // it fails.
      let isActive: Bool
      if let expectedEndianness = Endianness(rawValue: arg) {
        isActive = configuration.endianness == expectedEndianness
      } else {
        // Complain about unknown endianness
        extraDiagnostics.append(
          IfConfigDiagnostic.endiannessDoesNotMatch(syntax: argExpr, argument: arg)
            .asDiagnostic
        )

        isActive = false
      }

      return (
        active: isActive,
        syntaxErrorsAllowed: fn.syntaxErrorsAllowed,
        diagnostics: extraDiagnostics
      )

    case ._pointerBitWidth, ._hasAtomicBitWidth:
      // Ensure that we have a single argument that is a simple identifier, which
      // is an underscore followed by an integer.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr?.name,
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
        expectedVersion = try VersionTuple.parseCompilerBuildVersion(
          versionString,
          argExpr,
          extraDiagnostics: &extraDiagnostics
        )
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

      if call.arguments.count > 2 {
        return recordError(.canImportTwoParameters(syntax: ExprSyntax(call)))
      }

      // Extract the import path.
      let importPath: [(TokenSyntax, String)]
      do {
        importPath = try extractImportPath(firstArg.expression)
      } catch {
        return recordError(error, at: firstArg.expression)
      }

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
            IfConfigDiagnostic.ignoredTrailingComponents(
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
      } else {
        version = .unversioned
      }

      return checkConfiguration(at: call) {
        (
          active: try configuration.canImport(
            importPath: importPath,
            version: version
          ),
          syntaxErrorsAllowed: fn.syntaxErrorsAllowed
        )
      }
    }
  }

  return recordError(.unknownExpression(condition))
}

extension SyntaxProtocol {
  /// Determine whether this expression node is an "outermost" #if condition,
  /// meaning that it is not nested within some kind of expression like && or
  /// ||.
  fileprivate var isOutermostIfCondition: Bool {
    // If there is no parent, it's the outermost condition.
    guard let parent = self.parent else {
      return true
    }

    // If we hit the #if condition clause, it's the outermost condition.
    if parent.is(IfConfigClauseSyntax.self) {
      return true
    }

    // We found an infix operator, so this is not an outermost #if condition.
    if parent.is(InfixOperatorExprSyntax.self) {
      return false
    }

    // Keep looking up the syntax tree.
    return parent.isOutermostIfCondition
  }
}

/// Given an expression with the expected form A.B.C, extract the import path
/// ["A", "B", "C"] from it with the token syntax nodes for each name.
/// Throws an error if the expression doesn't match this form.
private func extractImportPath(_ expression: some ExprSyntaxProtocol) throws -> [(TokenSyntax, String)] {
  // Member access.
  if let memberAccess = expression.as(MemberAccessExprSyntax.self),
    let base = memberAccess.base,
    let memberName = memberAccess.declName.simpleIdentifier?.name
  {
    return try extractImportPath(base) + [(memberAccess.declName.baseName, memberName)]
  }

  // Declaration reference.
  if let declRef = expression.as(DeclReferenceExprSyntax.self),
    let name = declRef.simpleIdentifier?.name
  {
    return [(declRef.baseName, name)]
  }

  throw IfConfigDiagnostic.expectedModuleName(syntax: ExprSyntax(expression))
}

/// Determine whether the given condition only involves disjunctions that
/// check the given config function against one of the provided values.
///
/// For example, this will match a condition like `os(iOS) ||  os(tvOS)`
/// when passed `IfConfigFunctions.os` and `["iOS", "tvOS"]`.
private func isConditionDisjunction(
  _ condition: some ExprSyntaxProtocol,
  function: IfConfigFunctions,
  anyOf values: [String]
) -> Bool {
  // Recurse into disjunctions. Both sides need to match.
  if let binOp = condition.as(InfixOperatorExprSyntax.self),
    let op = binOp.operator.as(BinaryOperatorExprSyntax.self),
    op.operator.text == "||"
  {
    return isConditionDisjunction(binOp.leftOperand, function: function, anyOf: values)
      && isConditionDisjunction(binOp.rightOperand, function: function, anyOf: values)
  }

  // Look through parentheses.
  if let tuple = condition.as(TupleExprSyntax.self), tuple.isParentheses,
    let element = tuple.elements.first
  {
    return isConditionDisjunction(element.expression, function: function, anyOf: values)
  }

  // If we have a call to this function, check whether the argument is one of
  // the acceptable values.
  if let call = condition.as(FunctionCallExprSyntax.self),
    let fnName = call.calledExpression.simpleIdentifierExpr?.name,
    let callFn = IfConfigFunctions(rawValue: fnName),
    callFn == function,
    let argExpr = call.arguments.singleUnlabeledExpression,
    let arg = argExpr.simpleIdentifierExpr?.name
  {
    return values.contains(arg)
  }

  return false
}

/// If this binary operator looks like it could be replaced by a
/// targetEnvironment(simulator) check, produce a diagnostic that does so.
///
/// For example, this checks for conditions like:
///
/// ```
/// #if (os(iOS) ||  os(tvOS)) && (arch(i386) || arch(x86_64))
/// ```
///
/// which should be replaced with
///
/// ```
/// #if targetEnvironment(simulator)
/// ```
private func diagnoseLikelySimulatorEnvironmentTest(
  _ binOp: InfixOperatorExprSyntax
) -> Diagnostic? {
  guard let op = binOp.operator.as(BinaryOperatorExprSyntax.self),
    op.operator.text == "&&"
  else {
    return nil
  }

  func isSimulatorPlatformOSTest(_ condition: ExprSyntax) -> Bool {
    return isConditionDisjunction(condition, function: .os, anyOf: ["iOS", "tvOS", "watchOS"])
  }

  func isSimulatorPlatformArchTest(_ condition: ExprSyntax) -> Bool {
    return isConditionDisjunction(condition, function: .arch, anyOf: ["i386", "x86_64"])
  }

  guard
    (isSimulatorPlatformOSTest(binOp.leftOperand) && isSimulatorPlatformArchTest(binOp.rightOperand))
      || (isSimulatorPlatformOSTest(binOp.rightOperand) && isSimulatorPlatformArchTest(binOp.leftOperand))
  else {
    return nil
  }

  return IfConfigDiagnostic.likelySimulatorPlatform(syntax: ExprSyntax(binOp)).asDiagnostic
}

/// If this identifier looks like it is a `TARGET_OS_*` compilation condition,
/// produce a diagnostic that suggests replacing it with the `os(*)` syntax.
///
/// For example, this checks for conditions like:
///
/// ```
/// #if TARGET_OS_IOS
/// ```
///
/// which should be replaced with
///
/// ```
/// #if os(iOS)
/// ```
private func diagnoseLikelyTargetOSTest(
  at reference: DeclReferenceExprSyntax,
  name: String
) -> Diagnostic? {
  let prefix = "TARGET_OS_"
  guard name.hasPrefix(prefix) else { return nil }
  let osName = String(name.dropFirst(prefix.count))

  if unmappedTargetOSNames.contains(osName) {
    return IfConfigDiagnostic.likelyTargetOS(syntax: ExprSyntax(reference), replacement: nil).asDiagnostic
  }

  guard let replacement = targetOSNameMap[osName] else { return nil }

  return IfConfigDiagnostic.likelyTargetOS(syntax: ExprSyntax(reference), replacement: replacement).asDiagnostic
}

// TARGET_OS_* macros that don’t have a direct Swift equivalent
private let unmappedTargetOSNames = ["WIN32", "UNIX", "MAC", "IPHONE", "EMBEDDED"]
private let targetOSNameMap: [String: ExprSyntax] = [
  "WINDOWS": "os(Windows)",
  "LINUX": "os(Linux)",
  "OSX": "os(macOS)",
  "IOS": "os(iOS)",
  "MACCATALYST": "targetEnvironment(macCatalyst)",
  "TV": "os(tvOS)",
  "WATCH": "os(watchOS)",
  "VISION": "os(visionOS)",
  "SIMULATOR": "targetEnvironment(simulator)",
]

extension IfConfigClauseSyntax {
  /// Fold the operators within an #if condition, turning sequence expressions
  /// involving the various allowed operators (&&, ||, !) into well-structured
  /// binary operators.
  static func foldOperators(
    _ condition: some ExprSyntaxProtocol
  ) -> (folded: ExprSyntax, diagnostics: [Diagnostic]) {
    var foldingDiagnostics: [Diagnostic] = []
    let foldedCondition = OperatorTable.logicalOperators.foldAll(condition) { error in
      // Replace the "unknown infix operator" diagnostic with a custom one
      // that mentions that only '&&' and '||' are allowed.
      if case .missingOperator(_, referencedFrom: let syntax) = error,
        let binOp = syntax.parent?.as(BinaryOperatorExprSyntax.self)
      {

        foldingDiagnostics.append(
          IfConfigDiagnostic.badInfixOperator(syntax: ExprSyntax(binOp)).asDiagnostic
        )
        return
      }

      foldingDiagnostics.append(contentsOf: error.asDiagnostics(at: condition))
    }.cast(ExprSyntax.self)
    return (folded: foldedCondition, diagnostics: foldingDiagnostics)
  }

  /// Determine whether the given expression, when used as the condition in
  /// an inactive `#if` clause, implies that syntax errors are permitted within
  /// that region.
  @_spi(Compiler)
  public static func syntaxErrorsAllowed(
    _ condition: some ExprSyntaxProtocol
  ) -> (syntaxErrorsAllowed: Bool, diagnostics: [Diagnostic]) {
    let (foldedCondition, foldingDiagnostics) = IfConfigClauseSyntax.foldOperators(condition)

    return (
      !foldingDiagnostics.isEmpty || foldedCondition.allowsSyntaxErrorsFolded,
      foldingDiagnostics
    )
  }
}

extension ExprSyntaxProtocol {
  /// Determine whether this expression, when used as a condition within a #if
  /// that evaluates false, implies that the code contained in that `#if`
  ///
  /// Check whether of allowsSyntaxErrors(_:) that assumes that inputs have
  /// already been operator-folded.
  var allowsSyntaxErrorsFolded: Bool {
    // Logical '!'.
    if let prefixOp = self.as(PrefixOperatorExprSyntax.self),
      prefixOp.operator.text == "!"
    {
      return prefixOp.expression.allowsSyntaxErrorsFolded
    }

    // Logical '&&' and '||'.
    if let binOp = self.as(InfixOperatorExprSyntax.self),
      let op = binOp.operator.as(BinaryOperatorExprSyntax.self)
    {
      switch op.operator.text {
      case "&&":
        return binOp.leftOperand.allowsSyntaxErrorsFolded || binOp.rightOperand.allowsSyntaxErrorsFolded
      case "||":
        return binOp.leftOperand.allowsSyntaxErrorsFolded && binOp.rightOperand.allowsSyntaxErrorsFolded
      default:
        return false
      }
    }

    // Look through parentheses.
    if let tuple = self.as(TupleExprSyntax.self), tuple.isParentheses,
      let element = tuple.elements.first
    {
      return element.expression.allowsSyntaxErrorsFolded
    }

    // Call syntax is for operations.
    if let call = self.as(FunctionCallExprSyntax.self),
      let fnName = call.calledExpression.simpleIdentifierExpr?.name,
      let fn = IfConfigFunctions(rawValue: fnName)
    {
      return fn.syntaxErrorsAllowed
    }

    return false
  }
}

/// Build configuration adaptor that suppresses calls to canImport, which
/// can have side effects. This is somewhat of a hack for the compiler.
private struct CanImportSuppressingBuildConfiguration<Other: BuildConfiguration>: BuildConfiguration {
  var other: Other

  func isCustomConditionSet(name: String) throws -> Bool {
    return try other.isCustomConditionSet(name: name)
  }

  func hasFeature(name: String) throws -> Bool {
    return try other.hasFeature(name: name)
  }

  func hasAttribute(name: String) throws -> Bool {
    return try other.hasAttribute(name: name)
  }

  func canImport(importPath: [(TokenSyntax, String)], version: CanImportVersion) throws -> Bool {
    return false
  }

  func isActiveTargetOS(name: String) throws -> Bool {
    return try other.isActiveTargetOS(name: name)
  }

  func isActiveTargetArchitecture(name: String) throws -> Bool {
    return try other.isActiveTargetArchitecture(name: name)
  }

  func isActiveTargetEnvironment(name: String) throws -> Bool {
    return try other.isActiveTargetEnvironment(name: name)
  }

  func isActiveTargetRuntime(name: String) throws -> Bool {
    return try other.isActiveTargetRuntime(name: name)
  }

  func isActiveTargetPointerAuthentication(name: String) throws -> Bool {
    return try other.isActiveTargetPointerAuthentication(name: name)
  }

  var targetPointerBitWidth: Int { return other.targetPointerBitWidth }

  var targetAtomicBitWidths: [Int] { return other.targetAtomicBitWidths }

  var endianness: Endianness { return other.endianness }

  var languageVersion: VersionTuple { return other.languageVersion }

  var compilerVersion: VersionTuple { return other.compilerVersion }
}
