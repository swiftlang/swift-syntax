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

  public func testVisitGarbage() throws {
    // This is just bunch of garbage
    let garbageReturnStmt = SyntaxFactory.makeReturnStmt(
      garbage: SyntaxFactory.makeGarbageNodes([Syntax(SyntaxFactory.makeToken(.identifier("starting"), presence: .present)), Syntax(SyntaxFactory.makeToken(.identifier("garbage"), presence: .present))]),
      returnKeyword: SyntaxFactory.makeReturnKeyword(trailingTrivia: [.spaces(1)]),
      garbage: SyntaxFactory.makeGarbageNodes([Syntax(SyntaxFactory.makeToken(.identifier("middle"), presence: .present))]),
      expression: ExprSyntax(SyntaxFactory.makeNilLiteralExpr(garbage: SyntaxFactory.makeGarbageNodes([Syntax(SyntaxFactory.makeToken(.identifier("end"), presence: .present))]), nilKeyword: SyntaxFactory.makeToken(.nilKeyword, presence: .present)))
    )

    // This is more real-world where the user wrote null instead of nil.
    let misspelledNil = SyntaxFactory.makeReturnStmt(
      returnKeyword: SyntaxFactory.makeReturnKeyword(trailingTrivia: [.spaces(1)]),
      expression: ExprSyntax(SyntaxFactory.makeNilLiteralExpr(garbage: SyntaxFactory.makeGarbageNodes([Syntax(SyntaxFactory.makeToken(.identifier("null"), presence: .present))]), nilKeyword: SyntaxFactory.makeToken(.nilKeyword, presence: .missing)))
    )

    // Test SyntaxVisitor
    class TreePrinter: SyntaxVisitor {
      var out = ""

      override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
        out += node.leadingTrivia.description
        out += node.text
        out += node.trailingTrivia.description
        return .visitChildren
      }

      static func print(_ tree: SyntaxProtocol, viewMode: SyntaxTreeViewMode) -> String {
        let printer = TreePrinter(viewMode: viewMode)
        printer.walk(tree)
        return printer.out
      }
    }

    XCTAssertEqual(TreePrinter.print(garbageReturnStmt, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(TreePrinter.print(garbageReturnStmt, viewMode: .sourceAccurate), "startinggarbagereturn middleendnil")

    XCTAssertEqual(TreePrinter.print(misspelledNil, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(TreePrinter.print(misspelledNil, viewMode: .sourceAccurate), "return null")

    // Test SyntaxAnyVisitor
    class AnyTreePrinter: SyntaxAnyVisitor {
      var out = ""

      override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        if let token = node.as(TokenSyntax.self) {
          out += token.leadingTrivia.description
          out += token.text
          out += token.trailingTrivia.description
        }
        return .visitChildren
      }


      static func print(_ tree: SyntaxProtocol, viewMode: SyntaxTreeViewMode) -> String {
        let printer = TreePrinter(viewMode: viewMode)
        printer.walk(tree)
        return printer.out
      }
    }

    XCTAssertEqual(AnyTreePrinter.print(garbageReturnStmt, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(AnyTreePrinter.print(garbageReturnStmt, viewMode: .sourceAccurate), "startinggarbagereturn middleendnil")

    XCTAssertEqual(AnyTreePrinter.print(misspelledNil, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(AnyTreePrinter.print(misspelledNil, viewMode: .sourceAccurate), "return null")

    // Test SyntaxRewriter
    class RewritingTreePrinter: SyntaxRewriter {
      var out = ""

      override func visit(_ node: TokenSyntax) -> Syntax {
        out += node.leadingTrivia.description
        out += node.text
        out += node.trailingTrivia.description
        return Syntax(node)
      }


      static func print(_ tree: SyntaxProtocol, viewMode: SyntaxTreeViewMode) -> String {
        let printer = TreePrinter(viewMode: viewMode)
        printer.walk(tree)
        return printer.out
      }
    }

    XCTAssertEqual(RewritingTreePrinter.print(garbageReturnStmt, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(RewritingTreePrinter.print(garbageReturnStmt, viewMode: .sourceAccurate), "startinggarbagereturn middleendnil")

    XCTAssertEqual(RewritingTreePrinter.print(misspelledNil, viewMode: .fixedUp), "return nil")
    XCTAssertEqual(RewritingTreePrinter.print(misspelledNil, viewMode: .sourceAccurate), "return null")
  }
}
