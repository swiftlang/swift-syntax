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

@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class PatternTests: ParserTestCase {
  private var genericArgEnumPattern: Syntax {
    // let E<Int>.e(y)
    Syntax(
      ValueBindingPatternSyntax(
        bindingSpecifier: .keyword(.let),
        pattern: ExpressionPatternSyntax(
          expression: FunctionCallExprSyntax(
            calledExpression: MemberAccessExprSyntax(
              base: GenericSpecializationExprSyntax(
                expression: DeclReferenceExprSyntax(baseName: .identifier("E")),
                genericArgumentClause: GenericArgumentClauseSyntax(
                  arguments: .init([
                    .init(argument: .type(TypeSyntax(IdentifierTypeSyntax(name: .identifier("Int")))))
                  ])
                )
              ),
              name: .identifier("e")
            ),
            leftParen: .leftParenToken(),
            arguments: LabeledExprListSyntax([
              .init(
                expression: PatternExprSyntax(
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
        bindingSpecifier: .keyword(.let),
        pattern: ExpressionPatternSyntax(
          expression: TupleExprSyntax(
            elements: .init([
              .init(
                expression: SubscriptCallExprSyntax(
                  calledExpression: DeclReferenceExprSyntax(baseName: .identifier("y")),
                  leftSquare: .leftSquareToken(),
                  arguments: LabeledExprListSyntax([
                    .init(expression: IntegerLiteralExprSyntax(literal: .integerLiteral("0")))
                  ]),
                  rightSquare: .rightSquareToken()
                ),
                trailingComma: .commaToken()
              ),
              .init(
                expression: PatternExprSyntax(
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
        bindingSpecifier: .keyword(.let),
        pattern: ExpressionPatternSyntax(
          expression: SubscriptCallExprSyntax(
            calledExpression: DeclReferenceExprSyntax(baseName: .identifier("y")),
            leftSquare: .leftSquareToken(),
            arguments: LabeledExprListSyntax([
              .init(
                expression: PatternExprSyntax(
                  pattern: IdentifierPatternSyntax(identifier: .identifier("z"))
                )
              )
            ]),
            rightSquare: .rightSquareToken()
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

  func testPatternAsPlaceholderExpr() {
    assertParse(
      "let 1️⃣<#name#> = 2️⃣<#value#>",
      substructure: VariableDeclSyntax(
        bindingSpecifier: .keyword(.let),
        bindings: [
          PatternBindingSyntax(
            pattern: IdentifierPatternSyntax(
              identifier: .identifier("<#name#>")
            ),
            initializer: InitializerClauseSyntax(
              value: DeclReferenceExprSyntax(
                baseName: .identifier("<#value#>")
              )
            )
          )
        ]
      ),
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "editor placeholder in source file"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "editor placeholder in source file"),
      ]
    )
  }
}
