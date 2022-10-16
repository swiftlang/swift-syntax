import SwiftSyntax

/// Describes a macro that is explicitly expanded as an expression.
public protocol ExpressionMacro: Macro {
  /// Evaluate a macro described by the given macro expansion expression
  /// within the given context to produce a replacement expression.
  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax>
}
