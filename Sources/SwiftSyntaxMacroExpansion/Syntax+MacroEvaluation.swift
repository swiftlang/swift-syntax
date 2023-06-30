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
import SwiftSyntaxMacros

extension SyntaxProtocol {
  /// Detach the current node and inform the macro expansion context,
  /// if it needs to know.
  fileprivate func detach(in context: MacroExpansionContext) -> Self {
    if let basicContext = context as? BasicMacroExpansionContext {
      return basicContext.detach(self)
    }

    return self.detach()
  }
}

extension MacroExpansionExprSyntax {
  /// Evaluate the given macro for this syntax node, producing the expanded
  /// result and (possibly) some diagnostics.
  func evaluateMacro(
    _ macro: Macro.Type,
    in context: some MacroExpansionContext
  ) -> ExprSyntax {
    guard let exprMacro = macro as? ExpressionMacro.Type else {
      return ExprSyntax(self)
    }

    // Handle the rewrite.
    do {
      return try exprMacro.expansion(of: detach(in: context), in: context)
    } catch {
      context.addDiagnostics(from: error, node: self)
      return ExprSyntax(self)
    }
  }
}

extension MacroExpansionDeclSyntax {
  /// Evaluate the given macro for this syntax node, producing the expanded
  /// result and (possibly) some diagnostics.
  func evaluateMacro(
    _ macro: Macro.Type,
    in context: some MacroExpansionContext
  ) -> Syntax {
    // TODO: declaration/statement macros

    return Syntax(self)
  }
}

extension Syntax {
  /// Determine the name of the macro that is evaluated by this syntax node,
  /// if indeed it is a macro evaluation. For example, "#stringify(x)" has the
  /// name "stringify".
  var evaluatedMacroName: String? {
    switch self.as(SyntaxEnum.self) {
    case .macroExpansionDecl(let expansion):
      return expansion.macro.text

    case .macroExpansionExpr(let expansion):
      return expansion.macro.text

    default:
      return nil
    }
  }

  /// Evaluate the given macro and return the resulting syntax tree along with
  /// any errors along the way.
  ///
  /// This operation only makes sense when `evaluatedMacroName` produces a
  /// non-nil value, indicating that this syntax node is a macro evaluation of
  /// some kind.
  func evaluateMacro(
    with macroSystem: MacroSystem,
    context: some MacroExpansionContext
  ) -> Syntax {
    // If this isn't a macro evaluation node, do nothing.
    guard let macroName = evaluatedMacroName else {
      return self
    }

    // Look for a macro with the given name. Otherwise, fail.
    guard let macro = macroSystem.macros[macroName] else {
      return self
    }

    switch self.as(SyntaxEnum.self) {
    case .macroExpansionDecl(let expansion):
      return expansion.evaluateMacro(macro, in: context)

    case .macroExpansionExpr(let expansion):
      return Syntax(
        expansion.evaluateMacro(macro, in: context)
      )

    default:
      fatalError("switch is out-of-sync with evaluatedMacroName")
    }
  }
}
