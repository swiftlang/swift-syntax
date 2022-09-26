import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ProtocolDeclTests: XCTestCase {
  func testProtocolDecl() {
    let returnType = ArrayType(elementType: "DeclSyntax")
    let input = ParameterClause {
      FunctionParameter(firstName: .identifier("format"), colon: .colon, type: "Format")
      FunctionParameter(firstName: .identifier("leadingTrivia"), colon: .colon, type: OptionalType(wrappedType: "Trivia"))
    }
    let functionSignature = FunctionSignature(input: input, output: returnType)

    let buildable = ProtocolDecl(modifiers: [Token.public], identifier: "DeclListBuildable") {
      FunctionDecl(identifier: .identifier("buildDeclList"), signature: functionSignature, body: nil)
    }

    let syntax = buildable.buildSyntax()

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    public protocol DeclListBuildable {
        func buildDeclList(format: Format, leadingTrivia: Trivia?) -> [DeclSyntax]
    }
    """)
  }
}
