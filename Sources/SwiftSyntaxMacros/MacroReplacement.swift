import SwiftDiagnostics
import SwiftSyntax

/// The replacement of a parameter.
@_spi(Testing)
public struct ParameterReplacement {
  /// A reference to a parameter as it occurs in the macro expansion expression.
  public let reference: IdentifierExprSyntax

  /// The index of the parameter
  public let parameterIndex: Int
}

extension FunctionParameterSyntax {
  /// Retrieve the name of the parameter as it is used in source.
  ///
  /// Example:
  ///
  ///     func f(a: Int, _ b: Int, c see: Int) { ... }
  ///
  /// The parameter names for these three parameters are `a`, `b`, and `see`,
  /// respectively.
  var parameterName: TokenSyntax? {
    // If there were two names, the second is the parameter name.
    if let secondName = secondName {
      if secondName.text == "_" {
        return nil
      }

      return secondName
    }

    if let firstName = firstName {
      if firstName.text == "_" {
        return nil
      }

      return firstName
    }

    return nil
  }
}

enum MacroExpanderError: DiagnosticMessage {
  case undefined
  case nonParameterReference(TokenSyntax)
  case nonLiteralOrParameter(ExprSyntax)

  var message: String {
    switch self {
    case .undefined:
      return "macro expansion requires a definition"

    case .nonParameterReference(let name):
      return "reference to value '\(name.text)' that is not a macro parameter in expansion"

    case .nonLiteralOrParameter:
      return "only literals and macro parameters are permitted in expansion"
    }
  }

  var diagnosticID: MessageID {
    .init(domain: "SwiftMacros", id: "\(self)")
  }

  var severity: DiagnosticSeverity {
    .error
  }
}

fileprivate class ParameterReplacementVisitor: SyntaxAnyVisitor {
  let macro: MacroDeclSyntax
  var replacements: [ParameterReplacement] = []
  var diagnostics: [Diagnostic] = []

  init(macro: MacroDeclSyntax) {
    self.macro = macro
    super.init(viewMode: .fixedUp)
  }

  // Integer literals
  override func visit(_ node: IntegerLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Floating point literals
  override func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // nil literals
  override func visit(_ node: NilLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // String literals
  override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Array literals
  override func visit(_ node: ArrayExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Dictionary literals
  override func visit(_ node: DictionaryExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Tuple literals
  override func visit(_ node: TupleExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // Macro uses.
  override func visit(_ node: MacroExpansionExprSyntax) -> SyntaxVisitorContinueKind {
    .visitChildren
  }

  // References to declarations. Only accept those that refer to a parameter
  // of a macro.
  override func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    let identifier = node.identifier

    // FIXME: This will go away.
    guard case let .functionLike(signature) = macro.signature else {
      return .visitChildren
    }

    let matchedParameter = signature.input.parameterList.enumerated().first { (index, parameter) in
      if identifier.text == "_" {
        return false
      }

      guard let parameterName = parameter.parameterName else {
        return false
      }

      return identifier.text == parameterName.text
    }

    guard let (parameterIndex, _) = matchedParameter else {
      // We have a reference to something that isn't a parameter of the macro.
      diagnostics.append(
        Diagnostic(
          node: Syntax(identifier),
          message: MacroExpanderError.nonParameterReference(identifier)
        )
      )

      return .visitChildren
    }

    replacements.append(.init(reference: node, parameterIndex: parameterIndex))
    return .visitChildren
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if let expr = node.as(ExprSyntax.self) {
      // We have an expression that is not one of the allowed forms,
      diagnostics.append(
        Diagnostic(
          node: node,
          message: MacroExpanderError.nonLiteralOrParameter(expr)
        )
      )

      return .skipChildren
    }

    return .visitChildren
  }

}

extension MacroDeclSyntax {
  /// Compute the sequence of parameter replacements required when expanding
  /// the definition of a non-external macro.
  @_spi(Testing)
  public func expansionParameterReplacements() -> (replacements: [ParameterReplacement], diagnostics: [Diagnostic]) {
    // Cannot compute replacements for an undefined macro.
    guard let definition = definition?.value else {
      let undefinedDiag = Diagnostic(
        node: Syntax(self),
        message: MacroExpanderError.undefined
      )

      return (replacements: [], diagnostics: [undefinedDiag])
    }

    let visitor = ParameterReplacementVisitor(macro: self)
    visitor.walk(definition)

    return (replacements: visitor.replacements, diagnostics: visitor.diagnostics)
  }
}

/// Syntax rewrite that performs macro expansion by textually replacing
/// uses of macro parameters with their corresponding arguments.
private final class MacroExpansionRewriter: SyntaxRewriter {
  let parameterReplacements: [IdentifierExprSyntax: Int]
  let arguments: [ExprSyntax]

  init(parameterReplacements: [IdentifierExprSyntax: Int], arguments: [ExprSyntax]) {
    self.parameterReplacements = parameterReplacements
    self.arguments = arguments
  }

  override func visit(_ node: IdentifierExprSyntax) -> ExprSyntax {
    guard let parameterIndex = parameterReplacements[node] else {
      return super.visit(node)
    }

    // Swap in the argument for this parameter
    return arguments[parameterIndex].trimmed
  }
}

extension MacroDeclSyntax {
  /// Given a freestanding macro expansion syntax node that references this
  /// macro declaration, expand the macro by substituting the arguments from
  /// the macro expansion into the parameters that are used in the definition.
  ///
  /// If there are any errors, the function will throw with all diagnostics
  /// placed in a `DiagnosticsError`.
  public func expandDefinition(
    _ node: some FreestandingMacroExpansionSyntax
  ) throws -> ExprSyntax {
    let (replacements, diagnostics) = expansionParameterReplacements()

    // If there were any diagnostics, don't allow replacement.
    if !diagnostics.isEmpty {
      throw DiagnosticsError(diagnostics: diagnostics)
    }

    // FIXME: Do real call-argument matching between the argument list and the
    // macro parameter list, porting over from the compiler.
    let arguments: [ExprSyntax] = node.argumentList.map { element in
      element.expression
    }

    return MacroExpansionRewriter(
      parameterReplacements: Dictionary(
        uniqueKeysWithValues: replacements.map { replacement in
          (replacement.reference, replacement.parameterIndex)
        }
      ),
      arguments: arguments
    ).visit(definition!.value)
  }
}
