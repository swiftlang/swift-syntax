import XCTest
import SwiftDiagnostics
import SwiftParser

public class DiagnosticInfrastructureTests: XCTestCase {
  public func testDiagnosticID() throws {
    struct TestDiagnostic: ParserError {
      let message: String = "My test diagnostic"
    }

    let diag = TestDiagnostic()
    XCTAssertEqual(diag.diagnosticID, MessageID(domain: "SwiftParser", id: "TestDiagnostic"))
    XCTAssertEqual(diag.message, "My test diagnostic")
    XCTAssertEqual(diag.severity, .error)

    XCTAssertEqual(StaticParserError.throwsInReturnPosition.diagnosticID, MessageID(domain: "SwiftParser", id: "StaticParserError.throwsInReturnPosition"))
    XCTAssertEqual(StaticParserError.throwsInReturnPosition.severity, .error)
  }
}
