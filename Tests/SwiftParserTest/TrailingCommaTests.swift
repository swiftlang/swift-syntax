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
  override var experimentalFeatures: Parser.ExperimentalFeatures { [.trailingComma] }

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

  func testIfConditions() {
    assertParse("if true, { }")

    assertParse("if true, { }; { }()")

    assertParse(
      """
      if true, { print("if-body") } else { print("else-body") }
      """
    )

    assertParse(
      """
      if true, { print("if-body") } else if true, { print("else-if-body") } { print("else-body") }
      """
    )

    assertParse("if true, { if true { { } } }")

    assertParse("{ if true, { print(0) } }")

    assertParse("( if true, { print(0) } )")

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
      )
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
      )
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
      )
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
      )
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
      )
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
      )
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
      )
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
      )
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
      )
    )

    assertParse(
      "if 1️⃣, { }",
      diagnostics: [DiagnosticSpec(message: "missing condition in 'if' statement")]
    )
  }

  func testGuardConditions() {
    assertParse("guard true, else { break }")

    assertParse(
      "guard true, 1️⃣, else { return }",
      diagnostics: [DiagnosticSpec(message: "expected expression in 'guard' statement", fixIts: ["insert expression"])],
      fixedSource: "guard true, <#expression#>, else { return }"
    )

    assertParse(
      "guard true, 1️⃣{ return }",
      diagnostics: [DiagnosticSpec(message: "expected 'else' in 'guard' statement", fixIts: ["insert 'else'"])],
      fixedSource: "guard true, else { return }"
    )
  }

  func testWhileConditions() {
    assertParse("while true, { print(0) }")
  }
}
