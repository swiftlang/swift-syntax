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

final class EnumCaseElementTests: XCTestCase {
  func testEnumInit() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let buildable = EnumDecl(
      leadingTrivia: leadingTrivia,
      identifier: "Greeting",
      inheritanceClause: TypeInheritanceClause {
        InheritedType(typeName: Type("String"))
        InheritedType(typeName: Type("Codable"))
        InheritedType(typeName: Type("Equatable"))
      }
    ) {
      MemberDeclListItem(
        decl: EnumCaseDecl {
          EnumCaseElement(
            identifier: "goodMorning",
            rawValue: InitializerClause(value: StringLiteralExpr(content: "Good Morning"))
          )
          EnumCaseElement(
            identifier: "helloWorld",
            rawValue: InitializerClause(value: StringLiteralExpr(content: "Hello World"))
          )
          EnumCaseElement(identifier: "hi")
        }
      )
    }

    AssertBuildResult(
      buildable,
      """
      ␣enum Greeting: String, Codable, Equatable {
          case goodMorning = "Good Morning", helloWorld = "Hello World", hi
      }
      """
    )
  }
}
