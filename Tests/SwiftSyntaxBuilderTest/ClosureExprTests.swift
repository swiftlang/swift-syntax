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
import SwiftSyntaxBuilder
import XCTest

final class ClosureExprTests: XCTestCase {
  func testClosureExpr() {
    let buildable = ClosureExprSyntax(
      signature: ClosureSignatureSyntax(
        parameterClause: .simpleInput(
          ClosureShorthandParameterListSyntax {
            ClosureShorthandParameterSyntax(name: .identifier("area"))
          }
        )
      )
    ) {}

    assertBuildResult(
      buildable,
      """
      { area in
      }
      """
    )
  }
  func testClosureExprWithAsync() {
    let buildable = ClosureExprSyntax(
      signature: ClosureSignatureSyntax(
        parameterClause: .simpleInput(
          ClosureShorthandParameterListSyntax {
            ClosureShorthandParameterSyntax(name: .identifier("area"))
          }
        ),
        effectSpecifiers: TypeEffectSpecifiersSyntax(
          asyncSpecifier: .keyword(.async),
          throwsClause: ThrowsClauseSyntax(throwsSpecifier: .keyword(.throws))
        )
      )
    ) {}

    assertBuildResult(
      buildable,
      """
      { area async throws in
      }
      """
    )
  }

  func testMultiTrailingClosure() {
    let buildable = ExprSyntax(
      """
      foo { _ in
      }anotherClosure: { _ in
      }
      """
    )

    assertBuildResult(
      buildable,
      """
      foo { _ in
      } anotherClosure: { _ in
      }
      """
    )
  }
}
