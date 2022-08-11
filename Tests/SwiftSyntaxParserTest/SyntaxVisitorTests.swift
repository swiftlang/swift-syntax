import XCTest
import SwiftSyntax
import SwiftSyntaxParser
import _SwiftSyntaxTestSupport

public class SyntaxVisitorTests: XCTestCase {

  public func testBasic() {
    class FuncCounter: SyntaxVisitor {
      var funcCount = 0
      override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        funcCount += 1
        return .visitChildren
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getTestInput("visitor.swift"))
      let counter = FuncCounter(viewMode: .fixedUp)
      let hashBefore = parsed.hashValue
      counter.walk(parsed)
      XCTAssertEqual(counter.funcCount, 3)
      XCTAssertEqual(hashBefore, parsed.hashValue)
    }())
  }

  public func testRewritingNodeWithEmptyChild() {
    class ClosureRewriter: SyntaxRewriter {
      override func visit(_ node: ClosureExprSyntax) -> ExprSyntax {
        // Perform a no-op transform that requires rebuilding the node.
        return ExprSyntax(node.withSignature(node.signature))
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getTestInput("closure.swift"))
      let rewriter = ClosureRewriter()
      let rewritten = rewriter.visit(parsed)
      XCTAssertEqual(parsed.description, rewritten.description)
    }())
  }

  public func testSyntaxRewriterVisitAny() {
    class VisitAnyRewriter: SyntaxRewriter {
      let transform: (TokenSyntax) -> TokenSyntax
      init(transform: @escaping (TokenSyntax) -> TokenSyntax) {
        self.transform = transform
      }
      override func visitAny(_ node: Syntax) -> Syntax? {
        if let tok = node.as(TokenSyntax.self) {
          return Syntax(transform(tok))
        }
        return nil
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getTestInput("near-empty.swift"))
      let rewriter = VisitAnyRewriter(transform: { _ in
        return TokenSyntax.identifier("")
      })
      let rewritten = rewriter.visit(parsed)
      XCTAssertEqual(rewritten.description, "")
    }())
  }

  public func testSyntaxRewriterVisitCollection() {
    class VisitCollections: SyntaxVisitor {
      var numberOfCodeBlockItems = 0

      override func visit(_ items: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
        numberOfCodeBlockItems += items.count
        return .visitChildren
      }
    }

    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getTestInput("nested-blocks.swift"))
      let visitor = VisitCollections(viewMode: .fixedUp)
      visitor.walk(parsed)
      XCTAssertEqual(4, visitor.numberOfCodeBlockItems)
    }())
  }

  public func testVisitorClass() {
    class FuncCounter: SyntaxVisitor {
      var funcCount = 0
      override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        funcCount += 1
        return super.visit(node)
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getTestInput("visitor.swift"))
      let counter = FuncCounter(viewMode: .fixedUp)
      let hashBefore = parsed.hashValue
      counter.walk(parsed)
      XCTAssertEqual(counter.funcCount, 3)
      XCTAssertEqual(hashBefore, parsed.hashValue)
    }())
  }

  public func testRewriteTrivia() {
    class TriviaRemover: SyntaxRewriter {
      override func visit(_ token: TokenSyntax) -> Syntax {
        return Syntax(token.withTrailingTrivia(.zero))
      }
    }

    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(source: "let a = 5")
      let visitor = TriviaRemover()
      let rewritten = visitor.visit(parsed)
      XCTAssertEqual(rewritten.description, "leta=5")
    }())
  }
}
