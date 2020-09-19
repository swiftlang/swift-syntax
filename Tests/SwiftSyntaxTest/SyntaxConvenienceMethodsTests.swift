import XCTest
import SwiftSyntax

public class SyntaxConvenienceMethodsTests: XCTestCase {

  public func testFloatingValues() {
    testFloatingValue(text: "5.3_8", expectedValue: 5.38)
    testFloatingValue(text: "12e3", expectedValue: 12000.0)
    testFloatingValue(text: "32E1", expectedValue: 320.0)
    testFloatingValue(text: "0xdEFACE.C0FFEEp+1", expectedValue: 0xdEFACE.C0FFEEp+1)
    testFloatingValue(text: "0xaffab1e.e1fP-2", expectedValue: 0xaffab1e.e1fP-2)
    testFloatingValue(text: "🥥", expectedValue: nil)
  }

  public func testIntegerValues() {
    testIntegerValue(text: "0b001100", expectedValue: 0b001100)
    testIntegerValue(text: "4_2", expectedValue: 42)
    testIntegerValue(text: "0o3434", expectedValue: 0o3434)
    testIntegerValue(text: "0xba11aD", expectedValue: 0xba11aD)
    testIntegerValue(text: "🐋", expectedValue: nil)
  }
}

fileprivate func testFloatingValue(text: String, expectedValue: Double?) {
  let digits = SyntaxFactory.makeFloatingLiteral(text)
  let literalExpr = SyntaxFactory.makeFloatLiteralExpr(floatingDigits: digits)
  if let expectedValue = expectedValue {
    XCTAssertEqual(literalExpr!.floatingValue, expectedValue)
  } else {
    XCTAssertNil(literalExpr)
  }
}

fileprivate func testIntegerValue(text: String, expectedValue: Int?) {
  let digits = SyntaxFactory.makeIntegerLiteral(text)
  let literalExpr = SyntaxFactory.makeIntegerLiteralExpr(digits: digits)
  if let expectedValue = expectedValue {
    XCTAssertEqual(literalExpr!.integerValue, expectedValue)
  } else {
    XCTAssertNil(literalExpr)
  }
}