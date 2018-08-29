import XCTest
import SwiftSyntax

fileprivate class FuncRenamer: SyntaxRewriter {
  override func visit(_ node: FunctionDeclSyntax) ->DeclSyntax {
    return (super.visit(node) as! FunctionDeclSyntax).withIdentifier(
      SyntaxFactory.makeIdentifier("anotherName"))
  }
}

public class AbsolutePositionTestCase: XCTestCase {
  public func testVisitor() {
    XCTAssertNoThrow(try {
      let source = try String(contentsOf: getInput("visitor.swift"))
      let parsed = try SourceFileSyntax.parse(getInput("visitor.swift"))
      XCTAssertEqual(parsed.position.byteOffset, 0)
      XCTAssertEqual(parsed.eofToken.positionAfterSkippingLeadingTrivia.byteOffset,
                  source.count)
      XCTAssertEqual(parsed.position.byteOffset, 0)
      XCTAssertEqual(parsed.byteSize, source.count)
    }())
  }

  public func testClosure() {
    XCTAssertNoThrow(try {
      let source = try String(contentsOf: getInput("closure.swift"))
      let parsed = try SourceFileSyntax.parse(getInput("closure.swift"))
      XCTAssertEqual(parsed.eofToken.positionAfterSkippingLeadingTrivia.byteOffset,
                  source.count)
      XCTAssertEqual(parsed.position.byteOffset, 0)
      XCTAssertEqual(parsed.byteSize, source.count)
    }())
  }

  public func testRename() {
    XCTAssertNoThrow(try {
      let parsed = try SourceFileSyntax.parse(getInput("visitor.swift"))
      let renamed = FuncRenamer().visit(parsed) as! SourceFileSyntax
      let renamedSource = renamed.description
      XCTAssertEqual(renamed.eofToken.positionAfterSkippingLeadingTrivia.byteOffset,
                  renamedSource.count)
      XCTAssertEqual(renamed.byteSize, renamedSource.count)
    }())
  }

  public func testCurrentFile() {
    XCTAssertNoThrow(try {
      let parsed = try SourceFileSyntax.parse(URL(fileURLWithPath: #file))
      class Visitor: SyntaxVisitor {
        override func visitPre(_ node: Syntax) {
          _ = node.position
          _ = node.byteSize
          _ = node.positionAfterSkippingLeadingTrivia
        }
        override func visit(_ node: TokenSyntax) {
          XCTAssertEqual(node.position.byteOffset + node.leadingTrivia.byteSize,
                      node.positionAfterSkippingLeadingTrivia.byteOffset)
        }
      }
      Visitor().visit(parsed)
    }())
  }

  public func testRecursion() {
    var l = [CodeBlockItemSyntax]()
    let idx = 2000
    for _ in 0...idx {
      l.append(SyntaxFactory.makeCodeBlockItem(
        item: SyntaxFactory.makeReturnStmt(
          returnKeyword: SyntaxFactory.makeToken(.returnKeyword, presence: .present)
            .withTrailingTrivia(.newlines(1)), expression: nil), semicolon: nil))
    }
    let root = SyntaxFactory.makeSourceFile(
      statements: SyntaxFactory.makeCodeBlockItemList(l),
      eofToken: SyntaxFactory.makeToken(.eof, presence: .present))
    _ = root.statements[idx].position
    _ = root.statements[idx].byteSize
    _ = root.statements[idx].positionAfterSkippingLeadingTrivia
  }

  func createSourceFile(_ count: Int) -> SourceFileSyntax {
    let leading = Trivia(pieces: [
        .newlines(1),
        .backticks(1),
        .docLineComment("/// some comment")
        ])
    let trailing = Trivia.docLineComment("/// This is comment\n")
    let items : [CodeBlockItemSyntax] =
      [CodeBlockItemSyntax](repeating: CodeBlockItemSyntax {
        $0.useItem(ReturnStmtSyntax {
          $0.useReturnKeyword(
            SyntaxFactory.makeReturnKeyword(
              leadingTrivia: leading,
              trailingTrivia: trailing))
        })}, count: count)
    return SyntaxFactory.makeSourceFile(
      statements: SyntaxFactory.makeCodeBlockItemList(items),
      eofToken: SyntaxFactory.makeToken(.eof, presence: .present))
  }

  public func testTrivias() {
    let idx = 5
    let root = createSourceFile(idx + 1)
    XCTAssertEqual(root.leadingTrivia!.count, 3)
    XCTAssertEqual(root.trailingTrivia!.count, 0)
    let state = root.statements[idx]
    XCTAssertEqual(state.leadingTrivia!.count, 3)
    XCTAssertEqual(state.trailingTrivia!.count, 1)
    XCTAssertEqual(state.leadingTrivia!.byteSize + state.trailingTrivia!.byteSize
      + state.byteSizeAfterTrimmingTrivia, state.byteSize)
    XCTAssertFalse(root.statements.isImplicit)
  }

  public func testImplicit() {
    let root = createSourceFile(0)
    XCTAssertTrue(root.statements.isImplicit)
  }
}
