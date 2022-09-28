import XCTest
import SwiftSyntaxBuilder

final class DoStmtTests: XCTestCase {
  func testDoStmt() {
    let buildable = DoStmt(
      body: CodeBlock(statementsBuilder: {
        CodeBlockItem(item: TryExpr(expression: FunctionCallExpr(calledExpression: MemberAccessExpr(base: "a", name: "b"))))
      }),
      catchClauses: [
        CatchClause(CatchItemList {
          CatchItem(pattern: "Error1")
          CatchItem(pattern: "Error2")
        }) {
          FunctionCallExpr(calledExpression: "print") {
            TupleExprElement(expression: StringLiteralExpr("Known error"))
          }
        },
        CatchClause(CatchItemList {
          CatchItem(
            pattern: "Error3", whereClause: WhereClause(guardResult: MemberAccessExpr(base: "error", name: "isError4")))
        }) {
          ThrowStmt(expression: MemberAccessExpr(base: "Error4", name: "error3"))
        },
        CatchClause {
          FunctionCallExpr(calledExpression: "print") {
            TupleExprElement(expression: "error")
          }
        }
      ])

    let syntax = buildable.buildSyntax()
    XCTAssertEqual(
      syntax.description,
      """
      do {
          try a.b()
      } catch Error1, Error2 {
          print("Known error")
      } catch Error3 where error.isError4 {
          throw Error4.error3
      } catch {
          print(error)
      }
      """)
  }
}
