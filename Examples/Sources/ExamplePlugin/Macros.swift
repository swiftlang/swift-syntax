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
    guard let cls = declaration.as(ClassDeclSyntax.self) else {
      return []
    }
    let className = cls.identifier.trimmedDescription
    return [
      """
      static var __metadata__: [String: String] { ["name": "\(raw: className)"] }
      """
    ]
  }
}
