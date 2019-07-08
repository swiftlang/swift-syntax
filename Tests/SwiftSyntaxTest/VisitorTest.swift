import XCTest
import SwiftSyntax

public class SyntaxVisitorTestCase: XCTestCase {

  public static let allTests = [
    ("testBasic", testBasic),
    ("testRewritingNodeWithEmptyChild", testRewritingNodeWithEmptyChild),
    ("testSyntaxRewriterVisitAny", testSyntaxRewriterVisitAny),
    ("testSyntaxRewriterVisitCollection", testSyntaxRewriterVisitCollection),
    ("testVisitorClass", testVisitorClass),
  ]

  public func testBasic() {
    struct FuncCounter: SyntaxVisitor {
      var funcCount = 0
      mutating func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        funcCount += 1
        return .visitChildren
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("visitor.swift"))
      var counter = FuncCounter()
      let hashBefore = parsed.hashValue
      parsed.walk(&counter)
      XCTAssertEqual(counter.funcCount, 3)
      XCTAssertEqual(hashBefore, parsed.hashValue)
    }())
  }

  public func testRewritingNodeWithEmptyChild() {
    class ClosureRewriter: SyntaxRewriter {
      override func visit(_ node: ClosureExprSyntax) -> ExprSyntax {
        // Perform a no-op transform that requires rebuilding the node.
        return node.withSignature(node.signature)
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("closure.swift"))
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
        if let tok = node as? TokenSyntax {
          return transform(tok)
        }
        return nil
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("near-empty.swift"))
      let rewriter = VisitAnyRewriter(transform: { _ in
         return SyntaxFactory.makeIdentifier("")
      })
      let rewritten = rewriter.visit(parsed)
      XCTAssertEqual(rewritten.description, "")
    }())
  }

  public func testSyntaxRewriterVisitCollection() {
    struct VisitCollections: SyntaxVisitor {
      var numberOfCodeBlockItems = 0

      mutating func visit(_ items: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
        numberOfCodeBlockItems += items.count
        return .visitChildren
      }
    }

    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("nested-blocks.swift"))
      var visitor = VisitCollections()
      parsed.walk(&visitor)
      XCTAssertEqual(4, visitor.numberOfCodeBlockItems)
    }())
  }

  public func testVisitorClass() {
    class FuncCounter: SyntaxVisitorBase {
      var funcCount = 0
      override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        funcCount += 1
        return super.visit(node)
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("visitor.swift"))
      var counter = FuncCounter()
      let hashBefore = parsed.hashValue
      parsed.walk(&counter)
      XCTAssertEqual(counter.funcCount, 3)
      XCTAssertEqual(hashBefore, parsed.hashValue)
    }())
  }
}
