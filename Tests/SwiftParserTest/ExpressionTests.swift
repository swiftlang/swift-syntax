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

@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class ExpressionTests: XCTestCase {
  func testTernary() {
    assertParse(
      "let a =1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected expression in variable")
      ]
    )

    assertParse("a ? b : c ? d : e")
    assertParse(
      "a ? b :1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected expression after ternary operator")
      ]
    )
  }

  func testSequence() {
    assertParse(
      "A as? B + C -> D is E as! F ? G = 42 : H"
    )
  }

  func testClosureLiterals() {
    assertParse(
      #"""
      { @MainActor (a: Int) async -> Int in print("hi") }
      """#
    )

    assertParse(
      """
      { [weak self, weak weakB = b] foo in
        return 0
      }
      """
    )
  }

  func testTrailingClosures() {
    assertParse(
      """
      var button =  View.Button[5, 4, 3
      ] {
        // comment #0
        Text("ABC")
      }
      """
    )

    assertParse("compactMap { (parserDiag) in }")
  }

  func testSequenceExpressions() {
    assertParse("await a()")
    assertParse(
      """
      async let child = testNestedTaskPriority(basePri: basePri, curPri: curPri)
      await child
      """
    )
  }

  func testNestedTypeSpecialization() {
    assertParse("Swift.Array<Array<Foo>>()")
  }

  func testObjectLiterals() {
    assertParse(
      """
      #colorLiteral()
      #colorLiteral(red: 1.0)
      #colorLiteral(red: 1.0, green: 1.0)
      #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      """
    )

    assertParse(
      """
      #imageLiteral()
      #imageLiteral(resourceName: "foo.png")
      #imageLiteral(resourceName: "foo/bar/baz/qux.png")
      #imageLiteral(resourceName: "foo/bar/baz/quux.png")
      """
    )
  }

  func testKeypathExpression() {
    assertParse(
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

    assertParse(
      #"""
      children.filter(\.type.defaultInitialization.isEmpty)
      """#
    )

    assertParse(
      #"""
      \a
      cℹ️[1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: "expected value and ']' to end subscript")
      ]
    )

    assertParse(
      #"""
      _ = \Lens<[Int]>.[0]
      """#
    )

    assertParse(
      #"""
      \(UnsafeRawPointer?, String).1
      """#
    )

    assertParse(
      #"""
      \a.b.c
      """#
    )

    assertParse(
      #"""
      \ABCProtocol[100]
      """#
    )

    assertParse(
      #"""
      \S<T>.x
      """#
    )

    assertParse(
      #"""
      \TupleProperties.self
      """#
    )

    assertParse(
      #"""
      \Tuple<Int, Int>.self
      """#
    )

    assertParse(
      #"""
      \T.extension
      """#
    )

    assertParse(
      #"""
      \T.12[14]
      """#
    )

    assertParse(
      #"""
      \String?.!.count.?
      """#
    )

    assertParse(
      #"""
      \Optional.?!?!?!?
      """#
    )

    assertParse(
      #"""
      \Optional.?!?!?!?.??!
      """#
    )

    assertParse(
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

      assertParse(
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
    assertParse(
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

  func testInitializerExpression() {
    assertParse("Lexer.Cursor(input: input, previous: 0)")
  }

  func testCollectionLiterals() {
    assertParse("[Dictionary<String, Int>: Int]()")
    assertParse("[(Int, Double) -> Bool]()")
    assertParse("[(Int, Double) -> Bool]()")
    assertParse("_ = [@convention(block) ()  -> Int]().count")
    assertParse("A<@convention(c) () -> Int32>.c()")
    assertParse("A<(@autoclosure @escaping () -> Int, Int) -> Void>.c()")
    assertParse("_ = [String: (@escaping (A<B>) -> Int) -> Void]().keys")

    assertParse(
      """
      [
        condition ? firstOption : secondOption,
        bar(),
      ]
      """
    )

    assertParse(
      """
      [1️⃣
        ,2️⃣
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected value in array element"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ']' to end array"),
      ]
    )

    assertParse(
      """
      ([1:1️⃣)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value in dictionary element"),
        DiagnosticSpec(message: "expected ']' to end dictionary"),
      ]
    )

    assertParse(
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

    assertParse(
      """
      #fancyMacro<Arg1, Arg2>(hello: "me")
      """
    )
  }

  func testInterpolatedStringLiterals() {
    assertParse(
      #"""
      return "Fixit: \(range.debugDescription) Text: \"\(text)\""
      """#
    )

    assertParse(
      #"""
      "text \(array.map({ "\($0)" }).joined(separator: ",")) text"
      """#
    )

    assertParse(
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

    assertParse(
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
    assertParse(
      #"""
      "–"
      """#
    )

    assertParse(
      #"""
      ""
      """#
    )

    assertParse(
      #"""
      """
      """
      """#
    )

    assertParse(
      #"""
      " >> \( abc 1️⃣} ) << "
      """#,
      diagnostics: [
        DiagnosticSpec(message: "unexpected brace in string literal")
      ]
    )

    assertParse(
      ##"""


      #"Hello World"#

      "Hello World"


      """##
    )

    assertParse(
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

    assertParse(
      #"""
      "(?i)\\b((?:[a-z][\\w-]+:(?:/{1,3}|[a-z0-9%])|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)" +
      "(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*" +
      "\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"
      """#
    )

    assertParse(
      #"""
      """
          Custom(custom: \(interval),\
          Expr: \(pause?.debugDescription ?? "–"), \
          PlainWithContinuation: \(countdown), \
          Plain: \(units))"
      """
      """#
    )

    assertParse(
      #"""
      "Founded: \(Date.appleFounding, format: 📆)"
      """#
    )

    assertParse(
      """

      ""
      """
    )

    assertParse(
      ##"""
      #"""#
      """##
    )

    assertParse(
      ##"""
      #"""""#
      """##
    )

    assertParse(
      ##"""
      #"""
      multiline raw
      """#
      """##
    )

    assertParse(
      #"""
      "\(x)"
      """#
    )

    assertParse(
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
      ],
      fixedSource: ##"""
        """"
        """
        """##
    )

    assertParse(
      ##"""
      ℹ️"""""1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(
          message: #"expected '"""' to end string literal"#,
          notes: [NoteSpec(message: #"to match this opening '"""'"#)],
          fixIts: [#"insert '"""'"#]
        )
      ],
      fixedSource: ##"""
        """""
        """
        """##
    )

    assertParse(
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

    assertParse(
      ##"""
      #"1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"#' to end string literal"##, notes: [])
      ]
    )

    assertParse(
      ##"""
      #"""1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"""#' to end string literal"##, fixIts: [##"insert '"""#'"##])
      ],
      fixedSource: ##"""
        #"""
        """#
        """##
    )

    assertParse(
      ##"""
      #"""a1️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(message: ##"expected '"""#' to end string literal"##, fixIts: [##"insert '"""#'"##])
      ],
      fixedSource: ##"""
        #"""a
        """#
        """##
    )

    assertParse(
      ###""1️⃣\2️⃣"###,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "invalid escape sequence in literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testAdjacentRawStringLiterals() {
    assertParse(
      """
      "normal literal"
      #"raw literal"#
      """
    )

    assertParse(
      """
      #"raw literal"#
      #"second raw literal"#
      """
    )
  }

  func testSingleQuoteStringLiteral() {
    assertParse(
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

    assertParse(
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
    assertParse(
      ##"""
      \1️⃣\(2️⃣
      """##,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected root in key path"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end tuple type"),
      ]
    )

    assertParse(
      ##"""
      #"\\("#
      """##
    )

    assertParse(
      #"""
      "1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )

    assertParse(
      #"""
      "'1️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"expected '"' to end string literal"#)
      ]
    )
  }

  func testPoundsInStringInterpolationWhereNotNecessary() {
    assertParse(
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
    assertParse(
      """
      array[]
      """
    )

    assertParse(
      """
      text[...]
      """
    )
  }

  func testMissingColonInTernary() {
    assertParse(
      "foo ? 11️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected ':' and expression after '? ...' in ternary expression")
      ]
    )
  }

  func testBogusKeypathBaseRecovery() {
    assertParse(
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

    assertParse(
      "#keyPath((b:1️⃣)2️⃣",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected value in tuple"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ')' to end macro expansion"),
      ]
    )
  }

  func testMissingArrowInArrowExpr() {
    assertParse(
      "[(Int) -> 1️⃣throws Int]()",
      diagnostics: [
        DiagnosticSpec(message: "'throws' must preceed '->'", fixIts: ["move 'throws' in front of '->'"])
      ],
      fixedSource: "[(Int) throws -> Int]()"
    )

    assertParse(
      "[(Int) -> 1️⃣async throws Int]()",
      diagnostics: [
        DiagnosticSpec(message: "'async throws' must preceed '->'", fixIts: ["move 'async throws' in front of '->'"])
      ],
      fixedSource: "[(Int) async throws -> Int]()"
    )

    assertParse(
      "let _ = [Int throws 1️⃣Int]()",
      diagnostics: [
        DiagnosticSpec(message: "expected '->' in array element")
      ]
    )
  }

  func testBogusThrowingTernary() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse("_move msg")
    assertParse("use(_move msg)")
    assertParse("_move msg")
    assertParse("let b = (_move self).buffer")
  }

  func testBorrowExpression() {
    assertParse("_borrow msg")
    assertParse("use(_borrow msg)")
    assertParse("_borrow msg")
    assertParse("let b = (_borrow self).buffer")
  }

  func testCodeCompletionExpressions() {
    assertParse(
      "if !1️⃣<#b1#> && !2️⃣<#b2#> {}",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
      ]
    )

    assertParse(
      "if 1️⃣<#test#> {}",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file")
      ]
    )

    assertParse(
      "if 1️⃣<#b1#>, 2️⃣<#b2#> {}",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
      ]
    )
  }

  func testKeywordApplyExpression() {
    assertParse(
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
    assertParse(
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
    assertParse(
      "reduce(0, 1️⃣+)",
      substructure: Syntax(TokenSyntax.binaryOperator("+")),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testBogusCaptureLists() {
    // N.B. This test ensures that capture list lookahead doesn't try to pair
    // the opening square bracket from the array literal with the closing
    // square bracket from the capture list.
    assertParse(
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
    assertParse(
      #"#file == $0.path"#
    )

    assertParse(
      #"let a = #embed("filename.txt")"#
    )

    assertParse(
      """
      #Test {
        print("This is a test")
      }
      """
    )
  }

  func testMacroExpansionExpressionWithKeywordName() {
    assertParse(
      "#case",
      substructure: Syntax(
        MacroExpansionExprSyntax(
          poundToken: .poundToken(),
          macro: .identifier("case"),
          argumentList: TupleExprElementListSyntax([])
        )
      )
    )
  }

  func testNewlineInInterpolationOfSingleLineString() {
    assertParse(
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
    assertParse(
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
    assertParse(
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

    assertParse(
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

    assertParse(
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
    assertParse(
      #"""
      "foo\(test("""
      bar
      """) )"
      """#
    )
  }

  func testEmptyLineInMultilineStringLiteral() {
    assertParse(
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

    assertParse(
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
    assertParse(
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
    assertParse(
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

    assertParse(
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

    assertParse(
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

    assertParse(
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
    assertParse(
      "a 1️⃣\u{a0}+ 2",
      diagnostics: [
        DiagnosticSpec(message: "non-breaking space (U+00A0) used instead of regular space", severity: .warning, fixIts: ["replace non-breaking space with ' '"])
      ],
      fixedSource: "a  + 2"
    )
  }

  func testTabsIndentationInMultilineStringLiteral() {
    assertParse(
      #"""
      _ = """
      \#taq
      \#t"""
      """#
    )
  }

  func testMixedIndentationInMultilineStringLiteral() {
    assertParse(
      #"""
      _ = """
      \#t aq
      \#t """
      """#
    )
  }

  func testNulCharacterInSourceFile() {
    assertParse(
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
      assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      try switch Bool.random() { case true: 0 case false: 1 }
      """,
      substructure: Syntax(
        TryExprSyntax(expression: switchRandomZeroOne())
      )
    )
  }
  func testTrySwitch2() {
    assertParse(
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
    assertParse(
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
    assertParse(
      """
      await switch Bool.random() { case true: 0 case false: 1 }
      """,
      substructure: Syntax(
        AwaitExprSyntax(expression: switchRandomZeroOne())
      )
    )
  }
  func testAwaitSwitch2() {
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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
    assertParse(
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

  func testPatternExprInSwitchCaseItem() {
    assertParse(
      """
      switch x {
      case a:
      1️⃣is
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected 'is' keyword in 'switch' statement")
      ]
    )
  }

  func testStandaloneAtCaseInSwitch() {
    assertParse(
      """
      switch x {
        1️⃣@case
      }
      """,
      diagnostics: [DiagnosticSpec(message: "unexpected code '@case' in 'switch' statement")]
    )
  }

  func testUnterminatedInterpolationAtEndOfMultilineStringLiteral() {
    assertParse(
      #"""
      """1️⃣\({(2️⃣})
      """
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "multi-line string literal content must begin on a new line"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected value and ')' to end tuple"),
      ]
    )
  }

  func testUnterminatedString1() {
    assertParse(
      #"""
      "abc1️⃣
      "2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testUnterminatedString2() {
    assertParse(
      #"""
      "1️⃣
      "2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testUnterminatedString3() {
    assertParse(
      #"""
      "abc1️⃣
      \(def)2️⃣"3️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testUnterminatedString4() {
    assertParse(
      #"""
      "abc\(def1️⃣2️⃣
      3️⃣)"
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' in string literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "3️⃣", message: #"extraneous code ')"' at top level"#),
      ]
    )
  }

  func testUnterminatedString5() {
    assertParse(
      #"""
      "abc\(1️⃣2️⃣
      def3️⃣)"
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected value and ')' in string literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "3️⃣", message: #"extraneous code ')"' at top level"#),
      ]
    )
  }

  func testUnterminatedString6() {
    assertParse(
      #"""
      "abc1️⃣\2️⃣
      (def)3️⃣"4️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "invalid escape sequence in literal"),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
        DiagnosticSpec(locationMarker: "3️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "4️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testUnterminatedString7() {
    assertParse(
      #"""
      #1️⃣
      "abc"2️⃣#3️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected identifier in macro expansion"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "expected identifier in macro expansion"),
      ]
    )
  }

  func testUnterminatedString8() {
    assertParse(
      #"""
      #"1️⃣
      abc2️⃣"#3️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: ##"expected '"#' to end string literal"##),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "3️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testUnterminatedString9() {
    assertParse(
      #"""
      #"abc1️⃣
      "#2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: ##"expected '"#' to end string literal"##),
        DiagnosticSpec(locationMarker: "2️⃣", message: #"expected '"' to end string literal"#),
      ]
    )
  }

  func testUnterminatedString10() {
    assertParse(
      #"""
      #"abc"1️⃣
      #2️⃣
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: ##"expected '"#' to end string literal"##),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected identifier in macro expansion"),
      ]
    )
  }

  func testTriviaEndingInterpolation() {
    assertParse(
      #"""
      "abc\(def )"
      """#
    )
  }

  func testConsecutiveStatements1() {
    assertParse(
      "{a1️⃣ b2️⃣ c}",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testConsecutiveStatements2() {
    assertParse(
      "switch x {case y: a1️⃣ b2️⃣ c}",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testConsecutiveStatements3() {
    assertParse(
      """
      var i: Int { a1️⃣ b2️⃣ c }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testConsecutiveStatements4() {
    assertParse(
      """
      var i: Int { get {a1️⃣ b} set {c2️⃣ d} }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "consecutive statements on a line must be separated by ';'"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "consecutive statements on a line must be separated by ';'"),
      ]
    )
  }

  func testInitCallInPoundIf() {
    // MaSources/SwiftSyntax/generated/syntaxNodes/SyntaxTypeNodes.swiftke sure we parse 'init()' as an expr, not a decl.
    assertParse(
      """
      class C {
      init() {
      #if true
        init()
      #endif
      }
      }
      """,
      substructure: Syntax(
        FunctionCallExprSyntax(
          calledExpression: IdentifierExprSyntax(identifier: .keyword(.init("init")!)),
          leftParen: .leftParenToken(),
          argumentList: TupleExprElementListSyntax([]),
          rightParen: .rightParenToken()
        )
      )
    )
  }

  func testUnexpectedCloseBraceInPoundIf() {
    assertParse(
      """
      #if true
      1️⃣}
      class C {}
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected brace before class")
      ]
    )
  }

  func testStringLiteralAfterKeyPath() {
    assertParse(
      #"""
      \String.?1️⃣""
      """#,
      diagnostics: [
        DiagnosticSpec(message: "consecutive statements on a line must be separated by ';'")
      ]
    )
  }

  func testClosureParameterWithModifier() {
    assertParse(
      """
      _ = { (_const x: Int) in }
      """
    )
  }

  func testClosureWithExternalParameterName() {
    assertParse(
      """
      _ = { (_ x: MyType) in }
      """
    )

    // Using anything but '_' for the first parameter name is valid in SwiftSyntax
    // but should be diagnosed in the compiler.
    assertParse(
      """
      _ = { (x y: MyType) in }
      """
    )
  }

  func testClosureParameterWithAttribute() {
    assertParse("_ = { (@_noImplicitCopy _ x: Int) -> () in }")

    assertParse("_ = { (@Wrapper x) in }")
  }
}
