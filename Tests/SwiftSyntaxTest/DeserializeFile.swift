import XCTest
import SwiftSyntax

public class DecodeSyntaxTestCase: XCTestCase {

  public static let allTests = [
    ("testBasic", testBasic),
  ]

  public func testBasic() {
    XCTAssertNoThrow(try {
      let inputFile = getInput("visitor.swift")
      let source = try String(contentsOf: inputFile)
      let parsed = try SyntaxTreeParser.parse(inputFile)
      XCTAssertEqual("\(parsed)", source)
    }())
  }

  public func testIncrementalDeserialize() {
    XCTAssertNoThrow(try {
      let deserializer = SyntaxTreeDeserializer()
      var tree: SourceFileSyntax? = nil
      let responses = try (1...3).map {
        try Data(contentsOf: getInput("incremental-deserialize-\($0).json"))
      }
      for data in responses {
        tree = try deserializer.deserialize(data, serializationFormat: .json)
      }
      XCTAssertEqual(tree?.description, "x\ny")
    }())
  }
}
