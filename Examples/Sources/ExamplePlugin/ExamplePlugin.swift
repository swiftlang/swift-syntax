import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ThePlugin: CompilerPlugin {
  var providingMacros: [Macro.Type] = [
    EchoExpressionMacro.self,
    FuncUniqueMacro.self,
    MetadataMacro.self,
    PeerValueWithSuffixNameMacro.self,
    MemberDeprecatedMacro.self,
    EquatableConformanceMacro.self,
    SendableExtensionMacro.self,
    DidSetPrintMacro.self,
    PrintAnyMacro.self,
  ]
}
