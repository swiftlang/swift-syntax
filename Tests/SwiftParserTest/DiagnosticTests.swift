import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax) import SwiftParser
import _SwiftSyntaxTestSupport

public class DiagnosticTests: XCTestCase {
  public func testMissingTokenDiags() {
    AssertParse(
      "(first second #^DIAG^#Int)",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "Expected ':' in function parameter")
      ]
    )
  }

  public func testUnexpectedDiags() {
    AssertParse(
      "(first second #^DIAG^#third fourth: Int)",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text 'third fourth' found in function parameter")
      ]
    )
  }

  public func testCStyleForLoop() {
    AssertParse(
      """
      #^DIAG^#for let x = 0; x < 10; x += 1, y += 1 {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "C-style for statement has been removed in Swift 3", highlight: "let x = 0; x < 10; x += 1, y += 1 ")
      ]
    )
  }

  public func testMissingClosingParen() {
    AssertParse(
      "(first second: Int#^DIAG^#",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "Expected ')' to end parameter clause")
      ]
    )
  }

  public func testMissingOpeningParen() {
    AssertParse(
      "#^DIAG^#first second: Int)",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "Expected '(' to start parameter clause")
      ]
    )
  }

  public func testThrowsInWrongLocation() {
    AssertParse(
      "() -> #^DIAG^#throws Int",
      { $0.parseFunctionSignature() },
      diagnostics: [
        DiagnosticSpec(message: "'throws' may only occur before '->'", fixIts: ["Move 'throws' before '->'"])
      ],
      fixedSource: "() throws -> Int"
    )
  }

  public func testNoParamsForFunction() {
    AssertParse(
      """
      class MyClass {
        func withoutParameters#^DIAG^#

        func withParameters() {}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected argument list in function declaration")
      ]
    )
  }

  func testMissingColonInTernary() {
    AssertParse(
      "foo ? 1#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "Expected ':' after '? ...' in ternary expression")
      ]
    )
  }


  public func testUnterminatedPoundIf() {
    AssertParse(
      "#if test#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "Expected '#endif' in declaration")
      ]
    )
  }
}
