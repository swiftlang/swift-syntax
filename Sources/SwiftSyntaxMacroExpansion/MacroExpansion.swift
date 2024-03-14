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

#if swift(>=6)
import SwiftBasicFormat
public import SwiftSyntax
@_spi(MacroExpansion) @_spi(ExperimentalLanguageFeature) public import SwiftSyntaxMacros
#else
import SwiftBasicFormat
import SwiftSyntax
@_spi(MacroExpansion) @_spi(ExperimentalLanguageFeature) import SwiftSyntaxMacros
#endif

public enum MacroRole: Sendable {
  case expression
  case declaration
  case accessor
  case memberAttribute
  case member
  case peer
  case conformance
  case codeItem
  case `extension`
  @_spi(ExperimentalLanguageFeature) case preamble
  @_spi(ExperimentalLanguageFeature) case body
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
    case .preamble: return "PreambleMacro"
    case .body: return "BodyMacro"
    }
  }
}

/// Simple diagnostic message
enum MacroExpansionError: Error, CustomStringConvertible {
  case unmatchedMacroRole(Macro.Type, MacroRole)
  case parentDeclGroupNil
  case declarationNotDeclGroup
  case declarationNotIdentified
  case declarationHasNoBody
  case noExtendedTypeSyntax
  case noFreestandingMacroRoles(Macro.Type)
  case moreThanOneBodyMacro
  case preambleWithoutBody

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

    case .declarationHasNoBody:
      return "declaration is not a type with an optional code block"

    case .noExtendedTypeSyntax:
      return "no extended type for extension macro"

    case .noFreestandingMacroRoles(let type):
      return "macro implementation type '\(type)' does not conform to any freestanding macro protocol"

    case .moreThanOneBodyMacro:
      return "function can not have more than one body macro applied to it"

    case .preambleWithoutBody:
      return "preamble macro cannot be applied to a function with no body"
    }
  }
}

/// Expand `@freestanding(XXX)` macros.
///
/// - Parameters:
///   - definition: a type conforms to one of freestanding `Macro` protocol.
///   - macroRole: indicates which `Macro` protocol expansion should be performed
///   - node: macro expansion syntax node (e.g. `#macroName(argument)`).
///   - context: context of the expansion.
///   - indentationWidth: The indentation that should be added for each additional
///     nesting level
/// - Returns: expanded source text. Upon failure (i.e. `definition.expansion()`
///   throws) returns `nil`, and the diagnostics representing the `Error` are
///   guaranteed to be added to context.
public func expandFreestandingMacro(
  definition: Macro.Type,
  macroRole: MacroRole,
  node: FreestandingMacroExpansionSyntax,
  in context: some MacroExpansionContext,
  indentationWidth: Trivia? = nil
) -> String? {
  do {
    let expandedSyntax: Syntax
    switch (macroRole, definition) {
    case (.expression, let exprMacroDef as ExpressionMacro.Type):
      expandedSyntax = try Syntax(exprMacroDef.expansion(of: node, in: context))

    case (.declaration, let declMacroDef as DeclarationMacro.Type):
      var rewritten = try declMacroDef.expansion(of: node, in: context)
      // Copy attributes and modifiers to the generated decls.
      if let expansionDecl = node.as(MacroExpansionDeclSyntax.self) {
        // Strip any indentation from the attributes and modifiers that we are
        // inheriting. The expanded macro should start at the leftmost column.
        let attributes = declMacroDef.propagateFreestandingMacroAttributes ? expansionDecl.attributes.withIndentationRemoved : nil
        let modifiers = declMacroDef.propagateFreestandingMacroModifiers ? expansionDecl.modifiers.withIndentationRemoved : nil
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
      (.codeItem, _), (.preamble, _), (.body, _):
      throw MacroExpansionError.unmatchedMacroRole(definition, macroRole)
    }
    return expandedSyntax.formattedExpansion(definition.formatMode, indentationWidth: indentationWidth)
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
///   - context: context of the expansion.
///   - indentationWidth: The indentation that should be added for each additional
///     nesting level
/// - Returns: A list of expanded source text. Upon failure (i.e.
///   `definition.expansion()` throws) returns `nil`, and the diagnostics
///   representing the `Error` are guaranteed to be added to context.
public func expandAttachedMacroWithoutCollapsing<Context: MacroExpansionContext>(
  definition: Macro.Type,
  macroRole: MacroRole,
  attributeNode: AttributeSyntax,
  declarationNode: DeclSyntax,
  parentDeclNode: DeclSyntax?,
  extendedType: TypeSyntax?,
  conformanceList: InheritedTypeListSyntax?,
  in context: Context,
  indentationWidth: Trivia? = nil
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
        $0.formattedExpansion(definition.formatMode, indentationWidth: indentationWidth)
      }

    case (let attachedMacro as MemberAttributeMacro.Type, .memberAttribute):
      guard
        let parentDeclGroup = parentDeclNode?.asProtocol(DeclGroupSyntax.self)
      else {
        // Compiler error: 'parentDecl' is mandatory for MemberAttributeMacro.
        throw MacroExpansionError.parentDeclGroupNil
      }

      let attributes = try attachedMacro.expansion(
        of: attributeNode,
        attachedTo: parentDeclGroup,
        providingAttributesFor: declarationNode,
        in: context
      )

      // Form a buffer containing an attribute list to return to the caller.
      return attributes.map {
        $0.formattedExpansion(definition.formatMode, indentationWidth: indentationWidth)
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
        conformingTo: conformanceList?.map(\.type) ?? [],
        in: context
      )

      // Form a buffer of member declarations to return to the caller.
      return members.map {
        $0.formattedExpansion(definition.formatMode, indentationWidth: indentationWidth)
      }

    case (let attachedMacro as PeerMacro.Type, .peer):
      let peers = try attachedMacro.expansion(
        of: attributeNode,
        providingPeersOf: declarationNode,
        in: context
      )

      // Form a buffer of peer declarations to return to the caller.
      return peers.map {
        $0.formattedExpansion(definition.formatMode, indentationWidth: indentationWidth)
      }

    case (let attachedMacro as ExtensionMacro.Type, .extension):
      guard let declGroup = declarationNode.asProtocol(DeclGroupSyntax.self) else {
        // Compiler error: type mismatch.
        throw MacroExpansionError.declarationNotDeclGroup
      }

      let extensionOf: TypeSyntax
      if let extendedType {
        extensionOf = extendedType
      } else if let identified = declarationNode.asProtocol(NamedDeclSyntax.self) {
        // Fallback for old compilers with a new plugin, where
        extensionOf = TypeSyntax(IdentifierTypeSyntax(name: identified.name))
      } else {
        throw MacroExpansionError.noExtendedTypeSyntax
      }

      let protocols = conformanceList?.map(\.type) ?? []

      let extensions = try attachedMacro.expansion(
        of: attributeNode,
        attachedTo: declGroup,
        providingExtensionsOf: extensionOf,
        conformingTo: protocols,
        in: context
      )

      // Form a buffer of peer declarations to return to the caller.
      return extensions.map {
        $0.formattedExpansion(definition.formatMode, indentationWidth: indentationWidth)
      }

    case (let attachedMacro as PreambleMacro.Type, .preamble):
      guard let declToPass = Syntax(declarationNode).asProtocol(SyntaxProtocol.self) as? (DeclSyntaxProtocol & WithOptionalCodeBlockSyntax)
      else {
        // Compiler error: declaration must have a body.
        throw MacroExpansionError.declarationHasNoBody
      }

      let preamble = try attachedMacro.expansion(
        of: attributeNode,
        providingPreambleFor: declToPass,
        in: context
      )
      return preamble.map {
        $0.formattedExpansion(definition.formatMode, indentationWidth: indentationWidth)
      }

    case (let attachedMacro as BodyMacro.Type, .body):
      guard let declToPass = Syntax(declarationNode).asProtocol(SyntaxProtocol.self) as? (DeclSyntaxProtocol & WithOptionalCodeBlockSyntax)
      else {
        // Compiler error: declaration must have a body.
        throw MacroExpansionError.declarationHasNoBody
      }

      let body = try attachedMacro.expansion(
        of: attributeNode,
        providingBodyFor: declToPass,
        in: context
      )
      return body.map {
        $0.formattedExpansion(definition.formatMode, indentationWidth: indentationWidth)
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
///   - context: context of the expansion.
///   - indentationWidth: The indentation that should be added for each additional
///     nesting level
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
  in context: Context,
  indentationWidth: Trivia? = nil
) -> String? {
  let expandedSources = expandAttachedMacroWithoutCollapsing(
    definition: definition,
    macroRole: macroRole,
    attributeNode: attributeNode,
    declarationNode: declarationNode,
    parentDeclNode: parentDeclNode,
    extendedType: extendedType,
    conformanceList: conformanceList,
    in: context,
    indentationWidth: indentationWidth
  )
  return expandedSources.map {
    collapse(expansions: $0, for: macroRole, attachedTo: declarationNode, indentationWidth: indentationWidth)
  }
}

fileprivate extension SyntaxProtocol {
  /// Perform a format if required and then trim any leading/trailing
  /// whitespace.
  func formattedExpansion(_ mode: FormatMode, indentationWidth: Trivia?) -> String {
    let formatted: Syntax
    switch mode {
    case .auto:
      formatted = self.formatted(using: BasicFormat(indentationWidth: indentationWidth))
    case .disabled:
      formatted = Syntax(self)
    #if RESILIENT_LIBRARIES
    @unknown default:
      fatalError()
    #endif
    }
    return formatted.trimmedDescription(matching: { $0.isWhitespace })
  }
}

fileprivate extension DeclSyntax {
  /// Returns this node with `attributes` and `modifiers` prepended to the
  /// node’s attributes and modifiers, respectively.
  ///
  /// If the node can’t have attributes or modifiers, `attributes` or `modifiers`
  /// are ignored and not applied.
  func applying(
    attributes: AttributeListSyntax?,
    modifiers: DeclModifierListSyntax?
  ) -> DeclSyntax {
    func _combine<C: SyntaxCollection>(_ left: C, _ right: C?) -> C {
      guard let right = right else { return left }
      var elems: [C.Element] = []
      elems += left
      elems += right
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

/// Join `expansions`
public func collapse<Node: SyntaxProtocol>(
  expansions: [String],
  for role: MacroRole,
  attachedTo declarationNode: Node,
  indentationWidth: Trivia? = nil
) -> String {
  if expansions.isEmpty {
    return ""
  }

  var expansions = expansions
  var separator = "\n\n"

  // Wrap the expansions in a set of braces.
  func wrapInBraces() {
    // Default to 4 spaces if no indentation was passed.
    // In the future, we could consider inferring the indentation width from
    // the expansions to collapse.
    expansions = expansions.map({ $0.indented(by: indentationWidth ?? .spaces(4)) })
    expansions[0] = "{\n" + expansions[0]
    expansions[expansions.count - 1] += "\n}"
    separator = "\n"
  }

  switch role {
  case .accessor:
    let onDeclarationWithoutAccessor: Bool
    if let varDecl = declarationNode.as(VariableDeclSyntax.self),
      let binding = varDecl.bindings.first,
      binding.accessorBlock == nil
    {
      onDeclarationWithoutAccessor = true
    } else if let subscriptDecl = declarationNode.as(SubscriptDeclSyntax.self),
      subscriptDecl.accessorBlock == nil
    {
      onDeclarationWithoutAccessor = true
    } else {
      onDeclarationWithoutAccessor = false
    }
    if onDeclarationWithoutAccessor {
      wrapInBraces()
    }
  case .memberAttribute:
    separator = " "

  case .body:
    wrapInBraces()

  case .preamble:
    // Only place a single newline between statements.
    separator = "\n"

  default:
    break
  }

  return expansions.joined(separator: separator)
}
