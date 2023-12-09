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

import SwiftOperators
import SwiftSyntax
import XCTest

public class SyntaxSynthesisTests: XCTestCase {
  func testInfixOperator() {
    let plus = Operator(
      kind: .infix,
      name: "+",
      precedenceGroup: "AdditivePrecedence"
    )
    let plusSyntax = plus.synthesizedSyntax()
    XCTAssertEqual(
      plusSyntax.description,
      "infix operator +: AdditivePrecedence"
    )
  }

  func testPrecedenceGroup() {
    let group = PrecedenceGroup(
      name: "MyGroup",
      associativity: .right,
      assignment: true,
      relations: [.lowerThan("BetterGroup"), .higherThan("WorseGroup")]
    )
    let groupSyntax = group.synthesizedSyntax()
    XCTAssertEqual(
      groupSyntax.description,
      """
      precedencegroup MyGroup {
          associativity: right
          assignment: true
          lowerThan: BetterGroup
          higherThan: WorseGroup
      }
      """
    )
  }

  func testLogicalOperatorTable() {
    let table = OperatorTable.logicalOperators
    XCTAssertEqual(
      table.description,
      """
      precedencegroup LogicalConjunctionPrecedence {
          associativity: left
          higherThan: LogicalDisjunctionPrecedence
      }
      precedencegroup LogicalDisjunctionPrecedence {
          associativity: left
      }
      prefix operator !
      infix operator &&: LogicalConjunctionPrecedence
      infix operator ||: LogicalDisjunctionPrecedence

      """
    )
  }
}
