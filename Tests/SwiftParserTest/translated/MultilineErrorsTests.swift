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

// This test file has been translated from swift/test/Parse/multiline_errors.swift

import SwiftSyntax
import XCTest

extension ParserTestCase {
  fileprivate func assertParseWithAllNewlineEndings(
    _ markedSource: String,
    substructure expectedSubstructure: (some SyntaxProtocol)? = Optional<Syntax>.none,
    substructureAfterMarker: String = "START",
    diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
    applyFixIts: [String]? = nil,
    fixedSource expectedFixedSource: String? = nil,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    for newline in ["\n", "\r", "\r\n"] {
      assertParse(
        markedSource.replacingOccurrences(of: "\n", with: newline),
        substructure: expectedSubstructure,
        substructureAfterMarker: substructureAfterMarker,
        diagnostics: expectedDiagnostics,
        applyFixIts: applyFixIts,
        fixedSource: expectedFixedSource,
        options: [.normalizeNewlinesInFixedSource],
        file: file,
        line: line
      )
    }
  }
}

final class MultilineErrorsTests: ParserTestCase {
  func testMultilineErrors1() {
    assertParseWithAllNewlineEndings(
      """
      import Swift
      """
    )
  }

  // MARK: - Multiline

  func testMultilineErrors3() {
    // expecting at least 4 columns of leading indentation
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
          Eleven
        1️⃣Mu
          ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
            Eleven
            Mu
            """
        """#
    )
  }

  func testMultilineErrors4() {
    // expecting at least 4 columns of leading indentation
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
          Eleven
         1️⃣Mu
          ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
            Eleven
            Mu
            """
        """#
    )
  }

  func testMultilineErrors5() {
    // \t is not the same as an actual tab
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      	Twelve
      1️⃣\tNu
      	ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
        	Twelve
        	\tNu
        	"""
        """#
    )
  }

  func testMultilineErrors6a() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
          \(42
      1️⃣)
          ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
            \(42
            )
            """
        """#
    )
  }

  func testMultilineErrors6b() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
          \(42
       1️⃣)
          ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
            \(42
            )
            """
        """#
    )
  }

  func testMultilineErrors7() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
          Foo
      1️⃣\
          Bar
          ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
            Foo
            \
            Bar
            """
        """#
    )
  }

  func testMultilineErrors8() {
    // a tab is not the same as multiple spaces
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
        Thirteen
      1️⃣	Xi
        ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected tab in indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
          Thirteen
          Xi
          """
        """#
    )
  }

  func testMultilineErrors9() {
    // a tab is not the same as multiple spaces
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
          Fourteen
        1️⃣	Pi
          ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected tab in indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
            Fourteen
            Pi
            """
        """#
    )
  }

  func testMultilineErrors10() {
    // multiple spaces are not the same as a tab
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      	Thirteen 2
      1️⃣  Xi 2
      	ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected space in indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
        	Thirteen 2
        	Xi 2
        	"""
        """#
    )
  }

  func testMultilineErrors11() {
    // multiple spaces are not the same as a tab
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      		Fourteen 2
      	1️⃣  Pi 2
      		ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected space in indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
        		Fourteen 2
        		Pi 2
        		"""
        """#
    )
  }

  func testMultilineErrors12() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """1️⃣Fourteen
          Pi
          """
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal content must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: #"""
        _ = """
            Fourteen
            Pi
            """
        """#
    )
  }

  func testMultilineErrors13() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
          Fourteen
          Pi1️⃣"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal closing delimiter must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: #"""
        _ = """
            Fourteen
            Pi
            """
        """#
    )
  }

  func testMultilineErrors14() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """1️⃣"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal closing delimiter must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: #"""
        _ = """
        """
        """#
    )
  }

  func testMultilineErrors15() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """ 1️⃣"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal closing delimiter must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: #"""
        _ = """
        """
        """#
    )
  }

  func testMultilineErrors16() {
    // two lines should get only one error
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      1️⃣    Hello,
              World!
      	ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "unexpected space in indentation of the next 2 lines in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
        	Hello,
        	World!
        	"""
        """#
    )
  }

  func testMultilineErrors17a() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      1️⃣Zero A
      Zero B
      	One A
      	One B
      2️⃣  Two A
        Two B
      3️⃣Three A
      Three B
      		Four A
      		Four B
      			Five A
      			Five B
      		ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "insufficient indentation of the next 4 lines in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "unexpected space in indentation of the next 2 lines in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "insufficient indentation of the next 2 lines in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        ),
      ],
      fixedSource: #"""
        _ = """
        		Zero A
        		Zero B
        		One A
        		One B
        		Two A
        		Two B
        		Three A
        		Three B
        		Four A
        		Four B
        			Five A
        			Five B
        		"""
        """#
    )
  }

  func testMultilineErrors17b() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      1️⃣Zero A\(1)B
      Zero B
            X
          ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of the next 2 lines in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
        _ = """
            Zero A\(1)B
            Zero B
              X
            """
        """#
    )
  }

  func testMultilineErrors17c() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      1️⃣Incorrect 1
          Correct
      2️⃣Incorrect 2
          ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        ),
      ],
      fixedSource: #"""
        _ = """
            Incorrect 1
            Correct
            Incorrect 2
            """
        """#
    )
  }

  func testMultilineErrors18() {
    assertParseWithAllNewlineEndings(
      ##"""
      _ = 1️⃣"hello\2️⃣("""
                  world
                  """3️⃣
                  4️⃣)!"
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected ')' in string literal",
          notes: [NoteSpec(locationMarker: "2️⃣", message: "to match this opening '('")],
          fixIts: [#"insert ')'"#]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: #"extraneous code ')!"' at top level"#
        ),
      ],
      fixedSource: ##"""
        _ = "hello\("""
                    world
                    """)"
                    )!"
        """##
    )
  }

  func testMultilineErrors19() {
    assertParseWithAllNewlineEndings(
      ##"""
      _ = ℹ️"h\(1️⃣
                  """
                  world
                  """2️⃣)!"
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "expected value and ')' in string literal",
          fixIts: ["insert value and ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"extraneous code ')!"' at top level"#
        ),
      ],
      fixedSource: ##"""
        _ = "h\(<#expression#>)"
                    """
                    world
                    """)!"
        """##
    )
  }

  func testMultilineErrors20() {
    assertParseWithAllNewlineEndings(
      ##"""
      _ = """
        line one 1️⃣\ non-whitespace
        line two
        """
      """##,
      diagnostics: [
        DiagnosticSpec(message: "invalid escape sequence in literal")
      ]
    )
  }

  func testMultilineErrors21() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
        line one
        line two1️⃣\
        """
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "escaped newline at the last line of a multi-line string literal is not allowed",
          fixIts: [#"remove '\'"#]
        )
      ],
      fixedSource: #"""
        _ = """
          line one
          line two
          """
        """#
    )
  }

  func testMultilineErrors22() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
        \\1️⃣\	  \#u{20}
        """
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "escaped newline at the last line of a multi-line string literal is not allowed",
          fixIts: [#"remove '\'"#]
        )
      ],
      fixedSource: #"""
        _ = """
          \\
          """
        """#
    )
  }

  func testMultilineErrors23() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
        \(42)1️⃣\	\#t
        """
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "escaped newline at the last line of a multi-line string literal is not allowed",
          fixIts: [#"remove '\'"#]
        )
      ],
      fixedSource: #"""
        _ = """
          \(42)
          """
        """#
    )
  }

  func testMultilineErrors24() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
        foo1️⃣\
        """
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "escaped newline at the last line of a multi-line string literal is not allowed",
          fixIts: [#"remove '\'"#]
        )
      ],
      fixedSource: #"""
        _ = """
          foo
          """
        """#
    )
  }

  func testMultilineErrors25() {
    assertParseWithAllNewlineEndings(
      ##"""
      _ = ℹ️"""
        foo1️⃣\2️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "invalid escape sequence in literal"
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        ),
      ],
      fixedSource: ##"""
        _ = """
          foo\
        """
        """##
    )
  }

  func testMultilineErrors26() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      1️⃣\
        """
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "escaped newline at the last line of a multi-line string literal is not allowed",
          fixIts: [#"remove '\'"#]
        )
      ],
      fixedSource: #"""
        _ = """
         \#u{20}
          """
        """#
    )
  }

  func testMultilineErrors27() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """1️⃣\
        """
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal content must begin on a new line",
          fixIts: ["insert newline"]
        ),
        DiagnosticSpec(
          message: "escaped newline at the last line of a multi-line string literal is not allowed",
          fixIts: [#"remove '\'"#]
        ),
      ],
      fixedSource: #"""
        _ = """
         \#u{20}
          
          """
        """#
    )
  }

  func testMultilineErrors28() {
    assertParseWithAllNewlineEndings(
      ##"""
      let _ = """
        foo
        \1️⃣(2️⃣"bar3️⃣
        4️⃣baz5️⃣
        """
      """##,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "2️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: #"unexpected code 'baz' in string literal"#
        ),
        DiagnosticSpec(
          locationMarker: "5️⃣",
          message: #"expected ')' in string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: ##"""
        let _ = """
          foo
          \("bar"
          baz)
          """
        """##
    )
  }

  func testMultilineErrors29() {
    assertParseWithAllNewlineEndings(
      ##"""
      let _ = """
        foo
        \1️⃣(2️⃣"bar3️⃣
        4️⃣baz5️⃣
        """
        abc
      """##,
      substructure: DeclReferenceExprSyntax(baseName: .identifier("abc")),
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: #"expected '"' to end string literal"#,
          notes: [NoteSpec(locationMarker: "2️⃣", message: #"to match this opening '"'"#)],
          fixIts: [#"insert '"'"#]
        ),
        DiagnosticSpec(
          locationMarker: "4️⃣",
          message: #"unexpected code 'baz' in string literal"#
        ),
        DiagnosticSpec(
          locationMarker: "5️⃣",
          message: #"expected ')' in string literal"#,
          notes: [NoteSpec(locationMarker: "1️⃣", message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
      ],
      fixedSource: ##"""
        let _ = """
          foo
          \("bar"
          baz)
          """
          abc
        """##
    )
  }

  func testMultilineEndsWithStringInterpolation() {
    assertParseWithAllNewlineEndings(
      #"""
      _ = """
      \(1)1️⃣"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal closing delimiter must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: #"""
        _ = """
        \(1)
        """
        """#
    )
  }

  func testInsufficientIndentationInInterpolation() {
    assertParseWithAllNewlineEndings(
      #"""
        """
        \(
      1️⃣1
        )
        ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
          """
          \(
          1
          )
          """
        """#
    )

    assertParseWithAllNewlineEndings(
      #"""
        """
        \(
      1️⃣1
        +
      2️⃣2
        )
        ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "insufficient indentation of line in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        ),
      ],
      fixedSource: #"""
          """
          \(
          1
          +
          2
          )
          """
        """#
    )

    assertParseWithAllNewlineEndings(
      #"""
        """
        \(
      1️⃣1
      +
      2
        )
        ℹ️"""
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "insufficient indentation of the next 3 lines in multi-line string literal",
          highlight: " ",
          notes: [NoteSpec(message: "should match indentation here")],
          fixIts: ["change indentation of this line to match closing delimiter"]
        )
      ],
      fixedSource: #"""
          """
          \(
          1
          +
          2
          )
          """
        """#
    )
  }

  func testWhitespaceAfterOpenQuote() {
    assertParse(
      #"""
      """1️⃣\#(" ")
      """
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: "multi-line string literal content must begin on a new line",
          fixIts: ["insert newline"]
        )
      ],
      fixedSource: #"""
        """
        \#(" ")
        """
        """#
    )
  }
}
