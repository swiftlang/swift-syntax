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
  private func resolveMacro(moduleName: String, typeName: String) -> Macro.Type? {
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
    let syntax = sourceManager.add(expandingSyntax)

    let context = PluginMacroExpansionContext(
      sourceManager: sourceManager,
      expansionDiscriminator: discriminator
    )

    let expandedSource: String
    do {
      guard let macroSyntax = syntax.asProtocol(FreestandingMacroExpansionSyntax.self) else {
        throw MacroExpansionError.freestandingMacroSyntaxIsNotMacro
      }
      guard let macroDefinition = resolveMacro(macro) else {
        throw MacroExpansionError.macroTypeNotFound
      }

      switch macroDefinition {
      case let exprMacroDef as ExpressionMacro.Type:
        func _expand<Node: FreestandingMacroExpansionSyntax>(node: Node) throws -> ExprSyntax {
          try exprMacroDef.expansion(of: node, in: context)
        }
        let rewritten = try _openExistential(macroSyntax, do: _expand)
        expandedSource = rewritten.description

      case let declMacroDef as DeclarationMacro.Type:
        func _expand<Node: FreestandingMacroExpansionSyntax>(node: Node) throws -> [DeclSyntax] {
          try declMacroDef.expansion(of: node, in: context)
        }
        let rewritten = try _openExistential(macroSyntax, do: _expand)
        expandedSource = CodeBlockItemListSyntax(rewritten.map { CodeBlockItemSyntax(item: .decl($0)) }).description

      default:
        throw MacroExpansionError.unmathedMacroRole
      }
    } catch {
      let diagMessage: DiagnosticMessage
      if let message = error as? DiagnosticMessage, message.severity == .error {
        diagMessage = message
      } else {
        diagMessage = ThrownErrorDiagnostic(message: String(describing: error))
      }
      expandedSource = ""
      context.diagnose(Diagnostic(node: syntax, message: diagMessage))
    }

    let diagnostics = context.diagnostics.map {
      PluginMessage.Diagnostic(from: $0, in: sourceManager)
    }
    try pluginHostConnection.sendMessage(
      .expandFreestandingMacroResult(expandedSource: expandedSource, diagnostics: diagnostics)
    )
  }

  /// Expand `@attached(XXX)` macros.
  func expandAttachedMacro(
    macro: PluginMessage.MacroReference,
    macroRole: PluginMessage.MacroRole,
    discriminator: String,
    attributeSyntax: PluginMessage.Syntax,
    declSyntax: PluginMessage.Syntax,
    parentDeclSyntax: PluginMessage.Syntax?
  ) throws {
    let sourceManager = SourceManager()
    let context = PluginMacroExpansionContext(
      sourceManager: sourceManager,
      expansionDiscriminator: discriminator
    )

    let attributeNode = sourceManager.add(attributeSyntax).cast(AttributeSyntax.self)
    let declarationNode = sourceManager.add(declSyntax).cast(DeclSyntax.self)

    let expandedSources: [String]
    do {
      guard let macroDefinition = resolveMacro(macro) else {
        throw MacroExpansionError.macroTypeNotFound
      }

      switch (macroDefinition, macroRole) {
      case (let attachedMacro as AccessorMacro.Type, .accessor):
        let accessors = try attachedMacro.expansion(
          of: attributeNode,
          providingAccessorsOf: declarationNode,
          in: context
        )
        expandedSources = accessors.map {
          $0.trimmedDescription
        }

      case (let attachedMacro as MemberAttributeMacro.Type, .memberAttribute):
        guard
          let parentDeclSyntax = parentDeclSyntax,
          let parentDeclGroup = sourceManager.add(parentDeclSyntax).asProtocol(DeclGroupSyntax.self)
        else {
          // Compiler error: 'parentDecl' is mandatory for MemberAttributeMacro.
          throw MacroExpansionError.invalidExpansionMessage
        }

        // Local function to expand a member atribute macro once we've opened up
        // the existential.
        func expandMemberAttributeMacro<Node: DeclGroupSyntax>(
          _ node: Node
        ) throws -> [AttributeSyntax] {
          return try attachedMacro.expansion(
            of: attributeNode,
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
        expandedSources = attributes.map {
          $0.trimmedDescription
        }

      case (let attachedMacro as MemberMacro.Type, .member):
        guard let declGroup = declarationNode.asProtocol(DeclGroupSyntax.self)
        else {
          // Compiler error: declNode for member macro must be DeclGroupSyntax.
          throw MacroExpansionError.invalidExpansionMessage
        }

        // Local function to expand a member macro once we've opened up
        // the existential.
        func expandMemberMacro<Node: DeclGroupSyntax>(
          _ node: Node
        ) throws -> [DeclSyntax] {
          return try attachedMacro.expansion(
            of: attributeNode,
            providingMembersOf: node,
            in: context
          )
        }

        let members = try _openExistential(declGroup, do: expandMemberMacro)

        // Form a buffer of member declarations to return to the caller.
        expandedSources = members.map { $0.trimmedDescription }

      case (let attachedMacro as PeerMacro.Type, .peer):
        let peers = try attachedMacro.expansion(
          of: attributeNode,
          providingPeersOf: declarationNode,
          in: context
        )

        // Form a buffer of peer declarations to return to the caller.
        expandedSources = peers.map {
          $0.trimmedDescription
        }

      case (let attachedMacro as ConformanceMacro.Type, .conformance):
        guard
          let declGroup = declarationNode.asProtocol(DeclGroupSyntax.self),
          let identified = declarationNode.asProtocol(IdentifiedDeclSyntax.self)
        else {
          // Compiler error: type mismatch.
          throw MacroExpansionError.invalidExpansionMessage
        }

        // Local function to expand a conformance macro once we've opened up
        // the existential.
        func expandConformanceMacro<Node: DeclGroupSyntax>(
          _ node: Node
        ) throws -> [(TypeSyntax, GenericWhereClauseSyntax?)] {
          return try attachedMacro.expansion(
            of: attributeNode,
            providingConformancesOf: node,
            in: context
          )
        }

        let conformances = try _openExistential(
          declGroup,
          do: expandConformanceMacro
        )

        // Form a buffer of extension declarations to return to the caller.
        expandedSources = conformances.map { typeSyntax, whereClause in
          let typeName = identified.identifier.trimmedDescription
          let protocolName = typeSyntax.trimmedDescription
          let whereClause = whereClause?.trimmedDescription ?? ""
          return "extension \(typeName) : \(protocolName) \(whereClause) {}"
        }

      default:
        throw MacroExpansionError.unmathedMacroRole
      }
    } catch {
      let diagMessage: DiagnosticMessage
      if let message = error as? DiagnosticMessage, message.severity == .error {
        diagMessage = message
      } else {
        diagMessage = ThrownErrorDiagnostic(message: String(describing: error))
      }
      expandedSources = []
      context.diagnose(Diagnostic(node: Syntax(attributeNode), message: diagMessage))
    }

    let diagnostics = context.diagnostics.map {
      PluginMessage.Diagnostic(from: $0, in: sourceManager)
    }
    try pluginHostConnection.sendMessage(
      .expandAttachedMacroResult(expandedSources: expandedSources, diagnostics: diagnostics)
    )
  }
}

extension CompilerPlugin {
  // @testable
  public func _resolveMacro(moduleName: String, typeName: String) -> Macro.Type? {
    resolveMacro(moduleName: moduleName, typeName: typeName)
  }
}

/// Diagnostic message used for thrown errors.
fileprivate struct ThrownErrorDiagnostic: DiagnosticMessage {
  let message: String

  var severity: DiagnosticSeverity { .error }

  var diagnosticID: MessageID {
    .init(domain: "SwiftSyntaxMacros", id: "ThrownErrorDiagnostic")
  }
}
