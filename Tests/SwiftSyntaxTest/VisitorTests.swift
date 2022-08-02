import XCTest
import SwiftSyntax

public class VisitorTests: XCTestCase {
  public func testVisitMissingNodes() throws {
    let node = SyntaxFactory.makeDeclarationStmt(declaration: DeclSyntax(SyntaxFactory.makeBlankMissingDecl()))

    class MissingDeclChecker: SyntaxVisitor {
      var didSeeMissingDeclSyntax = false

      override func visit(_ node: MissingDeclSyntax) -> SyntaxVisitorContinueKind {
        didSeeMissingDeclSyntax = true
        return .visitChildren
      }

      static func check(_ tree: SyntaxProtocol, viewMode: SyntaxTreeViewMode) -> Bool {
        let visitor = MissingDeclChecker(viewMode: viewMode)
        visitor.walk(tree)
        return visitor.didSeeMissingDeclSyntax
      }
    }

    XCTAssertFalse(MissingDeclChecker.check(node, viewMode: .sourceAccurate))
    XCTAssertTrue(MissingDeclChecker.check(node, viewMode: .fixedUp))
  }
}
