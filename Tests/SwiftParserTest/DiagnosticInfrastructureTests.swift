import XCTest
import SwiftDiagnostics
import SwiftParser

public class DiagnosticInfrastructureTests: XCTestCase {
  public func testDiagnosticID() throws {
    struct TestDiagnostic: DiagnosticMessageType {
      let message: String = "My test diagnostic"
    }

    let diag = TestDiagnostic()
    XCTAssertEqual(diag.diagnosticID, MessageID("TestDiagnostic"))
    XCTAssertEqual(diag.message, "My test diagnostic")
  }
}
