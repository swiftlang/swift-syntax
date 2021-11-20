import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ExpressibleBuildablesTests: XCTestCase {
  func testExpressibleAsMemberDeclListItem() {
    let myStruct = StructDecl(identifier: "MyStruct", members: MemberDeclBlock(membersBuilder: {
      VariableDecl(.var, name: "myFirstVar", type: "Int")

      // We use `MemberDeclListItem` to ensure and show we can combine it with `ExpressibleAsMemberDeclListItem`
      MemberDeclListItem(decl: VariableDecl(letOrVarKeyword: .let, bindingsBuilder: {
        PatternBinding(pattern: "myOtherLet", typeAnnotation: "String")
      })
      )

      StructDecl(identifier: "InnerStruct", members: MemberDeclBlock())
    })
    )

    let syntax = myStruct.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, """
    struct MyStruct{
        var myFirstVar: Int
        let myOtherLet: String
        struct InnerStruct{
        }
    }
    """)
  }

  func testExpressibleAsCodeBlockItem() {
    let myCodeBlock = SourceFile(eofToken: .eof) {
      StructDecl(identifier: "MyStruct1", members: MemberDeclBlock())

      StructDecl(identifier: "MyStruct2", members: MemberDeclBlock())
    }

    let syntax = myCodeBlock.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, """

    struct MyStruct1{
    }
    struct MyStruct2{
    }
    """)
  }

  func testExpressibleAsSwitchStmt() {
    let versions = [("version_1", "1.0.0"), ("version_2", "2.0.0"), ("version_3", "3.0.0"), ("version_3_1", "3.1.0")]
    let expression = IdentifierExpr("version")

    let switchStmt = SwitchStmt(labelName: nil,
                                expression: expression,
                                leftBrace: .leftBrace.withTrailingTrivia(.newlines(1)),
                                rightBrace: .rightBrace.withLeadingTrivia(.newlines(1)),
                                casesBuilder: {
      for (version, semVer) in versions {
        SwitchCase(label: SwitchCaseLabel(caseItemsBuilder: {
          CaseItem(pattern: EnumCasePattern(caseName: version))
        }), statementsBuilder: {
          ReturnStmt(expression: StringLiteralExpr(semVer, closeQuote: .stringQuote.withTrailingTrivia(.newlines(1))))
        })
      }
    })

    let syntax = switchStmt.buildSyntax(format: Format())

    // The generated code contains whitespace after `:`.
    // So replacing whitespace with `␣`.
    XCTAssertEqual(syntax.description.replacingOccurrences(of: " ", with: "␣"), """
    switch␣version{
    case␣.version_1:␣
    return␣"1.0.0"
    case␣.version_2:␣
    return␣"2.0.0"
    case␣.version_3:␣
    return␣"3.0.0"
    case␣.version_3_1:␣
    return␣"3.1.0"

    }
    """)
  }
}
