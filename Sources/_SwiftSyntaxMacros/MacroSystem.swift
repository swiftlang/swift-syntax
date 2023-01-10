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
enum MacroSystemError: Error {
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
struct MacroSystem {
  var macros: [String: Macro.Type] = [:]

  /// Create an empty macro system.
  init() {}

  /// Add a macro to the system.
  ///
  /// Throws an error if there is already a macro with this name.
  mutating func add(_ macro: Macro.Type, name: String) throws {
    if let knownMacro = macros[name] {
      throw MacroSystemError.alreadyDefined(new: macro, existing: knownMacro)
    }

    macros[name] = macro
  }

  /// Look for a macro with the given name.
  func lookup(_ macroName: String) -> Macro.Type? {
    return macros[macroName]
  }
}

/// Syntax rewriter that evaluates any macros encountered along the way.
class MacroApplication: SyntaxRewriter {
  let macroSystem: MacroSystem
  var context: MacroExpansionContext
  var skipNodes: Set<Syntax> = []

  init(
    macroSystem: MacroSystem,
    context: MacroExpansionContext
  ) {
    self.macroSystem = macroSystem
    self.context = context
  }

  override func visitAny(_ node: Syntax) -> Syntax? {
    if skipNodes.contains(node) {
      return nil
    }

    if node.evaluatedMacroName != nil {
      return node.evaluateMacro(
        with: macroSystem,
        context: &context
      )
    }

    if let declSyntax = node.as(DeclSyntax.self),
      let attributedNode = node.asProtocol(AttributedSyntax.self),
      let attributes = attributedNode.attributes
    {
      // Visit the node.
      skipNodes.insert(node)
      let visitedNode = self.visit(declSyntax).asProtocol(AttributedSyntax.self)!
      skipNodes.remove(node)

      // Remove any attached attributes.
      let newAttributes = attributes.filter {
        guard case let .customAttribute(customAttr) = $0 else {
          return true
        }

        guard let attributeName = customAttr.attributeName.as(SimpleTypeIdentifierSyntax.self)?.name.text,
          let macro = macroSystem.macros[attributeName]
        else {
          return true
        }

        return !(macro is PeerDeclarationMacro.Type)
      }

      if newAttributes.isEmpty {
        return Syntax(fromProtocol: visitedNode.withAttributes(nil))
      }

      return Syntax(fromProtocol: visitedNode.withAttributes(AttributeListSyntax(newAttributes)))
    }

    return nil
  }

  override func visit(_ node: CodeBlockItemListSyntax) -> CodeBlockItemListSyntax {
    var newItems: [CodeBlockItemSyntax] = []
    for item in node {
      // Expand declaration macros that were parsed as macro expansion
      // expressions in this context.
      if case let .expr(exprItem) = item.item,
        let exprExpansion = exprItem.as(MacroExpansionExprSyntax.self),
        let macro = macroSystem.macros[exprExpansion.macro.text],
        let freestandingMacro = macro as? FreestandingDeclarationMacro.Type
      {
        do {
          let expandedDecls = try freestandingMacro.expansion(
            of: exprExpansion.asMacroExpansionDecl(),
            in: &context
          )

          newItems.append(
            contentsOf: expandedDecls.map { decl in
              CodeBlockItemSyntax(item: .decl(decl))
            }
          )
        } catch {
          // Record the error
          context.diagnose(
            Diagnostic(
              node: Syntax(node),
              message: ThrownErrorDiagnostic(message: String(describing: error))
            )
          )
        }

        continue
      }

      // Recurse on the child node.
      let newItem = visit(item.item)
      newItems.append(item.withItem(newItem))

      // Expand any peer declarations triggered by macros used as attributes.
      if case let .decl(decl) = item.item {
        let peers = expandPeers(of: decl)
        newItems.append(
          contentsOf: peers.map {
            newDecl in CodeBlockItemSyntax(item: .decl(newDecl))
          }
        )
      }
    }

    return CodeBlockItemListSyntax(newItems)
  }

  override func visit(_ node: MemberDeclListSyntax) -> MemberDeclListSyntax {
    var newItems: [MemberDeclListItemSyntax] = []
    for item in node {
      // Expand declaration macros, which produce zero or more declarations.
      if let declExpansion = item.decl.as(MacroExpansionDeclSyntax.self),
        let macro = macroSystem.macros[declExpansion.macro.text],
        let freestandingMacro = macro as? FreestandingDeclarationMacro.Type
      {
        do {
          let expandedDecls = try freestandingMacro.expansion(
            of: declExpansion,
            in: &context
          )

          newItems.append(
            contentsOf: expandedDecls.map { decl in
              MemberDeclListItemSyntax(decl: decl)
            }
          )
        } catch {
          // Record the error
          context.diagnose(
            Diagnostic(
              node: Syntax(node),
              message: ThrownErrorDiagnostic(message: String(describing: error))
            )
          )
        }

        continue
      }

      // Recurse on the child node.
      let newDecl = visit(item.decl)
      newItems.append(item.withDecl(newDecl))

      // Expand any peer declarations triggered by macros used as attributes.
      let peers = expandPeers(of: item.decl)
      newItems.append(
        contentsOf: peers.map {
          newDecl in MemberDeclListItemSyntax(decl: newDecl)
        }
      )
    }

    return .init(newItems)
  }
}

extension MacroApplication {
  // If any of the custom attributes associated with the given declaration
  // refer to "peer" declaration macros, expand them and return the resulting
  // set of peer declarations.
  private func expandPeers(of decl: DeclSyntax) -> [DeclSyntax] {
    // Dig out the attribute list.
    // FIXME: We should have a better way to get the attributes from any
    // declaration.
    guard
      let attributes =
        (decl.children(viewMode: .sourceAccurate).compactMap {
          $0.as(AttributeListSyntax.self)
        }).first
    else {
      return []
    }

    var peers: [DeclSyntax] = []
    for attribute in attributes {
      guard case let .customAttribute(customAttribute) = attribute,
        let attributeName = customAttribute.attributeName.as(SimpleTypeIdentifierSyntax.self)?.name.text,
        let macro = macroSystem.macros[attributeName],
        let peerMacro = macro as? PeerDeclarationMacro.Type
      else {
        continue
      }

      do {
        let newPeers = try peerMacro.expansion(of: customAttribute, attachedTo: decl, in: &context)
        peers.append(contentsOf: newPeers)
      } catch {
        // Record the error
        context.diagnose(
          Diagnostic(
            node: Syntax(attribute),
            message: ThrownErrorDiagnostic(message: String(describing: error))
          )
        )
      }
    }

    return peers
  }
}

extension SyntaxProtocol {
  /// Expand all uses of the given set of macros within this syntax
  /// node.
  public func expand(
    macros: [String: Macro.Type],
    in context: inout MacroExpansionContext
  ) -> Syntax {
    // Build the macro system.
    var system = MacroSystem()
    for (macroName, macroType) in macros {
      try! system.add(macroType, name: macroName)
    }

    let applier = MacroApplication(
      macroSystem: system,
      context: context
    )

    defer {
      context = applier.context
    }

    return applier.visit(Syntax(self))
  }
}
