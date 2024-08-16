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

// This test file has been translated from swift/test/Parse/ifconfig_expr.swift

import SwiftSyntax
import XCTest

final class IfconfigExprTests: ParserTestCase {
  func testIfconfigExpr1() {
    assertParse(
      """
      postfix operator ++
      postfix func ++ (_: Int) -> Int { 0 }
      """
    )
  }

  func testIfconfigExpr2() {
    assertParse(
      """
      struct OneResult {}
      struct TwoResult {}
      """
    )
  }

  func testIfconfigExpr3() {
    assertParse(
      """
      protocol MyProto {
          func optionalMethod() -> [Int]?
      }
      struct MyStruct {
          var optionalMember: MyProto? { nil }
          func methodOne() -> OneResult { OneResult() }
          func methodTwo() -> TwoResult { TwoResult() }
      }
      """
    )
  }

  func testIfconfigExpr4() {
    assertParse(
      """
      func globalFunc<T>(_ arg: T) -> T { arg }
      """
    )
  }

  func testIfconfigExpr5() {
    assertParse(
      """
      func testBasic(baseExpr: MyStruct) {
          baseExpr
      #if CONDITION_1
            .methodOne()
      #else
            .methodTwo()
      #endif
      }
      """
    )
  }

  func testIfconfigExpr6() {
    assertParse(
      """
      MyStruct()
      #if CONDITION_1
        .methodOne()
      #else
        .methodTwo()
      #endif
      """
    )
  }

  func testIfconfigExpr7() {
    assertParse(
      #"""
      func testInvalidContent(baseExpr: MyStruct, otherExpr: Int) {
        baseExpr
      #if CONDITION_1
          { $0 + 1  }
      #endif
        baseExpr
      #if CONDITION_1
          1️⃣+ otherExpr
      #endif
        baseExpr
      #if CONDITION_1
          .methodOne()
        2️⃣print("debug")
      #endif
      }
      """#,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected code '+ otherExpr' in conditional compilation block"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: #"unexpected code 'print("debug")' in conditional compilation block"#
        ),
      ]
    )
  }

  func testIfconfigExpr8() {
    assertParse(
      """
      func testExprKind(baseExpr: MyStruct, idx: Int) {
        baseExpr
      #if CONDITION_1
        .optionalMember?.optionalMethod()![idx]++
      #else
        .otherMethod(arg) {
          //...
        }
      #endif
        baseExpr
      #if CONDITION_1
        .methodOne() 1️⃣+ 12
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '+ 12' in conditional compilation block")
      ]
    )
  }

  func testIfconfigExpr9() {
    assertParse(
      """
      func emptyElse(baseExpr: MyStruct) {
        baseExpr
      #if CONDITION_1
          .methodOne()
      #elseif CONDITION_2
          // OK. Do nothing.
      #endif
        baseExpr
      #if CONDITION_1
          .methodOne()
      #elseif CONDITION_2
        1️⃣return
      #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected 'return' keyword in conditional compilation block")
      ]
    )
  }

  func testIfconfigExpr10() {
    assertParse(
      """
      func consecutiveIfConfig(baseExpr: MyStruct) {
          baseExpr
      #if CONDITION_1
        .methodOne()
      #endif
      #if CONDITION_2
        .methodTwo()
      #endif
        .unknownMethod()
      }
      """
    )
  }

  func testIfconfigExpr11() {
    assertParse(
      """
      func nestedIfConfig(baseExpr: MyStruct) {
        baseExpr
      #if CONDITION_1
        #if CONDITION_2
          .methodOne()
        #endif
        #if CONDITION_1
          .methodTwo()
        #endif
      #else
        .unknownMethod1()
        #if CONDITION_2
          .unknownMethod2()
        #endif
      #endif
      }
      """
    )
  }

  func testIfconfigExpr12() {
    assertParse(
      """
      func ifconfigExprInExpr(baseExpr: MyStruct) {
        globalFunc(
          baseExpr
      #if CONDITION_1
            .methodOne()
      #else
            .methodTwo()
      #endif
        )
      }
      """
    )
  }

  func testIfconfigExpr13() {
    assertParse(
      """
      #if canImport(A, _version: 2)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr14() {
    assertParse(
      """
      #if canImport(A, _version: 2.2)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr15() {
    assertParse(
      """
      #if canImport(A, _version: 2.2.2)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr16() {
    assertParse(
      """
      #if canImport(A, _version: 2.2.2.2)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr17() {
    assertParse(
      """
      #if canImport(A, _version: 2.2.2.21️⃣.2)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr18() {
    assertParse(
      """
      #if canImport(A, _underlyingVersion: 4)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr19() {
    assertParse(
      """
      #if canImport(A, _underlyingVersion: 2.200)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr20() {
    assertParse(
      """
      #if canImport(A, _underlyingVersion: 2.200.1)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr21() {
    assertParse(
      """
      #if canImport(A, _underlyingVersion: 2.200.1.3)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr22() {
    assertParse(
      """
      #if canImport(A, 1️⃣unknown: 2.2)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr23() {
    assertParse(
      """
      #if canImport(A,)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr24() {
    assertParse(
      """
      #if canImport(A, 1️⃣2.2)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr25() {
    assertParse(
      """
      #if canImport(A, 1️⃣2.22️⃣, 1.1)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr26() {
    assertParse(
      """
      #if canImport(A, _version:1️⃣)
        let a = 1
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected value in function call", fixIts: ["insert value"])
      ],
      fixedSource: """
        #if canImport(A, _version: <#expression#>)
          let a = 1
        #endif
        """
    )
  }

  func testIfconfigExpr27() {
    assertParse(
      #"""
      #if canImport(A, _version: 1️⃣"")
        let a = 1
      #endif
      """#
    )
  }

  func testIfconfigExpr28() {
    assertParse(
      """
      #if canImport(A, _version: 1️⃣>=2.2)
        let a = 1
      #endif
      """
    )
  }

  func testIfconfigExpr29() {
    assertParse(
      """
      #if canImport(A, _version: 201️⃣A301)
        let a = 1
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(message: "'A' is not a valid digit in integer literal")
      ]
    )
  }

  func testIfconfigExpr30() {
    assertParse(
      #"""
      #if canImport(A, _version: 1️⃣"20A301")
        let a = 1
      #endif
      """#
    )
  }

  func testIfconfigExpr31() {
    assertParse(
      """
      #if arch(x86_64)
        debugPrint("x86_64")
      1️⃣#else if arch(arm64)
        debugPrint("arm64")
      #else
        debugPrint("Some other architecture.")
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(
          message:
            "unexpected 'if' keyword following '#else' conditional compilation directive; did you mean '#elseif'?",
          fixIts: ["replace '#else if' with '#elseif'"]
        )
      ],
      fixedSource: """
        #if arch(x86_64)
          debugPrint("x86_64")
        #elseif arch(arm64)
          debugPrint("arm64")
        #else
          debugPrint("Some other architecture.")
        #endif
        """
    )
  }

  func testIfConfigExpr32() {
    assertParse(
      """
      #if arch(x86_64)
        debugPrint("x86_64")
      1️⃣#elif arch(arm64)
        debugPrint("arm64")
      #else
        debugPrint("Some other architecture.")
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "use of unknown directive '#elif'",
          fixIts: ["replace '#elif' with '#elseif'"]
        )
      ],
      fixedSource: """
        #if arch(x86_64)
          debugPrint("x86_64")
        #elseif arch(arm64)
          debugPrint("arm64")
        #else
          debugPrint("Some other architecture.")
        #endif
        """
    )
  }

  func testIfConfigExpr33() {
    assertParse(
      """
      #if arch(x86_64)
      #line
      #endif
      """
    )
  }

  func testIfConfigExpr34() {
    assertParse(
      """
      #if MY_FLAG
      #1️⃣
      elif
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "expected identifier in macro expansion",
          fixIts: ["insert identifier"]
        )
      ],
      fixedSource: """
        #if MY_FLAG
        #<#identifier#>
        elif
        #endif
        """
    )
  }

  func testIfConfigExpr35() {
    assertParse(
      """
      #if MY_FLAG
      #1️⃣ elif
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "extraneous whitespace after '#' is not permitted",
          fixIts: ["remove whitespace"]
        )
      ],
      fixedSource: """
        #if MY_FLAG
        #elif
        #endif
        """
    )
  }

  func testIfConfigExpr36() {
    assertParse(
      """
      switch x {
        1️⃣#()
      #if true
        2️⃣bar()
      #endif
        case .A, .B:
          break
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '#()' before conditional compilation clause"),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "all statements inside a switch must be covered by a 'case' or 'default' label",
          fixIts: ["insert label"]
        ),
      ],
      fixedSource: """
        switch x {
          #()
        #if true
        case <#identifier#>:
          bar()
        #endif
          case .A, .B:
            break
        }
        """
    )
  }

  func testCanImportFuncCall() {
    assertParse(
      """
      canImport(a, b, c)
      """
    )
  }

  func testArchFuncCall() {
    assertParse(
      """
      arch()
      """
    )
  }

  func testOsFuncCall() {
    assertParse(
      """
      os(bogus)
      """
    )
  }

  func testTargetEnvironmentFuncCall() {
    assertParse(
      """
      targetEnvironment(foo, bar)
      """
    )
  }

  func testCompilerFuncCall() {
    assertParse(
      """
      compiler(a)
      """
    )
  }

  func testSwiftFuncCall() {
    assertParse(
      """
      swift(foo)
      """
    )
  }

  func testUnknownPlatform1() {
    assertParse(
      """
      #if hasGreeble(blah)
      #endif
      """
    )
  }

  func testUnknownPlatform2() {
    assertParse(
      """
      // Future compiler, short-circuit right-hand side
      #if compiler(>=10.0) && hasGreeble(blah)
      #endif
      """
    )
  }

  func testUnknownPlatform3() {
    assertParse(
      """
      // Current compiler, short-circuit right-hand side
      #if compiler(<10.0) || hasGreeble(blah)
      #endif
      """,
      substructure: FunctionCallExprSyntax(
        calledExpression: DeclReferenceExprSyntax(baseName: .identifier("compiler")),
        leftParen: .leftParenToken(),
        arguments: LabeledExprListSyntax([
          LabeledExprSyntax(
            expression: PrefixOperatorExprSyntax(
              operator: .prefixOperator("<"),
              expression: FloatLiteralExprSyntax(literal: .floatLiteral("10.0"))
            )
          )
        ]),
        rightParen: .rightParenToken(trailingTrivia: .space)
      )
    )
  }

  func testUnknownPlatform4() {
    assertParse(
      """
      // This compiler, don't short-circuit.
      #if compiler(>=5.7) && hasGreeble(blah)
      #endif
      """
    )
  }

  func testUnknownPlatform5() {
    assertParse(
      """
      // This compiler, don't short-circuit.
      #if compiler(<5.8) || hasGreeble(blah)
      #endif
      """
    )
  }

  func testUnknownPlatform6() {
    assertParse(
      #"""
      // Not a "version" check, so don't short-circuit.
      #if os(macOS) && hasGreeble(blah)
      #endif
      """#
    )
  }

  func testUpcomingFeature1() {
    assertParse(
      """
      #if hasFeature(17)
      #endif
      """,
      substructure: IfConfigClauseSyntax(
        poundKeyword: .poundIfToken(),
        condition: FunctionCallExprSyntax(
          calledExpression: DeclReferenceExprSyntax(baseName: .identifier("hasFeature")),
          leftParen: .leftParenToken(),
          arguments: LabeledExprListSyntax([
            LabeledExprSyntax(
              expression: IntegerLiteralExprSyntax(literal: .integerLiteral("17"))
            )
          ]),
          rightParen: .rightParenToken()
        ),
        elements: .init(CodeBlockItemListSyntax([]))
      )
    )
  }

  func testCanImportWithStringVersion() {
    assertParse(
      """
      #if canImport(MyModule, _version: "1.2.3")
      #endif
      """
    )
  }
}
