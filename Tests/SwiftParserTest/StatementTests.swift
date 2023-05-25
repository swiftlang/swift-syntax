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

final class StatementTests: XCTestCase {
  func testIf() {
    assertParse(
      """
      if let baz {}
      """,
      substructure: Syntax(
        IfExprSyntax(
          ifKeyword: .keyword(.if),
          conditions: ConditionElementListSyntax([
            ConditionElementSyntax(
              condition: .init(
                OptionalBindingConditionSyntax(
                  bindingKeyword: .keyword(.let),
                  pattern: IdentifierPatternSyntax(identifier: .identifier("baz"))
                )
              )
            )
          ]),
          body: .init(
            leftBrace: .leftBraceToken(),
            statements: .init([]),
            rightBrace: .rightBraceToken()
          )
        )
      )
    )

    assertParse(
      """
      if let self = self {}
      """,
      substructure: Syntax(
        IfExprSyntax(
          ifKeyword: .keyword(.if),
          conditions: ConditionElementListSyntax([
            ConditionElementSyntax(
              condition: .init(
                OptionalBindingConditionSyntax(
                  bindingKeyword: .keyword(.let),
                  pattern: IdentifierPatternSyntax(identifier: .keyword(.self)),
                  initializer: InitializerClauseSyntax(equal: .equalToken(), value: IdentifierExprSyntax(identifier: .keyword(.self)))
                )
              )
            )
          ]),
          body: .init(
            leftBrace: .leftBraceToken(),
            statements: .init([]),
            rightBrace: .rightBraceToken()
          )
        )
      )
    )

    assertParse("if let x { }")

    assertParse(
      """
      if case1️⃣* ! = x {
        bar()
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected expression, '=', and expression in pattern matching"),
        DiagnosticSpec(message: "unexpected code '* ! = x' in 'if' statement"),
      ]
    )

    assertParse(
      """
      if includeSavedHints { a = a.flatMap{ $0 } ?? nil }
      """
    )
  }

  func testNestedIfs() {
    let nest = 10
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
    assertParse(source)
  }

  func testDo() {
    assertParse(
      """
      do {

      }
      """
    )
  }

  func testDoCatch() {
    assertParse(
      """
      do {

      } catch {

      }
      """
    )

    assertParse(
      """
      do {}
      catch where (error as NSError) == NSError() {}
      """
    )
  }

  func testReturn() {
    assertParse("return actor", { StmtSyntax.parse(from: &$0) })

    assertParse(
      "{ 1️⃣return 0 }",
      { ExprSyntax.parse(from: &$0) },
      substructure: Syntax(
        ReturnStmtSyntax(
          returnKeyword: .keyword(.return),
          expression: IntegerLiteralExprSyntax(digits: .integerLiteral("0"))
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse("return")

    assertParse(
      #"""
      return "assert(\(assertChoices.joined(separator: " || ")))"
      """#
    )

    assertParse("return true ? nil : nil")

    assertParse(
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
    assertParse(
      """
      switch x {
      case .A, .B:
        break
      }
      """
    )

    assertParse(
      """
      switch 0 {
      @$dollar case _:
        break
      }
      """
    )

    assertParse(
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
    assertParse(
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
    assertParse(
      "/*#-editable-code Swift Platground editable area*/1️⃣default/*#-end-editable-code*/",
      diagnostics: [
        DiagnosticSpec(message: "'default' label can only appear inside a 'switch' statement")
      ]
    )

    assertParse(
      "1️⃣case:",
      diagnostics: [
        DiagnosticSpec(message: "'case' can only appear inside a 'switch' statement or 'enum' declaration")
      ]
    )

    assertParse(
      #"""
      1️⃣case: { ("Hello World") }
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"'case' can only appear inside a 'switch' statement or 'enum' declaration"#)
      ]
    )
  }

  func testMissingIfClauseIntroducer() {
    assertParse("if _ = 42 {}")
  }

  func testAttributesOnStatements() {
    assertParse(
      """
      func test1() {
        1️⃣@s return
      }
      func test2() {
        2️⃣@unknown return
      }
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '@s' before 'return' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code '@unknown' before 'return' statement"),
      ]
    )
  }

  func testBogusSwitchStatement() {
    assertParse(
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
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code 'foo()' before conditional compilation clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "all statements inside a switch must be covered by a 'case' or 'default' label"),
      ]
    )

    assertParse(
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
        DiagnosticSpec(message: "unexpected code 'print()' before conditional compilation clause")
      ]
    )
  }

  func testBogusLineLabel() {
    assertParse(
      "LABEL1️⃣:",
      diagnostics: [
        DiagnosticSpec(message: "extraneous code ':' at top level")
      ]
    )
  }

  func testIfHasSymbol() {
    assertParse(
      """
      if #_hasSymbol(foo) {}
      """
    )

    assertParse(
      """
      if #_hasSymbol(foo as () -> ()) {}
      """
    )
  }

  func testIdentifierPattern() {
    assertParse(
      "switch x { case let .y(z): break }",
      substructure: Syntax(
        IdentifierPatternSyntax(
          identifier: .identifier("z")
        )
      )
    )
  }

  func testCaseContext() {
    assertParse(
      """
      graphQLMap["clientMutationId"] as? 1️⃣Swift.Optional<String?> ?? Swift.Optional<String?>.none
      """,
      substructure: Syntax(
        MemberTypeIdentifierSyntax(
          baseType: SimpleTypeIdentifierSyntax(name: .identifier("Swift")),
          period: .periodToken(),
          name: .identifier("Optional"),
          genericArgumentClause: GenericArgumentClauseSyntax(
            leftAngleBracket: .leftAngleToken(),
            arguments: GenericArgumentListSyntax([
              GenericArgumentSyntax(
                argumentType: OptionalTypeSyntax(
                  wrappedType: SimpleTypeIdentifierSyntax(name: .identifier("String")),
                  questionMark: .postfixQuestionMarkToken()
                )
              )
            ]),
            rightAngleBracket: .rightAngleToken()
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      if case 1️⃣Optional<Any>.none = object["anyCol"] { }
      """,
      substructure: Syntax(
        SpecializeExprSyntax(
          expression: IdentifierExprSyntax(identifier: .identifier("Optional")),
          genericArgumentClause: GenericArgumentClauseSyntax(
            leftAngleBracket: .leftAngleToken(),
            arguments: GenericArgumentListSyntax([
              GenericArgumentSyntax(
                argumentType: SimpleTypeIdentifierSyntax(name: .keyword(.Any))
              )
            ]),
            rightAngleBracket: .rightAngleToken()
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testHangingYieldArgument() {
    assertParse(
      """
      1️⃣yield
      print("huh")
      """,
      substructure: Syntax(IdentifierExprSyntax(identifier: .identifier("yield"))),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testYield() {
    // Make sure these are always considered a yield statement
    assertParse(
      """
      var x: Int {
        _read {
          1️⃣yield &x
        }
      }
      """,
      substructure: Syntax(
        YieldStmtSyntax(
          yieldKeyword: .keyword(.yield),
          yields: .init(
            InOutExprSyntax(
              ampersand: .prefixAmpersandToken(),
              expression: IdentifierExprSyntax(identifier: .identifier("x"))
            )
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      @inlinable internal subscript(key: Key) -> Value? {
        @inline(__always) get {
          return lookup(key)
        }
        @inline(__always) _modify {
          guard isNative else {
            let cocoa = asCocoa
            var native = _NativeDictionary<Key, Value>(
              cocoa, capacity: cocoa.count + 1)
            self = .init(native: native)
            1️⃣yield &native[key, isUnique: true]
            return
          }
          let isUnique = isUniquelyReferenced()
          yield &asNative[key, isUnique: isUnique]
        }
      }
      """,
      substructure: Syntax(
        YieldStmtSyntax(
          yieldKeyword: .keyword(.yield),
          yields: .init(
            InOutExprSyntax(
              ampersand: .prefixAmpersandToken(),
              expression: SubscriptExprSyntax(
                calledExpression: IdentifierExprSyntax(identifier: .identifier("native")),
                leftBracket: .leftSquareBracketToken(),
                argumentList: TupleExprElementListSyntax([
                  TupleExprElementSyntax(
                    expression: IdentifierExprSyntax(identifier: .identifier("key")),
                    trailingComma: .commaToken()
                  ),
                  TupleExprElementSyntax(
                    label: .identifier("isUnique"),
                    colon: .colonToken(),
                    expression: BooleanLiteralExprSyntax(booleanLiteral: .keyword(.true))
                  ),
                ]),
                rightBracket: .rightSquareBracketToken()
              )
            )
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    // Make sure these are not.
    assertParse(
      """
      var x: Int {
        _read {
          1️⃣yield ()
        }
      }
      """,
      substructure: Syntax(
        FunctionCallExprSyntax(
          calledExpression: IdentifierExprSyntax(identifier: .identifier("yield")),
          leftParen: .leftParenToken(),
          argumentList: TupleExprElementListSyntax([]),
          rightParen: .rightParenToken()
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      var x: Int {
        get {
          1️⃣yield ()
        }
      }
      """,
      substructure: Syntax(
        FunctionCallExprSyntax(
          calledExpression: IdentifierExprSyntax(identifier: .identifier("yield")),
          leftParen: .leftParenToken(),
          argumentList: TupleExprElementListSyntax([]),
          rightParen: .rightParenToken()
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      yield([])
      """,
      substructure: Syntax(
        FunctionCallExprSyntax(
          calledExpression: IdentifierExprSyntax(identifier: .identifier("yield")),
          leftParen: .leftParenToken(),
          argumentList: TupleExprElementListSyntax([
            TupleExprElementSyntax(
              expression: ArrayExprSyntax(
                leftSquare: .leftSquareBracketToken(),
                elements: ArrayElementListSyntax([]),
                rightSquare: .rightSquareBracketToken()
              )
            )
          ]),
          rightParen: .rightParenToken()
        )
      )
    )

    assertParse(
      """
      func f() -> Int {
        1️⃣yield & 5
      }
      """,
      substructure: Syntax(
        SequenceExprSyntax(
          elements: ExprListSyntax([
            IdentifierExprSyntax(identifier: .identifier("yield")),
            BinaryOperatorExprSyntax(operatorToken: .binaryOperator("&")),
            IntegerLiteralExprSyntax(5),
          ])
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      func f() -> Int {
        1️⃣yield&5
      }
      """,
      substructure: Syntax(
        SequenceExprSyntax(
          elements: ExprListSyntax([
            IdentifierExprSyntax(identifier: .identifier("yield")),
            BinaryOperatorExprSyntax(operatorToken: .binaryOperator("&")),
            IntegerLiteralExprSyntax(5),
          ])
        )
      ),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testDiscard() {
    // ensure the old spelling '_forget' can be parsed for now.
    assertParse(
      """
      _forget self
      """,
      substructure: Syntax(
        DiscardStmtSyntax(
          discardKeyword: .keyword(._forget),
          expression: IdentifierExprSyntax(identifier: .keyword(.`self`))
        )
      )
    )

    assertParse(
      """
      discard self
      """,
      substructure: Syntax(
        DiscardStmtSyntax(
          discardKeyword: .keyword(.discard),
          expression: IdentifierExprSyntax(identifier: .keyword(.`self`))
        )
      )
    )

    assertParse(
      """
      discard Self
      """,
      substructure: Syntax(
        DiscardStmtSyntax(
          discardKeyword: .keyword(.discard),
          expression: IdentifierExprSyntax(identifier: .keyword(.Self))
        )
      )
    )

    assertParse(
      """
      discard SarahMarshall
      """,
      substructure: Syntax(
        DiscardStmtSyntax(
          discardKeyword: .keyword(.discard),
          expression: IdentifierExprSyntax(identifier: .identifier("SarahMarshall"))
        )
      )
    )

    assertParse(
      """
      discard 1️⃣case
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected expression in 'discard' statement", fixIts: ["insert expression"]),
        DiagnosticSpec(locationMarker: "1️⃣", message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"),
      ],
      fixedSource: """
        discard <#expression#>case
        """
    )

    // It's important that we don't parse this one as a discard statement!
    assertParse(
      """
      func discard<T>(_ t: T) {}

      func caller() {
        discard(self)
      }
      """,
      substructure: Syntax(
        FunctionCallExprSyntax(
          callee: IdentifierExprSyntax(
            identifier: .identifier("discard")
          ),
          argumentList: {
            TupleExprElementListSyntax([
              TupleExprElementSyntax(
                expression: IdentifierExprSyntax(identifier: .keyword(.`self`))
              )
            ])
          }
        )
      )
    )
  }

  func testDefaultIdentIdentifierInReturnStmt() {
    assertParse("return FileManager.default")
  }

  func testDefaultAsIdentifierInSubscript() {
    assertParse(
      """
      data[position, default: 0]
      """,
      substructure: Syntax(
        SubscriptExprSyntax(
          calledExpression: IdentifierExprSyntax(identifier: .identifier("data")),
          leftBracket: .leftSquareBracketToken(),
          argumentList: TupleExprElementListSyntax([
            TupleExprElementSyntax(
              expression: IdentifierExprSyntax(identifier: .identifier("position")),
              trailingComma: .commaToken()
            ),
            TupleExprElementSyntax(
              label: .identifier("default"),
              colon: .colonToken(),
              expression: IntegerLiteralExprSyntax(0)
            ),
          ]),
          rightBracket: .rightSquareBracketToken()
        )
      )
    )
  }

  func testSkippingOverEmptyStringLiteral() {
    // https://github.com/apple/swift-syntax/issues/1247
    assertParse(
      """
      if p{""1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected '}' to end 'if' statement")
      ]
    )
  }

  func testRecoveryInFrontOfAccessorIntroducer() {
    assertParse(
      """
      subscript(1️⃣{2️⃣@self _modify
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ')' to end parameter clause"),
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected '->' and return type in subscript"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected '}' to end subscript"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code '@self _modify' at top level"),
      ]
    )
  }

  func testTrailingTriviaIncludesNewline() {
    assertParse(
      """
      let a = 2/*
      */let b = 3
      """
    )

    assertParse(
      """
      let a = 2/*



      */let b = 3
      """
    )
  }
}
