//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

/// Implementation for `CompilerPlugin` macro related request processing.
extension CompilerPlugin {
  public  // @testable
    func resolveMacro(moduleName: String, typeName: String) -> Macro.Type?
  {
    let qualifedName = "\(moduleName).\(typeName)"

    for type in self.providingMacros {
      // FIXME: Is `String(reflecting:)` stable?
      // Getting the module name and type name should be more robust.
      let name = String(reflecting: type)
      if name == qualifedName {
        return type
      }
    }
    return nil
  }

  /// Get concrete macro type from a pair of module name and type name.
  private func resolveMacro(_ ref: PluginMessage.MacroReference) -> Macro.Type? {
    resolveMacro(moduleName: ref.moduleName, typeName: ref.typeName)
  }

  /// Expand `@freestainding(XXX)` macros.
  func expandFreestandingMacro(
    macro: PluginMessage.MacroReference,
    discriminator: String,
    expandingSyntax: PluginMessage.Syntax
  ) throws {
    let sourceManager = SourceManager()
    let context = PluginMacroExpansionContext(
      sourceManager: sourceManager,
      discriminator: discriminator
    )

    let syntax = sourceManager.add(expandingSyntax)
    guard let macroSyntax = syntax.asProtocol(FreestandingMacroExpansionSyntax.self) else {
      let diag = PluginMessage.Diagnostic(
        from: .init(node: syntax, message: MacroExpansionError.freestandingMacroSyntaxIsNotMacro),
        in: sourceManager
      )
      try pluginHostConnection.sendMessage(
        .expandFreestandingMacroResult(
          expandedSource: "",
          diagnostics: [diag]
        )
      )
      return
    }

    let macroDef = self.resolveMacro(macro)
    ///
    if let exprMacroDef = macroDef as? ExpressionMacro.Type {
      let rewritten = try exprMacroDef.expansion(of: macroSyntax, in: context)
      let diagnostics = context.diagnostics.map {
        PluginMessage.Diagnostic(from: $0, in: sourceManager)
      }

      let resultMessage = PluginToHostMessage.expandFreestandingMacroResult(
        expandedSource: rewritten.description,
        diagnostics: diagnostics
      )

      try pluginHostConnection.sendMessage(resultMessage)
      return
    }

    if let declMacroDef = macroDef as? DeclarationMacro.Type {
      let rewritten = try declMacroDef.expansion(of: macroSyntax, in: context)
      let diagnostics = context.diagnostics.map {
        PluginMessage.Diagnostic(from: $0, in: sourceManager)
      }

      let resultMessage = PluginToHostMessage.expandFreestandingMacroResult(
        expandedSource: rewritten.description,
        diagnostics: diagnostics
      )

      try pluginHostConnection.sendMessage(resultMessage)
      return
    }

    let diag = PluginMessage.Diagnostic(
      from: Diagnostic(node: syntax, message: MacroExpansionError.macroTypeNotFound),
      in: sourceManager
    )

    try pluginHostConnection.sendMessage(
      .expandFreestandingMacroResult(expandedSource: "", diagnostics: [diag])
    )
  }

  /// Expand `@attached(XXX)` macros.
  func expandAttachedMacro(
    macro: PluginMessage.MacroReference,
    macroRole: PluginMessage.MacroRole,
    discriminator: String,
    customAttributeSyntax: PluginMessage.Syntax,
    declSyntax: PluginMessage.Syntax,
    parentDeclSyntax: PluginMessage.Syntax?
  ) throws {
    let sourceManager = SourceManager()
    let context = PluginMacroExpansionContext(
      sourceManager: sourceManager,
      discriminator: discriminator
    )

    guard let macroDefinition = resolveMacro(macro) else {
      fatalError("macro type not found: \(macro.moduleName).\(macro.typeName)")
    }

    let customAttributeNode = sourceManager.add(customAttributeSyntax).cast(AttributeSyntax.self)
    let declarationNode = sourceManager.add(declSyntax).cast(DeclSyntax.self)

    let expanded: [String]
    switch (macroDefinition, macroRole) {
    case (let attachedMacro as AccessorMacro.Type, .accessor):
      let accessors = try attachedMacro.expansion(
        of: customAttributeNode,
        providingAccessorsOf: declarationNode,
        in: context
      )
      expanded =
        accessors
        .map { $0.trimmedDescription }

    case (let attachedMacro as MemberAttributeMacro.Type, .memberAttribute):
      guard
        let parentDeclSyntax = parentDeclSyntax,
        let parentDeclGroup = sourceManager.add(parentDeclSyntax).asProtocol(DeclGroupSyntax.self)
      else {
        fatalError("parentDecl is mandatory for MemberAttributeMacro")
      }

      // Local function to expand a member atribute macro once we've opened up
      // the existential.
      func expandMemberAttributeMacro<Node: DeclGroupSyntax>(
        _ node: Node
      ) throws -> [AttributeSyntax] {
        return try attachedMacro.expansion(
          of: customAttributeNode,
          attachedTo: node,
          providingAttributesFor: declarationNode,
          in: context
        )
      }

      let attributes = try _openExistential(
        parentDeclGroup,
        do: expandMemberAttributeMacro
      )
      // Form a buffer containing an attribute list to return to the caller.
      expanded =
        attributes
        .map { $0.trimmedDescription }

    case (let attachedMacro as MemberMacro.Type, .member):
      guard let declGroup = declarationNode.asProtocol(DeclGroupSyntax.self)
      else {
        fatalError("declNode for member macro must be DeclGroupSyntax")
      }

      // Local function to expand a member macro once we've opened up
      // the existential.
      func expandMemberMacro<Node: DeclGroupSyntax>(
        _ node: Node
      ) throws -> [DeclSyntax] {
        return try attachedMacro.expansion(
          of: customAttributeNode,
          providingMembersOf: node,
          in: context
        )
      }

      let members = try _openExistential(declGroup, do: expandMemberMacro)

      // Form a buffer of member declarations to return to the caller.
      expanded =
        members
        .map { $0.trimmedDescription }

    case (let attachedMacro as PeerMacro.Type, .peer):
      let peers = try attachedMacro.expansion(
        of: customAttributeNode,
        providingPeersOf: declarationNode,
        in: context
      )

      // Form a buffer of peer declarations to return to the caller.
      expanded =
        peers
        .map { $0.trimmedDescription }

    case (let attachedMacro as ConformanceMacro.Type, .conformance):
      guard
        let declGroup = declarationNode.asProtocol(DeclGroupSyntax.self),
        let identified = declarationNode.asProtocol(IdentifiedDeclSyntax.self)
      else {
        fatalError("type mismatch")
      }

      // Local function to expand a conformance macro once we've opened up
      // the existential.
      func expandConformanceMacro<Node: DeclGroupSyntax>(
        _ node: Node
      ) throws -> [(TypeSyntax, GenericWhereClauseSyntax?)] {
        return try attachedMacro.expansion(
          of: customAttributeNode,
          providingConformancesOf: node,
          in: context
        )
      }

      let conformances = try _openExistential(
        declGroup,
        do: expandConformanceMacro
      )

      // Form a buffer of extension declarations to return to the caller.
      expanded = conformances.map { typeSyntax, whereClause in
        let typeName = identified.identifier.trimmedDescription
        let protocolName = typeSyntax.trimmedDescription
        let whereClause = whereClause?.trimmedDescription ?? ""
        return "extension \(typeName) : \(protocolName) \(whereClause) {}"
      }

    default:
      fatalError("\(macroDefinition) does not conform to any known attached macro protocol")
    }

    let diagnostics = context.diagnostics.map {
      PluginMessage.Diagnostic(from: $0, in: sourceManager)
    }
    try pluginHostConnection.sendMessage(
      .expandAttachedMacroResult(expandedSources: expanded, diagnostics: diagnostics)
    )
  }
}
