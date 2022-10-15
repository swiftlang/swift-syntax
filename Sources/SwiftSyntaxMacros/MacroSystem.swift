import SwiftDiagnostics
import SwiftSyntax

/// Describes the kinds of errors that can occur within a macro system.
public enum MacroSystemError: Error {
  /// Indicates that a macro with the given name has already been defined.
  case alreadyDefined(new: Macro.Type, existing: Macro.Type)

  /// Indicates that an unknown macro was encountered during expansion.
  case unknownMacro(name: String, node: Syntax)

  /// Indicates that a macro evaluated as an expression by the given node
  /// is not an expression macro.
  case requiresExpressionMacro(macro: Macro.Type, node: Syntax)

  /// Indicates that a macro evaluated as a code item by the given node
  /// is not suitable for code items.
  case requiresCodeItemMacro(macro: Macro.Type, node: Syntax)

  /// Indicates that a macro produced diagnostics during evaluation. The
  /// diagnostics might not specifically included errors, but will be reported
  /// nonetheless.
  case evaluationDiagnostics(node: Syntax, diagnostics: [Diagnostic])
}

/// A system of known macros that can be expanded syntactically
public struct MacroSystem {
  var macros: [String : Macro.Type] = [:]

  /// Create an empty macro system.
  public init() { }

  /// Add a macro to the system.
  ///
  /// Throws an error if there is already a macro with this name.
  public mutating func add(_ macro: Macro.Type) throws {
    if let knownMacro = macros[macro.name] {
      throw MacroSystemError.alreadyDefined(new: macro, existing: knownMacro)
    }

    macros[macro.name] = macro
  }
}

extension MacroExpansionDeclSyntax {
  /// Macro expansion declarations are parsed in some positions where an
  /// expression is also warranted, so
  func asMacroExpansionExpr() -> MacroExpansionExprSyntax {
    MacroExpansionExprSyntax(
      unexpectedBeforePoundToken, poundToken: poundToken,
      unexpectedBetweenPoundTokenAndMacro, macro: macro,
      unexpectedBetweenMacroAndLeftParen, leftParen: leftParen,
      unexpectedBetweenLeftParenAndArgumentList, argumentList: argumentList,
      unexpectedBetweenArgumentListAndRightParen, rightParen: rightParen,
      unexpectedBetweenRightParenAndTrailingClosure,
      trailingClosure: trailingClosure,
      unexpectedBetweenTrailingClosureAndAdditionalTrailingClosures,
      additionalTrailingClosures: additionalTrailingClosures,
      unexpectedAfterAdditionalTrailingClosures
    )
  }
}

/// Syntax rewriter that evaluates any macros encountered along the way.
class MacroApplication : SyntaxRewriter {
  let macroSystem: MacroSystem
  let context: MacroEvaluationContext
  let errorHandler: (MacroSystemError) -> Void

  init(
    macroSystem: MacroSystem,
    context: MacroEvaluationContext,
    errorHandler: @escaping (MacroSystemError) -> Void
  ) {
    self.macroSystem = macroSystem
    self.context = context
    self.errorHandler = errorHandler
  }

  private func evaluateExprMacro(exprMacro: ExpressionMacro.Type, node: MacroExpansionExprSyntax) -> ExprSyntax {
    // Handle the rewrite.
    let result = exprMacro.apply(node, in: context)

    // Report diagnostics, if there were any.
    if !result.diagnostics.isEmpty {
      errorHandler(
        .evaluationDiagnostics(
          node: Syntax(node), diagnostics: result.diagnostics
        )
      )
    }

    // TODO: Do we want to recurse here?
    return result.rewritten
  }

  override func visit(_ node: MacroExpansionExprSyntax) -> ExprSyntax {
    let name = node.macro.text
    guard let macro = macroSystem.macros[name] else {
      errorHandler(.unknownMacro(name: name, node: Syntax(node)))
      return ExprSyntax(node)
    }

    guard let exprMacro = macro as? ExpressionMacro.Type else {
      errorHandler(.requiresExpressionMacro(macro: macro, node: Syntax(node)))
      return ExprSyntax(node)
    }

    return evaluateExprMacro(exprMacro: exprMacro, node: node)
  }

  override func visit(_ node: CodeBlockItemListSyntax) -> Syntax {
    var newItems: [CodeBlockItemSyntax] = []
    for item in node {
      // Handle macro expansion declarations.
      if let macroEvaluationDecl = item.item.as(MacroExpansionDeclSyntax.self) {
        let name = macroEvaluationDecl.macro.text
        guard let macro = macroSystem.macros[name] else {
          errorHandler(.unknownMacro(name: name, node: Syntax(node)))
          newItems.append(item)
          continue
        }

        // TODO: declaration and statement macros can be applied here

        if let exprMacro = macro as? ExpressionMacro.Type {
          let result = evaluateExprMacro(
            exprMacro: exprMacro,
            node: macroEvaluationDecl.asMacroExpansionExpr()
          )
          newItems.append(item.withItem(Syntax(result)))
          continue
        }

        errorHandler(.requiresCodeItemMacro(macro: macro, node: Syntax(item)))
        continue
      }

      // Recurse on the child node.
      newItems.append(item.withItem(visit(item.item)))
    }

    return Syntax(CodeBlockItemListSyntax(newItems))
  }
}

extension MacroSystem {
  /// Expand all macros encountered within the given syntax tree.
  ///
  /// - Parameter node: The syntax node in which macros will be evaluated.
  /// - Parameter context: The context in which macros are evaluated.
  /// - Parameter errorHandler: Errors encountered during traversal will
  ///   be passed to the error handler.
  /// - Returns: the syntax tree with all macros evaluated.
  public func evaluateMacros<Node: SyntaxProtocol>(
    node: Node,
    in context: MacroEvaluationContext,
    errorHandler: (MacroSystemError) -> Void
  ) -> Syntax {
    return withoutActuallyEscaping(errorHandler) { errorHandler in
      let applier = MacroApplication(
        macroSystem: self, context: context, errorHandler: errorHandler
      )
      return applier.visit(Syntax(node))
    }
  }
}
