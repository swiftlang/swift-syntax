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
import SwiftDiagnostics
import SwiftOperators
import SwiftSyntax

enum IfConfigError: Error, CustomStringConvertible {
  case unknownExpression(ExprSyntax)
  case unhandledFunction(name: String, syntax: ExprSyntax)
  case requiresUnlabeledArgument(name: String, role: String, syntax: ExprSyntax)
  case unsupportedVersionOperator(name: String, operator: TokenSyntax)
  case invalidVersionOperand(name: String, syntax: ExprSyntax)
  case emptyVersionComponent(syntax: ExprSyntax)
  case compilerVersionOutOfRange(value: Int, upperLimit: Int, syntax: ExprSyntax)
  case compilerVersionSecondComponentNotWildcard(syntax: ExprSyntax)
  case compilerVersionTooManyComponents(syntax: ExprSyntax)
  case canImportMissingModule(syntax: ExprSyntax)
  case canImportLabel(syntax: ExprSyntax)
  case canImportTwoParameters(syntax: ExprSyntax)
  case ignoredTrailingComponents(version: VersionTuple, syntax: ExprSyntax)
  case integerLiteralCondition(syntax: ExprSyntax, replacement: Bool)

  var description: String {
    switch self {
    case .unknownExpression:
      return "invalid conditional compilation expression"

    case .unhandledFunction(name: let name, syntax: _):
      return "build configuration cannot handle '\(name)'"

    case .requiresUnlabeledArgument(name: let name, role: let role, syntax: _):
      return "\(name) requires a single unlabeled argument for the \(role)"

    case .unsupportedVersionOperator(name: let name, operator: let op):
      return "'\(name)' version check does not support operator '\(op.trimmedDescription)'"

    case .invalidVersionOperand(name: let name, syntax: let version):
      return "'\(name)' version check has invalid version '\(version.trimmedDescription)'"

    case .emptyVersionComponent(syntax: _):
      return "found empty version component"

    case .compilerVersionOutOfRange(value: _, upperLimit: let upperLimit, syntax: _):
      // FIXME: This matches the C++ implementation, but it would be more useful to
      // provide the actual value as-written and avoid the mathy [0, N] syntax.
      return "compiler version component out of range: must be in [0, \(upperLimit)]"

    case .compilerVersionSecondComponentNotWildcard(syntax: _):
      return "the second version component is not used for comparison in legacy compiler versions"

    case .compilerVersionTooManyComponents(syntax: _):
      return "compiler version must not have more than five components"

    case .canImportMissingModule(syntax: _):
      return "canImport requires a module name"

    case .canImportLabel(syntax: _):
      return "2nd parameter of canImport should be labeled as _version or _underlyingVersion"

    case .canImportTwoParameters(syntax: _):
      return "canImport can take only two parameters"

    case .ignoredTrailingComponents(version: let version, syntax: _):
      return "trailing components of version '\(version.description)' are ignored"

    case .integerLiteralCondition(syntax: let syntax, replacement: let replacement):
      return "'\(syntax.trimmedDescription)' is not a valid conditional compilation expression, use '\(replacement)'"
    }
  }

  /// Retrieve the syntax node associated with this error.
  var syntax: Syntax {
    switch self {
    case .unknownExpression(let syntax),
      .unhandledFunction(name: _, syntax: let syntax),
      .requiresUnlabeledArgument(name: _, role: _, syntax: let syntax),
      .invalidVersionOperand(name: _, syntax: let syntax),
      .emptyVersionComponent(syntax: let syntax),
      .compilerVersionOutOfRange(value: _, upperLimit: _, syntax: let syntax),
      .compilerVersionTooManyComponents(syntax: let syntax),
      .compilerVersionSecondComponentNotWildcard(syntax: let syntax),
      .canImportMissingModule(syntax: let syntax),
      .canImportLabel(syntax: let syntax),
      .canImportTwoParameters(syntax: let syntax),
      .ignoredTrailingComponents(version: _, syntax: let syntax),
      .integerLiteralCondition(syntax: let syntax, replacement: _):
      return Syntax(syntax)

    case .unsupportedVersionOperator(name: _, operator: let op):
      return Syntax(op)
    }
  }
}

extension IfConfigError: DiagnosticMessage {
  var message: String { description }

  var diagnosticID: MessageID {
    .init(domain: "SwiftIfConfig", id: "IfConfigError")
  }

  var severity: SwiftDiagnostics.DiagnosticSeverity {
    switch self {
    case .ignoredTrailingComponents: return .warning
    default: return .error
    }
  }

  private struct SimpleFixItMessage: FixItMessage {
    var message: String

    var fixItID: MessageID {
      .init(domain: "SwiftIfConfig", id: "IfConfigFixIt")
    }
  }

  var asDiagnostic: Diagnostic {
    // For the integer literal condition we have a Fix-It.
    if case .integerLiteralCondition(let syntax, let replacement) = self {
      return Diagnostic(
        node: syntax,
        message: self,
        fixIt: .replace(
          message: SimpleFixItMessage(
            message: "replace with Boolean literal '\(replacement)'"
          ),
          oldNode: syntax,
          newNode: BooleanLiteralExprSyntax(
            literal: .keyword(replacement ? .true : .false)
          )
        )
      )
    }

    return Diagnostic(node: syntax, message: self)
  }
}

extension VersionTuple {
  /// Parse a compiler build version of the form "5007.*.1.2.3*", which is
  /// used by an older if configuration form `_compiler_version("...")`.
  /// - Parameters:
  ///   - versionString: The version string for the compiler build version that
  ///   we are parsing.
  ///   - versionSyntax: The syntax node that contains the version string, used
  ///   only for diagnostic purposes.
  fileprivate init(
    parsingCompilerBuildVersion versionString: String,
    _ versionSyntax: ExprSyntax
  ) throws {
    components = []

    // Version value are separated by periods.
    let componentStrings = versionString.split(separator: ".")

    /// Record a component after checking its value.
    func recordComponent(_ value: Int) throws {
      let limit = components.isEmpty ? 9223371 : 999
      if value < 0 || value > limit {
        throw IfConfigError.compilerVersionOutOfRange(value: value, upperLimit: limit, syntax: versionSyntax)
      }

      components.append(value)
    }

    // Parse the components into version values.
    for (index, componentString) in componentStrings.enumerated() {
      // Check ahead of time for empty version components
      if componentString.isEmpty {
        throw IfConfigError.emptyVersionComponent(syntax: versionSyntax)
      }

      // The second component is always "*", and is never used for comparison.
      if index == 1 {
        if componentString != "*" {
          throw IfConfigError.compilerVersionSecondComponentNotWildcard(syntax: versionSyntax)
        }
        try recordComponent(0)
        continue
      }

      // Every other component must be an integer value.
      guard let component = Int(componentString) else {
        throw IfConfigError.invalidVersionOperand(name: "_compiler_version", syntax: versionSyntax)
      }

      try recordComponent(component)
    }

    // Only allowed to specify up to 5 version components.
    if components.count > 5 {
      throw IfConfigError.compilerVersionTooManyComponents(syntax: versionSyntax)
    }

    // In the beginning, '_compiler_version(string-literal)' was designed for a
    // different version scheme where the major was fairly large and the minor
    // was ignored; now we use one where the minor is significant and major and
    // minor match the Swift language version. Specifically, majors 600-1300
    // were used for Swift 1.0-5.5 (based on clang versions), but then we reset
    // the numbering based on Swift versions, so 5.6 had major 5. We assume
    // that majors below 600 use the new scheme and equal/above it use the old
    // scheme.
    //
    // However, we want the string literal variant of '_compiler_version' to
    // maintain source compatibility with old checks; that means checks for new
    // versions have to be written so that old compilers will think they represent
    // newer versions, while new compilers have to interpret old version number
    // strings in a way that will compare correctly to the new versions compiled
    // into them.
    //
    // To achieve this, modern compilers divide the major by 1000 and overwrite
    // the wildcard component with the remainder, effectively shifting the last
    // three digits of the major into the minor, before comparing it to the
    // compiler version:
    //
    //     _compiler_version("5007.*.1.2.3") -> 5.7.1.2.3
    //     _compiler_version("1300.*.1.2.3") -> 1.300.1.2.3 (smaller than 5.6)
    //     _compiler_version( "600.*.1.2.3") -> 0.600.1.2.3 (smaller than 5.6)
    //
    // So if you want to specify a 5.7.z.a.b version, we ask users to either
    // write it as 5007.*.z.a.b, or to use the new 'compiler(>= version)'
    // syntax instead, which does not perform this conversion.
    if !components.isEmpty {
      if components.count > 1 {
        components[1] = components[0] % 1000
      }
      components[0] = components[0] / 1000
    }
  }
}

/// Evaluate the condition of an `#if`.
/// - Parameters:
///   - condition: The condition to evaluate, which we assume has already been
///     folded according to the logical operators table.
///   - configuration: The configuration against which the condition will be
///     evaluated.
///   - diagnosticHandler: Receives any diagnostics that are produced by the
///     evaluation, whether from errors in the source code or produced by the
///     build configuration itself.
/// - Throws: Throws if an error occurs occur during evaluation. The error will
///   also be provided to the diagnostic handler before doing so.
/// - Returns: Whether the condition holds with the given build configuration.
private func evaluateIfConfig(
  condition: ExprSyntax,
  configuration: some BuildConfiguration,
  diagnosticHandler: ((Diagnostic) -> Void)?
) throws -> Bool {
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
    body: () throws -> Bool
  ) throws -> Bool {
    do {
      return try body()
    } catch let error {
      throw recordedError(error, at: node)
    }
  }

  // Boolean literals evaluate as-is
  if let boolLiteral = condition.as(BooleanLiteralExprSyntax.self) {
    return boolLiteral.literalValue
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

    return result
  }

  // Declaration references are for custom compilation flags.
  if let identExpr = condition.as(DeclReferenceExprSyntax.self) {
    // FIXME: Need a real notion of an identifier.
    let ident = identExpr.baseName.text

    // Evaluate the custom condition. If the build configuration cannot answer this query, fail.
    return try checkConfiguration(at: identExpr) {
      try configuration.isCustomConditionSet(name: ident)
    }
  }

  // Logical '!'.
  if let prefixOp = condition.as(PrefixOperatorExprSyntax.self),
    prefixOp.operator.text == "!"
  {
    return try !evaluateIfConfig(
      condition: prefixOp.expression,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )
  }

  // Logical '&&' and '||'.
  if let binOp = condition.as(InfixOperatorExprSyntax.self),
    let op = binOp.operator.as(BinaryOperatorExprSyntax.self),
    (op.operator.text == "&&" || op.operator.text == "||")
  {
    // Evaluate the left-hand side.
    let lhsResult = try evaluateIfConfig(
      condition: binOp.leftOperand,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )

    // Short-circuit evaluation if we know the answer.
    switch (lhsResult, op.operator.text) {
    case (true, "||"): return true
    case (false, "&&"): return false
    default: break
    }

    // Evaluate the right-hand side and use that result.
    return try evaluateIfConfig(
      condition: binOp.rightOperand,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )
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
    func doSingleIdentifierArgumentCheck(_ body: (String) throws -> Bool, role: String) throws -> Bool {
      // Ensure that we have a single argument that is a simple identifier.
      guard let argExpr = call.arguments.singleUnlabeledExpression,
        let arg = argExpr.simpleIdentifierExpr
      else {
        throw recordedError(
          .requiresUnlabeledArgument(name: fnName, role: role, syntax: ExprSyntax(call))
        )
      }

      return try checkConfiguration(at: argExpr) {
        try body(arg)
      }
    }

    /// Perform a check for a version constraint as used in the "swift" or "compiler" version checks.
    func doVersionComparisonCheck(_ actualVersion: VersionTuple) throws -> Bool {
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
        return actualVersion >= version
      case "<":
        return actualVersion < version
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

      return configuration.endianness == expectedEndianness

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

      return configuration.targetPointerBitWidth == expectedPointerBitWidth

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

      return configuration.compilerVersion >= expectedVersion

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
        try configuration.canImport(
          importPath: importPath.map { String($0) },
          version: version
        )
      }
    }
  }

  throw recordedError(.unknownExpression(condition))
}

extension IfConfigState {
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

    let result = try evaluateIfConfig(
      condition: foldedCondition,
      configuration: configuration,
      diagnosticHandler: diagnosticHandler
    )
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
  public func activeClause(
    in configuration: some BuildConfiguration,
    diagnosticHandler: ((Diagnostic) -> Void)? = nil
  ) throws -> IfConfigClauseSyntax? {
    for clause in clauses {
      // If there is no condition, we have reached an unconditional clause. Return it.
      guard let condition = clause.condition else {
        return clause
      }

      // If this condition evaluates true, return this clause.
      if try evaluateIfConfig(
        condition: condition,
        configuration: configuration,
        diagnosticHandler: diagnosticHandler
      ) {
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
  /// a call to `isActive` on the syntax node for the function `g` would return `true` when the
  /// configuration options `DEBUG` and `B` are provided, but `A` is not.
  public func isActive(in configuration: some BuildConfiguration) throws -> Bool {
    var currentNode: Syntax = Syntax(self)
    while let parent = currentNode.parent {
      // If the parent is an `#if` configuration, check whether our current
      // clause is active. If not, we're in an inactive region.
      if let ifConfigClause = currentNode.as(IfConfigClauseSyntax.self),
        let ifConfigDecl = ifConfigClause.parent?.as(IfConfigDeclSyntax.self)
      {
        if try ifConfigDecl.activeClause(in: configuration) != ifConfigClause {
          return false
        }
      }

      currentNode = parent
    }

    // No more enclosing nodes; this code is active.
    return true
  }
}
