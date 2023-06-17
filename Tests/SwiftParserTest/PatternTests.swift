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

@_spi(RawSyntax) import SwiftSyntax
@_spi(RawSyntax) import SwiftParser
import XCTest

final class PatternTests: XCTestCase {
  private var genericArgEnumPattern: Syntax {
    // let E<Int>.e(y)
    Syntax(
      ValueBindingPatternSyntax(
        bindingKeyword: .keyword(.let),
        valuePattern: ExpressionPatternSyntax(
          expression: FunctionCallExprSyntax(
            calledExpression: MemberAccessExprSyntax(
              base: SpecializeExprSyntax(
                expression: IdentifierExprSyntax(identifier: .identifier("E")),
                genericArgumentClause: GenericArgumentClauseSyntax(
                  arguments: .init([
                    .init(argumentType: SimpleTypeIdentifierSyntax(name: .identifier("Int")))
                  ])
                )
              ),
              name: .identifier("e")
            ),
            leftParen: .leftParenToken(),
            argumentList: TupleExprElementListSyntax([
              .init(
                expression: UnresolvedPatternExprSyntax(
                  pattern: IdentifierPatternSyntax(identifier: .identifier("y"))
                )
              )
            ]),
            rightParen: .rightParenToken()
          )
        )
      )
    )
  }

  func testNonBinding1() {
    assertParse(
      """
      if case let E<Int>.e(y) = x {}
      """,
      substructure: genericArgEnumPattern
    )
  }

  func testNonBinding2() {
    assertParse(
      """
      switch e {
      case let E<Int>.e(y):
        y
      }
      """,
      substructure: genericArgEnumPattern
    )
  }

  private var tupleWithSubscriptAndBindingPattern: Syntax {
    // let (y[0], z)
    Syntax(
      ValueBindingPatternSyntax(
        bindingKeyword: .keyword(.let),
        valuePattern: ExpressionPatternSyntax(
          expression: TupleExprSyntax(
            elementList: .init([
              .init(
                expression: SubscriptExprSyntax(
                  calledExpression: IdentifierExprSyntax(identifier: .identifier("y")),
                  leftBracket: .leftSquareBracketToken(),
                  argumentList: TupleExprElementListSyntax([
                    .init(expression: IntegerLiteralExprSyntax(digits: .integerLiteral("0")))
                  ]),
                  rightBracket: .rightSquareBracketToken()
                ),
                trailingComma: .commaToken()
              ),
              .init(
                expression: UnresolvedPatternExprSyntax(
                  pattern: IdentifierPatternSyntax(identifier: .identifier("z"))
                )
              ),
            ])
          )
        )
      )
    )
  }

  func testNonBinding3() {
    assertParse(
      """
      if case let (y[0], z) = x {}
      """,
      substructure: tupleWithSubscriptAndBindingPattern
    )
  }

  func testNonBinding4() {
    assertParse(
      """
      switch x {
      case let (y[0], z):
        z
      }
      """,
      substructure: tupleWithSubscriptAndBindingPattern
    )
  }

  private var subscriptWithBindingPattern: Syntax {
    // let y[z]
    Syntax(
      ValueBindingPatternSyntax(
        bindingKeyword: .keyword(.let),
        valuePattern: ExpressionPatternSyntax(
          expression: SubscriptExprSyntax(
            calledExpression: IdentifierExprSyntax(identifier: .identifier("y")),
            leftBracket: .leftSquareBracketToken(),
            argumentList: TupleExprElementListSyntax([
              .init(
                expression: UnresolvedPatternExprSyntax(
                  pattern: IdentifierPatternSyntax(identifier: .identifier("z"))
                )
              )
            ]),
            rightBracket: .rightSquareBracketToken()
          )
        )
      )
    )
  }

  func testNonBinding5() {
    assertParse(
      """
      if case let y[z] = x {}
      """,
      substructure: subscriptWithBindingPattern
    )
  }

  func testNonBinding6() {
    assertParse(
      """
      switch 0 {
      case let y[z]:
        z
      case y[z]:
        0
      default:
        0
      }
      """,
      substructure: subscriptWithBindingPattern
    )
  }
}
