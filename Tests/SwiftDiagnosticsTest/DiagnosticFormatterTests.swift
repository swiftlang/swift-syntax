//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import XCTest

final class DiagnosticFormatterTests: XCTestCase {
  func testFormattedMessage() {
    let message = SimpleDiagnosticMessage(
      message: "something went wrong",
      diagnosticID: MessageID(domain: "swift-syntax", id: "testing"),
      severity: .error,
      category: DiagnosticCategory(
        name: "Testing",
        documentationURL: "http://example.com"
      )
    )

    let formattedText = DiagnosticsFormatter().formattedMessage(message)
    XCTAssertEqual(formattedText, "error: something went wrong [#Testing]")
  }
}
