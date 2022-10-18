import SwiftSyntax
import SwiftSyntaxBuilder

// Macros used for testing purposes
struct LineMacro: ExpressionMacro {
  static var name: String { "line" }

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

struct ColorLiteral: ExpressionMacro {
  static var name: String { "myColorLiteral" }

  static func apply(
    _ macro: MacroExpansionExprSyntax, in context: MacroEvaluationContext
  ) -> MacroResult<ExprSyntax> {
    let initSyntax: ExprSyntax = ".init(\(macro.argumentList))"
    if let leadingTrivia = macro.leadingTrivia {
      return MacroResult(initSyntax.withLeadingTrivia(leadingTrivia))
    }
    return MacroResult(initSyntax)
  }
}

extension MacroSystem {
  public static var exampleSystem: MacroSystem {
    var macroSystem = MacroSystem()
    try! macroSystem.add(LineMacro.self)
    try! macroSystem.add(Stringify.self)
    try! macroSystem.add(ColorLiteral.self)
    return macroSystem
  }
}
