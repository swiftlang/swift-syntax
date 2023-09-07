//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
@_spi(MacroExpansion) import SwiftSyntaxMacros

public enum MacroRole {
  case expression
  case declaration
  case accessor
  case memberAttribute
  case member
  case peer
  case conformance
  case codeItem
  case `extension`
}

extension MacroRole {
  var protocolName: String {
    switch self {
    case .expression: return "ExpressionMacro"
    case .declaration: return "DeclarationMacro"
    case .accessor: return "AccessorMacro"
    case .memberAttribute: return "MemberAttributeMacro"
    case .member: return "MemberMacro"
    case .peer: return "PeerMacro"
    case .conformance: return "ConformanceMacro"
    case .codeItem: return "CodeItemMacro"
    case .extension: return "ExtensionMacro"
    }
  }
}

/// Simple diagnostic message
private enum MacroExpansionError: Error, CustomStringConvertible {
  case unmatchedMacroRole(Macro.Type, MacroRole)
  case parentDeclGroupNil
  case declarationNotDeclGroup
  case declarationNotIdentified
  case noExtendedTypeSyntax
  case noFreestandingMacroRoles(Macro.Type)

  var description: String {
    switch self {
    case .unmatchedMacroRole(let type, let role):
      return "macro implementation type '\(type)' doesn't conform to required protocol '\(role.protocolName)'"

    case .parentDeclGroupNil:
      return "parent decl group is nil"

    case .declarationNotDeclGroup:
      return "declaration is not a decl group syntax"

    case .declarationNotIdentified:
      return "declaration is not a 'Identified' syntax"

    case .noExtendedTypeSyntax:
      return "no extended type for extension macro"

    case .noFreestandingMacroRoles(let type):
      return "macro implementation type '\(type)' does not conform to any freestanding macro protocol"

    }
  }
}

/// Expand `@freestanding(XXX)` macros.
///
/// - Parameters:
///   - definition: a type conforms to one of freestanding `Macro` protocol.
///   - macroRole: indicates which `Macro` protocol expansion should be performed
///   - node: macro expansion syntax node (e.g. `#macroName(argument)`).
///   - in: context of the expansion.
/// - Returns: expanded source text. Upon failure (i.e. `defintion.expansion()`
///   throws) returns `nil`, and the diagnostics representing the `Error` are
///   guaranteed to be added to context.
public func expandFreestandingMacro(
  definition: Macro.Type,
  macroRole: MacroRole,
  node: FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext
) -> String? {
  do {
    func _expand(node: some FreestandingMacroExpansionSyntax) throws -> String {
      let expandedSyntax: Syntax
      switch (macroRole, definition) {
      case (.expression, let exprMacroDef as ExpressionMacro.Type):
        expandedSyntax = try Syntax(exprMacroDef.expansion(of: node, in: context))

      case (.declaration, let declMacroDef as DeclarationMacro.Type):
        var rewritten = try declMacroDef.expansion(of: node, in: context)
        // Copy attributes and modifiers to the generated decls.
        if let expansionDecl = node.as(MacroExpansionDeclSyntax.self) {
          let attributes = declMacroDef.propagateFreestandingMacroAttributes ? expansionDecl.attributes : nil
          let modifiers = declMacroDef.propagateFreestandingMacroModifiers ? expansionDecl.modifiers : nil
          rewritten = rewritten.map {
            $0.applying(attributes: attributes, modifiers: modifiers)
          }
        }
        expandedSyntax = Syntax(
          CodeBlockItemListSyntax(
            rewritten.map {
              CodeBlockItemSyntax(item: .decl($0))
            }
          )
        )

      case (.codeItem, let codeItemMacroDef as CodeItemMacro.Type):
        let rewritten = try codeItemMacroDef.expansion(of: node, in: context)
        expandedSyntax = Syntax(CodeBlockItemListSyntax(rewritten))

      case (.accessor, _), (.memberAttribute, _), (.member, _), (.peer, _), (.conformance, _), (.extension, _), (.expression, _), (.declaration, _),
        (.codeItem, _):
        throw MacroExpansionError.unmatchedMacroRole(definition, macroRole)
      }
      return expandedSyntax.formattedExpansion(definition.formatMode)
    }
    return try _openExistential(node, do: _expand)
  } catch {
    context.addDiagnostics(from: error, node: node)
    return nil
  }
}

/// Try to infer the freestanding macro role from the type definition itself.
///
/// This is a workaround for older compilers with a newer plugin
public func inferFreestandingMacroRole(definition: Macro.Type) throws -> MacroRole {
  switch definition {
  case is ExpressionMacro.Type: return .expression
  case is DeclarationMacro.Type: return .declaration
  case is CodeItemMacro.Type: return .codeItem

  default:
    throw MacroExpansionError.noFreestandingMacroRoles(definition)
  }
}

@available(*, deprecated, message: "pass a macro role, please!")
public func expandFreestandingMacro(
  definition: Macro.Type,
  node: FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext
) -> String? {
  do {
    return expandFreestandingMacro(
      definition: definition,
      macroRole: try inferFreestandingMacroRole(definition: definition),
      node: node,
      in: context
    )
  } catch {
    context.addDiagnostics(from: error, node: node)
    return nil
  }
}

/// Expand `@attached(XXX)` macros.
///
/// - Parameters:
///   - definition: a type that conforms to one or more attached `Macro` protocols.
///   - macroRole: indicates which `Macro` protocol expansion should be performed
///   - attributeNode: attribute syntax node (e.g. `@macroName(argument)`).
///   - declarationNode: target declaration syntax node to apply the expansion.
///   - parentDeclNode: Only used for `MacroRole.memberAttribute`. The parent
///     context node of `declarationNode`.
///   - in: context of the expansion.
/// - Returns: A list of expanded source text. Upon failure (i.e.
///   `defintion.expansion()` throws) returns `nil`, and the diagnostics
///   representing the `Error` are guaranteed to be added to context.
public func expandAttachedMacroWithoutCollapsing<Context: MacroExpansionContext>(
  definition: Macro.Type,
  macroRole: MacroRole,
  attributeNode: AttributeSyntax,
  declarationNode: DeclSyntax,
  parentDeclNode: DeclSyntax?,
  extendedType: TypeSyntax?,
  conformanceList: InheritedTypeListSyntax?,
  in context: Context
) -> [String]? {
  do {
    switch (definition, macroRole) {
    case (let attachedMacro as AccessorMacro.Type, .accessor):
      let accessors = try attachedMacro.expansion(
        of: attributeNode,
        providingAccessorsOf: declarationNode,
        in: context
      )
      return accessors.map {
        $0.formattedExpansion(definition.formatMode)
      }

    case (let attachedMacro as MemberAttributeMacro.Type, .memberAttribute):
      guard
        let parentDeclGroup = parentDeclNode?.asProtocol(DeclGroupSyntax.self)
      else {
        // Compiler error: 'parentDecl' is mandatory for MemberAttributeMacro.
        throw MacroExpansionError.parentDeclGroupNil
      }

      // Local function to expand a member attribute macro once we've opened up
      // the existential.
      func expandMemberAttributeMacro(
        _ node: some DeclGroupSyntax
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
      return attributes.map {
        $0.formattedExpansion(definition.formatMode)
      }

    case (let attachedMacro as MemberMacro.Type, .member):
      guard let declGroup = declarationNode.asProtocol(DeclGroupSyntax.self)
      else {
        // Compiler error: declNode for member macro must be DeclGroupSyntax.
        throw MacroExpansionError.declarationNotDeclGroup
      }

      let members = try attachedMacro.expansion(
        of: attributeNode,
        providingMembersOf: declGroup,
        conformingTo: conformanceList?.map(\.typeName) ?? [],
        in: context
      )

      // Form a buffer of member declarations to return to the caller.
      return members.map { $0.formattedExpansion(definition.formatMode) }

    case (let attachedMacro as PeerMacro.Type, .peer):
      let peers = try attachedMacro.expansion(
        of: attributeNode,
        providingPeersOf: declarationNode,
        in: context
      )

      // Form a buffer of peer declarations to return to the caller.
      return peers.map {
        $0.formattedExpansion(definition.formatMode)
      }

    case (let attachedMacro as ExtensionMacro.Type, .extension):
      guard let declGroup = declarationNode.asProtocol(DeclGroupSyntax.self) else {
        // Compiler error: type mismatch.
        throw MacroExpansionError.declarationNotDeclGroup
      }

      let extensionOf: TypeSyntax
      if let extendedType {
        extensionOf = extendedType
      } else if let identified = declarationNode.asProtocol(IdentifiedDeclSyntax.self) {
        // Fallback for old compilers with a new plugin, where
        extensionOf = TypeSyntax(SimpleTypeIdentifierSyntax(name: identified.identifier))
      } else {
        throw MacroExpansionError.noExtendedTypeSyntax
      }

      let protocols = conformanceList?.map(\.typeName) ?? []

      // Local function to expand an extension macro once we've opened up
      // the existential.
      func expandExtensionMacro(
        _ node: some DeclGroupSyntax
      ) throws -> [ExtensionDeclSyntax] {
        return try attachedMacro.expansion(
          of: attributeNode,
          attachedTo: node,
          providingExtensionsOf: extensionOf,
          conformingTo: protocols,
          in: context
        )
      }

      let extensions = try _openExistential(
        declGroup,
        do: expandExtensionMacro
      )

      // Form a buffer of peer declarations to return to the caller.
      return extensions.map {
        $0.formattedExpansion(definition.formatMode)
      }

    default:
      throw MacroExpansionError.unmatchedMacroRole(definition, macroRole)
    }
  } catch {
    context.addDiagnostics(from: error, node: attributeNode)
    return nil
  }
}

/// Expand `@attached(XXX)` macros.
///
/// - Parameters:
///   - definition: a type that conforms to one or more attached `Macro` protocols.
///   - macroRole: indicates which `Macro` protocol expansion should be performed
///   - attributeNode: attribute syntax node (e.g. `@macroName(argument)`).
///   - declarationNode: target declaration syntax node to apply the expansion.
///   - parentDeclNode: Only used for `MacroRole.memberAttribute`. The parent
///     context node of `declarationNode`.
///   - in: context of the expansion.
/// - Returns: expanded source text. Upon failure (i.e. `defintion.expansion()`
///   throws) returns `nil`, and the diagnostics representing the `Error` are
///   guaranteed to be added to context.
public func expandAttachedMacro<Context: MacroExpansionContext>(
  definition: Macro.Type,
  macroRole: MacroRole,
  attributeNode: AttributeSyntax,
  declarationNode: DeclSyntax,
  parentDeclNode: DeclSyntax?,
  extendedType: TypeSyntax?,
  conformanceList: InheritedTypeListSyntax?,
  in context: Context
) -> String? {
  let expandedSources = expandAttachedMacroWithoutCollapsing(
    definition: definition,
    macroRole: macroRole,
    attributeNode: attributeNode,
    declarationNode: declarationNode,
    parentDeclNode: parentDeclNode,
    extendedType: extendedType,
    conformanceList: conformanceList,
    in: context
  )
  return expandedSources.map {
    collapse(expansions: $0, for: macroRole, attachedTo: declarationNode)
  }
}

fileprivate extension SyntaxProtocol {
  /// Perform a format if required and then trim any leading/trailing
  /// whitespace.
  func formattedExpansion(_ mode: FormatMode) -> String {
    let formatted: Syntax
    switch mode {
    case .auto:
      formatted = self.formatted()
    case .disabled:
      formatted = Syntax(self)
    }
    return formatted.trimmedDescription(matching: { $0.isWhitespace })
  }
}

/// Join `expansions`
public func collapse<Node: SyntaxProtocol>(
  expansions: [String],
  for role: MacroRole,
  attachedTo declarationNode: Node
) -> String {
  if expansions.isEmpty {
    return ""
  }

  var expansions = expansions
  var separator: String = "\n\n"

  if role == .accessor,
    let varDecl = declarationNode.as(VariableDeclSyntax.self),
    let binding = varDecl.bindings.first,
    binding.accessor == nil
  {
    let indentation = String(repeating: " ", count: 4)

    expansions = expansions.map({ indent($0, with: indentation) })
    expansions[0] = "{\n" + expansions[0]
    expansions[expansions.count - 1] += "\n}"
  } else if role == .memberAttribute {
    separator = " "
  }

  return expansions.joined(separator: separator)
}

fileprivate func indent(_ source: String, with indentation: String) -> String {
  if source.isEmpty || indentation.isEmpty {
    return source
  }

  var indented = ""
  var remaining = source[...]
  while let nextNewline = remaining.firstIndex(where: { $0.isNewline }) {
    if nextNewline != remaining.startIndex {
      indented += indentation
    }
    indented += remaining[...nextNewline]
    remaining = remaining[remaining.index(after: nextNewline)...]
  }

  if !remaining.isEmpty {
    indented += indentation
    indented += remaining
  }

  return indented
}
