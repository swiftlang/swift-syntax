import SwiftSyntax
import SwiftParser
import XCTest
import _SwiftSyntaxTestSupport

/// Asserts that the diagnostics `diag` inside `tree` occurs at `line` and
/// `column`.
/// If `message` is not `nil`, assert that the diagnostic has the given message.
/// If `id` is not `nil`, assert that the diagnostic has the given message.
func XCTAssertDiagnostic<T: SyntaxProtocol>(
  _ diag: Diagnostic,
  in tree: T,
  line: Int,
  column: Int,
  id: DiagnosticMessageID? = nil,
  message: String? = nil,
  testFile: StaticString = #filePath,
  testLine: UInt = #line
) {
  let locationConverter = SourceLocationConverter(file: "/test.swift", source: tree.description)
  let location = diag.location(converter: locationConverter)
  XCTAssertEqual(location.line, line, "Expected diagnostic on line \(line) but got \(location.line ?? -1)", file: testFile, line: testLine)
  XCTAssertEqual(location.column, column, "Expected diagnostic on column \(column) but got \(location.column ?? -1)", file: testFile, line: testLine)
  if let id = id {
    XCTAssertEqual(diag.diagnosticID, id, file: testFile, line: testLine)
  }
  if let message = message {
    XCTAssertEqual(diag.message, message, file: testFile, line: testLine)
  }
}

/// Assert that producing diagnostics for `tree` generates a single diagnostic
/// at `line` and `column`.
/// If `message` is not `nil`, assert that the diagnostic has the given message.
/// If `id` is not `nil`, assert that the diagnostic has the given message.
func XCTAssertSingleDiagnostic<T: SyntaxProtocol>(
  in tree: T,
  line: Int,
  column: Int,
  id: DiagnosticMessageID? = nil,
  message: String? = nil,
  testFile: StaticString = #filePath,
  testLine: UInt = #line
) {
  let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
  guard diags.count == 1 else {
    XCTFail("Received \(diags.count) diagnostics but expected excatly one: \(diags)", file: testFile, line: testLine)
    return
  }
  XCTAssertDiagnostic(diags.first!, in: tree, line: line, column: column, id: id, message: message, testFile: testFile, testLine: testLine)
}
