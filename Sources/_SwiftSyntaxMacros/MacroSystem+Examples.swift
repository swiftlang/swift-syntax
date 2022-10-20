import SwiftSyntax
import SwiftSyntaxBuilder

// Macros used for testing purposes
struct StringifyMacro: ExpressionMacro {
  static var name: String { "stringify" }

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    guard let argument = macro.argumentList.first?.expression else {
      // FIXME: Create a diagnostic for the missing argument?
      return MacroResult(ExprSyntax(macro))
    }

    return MacroResult("(\(argument), #\"\(argument)\"#)")
  }
}

extension MacroSystem {
  public static var exampleSystem: MacroSystem = {
    var macroSystem = builtinMacroSystem
    try! macroSystem.add(StringifyMacro.self)
    return macroSystem
  }()
}
