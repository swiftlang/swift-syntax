import XCTest
import SwiftSyntax

fileprivate class FuncRenamer: SyntaxRewriter {
  override func visit(_ node: FunctionDeclSyntax) ->DeclSyntax {
    return (super.visit(node) as! FunctionDeclSyntax).withIdentifier(
      SyntaxFactory.makeIdentifier("anotherName"))
  }
}

public class AbsolutePositionTestCase: XCTestCase {

  public static let allTests = [
    ("testVisitor", testVisitor),
    ("testClosure", testClosure),
    ("testRename", testRename),
    ("testCurrentFile", testCurrentFile),
    ("testRecursion", testRecursion),
    ("testTrivias", testTrivias),
    ("testImplicit", testImplicit),
    ("testWithoutSourceFileRoot", testWithoutSourceFileRoot),
    ("testSourceLocation", testSourceLocation),
  ]

  public func testVisitor() {
    XCTAssertNoThrow(try {
      let source = try String(contentsOf: getInput("visitor.swift"))
      let parsed = try SyntaxParser.parse(getInput("visitor.swift"))
      XCTAssertEqual(0, parsed.position.utf8Offset)
      XCTAssertEqual(source.count,
        parsed.eofToken.positionAfterSkippingLeadingTrivia.utf8Offset)
      XCTAssertEqual(0, parsed.position.utf8Offset)
      XCTAssertEqual(source.count, parsed.byteSize)  
    }())
  }

  public func testClosure() {
    XCTAssertNoThrow(try {
      let source = try String(contentsOf: getInput("closure.swift"))
      let parsed = try SyntaxParser.parse(getInput("closure.swift"))
      XCTAssertEqual(source.count, 
        parsed.eofToken.positionAfterSkippingLeadingTrivia.utf8Offset)
      XCTAssertEqual(0, parsed.position.utf8Offset)
      XCTAssertEqual(source.count, parsed.byteSize)
    }())
  }

  public func testRename() {
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getInput("visitor.swift"))
      let renamed = FuncRenamer().visit(parsed) as! SourceFileSyntax
      let renamedSource = renamed.description
      XCTAssertEqual(renamedSource.count, 
        renamed.eofToken.positionAfterSkippingLeadingTrivia.utf8Offset)
      XCTAssertEqual(renamedSource.count, renamed.byteSize)
    }())
  }

  public func testCurrentFile() {
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(URL(fileURLWithPath: #file))
      class Visitor: SyntaxVisitor {
        override func visitPre(_ node: Syntax) {
          _ = node.position
          _ = node.byteSize
          _ = node.positionAfterSkippingLeadingTrivia
        }
        override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
          XCTAssertEqual(node.positionAfterSkippingLeadingTrivia.utf8Offset,
            node.position.utf8Offset + node.leadingTrivia.byteSize)
          return .skipChildren
        }
      }
      parsed.walk(Visitor())
    }())
  }

  public func testRecursion() {
    var l = [CodeBlockItemSyntax]()
    let idx = 2000
    for _ in 0...idx {
      l.append(SyntaxFactory.makeCodeBlockItem(
        item: SyntaxFactory.makeReturnStmt(
          returnKeyword: SyntaxFactory.makeToken(.returnKeyword, presence: .present)
            .withTrailingTrivia(.newlines(1)), expression: nil), semicolon: nil, errorTokens: nil))
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
        .docLineComment("/// some comment"),
        .carriageReturns(1),
        ])
    let trailing = Trivia(pieces: [
        .blockComment("/* This is comment \r\r\n */"),
        .carriageReturnLineFeeds(1),
        ])
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
    let root = self.createSourceFile(idx + 1)
    XCTAssertEqual(4, root.leadingTrivia!.count)
    XCTAssertEqual(0, root.trailingTrivia!.count)
    let state = root.statements[idx]
    XCTAssertEqual(4, state.leadingTrivia!.count)
    XCTAssertEqual(2, state.trailingTrivia!.count)
    XCTAssertEqual(state.byteSize,
      state.leadingTrivia!.byteSize + state.trailingTrivia!.byteSize
        + state.byteSizeAfterTrimmingTrivia)
    XCTAssertFalse(root.statements.isImplicit)
  }

  public func testImplicit() {
    let root = self.createSourceFile(0)
    XCTAssertTrue(root.statements.isImplicit)
  }

  public func testWithoutSourceFileRoot() {
    let item = SyntaxFactory.makeCodeBlockItem(
      item: SyntaxFactory.makeReturnStmt(
        returnKeyword: SyntaxFactory.makeToken(.returnKeyword, presence: .present)
          .withLeadingTrivia(.newlines(1)).withTrailingTrivia(.newlines(1)),
          expression: nil), semicolon: nil, errorTokens: nil)
     XCTAssertEqual(0, item.position.utf8Offset)
     XCTAssertEqual(1, item.positionAfterSkippingLeadingTrivia.utf8Offset)
  }

  public func testSourceLocation() {
    let filePath = "/tmp/test.swift"
    let root = self.createSourceFile(2)
    let converter = SourceLocationConverter(file: filePath, tree: root)
    let secondReturnStmt = root.statements[1]
    let startLoc = secondReturnStmt.startLocation(converter: converter)
    XCTAssertEqual(startLoc.line, 8)
    XCTAssertEqual(startLoc.column, 1)
    XCTAssertEqual(converter.position(ofLine: startLoc.line, column: startLoc.column),
      secondReturnStmt.positionAfterSkippingLeadingTrivia)

    let startLocBeforeTrivia =
      secondReturnStmt.startLocation(converter: converter,
        afterLeadingTrivia: false)
    XCTAssertEqual(startLocBeforeTrivia.line, 6)
    XCTAssertEqual(startLocBeforeTrivia.column, 1)
    XCTAssertEqual(converter.position(ofLine: startLocBeforeTrivia.line, column: startLocBeforeTrivia.column),
      secondReturnStmt.position)

    let endLoc = secondReturnStmt.endLocation(converter: converter)
    XCTAssertEqual(endLoc.line, 8)
    XCTAssertEqual(endLoc.column, 7)

    let endLocAfterTrivia =
      secondReturnStmt.endLocation(converter: converter,
        afterTrailingTrivia: true)
    XCTAssertEqual(endLocAfterTrivia.line, 11)
    XCTAssertEqual(endLocAfterTrivia.column, 1)

    XCTAssertTrue(converter.isValid(line: startLoc.line, column: startLoc.column))
    XCTAssertFalse(converter.isValid(line: startLoc.line, column: startLoc.column+50))
    XCTAssertFalse(converter.isValid(line: 0, column: startLoc.column))
    XCTAssertTrue(converter.isValid(position: secondReturnStmt.position))
    XCTAssertFalse(converter.isValid(position: secondReturnStmt.position+SourceLength(utf8Length: 100)))
  }
}
