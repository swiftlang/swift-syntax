import XCTest
import SwiftSyntax

fileprivate struct Foo {
  public let x: Int
  private(set) var y: [Bool]
}

#if os(macOS)
fileprivate class Test: NSObject {
  @objc var bar: Int = 0
  func test() {
    print(#selector(function))
    print(#keyPath(bar))
  }
  @objc func function() {
  }
}
#endif

enum Animal {
  case cat
  case dog
}

public class ParseFileTestCase: XCTestCase {

  public static let allTests = [
    ("testParseSingleFile", testParseSingleFile),
    ("testEnumCaseStructure", testEnumCaseStructure)
  ]

  public func testParseSingleFile() {
    let currentFile = URL(fileURLWithPath: #file)
    XCTAssertNoThrow(try {
      let fileContents = try String(contentsOf: currentFile)
      let parsed = try SyntaxParser.parse(currentFile)
      XCTAssertEqual("\(parsed)", fileContents)
      try SyntaxVerifier.verify(parsed)
    }())
  }

  public func testEnumCaseStructure() {
    class Visitor: SyntaxVisitor {
      var cases: [EnumCaseDeclSyntax] = []
      func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        cases.append(contentsOf: node.members.members.compactMap {
          ($0 as MemberDeclListItemSyntax).decl as? EnumCaseDeclSyntax
        })
        return .skipChildren
      }
    }
    var v = Visitor()
    let currentFile = URL(fileURLWithPath: #file)
    let parsed = try! SyntaxParser.parse(currentFile)
    parsed.walk(&v)
    XCTAssertEqual(v.cases.count, 2)
  }
}
