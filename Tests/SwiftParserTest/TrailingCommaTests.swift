//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(ExperimentalLanguageFeatures) import SwiftParser
import SwiftSyntax
import XCTest

final class TrailingCommaTests: ParserTestCase {

  func testTuple() {
    assertParse("(1, 2, 3,)")

    assertParse(
      "(1️⃣,)",
      diagnostics: [DiagnosticSpec(message: "expected value in tuple", fixIts: ["insert value"])],
      fixedSource: "(<#expression#>,)"
    )
  }

  func testArgumentList() {
    assertParse("foo(1, 2, 3,)")

    assertParse(
      "foo(1️⃣,)",
      diagnostics: [DiagnosticSpec(message: "expected value in function call", fixIts: ["insert value"])],
      fixedSource: "foo(<#expression#>,)"
    )
  }

  func testParameterList() {
    assertParse(
      """
      func foo(
          a: Int = 0,
          b: Int = 0,
      ) {
      }
      """
    )

    assertParse(
      "func foo(1️⃣,) { }",
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier, ':', and type in parameter",
          fixIts: ["insert identifier, ':', and type"]
        )
      ],
      fixedSource: "func foo(<#identifier#>: <#type#>,) { }"
    )
  }

  func testSubscriptArguments() {
    assertParse("d[1, 2,]")
  }

  func testStringLiteralInterpolation() {
    assertParse(#""\(1, 2,)""#)
  }

  func testKeyPathExpressionArguments() {
    assertParse(
      """
      \\Foo.bar[0,]
      """
    )
  }

  func testCustomAttributes() {
    assertParse("@Foo(a, b, c,) struct S { }")

    assertParse("f(_: @foo(1, 2,) Int)")
  }

  func testMacroExpansionExpressionArguments() {
    assertParse(
      """
      #foo(1, 2,)
      """
    )
  }

  func testMacroExpansionDeclarationArguments() {
    assertParse(
      """
      struct S {
      #foo(1, 2,)
      }
      """
    )
  }

  func testGenericParameters() {
    assertParse(
      """
      struct S<T1, T2,> { }
      """
    )
  }

  func testClosureCaptureList() {
    assertParse(
      """
      { [obj1, obj2,] in }
      """
    )
  }

  func testIfConditions() {
    assertParse("if true, { }", experimentalFeatures: .trailingComma)

    assertParse("if true, { }; { }()", experimentalFeatures: .trailingComma)

    assertParse(
      """
      if true, { print("if-body") } else { print("else-body") }
      """,
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true, { print("if-body") } else if true, { print("else-if-body") } { print("else-body") }
      """,
      experimentalFeatures: .trailingComma
    )

    assertParse("if true, { if true { { } } }", experimentalFeatures: .trailingComma)

    assertParse("{ if true, { print(0) } }", experimentalFeatures: .trailingComma)

    assertParse("( if true, { print(0) } )", experimentalFeatures: .trailingComma)

    assertParse(
      """
      if true, { true }() { print(0) }
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax(condition: .expression("true"), trailingComma: .commaToken()),
          ConditionElementSyntax(condition: .expression("{ true }()"), trailingComma: nil),
        ],
        body: "{ print(0) }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true, { true }, { print(0) }
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax.init(condition: .expression("true"), trailingComma: .commaToken()),
          ConditionElementSyntax.init(condition: .expression("{ true }"), trailingComma: .commaToken()),
        ],
        body: "{ print(0) }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true, { true } { print(0) }
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax.init(condition: .expression("true"), trailingComma: .commaToken()),
          ConditionElementSyntax.init(condition: .expression("{ true }"), trailingComma: nil),
        ],
        body: "{ print(0) }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true, { print(0) }
      { }()
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax.init(condition: .expression("true"), trailingComma: .commaToken())
        ],
        body: "{ print(0) }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true, { true }
      { print(0) }
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax.init(condition: .expression("true"), trailingComma: .commaToken())
        ],
        body: "{ true }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true, { true }
      ,{ print(0) }
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax.init(condition: .expression("true"), trailingComma: .commaToken()),
          ConditionElementSyntax.init(condition: .expression("{ true }"), trailingComma: .commaToken()),
        ],
        body: "{ print(0) }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true,
      { true }+++ { print(0) }
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax.init(condition: .expression("true"), trailingComma: .commaToken()),
          ConditionElementSyntax.init(condition: .expression("{ true }+++"), trailingComma: nil),
        ],
        body: "{ print(0) }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true, { (x: () -> Void) in true } != nil { print(0) }
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax.init(condition: .expression("true"), trailingComma: .commaToken()),
          ConditionElementSyntax.init(condition: .expression("{ (x: () -> Void) in true } != nil"), trailingComma: nil),
        ],
        body: "{ print(0) }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      if true, { (x: () -> Void) in true }
      != nil
      {
        print(0)
      }
      """,
      substructure: IfExprSyntax(
        conditions: [
          ConditionElementSyntax.init(condition: .expression("true"), trailingComma: .commaToken()),
          ConditionElementSyntax.init(condition: .expression("{ (x: () -> Void) in true } != nil"), trailingComma: nil),
        ],
        body: "{ print(0) }"
      ),
      experimentalFeatures: .trailingComma
    )

    assertParse(
      "if 1️⃣, { }",
      diagnostics: [DiagnosticSpec(message: "missing condition in 'if' statement")],
      experimentalFeatures: .trailingComma
    )
  }

  func testGuardConditions() {
    assertParse("guard true, else { break }", experimentalFeatures: .trailingComma)

    assertParse(
      "guard true, 1️⃣, else { return }",
      diagnostics: [DiagnosticSpec(message: "expected expression in 'guard' statement", fixIts: ["insert expression"])],
      fixedSource: "guard true, <#expression#>, else { return }",
      experimentalFeatures: .trailingComma
    )

    assertParse(
      "guard true, 1️⃣{ return }",
      diagnostics: [DiagnosticSpec(message: "expected 'else' in 'guard' statement", fixIts: ["insert 'else'"])],
      fixedSource: "guard true, else { return }",
      experimentalFeatures: .trailingComma
    )
  }

  func testWhileConditions() {
    assertParse("while true, { print(0) }", experimentalFeatures: .trailingComma)
  }

  func testSwitchCaseLabel() {
    assertParse(
      """
      switch number {
      case 1, 2,:
          break
      default:
          break
      }
      """,
      experimentalFeatures: .trailingComma
    )
  }

  func testInheritance() {
    assertParse(
      """
      struct T: P1, P2, { }
      """,
      experimentalFeatures: .trailingComma
    )

    assertParse(
      """
      struct T: P1, P2, where P1: Equatable, P2: Equatable { }
      """,
      experimentalFeatures: .trailingComma
    )
  }

  func testGenericWhereClause() {
    assertParse(
      """
      struct T: P1, P2, where P1: Equatable, P2: Equatable, { }
      """,
      experimentalFeatures: .trailingComma
    )
  }
}
