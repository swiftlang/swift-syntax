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
  func testSimple() {
    AssertParse(
      """
      func tuplify<T...>(_ t: (each T)...) -> ((each T)...) {
      }
      """
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
      func tuplify<T...>(_ t: (each T)...) -> ((each T)...) {
        return ((each t)...)
      }
      """
    )

    AssertParse(
      """
      func zip<T..., U...>(_ first: T..., with second: U...) -> ((T, U)...) {
        return ((each first, each second)...)
      }
      """
    )

    AssertParse(
      """
      func variadicMap<T..., Result...>(_ t: T..., transform: ((T) -> Result)...) -> (Result...) {
        return ((each transform)(each t)...)
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
}
