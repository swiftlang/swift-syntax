//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftSyntax

public class VisitorTests: XCTestCase {
  public func testVisitMissingNodes() {
    let node = DeclarationStmtSyntax(declaration: MissingDeclSyntax())

    class MissingDeclChecker: SyntaxVisitor {
      var didSeeMissingDeclSyntax = false

      override func visit(_ node: MissingDeclSyntax) -> SyntaxVisitorContinueKind {
        didSeeMissingDeclSyntax = true
        return .visitChildren
      }

      static func check<Tree: SyntaxProtocol>(_ tree: Tree, viewMode: SyntaxTreeViewMode) -> Bool {
        let visitor = MissingDeclChecker(viewMode: viewMode)
        visitor.walk(tree)
        return visitor.didSeeMissingDeclSyntax
      }
    }

    XCTAssertTrue(MissingDeclChecker.check(node, viewMode: .sourceAccurate))
    XCTAssertTrue(MissingDeclChecker.check(node, viewMode: .fixedUp))
  }

  public func testVisitMissingToken() {
    let node = ReturnStmtSyntax(
      returnKeyword: .returnKeyword(presence: .missing)
    )

    class MissingTokenChecker: SyntaxVisitor {
      var didSeeToken = false

      override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
        didSeeToken = true
        return .visitChildren
      }

      static func check<Tree: SyntaxProtocol>(_ tree: Tree, viewMode: SyntaxTreeViewMode) -> Bool {
        let visitor = MissingTokenChecker(viewMode: viewMode)
        visitor.walk(tree)
        return visitor.didSeeToken
      }
    }

    XCTAssertFalse(MissingTokenChecker.check(node, viewMode: .sourceAccurate))
    XCTAssertTrue(MissingTokenChecker.check(node, viewMode: .fixedUp))
  }

  public func testVisitUnexpected() {
    // This is just bunch of unexpected
    let unexpectedReturnStmt = ReturnStmtSyntax(
      UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("starting")), Syntax(TokenSyntax.integerLiteral("unexpected"))]),
      returnKeyword: .returnKeyword(trailingTrivia: [.spaces(1)]),
      UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("middle"))]),
      expression: ExprSyntax(NilLiteralExprSyntax(UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("end"))]), nilKeyword: TokenSyntax.nilKeyword(trailingTrivia: [])))
    )

    // This is more real-world where the user wrote null instead of nil.
    let misspelledNil = ReturnStmtSyntax(
      returnKeyword: .returnKeyword(trailingTrivia: [.spaces(1)]),
      expression: ExprSyntax(
        NilLiteralExprSyntax(
          UnexpectedNodesSyntax([Syntax(TokenSyntax.identifier("null"))]),
          nilKeyword: .nilKeyword(presence: .missing)
        )
      )
    )

    // Test SyntaxVisitor
    class TreePrinter: SyntaxVisitor {
      var out = ""

      override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
        out += node.leadingTrivia.description
        out += node.text
        out += node.trailingTrivia.description
        return .visitChildren
      }

      static func print<Tree: SyntaxProtocol>(_ tree: Tree, viewMode: SyntaxTreeViewMode) -> String {
        let printer = TreePrinter(viewMode: viewMode)
        printer.walk(tree)
        return printer.out
      }
    }

    XCTAssertEqual(TreePrinter.print(unexpectedReturnStmt, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(TreePrinter.print(unexpectedReturnStmt, viewMode: .sourceAccurate), "startingunexpectedreturn middleendnil")

    XCTAssertEqual(TreePrinter.print(misspelledNil, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(TreePrinter.print(misspelledNil, viewMode: .sourceAccurate), "return null")

    // Test SyntaxAnyVisitor
    class AnyTreePrinter: SyntaxAnyVisitor {
      var out = ""

      override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        if let token = node.as(TokenSyntax.self) {
          out += token.leadingTrivia.description
          out += token.text
          out += token.trailingTrivia.description
        }
        return .visitChildren
      }

      static func print<Tree: SyntaxProtocol>(_ tree: Tree, viewMode: SyntaxTreeViewMode) -> String {
        let printer = TreePrinter(viewMode: viewMode)
        printer.walk(tree)
        return printer.out
      }
    }

    XCTAssertEqual(AnyTreePrinter.print(unexpectedReturnStmt, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(AnyTreePrinter.print(unexpectedReturnStmt, viewMode: .sourceAccurate), "startingunexpectedreturn middleendnil")

    XCTAssertEqual(AnyTreePrinter.print(misspelledNil, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(AnyTreePrinter.print(misspelledNil, viewMode: .sourceAccurate), "return null")

    // Test SyntaxRewriter
    class RewritingTreePrinter: SyntaxRewriter {
      var out = ""

      override func visit(_ node: TokenSyntax) -> TokenSyntax {
        out += node.leadingTrivia.description
        out += node.text
        out += node.trailingTrivia.description
        return node
      }

      static func print<Tree: SyntaxProtocol>(_ tree: Tree, viewMode: SyntaxTreeViewMode) -> String {
        let printer = TreePrinter(viewMode: viewMode)
        printer.walk(tree)
        return printer.out
      }
    }

    XCTAssertEqual(RewritingTreePrinter.print(unexpectedReturnStmt, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(RewritingTreePrinter.print(unexpectedReturnStmt, viewMode: .sourceAccurate), "startingunexpectedreturn middleendnil")

    XCTAssertEqual(RewritingTreePrinter.print(misspelledNil, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(RewritingTreePrinter.print(misspelledNil, viewMode: .sourceAccurate), "return null")
  }
}
