//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import XCTest

final class ValueGenericsTests: ParserTestCase {
  func testBasic() {
    // Note: This is structurally illegal, but we don't diagnose that it is
    // until type checking.
    assertParse(
      """
      func requirement<let T>() {}
      """
    )

    assertParse(
      """
      func requirement<let T: Int>() {}
      """
    )

    assertParse(
      """
      func requirement<let T1️⃣...>() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "ellipsis operator cannot be used with a type parameter pack",
          fixIts: ["remove '...'"]
        )
      ],
      fixedSource: """
        func requirement<let T>() {}
        """
    )
  }

  func testCombination() {
    assertParse(
      """
      func requirementℹ️<each 1️⃣let T2️⃣>() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected name in generic parameter",
          fixIts: ["insert name"]
        ),
        DiagnosticSpec(
          message: "expected '>' to end generic parameter clause",
          notes: [
            NoteSpec(
              message: "to match this opening '<'"
            )
          ],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          message: "expected parameter clause in function signature",
          fixIts: ["insert parameter clause"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "extraneous code '>() {}' at top level"
        ),
      ],
      fixedSource: """
        func requirement<each <#identifier#>>()let T>() {}
        """
    )

    assertParse(
      """
      func requirementℹ️<let each1️⃣ 2️⃣T>() {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '>' to end generic parameter clause",
          notes: [
            NoteSpec(
              message: "to match this opening '<'"
            )
          ],
          fixIts: ["insert '>'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected code 'T>' before parameter clause"
        ),
      ],
      fixedSource: """
        func requirement<let each>T>() {}
        """
    )
  }
}
