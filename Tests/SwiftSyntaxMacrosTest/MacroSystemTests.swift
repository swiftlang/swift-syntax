import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
@_spi(Testing) import SwiftSyntaxMacros
import _SwiftSyntaxTestSupport

final class MacroSystemTests: XCTestCase {
  func testExpressionExpansion() {
    let sf: SourceFileSyntax =
      """
      #myLine
      let a = (#myLine)
      let b = #stringify(x + y)
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
      """
    )
  }
}
