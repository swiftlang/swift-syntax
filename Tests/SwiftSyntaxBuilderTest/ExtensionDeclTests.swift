import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ExtensionDeclTests: XCTestCase {
  func testExtensionDecl() {
    let keywords = ["associatedtype", "class"].map { keyword -> VariableDecl in
      // We need to use `CodeBlock` here to ensure there is braces around.
      let body = CodeBlock {
        FunctionCallExpr("SyntaxFactory.make\(keyword)Keyword",
                         leftParen: .leftParen,
                         rightParen: .rightParen)
      }

      return VariableDecl(letOrVarKeyword: .var,
                          modifiersBuilder: { TokenSyntax.public },
                          bindingsBuilder: {
        PatternBinding(pattern: "`\(keyword)`",
                       typeAnnotation: "TokenSyntax",
                       initializer: nil,
                       accessor: body)

      })
    }
    let members = MemberDeclList(keywords)
    let buildable = ExtensionDecl(modifiers: nil,
                                  extendedType: "TokenSyntax",
                                  members: members)

    let syntax = buildable.buildSyntax(format: Format())

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    extension TokenSyntax{
        public var `associatedtype`: TokenSyntax{
            SyntaxFactory.makeassociatedtypeKeyword()
        }
        public var `class`: TokenSyntax{
            SyntaxFactory.makeclassKeyword()
        }
    }
    """)
  }
}
