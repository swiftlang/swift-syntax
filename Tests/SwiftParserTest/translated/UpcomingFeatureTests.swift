// This test file has been translated from swift/test/Parse/upcoming_feature.swift

import XCTest
import SwiftSyntax

final class UpcomingFeatureTests: XCTestCase {
  func testUpcomingFeature1() {
    AssertParse(
      """
      #if hasFeature(17)
      #endif
      """,
      substructure: Syntax(IfConfigClauseSyntax(
        poundKeyword: .poundIfKeyword(),
        condition: ExprSyntax(FunctionCallExprSyntax(
          calledExpression: ExprSyntax(IdentifierExprSyntax(identifier: .identifier("hasFeature"), declNameArguments: nil)),
          leftParen: .leftParenToken(),
          argumentList: TupleExprElementListSyntax([
            TupleExprElementSyntax(
              label: nil,
              colon: nil,
              expression: ExprSyntax(IntegerLiteralExprSyntax(digits: .integerLiteral("17"))),
              trailingComma: nil
            )
          ]),
          rightParen: .rightParenToken(),
          trailingClosure: nil,
          additionalTrailingClosures: nil
        )),
        elements: Syntax(CodeBlockItemListSyntax([]))
      ))
    )
  }

}
