import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Returns the first argument prepending a comment '/* echo */'.
struct EchoExpressionMacro: ExpressionMacro {
  static func expansion<
    Node: FreestandingMacroExpansionSyntax,
    Context: MacroExpansionContext
  >(
    of node: Node,
    in context: Context
  ) throws -> ExprSyntax {
    let expr: ExprSyntax = node.argumentList.first!.expression
    return expr.with(\.leadingTrivia, [.blockComment("/* echo */")])
  }
}

/// Func With unique name.
struct FuncUniqueMacro: DeclarationMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    let name = context.makeUniqueName("unique")
    return ["func \(name)() {}"]
  }
}

/// Add a static property `__metadata__`.
struct MetadataMacro: MemberMacro {
  static func expansion<
    Declaration: DeclGroupSyntax,
    Context: MacroExpansionContext
  >(
    of node: SwiftSyntax.AttributeSyntax,
    providingMembersOf declaration: Declaration,
    in context: Context
  ) throws -> [DeclSyntax] {
    guard let type = declaration.asProtocol(IdentifiedDeclSyntax.self) else {
      return []
    }
    let typeName = type.identifier.trimmedDescription
    return [
      """
      static var __metadata__: [String: String] { ["name": "\(raw: typeName)"] }
      """
    ]
  }
}

/// Peer 'var' with the name suffixed with '_peer'.
struct PeerValueWithSuffixNameMacro: PeerMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingPeersOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let identified = declaration.asProtocol(IdentifiedDeclSyntax.self) else {
      return []
    }
    return ["var \(raw: identified.identifier.text)_peer: Int { 1 }"]
  }
}

/// Add '@available(*, deprecated)' to members.
struct MemberDeprecatedMacro: MemberAttributeMacro {
  static func expansion(
    of node: SwiftSyntax.AttributeSyntax,
    attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
    providingAttributesFor member: some SwiftSyntax.DeclSyntaxProtocol,
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.AttributeSyntax] {
    return ["@available(*, deprecated)"]
  }
}

/// Add 'Equatable' conformance.
struct EquatableConformanceMacro: ConformanceMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingConformancesOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [(TypeSyntax, GenericWhereClauseSyntax?)] {
    return [("Equatable", nil)]
  }
}

public struct SendableExtensionMacro: ExtensionMacro {
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    if protocols.isEmpty {
      return []
    }

    let sendableExtension: DeclSyntax =
      """
      extension \(type.trimmed): Sendable {}
      """

    guard let extensionDecl = sendableExtension.as(ExtensionDeclSyntax.self) else {
      return []
    }

    return [extensionDecl]
  }
}

/// Add 'didSet' printing the new value.
struct DidSetPrintMacro: AccessorMacro {
  static func expansion(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AccessorDeclSyntax] {
    guard
      let identifier = declaration.as(VariableDeclSyntax.self)?.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier
    else {
      return []
    }

    return ["didSet { print(\(identifier)) }"]
  }
}

/// 'print(<arg>)'.
struct PrintAnyMacro: CodeItemMacro {
  static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [CodeBlockItemSyntax] {
    guard let expr = node.argumentList.first?.expression else {
      return []
    }
    return ["print(\(expr))"]
  }
}
