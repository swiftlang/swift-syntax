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

final class DoStmtTests: XCTestCase {
  func testDoStmt() {
    let buildable = DoStmtSyntax(
      body: CodeBlockSyntax(statementsBuilder: {
        TryExprSyntax(expression: FunctionCallExprSyntax(callee: ExprSyntax("a.b")))
      }),
      catchClauses: [
        CatchClauseSyntax(
          CatchItemListSyntax {
            CatchItemSyntax(pattern: PatternSyntax("Error1"))
            CatchItemSyntax(pattern: PatternSyntax("Error2"))
          }
        ) {
          FunctionCallExprSyntax(callee: ExprSyntax("print")) {
            LabeledExprSyntax(expression: StringLiteralExprSyntax(content: "Known error"))
          }
        },
        CatchClauseSyntax(
          CatchItemListSyntax {
            CatchItemSyntax(
              pattern: PatternSyntax("Error3"),
              whereClause: WhereClauseSyntax(condition: ExprSyntax("error.isError4"))
            )
          }
        ) {
          ThrowStmtSyntax(expression: ExprSyntax("Error4.error3"))
        },
        CatchClauseSyntax {
          FunctionCallExprSyntax(callee: ExprSyntax("print")) {
            LabeledExprSyntax(expression: ExprSyntax("error"))
          }
        },
      ]
    )

    assertBuildResult(
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
      """
    )
  }

  func testDoStmtWithExclamationMark() {
    let buildable = DoStmtSyntax(
      body: CodeBlockSyntax(statementsBuilder: {
        TryExprSyntax(
          questionOrExclamationMark: .exclamationMarkToken(),
          expression: FunctionCallExprSyntax(callee: ExprSyntax("a.b"))
        )
      }),
      catchClauses: [
        CatchClauseSyntax(
          CatchItemListSyntax {
            CatchItemSyntax(pattern: PatternSyntax("Error1"))
            CatchItemSyntax(pattern: PatternSyntax("Error2"))
          }
        ) {
          FunctionCallExprSyntax(callee: ExprSyntax("print")) {
            LabeledExprSyntax(expression: StringLiteralExprSyntax(content: "Known error"))
          }
        },
        CatchClauseSyntax(
          CatchItemListSyntax {
            CatchItemSyntax(
              pattern: PatternSyntax("Error3"),
              whereClause: WhereClauseSyntax(condition: ExprSyntax("error.isError4"))
            )
          }
        ) {
          ThrowStmtSyntax(expression: ExprSyntax("Error4.error3"))
        },
        CatchClauseSyntax {
          FunctionCallExprSyntax(callee: ExprSyntax("print")) {
            LabeledExprSyntax(expression: ExprSyntax("error"))
          }
        },
      ]
    )

    assertBuildResult(
      buildable,
      """
      do {
          try! a.b()
      } catch Error1, Error2 {
          print("Known error")
      } catch Error3 where error.isError4 {
          throw Error4.error3
      } catch {
          print(error)
      }
      """
    )
  }

  func testDoStmtWithPostfixQuestionMark() {
    let buildable = DoStmtSyntax(
      body: CodeBlockSyntax(statementsBuilder: {
        TryExprSyntax(
          questionOrExclamationMark: .postfixQuestionMarkToken(),
          expression: FunctionCallExprSyntax(callee: ExprSyntax("a.b"))
        )
      }),
      catchClauses: [
        CatchClauseSyntax(
          CatchItemListSyntax {
            CatchItemSyntax(pattern: PatternSyntax("Error1"))
            CatchItemSyntax(pattern: PatternSyntax("Error2"))
          }
        ) {
          FunctionCallExprSyntax(callee: ExprSyntax("print")) {
            LabeledExprSyntax(expression: StringLiteralExprSyntax(content: "Known error"))
          }
        },
        CatchClauseSyntax(
          CatchItemListSyntax {
            CatchItemSyntax(
              pattern: PatternSyntax("Error3"),
              whereClause: WhereClauseSyntax(condition: ExprSyntax("error.isError4"))
            )
          }
        ) {
          ThrowStmtSyntax(expression: ExprSyntax("Error4.error3"))
        },
        CatchClauseSyntax {
          FunctionCallExprSyntax(callee: ExprSyntax("print")) {
            LabeledExprSyntax(expression: ExprSyntax("error"))
          }
        },
      ]
    )

    assertBuildResult(
      buildable,
      """
      do {
          try? a.b()
      } catch Error1, Error2 {
          print("Known error")
      } catch Error3 where error.isError4 {
          throw Error4.error3
      } catch {
          print(error)
      }
      """
    )
  }
}
