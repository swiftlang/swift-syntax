import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
@_spi(Testing) import SwiftSyntaxMacros
import _SwiftSyntaxTestSupport

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

extension MacroSystem {
  static var testingSystem: MacroSystem {
    var macroSystem = MacroSystem()
    try! macroSystem.add(LineMacro.self)
    return macroSystem
  }
}

final class MacroSystemTests: XCTestCase {
  func testExpressionExpansion() {
    let sf: SourceFileSyntax =
      """
      #myLine
      let a = (#myLine)
      """
    let converter = SourceLocationConverter(file: "test.swift", tree: sf)
    let context = MacroEvaluationContext(sourceLocationConverter: converter)
    let transformedSF = MacroSystem.testingSystem.evaluateMacros(
      node: sf, in: context, errorHandler: { error in }
    )
    AssertStringsEqualWithDiff(
      transformedSF.description,
      """
      1
      let a = (2)
      """
    )
  }
}
