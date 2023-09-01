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
@_spi(MacroExpansion) import SwiftParser
@_spi(MacroExpansion) import SwiftSyntaxMacros

// MARK: - Public entry function

extension SyntaxProtocol {
  /// Expand all uses of the given set of macros within this syntax node.
  public func expand(
    macros: [String: Macro.Type],
    in context: some MacroExpansionContext,
    indentationWidth: Trivia? = nil
  ) -> Syntax {
    // Build the macro system.
    var system = MacroSystem()
    for (macroName, macroType) in macros {
      try! system.add(macroType, name: macroName)
    }

    let applier = MacroApplication(
      macroSystem: system,
      context: context,
      indentationWidth: indentationWidth
    )

    return applier.rewrite(self)
  }
}

// MARK: - Expand macros

/// Expand the given freestanding macro and parse the resulting text into a
/// syntax tree.
private func expandFreestandingMemberDeclList(
  definition: Macro.Type,
  node: some FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> MemberBlockItemListSyntax? {
  guard
    let expanded = try expandFreestandingMacro(
      definition: definition,
      macroRole: inferFreestandingMacroRole(definition: definition),
      node: node.detach(in: context),
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  let indentedSource =
    expanded
    .indented(by: node.indentationOfFirstLine)
    .wrappingInTrivia(from: node)
  return "\(raw: indentedSource)"
}

private func expandFreestandingCodeItemList(
  definition: Macro.Type,
  node: some FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> CodeBlockItemListSyntax? {
  guard
    let expanded = try expandFreestandingMacro(
      definition: definition,
      macroRole: inferFreestandingMacroRole(definition: definition),
      node: node.detach(in: context),
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // The macro expansion just provides an expansion for the content.
  // We need to make sure that we aren’t dropping the trivia before and after
  // the expansion.
  let indentedSource =
    expanded
    .indented(by: node.indentationOfFirstLine)
    .wrappingInTrivia(from: node)
  return "\(raw: indentedSource)"
}

private func expandFreestandingExpr(
  definition: Macro.Type,
  node: some FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> ExprSyntax? {
  guard
    let expanded = expandFreestandingMacro(
      definition: definition,
      macroRole: .expression,
      node: node.detach(in: context),
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  let indentedSource =
    expanded
    .indented(by: node.indentationOfFirstLine)
    .wrappingInTrivia(from: node)
  return "\(raw: indentedSource)"
}

private func expandMemberMacro(
  definition: MemberMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> MemberBlockItemListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .member,
      attributeNode: attributeNode.detach(in: context),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate new members from exisiting members by two newlines
  let indentedSource = "\n\n" + expanded.indented(by: attachedTo.indentationOfFirstLine + indentationWidth)
  return "\(raw: indentedSource)"
}

private func expandMemberAttributeMacro(
  definition: MemberAttributeMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo declaration: DeclSyntax,
  providingAttributeFor member: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> AttributeListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .memberAttribute,
      attributeNode: attributeNode.detach(in: context),
      declarationNode: member.detach(in: context),
      parentDeclNode: declaration.detach(in: context),
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // The added attributes should be on their own line, so prepend them with a newline.
  let indentedSource = "\n" + expanded.indented(by: member.indentationOfFirstLine)
  return "\(raw: indentedSource)"
}

private func expandPeerMacroMember(
  definition: PeerMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> MemberBlockItemListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .peer,
      attributeNode: attributeNode.detach(in: context),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate the peers and the declaration by two newlines.
  let indentedSource = "\n\n" + expanded.indented(by: attachedTo.indentationOfFirstLine)
  return "\(raw: indentedSource)"
}

private func expandPeerMacroCodeItem(
  definition: PeerMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> CodeBlockItemListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .peer,
      attributeNode: attributeNode.detach(in: context),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate the peers and the declaration by two newlines.
  let indentedSource = "\n\n" + expanded.indented(by: attachedTo.indentationOfFirstLine)
  return "\(raw: indentedSource)"
}

/// Expand an accessor macro of a declaration that does not have existing
/// accessors.
///
/// See comment in `expandAccessors` for an explanation why we need this.
private func expandAccessorMacroWithoutExistingAccessors(
  definition: AccessorMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> AccessorBlockSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .accessor,
      attributeNode: attributeNode.detach(in: context),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // `expandAttachedMacro` adds the `{` and `}` to wrap the accessor block and
  // then indents it.
  // Remove any indentaiton from the first line using `drop(while:)` and then
  // prepend a space to separate it from the variable declaration
  let indentedSource = " " + expanded.indented(by: attachedTo.indentationOfFirstLine).drop(while: { $0.isWhitespace })
  return "\(raw: indentedSource)"
}

/// Expand an accessor macro of a declaration that already has an accessor.
///
/// See comment in `expandAccessors` for an explanation why we need this.
private func expandAccessorMacroWithExistingAccessors(
  definition: AccessorMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> AccessorDeclListSyntax? {
  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .accessor,
      attributeNode: attributeNode.detach(in: context),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: nil,
      conformanceList: nil,
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate the accessor from any existing accessors by two spaces
  let indentedSource = "\n" + expanded.indented(by: attachedTo.indentationOfFirstLine + indentationWidth)
  return "\(raw: indentedSource)"
}

private func expandExtensionMacro(
  definition: ExtensionMacro.Type,
  attributeNode: AttributeSyntax,
  attachedTo: DeclSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia
) throws -> CodeBlockItemListSyntax? {
  let extendedType: TypeSyntax
  if let identified = attachedTo.asProtocol(NamedDeclSyntax.self) {
    extendedType = "\(identified.name.trimmed)"
  } else if let ext = attachedTo.as(ExtensionDeclSyntax.self) {
    extendedType = "\(ext.extendedType.trimmed)"
  } else {
    return nil
  }

  guard
    let expanded = expandAttachedMacro(
      definition: definition,
      macroRole: .extension,
      attributeNode: attributeNode.detach(in: context),
      declarationNode: attachedTo.detach(in: context),
      parentDeclNode: nil,
      extendedType: extendedType.detach(in: context),
      conformanceList: [],
      in: context,
      indentationWidth: indentationWidth
    )
  else {
    return nil
  }

  // Separate the extension from other declarations in the source file by two newlines.
  let indentedSource = "\n\n" + expanded
  return "\(raw: indentedSource)"
}

// MARK: - MacroSystem

/// Describes the kinds of errors that can occur within a macro system.
enum MacroSystemError: Error {
  /// Indicates that a macro with the given name has already been defined.
  case alreadyDefined(new: Macro.Type, existing: Macro.Type)
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

// MARK: - MacroApplication

/// Removes attributes from a syntax tree while maintaining their surrounding trivia.
private class AttributeRemover: SyntaxRewriter {
  var attributesToRemove: [AttributeSyntax]

  var triviaToAttachToNextToken: Trivia = Trivia()

  init(attributesToRemove: [AttributeSyntax]) {
    self.attributesToRemove = attributesToRemove
  }

  override func visit(_ node: AttributeListSyntax) -> AttributeListSyntax {
    var filteredAttributes: [AttributeListSyntax.Element] = []
    for case .attribute(let attribute) in node {
      if attributesToRemove.contains(attribute) {
        var leadingTrivia = node.leadingTrivia
        if let lastNewline = leadingTrivia.pieces.lastIndex(where: { $0.isNewline }),
          leadingTrivia.pieces[lastNewline...].allSatisfy(\.isWhitespace),
          node.trailingTrivia.isEmpty,
          node.nextToken(viewMode: .sourceAccurate)?.leadingTrivia.first?.isNewline ?? false
        {
          // If the attribute is on its own line based on the following conditions,
          // remove the newline from it so we don’t end up with an empty line
          //  - Trailing trivia ends with a newline followed by arbitrary number of spaces or tabs
          //  - There is no trailing trivia and the next token starts on a new line
          leadingTrivia = Trivia(pieces: leadingTrivia.pieces[..<lastNewline])
        }
        // Drop any spaces or tabs from the trailing trivia because there’s no
        // more attribute they need to separate.
        let trailingTrivia = Trivia(pieces: attribute.trailingTrivia.drop(while: { $0.isSpaceOrTab }))
        triviaToAttachToNextToken += leadingTrivia + trailingTrivia
      } else {
        filteredAttributes.append(.attribute(attribute))
      }
    }
    return AttributeListSyntax(filteredAttributes)
  }

  override func visit(_ token: TokenSyntax) -> TokenSyntax {
    if !triviaToAttachToNextToken.isEmpty {
      defer { triviaToAttachToNextToken = Trivia() }
      return token.with(\.leadingTrivia, triviaToAttachToNextToken + token.leadingTrivia)
    } else {
      return token
    }
  }
}

let diagnosticDomain: String = "SwiftSyntaxMacroExpansion"

private enum MacroApplicationError: DiagnosticMessage, Error {
  case accessorMacroOnVariableWithMultipleBindings
  case malformedAccessor

  var diagnosticID: MessageID {
    return MessageID(domain: diagnosticDomain, id: "\(self)")
  }

  var severity: DiagnosticSeverity { return .error }

  var message: String {
    switch self {
    case .accessorMacroOnVariableWithMultipleBindings:
      return """
        swift-syntax applies macros syntactically and there is no way to represent a variable \
        declaration with multiple bindings that have accessors syntactically. \
        While the compiler allows this expansion, swift-syntax cannot represent it and thus \
        disallows it.
        """
    case .malformedAccessor:
      return """
        Macro returned a malformed accessor. Accessors should start with an introducer like 'get' or 'set'.
        """
    }
  }
}

/// Syntax rewriter that evaluates any macros encountered along the way.
private class MacroApplication<Context: MacroExpansionContext>: SyntaxRewriter {
  let macroSystem: MacroSystem
  var context: Context
  var indentationWidth: Trivia
  /// Nodes that we are currently handling in `visitAny` and that should be
  /// visited using the node-specific handling function.
  var skipVisitAnyHandling: Set<Syntax> = []

  /// Store expanded extension while visiting member decls. This should be
  /// added to top-level 'CodeBlockItemList'.
  var extensions: [CodeBlockItemSyntax] = []

  init(
    macroSystem: MacroSystem,
    context: Context,
    indentationWidth: Trivia?
  ) {
    self.macroSystem = macroSystem
    self.context = context
    // Default to 4 spaces if no indentation was passed.
    // In the future, we could consider inferring the indentation width from the
    // source file in which we expand the macros.
    self.indentationWidth = indentationWidth ?? .spaces(4)
    super.init(viewMode: .sourceAccurate)
  }

  override func visitAny(_ node: Syntax) -> Syntax? {
    if skipVisitAnyHandling.contains(node) {
      return nil
    }

    // Expand 'MacroExpansionExpr'.
    // Note that 'MacroExpansionExpr'/'MacroExpansionExprDecl' at code item
    // position are handled by 'visit(_:CodeBlockItemListSyntax)'.
    // Only expression expansions inside other syntax nodes is handled here.
    if let expanded = expandExpr(node: node) {
      return Syntax(visit(expanded))
    }

    if let declSyntax = node.as(DeclSyntax.self),
      let attributedNode = node.asProtocol(WithAttributesSyntax.self),
      !attributedNode.attributes.isEmpty
    {
      // Visit the node, disabling the `visitAny` handling.
      skipVisitAnyHandling.insert(node)
      let visitedNode = self.visit(declSyntax)
      skipVisitAnyHandling.remove(node)

      let attributesToRemove = self.macroAttributes(attachedTo: visitedNode).map(\.attributeNode)

      return AttributeRemover(attributesToRemove: attributesToRemove).rewrite(visitedNode)
    }

    return nil
  }

  override func visit(_ node: CodeBlockItemListSyntax) -> CodeBlockItemListSyntax {
    var newItems: [CodeBlockItemSyntax] = []
    func addResult(_ node: CodeBlockItemSyntax) {
      // Expand freestanding macro.
      if let expanded = expandCodeBlockItem(node: node) {
        for item in expanded {
          addResult(item)
        }
        return
      }

      // Recurse on the child node
      newItems.append(visit(node))

      // Expand any peer macro on this item.
      if case .decl(let decl) = node.item {
        for peer in expandCodeBlockPeers(of: decl) {
          addResult(peer)
        }
        extensions += expandExtensions(of: decl)
      }
    }

    for item in node {
      addResult(item)
    }

    // If this is the top-level code block item list, add the expanded extensions
    // at its end.
    if node.parent?.is(SourceFileSyntax.self) ?? false {
      newItems += extensions
    }

    return CodeBlockItemListSyntax(newItems)
  }

  override func visit(_ node: MemberBlockItemListSyntax) -> MemberBlockItemListSyntax {
    let parentDeclGroup = node
      .parent?
      .as(MemberBlockSyntax.self)?
      .parent?
      .as(DeclSyntax.self)
    var newItems: [MemberBlockItemSyntax] = []

    func addResult(_ node: MemberBlockItemSyntax) {
      // Expand freestanding macro.
      if let expanded = expandMemberDecl(node: node) {
        for item in expanded {
          addResult(item)
        }
        return
      }

      // Recurse on the child node.
      newItems.append(visit(node))

      // Expand any peer macro on this member.
      for peer in expandMemberDeclPeers(of: node.decl) {
        addResult(peer)
      }
      extensions += expandExtensions(of: node.decl)
    }

    for var item in node {
      // Expand member attribute members attached to the declaration context.
      // Note that MemberAttribute macros are _not_ applied to generated members
      if let parentDeclGroup, let decl = item.decl.asProtocol(WithAttributesSyntax.self) {
        var newAttributes = AttributeListSyntax(
          expandAttributesFromMemberAttributeMacros(
            of: item.decl,
            parentDecl: parentDeclGroup
          )
          .map { visit($0) }
        )
        if !newAttributes.isEmpty {
          // Transfer the trailing trivia from the old attributes to the new attributes.
          // This way, we essentially insert the new attributes right after the last attribute in source
          // but before its trailing trivia, keeping the trivia that separates the attribute block
          // from the variable itself.
          newAttributes.trailingTrivia = newAttributes.trailingTrivia + decl.attributes.trailingTrivia
          newAttributes.insert(contentsOf: decl.attributes.with(\.trailingTrivia, []), at: newAttributes.startIndex)
          item.decl = decl.with(\.attributes, newAttributes).cast(DeclSyntax.self)
        }
      }

      // Recurse on the child node.
      addResult(item)
    }

    // Expand any member macros of parent.
    if let parentDeclGroup {
      for member in expandMembers(of: parentDeclGroup) {
        addResult(member)
      }
    }

    return .init(newItems)
  }

  override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
    guard !macroAttributes(attachedTo: DeclSyntax(node), ofType: AccessorMacro.Type.self).isEmpty else {
      return super.visit(node).cast(DeclSyntax.self)
    }

    var node = super.visit(node).cast(VariableDeclSyntax.self)
    guard node.bindings.count == 1, let binding = node.bindings.first else {
      context.addDiagnostics(from: MacroApplicationError.accessorMacroOnVariableWithMultipleBindings, node: node)
      return DeclSyntax(node)
    }
    node.bindings[node.bindings.startIndex].accessorBlock = expandAccessors(of: node, existingAccessors: binding.accessorBlock)
    return DeclSyntax(node)
  }

  override func visit(_ node: SubscriptDeclSyntax) -> DeclSyntax {
    var node = super.visit(node).cast(SubscriptDeclSyntax.self)
    node.accessorBlock = expandAccessors(of: node, existingAccessors: node.accessorBlock)
    return DeclSyntax(node)
  }
}

// MARK:  Attached macro expansions.

extension MacroApplication {
  /// Get pairs of a macro attribute and the macro definition attached to `decl`.
  ///
  /// The macros must be registered in `macroSystem`.
  private func macroAttributes(
    attachedTo decl: DeclSyntax
  ) -> [(attributeNode: AttributeSyntax, definition: Macro.Type)] {
    guard let attributedNode = decl.asProtocol(WithAttributesSyntax.self) else {
      return []
    }

    return attributedNode.attributes.compactMap {
      guard case let .attribute(attribute) = $0,
        let attributeName = attribute.attributeName.as(IdentifierTypeSyntax.self)?.name.text,
        let macro = macroSystem.lookup(attributeName)
      else {
        return nil
      }

      return (attribute, macro)
    }
  }

  /// Get pairs of a macro attribute and the macro definition attached to `decl`
  /// matching `ofType` macro type.
  ///
  /// The macros must be registered in `macroSystem`.
  private func macroAttributes<MacroType>(
    attachedTo decl: DeclSyntax,
    ofType: MacroType.Type
  ) -> [(attributeNode: AttributeSyntax, definition: MacroType)] {
    return macroAttributes(attachedTo: decl)
      .compactMap { (attributeNode: AttributeSyntax, definition: Macro.Type) in
        if let macroType = definition as? MacroType {
          return (attributeNode, macroType)
        } else {
          return nil
        }
      }
  }

  /// Call `expandMacro` for every macro of type `ofType` attached to `decl` and
  /// return the list of all expaned nodes.
  private func expandMacros<
    ExpandedNode: SyntaxProtocol,
    ExpanedNodeCollection: Sequence<ExpandedNode>,
    MacroType
  >(
    attachedTo decl: DeclSyntax,
    ofType: MacroType.Type,
    expandMacro: (_ attributeNode: AttributeSyntax, _ definition: MacroType) throws -> ExpanedNodeCollection?
  ) -> [ExpandedNode] {
    var result: [ExpandedNode] = []

    for macroAttribute in macroAttributes(attachedTo: decl, ofType: ofType) {
      do {
        if let expanded = try expandMacro(macroAttribute.attributeNode, macroAttribute.definition) {
          result += expanded
        }
      } catch {
        context.addDiagnostics(from: error, node: macroAttribute.attributeNode)
      }
    }
    return result
  }

  /// Expand all the 'peer' macros attached to `decl`.
  ///
  /// - Note: This overload returns the list of peers as `MemberDeclListItemSyntax`
  ///   while `expandCodeBlockPeers` returns them as `CodeBlockItemSyntax`. The
  ///   overload is chosen based on the context in which the peers are expanded.
  ///
  /// - Returns: The macro-synthesized peers
  private func expandMemberDeclPeers(of decl: DeclSyntax) -> [MemberBlockItemSyntax] {
    return expandMacros(attachedTo: decl, ofType: PeerMacro.Type.self) { attributeNode, definition in
      return try expandPeerMacroMember(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: decl,
        in: context,
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand all the 'peer' macros attached to `decl`.
  ///
  /// - Note: This overload returns the list of peers as `MemberDeclListItemSyntax`
  ///   while `expandMemberDeclPeers` returns them as `MemberDeclListItemSyntax`.
  ///   The overload is chosen based on the context in which the peers are
  ///   expanded.
  ///
  /// - Returns: The macro-synthesized peers
  private func expandCodeBlockPeers(of decl: DeclSyntax) -> [CodeBlockItemSyntax] {
    return expandMacros(attachedTo: decl, ofType: PeerMacro.Type.self) { attributeNode, definition in
      return try expandPeerMacroCodeItem(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: decl,
        in: context,
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand all 'extension' macros attached to `decl`.
  ///
  /// - Returns: The macro-synthesized extensions
  private func expandExtensions(of decl: DeclSyntax) -> [CodeBlockItemSyntax] {
    return expandMacros(attachedTo: decl, ofType: ExtensionMacro.Type.self) { attributeNode, definition in
      return try expandExtensionMacro(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: decl,
        in: context,
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand all 'member' macros attached to `decl`.
  private func expandMembers(of decl: DeclSyntax) -> [MemberBlockItemSyntax] {
    return expandMacros(attachedTo: decl, ofType: MemberMacro.Type.self) { attributeNode, definition in
      return try expandMemberMacro(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: decl,
        in: context,
        indentationWidth: indentationWidth
      )
    }
  }

  /// Return the attributes on `decl` that are synthesized from member attribute
  /// macros on `parentDecl`.
  ///
  /// - Note: This only returns synthesized attributes from member attribute
  ///   macros, not the attributes that are attached to `decl` in the source code.
  private func expandAttributesFromMemberAttributeMacros(
    of decl: DeclSyntax,
    parentDecl: DeclSyntax
  ) -> [AttributeListSyntax.Element] {
    return expandMacros(attachedTo: parentDecl, ofType: MemberAttributeMacro.Type.self) { attributeNode, definition in
      return try expandMemberAttributeMacro(
        definition: definition,
        attributeNode: attributeNode,
        attachedTo: parentDecl,
        providingAttributeFor: decl,
        in: context,
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand all 'accessor' macros attached to `storage` and return the `storage`
  /// node.
  ///
  /// - Returns: The storage node with all macro-synthesized accessors applied.
  private func expandAccessors(of storage: some DeclSyntaxProtocol, existingAccessors: AccessorBlockSyntax?) -> AccessorBlockSyntax? {
    let accessorMacros = macroAttributes(attachedTo: DeclSyntax(storage), ofType: AccessorMacro.Type.self)

    var newAccessorsBlock = existingAccessors

    for macro in accessorMacros {
      do {
        // Accessor macros get expanded differently depending on whether the
        // variable already had an accessor. If not, '{' and '}' to wrap the
        // accessor block are added. If an accessor block already exists, only
        // the new accessors are returned.
        // We need to parse the result from the macro invocation differently
        // based on these cases.
        if existingAccessors != nil {
          if let newAccessors = try expandAccessorMacroWithExistingAccessors(
            definition: macro.definition,
            attributeNode: macro.attributeNode,
            attachedTo: DeclSyntax(storage),
            in: context,
            indentationWidth: indentationWidth
          ) {
            // If existingAccessors is not `nil`, then we also set
            // `newAccessorBlock` above to a a non-nil value, so
            // `newAccessorsBlock` also isn’t `nil`.
            newAccessorsBlock = newAccessorsBlock!.addingAccessors(
              from: newAccessors,
              indentationWidth: self.indentationWidth
            )
          }
        } else {
          let newAccessors = try expandAccessorMacroWithoutExistingAccessors(
            definition: macro.definition,
            attributeNode: macro.attributeNode,
            attachedTo: DeclSyntax(storage),
            in: context,
            indentationWidth: indentationWidth
          )
          if newAccessorsBlock == nil {
            newAccessorsBlock = newAccessors
          } else if let newAccessors = newAccessors {
            guard case .accessors(let accessorList) = newAccessors.accessors else {
              throw MacroApplicationError.malformedAccessor
            }
            newAccessorsBlock = newAccessorsBlock!.addingAccessors(
              from: accessorList,
              indentationWidth: self.indentationWidth
            )
          }
        }
      } catch {
        context.addDiagnostics(from: error, node: macro.attributeNode)
      }
    }
    return newAccessorsBlock
  }
}

// MARK: Freestanding macro expansion

extension MacroApplication {
  private func expandFreestandingMacro<ExpandedMacroType: SyntaxProtocol>(
    _ node: (any FreestandingMacroExpansionSyntax)?,
    expandMacro: (_ macro: Macro.Type, _ node: any FreestandingMacroExpansionSyntax) throws -> ExpandedMacroType?
  ) -> ExpandedMacroType? {
    guard let node,
      let macro = macroSystem.lookup(node.macro.text)
    else {
      return nil
    }
    do {
      return try expandMacro(macro, node)
    } catch {
      context.addDiagnostics(from: error, node: node)
      return nil
    }
  }

  /// Expand a freestanding macro expansion syntax in a code block item position.
  ///
  /// For example
  /// ```swift
  /// function test() {
  ///   #foo
  /// }
  /// ```
  func expandCodeBlockItem(node: CodeBlockItemSyntax) -> CodeBlockItemListSyntax? {
    return expandFreestandingMacro(node.item.asProtocol(FreestandingMacroExpansionSyntax.self)) { macro, node in
      return try expandFreestandingCodeItemList(
        definition: macro,
        node: node,
        in: context,
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand a freestanding macro expansion syntax in a member decl position.
  ///
  /// For exmple
  /// ```swift
  /// struct S {
  ///   #foo
  /// }
  /// ```
  func expandMemberDecl(node: MemberBlockItemSyntax) -> MemberBlockItemListSyntax? {
    return expandFreestandingMacro(node.decl.as(MacroExpansionDeclSyntax.self)) { macro, node in
      return try expandFreestandingMemberDeclList(
        definition: macro,
        node: node,
        in: context,
        indentationWidth: indentationWidth
      )
    }
  }

  /// Expand a freestanding macro expansion in a expression position inside
  /// other products.
  ///
  /// For example
  /// ```swift
  /// let a = #foo
  /// ```
  func expandExpr(node: Syntax) -> ExprSyntax? {
    return expandFreestandingMacro(node.as(MacroExpansionExprSyntax.self)) { macro, node in
      return try expandFreestandingExpr(
        definition: macro,
        node: node,
        in: context,
        indentationWidth: indentationWidth
      )
    }
  }
}

// MARK: Syntax utilities

private extension AccessorBlockSyntax {
  /// Create a new `AccessorBlockSyntax` by adding the given accessors.
  ///
  /// If this `AccessorBlockSyntax` contains a single code block as a getter,
  /// that code block will be converted to an explicit 'get' accessor. This
  /// causes the body to be indented by `indentationWidth`.
  func addingAccessors(
    from newAccessors: AccessorDeclListSyntax,
    indentationWidth: Trivia
  ) -> AccessorBlockSyntax {
    var result = self
    switch self.accessors {
    case .accessors(let accessors):
      result.accessors = .accessors(accessors + Array(newAccessors))
    case .getter(let getter):
      if newAccessors.isEmpty {
        return self
      }
      // Convert the existing getter into an explicit accessor (with 'get') so
      // we can add more accessors.
      let baseIndentation = getter.indentationOfFirstLine
      let getterAsAccessor = AccessorDeclSyntax(
        accessorSpecifier: .keyword(.get, leadingTrivia: .newline + baseIndentation, trailingTrivia: .space),
        body: CodeBlockSyntax(
          leftBrace: .leftBraceToken(),
          statements: Indenter.indent(getter, indentation: indentationWidth),
          rightBrace: .rightBraceToken(leadingTrivia: .newline + baseIndentation)
        )
      )
      result.accessors = .accessors(AccessorDeclListSyntax([getterAsAccessor] + Array(newAccessors)))
    }
    return result
  }
}

private extension String {
  /// Add any trivia from `node` before/after this string.
  ///
  /// We need to do this because we are replacing the entire macro expansion
  /// declaration / expression with the expanded source but semantically, the
  /// user should think about it as just replacing the `#...` expression without
  /// any trivia.
  func wrappingInTrivia(from node: some SyntaxProtocol) -> String {
    // We need to remove the indentation from the last line because the macro
    // expansion buffer already contains the indentation.
    return node.leadingTrivia.removingIndentationOnLastLine.description
      + self
      + node.trailingTrivia.description
  }
}

private extension SyntaxProtocol {
  /// Detach the current node and inform the macro expansion context,
  /// if it needs to know.
  func detach(in context: MacroExpansionContext) -> Self {
    if let basicContext = context as? BasicMacroExpansionContext {
      return basicContext.detach(self)
    }

    return self.detached
  }
}
