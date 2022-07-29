import XCTest
import SwiftSyntax
import SwiftSyntaxParser

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

public class ParseFileTests: XCTestCase {

  public func testParseSingleFile() {
    let currentFile = URL(fileURLWithPath: #file)
    XCTAssertNoThrow(try {
      let fileContents = try String(contentsOf: currentFile)
      let parsed = try SyntaxParser.parse(currentFile)
      XCTAssertEqual("\(parsed)", fileContents)
      try SyntaxVerifier.verify(Syntax(parsed))
    }())
  }

  public func testEnumCaseStructure() {
    class Visitor: SyntaxVisitor {
      var cases: [EnumCaseDeclSyntax] = []
      override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        cases.append(contentsOf: node.members.members.compactMap {
          $0.decl.as(EnumCaseDeclSyntax.self)
        })
        return .skipChildren
      }
    }
    let v = Visitor(viewMode: .fixedUp)
    let currentFile = URL(fileURLWithPath: #file)
    let parsed = try! SyntaxParser.parse(currentFile)
    v.walk(parsed)
    XCTAssertEqual(v.cases.count, 2)
  }
}
