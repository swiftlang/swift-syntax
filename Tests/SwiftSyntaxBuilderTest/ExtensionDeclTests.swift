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

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ExtensionDeclTests: XCTestCase {
  func testExtensionDecl() {
    let keywords = ["associatedtype", "class"].map { keyword -> VariableDeclSyntax in
      // We need to use `CodeBlock` here to ensure there is braces around.
      let body = CodeBlockSyntax {
        FunctionCallExprSyntax(callee: ExprSyntax("TokenSyntax.\(raw: keyword)Keyword"))
      }

      return VariableDeclSyntax(
        modifiers: [DeclModifierSyntax(name: .keyword(.public))],
        bindingKeyword: .keyword(.var)
      ) {
        PatternBindingSyntax(
          pattern: PatternSyntax("`\(raw: keyword)`"),
          typeAnnotation: TypeAnnotationSyntax(type: TypeSyntax("TokenSyntax")),
          accessor: .getter(body)
        )

      }
    }
    let members = MemberDeclListSyntax(keywords.map { MemberDeclListItemSyntax(decl: $0) })
    let buildable = ExtensionDeclSyntax(
      extendedType: TypeSyntax("TokenSyntax"),
      memberBlock: MemberDeclBlockSyntax(members: members)
    )

    assertBuildResult(
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
