import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax) import SwiftParser
import _SwiftSyntaxTestSupport

public class RecoveryTests: XCTestCase {
  func testRecoverOneExtraLabel() {
    AssertParse(
      "(first second #^DIAG^#third: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("third"))]),
        colon: TokenSyntax.colonToken(),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Int"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text 'third' found in function parameter")
      ]
    )
  }

  func testRecoverTwoExtraLabels() {
    AssertParse(
      "(first second #^DIAG^#third fourth: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("third")), Syntax(TokenSyntax.identifier("fourth"))]),
        colon: TokenSyntax.colonToken(),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("Int"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text 'third fourth' found in function parameter")
      ]
    )
  }

  func testDontRecoverFromDeclKeyword() {
    AssertParse(
      "func foo(first second #^MISSING_COLON^#third #^MISSING_RPAREN^#struct#^MISSING_IDENTIFIER^##^BRACES^#: Int) {}",
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        firstName: .identifier("first"),
        secondName: .identifier("second"),
        colon: .colonToken(presence: .missing),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: .identifier("third"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(locationMarker: "MISSING_COLON", message: "Expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "MISSING_RPAREN", message: "Expected ')' to end parameter clause"),
        // FIXME: We should issues something like "Expected identifier in declaration"
        DiagnosticSpec(locationMarker: "MISSING_IDENTIFIER", message: "Expected '' in declaration"),
        DiagnosticSpec(locationMarker: "BRACES", message: "Expected '{'"),
        DiagnosticSpec(locationMarker: "BRACES", message: "Expected '}'"),
      ]
    )
  }

  func testRecoverFromParens() {
    AssertParse(
      "(first second #^DIAG^#[third fourth]: Int)",
      { $0.parseFunctionSignature() },
      substructure: Syntax(FunctionParameterSyntax(
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
      )),
      diagnostics: [
        DiagnosticSpec(message: "Unexpected text '[third fourth]' found in function parameter")
      ]
    )
  }

  func testDontRecoverFromUnbalancedParens() {
    AssertParse(
      "func foo(first second #^COLON^#[third #^RSQUARE_COLON^#fourth: Int) {}",
      substructure: Syntax(FunctionParameterSyntax(
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
      )),
      diagnostics: [
        DiagnosticSpec(locationMarker: "COLON", message: "Expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "RSQUARE_COLON" , message: "Expected ']' to end type"),
        DiagnosticSpec(locationMarker: "RSQUARE_COLON", message: "Expected ')' to end parameter clause"),
      ]
    )
  }

  func testDontRecoverIfNewlineIsBeforeColon() {
    AssertParse(
      """
      func foo(first second #^COLON^#third#^RPAREN^#
      : Int) {}
      """,
      substructure: Syntax(FunctionParameterSyntax(
        attributes: nil,
        firstName: TokenSyntax.identifier("first"),
        secondName: TokenSyntax.identifier("second"),
        colon: TokenSyntax(.colon, presence: .missing),
        type: TypeSyntax(SimpleTypeIdentifierSyntax(name: TokenSyntax.identifier("third"), genericArgumentClause: nil)),
        ellipsis: nil,
        defaultArgument: nil,
        trailingComma: nil
      )),
      diagnostics: [
        DiagnosticSpec(locationMarker: "COLON", message: "Expected ':' in function parameter"),
        DiagnosticSpec(locationMarker: "RPAREN", message: "Expected ')' to end parameter clause"),
      ]
    )
  }

  public func testNoParamsForFunction() {
    AssertParse(
      """
      class MyClass {
        func withoutParameters#^DIAG^#

        func withParameters() {}
      }
      """,
      substructure: Syntax(FunctionDeclSyntax(
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
      )),
      diagnostics: [
        DiagnosticSpec(message: "Expected argument list in function declaration")
      ]
    )
  }
}
