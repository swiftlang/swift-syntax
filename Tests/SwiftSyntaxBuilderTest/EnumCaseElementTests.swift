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

final class EnumCaseElementTests: XCTestCase {
  func testEnumInit() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let buildable = EnumDeclSyntax(
      leadingTrivia: leadingTrivia,
      identifier: "Greeting",
      inheritanceClause: TypeInheritanceClauseSyntax {
        InheritedTypeSyntax(typeName: TypeSyntax("String"))
        InheritedTypeSyntax(typeName: TypeSyntax("Codable"))
        InheritedTypeSyntax(typeName: TypeSyntax("Equatable"))
      }
    ) {
      MemberDeclListItemSyntax(
        decl: EnumCaseDeclSyntax {
          EnumCaseElementSyntax(
            identifier: "goodMorning",
            rawValue: InitializerClauseSyntax(value: StringLiteralExprSyntax(content: "Good Morning"))
          )
          EnumCaseElementSyntax(
            identifier: "helloWorld",
            rawValue: InitializerClauseSyntax(value: StringLiteralExprSyntax(content: "Hello World"))
          )
          EnumCaseElementSyntax(identifier: "hi")
        }
      )
    }

    assertBuildResult(
      buildable,
      """
      ␣enum Greeting: String, Codable, Equatable {
          case goodMorning = "Good Morning", helloWorld = "Hello World", hi
      }
      """
    )
  }
}
