@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class AttributeTests: XCTestCase {
  func testMissingArgumentToAttribute() {
    AssertParse(
      """
      @_dynamicReplacement(#^DIAG^#
      func #^DIAG_2^#test_dynamic_replacement_for2() {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected argument for '@_dynamicReplacement' attribute", fixIts: ["Insert attribute argument"]),
        DiagnosticSpec(message: "Expected ')' to end attribute", fixIts: ["Insert ')'"]),
      ],
      fixedSource: """
      @_dynamicReplacement(for: <#identifier#>)
      func test_dynamic_replacement_for2() {
      }
      """
    )
  }
}
