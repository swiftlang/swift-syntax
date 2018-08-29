import XCTest
import SwiftSyntax

struct Foo {
  public let x: Int
  private(set) var y: [Bool]
}

#if os(macOS)
class Test: NSObject {
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
  public func testParseSingleFile() {
    let currentFile = URL(fileURLWithPath: #file)
    XCTAssertNoThrow(try {
      let currentFileContents = try String(contentsOf: currentFile)
      let parsed = try SourceFileSyntax.parse(currentFile)
      XCTAssertEqual("\(parsed)", currentFileContents)
    }())
  }
}
