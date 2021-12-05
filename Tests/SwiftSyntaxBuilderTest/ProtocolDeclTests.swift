import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ProtocolDeclTests: XCTestCase {
  func testProtocolDecl() {
    let returnType = ArrayType(elementType: "DeclSyntax")
    let input = ParameterClause(parameterListBuilder: {
      FunctionParameter(firstName: .identifier("format"), colon: .colon, type: "Format", trailingComma: .comma, attributesBuilder: {})
      FunctionParameter(firstName: .identifier("leadingTrivia"), colon: .colon, type: OptionalType(wrappedType: "Trivia"), attributesBuilder: {})
    })
    let functionSignature = FunctionSignature(input: input, output: returnType)

    // FIXME: We need to add the `modifiersBuilder` with a non-empty value, otherwise will the builder omit newline.
    let functionDecl = FunctionDecl(identifier: .identifier("buildDeclList"), signature: functionSignature, modifiersBuilder: { TokenSyntax.public })
    let buildable = ProtocolDecl(modifiers: TokenSyntax.public, identifier: .identifier("DeclListBuildable"), members: functionDecl)

    let syntax = buildable.buildSyntax(format: Format())

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    public protocol DeclListBuildable{
        public func buildDeclList(format: Format, leadingTrivia: Trivia?)-> [DeclSyntax]
    }
    """)
  }
}
