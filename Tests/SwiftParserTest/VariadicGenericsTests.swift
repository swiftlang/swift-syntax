//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
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
          repeatKeyword: .repeatKeyword(),
          patternExpr: PackElementExprSyntax(
            eachKeyword: .contextualKeyword("each"),
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

  func testEachExprContextualKeyword() {
    let callExpr = FunctionCallExprSyntax(
      calledExpression: IdentifierExprSyntax(
        identifier: .identifier("each")
      ),
      leftParen: .leftParen,
      argumentList: TupleExprElementListSyntax([
        .init(
          expression:
            IdentifierExprSyntax(
              identifier: .identifier("x")
            )
        )
      ]),
      rightParen: .rightParen
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
          eachKeyword: .contextualKeyword("each"),
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
          repeatKeyword: .repeatKeyword(),
          patternExpr: FunctionCallExprSyntax(
            callee: MemberAccessExprSyntax(
              base: ExprSyntax(
                TupleExprSyntax(
                  elementList: .init([
                    TupleExprElementSyntax(
                      expression: PackElementExprSyntax(
                        eachKeyword: .contextualKeyword("each"),
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
          repeatKeyword: .repeatKeyword(),
          patternExpr: PackElementExprSyntax(
            eachKeyword: .contextualKeyword("each"),
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
          repeatKeyword: .repeatKeyword(),
          patternExpr: SequenceExprSyntax(
            elements: .init([
              ExprSyntax(
                IdentifierExprSyntax(
                  identifier: .identifier("x")
                )
              ),
              ExprSyntax(
                BinaryOperatorExprSyntax(
                  operatorToken: .spacedBinaryOperator("+")
                )
              ),
              ExprSyntax(
                PackElementExprSyntax(
                  eachKeyword: .contextualKeyword("each"),
                  packRefExpr: IdentifierExprSyntax(
                    identifier: .identifier("t")
                  )
                )
              ),
              ExprSyntax(
                BinaryOperatorExprSyntax(
                  operatorToken: .spacedBinaryOperator("+")
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
