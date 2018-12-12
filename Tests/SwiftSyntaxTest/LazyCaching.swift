import XCTest
import SwiftSyntax

public class LazyCachingTestCase: XCTestCase {

  public static let allTests = [
    ("testPathological", disabledtestPathological),
    ("testTwoAccesses", disabledtestTwoAccesses),
  ]

  // FIXME: re-enable this test when syntax nodes are thread safe
  public func disabledtestPathological() {
    let tuple = SyntaxFactory.makeVoidTupleType()

    DispatchQueue.concurrentPerform(iterations: 100) { _ in
      XCTAssertEqual(tuple.leftParen, tuple.leftParen)
    }
  }

  // FIXME: re-enable this test when syntax nodes are thread safe
  public func disabledtestTwoAccesses() {
    let tuple = SyntaxFactory.makeVoidTupleType()

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
