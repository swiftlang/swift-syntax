import SwiftSyntax
import SwiftSyntaxMacros

public enum MacroRole {
  case expression
  case declaration
  case accessor
  case memberAttribute
  case member
  case peer
  case conformance
  case codeItem
}

/// Simple diagnostic message
private struct MacroExpansionError: Error, CustomStringConvertible {
  let description: String
}

/// Expand `@freestanding(XXX)` macros.
public func expandFreestandingMacro(
  definition: Macro.Type,
  node: FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext
) -> String? {
  do {
    func _expand(node: some FreestandingMacroExpansionSyntax) throws -> String {
      let expandedSyntax: Syntax
      switch definition {
      case let exprMacroDef as ExpressionMacro.Type:
        expandedSyntax = try Syntax(exprMacroDef.expansion(of: node, in: context))

      case let declMacroDef as DeclarationMacro.Type:
        let rewritten = try declMacroDef.expansion(of: node, in: context)
        expandedSyntax = Syntax(
          CodeBlockItemListSyntax(
            rewritten.map {
              CodeBlockItemSyntax(item: .decl($0))
            }
          )
        )

      case let codeItemMacroDef as CodeItemMacro.Type:
        let rewritten = try codeItemMacroDef.expansion(of: node, in: context)
        expandedSyntax = Syntax(CodeBlockItemListSyntax(rewritten))

      default:
        throw MacroExpansionError(description: "macro doesn't conform to required macro role")
      }
      return expandedSyntax.formattedExpansion(definition.formatMode)
    }
    return try _openExistential(node, do: _expand)
  } catch {
    context.addDiagnostics(from: error, node: node)
    return nil
  }
}

/// Expand `@attached(XXX)` macros.
public func expandAttachedMacro<Context: MacroExpansionContext>(
  definition: Macro.Type,
  macroRole: MacroRole,
  attributeNode: AttributeSyntax,
  declarationNode: DeclSyntax,
  parentDeclNode: DeclSyntax?,
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
        throw MacroExpansionError(description: "parent decl group is nil")
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
        throw MacroExpansionError(description: "declaration is not a decl group syntax")
      }

      // Local function to expand a member macro once we've opened up
      // the existential.
      func expandMemberMacro(
        _ node: some DeclGroupSyntax
      ) throws -> [DeclSyntax] {
        return try attachedMacro.expansion(
          of: attributeNode,
          providingMembersOf: node,
          in: context
        )
      }

      let members = try _openExistential(declGroup, do: expandMemberMacro)

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

    case (let attachedMacro as ConformanceMacro.Type, .conformance):
      guard
        let declGroup = declarationNode.asProtocol(DeclGroupSyntax.self),
        let identified = declarationNode.asProtocol(IdentifiedDeclSyntax.self)
      else {
        // Compiler error: type mismatch.
        throw MacroExpansionError(description: "declaration is not a identified decl group")
      }

      // Local function to expand a conformance macro once we've opened up
      // the existential.
      func expandConformanceMacro(
        _ node: some DeclGroupSyntax
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
      return conformances.map { typeSyntax, whereClause in
        let typeName = identified.identifier.trimmedDescription
        let protocolName = typeSyntax.trimmedDescription
        let whereClause = whereClause?.trimmedDescription ?? ""
        return "extension \(typeName) : \(protocolName) \(whereClause) {}"
      }

    default:
      throw MacroExpansionError(description: "macro doesn't conform to required macro role")
    }
  } catch {
    context.addDiagnostics(from: error, node: attributeNode)
    return nil
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
