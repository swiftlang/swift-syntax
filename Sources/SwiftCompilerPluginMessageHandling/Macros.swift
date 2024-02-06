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
import SwiftOperators
import SwiftSyntax
@_spi(ExperimentalLanguageFeature) import SwiftSyntaxMacroExpansion
@_spi(ExperimentalLanguageFeature) import SwiftSyntaxMacros

extension CompilerPluginMessageHandler {
  /// Get concrete macro type from a pair of module name and type name.
  private func resolveMacro(_ ref: PluginMessage.MacroReference) throws -> Macro.Type {
    try provider.resolveMacro(moduleName: ref.moduleName, typeName: ref.typeName)
  }

  /// Resolve the lexical context
  private static func resolveLexicalContext(
    _ lexicalContext: [PluginMessage.Syntax]?,
    sourceManager: SourceManager,
    operatorTable: OperatorTable,
    fallbackSyntax: some SyntaxProtocol
  ) -> [Syntax] {
    // If we weren't provided with a lexical context, retrieve it from the
    // syntax node we were given. This is for dealing with older compilers.
    guard let lexicalContext else {
      return fallbackSyntax.allMacroLexicalContexts()
    }

    return lexicalContext.map { sourceManager.add($0, foldingWith: operatorTable) }
  }

  /// Expand `@freestainding(XXX)` macros.
  func expandFreestandingMacro(
    macro: PluginMessage.MacroReference,
    macroRole pluginMacroRole: PluginMessage.MacroRole?,
    discriminator: String,
    expandingSyntax: PluginMessage.Syntax,
    lexicalContext: [PluginMessage.Syntax]?
  ) throws {
    let sourceManager = SourceManager()
    let syntax = sourceManager.add(expandingSyntax, foldingWith: .standardOperators)

    let context = PluginMacroExpansionContext(
      sourceManager: sourceManager,
      lexicalContext: Self.resolveLexicalContext(
        lexicalContext,
        sourceManager: sourceManager,
        operatorTable: .standardOperators,
        fallbackSyntax: syntax
      ),
      expansionDiscriminator: discriminator
    )

    let expandedSource: String?
    do {
      guard let macroSyntax = syntax.asProtocol(FreestandingMacroExpansionSyntax.self) else {
        throw MacroExpansionError.freestandingMacroSyntaxIsNotMacro
      }
      let macroDefinition = try resolveMacro(macro)
      let macroRole: MacroRole
      if let pluginMacroRole {
        macroRole = MacroRole(messageMacroRole: pluginMacroRole)
      } else {
        macroRole = try inferFreestandingMacroRole(definition: macroDefinition)
      }

      expandedSource = SwiftSyntaxMacroExpansion.expandFreestandingMacro(
        definition: macroDefinition,
        macroRole: macroRole,
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

    let response: PluginToHostMessage
    if hostCapability.hasExpandMacroResult {
      response = .expandMacroResult(expandedSource: expandedSource, diagnostics: diagnostics)
    } else {
      // TODO: Remove this  when all compilers have 'hasExpandMacroResult'.
      response = .expandFreestandingMacroResult(expandedSource: expandedSource, diagnostics: diagnostics)
    }
    try self.sendMessage(response)
  }

  /// Expand `@attached(XXX)` macros.
  func expandAttachedMacro(
    macro: PluginMessage.MacroReference,
    macroRole: PluginMessage.MacroRole,
    discriminator: String,
    attributeSyntax: PluginMessage.Syntax,
    declSyntax: PluginMessage.Syntax,
    parentDeclSyntax: PluginMessage.Syntax?,
    extendedTypeSyntax: PluginMessage.Syntax?,
    conformanceListSyntax: PluginMessage.Syntax?,
    lexicalContext: [PluginMessage.Syntax]?
  ) throws {
    let sourceManager = SourceManager()
    let attributeNode = sourceManager.add(
      attributeSyntax,
      foldingWith: .standardOperators
    ).cast(AttributeSyntax.self)
    let declarationNode = sourceManager.add(declSyntax).cast(DeclSyntax.self)
    let parentDeclNode = parentDeclSyntax.map { sourceManager.add($0).cast(DeclSyntax.self) }
    let extendedType = extendedTypeSyntax.map {
      sourceManager.add($0).cast(TypeSyntax.self)
    }
    let conformanceList = conformanceListSyntax.map {
      let placeholderStruct = sourceManager.add($0).cast(StructDeclSyntax.self)
      return placeholderStruct.inheritanceClause!.inheritedTypes
    }

    let context = PluginMacroExpansionContext(
      sourceManager: sourceManager,
      lexicalContext: Self.resolveLexicalContext(
        lexicalContext,
        sourceManager: sourceManager,
        operatorTable: .standardOperators,
        fallbackSyntax: declarationNode
      ),
      expansionDiscriminator: discriminator
    )

    // TODO: Make this a 'String?' and remove non-'hasExpandMacroResult' branches.
    let expandedSources: [String]?
    do {
      let macroDefinition = try resolveMacro(macro)
      let role = MacroRole(messageMacroRole: macroRole)

      let expansions = SwiftSyntaxMacroExpansion.expandAttachedMacroWithoutCollapsing(
        definition: macroDefinition,
        macroRole: role,
        attributeNode: attributeNode,
        declarationNode: declarationNode,
        parentDeclNode: parentDeclNode,
        extendedType: extendedType,
        conformanceList: conformanceList,
        in: context
      )
      if let expansions, hostCapability.hasExpandMacroResult {
        // Make a single element array by collapsing the results into a string.
        expandedSources = [
          SwiftSyntaxMacroExpansion.collapse(
            expansions: expansions,
            for: role,
            attachedTo: declarationNode
          )
        ]
      } else {
        expandedSources = expansions
      }
    } catch {
      context.addDiagnostics(from: error, node: attributeNode)
      expandedSources = nil
    }

    let diagnostics = context.diagnostics.map {
      PluginMessage.Diagnostic(from: $0, in: sourceManager)
    }

    let response: PluginToHostMessage
    if hostCapability.hasExpandMacroResult {
      response = .expandMacroResult(expandedSource: expandedSources?.first, diagnostics: diagnostics)
    } else {
      response = .expandAttachedMacroResult(expandedSources: expandedSources, diagnostics: diagnostics)
    }
    try self.sendMessage(response)
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
    case .conformance: self = .extension
    case .codeItem: self = .codeItem
    case .extension: self = .extension
    case .preamble: self = .preamble
    case .body: self = .body
    }
  }
}
