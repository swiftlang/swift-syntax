//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

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
}
