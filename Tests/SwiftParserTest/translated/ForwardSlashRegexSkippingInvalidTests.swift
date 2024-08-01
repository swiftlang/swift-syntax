//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This test file has been translated from swift/test/StringProcessing/Parse/forward-slash-regex-skipping-invalid.swift

import XCTest

final class ForwardSlashRegexSkippingInvalidTests: ParserTestCase {
  func testForwardSlashRegexSkippingInvalid1() {
    // We don't consider this a regex literal when skipping as it has an initial
    // space.
    assertParse(
      """
      func a() { _ = /1️⃣ x*/ }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      applyFixIts: [],
      fixedSource: """
        func a() { _ = / x*/ }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid2() {
    // Same because of unbalanced ')'
    assertParse(
      """
      func b() { _ = /x1️⃣)*/ }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code ')*/' in function")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid3() {
    // These also fail the heuristic, but have unbalanced `{` `}`, so we don't skip.
    assertParse(
      """
      func c() { _ = /1️⃣ x}*/ }
      func d() { _ = /2️⃣ x{*/ }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        ),
      ],
      applyFixIts: [],
      fixedSource: """
        func c() { _ = / x}*/ }
        func d() { _ = / x{*/ }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid4() {
    // Unterminated, and unbalanced `{}`.
    assertParse(
      """
      func e() {
        _ = ℹ️/1️⃣         }2️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        ),
      ],
      applyFixIts: ["insert '/'"],
      fixedSource: """
        func e() {
          _ = /         }/
        }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid5() {
    assertParse(
      """
      func f() {
        _ = ℹ️/1️⃣         {2️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        ),
      ],
      applyFixIts: ["insert '/'"],
      fixedSource: """
        func f() {
          _ = /         {/
        }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid6() {
    assertParse(
      """
      func g() {
        _ = /x         }
      1️⃣}
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous brace at top level")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid7() {
    assertParse(
      """
      func h() {
        _ = /x         {
        }
      }
      """
    )
  }

  func testForwardSlashRegexSkippingInvalid8a() {
    assertParse(
      #"""
      func i() {
        _ = /x1️⃣ ℹ️"[abc]     {2️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      applyFixIts: ["insert newline", #"insert '"'"#],
      fixedSource: #"""
        func i() {
          _ = /x
          "[abc]     {"
        }
        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid8b() {
    assertParse(
      #"""
      func i() {
        _ = /x1️⃣ ℹ️"[abc]     {2️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
      ],
      applyFixIts: ["insert ';'", #"insert '"'"#],
      fixedSource: #"""
        func i() {
          _ = /x; "[abc]     {"
        }
        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid9() {
    assertParse(
      """
      func j() {
        _ = ℹ️/^ [abc]     {1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        )
      ],
      fixedSource: """
        func j() {
          _ = /^ [abc]     {/
        }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid10() {
    assertParse(
      #"""
      func k() {
        _ = ℹ️/^ "[abc]     {1️⃣
      }
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        )
      ],
      fixedSource: #"""
        func k() {
          _ = /^ "[abc]     {/
        }
        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid11() {
    assertParse(
      """
      func l() {
        _ = ℹ️/^    } abc     {1️⃣
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        )
      ],
      fixedSource: """
        func l() {
          _ = /^    } abc     {/
        }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid12() {
    assertParse(
      #"""
      func m() {
        _ = ℹ️/1️⃣ "2️⃣
      }
      3️⃣}
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '/' to end regex literal",
          notes: [NoteSpec(message: "to match this opening '/'")],
          fixIts: ["insert '/'"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "extraneous brace at top level"
        ),
      ],
      applyFixIts: ["insert '/'"],
      fixedSource: #"""
        func m() {
          _ = / "/
        }
        }
        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid13() {
    // Unbalanced `}`, make sure we don't consider the string literal `{`.
    assertParse(
      #"""
      func n() { /1️⃣ "{"}/ }
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      applyFixIts: [],
      fixedSource: #"""
        func n() { / "{"}/ }
        """#
    )
  }

  func testForwardSlashRegexSkippingInvalid14() {
    assertParse(
      """
      func o() {
        _ = {
          0
          /x}}1️⃣} /
          2
        } 
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code at top level")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid15() {
    assertParse(
      """
      func p() {
        _ = 2
        /x} 1️⃣/
        .bitWidth
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "extraneous code at top level")
      ]
    )
  }

  func testForwardSlashRegexSkippingInvalid17() {
    assertParse(
      """
      func err1() { _ = /1️⃣ 0xG}/ }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      applyFixIts: [],
      fixedSource: """
        func err1() { _ = / 0xG}/ }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid18() {
    assertParse(
      """
      func err2() { _ = /1️⃣ 0oG}/ }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      applyFixIts: [],
      fixedSource: """
        func err2() { _ = / 0oG}/ }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid19() {
    assertParse(
      """
      func err3() { _ = /1️⃣ {"/ }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      applyFixIts: [],
      fixedSource: """
        func err3() { _ = / {"/ }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid20() {
    assertParse(
      """
      func err4() { _ = /1️⃣ {'/ }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      applyFixIts: [],
      fixedSource: """
        func err4() { _ = / {'/ }
        """
    )
  }

  func testForwardSlashRegexSkippingInvalid21() {
    assertParse(
      """
      func err5() { _ = /1️⃣ {<#placeholder#>/ }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "bare slash regex literal may not start with space",
          fixIts: [
            "convert to extended regex literal with '#'",
            #"insert '\'"#,
          ]
        )
      ],
      applyFixIts: [],
      fixedSource: """
        func err5() { _ = / {<#placeholder#>/ }
        """
    )
  }
}
