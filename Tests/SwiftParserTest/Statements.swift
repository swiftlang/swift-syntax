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

    AssertParse("if let x { }")

    AssertParse(
      """
      if case#^DIAG^#* ! = x {
        bar()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected '=' in pattern matching"),
        DiagnosticSpec(message: "Unexpected text '* ! = x' in 'if' statement"),
      ]
    )
  }

  func testNestedIfs() {
    let nest = 22
    var source = "func nestThoseIfs() {\n"
    for index in (0...nest) {
        let indent = String(repeating: "    ", count: index + 1)
        source += indent + "if false != true {\n"
        source += indent + "   print \"\\(i)\"\n"
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
    AssertParse("{ #^ASYNC^#return 0 }",
                { $0.parseClosureExpression() },
                substructure: Syntax(ReturnStmtSyntax(returnKeyword: .returnKeyword(),
                                                      expression: ExprSyntax(IntegerLiteralExprSyntax(digits: .integerLiteral("0"))))),
                substructureAfterMarker: "ASYNC")

    AssertParse("return")

    AssertParse(
       #"""
       return "assert(\(assertChoices.joined(separator: " || ")))"
       """#
    )

    AssertParse("return true ? nil : nil")
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
      #^DIAG^#for let x = 0; x < 10; x += 1, y += 1 {
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "C-style for statement has been removed in Swift 3", highlight: "let x = 0; x < 10; x += 1, y += 1 ")
      ]
    )
  }

  func testTopLevelCaseRecovery() {
    AssertParse(
      "/*#-editable-code Swift Platground editable area*/#^DIAG^#default/*#-end-editable-code*/",
      diagnostics: [
        DiagnosticSpec(message: "Extraneous 'default' at top level")
      ]
    )

    AssertParse(
      "#^DIAG^#case:",
      diagnostics: [
        DiagnosticSpec(message: "Extraneous 'case:' at top level")
      ])

    AssertParse(
      #"""
      #^DIAG^#case: { ("Hello World") }
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Extraneous 'case: { ("Hello World") }' at top level"#)
      ]
    )
  }

  func testMissingIfClauseIntroducer() {
    // FIXME: This test case should produce a diagnostics
    AssertParse("if _ = 42 {}")
  }

  func testAttributesOnStatements() {
    AssertParse(
      """
      func test1() {
        #^TEST_1^#@s return
      }
      func test2() {
        #^TEST_2^#@unknown return
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "TEST_1", message: "Unexpected text '@s return' in function"),
        DiagnosticSpec(locationMarker: "TEST_2", message: "Unexpected text '@unknown return' in function")
      ]
    )
  }

  func testBogusSwitchStatement() {
    AssertParse(
      """
      switch x {
        #^FOO^#foo()
      #if true
        #^BAR^#bar()
      #endif
        case .A, .B:
          break
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "FOO", message: "Unexpected text 'foo()' before conditional compilation clause"),
        DiagnosticSpec(locationMarker: "BAR", message: "Unexpected text 'bar()' in conditional compilation block"),
      ]
    )

    AssertParse(
      """
      switch x {
      #^DIAG^#print()
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
        DiagnosticSpec(message: "Unexpected text 'print()' before conditional compilation clause")
      ]
    )
  }

  func testBogusLineLabel() {
    AssertParse(
      "LABEL#^DIAG^#:",
      diagnostics: [
        DiagnosticSpec(message: "Extraneous ':' at top level")
      ]
    )
  }
}
