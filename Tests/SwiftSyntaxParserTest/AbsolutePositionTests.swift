import XCTest
import SwiftSyntax
import SwiftSyntaxParser
import _SwiftSyntaxTestSupport

fileprivate class FuncRenamer: SyntaxRewriter {
  override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
    let rewritten = super.visit(node).as(FunctionDeclSyntax.self)!
    let modifiedFunctionDecl = rewritten.withIdentifier(
      .identifier("anotherName"))
    return DeclSyntax(modifiedFunctionDecl)
  }
}

public class AbsolutePositionTests: XCTestCase {

  public func testVisitor() {
    XCTAssertNoThrow(try {
      let source = try String(contentsOf: getTestInput("visitor.swift"))
      let parsed = try SyntaxParser.parse(getTestInput("visitor.swift"))
      XCTAssertEqual(0, parsed.position.utf8Offset)
      XCTAssertEqual(source.count,
        parsed.eofToken.positionAfterSkippingLeadingTrivia.utf8Offset)
      XCTAssertEqual(0, parsed.position.utf8Offset)
      XCTAssertEqual(source.count, parsed.byteSize)  
    }())
  }

  public func testClosure() {
    XCTAssertNoThrow(try {
      let source = try String(contentsOf: getTestInput("closure.swift"))
      let parsed = try SyntaxParser.parse(getTestInput("closure.swift"))
      XCTAssertEqual(source.count, 
        parsed.eofToken.positionAfterSkippingLeadingTrivia.utf8Offset)
      XCTAssertEqual(0, parsed.position.utf8Offset)
      XCTAssertEqual(source.count, parsed.byteSize)
    }())
  }

  public func testRename() {
    XCTAssertNoThrow(try {
      let parsed = try SyntaxParser.parse(getTestInput("visitor.swift"))
      let renamed = FuncRenamer().visit(parsed).as(SourceFileSyntax.self)!
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
        override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
          XCTAssertEqual(node.positionAfterSkippingLeadingTrivia.utf8Offset,
            node.position.utf8Offset + node.leadingTrivia.byteSize)
          return .skipChildren
        }
      }
      let visitor = Visitor(viewMode: .sourceAccurate)
      visitor.walk(parsed)
    }())
  }

  public func testRecursion() {
    var l = [CodeBlockItemSyntax]()
    let idx = 2000
    for _ in 0...idx {
      l.append(CodeBlockItemSyntax(
        item: Syntax(
          ReturnStmtSyntax(
            returnKeyword: .returnKeyword(trailingTrivia: .newline),
            expression: nil
          )
        ),
        semicolon: nil, 
        errorTokens: nil)
      )
    }
    let root = SourceFileSyntax(
      statements: CodeBlockItemListSyntax(l),
      eofToken: .eof())
    _ = root.statements[idx].position
    _ = root.statements[idx].byteSize
    _ = root.statements[idx].positionAfterSkippingLeadingTrivia
  }

  static let leadingTrivia = Trivia(pieces: [
    .newlines(1),
    .docLineComment("/// some comment"),
    .carriageReturns(1),
  ])

  static let trailingTrivia = Trivia(pieces: [
    .blockComment("/* This is comment \r\r\n */"),
    .carriageReturnLineFeeds(1),
  ])

  func createSourceFile(_ count: Int) -> SourceFileSyntax {
    let items : [CodeBlockItemSyntax] =
    [CodeBlockItemSyntax](repeating: CodeBlockItemSyntax(
      item: Syntax(ReturnStmtSyntax(
        returnKeyword: .returnKeyword(
          leadingTrivia: AbsolutePositionTests.leadingTrivia,
          trailingTrivia: AbsolutePositionTests.trailingTrivia
        ),
        expression: nil
      )),
      semicolon: nil,
      errorTokens: nil
    ), count: count)
    return SourceFileSyntax(
      statements: CodeBlockItemListSyntax(items),
      eofToken: .eof())
  }

  public func testTrivias() {
    let idx = 5
    let root = self.createSourceFile(idx + 1)
    XCTAssertEqual(3, root.leadingTrivia!.count)
    XCTAssertEqual(0, root.trailingTrivia!.count)
    let state = root.statements[idx]
    XCTAssertEqual(3, state.leadingTrivia!.count)
    XCTAssertEqual(2, state.trailingTrivia!.count)
    XCTAssertEqual(state.byteSize,
      state.leadingTrivia!.byteSize + state.trailingTrivia!.byteSize
        + state.byteSizeAfterTrimmingTrivia)
    XCTAssertFalse(root.statements.isImplicit)

    // Test Node trivia setters and getters

    XCTAssertEqual(AbsolutePositionTests.leadingTrivia, root.leadingTrivia)
    XCTAssertEqual([], root.trailingTrivia)

    var modifiedRoot1 = root.withLeadingTrivia([.spaces(6), .tabs(1)])
    XCTAssertEqual([.spaces(6), .tabs(1)], modifiedRoot1.leadingTrivia)
    XCTAssertEqual(AbsolutePositionTests.leadingTrivia, root.leadingTrivia)
    modifiedRoot1.leadingTrivia = [.blockComment("/* this is a comment */")]
    XCTAssertEqual([.blockComment("/* this is a comment */")], modifiedRoot1.leadingTrivia)

    var modifiedRoot2 = root.withTrailingTrivia([.tabs(2)])
    XCTAssertEqual([.tabs(2)], modifiedRoot2.trailingTrivia)
    XCTAssertEqual([], root.trailingTrivia)
    modifiedRoot2.trailingTrivia = [.carriageReturns(1), .newlines(2)]
    XCTAssertEqual([.carriageReturns(1), .newlines(2)], modifiedRoot2.trailingTrivia)

    // Test Collection trivia setters and getters

    XCTAssertEqual(AbsolutePositionTests.leadingTrivia, root.statements.leadingTrivia)
    XCTAssertEqual(AbsolutePositionTests.trailingTrivia, root.statements.trailingTrivia)

    var modifiedStatements1 = root.withLeadingTrivia([.carriageReturnLineFeeds(3)])
    XCTAssertEqual([.carriageReturnLineFeeds(3)], modifiedStatements1.leadingTrivia)
    XCTAssertEqual(AbsolutePositionTests.leadingTrivia, root.statements.leadingTrivia)
    modifiedStatements1.leadingTrivia = [.unexpectedText("UNEXPECTED")]
    XCTAssertEqual([.unexpectedText("UNEXPECTED")], modifiedStatements1.leadingTrivia)

    var modifiedStatements2 = root.withTrailingTrivia([.formfeeds(1), .carriageReturns(3)])
    XCTAssertEqual([.formfeeds(1), .carriageReturns(3)], modifiedStatements2.trailingTrivia)
    XCTAssertEqual(AbsolutePositionTests.trailingTrivia, root.statements.trailingTrivia)
    modifiedStatements2.trailingTrivia = [.verticalTabs(4)]
    XCTAssertEqual([.verticalTabs(4)], modifiedStatements2.trailingTrivia)
  }

  public func testImplicit() {
    let root = self.createSourceFile(0)
    XCTAssertTrue(root.statements.isImplicit)
  }

  public func testWithoutSourceFileRoot() {
    let item = CodeBlockItemSyntax(
      item: Syntax(
        ReturnStmtSyntax(
          returnKeyword: .returnKeyword(leadingTrivia: .newline, trailingTrivia: .newline),
          expression: nil)
      ),
      semicolon: nil,
      errorTokens: nil)
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
    XCTAssertEqual(converter.position(ofLine: startLoc.line!, column: startLoc.column!),
      secondReturnStmt.positionAfterSkippingLeadingTrivia)

    let startLocBeforeTrivia =
      secondReturnStmt.startLocation(converter: converter,
        afterLeadingTrivia: false)
    XCTAssertEqual(startLocBeforeTrivia.line, 6)
    XCTAssertEqual(startLocBeforeTrivia.column, 1)
    XCTAssertEqual(converter.position(ofLine: startLocBeforeTrivia.line!, column: startLocBeforeTrivia.column!),
      secondReturnStmt.position)

    let endLoc = secondReturnStmt.endLocation(converter: converter)
    XCTAssertEqual(endLoc.line, 8)
    XCTAssertEqual(endLoc.column, 7)

    let endLocAfterTrivia =
      secondReturnStmt.endLocation(converter: converter,
        afterTrailingTrivia: true)
    XCTAssertEqual(endLocAfterTrivia.line, 11)
    XCTAssertEqual(endLocAfterTrivia.column, 1)

    XCTAssertTrue(converter.isValid(line: startLoc.line!, column: startLoc.column!))
    XCTAssertFalse(converter.isValid(line: startLoc.line!, column: startLoc.column!+50))
    XCTAssertFalse(converter.isValid(line: 0, column: startLoc.column!))
    XCTAssertTrue(converter.isValid(position: secondReturnStmt.position))
    XCTAssertFalse(converter.isValid(position: secondReturnStmt.position+SourceLength(utf8Length: 100)))
  }
}
