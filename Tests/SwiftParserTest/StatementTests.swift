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

@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class StatementTests: ParserTestCase {
  func testIf() {
    assertParse(
      """
      if let baz {}
      """,
      substructure: IfExprSyntax(
        ifKeyword: .keyword(.if),
        conditions: ConditionElementListSyntax([
          ConditionElementSyntax(
            condition: .init(
              OptionalBindingConditionSyntax(
                bindingSpecifier: .keyword(.let),
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

    assertParse(
      """
      if let self = self {}
      """,
      substructure: IfExprSyntax(
        ifKeyword: .keyword(.if),
        conditions: ConditionElementListSyntax([
          ConditionElementSyntax(
            condition: .init(
              OptionalBindingConditionSyntax(
                bindingSpecifier: .keyword(.let),
                pattern: IdentifierPatternSyntax(identifier: .keyword(.self)),
                initializer: InitializerClauseSyntax(
                  equal: .equalToken(),
                  value: DeclReferenceExprSyntax(baseName: .keyword(.self))
                )
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

    assertParse("if let x { }")

    assertParse(
      """
      if case1️⃣* ! = x {
        bar()
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected expression, '=', and expression in pattern matching",
          fixIts: ["insert expression, '=', and expression"]
        ),
        DiagnosticSpec(message: "unexpected code '* ! = x' in 'if' statement"),
      ],
      fixedSource: """
        if case <#expression#> = <#expression#> * ! = x {
          bar()
        }
        """
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
    assertParse("return actor")

    assertParse(
      "{ 1️⃣return 0 }",
      substructure: ReturnStmtSyntax(
        returnKeyword: .keyword(.return),
        expression: IntegerLiteralExprSyntax(literal: .integerLiteral("0"))
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
        DiagnosticSpec(
          message: "C-style for statement has been removed in Swift 3",
          highlight: "let x = 0; x < 10; x += 1, y += 1 "
        )
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
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "all statements inside a switch must be covered by a 'case' or 'default' label",
          fixIts: ["insert label"]
        ),
      ],
      fixedSource: """
        switch x {
          foo()
        #if true
        case <#identifier#>:
          bar()
        #endif
          case .A, .B:
            break
        }
        """
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
      substructure: IdentifierPatternSyntax(
        identifier: .identifier("z")
      )
    )
  }

  func testCaseContext() {
    assertParse(
      """
      graphQLMap["clientMutationId"] as? 1️⃣Swift.Optional<String?> ?? Swift.Optional<String?>.none
      """,
      substructure: MemberTypeSyntax(
        baseType: IdentifierTypeSyntax(name: .identifier("Swift")),
        period: .periodToken(),
        name: .identifier("Optional"),
        genericArgumentClause: GenericArgumentClauseSyntax(
          leftAngle: .leftAngleToken(),
          arguments: GenericArgumentListSyntax([
            GenericArgumentSyntax(
              argument: .type(
                TypeSyntax(
                  OptionalTypeSyntax(
                    wrappedType: IdentifierTypeSyntax(name: .identifier("String")),
                    questionMark: .postfixQuestionMarkToken()
                  )
                )
              )
            )
          ]),
          rightAngle: .rightAngleToken()
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      if case 1️⃣Optional<Any>.none = object["anyCol"] { }
      """,
      substructure: GenericSpecializationExprSyntax(
        expression: DeclReferenceExprSyntax(baseName: .identifier("Optional")),
        genericArgumentClause: GenericArgumentClauseSyntax(
          leftAngle: .leftAngleToken(),
          arguments: GenericArgumentListSyntax([
            GenericArgumentSyntax(
              argument: .type(TypeSyntax(IdentifierTypeSyntax(name: .keyword(.Any))))
            )
          ]),
          rightAngle: .rightAngleToken()
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
      substructure: DeclReferenceExprSyntax(baseName: .identifier("yield")),
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
      substructure: YieldStmtSyntax(
        yieldKeyword: .keyword(.yield),
        yieldedExpressions: .init(
          InOutExprSyntax(
            ampersand: .prefixAmpersandToken(),
            expression: DeclReferenceExprSyntax(baseName: .identifier("x"))
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
      substructure: YieldStmtSyntax(
        yieldKeyword: .keyword(.yield),
        yieldedExpressions: .init(
          InOutExprSyntax(
            ampersand: .prefixAmpersandToken(),
            expression: SubscriptCallExprSyntax(
              calledExpression: DeclReferenceExprSyntax(baseName: .identifier("native")),
              leftSquare: .leftSquareToken(),
              arguments: LabeledExprListSyntax([
                LabeledExprSyntax(
                  expression: DeclReferenceExprSyntax(baseName: .identifier("key")),
                  trailingComma: .commaToken()
                ),
                LabeledExprSyntax(
                  label: .identifier("isUnique"),
                  colon: .colonToken(),
                  expression: BooleanLiteralExprSyntax(literal: .keyword(.true))
                ),
              ]),
              rightSquare: .rightSquareToken()
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
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("yield")),
        leftParen: .leftParenToken(),
        arguments: LabeledExprListSyntax([]),
        rightParen: .rightParenToken()
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
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("yield")),
        leftParen: .leftParenToken(),
        arguments: LabeledExprListSyntax([]),
        rightParen: .rightParenToken()
      ),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      yield([])
      """,
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("yield")),
        leftParen: .leftParenToken(),
        arguments: LabeledExprListSyntax([
          LabeledExprSyntax(
            expression: ArrayExprSyntax(
              leftSquare: .leftSquareToken(),
              elements: ArrayElementListSyntax([]),
              rightSquare: .rightSquareToken()
            )
          )
        ]),
        rightParen: .rightParenToken()
      )
    )

    assertParse(
      """
      func f() -> Int {
        1️⃣yield & 5
      }
      """,
      substructure: SequenceExprSyntax {
        DeclReferenceExprSyntax(baseName: .identifier("yield"))
        BinaryOperatorExprSyntax(operator: .binaryOperator("&"))
        IntegerLiteralExprSyntax(5)
      },
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      func f() -> Int {
        1️⃣yield&5
      }
      """,
      substructure: SequenceExprSyntax {
        DeclReferenceExprSyntax(baseName: .identifier("yield"))
        BinaryOperatorExprSyntax(operator: .binaryOperator("&"))
        IntegerLiteralExprSyntax(5)
      },
      substructureAfterMarker: "1️⃣"
    )
  }

  func testDiscard() {
    assertParse(
      """
      discard self
      """,
      substructure: DiscardStmtSyntax(
        discardKeyword: .keyword(.discard),
        expression: DeclReferenceExprSyntax(baseName: .keyword(.`self`))
      )
    )

    assertParse(
      """
      discard Self
      """,
      substructure: DiscardStmtSyntax(
        discardKeyword: .keyword(.discard),
        expression: DeclReferenceExprSyntax(baseName: .keyword(.Self))
      )
    )

    assertParse(
      """
      discard SarahMarshall
      """,
      substructure: DiscardStmtSyntax(
        discardKeyword: .keyword(.discard),
        expression: DeclReferenceExprSyntax(baseName: .identifier("SarahMarshall"))
      )
    )

    assertParse(
      """
      discard1️⃣ 2️⃣case
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "'case' can only appear inside a 'switch' statement or 'enum' declaration"
        ),
      ],
      fixedSource: """
        discard
        case
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
      substructure: FunctionCallExprSyntax(
        callee: DeclReferenceExprSyntax(
          baseName: .identifier("discard")
        ),
        argumentList: {
          LabeledExprListSyntax([
            LabeledExprSyntax(
              expression: DeclReferenceExprSyntax(baseName: .keyword(.`self`))
            )
          ])
        }
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
      substructure: SubscriptCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("data")),
        leftSquare: .leftSquareToken(),
        arguments: LabeledExprListSyntax([
          LabeledExprSyntax(
            expression: DeclReferenceExprSyntax(baseName: .identifier("position")),
            trailingComma: .commaToken()
          ),
          LabeledExprSyntax(
            label: .identifier("default"),
            colon: .colonToken(),
            expression: IntegerLiteralExprSyntax(0)
          ),
        ]),
        rightSquare: .rightSquareToken()
      )
    )
  }

  func testSkippingOverEmptyStringLiteral() {
    // https://github.com/swiftlang/swift-syntax/issues/1247
    assertParse(
      """
      if pℹ️{""1️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected '}' to end 'if' statement",
          notes: [NoteSpec(message: "to match this opening '{'")],
          fixIts: ["insert '}'"]
        )
      ],
      fixedSource: """
        if p{""
        }
        """
    )
  }

  func testRecoveryInFrontOfAccessorIntroducer() {
    assertParse(
      """
      subscript1️⃣(2️⃣{@attr _modify3️⃣
      """,
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected ')' to end parameter clause",
          notes: [NoteSpec(locationMarker: "1️⃣", message: "to match this opening '('")],
          fixIts: ["insert ')'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "expected '->' and return type in subscript",
          fixIts: ["insert '->' and return type"]
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "expected '}' to end subscript",
          notes: [NoteSpec(locationMarker: "2️⃣", message: "to match this opening '{'")],
          fixIts: ["insert '}'"]
        ),
      ],
      fixedSource: """
        subscript() -> <#type#> {@attr _modify
        }
        """
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

  func testTrailingClosureInIfCondition() {
    assertParse("if test { $0 } {}")

    assertParse(
      """
      if test {
        $0
      }1️⃣ {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "consecutive statements on a line must be separated by newline or ';'",
          fixIts: ["insert newline", "insert ';'"]
        )
      ],
      fixedSource: """
        if test {
          $0
        }
        {}
        """
    )

    assertParse(
      """
      if test { $0
      } {}
      """
    )

    assertParse(
      """
      if test { x in
        x
      } {}
      """
    )
  }

  func testClosureAtStartOfIfCondition() {
    assertParse(
      "if 1️⃣{x}() {}",
      diagnostics: [
        DiagnosticSpec(message: "missing condition in 'if' statement")
      ]
    )

    assertParse(
      """
      if 1️⃣{
        x
      }() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "missing condition in 'if' statement")
      ]
    )

    assertParse(
      """
      if 1️⃣{ x
      }() {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "missing condition in 'if' statement")
      ]
    )

    assertParse(
      """
      if 1️⃣{ a 2️⃣in
        x + a
      }(1) {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "missing condition in 'if' statement"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code in 'if' statement"),
      ]
    )
  }

  func testClosureInsideIfCondition() {
    assertParse("if true, {x}() {}")

    assertParse(
      """
      if true, {
        x
      }() {}
      """
    )

    assertParse(
      """
      if true, { x
      }() {}
      """
    )

    assertParse(
      """
      if true, { a in
        x + a
      }(1) {}
      """
    )
  }

  func testTrailingClosureInGuard() {
    assertParse(
      "guard test 1️⃣{ $0 } 2️⃣else {}",
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'else' in 'guard' statement", fixIts: ["insert 'else'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code 'else {}' at top level"),
      ],
      fixedSource: "guard test else { $0 } else {}"
    )

    assertParse(
      """
      guard test 1️⃣{
        $0
      } 2️⃣else {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'else' in 'guard' statement", fixIts: ["insert 'else'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code 'else {}' at top level"),
      ],
      fixedSource:
        """
        guard test else {
          $0
        } else {}
        """
    )

    assertParse(
      """
      guard test 1️⃣{ $0
      } 2️⃣else {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'else' in 'guard' statement", fixIts: ["insert 'else'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "extraneous code 'else {}' at top level"),
      ],
      fixedSource: """
        guard test else { $0
        } else {}
        """
    )

    assertParse(
      """
      guard test 1️⃣{ x 2️⃣in
        x
      } 3️⃣else {}
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected 'else' in 'guard' statement", fixIts: ["insert 'else'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected code in 'guard' statement"),
        DiagnosticSpec(locationMarker: "3️⃣", message: "extraneous code 'else {}' at top level"),
      ],
      fixedSource: """
        guard test else { x in
          x
        } else {}
        """
    )
  }

  func testTypedThrows() {
    assertParse(
      """
      do throws(any Error) {
        throw myError
      }
      """
    )

    assertParse(
      """
      do throws(MyError) {
        throw myError
      }
      """
    )

    assertParse(
      """
      do throws {
        throw myError
      }
      """
    )
  }

  func testForStatementWithUnexpectedTokenBeforeInKeyword() {
    assertParse(
      "for var elem1️⃣? in arr { }",
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '?' in 'for' statement")
      ]
    )
  }

  func testForUnsafeStatement() {
    assertParse(
      "for try await unsafe x in e { }"
    )

    assertParse(
      "for try await unsafe in e { }"
    )

    assertParse(
      "for unsafe in e { }"
    )

    assertParse(
      "for unsafe: Int in e { }"
    )
  }
}
