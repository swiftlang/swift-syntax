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

import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

class SyntaxVisitorTests: XCTestCase {
  /// The syntax tree of the following source file
  /// ```swift
  /// func foo() {
  ///   public func foo() {
  ///     func foo() {
  ///       /*Unknown token */0xG
  ///     }
  ///   }
  /// }
  /// ```
  ///
  /// The source file is hard-coded so this test case doesn't need to depend on the parser.
  static var nestedFunctionsFile: SourceFileSyntax {
    let innerBody = CodeBlockSyntax(
      leftBrace: .leftBraceToken(),
      statements: CodeBlockItemListSyntax([
        CodeBlockItemSyntax(
          item: CodeBlockItemSyntax.Item(
            IntegerLiteralExprSyntax(
              literal: .integerLiteral(
                "0xG",
                leadingTrivia: [
                  .newlines(1),
                  .spaces(6),
                  .blockComment("/*Unknown token */"),
                ]
              )
            )
          )
        )
      ]),
      rightBrace: .rightBraceToken(leadingTrivia: [.newlines(1), .spaces(4)])
    )

    let source = SourceFileSyntax(
      statements: CodeBlockItemListSyntax([
        CodeBlockItemSyntax(
          item: CodeBlockItemSyntax.Item(
            FunctionDeclSyntax(
              funcKeyword: .keyword(.func, trailingTrivia: .space),
              name: .identifier("foo"),
              signature: FunctionSignatureSyntax(
                parameterClause: FunctionParameterClauseSyntax(
                  leftParen: .leftParenToken(),
                  parameters: FunctionParameterListSyntax([]),
                  rightParen: .rightParenToken(trailingTrivia: .space)
                )
              ),
              body: CodeBlockSyntax(
                leftBrace: .leftBraceToken(),
                statements: CodeBlockItemListSyntax([
                  CodeBlockItemSyntax(
                    item: CodeBlockItemSyntax.Item(
                      FunctionDeclSyntax(
                        modifiers: DeclModifierListSyntax([
                          DeclModifierSyntax(name: .keyword(.public, leadingTrivia: [.newlines(1), .spaces(2)], trailingTrivia: .space))
                        ]),
                        funcKeyword: .keyword(.func, trailingTrivia: .space),
                        name: .identifier("foo"),
                        signature: FunctionSignatureSyntax(
                          parameterClause: FunctionParameterClauseSyntax(
                            leftParen: .leftParenToken(),
                            parameters: FunctionParameterListSyntax([]),
                            rightParen: .rightParenToken(trailingTrivia: .space)
                          )
                        ),
                        body: CodeBlockSyntax(
                          leftBrace: .leftBraceToken(),
                          statements: CodeBlockItemListSyntax([
                            CodeBlockItemSyntax(
                              item: CodeBlockItemSyntax.Item(
                                FunctionDeclSyntax(
                                  funcKeyword: .keyword(.func, leadingTrivia: [.newlines(1), .spaces(4)], trailingTrivia: .space),
                                  name: .identifier("foo"),
                                  signature: FunctionSignatureSyntax(
                                    parameterClause: FunctionParameterClauseSyntax(
                                      leftParen: .leftParenToken(),
                                      parameters: FunctionParameterListSyntax([]),
                                      rightParen: .rightParenToken(trailingTrivia: .space)
                                    )
                                  ),
                                  body: innerBody
                                )
                              )
                            )
                          ]),
                          rightBrace: .rightBraceToken(leadingTrivia: [.newlines(1), .spaces(2)])
                        )
                      )
                    )
                  )
                ]),
                rightBrace: .rightBraceToken(leadingTrivia: .newline)
              )
            )
          )
        )
      ])
    )

    // Make sure we are indeed generating a syntax tree for the expected source file.
    precondition(
      source.description
        == """
        func foo() {
          public func foo() {
            func foo() {
              /*Unknown token */0xG
            }
          }
        }
        """
    )
    return source
  }

  public func testBasic() {
    class FuncCounter: SyntaxVisitor {
      var funcCount = 0
      override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        funcCount += 1
        return .visitChildren
      }
    }
    let parsed = Self.nestedFunctionsFile
    let counter = FuncCounter(viewMode: .fixedUp)
    let hashBefore = parsed.hashValue
    counter.walk(parsed)
    XCTAssertEqual(counter.funcCount, 3)
    XCTAssertEqual(hashBefore, parsed.hashValue)
  }

  public func testRewritingNodeWithEmptyChild() {
    class ClosureRewriter: SyntaxRewriter {
      override func visit(_ node: ClosureExprSyntax) -> ExprSyntax {
        // Perform a no-op transform that requires rebuilding the node.
        return ExprSyntax(node.with(\.statements, node.statements))
      }
    }
    let closure = ClosureExprSyntax(
      statements: CodeBlockItemListSyntax([])
    )
    let rewriter = ClosureRewriter(viewMode: .sourceAccurate)
    let rewritten = rewriter.rewrite(closure)
    XCTAssertEqual(closure.description, rewritten.description)
  }

  public func testSyntaxRewriterVisitAny() {
    class VisitAnyRewriter: SyntaxRewriter {
      let transform: (TokenSyntax) -> TokenSyntax
      init(transform: @escaping (TokenSyntax) -> TokenSyntax) {
        self.transform = transform
        super.init(viewMode: .sourceAccurate)
      }
      override func visitAny(_ node: Syntax) -> Syntax? {
        if let tok = node.as(TokenSyntax.self) {
          return Syntax(transform(tok))
        }
        return nil
      }
    }
    let parsed = DeclReferenceExprSyntax(baseName: .identifier("n"))
    let rewriter = VisitAnyRewriter(transform: { _ in
      return TokenSyntax.identifier("")
    })
    let rewritten = rewriter.visit(parsed)
    XCTAssertEqual(rewritten.description, "")
  }

  public func testSyntaxRewriterVisitCollection() {
    class VisitCollections: SyntaxVisitor {
      var numberOfCodeBlockItems = 0

      override func visit(_ items: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
        numberOfCodeBlockItems += items.count
        return .visitChildren
      }
    }

    let visitor = VisitCollections(viewMode: .fixedUp)
    visitor.walk(Self.nestedFunctionsFile)
    XCTAssertEqual(4, visitor.numberOfCodeBlockItems)
  }

  public func testVisitorClass() {
    class FuncCounter: SyntaxVisitor {
      var funcCount = 0
      override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        funcCount += 1
        return super.visit(node)
      }
    }
    let sourceFile = Self.nestedFunctionsFile
    let counter = FuncCounter(viewMode: .fixedUp)
    let hashBefore = sourceFile.hashValue
    counter.walk(sourceFile)
    XCTAssertEqual(counter.funcCount, 3)
    XCTAssertEqual(hashBefore, sourceFile.hashValue)
  }

  public func testRewriteTrivia() {
    class TriviaRemover: SyntaxRewriter {
      override func visit(_ token: TokenSyntax) -> TokenSyntax {
        return token.with(\.trailingTrivia, [])
      }
    }

    let source = VariableDeclSyntax(
      bindingSpecifier: .keyword(.let, trailingTrivia: .space),
      bindings: PatternBindingListSyntax([
        PatternBindingSyntax(
          pattern: PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("a", trailingTrivia: .space))),
          initializer: InitializerClauseSyntax(
            equal: .equalToken(trailingTrivia: .space),
            value: ExprSyntax(IntegerLiteralExprSyntax(literal: .integerLiteral("5")))
          )
        )
      ])
    )
    XCTAssertEqual(source.description, "let a = 5")
    let rewriter = TriviaRemover(viewMode: .sourceAccurate)
    let rewritten = rewriter.rewrite(source)
    XCTAssertEqual(rewritten.description, "leta=5")
  }
}
