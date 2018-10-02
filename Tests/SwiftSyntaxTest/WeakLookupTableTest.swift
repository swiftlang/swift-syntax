#if DEBUG // @testable import

import XCTest
@testable import SwiftSyntax

final class MinimalNode : Identifiable {
  let id: String
  let children: [MinimalNode?]
  init(id: String, children: [MinimalNode?]) {
    self.id = id
    self.children = children
  }
}

func createNode(
  _ table: WeakLookupTable<MinimalNode>,
  _ id: String,
  _ children: [MinimalNode?] = []
) -> MinimalNode {
  let node = MinimalNode(id: id, children: children)
  XCTAssertTrue(table.insert(node))
  return node
}

public class WeakLookupTableTestCase: XCTestCase {

  public static let allTests = [
    ("testBasic", testBasic),
  ]

  func testBasic() {
    let table = WeakLookupTable<MinimalNode>()
    var tree: MinimalNode? = nil

    // ------------------------------------------------------------------------
    // Initial.
    tree = createNode(table, "root1", [
      createNode(table, "1", [
        createNode(table, "1-1"),
        createNode(table, "1-2"),
        createNode(table, "1-3"),
      ]),
      createNode(table, "2", [
        createNode(table, "2-1"),
        nil,
        createNode(table, "2-2"),
      ]),
      createNode(table, "3"),
    ])

    XCTAssertNil(table["notexist"])

    XCTAssertNotNil(table["root1"])
    XCTAssertNotNil(table["1"])
    XCTAssertNotNil(table["1-1"])
    XCTAssertNotNil(table["1-2"])
    XCTAssertNotNil(table["1-3"])
    XCTAssertNotNil(table["2"])
    XCTAssertNotNil(table["2-1"])
    XCTAssertNotNil(table["2-2"])
    XCTAssertNotNil(table["3"])

    // ------------------------------------------------------------------------
    // Partially replaced.
    tree = createNode(table, "root2", [
      table["1"],
      createNode(table, "4", [
        table["2-1"],
        nil,
        createNode(table, "4-3")
      ]),
      table["3"],
    ])

    // Reused nodes.
    XCTAssertNotNil(table["1"])
    XCTAssertNotNil(table["1-1"])
    XCTAssertNotNil(table["1-2"])
    XCTAssertNotNil(table["1-3"])
    XCTAssertNotNil(table["2-1"])
    XCTAssertNotNil(table["3"])

    // Newly added nodes.
    XCTAssertNotNil(table["root2"])
    XCTAssertNotNil(table["4"])
    XCTAssertNotNil(table["4-3"])

    // Destroyed nodes.
    XCTAssertNil(table["root1"])
    XCTAssertNil(table["2"])
    XCTAssertNil(table["2-2"])

    // ------------------------------------------------------------------------
    // Completely replaced.
    tree = createNode(table, "empty")

    XCTAssertNotNil(table["empty"])

    XCTAssertNil(table["root2"])
    XCTAssertNil(table["1"])
    XCTAssertNil(table["1-1"])
    XCTAssertNil(table["1-2"])
    XCTAssertNil(table["1-3"])
    XCTAssertNil(table["2-1"])
    XCTAssertNil(table["3"])
    XCTAssertNil(table["4"])
    XCTAssertNil(table["4-3"])

    _ = tree // Prevents 'never read' warning
  }

  func testSameIdentifierDifferentObject() {
    let table = WeakLookupTable<MinimalNode>()

    let object1 = MinimalNode(id: "1", children: [])
    let object2 = MinimalNode(id: "1", children: [])

    XCTAssertTrue(table.insert(object1))
    XCTAssert(table["1"] === object1)
    XCTAssertFalse(table.insert(object2))
    XCTAssert(table["1"] === object1)
  }
}

#endif // DEBUG
