import SwiftSyntax
import SwiftSyntaxBuilder

// Macros used for testing purposes
struct LineMacro: ExpressionMacro {
  static var name: String { "myLine" }

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let line = macro.startLocation(
      converter: context.sourceLocationConverter
    ).line ?? 0
    return .init("\(line)")
  }
}

struct Stringify: ExpressionMacro {
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
  public static var exampleSystem: MacroSystem {
    var macroSystem = MacroSystem()
    try! macroSystem.add(LineMacro.self)
    try! macroSystem.add(Stringify.self)
    return macroSystem
  }
}
