import XCTest
import SwiftSyntax
import _SwiftSyntaxTestSupport

public class SyntaxChildrenTests: XCTestCase {

  public func testIterateWithAllPresent() throws {
    let returnStmt = SyntaxFactory.makeReturnStmt(
      returnKeyword: SyntaxFactory.makeReturnKeyword(),
      expression: ExprSyntax(SyntaxFactory.makeBlankUnknownExpr()))

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&iterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    try XCTAssertNext(&iterator) { $0.is(ExprSyntax.self) }
    XCTAssertNextIsNil(&iterator)
  }

  public func testIterateWithSomeMissing() throws {
    let returnStmt = SyntaxFactory.makeReturnStmt(
      returnKeyword: SyntaxFactory.makeReturnKeyword(),
      expression: nil)

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&iterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    XCTAssertNextIsNil(&iterator)
  }

  public func testIterateWithAllMissing() {
    let returnStmt = SyntaxFactory.makeBlankReturnStmt()

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    XCTAssertNextIsNil(&iterator)
  }

  public func testMissingTokens() throws {
    let returnStmt = SyntaxFactory.makeReturnStmt(
      returnKeyword: SyntaxFactory.makeToken(.returnKeyword, presence: .missing),
      expression: nil
    )

    var sourceAccurateIterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    XCTAssertNextIsNil(&sourceAccurateIterator)

    var fixedUpIterator = returnStmt.children(viewMode: .fixedUp).makeIterator()
    try XCTAssertNext(&fixedUpIterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    XCTAssertNextIsNil(&fixedUpIterator)
  }
}
