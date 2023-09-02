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

final class ReturnStmtTests: XCTestCase {
  func testReturnStmt() {
    let testCases: [UInt: (StmtSyntax, String)] = [
      #line: (
        StmtSyntax("return Self.parse(from: &parser)"),
        "return Self.parse(from: &parser)"
      ),
      #line: (
        StmtSyntax("return self.asProtocol(SyntaxProtocol.self) as? DeclSyntaxProtocol"),
        "return self.asProtocol(SyntaxProtocol.self) as? DeclSyntaxProtocol"
      ),
      #line: (
        StmtSyntax("return 0 as! String"),
        "return 0 as! String"
      ),
      #line: (
        StmtSyntax("return 0 as Double"),
        "return 0 as Double"
      ),
      #line: (
        StmtSyntax("return !myBool"),
        "return !myBool"
      ),
      #line: (
        StmtSyntax("return data.child(at: 2, parent: Syntax(self)).map(UnexpectedNodesSyntax.init)"),
        "return data.child(at: 2, parent: Syntax(self)).map(UnexpectedNodesSyntax.init)"
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }
}
