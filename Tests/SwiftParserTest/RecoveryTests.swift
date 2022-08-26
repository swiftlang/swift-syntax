import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax) import SwiftParser
import _SwiftSyntaxTestSupport

public class RecoveryTests: XCTestCase {
  func testRecoverOneExtraLabel() throws {
    try XCTAssertHasSubstructure(
      "(first second third: Int)",
      parse: { withParser(source: $0) { Syntax(raw: $0.parseFunctionSignature().raw) } },
      FunctionParameterSyntax(
        attributes: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("third"))]),
        colon: TokenSyntax.colonToken(),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Int"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )
    )
  }

  func testRecoverTwoExtraLabels() throws {
    try XCTAssertHasSubstructure(
      "(first second third fourth: Int)",
      parse: { withParser(source: $0) { Syntax(raw: $0.parseFunctionSignature().raw) } },
      FunctionParameterSyntax(
        attributes: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("third")), Syntax(TokenSyntax.identifier("fourth"))]),
        colon: TokenSyntax.colonToken(),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Int"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )
    )
  }

  func testDontRecoverFromDeclKeyword() {
    var source = """
    (first second third struct: Int)
    """
    let (_, currentToken): (RawFunctionSignatureSyntax, Lexer.Lexeme) =
      source.withUTF8 { buffer in
        var parser = Parser(buffer)
        return (parser.parseFunctionSignature(), parser.currentToken)
      }

    // The 'struct' keyword should be taken as an indicator that a new decl
    // starts here, so `parseFunctionSignature` shouldn't eat it.
    XCTAssertEqual(currentToken.tokenKind, .structKeyword)
  }

  func testRecoverFromParens() throws {
    try XCTAssertHasSubstructure(
      "(first second [third fourth]: Int)",
      parse: { withParser(source: $0) { Syntax(raw: $0.parseFunctionSignature().raw) } },
      FunctionParameterSyntax(
        attributes: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        UnexpectedNodesSyntax([
          Syntax(TokenSyntax.leftSquareBracketToken()),
          Syntax(TokenSyntax.identifier("third")),
          Syntax(TokenSyntax.identifier("fourth")),
          Syntax(TokenSyntax.rightSquareBracketToken())
        ]),
        colon: TokenSyntax.colonToken(),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Int"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )
    )
  }

  func testDontRecoverFromUnbalancedParens() throws {
    let source = """
    (first second [third fourth: Int)
    """
    try withParser(source: source) { parser in
      let signature = Syntax(raw: parser.parseFunctionSignature().raw)
      let currentToken = parser.currentToken
      XCTAssertEqual(currentToken.tokenKind, .identifier)
      XCTAssertEqual(currentToken.tokenText, "fourth")
      try XCTAssertHasSubstructure(
        signature,
        FunctionParameterSyntax(
          attributes: nil,
          firstName: TokenSyntax.identifier("first"),
          secondName: TokenSyntax.identifier("second"),
          colon: TokenSyntax(.colon, presence: .missing),
          type: TypeSyntax(ArrayTypeSyntax(
            leftSquareBracket: TokenSyntax.leftSquareBracketToken(),
            elementType: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("third"), genericArgumentClause: nil)),
            rightSquareBracket: TokenSyntax(.rightSquareBracket, presence: .missing)
          )),
          ellipsis: nil,
          defaultArgument: nil,
          trailingComma: nil
        )
      )
    }
  }

  func testDontRecoverIfNewlineIsBeforeColon() {
    var source = """
    (first second third
    : Int)
    """
    let (_, currentToken): (RawFunctionSignatureSyntax, Lexer.Lexeme) =
      source.withUTF8 { buffer in
        var parser = Parser(buffer)
        return (parser.parseFunctionSignature(), parser.currentToken)
      }

    XCTAssertEqual(currentToken.tokenKind, .colon)
  }

  public func testNoParamsForFunction() throws {
    let source = """
    class MyClass {
      func withoutParameters

      func withParameters() {}
    }
    """

    let classDecl = withParser(source: source) {
      Syntax(raw: $0.parseDeclaration().raw)
    }
    try XCTAssertHasSubstructure(
      classDecl,
      FunctionDeclSyntax(
        attributes: nil,
        modifiers: nil,
        funcKeyword: .funcKeyword(),
        identifier: .identifier("withoutParameters"),
        genericParameterClause: nil,
        signature: FunctionSignatureSyntax(
          input: ParameterClauseSyntax(
            leftParen: .leftParenToken(presence: .missing),
            parameterList: FunctionParameterListSyntax([]),
            rightParen: .rightParenToken(presence: .missing)
          ),
          asyncOrReasyncKeyword: nil,
          throwsOrRethrowsKeyword: nil,
          output: nil
        ),
        genericWhereClause: nil,
        body: nil
      )
    )
  }
}
