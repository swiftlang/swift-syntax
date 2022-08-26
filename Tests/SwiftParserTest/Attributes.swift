@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class AttributeTests: XCTestCase {
  func testMissingArgumentToAttribute() {
    AssertParse(
      """
      @_dynamicReplacement(#^DIAG_1^#
      func #^DIAG_2^#test_dynamic_replacement_for2() {
      }
      """,
      diagnostics: [
        // FIXME: We should be complaining about the missing ')' for the attribute
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Expected 'for'"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Expected ':'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected ')'"),
      ]
    )
  }
}
