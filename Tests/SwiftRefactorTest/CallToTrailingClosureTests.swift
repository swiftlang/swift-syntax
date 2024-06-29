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

import SwiftBasicFormat
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

final class CallToTrailingClosuresTest: XCTestCase {
  func testSingleClosure() throws {
    let baseline: ExprSyntax = """
      foo({ label in
          return 1
      })
      """

    let expected: ExprSyntax = """
      foo { label in
          return 1
      }
      """

    try assertRefactorCall(baseline, expected: expected)
  }

  func testSingleNamedClosure() throws {
    let baseline: ExprSyntax = """
      foo(arg: { label in
          return 1
      })
      """

    let expected: ExprSyntax = """
      foo { label in
          return 1
      }
      """

    try assertRefactorCall(baseline, expected: expected)
  }

  func testSuffixClosure() throws {
    let baseline: ExprSyntax = """
      foo(1, { label in
          return 1
      })
      """

    let expected: ExprSyntax = """
      foo(1) { label in
          return 1
      }
      """

    try assertRefactorCall(baseline, expected: expected)
  }

  func testSuffixClosures() throws {
    let baseline: ExprSyntax = """
      foo({ label in
          return 1
      }, 1, { label2 in
          return 2
      }, { label3 in
          return 3
      }, named: { label4 in
          return 4
      })
      """

    // TODO: The ident here is not great.
    // https://github.com/swiftlang/swift-syntax/issues/1473
    let expected: ExprSyntax = """
      foo({ label in
          return 1
          }, 1) { label2 in
          return 2
      } _: { label3 in
          return 3
      } named: { label4 in
          return 4
      }
      """

    try assertRefactorCall(baseline, expected: expected)
  }

  func testSomeSuffixClosures() throws {
    let baseline: ExprSyntax = """
      foo({ label in
          return 1
      }, 1, { label2 in
          return 2
      }, { label3 in
          return 3
      }, named: { label4 in
          return 4
      })
      """

    // TODO: BasicFormat is pretty messed up here
    let expected: ExprSyntax = """
      foo({ label in
          return 1
          }, 1, { label2 in
          return 2
          }) { label3 in
          return 3
      } named: { label4 in
          return 4
      }
      """

    try assertRefactorCall(baseline, startAtArgument: 3, expected: expected)
  }

  func testNoArgs() throws {
    let baseline: ExprSyntax = """
      foo()
      """

    try assertRefactorCall(baseline, expected: nil)
  }

  func testNonSuffixClosure() throws {
    let baseline: ExprSyntax = """
      foo({ _ in }, 1)
      """

    try assertRefactorCall(baseline, expected: nil)
  }

  func testExistingTrailingClosure() throws {
    let baseline: ExprSyntax = """
      foo({ _ in }) { _ in }
      """

    try assertRefactorCall(baseline, expected: nil)
  }

  func testExistingAdditionalTrailingClosure() throws {
    let baseline = ExprSyntax(
      """
      foo({ _ in }) { _ in
      } another: { _ in
      }
      """
    )
    .cast(FunctionCallExprSyntax.self)
    .with(\.trailingClosure, nil)

    try assertRefactorCall(ExprSyntax(baseline), expected: nil)
  }

  func testMissingParens() throws {
    let baseline = ExprSyntax(
      """
      foo(1, { label in
          return 1
      })
      """
    )
    .cast(FunctionCallExprSyntax.self)
    .with(\.leftParen, nil)
    .with(\.rightParen, nil)

    try assertRefactorCall(ExprSyntax(baseline), expected: nil)
  }

  func testBadContext() throws {
    try assertRefactorCall("foo({ _ in })", startAtArgument: 1, expected: nil)
  }

  func testSingleClosureComments() throws {
    let baseline: ExprSyntax = """
      /*c1*/foo/*c2*/(/*c3*/1/*c4*/, /*c5*/arg/*c6*/:/*c7*/ {/*c8*/ label in
          return 1
      /*c9*/}/*c10*/)/*c11*/
      """

    let expected: ExprSyntax = """
      /*c1*/foo/*c2*/(/*c3*/1/*c4*/) /*c5*/ /*c6*//*c7*/ {/*c8*/ label in
          return 1
      /*c9*/}/*c10*//*c11*/
      """

    try assertRefactorCall(baseline, expected: expected)
  }

  func testTrailingClosureComments() throws {
    let baseline: ExprSyntax = """
      /*c1*/foo/*c2*/(/*c3*/1/*c4*/, /*c5*/arg/*c6*/: /*c7*/{/*c8*/ label in
          return 1
      /*c9*/}/*c10*/, /*c11*/named/*c12*/: /*c13*/{/*c14*/ label2 in
          return 2
      /*c15*/}/*c16*/)/*c17*/
      """

    let expected: ExprSyntax = """
      /*c1*/foo/*c2*/(/*c3*/1/*c4*/) /*c5*/ /*c6*/ /*c7*/{/*c8*/ label in
          return 1
      /*c9*/}/*c10*/ /*c11*/ named/*c12*/: /*c13*/ {/*c14*/ label2 in
          return 2
      /*c15*/}/*c16*//*c17*/
      """

    try assertRefactorCall(baseline, expected: expected)
  }

  func testClosureWithArgumentLabel() throws {
    try assertRefactorCall(
      """
      foo(arg: 1, closure: { someInt in

      })
      """,
      expected: """
        foo(arg: 1) { someInt in

        }
        """
    )
  }

  func testCallHasInitialIndentationIndentation() throws {
    try assertRefactorCall(
      """
          foo(arg: 1, closure: { someInt in
              "abc"
          })
      """,
      expected: """
            foo(arg: 1) { someInt in
                "abc"
            }
        """
    )
  }
}

fileprivate func assertRefactorCall(
  _ callExpr: ExprSyntax,
  startAtArgument: Int = 0,
  expected: ExprSyntax?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  try assertRefactor(
    callExpr,
    context: CallToTrailingClosures.Context(startAtArgument: startAtArgument),
    provider: CallToTrailingClosures.self,
    expected: expected,
    file: file,
    line: line
  )
}
