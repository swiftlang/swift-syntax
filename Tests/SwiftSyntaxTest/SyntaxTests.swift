import XCTest
import SwiftSyntax

public class SyntaxAPITestCase: XCTestCase {

  public static let allTests = [
    ("testSyntaxAPI", testSyntaxAPI),
  ]

  public func testSyntaxAPI() {
    let source = "struct A { func f() {} }"
    let tree = try! SyntaxParser.parse(source: source)

    XCTAssertEqual("\(tree.firstToken!)", "struct ")
    XCTAssertEqual("\(tree.firstToken!.nextToken!)", "A ")
    let funcKW = tree.firstToken!.nextToken!.nextToken!.nextToken!
    XCTAssertEqual("\(funcKW)", "func ")
    XCTAssertEqual("\(funcKW.nextToken!.nextToken!.nextToken!.nextToken!.nextToken!.nextToken!)", "}")

    XCTAssertEqual(tree.lastToken!.tokenKind, .eof)
    XCTAssertEqual("\(funcKW.parent!.lastToken!)", "} ")
    XCTAssertEqual("\(funcKW.nextToken!.previousToken!)", "func ")
    XCTAssertEqual("\(funcKW.previousToken!)", "{ ")

    let toks = Array(funcKW.parent!.tokens)
    XCTAssertEqual(toks.count, 6)
    guard toks.count == 6 else {
      return
    }
    XCTAssertEqual("\(toks[0])", "func ")
    XCTAssertEqual("\(toks[1])", "f")
    XCTAssertEqual("\(toks[2])", "(")
    XCTAssertEqual("\(toks[3])", ") ")
    XCTAssertEqual("\(toks[4])", "{")
    XCTAssertEqual("\(toks[5])", "} ")

    let rtoks = Array(funcKW.parent!.tokens.reversed())
    XCTAssertEqual(rtoks.count, 6)
    guard rtoks.count == 6 else {
      return
    }
    XCTAssertEqual("\(rtoks[5])", "func ")
    XCTAssertEqual("\(rtoks[4])", "f")
    XCTAssertEqual("\(rtoks[3])", "(")
    XCTAssertEqual("\(rtoks[2])", ") ")
    XCTAssertEqual("\(rtoks[1])", "{")
    XCTAssertEqual("\(rtoks[0])", "} ")
  }
}
