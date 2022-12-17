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
        FunctionCallExpr(callee: MemberAccessExpr(base: "TokenSyntax", name: "\(keyword)Keyword"))
      }

      return VariableDecl(
        modifiers: [DeclModifier(name: .public)],
        letOrVarKeyword: .var
      ) {
        PatternBinding(
          pattern: PatternSyntax("`\(raw: keyword)`"),
          typeAnnotation: TypeAnnotation(type: Type("TokenSyntax")),
          accessor: .getter(body)
        )

      }
    }
    let members = MemberDeclList(keywords.map { MemberDeclListItem(decl: $0) })
    let buildable = ExtensionDecl(
      extendedType: Type("TokenSyntax"),
      members: MemberDeclBlock(members: members)
    )

    AssertBuildResult(
      buildable,
      """
      extension TokenSyntax {
          public var `associatedtype`: TokenSyntax {
              TokenSyntax.associatedtypeKeyword()
          }
          public var `class`: TokenSyntax {
              TokenSyntax.classKeyword()
          }
      }
      """
    )
  }
}
