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

    AssertBuildResult(
      buildable,
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
