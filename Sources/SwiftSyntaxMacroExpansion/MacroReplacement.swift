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

#if swift(>=6)
import SwiftDiagnostics
public import SwiftSyntax
import SwiftSyntaxBuilder
#else
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
#endif

enum MacroExpanderError: DiagnosticMessage {
  case undefined
  case definitionNotMacroExpansion
  case nonParameterReference(TokenSyntax)
  case nonTypeReference(TokenSyntax)
  case nonLiteralOrParameter

  var message: String {
    switch self {
    case .undefined:
      return "macro expansion requires a definition"

    case .definitionNotMacroExpansion:
      return "macro must itself be defined by a macro expansion expression (starting with '#')"

    case .nonParameterReference(let name):
      return "reference to value '\(name.text)' that is not a macro parameter in expansion"

    case .nonTypeReference(let name):
      return "reference to type '\(name)' that is not a macro type parameter in expansion"

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

/// Provide the definition of a macro
public enum MacroDefinition {
  /// An externally-defined macro, known by its type name and the module in
  /// which that type resides, which uses the deprecated syntax `A.B`.
  case deprecatedExternal(node: Syntax, module: String, type: String)

  /// A macro that is defined by expansion of another macro.
  ///
  /// The definition has the macro expansion expression itself, along with
  /// sequence of replacements for subtrees that refer to parameters of the
  /// defining macro. These subtrees will need to be replaced with the text of
  /// the corresponding argument to the macro, which can be accomplished with
  /// `MacroDeclSyntax.expandDefinition`.
  case expansion(MacroExpansionExprSyntax, replacements: [Replacement], genericReplacements: [GenericArgumentReplacement])
}

extension MacroDefinition {
  /// Best effort compatibility shim, the case has gained additional parameters.
  @available(*, deprecated, message: "Use the expansion case with three associated values instead")
  public func expansion(_ node: MacroExpansionExprSyntax, replacements: [Replacement]) -> Self {
    .expansion(node, replacements: replacements, genericReplacements: [])
  }
}

extension MacroDefinition {
  /// A replacement that occurs as part of an expanded macro definition.
  public struct Replacement {
    /// A reference to a parameter as it occurs in the macro expansion expression.
    public let reference: DeclReferenceExprSyntax

    /// The index of the parameter in the defining macro.
    public let parameterIndex: Int
  }

  /// A replacement that occurs as part of an expanded macro definition.
  public struct GenericArgumentReplacement {
    /// A reference to a parameter as it occurs in the macro expansion expression.
    public let reference: GenericArgumentSyntax

    /// The index of the parameter in the defining macro.
    public let parameterIndex: Int
  }
}

fileprivate class ParameterReplacementVisitor: OnlyLiteralExprChecker {
  let macro: MacroDeclSyntax
  var replacements: [MacroDefinition.Replacement] = []
  var genericReplacements: [MacroDefinition.GenericArgumentReplacement] = []

  init(macro: MacroDeclSyntax) {
    self.macro = macro
    super.init()
  }

  // References to declarations. Only accept those that refer to a parameter
  // of a macro.
  override func visit(_ node: DeclReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    let baseName = node.baseName
    let signature = macro.signature

    let matchedParameter = signature.parameterClause.parameters.enumerated().first { (index, parameter) in
      if baseName.text == "_" {
        return false
      }

      guard let parameterName = parameter.parameterName else {
        return false
      }

      return baseName.text == parameterName.text
    }

    guard let (parameterIndex, _) = matchedParameter else {
      // We have a reference to something that isn't a parameter of the macro.
      diagnostics.append(
        Diagnostic(
          node: Syntax(baseName),
          message: MacroExpanderError.nonParameterReference(baseName)
        )
      )

      return .visitChildren
    }

    replacements.append(.init(reference: node, parameterIndex: parameterIndex))
    return .visitChildren
  }

  override func visit(_ node: GenericArgumentClauseSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  override func visit(_ node: GenericArgumentListSyntax) -> SyntaxVisitorContinueKind {
    return .visitChildren
  }

  override func visit(_ node: GenericArgumentSyntax) -> SyntaxVisitorContinueKind {
    guard let baseName = node.argument.as(IdentifierTypeSyntax.self)?.name else {
      return .skipChildren
    }

    guard let genericParameterClause = macro.genericParameterClause else {
      return .skipChildren
    }

    let matchedParameter = genericParameterClause.parameters.enumerated().first { (index, parameter) in
      return parameter.name.text == baseName.text
    }

    guard let (parameterIndex, _) = matchedParameter else {
      // We have a reference to something that isn't a parameter of the macro.
      diagnostics.append(
        Diagnostic(
          node: Syntax(baseName),
          message: MacroExpanderError.nonTypeReference(baseName)
        )
      )

      return .visitChildren
    }

    genericReplacements.append(.init(reference: node, parameterIndex: parameterIndex))

    return .visitChildren
  }

  override func diagnoseNonLiteral(_ node: some SyntaxProtocol) -> SyntaxVisitorContinueKind {
    diagnostics.append(
      Diagnostic(
        node: node,
        message: MacroExpanderError.nonLiteralOrParameter
      )
    )

    return .skipChildren
  }
}

extension MacroDeclSyntax {
  /// Check the definition of the given macro.
  ///
  /// Macros are defined by an expression, which must itself be a macro
  /// expansion. Check the definition and produce a semantic representation of
  /// it or one of the "builtin"
  ///
  /// Compute the sequence of parameter replacements required when expanding
  /// the definition of a non-external macro.
  ///
  /// If there are an errors that prevent expansion, the diagnostics will be
  /// wrapped into an error that prevents expansion, that error is thrown.
  public func checkDefinition() throws -> MacroDefinition {
    // Cannot compute replacements for an undefined macro.
    guard let originalDefinition = definition?.value else {
      let undefinedDiag = Diagnostic(
        node: Syntax(self),
        message: MacroExpanderError.undefined
      )

      throw DiagnosticsError(diagnostics: [undefinedDiag])
    }

    /// Recognize the deprecated syntax A.B. Clients will need to
    /// handle this themselves.
    if let memberAccess = originalDefinition.as(MemberAccessExprSyntax.self),
      let base = memberAccess.base,
      let baseName = base.as(DeclReferenceExprSyntax.self)?.baseName
    {
      let memberName = memberAccess.declName.baseName
      return .deprecatedExternal(
        node: Syntax(memberAccess),
        module: baseName.trimmedDescription,
        type: memberName.trimmedDescription
      )
    }

    // Make sure we have a macro expansion expression.
    guard let definition = originalDefinition.as(MacroExpansionExprSyntax.self) else {
      let badDefinitionDiag =
        Diagnostic(
          node: Syntax(originalDefinition),
          message: MacroExpanderError.definitionNotMacroExpansion
        )

      throw DiagnosticsError(diagnostics: [badDefinitionDiag])
    }

    let visitor = ParameterReplacementVisitor(macro: self)
    visitor.walk(definition)

    if !visitor.diagnostics.isEmpty {
      throw DiagnosticsError(diagnostics: visitor.diagnostics)
    }

    return .expansion(definition, replacements: visitor.replacements, genericReplacements: visitor.genericReplacements)
  }
}

/// Syntax rewrite that performs macro expansion by textually replacing
/// uses of macro parameters with their corresponding arguments.
private final class MacroExpansionRewriter: SyntaxRewriter {
  let parameterReplacements: [DeclReferenceExprSyntax: Int]
  let arguments: [ExprSyntax]
  let genericParameterReplacements: [GenericArgumentSyntax: Int]
  let genericArguments: [TypeSyntax]

  init(
    parameterReplacements: [DeclReferenceExprSyntax: Int],
    arguments: [ExprSyntax],
    genericReplacements: [GenericArgumentSyntax: Int],
    genericArguments: [TypeSyntax]
  ) {
    self.parameterReplacements = parameterReplacements
    self.arguments = arguments
    self.genericParameterReplacements = genericReplacements
    self.genericArguments = genericArguments
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: DeclReferenceExprSyntax) -> ExprSyntax {
    guard let parameterIndex = parameterReplacements[node] else {
      return super.visit(node)
    }

    // Swap in the argument for this parameter
    return arguments[parameterIndex].trimmed
  }

  override func visit(_ node: GenericArgumentSyntax) -> GenericArgumentSyntax {
    guard let parameterIndex = genericParameterReplacements[node] else {
      return super.visit(node)
    }

    guard parameterIndex < genericArguments.count else {
      return super.visit(node)
    }

    // Swap in the argument for type parameter
    var node = node
    node.argument = genericArguments[parameterIndex].trimmed
    return node
  }
}

extension MacroDeclSyntax {
  /// Expand the definition of this macro when provided with the given
  /// argument list.
  private func expand(
    argumentList: LabeledExprListSyntax?,
    genericArgumentList: GenericArgumentClauseSyntax?,
    definition: MacroExpansionExprSyntax,
    replacements: [MacroDefinition.Replacement],
    genericReplacements: [MacroDefinition.GenericArgumentReplacement] = []
  ) -> ExprSyntax {
    // FIXME: Do real call-argument matching between the argument list and the
    // macro parameter list, porting over from the compiler.
    let parameterReplacements = Dictionary(
      replacements.map { replacement in
        (replacement.reference, replacement.parameterIndex)
      },
      uniquingKeysWith: { l, r in l }
    )
    let arguments: [ExprSyntax] =
      argumentList?.map { element in
        element.expression
      } ?? []

    let genericReplacements = Dictionary(
      genericReplacements.map { replacement in
        (replacement.reference, replacement.parameterIndex)
      },
      uniquingKeysWith: { l, r in l }
    )
    let genericArguments: [TypeSyntax] =
      genericArgumentList?.arguments.map { $0.argument } ?? []

    let rewriter = MacroExpansionRewriter(
      parameterReplacements: parameterReplacements,
      arguments: arguments,
      genericReplacements: genericReplacements,
      genericArguments: genericArguments
    )
    return rewriter.visit(definition)
  }

  /// Given a freestanding macro expansion syntax node that references this
  /// macro declaration, expand the macro by substituting the arguments from
  /// the macro expansion into the parameters that are used in the definition.
  public func expand(
    _ node: some FreestandingMacroExpansionSyntax,
    definition: MacroExpansionExprSyntax,
    replacements: [MacroDefinition.Replacement],
    genericReplacements: [MacroDefinition.GenericArgumentReplacement] = []
  ) -> ExprSyntax {
    return expand(
      argumentList: node.arguments,
      genericArgumentList: node.genericArgumentClause,
      definition: definition,
      replacements: replacements,
      genericReplacements: genericReplacements
    )
  }

  /// Given an attached macro expansion syntax node that references this
  /// macro declaration, expand the macro by substituting the arguments from
  /// the expansion into the parameters that are used in the definition.
  public func expand(
    _ node: AttributeSyntax,
    definition: MacroExpansionExprSyntax,
    replacements: [MacroDefinition.Replacement],
    genericReplacements: [MacroDefinition.GenericArgumentReplacement] = []
  ) -> ExprSyntax {
    // Dig out the argument list.
    let argumentList: LabeledExprListSyntax?
    if case let .argumentList(argList) = node.arguments {
      argumentList = argList
    } else {
      argumentList = nil
    }

    return expand(
      argumentList: argumentList,
      genericArgumentList: .init(arguments: []),
      definition: definition,
      replacements: replacements,
      genericReplacements: genericReplacements
    )
  }
}
