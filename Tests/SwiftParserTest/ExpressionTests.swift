//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class ExpressionTests: XCTestCase {
  func testTernary() {
    AssertParse(
      "let a =1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected expression in variable")
      ]
    )

    AssertParse("a ? b : c ? d : e")
    AssertParse(
      "a ? b :1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected expression after ternary operator")
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
      """
    )
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
      \.?.foo
      """#,
      substructure: Syntax(
        CodeBlockItemListSyntax([
          CodeBlockItemSyntax(
            item: .init(
              KeyPathExprSyntax(
                backslash: .backslashToken(),
                components: KeyPathComponentListSyntax([
                  KeyPathComponentSyntax(
                    period: .periodToken(),
                    component: .init(
                      KeyPathOptionalComponentSyntax(
                        questionOrExclamationMark: .postfixQuestionMarkToken()
                      )
                    )
                  ),
                  KeyPathComponentSyntax(
                    period: .periodToken(),
                    component: .init(
                      KeyPathPropertyComponentSyntax(
                        identifier: .identifier("foo")
                      )
                    )
                  ),
                ])
              )
            )
          )
        ])
      )
    )

    AssertParse(
      #"""
      children.filter(\.type.defaultInitialization.isEmpty)
      """#
    )

    AssertParse(
      #"""
      \a
      cℹ️[1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected value and ']' to end subscript")
      ]
    )

    AssertParse(
      #"""
      _ = \Lens<[Int]>.[0]
      """#
    )

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

    AssertParse(
      #"""
      _ = distinctUntilChanged(\ .?.status)
      _ = distinctUntilChanged(\.?.status)
      """#
    )
  }

  func testKeypathExpressionWithSugaredRoot() {
    let cases: [UInt: String] = [
      // Identifiers
      #line: "X",
      #line: "X<T>",

      // Sugared optionals
      #line: "X?",
      #line: "X!",

      // Sugared collections
      #line: "[X]",
      #line: "[X : Y]",

      // Tuples and paren type
      #line: "()",
      #line: "(X)",
      #line: "(X, X)",

      // Keywords
      #line: "Any",
      #line: "Self",
    ]

    for (line, rootType) in cases {
      var parser = Parser(rootType)

      AssertParse(
        "\\\(rootType).y",
        ExprSyntax.parse,
        substructure: Syntax(
          KeyPathExprSyntax(
            root: TypeSyntax.parse(from: &parser),
            components: KeyPathComponentListSyntax([
              KeyPathComponentSyntax(
                period: .periodToken(),
                component: .init(
                  KeyPathPropertyComponentSyntax(identifier: .identifier("y"))
                )
              )
            ])
          )
        ),
        line: line
      )
    }
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

      func f() {
        return #function
      }
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
      [1️⃣
        ,2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected value in array element"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ']' to end array"),
      ]
    )

    AssertParse(
      """
      ([1:1️⃣)
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
        1️⃣#line : Calendar(identifier: .buddhist),
      ]
      """,
      substructure: Syntax(
        DictionaryElementSyntax.init(
          keyExpression: MacroExpansionExprSyntax(
            poundToken: .poundToken(),
            macro: .identifier("line"),
            argumentList: TupleExprElementListSyntax([])
          ),
          colon: .colonToken(),
          valueExpression: FunctionCallExprSyntax(
            calledExpression: IdentifierExprSyntax(identifier: .identifier("Calendar")),
            leftParen: .leftParenToken(),
            argumentList: TupleExprElementListSyntax([
              TupleExprElementSyntax(
                label: .identifier("identifier"),
                colon: .colonToken(),
                expression: MemberAccessExprSyntax(
                  dot: .periodToken(),
                  name: .identifier("buddhist")
                )
              )
            ]),
            rightParen: .rightParenToken()
          ),
          trailingComma: .commaToken()
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    AssertParse(
      """
      #fancyMacro<Arg1, Arg2>(hello: "me")
      """
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
      "\(()1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected ')' in string literal"#),
        DiagnosticSpec(message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testStringLiterals() {
    AssertParse(
      #"""
      "–"
      """#
    )

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
      " >> \( abc 1️⃣} ) << "
      """#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected brace in string literal")
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
      ℹ️"\",1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(
          message: #"expected '"' to end string literal"#,
          notes: [
            NoteSpec(message: #"to match this opening '"'"#)
          ]
        )
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
      ℹ️""""1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          message: #"expected '"""' to end string literal"#,
          notes: [
            NoteSpec(message: #"to match this opening '"""'"#)
          ]
        )
      ]
    )

    AssertParse(
      ##"""
      """""1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"""' to end string literal"#)
      ]
    )

    AssertParse(
      ##"""
      """1️⃣"""
      """##,
      diagnostics: [
        DiagnosticSpec(message: "multi-line string literal closing delimiter must begin on a new line")
      ],
      fixedSource: ##"""
        """
        """
        """##
    )

    AssertParse(
      ##"""
      #"1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"#' to end string literal"##, notes: [])
      ]
    )

    AssertParse(
      ##"""
      #"""1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"""#' to end string literal"##)
      ]
    )

    AssertParse(
      ##"""
      #"""a1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"""#' to end string literal"##)
      ]
    )

    AssertParse(
      ###""1️⃣\2️⃣"###,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "invalid escape sequence in literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testAdjacentRawStringLiterals() {
    AssertParse(
      """
      "normal literal"
      #"raw literal"#
      """
    )

    AssertParse(
      """
      #"raw literal"#
      #"second raw literal"#
      """
    )
  }

  func testSingleQuoteStringLiteral() {
    AssertParse(
      #"""
      1️⃣'red'
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Single-quoted string literal found, use '"'"#, fixIts: [#"replace ''' with '"'"#])
      ],
      fixedSource: """
        "red"
        """
    )

    AssertParse(
      #"""
       1️⃣' red ' + 1
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Single-quoted string literal found, use '"'"#, fixIts: [#"replace ''' with '"'"#])
      ],
      fixedSource: """
         " red " + 1
        """
    )
  }

  func testStringBogusClosingDelimiters() {
    AssertParse(
      ##"""
      \1️⃣\(2️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end tuple type"),
      ]
    )

    AssertParse(
      ##"""
      #"\\("#
      """##
    )

    AssertParse(
      #"""
      "1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )

    AssertParse(
      #"""
      "'1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )
  }

  func testPoundsInStringInterpolationWhereNotNecessary() {
    AssertParse(
      ##"""
      "1️⃣\#(1)"
      """##,
      substructure: Syntax(StringSegmentSyntax(content: .stringSegment(##"\#(1)"##))),
      diagnostics: [
        DiagnosticSpec(message: "invalid escape sequence in literal")
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
      "foo ? 11️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression")
      ]
    )
  }

  func testBogusKeypathBaseRecovery() {
    AssertParse(
      #"""
      func nestThoseIfs() {
        \n
        if false != true {
          \n
          print1️⃣ "\(i)\"\n2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end 'if' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end function"),
      ]
    )

    AssertParse(
      "#keyPath((b:1️⃣)2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected value in tuple"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end macro expansion"),
      ]
    )
  }

  func testMissingArrowInArrowExpr() {
    AssertParse(
      "[(Int) -> 1️⃣throws Int]()",
      diagnostics: [
        DiagnosticSpec(message: "'throws' must preceed '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: "[(Int) throws -> Int]()"
    )

    AssertParse(
      "[(Int) -> 1️⃣async throws Int]()",
      diagnostics: [
        DiagnosticSpec(message: "'async throws' must preceed '->'", fixIts: ["move 'async throws' in front of '->'"])
      ],
      fixedSource: "[(Int) async throws -> Int]()"
    )

    AssertParse(
      "let _ = [Int throws 1️⃣Int]()",
      diagnostics: [
        DiagnosticSpec(message: "expected '->' in array element")
      ]
    )
  }

  func testBogusThrowingTernary() {
    AssertParse(
      """
      do {
        true ? () : 1️⃣throw opaque_error()
      } catch _ {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after ternary operator")
      ]
    )
  }

  func testClosureExpression() {
    AssertParse(
      """
      let 1️⃣:(2️⃣..)->3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected pattern in variable"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected type in function type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '..' in function type"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected return type in function type"),
      ]
    )
  }

  func testParseArrowExpr() {
    AssertParse(
      "Foo 1️⃣async ->2️⃣",
      { ExprSyntax.parse(from: &$0) },
      substructure: Syntax(TokenSyntax.keyword(.async)),
      substructureAfterMarker: "1️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected expression")
      ]
    )
  }

  func testMoveExpression() {
    AssertParse("_move msg")
    AssertParse("use(_move msg)")
    AssertParse("_move msg")
    AssertParse("let b = (_move self).buffer")
  }

  func testBorrowExpression() {
    AssertParse("_borrow msg")
    AssertParse("use(_borrow msg)")
    AssertParse("_borrow msg")
    AssertParse("let b = (_borrow self).buffer")
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
      """
    )
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
      """###
    )
  }

  func testOperatorReference() {
    AssertParse(
      "reduce(0, 1️⃣+)",
      substructure: Syntax(TokenSyntax.binaryOperator("+")),
      substructureAfterMarker: "1️⃣"
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
      """
    )
  }

  func testMacroExpansionExpression() {
    AssertParse(
      #"#file == $0.path"#
    )

    AssertParse(
      #"let a = #embed("filename.txt")"#
    )

    AssertParse(
      """
      #Test {
        print("This is a test")
      }
      """
    )
  }

  func testNewlineInInterpolationOfSingleLineString() {
    AssertParse(
      #"""
      "test \(label:1️⃣
      foo2️⃣)"
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected value in string literal"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' in string literal"),
        DiagnosticSpec(locationMarker: "1️⃣", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"extraneous code ')"' at top level"#),
      ]
    )
  }

  func testUnterminatedStringLiteral() {
    AssertParse(
      """
      "This is unterminated1️⃣
      x
      """,
      substructure: Syntax(
        StringLiteralExprSyntax(
          openQuote: .stringQuoteToken(),
          segments: StringLiteralSegmentsSyntax([
            .stringSegment(StringSegmentSyntax(content: .stringSegment("This is unterminated")))
          ]),
          closeQuote: .stringQuoteToken(presence: .missing)
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )
  }

  func testPostProcessMultilineStringLiteral() {
    AssertParse(
      #"""
        """
        line 1
        line 2
        """
      """#,
      substructure: Syntax(
        StringLiteralExprSyntax(
          openQuote: .multilineStringQuoteToken(leadingTrivia: .spaces(2), trailingTrivia: .newline),
          segments: StringLiteralSegmentsSyntax([
            .stringSegment(StringSegmentSyntax(content: .stringSegment("line 1\n", leadingTrivia: .spaces(2)))),
            .stringSegment(StringSegmentSyntax(content: .stringSegment("line 2", leadingTrivia: .spaces(2), trailingTrivia: .newline))),
          ]),
          closeQuote: .multilineStringQuoteToken(leadingTrivia: .spaces(2))
        )
      ),
      options: [.substructureCheckTrivia]
    )

    AssertParse(
      #"""
        """
        line 1 \
        line 2
        """
      """#,
      substructure: Syntax(
        StringLiteralExprSyntax(
          openQuote: .multilineStringQuoteToken(leadingTrivia: .spaces(2), trailingTrivia: .newline),
          segments: StringLiteralSegmentsSyntax([
            .stringSegment(StringSegmentSyntax(content: .stringSegment("line 1 ", leadingTrivia: .spaces(2), trailingTrivia: [.backslashes(1), .newlines(1)]))),
            .stringSegment(StringSegmentSyntax(content: .stringSegment("line 2", leadingTrivia: .spaces(2), trailingTrivia: .newline))),
          ]),
          closeQuote: .multilineStringQuoteToken(leadingTrivia: .spaces(2))
        )
      ),
      options: [.substructureCheckTrivia]
    )

    AssertParse(
      #"""
        """
        line 1
        line 2 1️⃣\
        """
      """#,
      substructure: Syntax(
        StringLiteralExprSyntax(
          openQuote: .multilineStringQuoteToken(leadingTrivia: .spaces(2), trailingTrivia: .newline),
          segments: StringLiteralSegmentsSyntax([
            .stringSegment(StringSegmentSyntax(content: .stringSegment("line 1\n", leadingTrivia: .spaces(2)))),
            .stringSegment(
              StringSegmentSyntax(
                UnexpectedNodesSyntax([Syntax(TokenSyntax.stringSegment("  line 2 ", trailingTrivia: [.backslashes(1), .newlines(1)]))]),
                content: .stringSegment("line 2 ", leadingTrivia: .spaces(2), trailingTrivia: .newline, presence: .missing)
              )
            ),
          ]),
          closeQuote: .multilineStringQuoteToken(leadingTrivia: .spaces(2))
        )
      ),
      diagnostics: [
        DiagnosticSpec(message: "escaped newline at the last line of a multi-line string literal is not allowed")
      ],
      options: [.substructureCheckTrivia]
    )
  }

  func testMultiLineStringInInterpolationOfSingleLineStringLiteral() {
    // It's odd that we accept this but it matches the C++ parser's behavior.
    AssertParse(
      #"""
      "foo\(test("""
      bar
      """) )"
      """#
    )
  }

  func testEmptyLineInMultilineStringLiteral() {
    AssertParse(
      #"""
        """
        line 1

        line 2
        """
      """#,
      substructure: Syntax(
        StringLiteralExprSyntax(
          openDelimiter: nil,
          openQuote: .multilineStringQuoteToken(leadingTrivia: [.spaces(2)], trailingTrivia: .newline),
          segments: StringLiteralSegmentsSyntax([
            .stringSegment(StringSegmentSyntax(content: .stringSegment("line 1\n", leadingTrivia: [.spaces(2)]))),
            .stringSegment(StringSegmentSyntax(content: .stringSegment("\n"))),
            .stringSegment(StringSegmentSyntax(content: .stringSegment("line 2", leadingTrivia: [.spaces(2)], trailingTrivia: .newline))),
          ]),
          closeQuote: .multilineStringQuoteToken(leadingTrivia: [.spaces(2)]),
          closeDelimiter: nil
        )
      ),
      options: [.substructureCheckTrivia]
    )

    AssertParse(
      #"""
        """
        line 1

        """
      """#,
      substructure: Syntax(
        StringLiteralExprSyntax(
          openDelimiter: nil,
          openQuote: .multilineStringQuoteToken(leadingTrivia: [.spaces(2)], trailingTrivia: .newline),
          segments: StringLiteralSegmentsSyntax([
            .stringSegment(StringSegmentSyntax(content: .stringSegment("line 1\n", leadingTrivia: [.spaces(2)]))),
            .stringSegment(StringSegmentSyntax(content: .stringSegment("", trailingTrivia: .newline))),
          ]),
          closeQuote: .multilineStringQuoteToken(leadingTrivia: [.spaces(2)]),
          closeDelimiter: nil
        )
      ),
      options: [.substructureCheckTrivia]
    )
  }

  func testUnderIndentedWhitespaceonlyLineInMultilineStringLiteral() {
    AssertParse(
      #"""
        """
        line 1
       1️⃣
        line 2
        """
      """#,
      diagnostics: [
        DiagnosticSpec(message: "insufficient indentation of line in multi-line string literal")
      ],
      fixedSource: #"""
          """
          line 1
        \#("  ")
          line 2
          """
        """#
    )
  }

  func testMissingExpresssionInSequenceExpression() {
    AssertParse(
      """
      a ? b :1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after ternary operator")
      ],
      fixedSource: """
        a ? b : <#expression#>
        """
    )

    AssertParse(
      """
      a +1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression after operator")
      ],
      fixedSource: """
        a + <#expression#>
        """
    )

    AssertParse(
      """
      a as1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type after 'as'")
      ],
      fixedSource: """
        a as <#type#>
        """
    )

    AssertParse(
      """
      a is1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected type after 'is'")
      ],
      fixedSource: """
        a is <#type#>
        """
    )
  }

  func testNonBreakingSpace() {
    AssertParse(
      "a 1️⃣\u{a0}+ 2",
      diagnostics: [
        DiagnosticSpec(message: "non-breaking space (U+00A0) used instead of regular space", severity: .warning, fixIts: ["replace non-breaking space with ' '"])
      ],
      fixedSource: "a  + 2"
    )
  }

  func testTabsIndentationInMultilineStringLiteral() {
    AssertParse(
      #"""
      _ = """
      \#taq
      \#t"""
      """#
    )
  }

  func testMixedIndentationInMultilineStringLiteral() {
    AssertParse(
      #"""
      _ = """
      \#t aq
      \#t """
      """#
    )
  }

  func testNulCharacterInSourceFile() {
    AssertParse(
      "let a = 1️⃣\u{0}1",
      diagnostics: [
        DiagnosticSpec(message: "nul character embedded in middle of file", severity: .warning)
      ]
    )
  }
}

final class MemberExprTests: XCTestCase {
  func testMissing() {
    let cases: [UInt: String] = [
      #line: "",
      #line: "\nmember",
      #line: "  \nmember",
      #line: "/*foo*/\nmember",
      #line: "\n  member",
    ]
    for (line, trailing) in cases {
      AssertParse(
        "someVar.1️⃣\(trailing)",
        diagnostics: [DiagnosticSpec(message: "expected name in member access")],
        fixedSource: "someVar.<#identifier#>\(trailing)",
        line: line
      )
    }
  }
}

final class StatementExpressionTests: XCTestCase {
  private func ifZeroElseOne() -> ExprSyntax {
    .init(
      IfExprSyntax(
        conditions: [
          .init(
            condition: .expression(
              .init(
                FunctionCallExprSyntax(callee: MemberAccessExprSyntax(name: "random"))
              )
            )
          )
        ],
        body: .init(statements: [
          .init(item: .expr(.init(IntegerLiteralExprSyntax(0))))
        ]),
        elseKeyword: .keyword(.else),
        elseBody: .init(
          .codeBlock(
            .init(statements: [
              .init(item: .expr(.init(IntegerLiteralExprSyntax(1))))
            ])
          )
        )
      )
    )
  }
  private func switchRandomZeroOne() -> ExprSyntax {
    .init(
      SwitchExprSyntax(
        expression: FunctionCallExprSyntax(
          callee: MemberAccessExprSyntax(
            base: IdentifierExprSyntax(identifier: .identifier("Bool")),
            name: "random"
          )
        ),
        cases: [
          .switchCase(
            .init(
              label: .case(
                .init(caseItems: [
                  .init(pattern: ExpressionPatternSyntax(expression: BooleanLiteralExprSyntax(true)))
                ])
              ),
              statements: [
                .init(item: .expr(.init(IntegerLiteralExprSyntax(0))))
              ]
            )
          ),
          .switchCase(
            .init(
              label: .case(
                .init(caseItems: [
                  .init(pattern: ExpressionPatternSyntax(expression: BooleanLiteralExprSyntax(false)))
                ])
              ),
              statements: [
                .init(item: .expr(.init(IntegerLiteralExprSyntax(1))))
              ]
            )
          ),
        ]
      )
    )
  }
  func testIfExprInCoercion() {
    AssertParse(
      """
      func foo() {
        if .random() { 0 } else { 1 } as Int
      }
      """,
      substructure: Syntax(
        SequenceExprSyntax(
          elements: ExprListSyntax([
            ifZeroElseOne(),
            ExprSyntax(
              UnresolvedAsExprSyntax()
            ),
            ExprSyntax(
              TypeExprSyntax(type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("Int"))))
            ),
          ])
        )
      )
    )
  }
  func testSwitchExprInCoercion() {
    AssertParse(
      """
      switch Bool.random() { case true: 0 case false: 1 } as Int
      """,
      substructure: Syntax(
        SequenceExprSyntax(
          elements: ExprListSyntax([
            switchRandomZeroOne(),
            ExprSyntax(
              UnresolvedAsExprSyntax()
            ),
            ExprSyntax(
              TypeExprSyntax(type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("Int"))))
            ),
          ])
        )
      )
    )
  }
  func testIfExprInReturn() {
    AssertParse(
      """
      func foo() {
        return if .random() { 0 } else { 1 }
      }
      """,
      substructure: Syntax(
        ReturnStmtSyntax(expression: ifZeroElseOne())
      )
    )
  }
  func testSwitchExprInReturn() {
    AssertParse(
      """
      func foo() {
        return switch Bool.random() { case true: 0 case false: 1 }
      }
      """,
      substructure: Syntax(
        ReturnStmtSyntax(expression: switchRandomZeroOne())
      )
    )
  }
  func testTryIf1() {
    AssertParse(
      """
      func foo() -> Int {
        try if .random() { 0 } else { 1 }
      }
      """,
      substructure: Syntax(
        TryExprSyntax(expression: ifZeroElseOne())
      )
    )
  }
  func testTryIf2() {
    AssertParse(
      """
      func foo() -> Int {
        return try if .random() { 0 } else { 1 }
      }
      """,
      substructure: Syntax(
        ReturnStmtSyntax(expression: TryExprSyntax(expression: ifZeroElseOne()))
      )
    )
  }
  func testTryIf3() {
    AssertParse(
      """
      func foo() -> Int {
        let x = try if .random() { 0 } else { 1 }
        return x
      }
      """,
      substructure: Syntax(
        TryExprSyntax(expression: ifZeroElseOne())
      )
    )
  }
  func testAwaitIf1() {
    AssertParse(
      """
      func foo() async -> Int {
        await if .random() { 0 } else { 1 }
      }
      """,
      substructure: Syntax(
        AwaitExprSyntax(expression: ifZeroElseOne())
      )
    )
  }
  func testAwaitIf2() {
    AssertParse(
      """
      func foo() async -> Int {
        return await if .random() { 0 } else { 1 }
      }
      """,
      substructure: Syntax(
        ReturnStmtSyntax(expression: AwaitExprSyntax(expression: ifZeroElseOne()))
      )
    )
  }
  func testAwaitIf3() {
    AssertParse(
      """
      func foo() async -> Int {
        let x = await if .random() { 0 } else { 1 }
        return x
      }
      """,
      substructure: Syntax(
        AwaitExprSyntax(expression: ifZeroElseOne())
      )
    )
  }
  func testTrySwitch1() {
    AssertParse(
      """
      try switch Bool.random() { case true: 0 case false: 1 }
      """,
      substructure: Syntax(
        TryExprSyntax(expression: switchRandomZeroOne())
      )
    )
  }
  func testTrySwitch2() {
    AssertParse(
      """
      func foo() -> Int {
        return try switch Bool.random() { case true: 0 case false: 1 }
      }
      """,
      substructure: Syntax(
        ReturnStmtSyntax(expression: TryExprSyntax(expression: switchRandomZeroOne()))
      )
    )
  }
  func testTrySwitch3() {
    AssertParse(
      """
      func foo() -> Int {
        let x = try switch Bool.random() { case true: 0 case false: 1 }
        return x
      }
      """,
      substructure: Syntax(
        TryExprSyntax(expression: switchRandomZeroOne())
      )
    )
  }
  func testAwaitSwitch1() {
    AssertParse(
      """
      await switch Bool.random() { case true: 0 case false: 1 }
      """,
      substructure: Syntax(
        AwaitExprSyntax(expression: switchRandomZeroOne())
      )
    )
  }
  func testAwaitSwitch2() {
    AssertParse(
      """
      func foo() async -> Int {
        return await switch Bool.random() { case true: 0 case false: 1 }
      }
      """,
      substructure: Syntax(
        ReturnStmtSyntax(expression: AwaitExprSyntax(expression: switchRandomZeroOne()))
      )
    )
  }
  func testAwaitSwitch3() {
    AssertParse(
      """
      func foo() async -> Int {
        let x = await switch Bool.random() { case true: 0 case false: 1 }
        return x
      }
      """,
      substructure: Syntax(
        AwaitExprSyntax(expression: switchRandomZeroOne())
      )
    )
  }
  func testIfExprMultipleCoerce() {
    // We only allow coercions as a narrow case in the parser, so attempting to
    // double them up is invalid.
    AssertParse(
      """
      func foo() {
        if .random() { 0 } else { 1 } as Int 1️⃣as Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'as Int' in function")
      ]
    )
  }
  func testIfExprIs() {
    // We don't parse 'is Int'.
    AssertParse(
      """
      func foo() -> Bool {
        if .random() { 0 } else { 1 } 1️⃣is Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'is Int' in function")
      ]
    )
  }
  func testIfExprCondCast() {
    // We parse 'as? Int', but it will be a semantic error.
    AssertParse(
      """
      if .random() { 0 } else { 1 } as? Int
      """,
      substructure: Syntax(
        SequenceExprSyntax(
          elements: ExprListSyntax([
            ifZeroElseOne(),
            ExprSyntax(
              UnresolvedAsExprSyntax(questionOrExclamationMark: .postfixQuestionMarkToken())
            ),
            ExprSyntax(
              TypeExprSyntax(type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("Int"))))
            ),
          ])
        )
      )
    )
  }
  func testIfExprForceCast() {
    // We parse 'as! Int', but it will be a semantic error.
    AssertParse(
      """
      if .random() { 0 } else { 1 } as! Int
      """,
      substructure: Syntax(
        SequenceExprSyntax(
          elements: ExprListSyntax([
            ifZeroElseOne(),
            ExprSyntax(
              UnresolvedAsExprSyntax(questionOrExclamationMark: .exclamationMarkToken())
            ),
            ExprSyntax(
              TypeExprSyntax(type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("Int"))))
            ),
          ])
        )
      )
    )
  }
  func testSwitchExprMultipleCoerce() {
    // We only allow coercions as a narrow case in the parser, so attempting to
    // double them up is invalid.
    AssertParse(
      """
      func foo() {
        switch Bool.random() { case true: 0 case false: 1 } as Int 1️⃣as Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'as Int' in function")
      ]
    )
  }
  func testSwitchExprIs() {
    // We don't parse 'is Int'.
    AssertParse(
      """
      func foo() -> Bool {
        switch Bool.random() { case true: 0 case false: 1 } 1️⃣is Int
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code 'is Int' in function")
      ]
    )
  }
  func testSwitchExprCondCast() {
    // We parse 'as? Int', but it will be a semantic error.
    AssertParse(
      """
      switch Bool.random() { case true: 0 case false: 1 } as? Int
      """,
      substructure: Syntax(
        SequenceExprSyntax(
          elements: ExprListSyntax([
            switchRandomZeroOne(),
            ExprSyntax(
              UnresolvedAsExprSyntax(questionOrExclamationMark: .postfixQuestionMarkToken())
            ),
            ExprSyntax(
              TypeExprSyntax(type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("Int"))))
            ),
          ])
        )
      )
    )
  }
  func testSwitchExprForceCast() {
    // We parse 'as! Int', but it will be a semantic error.
    AssertParse(
      """
      switch Bool.random() { case true: 0 case false: 1 } as! Int
      """,
      substructure: Syntax(
        SequenceExprSyntax(
          elements: ExprListSyntax([
            switchRandomZeroOne(),
            ExprSyntax(
              UnresolvedAsExprSyntax(questionOrExclamationMark: .exclamationMarkToken())
            ),
            ExprSyntax(
              TypeExprSyntax(type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("Int"))))
            ),
          ])
        )
      )
    )
  }
}
