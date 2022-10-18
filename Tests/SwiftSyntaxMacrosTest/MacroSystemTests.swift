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
      #colorLiteral(red: 0.5, green: 0.5, blue: 0.25, alpha: 1.0)
      let c = #column
      """
    let converter = SourceLocationConverter(file: "test.swift", tree: sf)
    let context = MacroEvaluationContext(
      moduleName: "MyModule", sourceLocationConverter: converter
    )
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

  func testPoundFunctionExpansion() {
    let sf: SourceFileSyntax =
      """
      func f(a: Int, _: Double, c: Int) {
        print(#function)
      }

      struct X {
        var computed: String {
          get {
            (#function)
          }
        }

        init(from: String) {
          (#function)
        }

        subscript(a: Int) -> String {
          (#function)
        }

        subscript(a a: Int) -> String {
          (#function)
        }
      }

      extension A {
        static var staticProp: String = #function
      }
      """
    let converter = SourceLocationConverter(file: "test.swift", tree: sf)
    let context = MacroEvaluationContext(
      moduleName: "MyModule", sourceLocationConverter: converter
    )
    let transformedSF = MacroSystem.exampleSystem.evaluateMacros(
      node: sf, in: context, errorHandler: { error in }
    )
    AssertStringsEqualWithDiff(
      transformedSF.description,
      """
      func f(a: Int, _: Double, c: Int) {
        print("f(a:_:c:)")
      }

      struct X {
        var computed: String {
          get {
            ("computed")
          }
        }

        init(from: String) {
          ("init(from:)")
        }

        subscript(a: Int) -> String {
          ("subscript(_:)")
        }

        subscript(a a: Int) -> String {
          ("subscript(a:)")
        }
      }

      extension A {
        static var staticProp: String = "A"
      }
      """
    )
  }
}
