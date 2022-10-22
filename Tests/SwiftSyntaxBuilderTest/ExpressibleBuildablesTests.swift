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

final class ExpressibleBuildablesTests: XCTestCase {
  func testExpressibleAsMemberDeclListItem() {
    let myStruct = StructDecl(identifier: "MyStruct") {
      VariableDecl(.var, name: "myFirstVar", type: "Int")

      // We use `MemberDeclListItem` to ensure and show we can combine it with `ExpressibleAsMemberDeclListItem`
      MemberDeclListItem(decl: VariableDecl(letOrVarKeyword: .let) {
        PatternBinding(pattern: "myOtherLet", typeAnnotation: "String")
      })

      StructDecl(identifier: "InnerStruct") {}
    }

    AssertBuildResult(myStruct, """
    struct MyStruct {
        var myFirstVar: Int
        let myOtherLet: String
        struct InnerStruct {
        }
    }
    """)
  }

  func testDeclExpressibleAsCodeBlockItem() {
    let myCodeBlock = SourceFile(eofToken: .eof) {
      StructDecl(identifier: "MyStruct1") {}

      StructDecl(identifier: "MyStruct2") {}
    }

    AssertBuildResult(myCodeBlock, """

    struct MyStruct1 {
    }
    struct MyStruct2 {
    }
    """)
  }

  func testExprExpressibleAsCodeBlockItem() {
    let myCodeBlock = CodeBlock(leftBrace: .leftBrace.withLeadingTrivia([])) {
      FunctionCallExpr(calledExpression: "print") { TupleExprElement(expression: StringLiteralExpr("Hello world")) }
      IntegerLiteralExpr(42)
      "someIdentifier"
    }
    
    AssertBuildResult(myCodeBlock, """
     {
        print("Hello world")
        42
        someIdentifier
    }
    """)
  }

  func testExpressibleAsSwitchStmt() {
    let versions = [("version_1", "1.0.0"), ("version_2", "2.0.0"), ("version_3", "3.0.0"), ("version_3_1", "3.1.0")]
    let expression = IdentifierExpr("version")

    let switchStmt = SwitchStmt(
      expression: expression
    ) {
      for (version, semVer) in versions {
        SwitchCase(label: SwitchCaseLabel(caseItems: [
          CaseItem(pattern: EnumCasePattern(caseName: version))
        ])) {
          ReturnStmt(expression: StringLiteralExpr(semVer))
        }
      }
    }

    AssertBuildResult(
      switchStmt,
      """
      switch version {
      case .version_1: 
          return "1.0.0"
      case .version_2: 
          return "2.0.0"
      case .version_3: 
          return "3.0.0"
      case .version_3_1: 
          return "3.1.0"
      }
      """)
  }
}
