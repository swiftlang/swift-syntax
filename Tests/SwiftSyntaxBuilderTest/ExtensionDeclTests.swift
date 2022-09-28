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

    let syntax = buildable.buildSyntax()

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
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
