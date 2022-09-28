import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class IfStmtTests: XCTestCase {
  func testEmptyIfStmt() {
    // Use the convenience initializer from IfStmtConvenienceInitializers. This is
    // disambiguated by the absence of a labelName parameter and the use of a
    // trailing closure.
    let buildable = IfStmt(conditions: ExprList([BooleanLiteralExpr(false)])) {}
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, """
      if false {
      }
      """)
  }

  func testIfElseStmt() {
    // Use the convenience initializer from IfStmtConvenienceInitializers
    // with an else branch expressed by a second trailing closure.
    let buildable = IfStmt(conditions: ExprList([BooleanLiteralExpr(true)])) {
      FunctionCallExpr(calledExpression: "print") {
        TupleExprElement(expression: StringLiteralExpr("Hello from the if-branch!"))
      }
    } elseBody: {
      FunctionCallExpr(calledExpression: "print") {
        TupleExprElement(expression: StringLiteralExpr("Hello from the else-branch!"))
      }
    }
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, """
      if true {
          print("Hello from the if-branch!")
      } else {
          print("Hello from the else-branch!")
      }
      """)
  }

  func testIfLetStmt() {
    let buildable = IfStmt(
      conditions: OptionalBindingCondition(
        letOrVarKeyword: .let,
        pattern: "x",
        initializer: InitializerClause(value: "y")
      )
    ) {}
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, """
      if let x = y {
      }
      """)
  }

  func testIfCaseStmt() {
    let buildable = IfStmt(
      conditions: MatchingPatternCondition(
        pattern: ExpressionPattern(expression: MemberAccessExpr(name: "x")),
        initializer: InitializerClause(value: "y")
      )
    ) {}
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, """
      if case .x = y {
      }
      """)
  }
}
