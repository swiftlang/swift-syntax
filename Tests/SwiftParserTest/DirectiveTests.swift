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

@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class DirectiveTests: ParserTestCase {
  func testSwitchIfConfig() {
    assertParse(
      """
      switch x {
      case 1: fallthrough
      #if FOO
      case 2: fallthrough
      case 3: print(3)
      case 4: print(4)
      #endif
      case 5: fallthrough
      case 6: print(6)
      #if BAR
      #if BAZ
      case 7: print(7)
      case 8: fallthrough
      #endif
      case 9: fallthrough
      #endif
      case 10: print(10)
      }
      """
    )
  }

  func testPostfixIfConfigExpression() {
    assertParse(
      """
      foo
        .bar()
        .baz()
        #if CONFIG1
        .quux
        .garp
        #if CONFIG2
        .quux
        #if CONFIG3
          #if INNER1
           .quux
           .garp
          #endif
        #elseif CONFIG3
        .quux
        .garp
        #else
        .gorp
        #endif
        .garp
        #endif
        #endif
      """
    )
  }

  func testPostfixIfConfigExpressionContainsPoundIf() {
    assertParse(
      """
      b
      #if true
      .a
      1️⃣#if true
      #endif
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(message: "unexpected code in conditional compilation block")
      ]
    )
  }

  func testSourceLocation() {
    assertParse(
      """
      #sourceLocation()
      """
    )

    assertParse(
      """
      #sourceLocation(file: "foo", line: 42)
      """
    )

    assertParse(
      """
      public class C<R> {

      #sourceLocation(file: "f.swift", line: 1)
        public func f<S>(_ s: S) {

      #sourceLocation(file: "f.swift", line: 2)
          g(s)
        }
      }
      """
    )

    assertParse(
      """
      #sourceLocation(file: "f.swift", line: 1️⃣-1)
      """,
      diagnostics: [
        DiagnosticSpec(message: "expected line number in '#sourceLocation' arguments", fixIts: ["insert line number"]),
        DiagnosticSpec(message: "unexpected code '-1' in '#sourceLocation' directive"),
      ],
      fixedSource: """
        #sourceLocation(file: "f.swift", line: <#integer literal#>-1)
        """
    )
  }

  public func testUnterminatedPoundIf() {
    assertParse(
      "#if test1️⃣",
      diagnostics: [
        DiagnosticSpec(message: "expected '#endif' in conditional compilation block", fixIts: ["insert '#endif'"])
      ],
      fixedSource: """
        #if test
        #endif
        """
    )
  }

  func testExtraSyntaxInDirective() {
    assertParse(
      """
      #if os(iOS)
        func foo() {}
      1️⃣}
      #else
        func baz() {}
      2️⃣}
      #endif
      """,
      diagnostics: [
        DiagnosticSpec(locationMarker: "1️⃣", message: "unexpected brace before conditional compilation clause"),
        DiagnosticSpec(locationMarker: "2️⃣", message: "unexpected brace in conditional compilation block"),
      ]
    )
  }

  func testPoundIfNestedStructure() {
    assertParse(
      """
      #if true
      #if true
      @frozen
      #endif
      #endif
      public struct S {}
      """,
      substructure: AttributeListSyntax([
        .ifConfigDecl(
          IfConfigDeclSyntax(clauses: [
            IfConfigClauseSyntax(
              poundKeyword: .poundIfToken(),
              condition: ExprSyntax("true"),
              elements: .attributes([
                .ifConfigDecl(
                  IfConfigDeclSyntax(clauses: [
                    IfConfigClauseSyntax(
                      poundKeyword: .poundIfToken(),
                      condition: ExprSyntax("true"),
                      elements: .attributes([
                        .attribute("@frozen")
                      ])
                    )
                  ])
                )
              ])
            )
          ])
        )
      ])
    )
  }

  func testHasAttribute() {
    assertParse(
      """
      @frozen
      #if hasAttribute(foo)
      @foo
      #endif
      public struct S2 { }
      """
    )

    assertParse(
      """
      struct Inner {
        @frozen
      #if hasAttribute(foo)
        #if hasAttribute(bar)
        @foo @bar
        #endif
      #endif
        public struct S2 { }

      #if hasAttribute(foo)
        @foo
      #endif
        @inlinable
        func f1() { }

      #if hasAttribute(foo)
        @foo
      #else
        @available(*, deprecated, message: "nope")
        @frozen
      #endif
        public struct S3 { }
      }
      """
    )
  }

  func testEndIfFollowedByDeclarations() {
    assertParse(
      """
      struct Foo {
        #if false
        var x: Int
        #endif1️⃣; var x = 1
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "extra tokens following conditional compilation directive"
        )
      ]
    )
  }

  func testIfFollowByDeclarations() {
    assertParse(
      """
      struct Foo {
        #if DEBUG1️⃣; var x = 1
        var x: Int
        #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "extra tokens following conditional compilation directive"
        )
      ]
    )

    assertParse(
      """
      struct Foo {
        #if DEBUG || UAT1️⃣; var x = 1
        var x: Int
        #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "extra tokens following conditional compilation directive"
        )
      ]
    )
  }

  func testElseIfFollowByDeclarations() {
    assertParse(
      """
      struct Foo {
        #if DEBUG
        var x: Int = 1
        #elseif UAT1️⃣; var x = 1
        var x: Int = 2
        #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "extra tokens following conditional compilation directive"
        )
      ]
    )

    assertParse(
      """
      struct Foo {
        #if DEBUG
        var x: Int = 1
        #elseif UAT || UAT1️⃣; var x = 1
        var x: Int = 2
        #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "extra tokens following conditional compilation directive"
        )
      ]
    )
  }

  func testElseFollowByDeclarations() {
    assertParse(
      """
      struct Foo {
        #if DEBUG
        var x: Int = 1
        #else1️⃣; var x = 1
        var x: Int = 2
        #endif
      }
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "extra tokens following conditional compilation directive"
        )
      ]
    )
  }

  func testSourcelocationDirectiveFollowedByDeclarations() {
    assertParse(
      """
      var sometName: Int
      #sourceLocation(file: "other.swift", line: 1)
      var someName: Int
      """
    )

    assertParse(
      """
      #sourceLocation(file: "other.swift", line: 1)1️⃣; let x = 1
      """,
      diagnostics: [
        DiagnosticSpec(
          message: "extra tokens following the #sourceLocation directive"
        )
      ]
    )
  }

  func testIfConfigRRR() {
    assertParse(
      """
      @frozen1️⃣

      #if true
      func foo() {}
      #endif
      """,
      substructure: CodeBlockItemListSyntax([
        CodeBlockItemSyntax(
          item: .init(
            MissingDeclSyntax(
              attributes: [
                .attribute(
                  AttributeSyntax(
                    atSign: .atSignToken(),
                    attributeName: TypeSyntax(IdentifierTypeSyntax(name: .identifier("frozen")))
                  )
                )
              ],
              modifiers: [],
              placeholder: .identifier("<#declaration#>", presence: .missing)
            )
          )
        ),
        CodeBlockItemSyntax(
          item: .init(
            IfConfigDeclSyntax(
              clauses: IfConfigClauseListSyntax([
                IfConfigClauseSyntax(
                  poundKeyword: .poundIfToken(),
                  condition: ExprSyntax(BooleanLiteralExprSyntax(literal: .keyword(.true))),
                  elements: .statements(
                    CodeBlockItemListSyntax([
                      CodeBlockItemSyntax(
                        item: CodeBlockItemSyntax.Item(
                          FunctionDeclSyntax(
                            attributes: [],
                            modifiers: [],
                            funcKeyword: .keyword(.func),
                            name: .identifier("foo"),
                            signature: FunctionSignatureSyntax(
                              parameterClause: FunctionParameterClauseSyntax(
                                leftParen: .leftParenToken(),
                                parameters: FunctionParameterListSyntax([]),
                                rightParen: .rightParenToken()
                              )
                            ),
                            body: CodeBlockSyntax(
                              leftBrace: .leftBraceToken(),
                              statements: CodeBlockItemListSyntax([]),
                              rightBrace: .rightBraceToken()
                            )
                          )
                        )
                      )
                    ])
                  )
                )
              ]),
              poundEndif: .poundEndifToken()
            )
          )
        ),
      ]),
      diagnostics: [
        DiagnosticSpec(message: "expected declaration after attribute", fixIts: ["insert declaration"])
      ],
      fixedSource: """
        @frozen <#declaration#>

        #if true
        func foo() {}
        #endif
        """
    )
  }
}
