import XCTest
import SwiftSyntax
import _SwiftSyntaxTestSupport

public class SyntaxChildrenTests: XCTestCase {

  public func testIterateWithAllPresent() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .returnKeyword(),
      expression: ExprSyntax(UnknownExprSyntax()))

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&iterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    try XCTAssertNext(&iterator) { $0.is(ExprSyntax.self) }
    XCTAssertNextIsNil(&iterator)
  }

  public func testIterateWithSomeMissing() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .returnKeyword(),
      expression: nil)

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&iterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    XCTAssertNextIsNil(&iterator)
  }

  public func testIterateWithAllMissing() {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: TokenSyntax.returnKeyword(presence: .missing),
      expression: nil
    )

    var iterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    XCTAssertNextIsNil(&iterator)
  }

  public func testMissingTokens() throws {
    let returnStmt = ReturnStmtSyntax(
      returnKeyword: .returnKeyword(presence: .missing),
      expression: nil
    )

    var sourceAccurateIterator = returnStmt.children(viewMode: .sourceAccurate).makeIterator()
    XCTAssertNextIsNil(&sourceAccurateIterator)

    var fixedUpIterator = returnStmt.children(viewMode: .fixedUp).makeIterator()
    try XCTAssertNext(&fixedUpIterator) { $0.as(TokenSyntax.self)?.tokenKind == .returnKeyword }
    XCTAssertNextIsNil(&fixedUpIterator)
  }

  public func testMissingNodes() throws {
    let node = DeclarationStmtSyntax(declaration: DeclSyntax(MissingDeclSyntax(
      attributes: nil,
      modifiers: nil
    )))

    var sourceAccurateIt = node.children(viewMode: .sourceAccurate).makeIterator()
    try XCTAssertNext(&sourceAccurateIt) { $0.is(MissingDeclSyntax.self) }
    
    var fixedUpIt = node.children(viewMode: .fixedUp).makeIterator()
    try XCTAssertNext(&fixedUpIt) { $0.is(MissingDeclSyntax.self) }
  }
}
