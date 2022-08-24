import SwiftDiagnostics
import SwiftSyntax
import SwiftParser
import XCTest
import _SwiftSyntaxTestSupport

public class FixItApplier: SyntaxRewriter {
  var changes: [FixIt.Change]

  init(diagnostics: [Diagnostic]) {
    self.changes = diagnostics.flatMap({ $0.fixIts }).flatMap({ $0.changes })
  }

  public override func visitAny(_ node: Syntax) -> Syntax? {
    for change in changes {
      switch change {
      case .replace(oldNode: let oldNode, newNode: let newNode) where oldNode.id == node.id:
        return newNode
      default:
        break
      }
    }
    return nil
  }

  /// Applies all Fix-Its in `diagnostics` to `tree` and returns the fixed syntax tree.
  public static func applyFixes<T: SyntaxProtocol>(in diagnostics: [Diagnostic], to tree: T) -> Syntax {
    let applier = FixItApplier(diagnostics: diagnostics)
    return applier.visit(Syntax(tree))
  }
}

/// Asserts that the diagnostics `diag` inside `tree` occurs at `line` and
/// `column`.
/// If `message` is not `nil`, assert that the diagnostic has the given message.
/// If `id` is not `nil`, assert that the diagnostic has the given message.
func XCTAssertDiagnostic<T: SyntaxProtocol>(
  _ diag: Diagnostic,
  in tree: T,
  line: Int,
  column: Int,
  id: MessageID? = nil,
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
/// If `expectedFixedSource` is not `nil`, assert that the source code that it is source code that result from applying all Fix-Its.
func XCTAssertSingleDiagnostic<T: SyntaxProtocol>(
  in tree: T,
  line: Int,
  column: Int,
  id: MessageID? = nil,
  message: String? = nil,
  expectedFixedSource: String? = nil,
  testFile: StaticString = #filePath,
  testLine: UInt = #line
) {
  let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
  guard diags.count == 1 else {
    XCTFail("Received \(diags.count) diagnostics but expected excatly one: \(diags)", file: testFile, line: testLine)
    return
  }
  XCTAssertDiagnostic(diags.first!, in: tree, line: line, column: column, id: id, message: message, testFile: testFile, testLine: testLine)
  if let expectedFixedSource = expectedFixedSource {
    let fixedSource = FixItApplier.applyFixes(in: diags, to: tree).description
    AssertStringsEqualWithDiff(fixedSource, expectedFixedSource, file: testFile, line: testLine)
  }
}
