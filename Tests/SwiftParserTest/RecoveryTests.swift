import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax) import SwiftParser
import _SwiftSyntaxTestSupport

public class RecoveryTests: XCTestCase {
  func testTopLevelCaseRecovery() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      "/*#-editable-code Swift Platground editable area*/default/*#-end-editable-code*/"
    }

    try AssertParse({ $0.parseSourceFile() }) {
      "case:"
    }

    try AssertParse({ $0.parseSourceFile() }) {
      #"case: { ("Hello World") }"#
    }
  }

  func testBogusKeypathBaseRecovery() throws {
    try AssertParse({ $0.parseSourceFile() }, allowErrors: true) {
      #"func nestThoseIfs() {\n    if false != true {\n       print "\(i)\"\n"#
    }
  }

  func testExtraneousRightBraceRecovery() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      "class ABC { let def = ghi(jkl: mno) } }"
    }
  }

  func testMissingIfClauseIntroducer() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      "if _ = 42 {}"
    }
  }

  func testMissingSubscriptReturnClause() throws {
    try AssertParse({ $0.parseSourceFile() }, allowErrors: true) {
      """
      struct Foo {
        subscript(x: String) {}
      }
      """
    }
  }

  func testSingleQuoteStringLiteral() throws {
    try AssertParse({ $0.parseExpression() }) {
      #"""
      'red'
      """#
    }
  }

  func testClassWithLeadingNumber() throws {
    try AssertParse({ $0.parseSourceFile() }, allowErrors: true) {
      """
      class 23class {
        // expected-error@-1 {{class name can only start with a letter or underscore, not a number}}
        // expected-error@-2 {{'c' is not a valid digit in integer literal}}
        func 24method() {}
        // expected-error@-1 {{function name can only start with a letter or underscore, not a number}}
        // expected-error@-2 {{'m' is not a valid digit in integer literal}}
      }
      """
    }
  }

  func testAttributesOnStatements() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      """
      func test1() {
        @s return
      }
      func test2() {
        @unknown return
      }
      """
    }
  }

  func testMissingArrowInArrowExpr() throws {
    try AssertParse({ $0.parseSourceFile() }, allowErrors: true) {
      """
      [(Int) -> throws Int]()
      let _ = [Int throws Int]()
      """
    }
  }

  func testBogusSwitchStatement() throws {
    try AssertParse({ $0.parseStatement() }) {
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
    }
    
    try AssertParse({ $0.parseStatement() }) {
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
    }
  }

  func testBogusLineLabel() throws {
    try AssertParse({ $0.parseSourceFile() }) {
      """
      LABEL:
      """
    }
  }

  func testStringBogusClosingDelimiters() throws {
    try AssertParse({ $0.parseSourceFile() }, allowErrors: true) {
      #"\\("#
    }

    try AssertParse({ $0.parseExpression() }) {
      ##"""
      #"\\("#
      """##
    }

    try AssertParse({ $0.parseStringLiteral() }, allowErrors: true) {
      #"""
      "
      """#
    }

    try AssertParse({ $0.parseStringLiteral() }, allowErrors: true) {
      #"""
      "'
      """#
    }
  }

  func testMissingArgumentToAttribute() throws {
    try AssertParse({ $0.parseSourceFile() }, allowErrors: true) {
      """
      @_dynamicReplacement(
      func test_dynamic_replacement_for2() {
      }
      """
    }
  }

  func testBogusThrowingTernary() throws {
    try AssertParse({ $0.parseStatement() }) {
      """
      do {
        true ? () : throw opaque_error()
      } catch _ {
      }
      """
    }
  }

  func testAccessors() throws {
    try AssertParse({ $0.parseDeclaration() }) {
      """
      var bad1 : Int {
        _read async { 0 }
      }
      """
    }

    try AssertParse({ $0.parseDeclaration() }) {
      """
      var bad2 : Int {
        get reasync { 0 }
      }
      """
    }
  }

  func testExpressionMember() throws {
    try AssertParse({ $0.parseSourceFile() }, allowErrors: true) {
      """
      struct S {
        / ###line 25 "line-directive.swift"
      }
      """
    }
  }

  func testBogusProtocolRequirements() throws {
    try AssertParse({ $0.parseDeclaration() }) {
      """
      protocol P {
        var prop : Int { get bogus rethrows set }
      }
      """
    }
  }

  func testExtraSyntaxInDirective() throws {
    try AssertParse({ $0.parseDeclaration() }, allowErrors: true) {
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
    }
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

  func testDontRecoverFromDeclKeyword() throws {
    var source = """
    (first second third struct: Int)
    """
    let (_, currentToken) = source.withUTF8 { buffer in
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

  func testDontRecoverIfNewlineIsBeforeColon() throws {
    var source = """
    (first second third
    : Int)
    """
    let (_, currentToken) = source.withUTF8 { buffer in
      var parser = Parser(buffer)
      return (parser.parseFunctionSignature(), parser.currentToken)
    }

    XCTAssertEqual(currentToken.tokenKind, .colon)
  }

  func testTextRecovery() throws {
    try AssertParse({ $0.parseSourceFile() }, allowErrors: true) {
      """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      """
    }
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
