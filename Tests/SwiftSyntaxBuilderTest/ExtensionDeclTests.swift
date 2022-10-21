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

final class ExtensionDeclTests: XCTestCase {
  func testExtensionDecl() {
    let keywords = ["associatedtype", "class"].map { keyword -> VariableDecl in
      // We need to use `CodeBlock` here to ensure there is braces around.
      let body = CodeBlock {
        FunctionCallExpr(calledExpression: "TokenSyntax.\(keyword)Keyword")
      }

      return VariableDecl(
        modifiers: [Token.public],
        letOrVarKeyword: .var
      ) {
        PatternBinding(pattern: "`\(keyword)`",
                       typeAnnotation: "TokenSyntax",
                       initializer: nil,
                       accessor: body)

      }
    }
    let members = MemberDeclList(keywords)
    let buildable = ExtensionDecl(modifiers: nil,
                                  extendedType: "TokenSyntax",
                                  members: members)

    AssertBuildResult(buildable, """
    extension TokenSyntax {
        public var `associatedtype`: TokenSyntax {
            TokenSyntax.associatedtypeKeyword()
        }
        public var `class`: TokenSyntax {
            TokenSyntax.classKeyword()
        }
    }
    """)
  }
}
