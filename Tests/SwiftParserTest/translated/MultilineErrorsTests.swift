// This test file has been translated from swift/test/Parse/multiline_errors.swift

import XCTest

final class MultilineErrorsTests: XCTestCase {
  func testMultilineErrors1() {
    AssertParse(
      """
      import Swift
      """
    )
  }

  func testMultilineErrors2() {
    AssertParse(
      """
      // ===---------- Multiline --------===
      """
    )
  }

  func testMultilineErrors3() {
    AssertParse(
      #"""
      // expecting at least 4 columns of leading indentation
      _ = """
          Eleven
        Mu
          """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: insufficient indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 4: change indentation of this line to match closing delimiter, Fix-It replacements: 3 - 3 = '  '
        // TODO: Old parser expected note on line 5: should match space here
      ]
    )
  }

  func testMultilineErrors4() {
    AssertParse(
      #"""
      // expecting at least 4 columns of leading indentation
      _ = """
          Eleven
         Mu
          """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: insufficient indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 4: change indentation of this line to match closing delimiter, Fix-It replacements: 4 - 4 = ' '
        // TODO: Old parser expected note on line 5: should match space here
      ]
    )
  }

  func testMultilineErrors5() {
    AssertParse(
      #"""
      // \t is not the same as an actual tab for de-indentation
      _ = """
      	Twelve
      \tNu
      	"""
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: insufficient indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 4: change indentation of this line to match closing delimiter, Fix-It replacements: 1 - 1 = '	'
        // TODO: Old parser expected note on line 5: should match tab here
      ]
    )
  }

  func testMultilineErrors6() {
    AssertParse(
      #"""
      _ = """
          \(42
      )
          """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: insufficient indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 3: change indentation of this line to match closing delimiter, Fix-It replacements: 1 - 1 = '    '
        // TODO: Old parser expected note on line 4: should match space here
      ]
    )
  }

  func testMultilineErrors7() {
    AssertParse(
      #"""
      _ = """
          Foo
      \
          Bar 
          """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: insufficient indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 3: change indentation of this line to match closing delimiter, Fix-It replacements: 1 - 1 = '    '
        // TODO: Old parser expected note on line 5: should match space here
      ]
    )
  }

  func testMultilineErrors8() {
    AssertParse(
      #"""
      // a tab is not the same as multiple spaces for de-indentation
      _ = """
        Thirteen
      	Xi
        """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unexpected tab in indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 4: change indentation of this line to match closing delimiter, Fix-It replacements: 1 - 2 = '  '
        // TODO: Old parser expected note on line 5: should match space here
      ]
    )
  }

  func testMultilineErrors9() {
    AssertParse(
      #"""
      // a tab is not the same as multiple spaces for de-indentation
      _ = """
          Fourteen
        	Pi
          """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unexpected tab in indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 4: change indentation of this line to match closing delimiter, Fix-It replacements: 3 - 4 = '  '
        // TODO: Old parser expected note on line 5: should match space here
      ]
    )
  }

  func testMultilineErrors10() {
    AssertParse(
      #"""
      // multiple spaces are not the same as a tab for de-indentation
      _ = """
      	Thirteen 2
        Xi 2
      	"""
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unexpected space in indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 4: change indentation of this line to match closing delimiter, Fix-It replacements: 1 - 3 = '	'
        // TODO: Old parser expected note on line 5: should match tab here
      ]
    )
  }

  func testMultilineErrors11() {
    AssertParse(
      #"""
      // multiple spaces are not the same as a tab for de-indentation
      _ = """
      		Fourteen 2
      	  Pi 2
      		"""
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: unexpected space in indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 4: change indentation of this line to match closing delimiter, Fix-It replacements: 2 - 4 = '	'
        // TODO: Old parser expected note on line 5: should match tab here
      ]
    )
  }

  func testMultilineErrors12() {
    AssertParse(
      #"""
      // newline currently required after opening """
      _ = """Fourteen
          Pi
          """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: multi-line string literal content must begin on a new line, Fix-It replacements: 8 - 8 = '\n'
      ]
    )
  }

  func testMultilineErrors13() {
    AssertParse(
      #"""
      // newline currently required before closing """
      _ = """
          Fourteen
          Pi"""
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 4: multi-line string literal closing delimiter must begin on a new line, Fix-It replacements: 7 - 7 = '\n'
      ]
    )
  }

  func testMultilineErrors14() {
    AssertParse(
      #"""
      // newline currently required after opening """
      _ = """"""
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: multi-line string literal content must begin on a new line, Fix-It replacements: 8 - 8 = '\n'
      ]
    )
  }

  func testMultilineErrors15() {
    AssertParse(
      #"""
      // newline currently required after opening """
      _ = """ """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: multi-line string literal content must begin on a new line, Fix-It replacements: 8 - 8 = '\n'
      ]
    )
  }

  func testMultilineErrors16() {
    AssertParse(
      #"""
      // two lines should get only one error
      _ = """
          Hello,
              World!
      	"""
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: unexpected space in indentation of next 2 lines in multi-line string literal
        // TODO: Old parser expected note on line 3: change indentation of these lines to match closing delimiter, Fix-It replacements: 1 - 5 = '	', 1 - 5 = '	'
        // TODO: Old parser expected note on line 5: should match tab here
      ]
    )
  }

  func testMultilineErrors17() {
    AssertParse(
      #"""
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
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: insufficient indentation of next 2 lines in multi-line string literal
        // TODO: Old parser expected note on line 2: change indentation of these lines to match closing delimiter, Fix-It replacements: 1 - 1 = '		', 1 - 1 = '		'
        // TODO: Old parser expected error on line 4: insufficient indentation of next 2 lines in multi-line string literal
        // TODO: Old parser expected note on line 4: change indentation of these lines to match closing delimiter, Fix-It replacements: 2 - 2 = '	', 2 - 2 = '	'
        // TODO: Old parser expected error on line 6: unexpected space in indentation of next 4 lines in multi-line string literal
        // TODO: Old parser expected note on line 6: change indentation of these lines to match closing delimiter, Fix-It replacements: 1 - 1 = '		', 1 - 1 = '		', 1 - 1 = '		', 1 - 1 = '		'
        // TODO: Old parser expected note on line 14: should match tab here
        // TODO: Old parser expected note on line 14: should match tab here
        // TODO: Old parser expected note on line 14: should match tab here
      ]
    )
  }

  func testMultilineErrors18() {
    AssertParse(
      ##"""
      _ = #^DIAG^#"hello\("""
                  world
                  """
                  )!"
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 4: unterminated string literal
      ]
    )
  }

  func testMultilineErrors19() {
    AssertParse(
      ##"""
      _ = #^DIAG^#"hello\(
                  """
                  world
                  """)!"
      """##,
      diagnostics: [
        // TODO: Old parser expected error on line 1: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 1: unterminated string literal
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 4: unterminated string literal
      ]
    )
  }

  func testMultilineErrors20() {
    AssertParse(
      ##"""
      _ = #^DIAG^#"""
        line one \ non-whitespace
        line two
        """
      """##,
      diagnostics: [
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 2: invalid escape sequence in literal
      ]
    )
  }

  func testMultilineErrors21() {
    AssertParse(
      #"""
      _ = """
        line one
        line two\
        """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: escaped newline at the last line is not allowed, Fix-It replacements: 11 - 12 = ''
      ]
    )
  }

  func testMultilineErrors22() {
    AssertParse(
      #"""
      _ = """
        \\\	   
        """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: escaped newline at the last line is not allowed, Fix-It replacements: 5 - 10 = ''
      ]
    )
  }

  func testMultilineErrors23() {
    AssertParse(
      #"""
      _ = """
        \(42)\		
        """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: escaped newline at the last line is not allowed, Fix-It replacements: 8 - 11 = ''
      ]
    )
  }

  func testMultilineErrors24() {
    AssertParse(
      #"""
      _ = """
        foo\
        """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: escaped newline at the last line is not allowed, Fix-It replacements: 6 - 7 = ''
      ]
    )
  }

  func testMultilineErrors25() {
    AssertParse(
      #"""
      _ = """
        foo\
        """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 3: escaped newline at the last line is not allowed, Fix-It replacements: 6 - 7 = ''
      ]
    )
  }

  func testMultilineErrors26() {
    AssertParse(
      ##"""
      _ = #^DIAG^#"""
        foo\
      """##,
      diagnostics: [
        DiagnosticSpec(message: "expected expression"),
        DiagnosticSpec(message: "extraneous code at top level"),
      ]
    )
  }

  func testMultilineErrors27() {
    AssertParse(
      #"""
      """ // OK because LF + CR is two new lines.#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"""' to end string literal"#),
      ]
    )
  }

  func testMultilineErrors28() {
    AssertParse(
      #"""
      _ = """
      \
        """
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 2: escaped newline at the last line is not allowed, Fix-It replacements: 1 - 2 = ''
        // TODO: Old parser expected error on line 2: insufficient indentation of line in multi-line string literal
        // TODO: Old parser expected note on line 2: change indentation of this line to match closing delimiter, Fix-It replacements: 1 - 1 = '  '
        // TODO: Old parser expected note on line 3: should match space here
      ]
    )
  }

  func testMultilineErrors29() {
    AssertParse(
      #"""
      _ = """\
        """
        // FIXME: Bad diagnostics
      """#,
      diagnostics: [
        // TODO: Old parser expected error on line 1: multi-line string literal content must begin on a new line
        // TODO: Old parser expected error on line 1: escaped newline at the last line is not allowed, Fix-It replacements: 8 - 9 = ''
      ]
    )
  }

  func testMultilineErrors30() {
    AssertParse(
      ##"""
      let _ = #^DIAG^#"""
        foo
        \("bar
        baz
        """
      """##,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in variable"),
        DiagnosticSpec(message: "extraneous code at top level"),
        // TODO: Old parser expected error on line 3: cannot find ')' to match opening '(' in string interpolation
        // TODO: Old parser expected error on line 3: unterminated string literal
      ]
    )
  }

}
