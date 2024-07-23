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

  func testAttributesArguments() {
    assertParse("@Foo(a, b, c,) struct S { }")

    assertParse(
      """
      @available(iOS 15, *,)
      @backDeployed(before: iOS 17,)
      func foo() { }
      """
    )

    assertParse(
      """
      @_originallyDefinedIn(module: "ToasterKit", toasterOS 57, bowlOS 69, mugOS 69,)
      enum Toast { }
      """
    )

    assertParse(
      """
      @_documentation(visibility: internal, metadata: "this is a longer string",) public class OtherClass {}
      """
    )

    assertParse(
      """
      func f(in: @differentiable(reverse,) (Int) -> Int) { }
      """
    )

    assertParse(
      """
      @derivative(of: Self.other,)
      func foo() {}
      """
    )

    assertParse(
      """
      @transpose(of: S.instanceMethod,)
      static func transposeInstanceMethodWrtSelf(_ other: S, t: S) -> S {
        other + t
      }
      """
    )
  }

  func testTypeAttribute() {
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

  func testMacroRoleArguments() {
    assertParse(
      """
      @attached(extension, conformances: OptionSet,)
      public macro OptionSet<RawType>() = #externalMacro(module: "SwiftMacros", type: "OptionSetMacro")
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

  func testSwitchCaseLabel() {
    assertParse(
      """
      switch number {
      case 1, 2,:
          break
      default:
          break
      }
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

  func testInheritance() {
    assertParse(
      """
      struct T: P1, P2, { }
      """
    )

    assertParse(
      """
      struct T: P1, P2, where P1: Equatable, P2: Equatable { }
      """
    )
  }

  func testGenericWhereClause() {
    assertParse(
      """
      struct T: P1, P2, where P1: Equatable, P2: Equatable, { }
      """
    )
  }

  func testAvailabilityArgumentSpecList() {
    assertParse(
      """
      if #available(iOS 15, watchOS 9, *,) { }
      """
    )

    assertParse(
      """
      if #unavailable(iOS 15, watchOS 9,) { }
      """
    )
  }
}
