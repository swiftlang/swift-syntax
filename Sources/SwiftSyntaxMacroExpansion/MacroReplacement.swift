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
import SwiftSyntax
import SwiftSyntaxBuilder

enum MacroExpanderError: DiagnosticMessage {
  case undefined
  case definitionNotMacroExpansion
  case nonParameterReference(TokenSyntax)
  case nonLiteralOrParameter(ExprSyntax)

  var message: String {
    switch self {
    case .undefined:
      return "macro expansion requires a definition"

    case .definitionNotMacroExpansion:
      return "macro must itself be defined by a macro expansion expression (starting with '#')"

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
  case expansion(MacroExpansionExprSyntax, replacements: [Replacement])
}

extension MacroDefinition {
  /// A replacement that occurs as part of an expanded macro definition.
  public struct Replacement {
    /// A reference to a parameter as it occurs in the macro expansion expression.
    public let reference: DeclReferenceExprSyntax

    /// The index of the parameter in the defining macro.
    public let parameterIndex: Int
  }
}

fileprivate class ParameterReplacementVisitor: SyntaxAnyVisitor {
  let macro: MacroDeclSyntax
  var replacements: [MacroDefinition.Replacement] = []
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

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if let expr = node.as(ExprSyntax.self) {
      // We have an expression that is not one of the allowed forms, so
      // diagnose it.
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

    return .expansion(definition, replacements: visitor.replacements)
  }
}

/// Syntax rewrite that performs macro expansion by textually replacing
/// uses of macro parameters with their corresponding arguments.
private final class MacroExpansionRewriter: SyntaxRewriter {
  let parameterReplacements: [DeclReferenceExprSyntax: Int]
  let arguments: [ExprSyntax]

  init(parameterReplacements: [DeclReferenceExprSyntax: Int], arguments: [ExprSyntax]) {
    self.parameterReplacements = parameterReplacements
    self.arguments = arguments
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: DeclReferenceExprSyntax) -> ExprSyntax {
    guard let parameterIndex = parameterReplacements[node] else {
      return super.visit(node)
    }

    // Swap in the argument for this parameter
    return arguments[parameterIndex].trimmed
  }
}

extension MacroDeclSyntax {
  /// Expand the definition of this macro when provided with the given
  /// argument list.
  private func expand(
    argumentList: LabeledExprListSyntax?,
    definition: MacroExpansionExprSyntax,
    replacements: [MacroDefinition.Replacement]
  ) -> ExprSyntax {
    // FIXME: Do real call-argument matching between the argument list and the
    // macro parameter list, porting over from the compiler.
    let arguments: [ExprSyntax] =
      argumentList?.map { element in
        element.expression
      } ?? []

    return MacroExpansionRewriter(
      parameterReplacements: Dictionary(
        uniqueKeysWithValues: replacements.map { replacement in
          (replacement.reference, replacement.parameterIndex)
        }
      ),
      arguments: arguments
    ).visit(definition)
  }

  /// Given a freestanding macro expansion syntax node that references this
  /// macro declaration, expand the macro by substituting the arguments from
  /// the macro expansion into the parameters that are used in the definition.
  public func expand(
    _ node: some FreestandingMacroExpansionSyntax,
    definition: MacroExpansionExprSyntax,
    replacements: [MacroDefinition.Replacement]
  ) -> ExprSyntax {
    return expand(
      argumentList: node.arguments,
      definition: definition,
      replacements: replacements
    )
  }

  /// Given an attached macro expansion syntax node that references this
  /// macro declaration, expand the macro by substituting the arguments from
  /// the expansion into the parameters that are used in the definition.
  public func expand(
    _ node: AttributeSyntax,
    definition: MacroExpansionExprSyntax,
    replacements: [MacroDefinition.Replacement]
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
      definition: definition,
      replacements: replacements
    )
  }
}
