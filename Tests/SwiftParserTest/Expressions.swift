@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class ExpressionTests: XCTestCase {
  func testTernary() {
    AssertParse(
      "let a =#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "expected expression in variable")
      ]
    )

    AssertParse("a ? b : c ? d : e")
    AssertParse(
      "a ? b :#^DIAG^#",
      diagnostics: [
        DiagnosticSpec(message: "expected expression")
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
      c#^NOTE^#[#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected value in subscript"),
        DiagnosticSpec(message: "expected ']' to end subscript", notes: [
          NoteSpec(message: "to match this opening '['")
        ]),
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

    AssertParse(
      #"""
      \a.b.c
      """#
    )

    AssertParse(
      #"""
      \ABCProtocol[100]
      """#
    )

    AssertParse(
      #"""
      \S<T>.x
      """#
    )

    AssertParse(
      #"""
      \TupleProperties.self
      """#
    )

    AssertParse(
      #"""
      \Tuple<Int, Int>.self
      """#
    )

    AssertParse(
      #"""
      \T.extension
      """#
    )

    AssertParse(
      #"""
      \T.12[14]
      """#
    )

    AssertParse(
      #"""
      \String?.!.count.?
      """#
    )

    AssertParse(
      #"""
      \Optional.?!?!?!?
      """#
    )

    AssertParse(
      #"""
      \Optional.?!?!?!?.??!
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
        DiagnosticSpec(locationMarker: "EXPECTED_EXPR", message: "expected value in array element"),
        DiagnosticSpec(locationMarker: "END_ARRAY", message: "expected ']' to end array"),
      ]
    )

    AssertParse(
      """
      ([1:#^DIAG^#)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value in dictionary element"),
        DiagnosticSpec(message: "expected ']' to end dictionary"),
      ]
    )

    AssertParse(
      """
      [
        #line : Calendar(identifier: .gregorian),
        #^STRUCTURE^##line : Calendar(identifier: .buddhist),
      ]
      """,
      substructure: Syntax(DictionaryElementSyntax.init(
        keyExpression: ExprSyntax(PoundLineExprSyntax(poundLine: .poundLineKeyword())),
        colon: .colonToken(),
        valueExpression: ExprSyntax(FunctionCallExprSyntax(
          calledExpression: ExprSyntax(IdentifierExprSyntax(identifier: .identifier("Calendar"), declNameArguments: nil)),
          leftParen: .leftParenToken(),
          argumentList: TupleExprElementListSyntax([
            TupleExprElementSyntax(
              label: .identifier("identifier"),
              colon: .colonToken(),
              expression: ExprSyntax(MemberAccessExprSyntax(
                base: nil,
                dot: .prefixPeriodToken(),
                name: .identifier("buddhist"),
                declNameArguments: nil)),
              trailingComma: nil)
          ]),
          rightParen: .rightParenToken(),
          trailingClosure: nil,
          additionalTrailingClosures: nil)),
        trailingComma: .commaToken())),
    substructureAfterMarker: "STRUCTURE")
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
        DiagnosticSpec(message: #"extraneous '"\(()' at top level"#)
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
        DiagnosticSpec(message: "unexpected text '}' in string literal")
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
      #^NOTE^#"\",#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#, notes: [
          NoteSpec(message: #"to match this opening '"'"#)
        ])
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
       #^NOTE^#""""#^DIAG^#
       """##,
       diagnostics: [
         DiagnosticSpec(message: #"expected '"""' to end string literal"#, notes: [
          NoteSpec(message: #"to match this opening '"""'"#)
         ])
       ]
     )

    AssertParse(
       ##"""
       """""#^DIAG^#
       """##,
       diagnostics: [
         DiagnosticSpec(message: #"expected '"""' to end string literal"#)
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
      #^NOTE^##"#^DIAG^#
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"#' to end string literal"##, notes: []),
      ]
    )

    AssertParse(
      ##"""
      #"""#^DIAG^#
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"""#' to end string literal"##),
      ]
    )

    AssertParse(
      ##"""
      #"""a#^DIAG^#
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"""#' to end string literal"##),
      ]
    )

    AssertParse(
      ###"#^DIAG^#"\"###,
      diagnostics: [
        DiagnosticSpec(message: "extraneous '\"\\' at top level")
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
        DiagnosticSpec(locationMarker: "AFTER_SLASH", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "AFTER_PAREN", message: "expected ')' to end tuple type"),
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
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )

    AssertParse(
      #"""
      "'#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )
  }

  func testSubscript() {
    AssertParse(
      """
      array[]
      """
    )

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
        DiagnosticSpec(message: "expected ':' after '? ...' in ternary expression"),
        DiagnosticSpec(message: "expected expression"),
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
        DiagnosticSpec(locationMarker: "END", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "END", message: "expected '}' to end 'if' statement"),
        DiagnosticSpec(locationMarker: "END", message: "expected '}' to end function"),
      ]
    )

    AssertParse("#keyPath(#^DIAG^#(b:#^MISSING_VALUE^#)",
                diagnostics: [
                  DiagnosticSpec(message: "expected identifier in '#keyPath' expression"),
                  DiagnosticSpec(message: "expected ')' to end '#keyPath' expression"),
                  DiagnosticSpec(locationMarker: "MISSING_VALUE", message: "expected value in function call"),
                ])
  }

  func testMissingArrowInArrowExpr() {
    AssertParse(
      "[(Int) -> #^DIAG^#throws Int]()",
      diagnostics: [
        // FIXME: We should suggest to move 'throws' in front of '->'
        DiagnosticSpec(message: "expected expression in array element"),
        DiagnosticSpec(message: "unexpected text 'throws Int' in array"),
      ]
    )

    AssertParse(
      "let _ = [Int throws #^DIAG^#Int]()",
      diagnostics: [
        DiagnosticSpec(message: "expected '->' in array element")
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
        DiagnosticSpec(message: "expected expression in 'do' statement")
      ]
    )
  }

  func testClosureExpression() {
    AssertParse(
      """
      let #^VAR_NAME^#:(#^DIAG_1^#..)->#^END^#
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "VAR_NAME", message: "expected pattern in variable"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "expected type in function type"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "unexpected text '..' in function type"),
        DiagnosticSpec(locationMarker: "END", message: "expected type in function type"),
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
        DiagnosticSpec(locationMarker: "END", message: "expected expression")
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

  func testBogusCaptureLists() {
    // N.B. This test ensures that capture list lookahead doesn't try to pair
    // the opening square bracket from the array literal with the closing
    // square bracket from the capture list.
    AssertParse(
      """
      {
          [
              AboutItem(title: TextContent.legalAndMore, accessoryType: .disclosureIndicator, action: { [weak self] context in
                  self?.tracker.buttonPressed(.legal)
                  context.showSubmenu(title: TextContent.legalAndMore, configuration: LegalAndMoreSubmenuConfiguration())
              }),
          ]
      }()
      """)
  }
}
