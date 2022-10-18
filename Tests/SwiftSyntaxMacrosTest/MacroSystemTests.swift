import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
@_spi(Testing) import SwiftSyntaxMacros
import _SwiftSyntaxTestSupport

final class MacroSystemTests: XCTestCase {
  func testExpressionExpansion() {
    let sf: SourceFileSyntax =
      """
      #line
      let a = (#line)
      let b = #stringify(x + y)
      #myColorLiteral(red: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
      let c = #column
      """
    let converter = SourceLocationConverter(file: "test.swift", tree: sf)
    let context = MacroEvaluationContext(sourceLocationConverter: converter)
    let transformedSF = MacroSystem.exampleSystem.evaluateMacros(
      node: sf, in: context, errorHandler: { error in }
    )
    AssertStringsEqualWithDiff(
      transformedSF.description,
      """
      1
      let a = (2)
      let b = (x + y, #"x + y"#)
      .init(red: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
      let c = 9
      """
    )
  }
}
