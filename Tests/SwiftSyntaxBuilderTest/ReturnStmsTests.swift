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
import SwiftSyntax
import SwiftSyntaxBuilder

final class ReturnStmtTests: XCTestCase {

  func testReturnStmt() {
    let buildable = ReturnStmt("return Self.parse(from: &parser)")

    AssertBuildResult(
      buildable,
      """
      return Self.parse(from: &parser)
      """
    )
  }

  func testReturnStmtwithAsKeyword() {
    let testCases: [UInt: (ReturnStmt, String)] = [
      #line: (
        ReturnStmt("return self.asProtocol(SyntaxProtocol.self) as? DeclSyntaxProtocol"),
        "return self.asProtocol(SyntaxProtocol.self) as? DeclSyntaxProtocol"
      ),
      #line: (
        ReturnStmt("return 0 as! String"),
        "return 0 as! String"
      ),
      #line: (
        ReturnStmt("return 0 as Double"),
        "return 0 as Double"
      ),
      #line: (
        ReturnStmt("return !myBool"),
        "return !myBool"
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      AssertBuildResult(builder, expected, line: line)
    }
  }
}
