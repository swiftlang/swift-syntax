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

// This test file has been translated from swift/test/Parse/multiline_pound_diagnostic_arg_rdar_41154797.swift

import XCTest

final class MultilinePoundDiagnosticArgRdar41154797Tests: ParserTestCase {
  func testMultilinePoundDiagnosticArgRdar411547971() {
    assertParse(
      ##"""
      #error1️⃣(2️⃣"""3️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(locationMarker: "2️⃣", message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected ')' to end macro expansion",
          notes: [NoteSpec(locationMarker: "1️⃣", message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: ##"""
        #error("""
        """)
        """##
    )
  }

}
