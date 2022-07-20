import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ProtocolDeclTests: XCTestCase {
  func testProtocolDecl() {
    let returnType = ArrayType(elementType: "DeclSyntax")
    let input = ParameterClause {
      FunctionParameter(firstName: "format", colon: .colon, type: "Format")
      FunctionParameter(firstName: "leadingTrivia", colon: .colon, type: OptionalType(wrappedType: "Trivia"))
    }
    let functionSignature = FunctionSignature(input: input, output: returnType)

    let buildable = ProtocolDecl(modifiers: [TokenSyntax.public], identifier: "DeclListBuildable") {
      FunctionDecl(identifier: "buildDeclList", signature: functionSignature, body: nil)
    }

    let syntax = buildable.buildSyntax(format: Format())

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    public protocol DeclListBuildable {
        func buildDeclList(format: Format, leadingTrivia: Trivia?)-> [DeclSyntax]
    }
    """)
  }
}
