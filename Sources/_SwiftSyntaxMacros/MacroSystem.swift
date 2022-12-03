//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

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
  /// diagnostics might not specifically include errors, but will be reported
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
  public mutating func add(_ macro: Macro.Type, name: String) throws {
    if let knownMacro = macros[name] {
      throw MacroSystemError.alreadyDefined(new: macro, existing: knownMacro)
    }

    macros[name] = macro
  }

  /// Look for a macro with the given name.
  public func lookup(_ macroName: String) -> Macro.Type? {
    return macros[macroName]
  }
}

/// Syntax rewriter that evaluates any macros encountered along the way.
class MacroApplication : SyntaxRewriter {
  let macroSystem: MacroSystem
  var context: MacroExpansionContext

  init(
    macroSystem: MacroSystem,
    context: MacroExpansionContext
  ) {
    self.macroSystem = macroSystem
    self.context = context
  }

  override func visitAny(_ node: Syntax) -> Syntax? {
    guard node.evaluatedMacroName != nil else {
      return nil
    }

    return node.evaluateMacro(
      with: macroSystem, context: &context
    )
  }

  override func visit(_ node: CodeBlockItemListSyntax) -> CodeBlockItemListSyntax {
    var newItems: [CodeBlockItemSyntax] = []
    for item in node {
      // Recurse on the child node.
      let newItem = visit(item.item)

      // Flatten if we get code block item list syntax back.
      if let itemList = newItem.as(CodeBlockItemListSyntax.self) {
        newItems.append(contentsOf: itemList)
      } else {
        newItems.append(item.withItem(newItem))
      }
    }

    return CodeBlockItemListSyntax(newItems)
  }
}

extension MacroSystem {
  /// Expand all macros encountered within the given syntax tree.
  ///
  /// - Parameter node: The syntax node in which macros will be evaluated.
  /// - Parameter context: The context in which macros are evaluated.
  /// - Returns: the syntax tree with all macros evaluated.
  public func evaluateMacros<Node: SyntaxProtocol>(
    node: Node,
    in context: inout MacroExpansionContext
  ) -> Syntax {
    let applier = MacroApplication(
      macroSystem: self, context: context
    )
    return applier.visit(Syntax(node))
  }
}
