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

public class ParseFileTestCase: XCTestCase {

  public static let allTests = [
    ("testParseSingleFile", testParseSingleFile)
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
}
