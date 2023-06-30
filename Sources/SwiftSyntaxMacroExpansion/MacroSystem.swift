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
@_spi(MacroExpansion) import SwiftSyntaxMacros

private func expandMemberAttributeMacro(attribute: AttributeSyntax, attachedTo: DeclSyntax) -> AttributeListSyntax {
  fatalError("unimplemented")
}

private func expandMemberMacro(attribute: AttributeSyntax, attachedTo: DeclGroupSyntax) -> MemberDeclListSyntax {
  fatalError("unimplemented")
}

private func expandPeerMacro(attribute: AttributeSyntax, attachedTo: DeclSyntax) -> CodeBlockItemListSyntax {
  fatalError("unimplemented")
}

private func expandConformanceMacro(attribute: AttributeSyntax, attachedTo: DeclSyntax) -> CodeBlockItemListSyntax {
  fatalError("unimplemented")
}

private func expandAccessorMacro(attribute: AttributeSyntax, attachedTo: DeclSyntax) -> AccessorListSyntax {
  fatalError("unimplemented")
}

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
class MacroApplication<Context: MacroExpansionContext>: SyntaxRewriter {
  let macroSystem: MacroSystem
  var context: Context
  var skipNodes: Set<Syntax> = []

  /// A stack of member attribute macos to expand when iterating over a ``MemberDeclListSyntax``.
  var memberAttributeMacros: [([(AttributeSyntax, MemberAttributeMacro.Type)], DeclSyntax)] = []

  init(
    macroSystem: MacroSystem,
    context: Context
  ) {
    self.macroSystem = macroSystem
    self.context = context
    super.init(viewMode: .sourceAccurate)
  }

  override func visitAny(_ node: Syntax) -> Syntax? {
    if skipNodes.contains(node) {
      return nil
    }

    if node.evaluatedMacroName != nil {
      return node.evaluateMacro(
        with: macroSystem,
        context: context
      )
    }

    if let declSyntax = node.as(DeclSyntax.self),
      let attributedNode = node.asProtocol(WithAttributesSyntax.self),
      let attributes = attributedNode.attributes
    {
      // Visit the node.
      skipNodes.insert(node)
      let visitedNode = self.visit(declSyntax).asProtocol(WithAttributesSyntax.self)!
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

        return
          !(macro is PeerMacro.Type
          || macro is MemberMacro.Type
          || macro is AccessorMacro.Type
          || macro is MemberAttributeMacro.Type
          || macro is ExtensionMacro.Type)
      }

      if newAttributes.isEmpty {
        return Syntax(fromProtocol: visitedNode.with(\.attributes, nil))
      }

      return Syntax(fromProtocol: visitedNode.with(\.attributes, AttributeListSyntax(newAttributes)))
    }

    return nil
  }

  override func visit(_ node: CodeBlockItemListSyntax) -> CodeBlockItemListSyntax {
    var newItems: [CodeBlockItemSyntax] = []
    for item in node {
      if let expansion = item.item.asProtocol(FreestandingMacroExpansionSyntax.self),
        let macro = macroSystem.macros[expansion.macro.text]
      {
        func _expand(expansion: some FreestandingMacroExpansionSyntax) throws {
          if let macro = macro as? CodeItemMacro.Type {
            let expandedItemList = try macro.expansion(
              of: expansion,
              in: context
            )
            newItems.append(contentsOf: expandedItemList)
          } else if let macro = macro as? DeclarationMacro.Type {
            var expandedItemList = try macro.expansion(
              of: expansion,
              in: context
            )
            if let declExpansion = expansion.as(MacroExpansionDeclSyntax.self) {
              let attributes = macro.propagateFreestandingMacroAttributes ? declExpansion.attributes : nil
              let modifiers = macro.propagateFreestandingMacroModifiers ? declExpansion.modifiers : nil
              expandedItemList = expandedItemList.map {
                $0.applying(attributes: attributes, modifiers: modifiers)
              }
            }
            newItems.append(
              contentsOf: expandedItemList.map {
                CodeBlockItemSyntax(item: .decl($0))
              }
            )
          } else if let macro = macro as? ExpressionMacro.Type {
            let expandedExpr = try macro.expansion(
              of: expansion,
              in: context
            )
            newItems.append(CodeBlockItemSyntax(item: .init(expandedExpr)))
          }
        }
        do {
          try _openExistential(expansion, do: _expand)
        } catch {
          context.addDiagnostics(from: error, node: node)
        }

        continue
      }

      // Recurse on the child node.
      let newItem = visit(item.item)
      newItems.append(item.with(\.item, newItem))

      // Expand any peer declarations or conformances triggered by macros used
      // as attributes.
      if case let .decl(decl) = item.item {
        let peers = expandPeers(of: decl)
        newItems.append(
          contentsOf: peers.map {
            newDecl in CodeBlockItemSyntax(item: .decl(newDecl))
          }
        )

        if let declGroup = decl.asProtocol(DeclGroupSyntax.self) {
          newItems.append(
            contentsOf: expandExtensions(of: declGroup).map {
              newDecl in CodeBlockItemSyntax(item: .decl(newDecl))
            }
          )
        }
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
        let freestandingMacro = macro as? DeclarationMacro.Type
      {
        do {
          var expandedList = try freestandingMacro.expansion(
            of: declExpansion,
            in: context
          )
          let attributes = freestandingMacro.propagateFreestandingMacroAttributes ? declExpansion.attributes : nil
          let modifiers = freestandingMacro.propagateFreestandingMacroModifiers ? declExpansion.modifiers : nil
          expandedList = expandedList.map {
            $0.applying(attributes: attributes, modifiers: modifiers)
          }

          newItems.append(
            contentsOf: expandedList.map { decl in
              return MemberDeclListItemSyntax(decl: decl)
            }
          )
        } catch {
          context.addDiagnostics(from: error, node: declExpansion)
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
      newItems.append(attributedMember.with(\.decl, newDecl))

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
    let newMembers = visit(expandedDeclGroup.memberBlock)

    return DeclSyntax(expandedDeclGroup.with(\.memberBlock, newMembers))
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

    let accessorMacroAttributes = getMacroAttributes(attachedTo: DeclSyntax(node), ofType: AccessorMacro.Type.self)
    for (accessorAttr, accessorMacro) in accessorMacroAttributes {
      do {
        let newAccessors = try accessorMacro.expansion(
          of: accessorAttr,
          providingAccessorsOf: visitedNode,
          in: context
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
      visitedVarDecl.with(
        \.bindings,
        visitedVarDecl.bindings.replacing(
          childAt: 0,
          with: binding.with(
            \.accessor,
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
    guard let attributedNode = decl.asProtocol(WithAttributesSyntax.self),
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
    let macroAttributes = getMacroAttributes(attachedTo: decl, ofType: PeerMacro.Type.self)
    for (attribute, peerMacro) in macroAttributes {
      do {
        let newPeers = try peerMacro.expansion(of: attribute, providingPeersOf: decl, in: context)
        peers.append(contentsOf: newPeers)
      } catch {
        context.addDiagnostics(from: error, node: attribute)
      }
    }

    return peers
  }

  // If any of the custom attributes associated with the given declaration
  // refer to conformance macros, expand them and return the resulting
  // set of extension declarations.
  private func expandExtensions(of decl: DeclGroupSyntax) -> [DeclSyntax] {
    let extendedType: TypeSyntax
    if let identified = decl.asProtocol(IdentifiedDeclSyntax.self) {
      extendedType = "\(identified.identifier.trimmed)"
    } else if let ext = decl.as(ExtensionDeclSyntax.self) {
      extendedType = "\(ext.extendedType.trimmed)"
    } else {
      return []
    }

    var extensions: [DeclSyntax] = []

    let extensionMacroAttrs = getMacroAttributes(attachedTo: decl.as(DeclSyntax.self)!, ofType: ExtensionMacro.Type.self)
    for (attribute, extensionMacro) in extensionMacroAttrs {
      do {
        // FIXME: We need a way for unit tests of extension macros to
        // specify protocols already stated in source (e.g. as arguments
        // to `assertMacroExpansion`).
        let newExtensions = try extensionMacro.expansion(
          of: attribute,
          attachedTo: decl,
          providingExtensionsOf: extendedType,
          conformingTo: [],
          in: context
        )

        extensions.append(contentsOf: newExtensions.map(DeclSyntax.init))
      } catch {
        context.addDiagnostics(from: error, node: attribute)
      }
    }

    return extensions
  }

  /// Expands any attached custom attributes that refer to member declaration macros,
  /// and returns result of adding those members to the given declaration.
  private func expandMembers<Decl: DeclGroupSyntax & DeclSyntaxProtocol>(
    of decl: Decl
  ) -> Decl {
    var newMembers: [DeclSyntax] = []
    let macroAttributes = getMacroAttributes(attachedTo: DeclSyntax(decl), ofType: MemberMacro.Type.self)
    for (attribute, memberMacro) in macroAttributes {
      do {
        try newMembers.append(
          contentsOf: memberMacro.expansion(
            of: attribute,
            providingMembersOf: decl,
            in: context
          )
        )
      } catch {
        context.addDiagnostics(from: error, node: attribute)
      }
    }

    // FIXME: Is there a better way to add N members to a decl?
    return decl.with(
      \.memberBlock,
      newMembers.reduce(decl.memberBlock) { partialMembers, newMember in
        partialMembers.addMember(.init(decl: newMember))
      }
    )
  }

  private func expandMemberAttribute(
    attribute: AttributeSyntax,
    macro: MemberAttributeMacro.Type,
    decl: DeclGroupSyntax,
    member: DeclSyntax,
    in context: MacroExpansionContext
  ) throws -> [AttributeSyntax] {
    #if false
    _openExistential(decl) { d in
      return try! macro.expansion(
        of: attribute,
        attachedTo: d,
        annotating: member,
        in: context
      )
    }
    #else
    return []
    #endif
  }

  private func expandAttributes(
    for macroAttributes: [(AttributeSyntax, MemberAttributeMacro.Type)],
    attachedTo decl: DeclSyntax,
    annotating member: MemberDeclListSyntax.Element
  ) -> MemberDeclListSyntax.Element {
    guard let attributedDecl = member.decl.asProtocol(WithAttributesSyntax.self) else {
      return member
    }

    var attributes: [AttributeSyntax] = []
    for (attribute, attributeMacro) in macroAttributes {
      do {
        let typedDecl = decl.asProtocol(DeclGroupSyntax.self)!

        func expand(_ decl: some DeclGroupSyntax) throws -> [AttributeSyntax] {
          return try attributeMacro.expansion(
            of: attribute,
            attachedTo: decl,
            providingAttributesFor: member.decl,
            in: context
          )
        }

        attributes.append(
          contentsOf: try _openExistential(typedDecl, do: expand)
        )
      } catch {
        context.addDiagnostics(from: error, node: attribute)
      }
    }

    let newAttributes = attributes.reduce(attributedDecl.attributes ?? .init([])) {
      $0.appending(AttributeListSyntax.Element($1))
    }

    let newDecl = attributedDecl.with(\.attributes, newAttributes).as(DeclSyntax.self)!
    return member.with(\.decl, newDecl)
  }
}

extension DeclSyntax {
  /// Returns this node with `attributes` and `modifiers` prepended to the
  /// node’s attributes and modifiers, respectively. If the node doesn’t contain
  /// attributes or modifiers, `attributes` or `modifiers` are ignored and not
  /// applied.
  func applying(
    attributes: AttributeListSyntax?,
    modifiers: ModifierListSyntax?
  ) -> DeclSyntax {
    func _combine<C: SyntaxCollection>(_ left: C, _ right: C?) -> C? {
      guard let right = right else { return left }
      var elems: [C.Element] = []
      elems.append(contentsOf: left)
      elems.append(contentsOf: right)
      return C(elems)
    }
    var node = self
    if let attributes = attributes,
      let withAttrs = node.asProtocol(WithAttributesSyntax.self)
    {
      node = withAttrs.with(
        \.attributes,
        _combine(attributes, withAttrs.attributes)
      ).cast(DeclSyntax.self)
    }
    if let modifiers = modifiers,
      let withModifiers = node.asProtocol(WithModifiersSyntax.self)
    {
      node = withModifiers.with(
        \.modifiers,
        _combine(modifiers, withModifiers.modifiers)
      ).cast(DeclSyntax.self)
    }
    return node
  }
}

extension SyntaxProtocol {
  /// Expand all uses of the given set of macros within this syntax
  /// node.
  public func expand(
    macros: [String: Macro.Type],
    in context: some MacroExpansionContext
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

    return applier.rewrite(self)
  }
}
