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

  /// A stack of member attribute macos to expand when iterating over a `MemberDeclListSyntax`.
  var memberAttributeMacros: [([(AttributeSyntax, MemberAttributeMacro.Type)], DeclSyntax)] = []

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
        guard case let .attribute(attribute) = $0 else {
          return true
        }

        guard let attributeName = attribute.attributeName.as(SimpleTypeIdentifierSyntax.self)?.name.text,
          let macro = macroSystem.macros[attributeName]
        else {
          return true
        }

        return !(macro is PeerDeclarationMacro.Type || macro is MemberDeclarationMacro.Type || macro is AccessorDeclarationMacro.Type || macro is MemberAttributeMacro.Type)
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

      // Expand member attribute members attached to the declaration context.
      let attributedMember: MemberDeclListSyntax.Element
      if let (macroAttributes, decl) = memberAttributeMacros.last {
        attributedMember = expandAttributes(
          for: macroAttributes,
          attachedTo: decl,
          annotating: item
        )
      } else {
        attributedMember = item
      }

      // Recurse on the child node.
      let newDecl = visit(attributedMember.decl)
      newItems.append(attributedMember.withDecl(newDecl))

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

  func visit<DeclType: DeclGroupSyntax & DeclSyntaxProtocol>(
    declGroup: DeclType
  ) -> DeclSyntax {
    memberAttributeMacros.append(
      (
        getMacroAttributes(attachedTo: DeclSyntax(declGroup), ofType: MemberAttributeMacro.Type.self),
        DeclSyntax(declGroup)
      )
    )
    defer { memberAttributeMacros.removeLast() }

    // Expand any attached member macros.
    let expandedDeclGroup = expandMembers(of: declGroup)

    // Recurse into member decls.
    let newMembers = visit(expandedDeclGroup.members)

    return DeclSyntax(expandedDeclGroup.withMembers(newMembers))
  }

  override func visit(_ node: ActorDeclSyntax) -> DeclSyntax {
    return visit(declGroup: node)
  }

  override func visit(_ node: StructDeclSyntax) -> DeclSyntax {
    return visit(declGroup: node)
  }

  override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
    return visit(declGroup: node)
  }

  override func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
    return visit(declGroup: node)
  }

  override func visit(_ node: ProtocolDeclSyntax) -> DeclSyntax {
    return visit(declGroup: node)
  }

  override func visit(_ node: ExtensionDeclSyntax) -> DeclSyntax {
    return visit(declGroup: node)
  }

  // Properties
  override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
    let visitedNode = super.visit(node)
    guard let visitedVarDecl = visitedNode.as(VariableDeclSyntax.self) else {
      return visitedNode
    }

    guard let binding = visitedVarDecl.bindings.first,
      visitedVarDecl.bindings.count == 1
    else {
      return DeclSyntax(node)
    }

    var accessors: [AccessorDeclSyntax] = []

    let accessorMacroAttributes = getMacroAttributes(attachedTo: DeclSyntax(node), ofType: AccessorDeclarationMacro.Type.self)
    for (accessorAttr, accessorMacro) in accessorMacroAttributes {
      do {
        let newAccessors = try accessorMacro.expansion(
          of: accessorAttr,
          attachedTo: DeclSyntax(visitedNode),
          in: &context
        )

        accessors.append(contentsOf: newAccessors)
      } catch {
        // FIXME: record the error
      }
    }

    if accessors.isEmpty {
      return visitedNode
    }

    return DeclSyntax(
      visitedVarDecl.withBindings(
        visitedVarDecl.bindings.replacing(
          childAt: 0,
          with: binding.withAccessor(
            .accessors(
              .init(
                leftBrace: .leftBraceToken(leadingTrivia: .space),
                accessors: .init(accessors),
                rightBrace: .rightBraceToken(leadingTrivia: .newline)
              )
            )
          )
        )
      )
    )
  }

  // Subscripts
}

extension MacroApplication {
  private func getMacroAttributes<MacroType>(
    attachedTo decl: DeclSyntax,
    ofType: MacroType.Type
  ) -> [(AttributeSyntax, MacroType)] {
    guard let attributedNode = decl.asProtocol(AttributedSyntax.self),
      let attributes = attributedNode.attributes
    else {
      return []
    }

    return attributes.compactMap {
      guard case let .attribute(attribute) = $0,
        let attributeName = attribute.attributeName.as(SimpleTypeIdentifierSyntax.self)?.name.text,
        let macro = macroSystem.macros[attributeName],
        let macroType = macro as? MacroType
      else {
        return nil
      }

      return (attribute, macroType)
    }
  }

  // If any of the custom attributes associated with the given declaration
  // refer to "peer" declaration macros, expand them and return the resulting
  // set of peer declarations.
  private func expandPeers(of decl: DeclSyntax) -> [DeclSyntax] {
    var peers: [DeclSyntax] = []
    let macroAttributes = getMacroAttributes(attachedTo: decl, ofType: PeerDeclarationMacro.Type.self)
    for (attribute, peerMacro) in macroAttributes {
      do {
        let newPeers = try peerMacro.expansion(of: attribute, attachedTo: decl, in: &context)
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

  /// Expands any attached custom attributes that refer to member declaration macros,
  /// and returns result of adding those members to the given declaration.
  private func expandMembers<Decl: DeclGroupSyntax & DeclSyntaxProtocol>(
    of decl: Decl
  ) -> Decl {
    var newMembers: [DeclSyntax] = []
    let macroAttributes = getMacroAttributes(attachedTo: DeclSyntax(decl), ofType: MemberDeclarationMacro.Type.self)
    for (attribute, memberMacro) in macroAttributes {
      do {
        try newMembers.append(
          contentsOf: memberMacro.expansion(
            of: attribute,
            attachedTo: DeclSyntax(decl),
            in: &context
          )
        )
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

    // FIXME: Is there a better way to add N members to a decl?
    return decl.withMembers(
      newMembers.reduce(decl.members) { partialMembers, newMember in
        partialMembers.addMember(.init(decl: newMember))
      }
    )
  }

  private func expandAttributes(
    for macroAttributes: [(AttributeSyntax, MemberAttributeMacro.Type)],
    attachedTo decl: DeclSyntax,
    annotating member: MemberDeclListSyntax.Element
  ) -> MemberDeclListSyntax.Element {
    guard let attributedDecl = member.decl.asProtocol(AttributedSyntax.self) else {
      return member
    }

    var attributes: [AttributeSyntax] = []
    for (attribute, attributeMacro) in macroAttributes {
      do {
        try attributes.append(
          contentsOf: attributeMacro.expansion(
            of: attribute,
            attachedTo: DeclSyntax(decl),
            annotating: member.decl,
            in: &context
          )
        )
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

    let newAttributes = attributes.reduce(attributedDecl.attributes ?? .init([])) {
      $0.appending(AttributeListSyntax.Element($1))
    }

    let newDecl = attributedDecl.withAttributes(newAttributes).as(DeclSyntax.self)!
    return member.withDecl(newDecl)
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
