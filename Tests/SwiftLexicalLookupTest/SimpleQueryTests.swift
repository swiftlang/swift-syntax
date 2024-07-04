//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
@_spi(Experimental) import SwiftLexicalLookup
import SwiftSyntax
import XCTest

final class testSimpleQueries: XCTestCase {
  func testLabeledStmtLookupThreeNested() {
    assertLexicalScopeQuery(
      source: """
        1️⃣one: for i in 1..<10 {
          while true {
            2️⃣two: do {
              3️⃣break one
            } while true
          }
          4️⃣break
        }
        """,
      methodUnderTest: { argument in
        argument.lookupLabeledStmts()
      },
      expected: ["3️⃣": ["2️⃣", "1️⃣"], "4️⃣": ["1️⃣"]]
    )
  }

  func testNoLabeledStatements() {
    assertLexicalScopeQuery(
      source: """
        while true {
          1️⃣break
        }
        """,
      methodUnderTest: { argument in
        argument.lookupLabeledStmts()
      },
      expected: ["1️⃣": []]
    )
  }

  func testLabeledStmtLookupClassNestedWithinLoop() {
    assertLexicalScopeQuery(
      source: """
        1️⃣one: while true {
          class a {
            func foo() {
              2️⃣two: while true {
                3️⃣break
              }
            }
          }
          4️⃣break
        }
        """,
      methodUnderTest: { argument in
        argument.lookupLabeledStmts()
      },
      expected: ["3️⃣": ["2️⃣"], "4️⃣": ["1️⃣"]]
    )
  }

  func testLabeledStmtLookupClosureNestedWithinLoop() {
    assertLexicalScopeQuery(
      source: """
        1️⃣one: while true {
          var a = {
            2️⃣two: while true {
              3️⃣break
            }
          }
          4️⃣break
        }
        """,
      methodUnderTest: { argument in
        argument.lookupLabeledStmts()
      },
      expected: ["3️⃣": ["2️⃣"], "4️⃣": ["1️⃣"]]
    )
  }

  func testLabeledStmtLookupFunctionNestedWithinLoop() {
    assertLexicalScopeQuery(
      source: """
        1️⃣one: while true {
          func foo() {
            2️⃣two: while true {
              3️⃣break
            }
          }
          4️⃣break
        }
        """,
      methodUnderTest: { argument in
        argument.lookupLabeledStmts()
      },
      expected: ["3️⃣": ["2️⃣"], "4️⃣": ["1️⃣"]]
    )
  }

  func testLookupFallthroughDestination() {
    assertLexicalScopeQuery(
      source: """
        func foo() {
          7️⃣fallthrough
        }

        switch a {
        1️⃣case 1:
          2️⃣fallthrough
        3️⃣case 2:
          4️⃣fallthrough
        5️⃣default:
          6️⃣fallthrough
        }
        """,
      methodUnderTest: { argument in
        guard let fallthroughStmt = argument.ancestorOrSelf(mapping: { $0.as(FallThroughStmtSyntax.self) }) else {
          return []
        }
        let result = fallthroughStmt.lookupFallthroughSourceAndDestintation()
        return [result.source, result.destination]
      },
      expected: ["2️⃣": ["1️⃣", "3️⃣"], "4️⃣": ["3️⃣", "5️⃣"], "6️⃣": ["5️⃣", nil], "7️⃣": [nil, nil]]
    )
  }

  func testLookupCatchNode() {
    assertLexicalScopeQuery(
      source: """
        1️⃣func foo() throws {
          2️⃣do {
            try 3️⃣f()
            4️⃣try? 5️⃣f()
          } catch {
            throw 6️⃣error
          }
        }

        8️⃣func bar() {
          throw 7️⃣f()
        }
        """,
      methodUnderTest: { argument in
        return [argument.lookupCatchNode()]
      },
      expected: ["3️⃣": ["2️⃣"], "5️⃣": ["4️⃣"], "6️⃣": ["1️⃣"], "7️⃣": ["8️⃣"]]
    )
  }

  func testLookupCatchNodeWithNestedDoCatch() {
    assertLexicalScopeQuery(
      source: """
        1️⃣func foo() rethrows {
          2️⃣do {
            3️⃣do {
              try 4️⃣f()
            } catch {
              try 5️⃣f()
            }
          } catch {
            6️⃣try! 7️⃣f()
            throw 8️⃣f()
          }
        }
        """,
      methodUnderTest: { argument in
        [argument.lookupCatchNode()]
      },
      expected: ["4️⃣": ["3️⃣"], "5️⃣": ["2️⃣"], "7️⃣": ["6️⃣"], "8️⃣": ["1️⃣"]]
    )
  }

  func testCatchBlockLookupFromWithinExpressionList() {
    assertLexicalScopeQuery(
      source: """
        1️⃣do {
          try 2️⃣x + 3️⃣y + 4️⃣z
          5️⃣try! 6️⃣x + 7️⃣y + 8️⃣z
        } catch {
          print(error)
        }
        """,
      methodUnderTest: { argument in
        [argument.lookupCatchNode()]
      },
      expected: ["2️⃣": ["1️⃣"], "3️⃣": ["1️⃣"], "4️⃣": ["1️⃣"], "6️⃣": ["5️⃣"], "7️⃣": ["5️⃣"], "8️⃣": ["5️⃣"]]
    )
  }
}
