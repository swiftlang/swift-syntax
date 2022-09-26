@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class ExpressionTests: XCTestCase {
  func testTernary() {
    AssertParse(
      "let a =#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "Expected expression after '=' in variable")
      ]
    )

    AssertParse("a ? b : c ? d : e")
    AssertParse(
      "a ? b :#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "Expected expression after ':'")
      ]
    )
  }

  func testSequence() {
    AssertParse(
       "A as? B + C -> D is E as! F ? G = 42 : H"
    )
  }

  func testClosureLiterals() {
    AssertParse(
      #"""
      { @MainActor (a: Int) async -> Int in print("hi") }
      """#
    )

    AssertParse(
      """
      { [weak self, weak weakB = b] foo in
        return 0
      }
      """
    )
  }

  func testTrailingClosures() {
    AssertParse(
      """
      var button =  View.Button[5, 4, 3
      ] {
        // comment #0
        Text("ABC")
      }
      """
    )

    AssertParse("compactMap { (parserDiag) in }")
  }

  func testSequenceExpressions() {
    AssertParse("await a()")
    AssertParse(
      """
      async let child = testNestedTaskPriority(basePri: basePri, curPri: curPri)
      await child
      """)
  }

  func testNestedTypeSpecialization() {
    AssertParse("Swift.Array<Array<Foo>>()")
  }

  func testObjectLiterals() {
    AssertParse(
      """
      #colorLiteral()
      #colorLiteral(red: 1.0)
      #colorLiteral(red: 1.0, green: 1.0)
      #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      """
    )

    AssertParse(
      """
      #imageLiteral()
      #imageLiteral(resourceName: "foo.png")
      #imageLiteral(resourceName: "foo/bar/baz/qux.png")
      #imageLiteral(resourceName: "foo/bar/baz/quux.png")
      """
    )
  }

  func testKeypathExpression() {
    AssertParse(
      #"""
      children.filter(\.type.defaultInitialization.isEmpty)
      """#
    )

    AssertParse(
      #"""
      \a
      c[#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: "Expected value in subscript"),
        DiagnosticSpec(message: "Expected ']' to end subscript"),
      ]
    )

    AssertParse(
      #"""
      _ = \Lens<[Int]>.[0]
      """#)

    AssertParse(
      #"""
      \(UnsafeRawPointer?, String).1
      """#
    )
  }

  func testBasicLiterals() {
    AssertParse(
      """
      #file
      #fileID
      (#line)
      #column
      #function
      #dsohandle
      __FILE__
      __LINE__
      __COLUMN__
      __FUNCTION__
      __DSO_HANDLE__
      """
    )
  }

  func testRegexLiteral() {
    AssertParse(
      #"""
      /(?<identifier>[[:alpha:]]\w*) = (?<hex>[0-9A-F]+)/
      """#
    )
  }

  func testInitializerExpression() {
    AssertParse("Lexer.Cursor(input: input, previous: 0)")
  }

  func testCollectionLiterals() {
    AssertParse("[Dictionary<String, Int>: Int]()")
    AssertParse("[(Int, Double) -> Bool]()")
    AssertParse("[(Int, Double) -> Bool]()")
    AssertParse("_ = [@convention(block) ()  -> Int]().count")
    AssertParse("A<@convention(c) () -> Int32>.c()")
    AssertParse("A<(@autoclosure @escaping () -> Int, Int) -> Void>.c()")
    AssertParse("_ = [String: (@escaping (A<B>) -> Int) -> Void]().keys")

    AssertParse(
      """
      [
        condition ? firstOption : secondOption,
        bar(),
      ]
      """
    )

    AssertParse(
      """
      [#^EXPECTED_EXPR^#
        ,#^END_ARRAY^#
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "EXPECTED_EXPR", message: "Expected value of array element"),
        DiagnosticSpec(locationMarker: "END_ARRAY", message: "Expected ']' to end array"),
      ]
    )

    AssertParse(
      """
      ([1:#^DIAG^#)
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected value of dictionary element"),
        DiagnosticSpec(message: "Expected ']' to end dictionary"),
      ]
    )
  }

  func testInterpolatedStringLiterals() {
    AssertParse(
      #"""
      return "Fixit: \(range.debugDescription) Text: \"\(text)\""
      """#
    )

    AssertParse(
      #"""
      "text \(array.map({ "\($0)" }).joined(separator: ",")) text"
      """#
    )

    AssertParse(
      #"""
      """
      \(gen(xx) { (x) in
          return """
          case
      """
      })
      """
      """#
    )

    AssertParse(
      #"""
      #^DIAG^#"\(()
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Extraneous '"\(()' at top level"#)
      ]
    )
  }

  func testStringLiterals() {
    AssertParse(
      #"""
      ""
      """#
    )

    AssertParse(
      #"""
      """
      """
      """#
    )

    AssertParse(
      #"""
      " >> \( abc #^DIAG^#} ) << "
      """#,
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text '}' in string literal")
      ]
    )

    AssertParse(
      ##"""


      #"Hello World"#

      "Hello World"


      """##
    )

    AssertParse(
      #"""
      "\",#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"' in string literal"#)
      ]
    )

    AssertParse(
      #"""
      "(?i)\\b((?:[a-z][\\w-]+:(?:/{1,3}|[a-z0-9%])|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)" +
      "(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*" +
      "\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"
      """#
    )

    AssertParse(
      #"""
      """
          Custom(custom: \(interval),\
          Expr: \(pause?.debugDescription ?? "–"), \
          PlainWithContinuation: \(countdown), \
          Plain: \(units))"
      """
      """#
    )

    AssertParse(
      #"""
      "Founded: \(Date.appleFounding, format: 📆)"
      """#
    )

    AssertParse(
        """

        ""
        """
    )

    AssertParse(
      ##"""
      #"""#
      """##
    )

    AssertParse(
      ##"""
      #"""""#
      """##
    )

    AssertParse(
      ##"""
      #"""
      multiline raw
      """#
      """##
    )

    AssertParse(
      #"""
      "\(x)"
      """#
    )

    AssertParse(
       ##"""
       """"#^DIAG^#
       """##,
       diagnostics: [
         DiagnosticSpec(message: #"Expected '"""' in string literal"#)
       ]
     )

    AssertParse(
       ##"""
       """""#^DIAG^#
       """##,
       diagnostics: [
         DiagnosticSpec(message: #"Expected '"""' in string literal"#)
       ]
     )

    // FIXME: We currently don't enforce that multiline string literal
    // contents must start on a new line
    AssertParse(
       ##"""
       """"""#^DIAG^#
       """##
     )

    AssertParse(
      ##"""
      #"#^DIAG^#
      """##,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"' in string literal"#),
        DiagnosticSpec(message: #"Expected '#' in string literal"#)
      ]
    )

    AssertParse(
      ##"""
      #"""#^DIAG^#
      """##,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"""' in string literal"#),
        DiagnosticSpec(message: #"Expected '#' in string literal"#)
      ]
    )

    AssertParse(
      ##"""
      #"""a#^DIAG^#
      """##,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"""' in string literal"#),
        DiagnosticSpec(message: #"Expected '#' in string literal"#)
      ]
    )

    AssertParse(
      ###"#^DIAG^#"\"###,
      diagnostics: [
        DiagnosticSpec(message: "Extraneous '\"\\' at top level")
      ]
    )
  }

  func testSingleQuoteStringLiteral() {
    AssertParse(
      #"""
      'red'
      """#
    )
  }

  func testStringBogusClosingDelimiters() {
    AssertParse(
      ##"""
      \#^AFTER_SLASH^#\(#^AFTER_PAREN^#
      """##,
      diagnostics: [
        DiagnosticSpec(locationMarker: "AFTER_SLASH", message: "Expected root of key path"),
        DiagnosticSpec(locationMarker: "AFTER_SLASH", message: "Expected expression of key path"),
        DiagnosticSpec(locationMarker: "AFTER_PAREN", message: "Expected value in tuple"),
        DiagnosticSpec(locationMarker: "AFTER_PAREN", message: "Expected ')' to end tuple"),
        DiagnosticSpec(locationMarker: "AFTER_PAREN", message: "Expected expression of key path"),
      ]
    )

    AssertParse(
      ##"""
      #"\\("#
      """##
    )

    AssertParse(
      #"""
      "#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"' in string literal"#)
      ]
    )

    AssertParse(
      #"""
      "'#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"' in string literal"#)
      ]
    )
  }

  func testRangeSubscript() {
    AssertParse(
      """
      text[...]
      """
    )
  }

  func testMissingColonInTernary() {
    AssertParse(
      "foo ? 1#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "Expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(message: "Expected expression"),
      ]
    )
  }

  func testBogusKeypathBaseRecovery() {
    AssertParse(
      #"""
      func nestThoseIfs() {
        \n    #^KEY_PATH_1^#
        if false != true {
          \n       #^KEY_PATH_2^#
          print "\(i)\"\n#^END^#
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "KEY_PATH_1", message: "Expected expression of key path"),
        DiagnosticSpec(locationMarker: "KEY_PATH_2", message: "Expected expression of key path"),
        DiagnosticSpec(locationMarker: "END", message: #"Expected '"' in string literal"#),
        DiagnosticSpec(locationMarker: "END", message: "Expected '}' to end 'if' statement"),
        DiagnosticSpec(locationMarker: "END", message: "Expected '}' to end function"),
      ]
    )

    AssertParse("#keyPath(#^DIAG^#(b:#^MISSING_VALUE^#)",
                diagnostics: [
                  DiagnosticSpec(message: "Expected identifier in '#keyPath' expression"),
                  DiagnosticSpec(message: "Expected ')' to end '#keyPath' expression"),
                  DiagnosticSpec(locationMarker: "MISSING_VALUE", message: "Expected value in function call"),
                ])
  }

  func testMissingArrowInArrowExpr() {
    AssertParse(
      "[(Int) -> #^DIAG^#throws Int]()",
      diagnostics: [
        // FIXME: We should suggest to move 'throws' in front of '->'
        DiagnosticSpec(message: "Expected expression after '->' in array element"),
        DiagnosticSpec(message: "Unexpected text 'throws Int' in array"),
      ]
    )

    AssertParse(
      "let _ = [Int throws #^DIAG^#Int]()",
      diagnostics: [
        DiagnosticSpec(message: "Expected '->' in array element")
      ]
    )
  }

  func testBogusThrowingTernary() {
    AssertParse(
      """
      do {
        true ? () : #^DIAG^#throw opaque_error()
      } catch _ {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected expression after ':' in 'do' statement")
      ]
    )
  }

  func testClosureExpression() {
    AssertParse(
      """
      let #^VAR_NAME^#:(#^DIAG_1^#..)->#^END^#
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "VAR_NAME", message: "Expected pattern after 'let' in variable"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Expected type after '(' in function type"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Unexpected text '..' in function type"),
        DiagnosticSpec(locationMarker: "END", message: "Expected type after '->' in function type"),
      ]
    )
  }

  func testParseArrowExpr() {
    AssertParse(
      "Foo #^ASYNC^#async ->#^END^#",
      { $0.parseSequenceExpression(.basic, forDirective: false) },
      substructure: Syntax(TokenSyntax.contextualKeyword("async")),
      substructureAfterMarker: "ASYNC",
      diagnostics: [
        DiagnosticSpec(locationMarker: "END", message: "Expected expression after '->'")
      ]
    )
  }

  func testTypeExpression() {
    AssertParse("_ = (any Sequence<Int>).self")
  }

  func testMoveExpression() {
    AssertParse("_move msg")
    AssertParse("use(_move msg)")
    AssertParse("_move msg")
    AssertParse("let b = (_move self).buffer")
  }

  func testCodeCompletionExpressions() {
    AssertParse("if !<#b1#> && !<#b2#> {}")
    AssertParse("if <#test#> {}")
    AssertParse("if <#b1#>, <#b2#> {}")
  }

  func testKeywordApplyExpression() {
    AssertParse(
      """
      optional(x: .some(23))
      optional(x: .none)
      var pair : (Int, Double) = makePair(a: 1, b: 2.5)
      """)
  }

  // N.B. This test includes zero-width characters that may not render in most
  // text editors. Be very careful editing these strings.
  //
  // See https://github.com/apple/swift/issues/51192 for more context here.
  func testFalseMultilineDelimiters() {
    AssertParse(
      ###"""
      _ = #"​"​"#

      _ = #""""#

      _ = #"""""#

      _ = #""""""#

      _ = ##""" foo # "# "##
      """###)
  }

  func testOperatorReference() {
    AssertParse(
      "reduce(0, #^PLUS^#+)",
      substructure: Syntax(TokenSyntax.unspacedBinaryOperator("+")),
      substructureAfterMarker: "PLUS"
    )
  }
}
