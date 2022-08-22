import XCTest
import SwiftParser

public class DiagnosticInfrastructureTests: XCTestCase {
  public func testDiagnosticID() throws {
    struct TestDiagnostic: TypedDiagnosticMessage {
      let message: String = "My test diagnostic"
    }

    let diag = TestDiagnostic()
    XCTAssertEqual(diag.diagnosticID, DiagnosticMessageID("TestDiagnostic"))
    XCTAssertEqual(diag.message, "My test diagnostic")
  }
}
