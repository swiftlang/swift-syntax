import XCTest
import SwiftSyntax

func loc(_ file: String = #file, line: Int = #line,
         column: Int = #line) -> SourceLocation {
  return SourceLocation(line: line, column: column, offset: 0, file: file)
}

/// Adds static constants to Diagnostic.Message.
extension Diagnostic.Message {
  /// Error thrown when a conversion between two types is impossible.
  static func cannotConvert(fromType: String,
                            toType: String) -> Diagnostic.Message {
    return .init(.error,
      "cannot convert value of type '\(fromType)' to '\(toType)'")
  }

  /// Suggestion for the user to explicitly check a value does not equal zero.
  static let checkEqualToZero =
    Diagnostic.Message(.note, "check for explicit equality to '0'")
}

public class DiagnosticsTestCase: XCTestCase {
  public func testDiagnosticEmission() {
    let startLoc = loc()
    let fixLoc = loc()

    let engine = DiagnosticEngine()
    XCTAssertFalse(engine.hasErrors)

    engine.diagnose(.cannotConvert(fromType: "Int", toType: "Bool"),
                    location: startLoc) {
      $0.note(.checkEqualToZero, location: fixLoc,
              fixIts: [.insert(fixLoc, " != 0")])
    }

    XCTAssertEqual(engine.diagnostics.count, 1)
    guard let diag = engine.diagnostics.first else { return }
    XCTAssertEqual(diag.message.text,
                "cannot convert value of type 'Int' to 'Bool'")
    XCTAssertEqual(diag.message.severity, .error)
    XCTAssertEqual(diag.notes.count, 1)
    XCTAssertTrue(engine.hasErrors)

    guard let note = diag.notes.first else { return }
    XCTAssertEqual(note.message.text, "check for explicit equality to '0'")
    XCTAssertEqual(note.message.severity, .note)
    XCTAssertEqual(note.fixIts.count, 1)

    guard let fixIt = note.fixIts.first else { return }
    XCTAssertEqual(fixIt.text, " != 0")
  }
}