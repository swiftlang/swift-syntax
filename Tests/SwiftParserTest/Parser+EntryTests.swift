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

  /// The parser lexes directly over the source buffer, which is not
  /// null-terminated, so EOF-adjacent lexing must never read past the buffer's
  /// end. These inputs exercise the code paths most likely to over-read at EOF;
  /// each must round-trip exactly.
  ///
  /// Each case is copied into an exactly-sized allocation so that, under
  /// AddressSanitizer, any read past the last byte is caught (an `Array`'s or
  /// `String`'s storage may have trailing slack that would mask such a read).
  func testParseBufferEOFEdgeCases() throws {
    func assertRoundTrips(_ bytes: [UInt8], file: StaticString = #filePath, line: UInt = #line) {
      let buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: bytes.count)
      defer { buffer.deallocate() }
      _ = buffer.initialize(from: bytes)
      let tree = Parser.parse(source: UnsafeBufferPointer(buffer))
      XCTAssertEqual(
        tree.syntaxTextBytes,
        bytes,
        "parsed tree did not round-trip for input \(bytes)",
        file: file,
        line: line
      )
    }

    assertRoundTrips(Array("".utf8))  // empty input
    assertRoundTrips(Array("x".utf8))  // single character
    assertRoundTrips(Array("let a = b +".utf8))  // trailing operator, no newline
    assertRoundTrips(Array("a /".utf8))  // slash at EOF (comment lookahead)
    assertRoundTrips(Array("/* unterminated".utf8))  // unterminated block comment at EOF
    assertRoundTrips(Array("\"unterminated".utf8))  // unterminated string at EOF
    assertRoundTrips(Array("1.".utf8))  // number needing lookahead at EOF
    assertRoundTrips(Array("foo".utf8) + [0xE2, 0x80])  // truncated 3-byte UTF-8 at EOF
    assertRoundTrips(Array("bar".utf8) + [0xF0])  // lone UTF-8 lead byte at EOF
    assertRoundTrips(Array("#if X".utf8))  // directive at EOF
    assertRoundTrips(Array("a".utf8) + [0x00] + Array("b".utf8))  // embedded NUL
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
