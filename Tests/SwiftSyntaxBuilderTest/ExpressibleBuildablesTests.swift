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

    let syntax = myStruct.buildSyntax()
    XCTAssertEqual(syntax.description, """
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

    let syntax = myCodeBlock.buildSyntax()
    XCTAssertEqual(syntax.description, """

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
    
    let syntax = myCodeBlock.buildSyntax()
    XCTAssertEqual(syntax.description, """
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

    let syntax = switchStmt.buildSyntax()
    XCTAssertEqual(
      syntax.description,
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
