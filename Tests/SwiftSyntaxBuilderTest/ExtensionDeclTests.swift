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

final class ExtensionDeclTests: XCTestCase {
  func testExtensionDecl() {
    let keywords = ["associatedtype", "class"].map { keyword -> VariableDeclSyntax in
      // We need to use `CodeBlock` here to ensure there is braces around.
      let body = CodeBlockItemListSyntax {
        FunctionCallExprSyntax(callee: ExprSyntax("TokenSyntax.\(raw: keyword)Keyword"))
      }

      return VariableDeclSyntax(
        modifiers: [DeclModifierSyntax(name: .keyword(.public))],
        bindingSpecifier: .keyword(.var)
      ) {
        PatternBindingSyntax(
          pattern: PatternSyntax("`\(raw: keyword)`"),
          typeAnnotation: TypeAnnotationSyntax(type: TypeSyntax("TokenSyntax")),
          accessorBlock: AccessorBlockSyntax(accessors: .getter(body))
        )

      }
    }
    let members = MemberBlockItemListSyntax(keywords.map { MemberBlockItemSyntax(decl: $0) })
    let buildable = ExtensionDeclSyntax(
      extendedType: TypeSyntax("TokenSyntax"),
      memberBlock: MemberBlockSyntax(members: members)
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
