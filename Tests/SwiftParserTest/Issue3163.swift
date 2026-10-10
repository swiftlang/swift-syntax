import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax
import XCTest

public class Issue3163Tests: XCTestCase {
  func testFixForIssue3163() {
    let source = "struct Foo {func a(s: S [{{g) -> Int {}}}}"

    // Parse the code
    let tree = Parser.parse(source: source)

    // Get the error messages
    let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: tree)

    // CHECK: Ensure the specific "missing 'in'" error is NOT present
    let hasBadError = diagnostics.contains { $0.message.contains("expected 'in' in closure signature") }

    // This will pass if the error is gone (FIXED).
    // This will fail if the error is still there (BROKEN).
    XCTAssertFalse(hasBadError, "The parser incorrectly identified a closure signature and asked for 'in'")
  }
}
