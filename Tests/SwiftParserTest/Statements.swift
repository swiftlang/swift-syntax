@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class StatementTests: XCTestCase {
  func testIf() {
    AssertParse("""
                if let baz {}
                """,
                substructure: Syntax(IfStmtSyntax(ifKeyword: .ifKeyword(),
                                                  conditions: ConditionElementListSyntax([
                                                    ConditionElementSyntax(condition: Syntax(OptionalBindingConditionSyntax(
                                                      letOrVarKeyword: .letKeyword(),
                                                      pattern: PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("baz"))),
                                                      typeAnnotation: nil,
                                                      initializer: nil)), trailingComma: nil)
                                                  ]),
                                                  body: .init(leftBrace: .leftBraceToken(),
                                                              statements: .init([]),
                                                              rightBrace: .rightBraceToken()),
                                                  elseKeyword: nil, elseBody: nil)))

    AssertParse("""
                if let self = self {}
                """,
                substructure: Syntax(IfStmtSyntax(ifKeyword: .ifKeyword(),
                                                  conditions: ConditionElementListSyntax([
                                                    ConditionElementSyntax(condition: Syntax(OptionalBindingConditionSyntax(
                                                      letOrVarKeyword: .letKeyword(),
                                                      pattern: PatternSyntax(IdentifierPatternSyntax(identifier: .selfKeyword())),
                                                      typeAnnotation: nil,
                                                      initializer: InitializerClauseSyntax(equal: .equalToken(), value: ExprSyntax(IdentifierExprSyntax(identifier: .selfKeyword(), declNameArguments: nil))))), trailingComma: nil)
                                                  ]),
                                                  body: .init(leftBrace: .leftBraceToken(),
                                                              statements: .init([]),
                                                              rightBrace: .rightBraceToken()),
                                                  elseKeyword: nil, elseBody: nil)))

    AssertParse("if let x { }")

    AssertParse(
      """
      if case1️⃣* ! = x {
        bar()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression in pattern"),
        DiagnosticSpec(message: "expected '=' and expression in pattern matching"),
        DiagnosticSpec(message: "unexpected text '* ! = x' in 'if' statement"),
      ]
    )
  }

  func testNestedIfs() {
    let nest = 22
    var source = "func nestThoseIfs() {\n"
    for index in (0...nest) {
        let indent = String(repeating: "    ", count: index + 1)
        source += indent + "if false != true {\n"
        source += indent + "   print(\"\\(i)\")\n"
    }

    for index in (0...nest).reversed() {
        let indent = String(repeating: "    ", count: index + 1)
        source += indent + "}\n"
    }
    source += "}"
    AssertParse(source)
  }

  func testDo() {
    AssertParse(
       """
       do {

       }
       """
    )
  }

  func testDoCatch() {
    AssertParse(
       """
       do {

       } catch {

       }
       """
    )
  }

  func testReturn() {
    AssertParse("return actor", { $0.parseReturnStatement() })

    AssertParse(
      "{ 1️⃣return 0 }",
      { $0.parseClosureExpression() },
      substructure: Syntax(ReturnStmtSyntax(returnKeyword: .returnKeyword(),
                                            expression: ExprSyntax(IntegerLiteralExprSyntax(digits: .integerLiteral("0"))))),
      substructureAfterMarker: "1️⃣"
    )

    AssertParse("return")

    AssertParse(
       #"""
       return "assert(\(assertChoices.joined(separator: " || ")))"
       """#
    )

    AssertParse("return true ? nil : nil")

    AssertParse(
      """
      switch command {
      case .start:
        break

      case .stop:
        return

      default:
        break
      }
      """
    )
  }

  func testSwitch() {
    AssertParse(
      """
      switch x {
      case .A, .B:
        break
      }
      """
    )

    AssertParse(
      """
      switch 0 {
      @$dollar case _:
        break
      }
      """
    )

    AssertParse(
      """
      switch x {
      case .A:
        break
      case .B:
        break
      #if NEVER
      #elseif ENABLE_C
      case .C:
        break
      #endif
      }
      """
    )
  }

  func testCStyleForLoop() {
    AssertParse(
      """
      1️⃣for let x = 0; x < 10; x += 1, y += 1 {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "C-style for statement has been removed in Swift 3", highlight: "let x = 0; x < 10; x += 1, y += 1 ")
      ]
    )
  }

  func testTopLevelCaseRecovery() {
    AssertParse(
      "/*#-editable-code Swift Platground editable area*/1️⃣default/*#-end-editable-code*/",
      diagnostics: [
        DiagnosticSpec(message: "extraneous 'default' at top level")
      ]
    )

    AssertParse(
      "1️⃣case:",
      diagnostics: [
        DiagnosticSpec(message: "extraneous 'case:' at top level")
      ])

    AssertParse(
      #"""
      1️⃣case: { ("Hello World") }
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"extraneous 'case: { ("Hello World") }' at top level"#)
      ]
    )
  }

  func testMissingIfClauseIntroducer() {
    AssertParse("if _ = 42 {}")
  }

  func testAttributesOnStatements() {
    AssertParse(
      """
      func test1() {
        1️⃣@s return
      }
      func test2() {
        2️⃣@unknown return
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text '@s return' in function"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text '@unknown return' in function")
      ]
    )
  }

  func testBogusSwitchStatement() {
    AssertParse(
      """
      switch x {
        1️⃣foo()
      #if true
        2️⃣bar()
      #endif
        case .A, .B:
          break
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected text 'foo()' before conditional compilation clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected text 'bar()' in conditional compilation block"),
      ]
    )

    AssertParse(
      """
      switch x {
      1️⃣print()
      #if ENABLE_C
      case .NOT_EXIST:
        break
      case .C:
        break
      #endif
      case .A, .B:
        break
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected text 'print()' before conditional compilation clause")
      ]
    )
  }

  func testBogusLineLabel() {
    AssertParse(
      "LABEL1️⃣:",
      diagnostics: [
        DiagnosticSpec(message: "extraneous ':' at top level")
      ]
    )
  }

  func testIfHasSymbol() {
    AssertParse(
      """
      if #_hasSymbol(foo) {}
      """
    )
    
    AssertParse(
      """
      if #_hasSymbol(foo as () -> ()) {}
      """
    )
  }

  func testIdentifierPattern() {
    AssertParse(
      "switch x { case let .y(z): break }",
      substructure: Syntax(IdentifierPatternSyntax(
        identifier: .identifier("z")
      ))
    )
  }

  func testCaseContext() {
    AssertParse(
      """
      graphQLMap["clientMutationId"] as? 1️⃣Swift.Optional<String?> ?? Swift.Optional<String?>.none
      """,
    substructure: Syntax(MemberTypeIdentifierSyntax(
      baseType: TypeSyntax(SimpleTypeIdentifierSyntax(
        name: .identifier("Swift"),
        genericArgumentClause: nil)),
      period: .periodToken(),
      name: .identifier("Optional"),
      genericArgumentClause: GenericArgumentClauseSyntax(
        leftAngleBracket: .leftAngleToken(),
        arguments: GenericArgumentListSyntax([
          GenericArgumentSyntax(
            argumentType: TypeSyntax(OptionalTypeSyntax(
              wrappedType: TypeSyntax(SimpleTypeIdentifierSyntax(
                name: .identifier("String"),
                genericArgumentClause: nil)),
              questionMark: .postfixQuestionMarkToken())),
            trailingComma: nil)
        ]),
        rightAngleBracket: .rightAngleToken()))),
    substructureAfterMarker: "1️⃣")

    AssertParse(
      """
      if case 1️⃣Optional<Any>.none = object["anyCol"] { }
      """,
      substructure: Syntax(SpecializeExprSyntax(
        expression: ExprSyntax(IdentifierExprSyntax(
          identifier: .identifier("Optional"), declNameArguments: nil)),
        genericArgumentClause: GenericArgumentClauseSyntax(
          leftAngleBracket: .leftAngleToken(), arguments: GenericArgumentListSyntax([
        GenericArgumentSyntax(
          argumentType: TypeSyntax(SimpleTypeIdentifierSyntax(
            name: .anyKeyword(), genericArgumentClause: nil)),
          trailingComma: nil)
      ]), rightAngleBracket: .rightAngleToken()))),
      substructureAfterMarker: "1️⃣")
  }
<<<<<<< HEAD

  func testYield() {
    // Make sure these are always considered a yield statement
    AssertParse(
      """
      var x: Int {
        _read {
          1️⃣yield ()
        }
      }
      """,
      substructure: Syntax(YieldStmtSyntax(
        yieldKeyword: .contextualKeyword("yield"),
        yields: Syntax(YieldListSyntax(
          leftParen: .leftParenToken(),
          elementList: YieldExprListSyntax([]),
          rightParen: .rightParenToken())
        ))
      ),
      substructureAfterMarker: "1️⃣")

    // Make sure these are not.
    AssertParse(
      """
      var x: Int {
        get {
          1️⃣yield ()
        }
      }
      """,
      substructure: Syntax(FunctionCallExprSyntax(
        calledExpression: ExprSyntax(IdentifierExprSyntax(
          identifier: .identifier("yield"),
          declNameArguments: nil)),
        leftParen: .leftParenToken(),
        argumentList: TupleExprElementListSyntax([]),
        rightParen: .rightParenToken(),
        trailingClosure: nil,
        additionalTrailingClosures: nil)),
    substructureAfterMarker: "1️⃣")

    AssertParse(
      """
      yield([])
      """,
      substructure: Syntax(FunctionCallExprSyntax(
        calledExpression: ExprSyntax(IdentifierExprSyntax(
          identifier: .identifier("yield"),
          declNameArguments: nil)),
        leftParen: .leftParenToken(),
        argumentList: TupleExprElementListSyntax([
          TupleExprElementSyntax(
            label: nil,
            colon: nil,
            expression: ExprSyntax(ArrayExprSyntax(
              leftSquare: .leftSquareBracketToken(),
              elements: ArrayElementListSyntax([]),
              rightSquare: .rightSquareBracketToken())),
            trailingComma: nil),
        ]),
        rightParen: .rightParenToken(),
        trailingClosure: nil,
        additionalTrailingClosures: nil)))
  }
=======
>>>>>>> parent of a76e907 (Plumb Coroutine Accessor Context Through Item Parsing)
}
