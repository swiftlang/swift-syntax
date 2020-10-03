import XCTest
import SwiftSyntax

public class SyntaxConvenienceMethodsTests: XCTestCase {
  public func testFloatValues() {
    testFloatValue(text: "5.3_8", expectedValue: 5.38)
    testFloatValue(text: "12e3", expectedValue: 12000.0)
    testFloatValue(text: "32E1", expectedValue: 320.0)
    testFloatValue(text: "0xdEFACE.C0FFEEp+1", expectedValue: 0xdEFACE.C0FFEEp+1)
    testFloatValue(text: "0xaffab1e.e1fP-2", expectedValue: 0xaffab1e.e1fP-2)
    testFloatValue(text: "🥥", expectedValue: nil)
    // The following results in a valid FloatLiteralExprSyntax, but because Double.greatestFiniteMagnitude
    // is 1.7976931348623157e+308, floatLiteralValue should be nil.
    testFloatValue(text: "1.7976931348623157e+309", expectedValue: nil)
  }

  public func testIntegerValues() {
    testIntegerValue(text: "0b001100", expectedValue: 0b001100)
    testIntegerValue(text: "4_2", expectedValue: 42)
    testIntegerValue(text: "0o3434", expectedValue: 0o3434)
    testIntegerValue(text: "0xba11aD", expectedValue: 0xba11aD)
    testIntegerValue(text: "🐋", expectedValue: nil)
    // The following results in a valid IntegerLiteralExprSyntax, but because Int.max is
    // 9223372036854775807, integerLiteralValue should be nil.
    testIntegerValue(text: "9223372036854775808", expectedValue: nil)
  }
}

fileprivate func testFloatValue(text: String, expectedValue: Double?) {
  let digits = SyntaxFactory.makeFloatingLiteral(text)

  let literalExpr = SyntaxFactory.makeFloatLiteralExpr(floatingDigits: digits)
  if let expectedValue = expectedValue {
    XCTAssertEqual(literalExpr.floatLiteralValue!, expectedValue)
  } else {
    XCTAssertNil(literalExpr.floatLiteralValue)
  }
}

fileprivate func testIntegerValue(text: String, expectedValue: Int?) {
  let digits = SyntaxFactory.makeIntegerLiteral(text)

  let literalExpr = SyntaxFactory.makeIntegerLiteralExpr(digits: digits)
  if let expectedValue = expectedValue {
    XCTAssertEqual(literalExpr.integerLiteralValue!, expectedValue)
  } else {
    XCTAssertNil(literalExpr.integerLiteralValue)
  }
}
