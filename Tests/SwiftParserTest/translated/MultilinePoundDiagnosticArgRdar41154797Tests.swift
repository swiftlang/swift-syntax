// This test file has been translated from swift/test/Parse/multiline_pound_diagnostic_arg_rdar_41154797.swift

import XCTest

final class MultilinePoundDiagnosticArgRdar41154797Tests: XCTestCase {
  func testMultilinePoundDiagnosticArgRdar411547971() {
    AssertParse(
      ##"""
      #error("""#^DIAG^#
      """##,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"""' to end string literal"#),
        DiagnosticSpec(message: "expected ')' to end '#error' directive"),
      ]
    )
  }

}
