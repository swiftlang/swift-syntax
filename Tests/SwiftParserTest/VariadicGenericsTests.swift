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
    assertParse(
      """
      func tuplify<each T>(_ t: repeat each T) -> (repeat each T) {
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
    assertParse(
      """
      func requirement<each T>() where each T: P {
      }
      """
    )
  }

  func testElementOutsideExpansion() {
    // This is valid to parse, and becomes invalid during type resolution.
    assertParse(
      """
      func invalid<each T>(_ t: each T) -> each T {}
      """
    )
  }

  func testInvalidPackElement() {
    assertParse(
      """
      func invalid<each T>() -> (each any 1️⃣T) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type", fixIts: ["insert ','"])
      ]
    )

    assertParse(
      """
      func invalid<each T>(_: each T 1️⃣& P) {}
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code '& P' in parameter clause")
      ]
    )
  }

  func testTypeParameterPackEllipsis() {
    assertParse(
      """
      func invalid<T1️⃣...>(_ t: repeat each T) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "ellipsis operator cannot be used with a type parameter pack",
          fixIts: ["replace '...' with 'each'"]
        )
      ],
      fixedSource: """
        func invalid<each T>(_ t: repeat each T) {}
        """
    )
  }

  func testTypeParameterPackEachEllipsis() {
    assertParse(
      """
      func invalid<each T1️⃣...>(_ t: repeat each T) {}
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "ellipsis operator cannot be used with a type parameter pack",
          fixIts: ["remove '...'"]
        )
      ]
    )
  }

  func testPackElementExprSimple() {
    assertParse(
      """
      func tuplify<each T>(_ t: repeat each T) -> (repeat each T) {
        return (repeat each t)
      }
      """
    )

    assertParse(
      """
      func zip<each T, each U>(_ first: repeat each T, with second: repeat each U) -> (repeat (each T, each U)) {
        return (repeat (each first, each second))
      }
      """
    )

    assertParse(
      """
      func variadicMap<each T, each Result>(_ t: repeat each T, transform: repeat (each T) -> each Result) -> (repeat each Result) {
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

    assertParse(
      """
      func test() {
      1️⃣each(x)
      }
      """,
      substructure: Syntax(callExpr),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
      """
      func test() {
      1️⃣each (x)
      }
      """,
      substructure: Syntax(callExpr),
      substructureAfterMarker: "1️⃣"
    )

    assertParse(
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
    assertParse(
      """
      func expand<each T>(_ t: repeat each T) {
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

    assertParse(
      """
      func expand<each T>(_ t: repeat each T) {
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

    assertParse(
      """
      func expand<each T>(_ t: repeat each T) {
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
    assertParse(
      """
      G<Int, repeat Array<each T>>.self
      """
    )
  }
}

final class TypeParameterPackTests: XCTestCase {
  func testParameterPacks1() {
    assertParse(
      """
      func f1<each T>() -> repeat each T {}
      """
    )
  }
  func testParameterPacks2() {
    assertParse(
      """
      func f2<each T>() -> (repeat each T) {}
      """
    )
  }
  func testParameterPacks3() {
    assertParse(
      """
      func f3<each T>() -> G<repeat each T> {}
      """
    )
  }
  func testParameterPacks4() {
    assertParse(
      """
      protocol P {
        associatedtype 1️⃣each T
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "associated types cannot be variadic",
          fixIts: ["remove 'each'"]
        )
      ]
    )
  }
  func testParameterPacks4EarlySyntax() {
    assertParse(
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
    assertParse(
      """
      typealias Alias<each T> = (repeat each T)
      """
    )
  }
  func testParameterPacks6() {
    assertParse(
      """
      struct S<each T> {}
      """
    )
  }
  func testParameterPacks7() {
    assertParse(
      """
      struct S<T, each U> {}
      """
    )
  }
  func testParameterPacks8() {
    assertParse(
      """
      struct S<each T, U> {}
      """
    )
  }
  func testParameterPacks9() {
    assertParse(
      """
      struct S<each T:P, U> {}
      """
    )
  }
  func testParameterPacks10() {
    assertParse(
      """
      struct S<each T :P, U> {}
      """
    )
  }
  func testParameterPacks11() {
    assertParse(
      """
      struct S<each T: P> {}
      """
    )
  }
  func testParameterPacks12() {
    assertParse(
      """
      struct S<each T : P> {}
      """
    )
  }
  func testParameterPacks13() {
    assertParse(
      """
      func foo<each T>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks14() {
    assertParse(
      """
      func foo<each T:P>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks15() {
    assertParse(
      """
      func foo<each T :P>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks16() {
    assertParse(
      """
      func foo<each T : P>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks17() {
    assertParse(
      """
      func foo<each T: P>(_ x: repeat each T) {}
      """
    )
  }
  func testParameterPacks18() {
    assertParse(
      """
      func foo<T, U, each V>(x: T, y: U, z: repeat each V) { }
      """
    )
  }
  func testParameterPacks19() {
    assertParse(
      """
      func foo<T, each U, V>(x: T, y: repeat each U, z: V) { }
      """
    )
  }
  func testParameterPacks20() {
    assertParse(
      """
      func foo<each T, each U, each V>(x: repeat each T, y: repeat each U, z: repeat each V) { }
      """
    )
  }
  func testParameterPacks21() {
    assertParse(
      """
      enum E<each T> {
        case f1(_: repeat each T)
      }
      """
    )
  }
  func testParameterPacks22() {
    assertParse(
      """
      enum E<each T> {
        case f2(_: G<repeat each T>)
      }
      """
    )
  }
  func testParameterPacks23() {
    assertParse(
      """
      enum E<each T> {
        var x: repeat each T { fatalError() }
      }
      """
    )
  }
  func testParameterPacks24() {
    assertParse(
      """
      enum E<each T> {
        var x: (repeat each T) { fatalError() }
      }
      """
    )
  }
  func testParameterPacks25() {
    assertParse(
      """
      enum E<each T> {
        subscript(_: repeat each T) -> Int { fatalError() }
      }
      """
    )
  }
  func testParameterPacks26() {
    assertParse(
      """
      enum E<each T> {
        subscript() -> repeat each T { fatalError() }
      }
      """
    )
  }
  func testParameterPacks27() {
    assertParse(
      """
      enum E<each T> {
        subscript() -> (repeat each T) { fatalError() }
      }
      """
    )
  }

  func testVariadicTypes() {
    assertParse(
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
    assertParse(
      """
      var foo: (Int)
      """
    )

    assertParse(
      """
      var foo: (Int, Int)
      """
    )

    assertParse(
      """
      var foo: (bar: Int 1️⃣bar2: Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type", fixIts: ["insert ','"])
      ],
      fixedSource: """
        var foo: (bar: Int, bar2: Int)
        """
    )

    assertParse(
      """
      var foo: (bar: Int 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type", fixIts: ["insert ','"])
      ]
    )

    assertParse(
      """
      var foo: (a 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in tuple type", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        var foo: (a: Int)
        """
    )

    assertParse(
      """
      var foo: (A 1️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type", fixIts: ["insert ','"])
      ]
    )

    assertParse(
      """
      var foo: (_ 1️⃣a 2️⃣Int)
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "expected ':' in tuple type", fixIts: ["insert ':'"]),
        DiagnosticSpec(locationMarker: "2️⃣", message: "expected ',' in tuple type", fixIts: ["insert ','"]),
      ]
    )

    assertParse(
      """
      var foo: (Array<Foo> 1️⃣Array<Bar>)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type", fixIts: ["insert ','"])
      ],
      fixedSource: """
        var foo: (Array<Foo>, Array<Bar>)
        """
    )

    assertParse(
      """
      var foo: (a 1️⃣Array<Bar>)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ':' in tuple type", fixIts: ["insert ':'"])
      ],
      fixedSource: """
        var foo: (a: Array<Bar>)
        """
    )

    assertParse(
      """
      var foo: (Array<Foo> 1️⃣a)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected ',' in tuple type", fixIts: ["insert ','"])
      ],
      fixedSource: """
        var foo: (Array<Foo>, a)
        """
    )
  }
}
