import XCTest
import SwiftSyntax

public class SyntaxConvenienceMethodsTestCase: XCTestCase {

  public static let allTests = [
    ("testFloatingValue", testFloatingValue),
    ("testIntegerValue", testIntegerValue),
  ]

  public func testFloatingValue() {
    let digits = SyntaxFactory.makeFloatingLiteral("5.38")
    let literalExpr = SyntaxFactory.makeFloatLiteralExpr(floatingDigits: digits)
    XCTAssertEqual(literalExpr.floatingValue, 5.38)
  }

  public func testIntegerValue() {
    let digits = SyntaxFactory.makeIntegerLiteral("42")
    let literalExpr = SyntaxFactory.makeIntegerLiteralExpr(digits: digits)
    XCTAssertEqual(literalExpr.integerValue, 42)
  }
}
