import XCTest
@_spi(RawSyntax) import SwiftSyntax


public class MultithreadingTests: XCTestCase {

  public func testPathological() {
    let tuple = TupleTypeSyntax(
      leftParen: .leftParenToken(),
      elements: TupleTypeElementListSyntax([]),
      rightParen: .rightParenToken()
    )

    DispatchQueue.concurrentPerform(iterations: 100) { _ in
      XCTAssertEqual(tuple.leftParen, tuple.leftParen)
    }
  }

  public func testConcurrentArena() {
    let arena = SyntaxArena()

    DispatchQueue.concurrentPerform(iterations: 100) { i in
      var identStr = " ident\(i) "
      let tokenRaw = identStr.withSyntaxText { text in
        RawTokenSyntax(
          kind: .identifier,
          wholeText: arena.intern(text),
          textRange: 1..<(text.count-1),
          presence: .present,
          arena: arena)
      }
      let identifierExprRaw = RawIdentifierExprSyntax(
        identifier: tokenRaw,
        declNameArguments: nil,
        arena: arena)

      let expr = Syntax(raw: RawSyntax(identifierExprRaw)).as(IdentifierExprSyntax.self)!
      XCTAssertEqual(expr.identifier.text, "ident\(i)")
    }
  }

  public func testTwoAccesses() {
    let tuple = TupleTypeSyntax(
      leftParen: .leftParenToken(),
      elements: TupleTypeElementListSyntax([]),
      rightParen: .rightParenToken()
    )

    let queue1 = DispatchQueue(label: "queue1")
    let queue2 = DispatchQueue(label: "queue2")

    var node1: TokenSyntax?
    var node2: TokenSyntax?

    let group = DispatchGroup()
    queue1.async(group: group) {
      node1 = tuple.leftParen
    }
    queue2.async(group: group) {
      node2 = tuple.leftParen
    }
    group.wait()

    let final = tuple.leftParen

    XCTAssertNotNil(node1)
    XCTAssertNotNil(node2)
    XCTAssertEqual(node1, node2)
    XCTAssertEqual(node1, final)
    XCTAssertEqual(node2, final)
  }

}
