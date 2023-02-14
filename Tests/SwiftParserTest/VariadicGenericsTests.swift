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

import SwiftSyntax
import XCTest

final class VariadicGenericsTests: XCTestCase {
  func testSimpleForwarding() {
    AssertParse(
      """
      func tuplify<T...>(_ t: repeat each T) -> (repeat each T) {
        return (1️⃣repeat each t)
      }
      """,
      substructure: Syntax(
        PackExpansionExprSyntax(
          repeatKeyword: .keyword(.repeat),
          patternExpr: PackElementExprSyntax(
            eachKeyword: .keyword(.each),
            packRefExpr: IdentifierExprSyntax(
              identifier: .identifier("t")
            )
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testRequirement() {
    AssertParse(
      """
      func requirement<T...>() where each T: P {
      }
      """
    )
  }

  func testElementOutsideExpansion() {
    // This is valid to parse, and becomes invalid during type resolution.
    AssertParse(
      """
      func invalid<T...>(_ t: each T) -> each T {}
      """
    )
  }

  func testInvalidPackElement() {
    AssertParse(
      """
      func invalid<T...>() -> (each any 1️⃣T) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      func invalid<T...>(_: each T 1️⃣& P) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '& P' in parameter clause")
      ]
    )
  }

  func testPackElementExprSimple() {
    AssertParse(
      """
      func tuplify<T...>(_ t: repeat each T) -> (repeat each T) {
        return (repeat each t)
      }
      """
    )

    AssertParse(
      """
      func zip<T..., U...>(_ first: repeat each T, with second: repeat each U) -> (repeat (each T, each U)) {
        return (repeat (each first, each second))
      }
      """
    )

    AssertParse(
      """
      func variadicMap<T..., Result...>(_ t: repeat each T, transform: repeat (each T) -> each Result) -> (repeat each Result) {
        return (repeat (each transform)(each t))
      }
      """
    )
  }

  func testEachExprKeyword() {
    let callExpr = FunctionCallExprSyntax(
      calledExpression: IdentifierExprSyntax(
        identifier: .identifier("each")
      ),
      leftParen: .leftParenToken(),
      argumentList: TupleExprElementListSyntax([
        .init(
          expression:
            IdentifierExprSyntax(
              identifier: .identifier("x")
            )
        )
      ]),
      rightParen: .rightParenToken()
    )

    AssertParse(
      """
      func test() {
      1️⃣each(x)
      }
      """,
      substructure: Syntax(callExpr),
      substructureAfterMarker: "1️⃣"
    )

    AssertParse(
      """
      func test() {
      1️⃣each (x)
      }
      """,
      substructure: Syntax(callExpr),
      substructureAfterMarker: "1️⃣"
    )

    AssertParse(
      """
      func test() {
      1️⃣each x
      }
      """,
      substructure: Syntax(
        PackElementExprSyntax(
          eachKeyword: .keyword(.each),
          packRefExpr: IdentifierExprSyntax(
            identifier: .identifier("x")
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testPackExpansionExpr() {
    AssertParse(
      """
      func expand<T...>(_ t: repeat each T) {
        1️⃣repeat (each t).member()
      }
      """,
      substructure: Syntax(
        PackExpansionExprSyntax(
          repeatKeyword: .keyword(.repeat),
          patternExpr: FunctionCallExprSyntax(
            callee: MemberAccessExprSyntax(
              base: ExprSyntax(
                TupleExprSyntax(
                  elementList: .init([
                    TupleExprElementSyntax(
                      expression: PackElementExprSyntax(
                        eachKeyword: .keyword(.each),
                        packRefExpr: IdentifierExprSyntax(
                          identifier: .identifier("t")
                        )
                      )
                    )
                  ])
                )
              ),
              name: "member"
            )
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    AssertParse(
      """
      func expand<T...>(_ t: repeat each T) {
        1️⃣repeat each t.member
      }
      """,
      substructure: Syntax(
        PackExpansionExprSyntax(
          repeatKeyword: .keyword(.repeat),
          patternExpr: PackElementExprSyntax(
            eachKeyword: .keyword(.each),
            packRefExpr: MemberAccessExprSyntax(
              base: ExprSyntax(
                IdentifierExprSyntax(
                  identifier: .identifier("t")
                )
              ),
              name: "member"
            )
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )

    AssertParse(
      """
      func expand<T...>(_ t: repeat each T) {
        1️⃣repeat x + each t + 10
      }
      """,
      substructure: Syntax(
        PackExpansionExprSyntax(
          repeatKeyword: .keyword(.repeat),
          patternExpr: SequenceExprSyntax(
            elements: .init([
              ExprSyntax(
                IdentifierExprSyntax(
                  identifier: .identifier("x")
                )
              ),
              ExprSyntax(
                BinaryOperatorExprSyntax(
                  operatorToken: .binaryOperator("+")
                )
              ),
              ExprSyntax(
                PackElementExprSyntax(
                  eachKeyword: .keyword(.each),
                  packRefExpr: IdentifierExprSyntax(
                    identifier: .identifier("t")
                  )
                )
              ),
              ExprSyntax(
                BinaryOperatorExprSyntax(
                  operatorToken: .binaryOperator("+")
                )
              ),
              ExprSyntax(
                IntegerLiteralExprSyntax(
                  integerLiteral: 10
                )
              ),
            ])
          )
        )
      ),
      substructureAfterMarker: "1️⃣"
    )
  }

  func testMetatype() {
    AssertParse(
      """
      G<Int, repeat Array<each T>>.self
      """
    )
  }
}

final class TypeParameterPackTests: XCTestCase {
  func testParameterPacks1() {
    AssertParse(
      """
      func f1<T...>() -> repeat each T {}
      """
    )
  }
  func testParameterPacks2() {
    AssertParse(
      """
      func f2<T...>() -> (repeat each T) {}
      """
    )
  }
  func testParameterPacks3() {
    AssertParse(
      """
      func f3<T...>() -> G<repeat each T> {}
      """
    )
  }
  func testParameterPacks4() {
    AssertParse(
      """
      protocol P {
        associatedtype T1️⃣...
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "associated types cannot be variadic",
          fixIts: ["remove '...'"]
        )
      ]
    )
  }
  func testParameterPacks5() {
    AssertParse(
      """
      typealias Alias<T...> = (repeat each T)
      """
    )
  }
  func testParameterPacks6() {
    AssertParse(
      """
      struct S<T...> {}
      """
    )
  }
  func testParameterPacks7() {
    AssertParse(
      """
      struct S<T, U...> {}
      """
    )
  }
  func testParameterPacks8() {
    AssertParse(
      """
      struct S<T..., U> {}
      """
    )
  }
  func testParameterPacks9() {
    AssertParse(
      """
      struct S<T...:P, U> {}
      """
    )
  }
  func testParameterPacks10() {
    AssertParse(
      """
      struct S<T... :P, U> {}
      """
    )
  }
  func testParameterPacks11() {
    AssertParse(
      """
      struct S<T...: P> {}
      """
    )
  }
  func testParameterPacks12() {
    AssertParse(
      """
      struct S<T... : P> {}
      """
    )
  }
  func testParameterPacks13() {
    AssertParse(
      """
      func foo<T...>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks14() {
    AssertParse(
      """
      func foo<T...:P>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks15() {
    AssertParse(
      """
      func foo<T... :P>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks16() {
    AssertParse(
      """
      func foo<T... : P>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks17() {
    AssertParse(
      """
      func foo<T...: P>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks18() {
    AssertParse(
      """
      func foo<T, U, V...>(x: T, y: U, z: repeat each V) { }
      """
    )
  }
  func testParameterPacks19() {
    AssertParse(
      """
      func foo<T, U..., V>(x: T, y: repeat each U, z: V) { }
      """
    )
  }
  func testParameterPacks20() {
    AssertParse(
      """
      func foo<T..., U..., V...>(x: repeat each T, y: repeat each U, z: repeat each V) { }
      """
    )
  }
  func testParameterPacks21() {
    AssertParse(
      """
      enum E<T...> {
        case f1(_: repeat each T)
      }
      """
    )
  }
  func testParameterPacks22() {
    AssertParse(
      """
      enum E<T...> {
        case f2(_: G<repeat each T>)
      }
      """
    )
  }
  func testParameterPacks23() {
    AssertParse(
      """
      enum E<T...> {
        var x: repeat each T { fatalError() }
      }
      """
    )
  }
  func testParameterPacks24() {
    AssertParse(
      """
      enum E<T...> {
        var x: (repeat each T) { fatalError() }
      }
      """
    )
  }
  func testParameterPacks25() {
    AssertParse(
      """
      enum E<T...> {
        subscript(_: repeat each T) -> Int { fatalError() }
      }
      """
    )
  }
  func testParameterPacks26() {
    AssertParse(
      """
      enum E<T...> {
        subscript() -> repeat each T { fatalError() }
      }
      """
    )
  }
  func testParameterPacks27() {
    AssertParse(
      """
      enum E<T...> {
        subscript() -> (repeat each T) { fatalError() }
      }
      """
    )
  }

  func testVariadicTypes() {
    AssertParse(
      """
      let _: G< > = G()
      let _: G<repeat each T> = G()
      let _: G<Int, repeat each T> = G()
      let _ = G< >.self
      let _ = G<repeat each T>.self
      let _ = G<Int, repeat each T>.self
      """
    )

  }

  func testMissingCommaInType() throws {
    AssertParse(
      """
      var foo: (Int)
      """
    )

    AssertParse(
      """
      var foo: (Int, Int)
      """
    )

    AssertParse(
      """
      var foo: (bar: Int 1️⃣bar2: Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (bar: Int 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (a 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (A 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (_ 1️⃣a 2️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in tuple type"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ',' in tuple type"),
      ]
    )

    AssertParse(
      """
      var foo: (Array<Foo> 1️⃣Array<Bar>)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (a 1️⃣Array<Bar>)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in tuple type")
      ]
    )

    AssertParse(
      """
      var foo: (Array<Foo> 1️⃣a)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type")
      ]
    )
  }
}
