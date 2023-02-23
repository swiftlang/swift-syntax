import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ThePlugin: CompilerPlugin {
  var providingMacros: [Macro.Type] = [
    EchoExpressionMacro.self,
    MetadataMacro.self,
  ]
}
