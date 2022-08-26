import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax) import SwiftParser
import _SwiftSyntaxTestSupport

public class RecoveryTests: XCTestCase {
  func testTopLevelCaseRecovery() {
    AssertParse(
      "/*#-editable-code Swift Platground editable area*/default/*#-end-editable-code*/"
    )

    AssertParse("case:")

    AssertParse(
      #"""
      case: { ("Hello World") }
      """#
    )
  }

  func testBogusKeypathBaseRecovery() {
    AssertParse(
      #"""
      func nestThoseIfs() {\n    if false != true {\n       print "\(i)\"\n#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"' in expression"#),
        DiagnosticSpec(message: "Expected '}'"),
        DiagnosticSpec(message: "Expected '}'"),
      ]
    )
  }

  func testExtraneousRightBraceRecovery() {
    AssertParse("class ABC { let def = ghi(jkl: mno) } }")
  }

  func testMissingIfClauseIntroducer() {
    AssertParse("if _ = 42 {}")
  }

  func testMissingSubscriptReturnClause() {
    AssertParse(
      """
      struct Foo {
        subscript(x: String) #^DIAG^#{}
      }
      """,
      diagnostics: [
        DiagnosticSpec(message: "Expected '->'")
      ]
    )
  }

  func testSingleQuoteStringLiteral() {
    AssertParse(
      #"""
      'red'
      """#
    )
  }

  func testClassWithLeadingNumber() {
    AssertParse(
      """
      class #^DIAG^#23class {
        // expected-error@-1 {{class name can only start with a letter or underscore, not a number}}
        // expected-error@-2 {{'c' is not a valid digit in integer literal}}
        func 24method() {}
        // expected-error@-1 {{function name can only start with a letter or underscore, not a number}}
        // expected-error@-2 {{'m' is not a valid digit in integer literal}}
      }
      """,
      // FIXME: These are simply bad diagnostics. We should be complaining that identifiers cannot start with digits.
      diagnostics: [
        DiagnosticSpec(message: "Expected '' in declaration"),
        DiagnosticSpec(message: "Expected '{'"),
        DiagnosticSpec(message: "Expected '}'"),
      ]
    )
  }

  func testAttributesOnStatements() {
    AssertParse(
      """
      func test1() {
        @s return
      }
      func test2() {
        @unknown return
      }
      """
    )
  }

  func testMissingArrowInArrowExpr() {
    AssertParse(
      "[(Int) -> #^DIAG^#throws Int]()",
      diagnostics: [
        // FIXME: We should suggest to move 'throws' in front of '->'
        DiagnosticSpec(message: "Unexpected text 'throws Int' found in expression")
      ]
    )

    AssertParse(
      "let _ = [Int throws #^DIAG^#Int]()",
      diagnostics: [
        DiagnosticSpec(message: "Expected '->' in expression")
      ]
    )
  }

  func testBogusSwitchStatement() {
    AssertParse(
      """
      switch x {
        print()
      #if true
        print()
      #endif
        case .A, .B:
          break
      }
      """
    )
    
    AssertParse(
      """
      switch x {
      print()
      #if ENABLE_C
      case .NOT_EXIST:
        break
      case .C:
        break
      #endif
      case .A, .B:
        break
      }
      """
    )
  }

  func testBogusLineLabel() {
    AssertParse(
      """
      LABEL:
      """
    )
  }

  func testStringBogusClosingDelimiters() {
    AssertParse(
      #"\\(#^DIAG^#"#,
      diagnostics: [
        DiagnosticSpec(message: "Expected ')' to end expression")
      ]
    )

    AssertParse(
      ##"""
      #"\\("#
      """##
    )

    AssertParse(
      #"""
      "#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"' in expression"#)
      ]
    )

    AssertParse(
      #"""
      "'#^DIAG^#
      """#,
      diagnostics: [
        DiagnosticSpec(message: #"Expected '"' in expression"#)
      ]
    )
  }

  func testMissingArgumentToAttribute() {
    AssertParse(
      """
      @_dynamicReplacement(#^DIAG_1^#
      func #^DIAG_2^#test_dynamic_replacement_for2() {
      }
      """,
      diagnostics: [
        // FIXME: We should be complaining about the missing ')' for the attribute
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Expected 'for'"),
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Expected ':'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected ')'"),
      ]
    )
  }

  func testBogusThrowingTernary() {
    AssertParse(
      """
      do {
        true ? () : throw opaque_error()
      } catch _ {
      }
      """
    )
  }

  func testAccessors() {
    AssertParse(
      """
      var bad1 : Int {
        _read async { 0 }
      }
      """
    )

    AssertParse(
      """
      var bad2 : Int {
        get reasync { 0 }
      }
      """
    )
  }

  func testExpressionMember() {
    AssertParse(
      """
      struct S {
        #^DIAG^#/ ###line 25 "line-directive.swift"
      }
      """,
      diagnostics: [
        // FIXME: The diagnostic should not contain a newline.
        DiagnosticSpec(
          message: """
            Unexpected text '
              / ###line 25 "line-directive.swift"'
            """
        )
      ]
    )
  }

  func testBogusProtocolRequirements() {
    AssertParse(
      """
      protocol P {
        var prop : Int { get bogus rethrows set }
      }
      """
    )
  }

  func testExtraSyntaxInDirective() {
    AssertParse(
      """
      #if os(iOS)
        func foo() {}
      } // expected-error{{unexpected '}' in conditional compilation block}}
      #else
        func bar() {}
        func baz() {}
      } // expected-error{{unexpected '}' in conditional compilation block}}
      #endif
      """
    )
  }

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

  func testTextRecovery() {
    AssertParse(
      """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do #^DIAG_1^#eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.#^DIAG_2^#
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "DIAG_1", message: "Expected '{'"),
        DiagnosticSpec(locationMarker: "DIAG_2", message: "Expected '}'"),
      ]
    )
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
