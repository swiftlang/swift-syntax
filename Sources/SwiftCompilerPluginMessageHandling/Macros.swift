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

import SwiftBasicFormat
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxMacroExpansion

extension CompilerPluginMessageHandler {
  /// Get concrete macro type from a pair of module name and type name.
  private func resolveMacro(_ ref: PluginMessage.MacroReference) -> Macro.Type? {
    provider.resolveMacro(moduleName: ref.moduleName, typeName: ref.typeName)
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

    let expandedSource: String?
    do {
      guard let macroSyntax = syntax.asProtocol(FreestandingMacroExpansionSyntax.self) else {
        throw MacroExpansionError.freestandingMacroSyntaxIsNotMacro
      }
      guard let macroDefinition = resolveMacro(macro) else {
        throw MacroExpansionError.macroTypeNotFound
      }

      expandedSource = SwiftSyntaxMacroExpansion.expandFreestandingMacro(
        definition: macroDefinition,
        node: macroSyntax,
        in: context
      )
    } catch {
      context.addDiagnostics(from: error, node: syntax)
      expandedSource = nil
    }

    let diagnostics = context.diagnostics.map {
      PluginMessage.Diagnostic(from: $0, in: sourceManager)
    }
    try self.sendMessage(
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
    let parentDeclNode = parentDeclSyntax.map { sourceManager.add($0).cast(DeclSyntax.self) }

    let expandedSources: [String]?
    do {
      guard let macroDefinition = resolveMacro(macro) else {
        throw MacroExpansionError.macroTypeNotFound
      }

      expandedSources = SwiftSyntaxMacroExpansion.expandAttachedMacro(
        definition: macroDefinition,
        macroRole: MacroRole(messageMacroRole: macroRole),
        attributeNode: attributeNode,
        declarationNode: declarationNode,
        parentDeclNode: parentDeclNode,
        in: context
      )
    } catch {
      context.addDiagnostics(from: error, node: attributeNode)
      expandedSources = nil
    }

    let diagnostics = context.diagnostics.map {
      PluginMessage.Diagnostic(from: $0, in: sourceManager)
    }
    try self.sendMessage(
      .expandAttachedMacroResult(expandedSources: expandedSources, diagnostics: diagnostics)
    )
  }
}

private extension MacroRole {
  init(messageMacroRole: PluginMessage.MacroRole) {
    switch messageMacroRole {
    case .expression: self = .expression
    case .declaration: self = .declaration
    case .accessor: self = .accessor
    case .memberAttribute: self = .memberAttribute
    case .member: self = .member
    case .peer: self = .peer
    case .conformance: self = .conformance
    case .codeItem: self = .codeItem
    }
  }
}
