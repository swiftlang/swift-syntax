//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftParser
import SwiftSyntax
import XCTest

class EntryTests: ParserTestCase {
  func testTopLevelStringParse() throws {
    let source = "func test() {}"
    let tree = Parser.parse(source: source)
    XCTAssert(!tree.hasError)
    XCTAssertEqual(tree.description, source)
  }

  func testTopLevelBufferParse() throws {
    var source = "func test() {}"
    source.makeContiguousUTF8()
    let tree = source.withUTF8 { Parser.parse(source: $0) }
    XCTAssert(!tree.hasError)
    XCTAssertEqual(tree.description, source)
  }

  func testSyntaxParse() throws {
    assertParse(
      "func test() {}",
      { DeclSyntax.parse(from: &$0) }
    )
  }

  func testDeclSyntaxParseIfConfig() throws {
    assertParse(
      """
      #if FLAG
      func test() {}
      #endif
      """,
      { DeclSyntax.parse(from: &$0) },
      substructure: IfConfigDeclSyntax(
        clauses: IfConfigClauseListSyntax([
          IfConfigClauseSyntax(
            poundKeyword: .poundIfToken(),
            condition: ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier("FLAG"))),
            elements: .init([
              MemberBlockItemSyntax(
                decl: DeclSyntax(
                  FunctionDeclSyntax(
                    funcKeyword: .keyword(.func),
                    name: .identifier("test"),
                    signature: FunctionSignatureSyntax(
                      parameterClause: FunctionParameterClauseSyntax(parameters: [])
                    ),
                    body: CodeBlockSyntax(statements: [])
                  )
                )
              )
            ])
          )
        ])
      )
    )
  }

  func testDeclSyntaxParseIfConfigAttr() throws {
    assertParse(
      """
      #if FLAG
      @attr
      #endif
      func test() {}
      """,
      { DeclSyntax.parse(from: &$0) },
      substructure: FunctionDeclSyntax(
        attributes: [
          .ifConfigDecl(
            IfConfigDeclSyntax(clauses: [
              IfConfigClauseSyntax(
                poundKeyword: .poundIfToken(),
                condition: DeclReferenceExprSyntax(baseName: .identifier("FLAG")),
                elements: .attributes([
                  .attribute(AttributeSyntax(TypeSyntax(IdentifierTypeSyntax(name: .identifier("attr")))))
                ])
              )
            ])
          )
        ],
        funcKeyword: .keyword(.func),
        name: .identifier("test"),
        signature: FunctionSignatureSyntax(
          parameterClause: FunctionParameterClauseSyntax(parameters: [])
        ),
        body: CodeBlockSyntax(statements: [])
      )
    )
  }

  func testRemainderUnexpected() throws {
    assertParse(
      "func test() {} 1️⃣other tokens",
      { DeclSyntax.parse(from: &$0) },
      diagnostics: [DiagnosticSpec(message: "unexpected code 'other tokens' in function")]
    )
  }

  func testRemainderUnexpectedDoesntOverrideExistingUnexpected() throws {
    assertParse(
      "1️⃣operator 2️⃣test 3️⃣{} other tokens",
      { DeclSyntax.parse(from: &$0) },
      substructure: UnexpectedNodesSyntax([
        TokenSyntax.leftBraceToken(),
        PrecedenceGroupAttributeListSyntax([]),
        TokenSyntax.rightBraceToken(),
        TokenSyntax.identifier("other"),
        TokenSyntax.identifier("tokens"),
      ]),
      substructureAfterMarker: "3️⃣",
      diagnostics: [
        DiagnosticSpec(
          locationMarker: "1️⃣",
          message: "operator must be declared as 'prefix', 'postfix', or 'infix'",
          fixIts: ["insert 'prefix'", "insert 'infix'", "insert 'postfix'"]
        ),
        DiagnosticSpec(
          locationMarker: "2️⃣",
          message: "'test' is considered an identifier and must not appear within an operator name"
        ),
        DiagnosticSpec(
          locationMarker: "3️⃣",
          message: "operator should not be declared with body",
          fixIts: ["remove operator body"]
        ),
      ],
      fixedSource: """
        prefix operator test
        """
    )
  }
}
