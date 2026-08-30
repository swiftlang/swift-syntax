import SwiftDiagnostics
import SwiftParserDiagnostics
import XCTest

class DiagnosticInfrastructureTests: XCTestCase {
  public func testDiagnosticID() {
    struct TestDiagnostic: ParserError {
      let message: String = "My test diagnostic"
    }

    let diag = TestDiagnostic()
    XCTAssertEqual(diag.diagnosticID, MessageID(domain: "SwiftParser", id: "TestDiagnostic"))
    XCTAssertEqual(diag.message, "My test diagnostic")
    XCTAssertEqual(diag.severity, .error)

    XCTAssertEqual(
      StaticParserError.caseOutsideOfSwitchOrEnum.diagnosticID,
      MessageID(domain: "SwiftParser", id: "StaticParserError.caseOutsideOfSwitchOrEnum")
    )
    XCTAssertEqual(StaticParserError.caseOutsideOfSwitchOrEnum.severity, .error)

    XCTAssertEqual(
      StaticParserFixIt.insertSemicolon.fixItID,
      MessageID(domain: "SwiftParser", id: "StaticParserFixIt.insertSemicolon")
    )
  }
  public func testCaseOutsideOfSwitchDiagnosticSeverityAndID() {
    let diagnostic = StaticParserError.caseOutsideOfSwitchOrEnum

    XCTAssertEqual(
      diagnostic.diagnosticID,
      MessageID(
        domain: "SwiftParser",
        id: "StaticParserError.caseOutsideOfSwitchOrEnum"
      )
    )

    XCTAssertEqual(diagnostic.severity, DiagnosticSeverity.error)
  }
}
