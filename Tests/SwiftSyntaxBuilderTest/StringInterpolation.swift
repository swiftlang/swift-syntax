//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import _SwiftSyntaxTestSupport
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftParser
import SwiftBasicFormat

import XCTest

class TwoSpacesFormat: BasicFormat {
  override var indentation: TriviaPiece {
    .spaces(indentationLevel * 2)
  }
}

final class StringInterpolationTests: XCTestCase {
  func testDeclInterpolation() {
    let funcSyntax: DeclSyntax =
      """
      func f(a: Int, b: Int) -> Int {
        a + b
      }
      """
    XCTAssertTrue(funcSyntax.is(FunctionDeclSyntax.self))
    XCTAssertEqual(funcSyntax.description,
      """
      func f(a: Int, b: Int) -> Int {
        a + b
      }
      """)
  }

  func testExprInterpolation() {
    let exprSyntax: ExprSyntax =
      """
      f(x + g(y), y.z)
      """
    XCTAssertTrue(exprSyntax.is(FunctionCallExprSyntax.self))

    let addIt: ExprSyntax = "w + \(exprSyntax)"
    XCTAssertTrue(addIt.is(SequenceExprSyntax.self))
  }

  func testStmtSyntax() {
    let collection: ExprSyntax = "[1, 2, 3, 4, 5]"
    let stmtSyntax: StmtSyntax = "for x in \(collection) { }"
    XCTAssertTrue(stmtSyntax.is(ForInStmtSyntax.self))
  }

  func testTypeInterpolation() {
    let tupleSyntax: TypeSyntax = "(Int, name: String)"
    XCTAssertTrue(tupleSyntax.is(TupleTypeSyntax.self))
    XCTAssertEqual(tupleSyntax.description, "(Int, name: String)")
    let fnTypeSyntax: TypeSyntax = "(String) async throws -> \(tupleSyntax)"
    XCTAssertTrue(fnTypeSyntax.is(FunctionTypeSyntax.self))
    XCTAssertEqual(fnTypeSyntax.description,
                   "(String) async throws -> (Int, name: String)")
  }

  func testPatternInterpolation() {
    let letPattern: PatternSyntax = "let x"
    XCTAssertTrue(letPattern.is(ValueBindingPatternSyntax.self))
  }

  func testStructGenerator() {
    let name = "Type"
    let id = 17

    let structNode: DeclSyntax =
       """
       struct \(name) {
         static var id = \(id)
       }
       """
    XCTAssertTrue(structNode.is(StructDeclSyntax.self))
  }

  func testSourceFile() {
    let _: SourceFileSyntax =
      """
      print("Hello, world!")
      """
  }


  func testRewriter() {
    let sourceFile = Parser.parse(source: """
      class Foo {
        func method() {}
      }
      """)
    class Rewriter: SyntaxRewriter {
      override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        let newFunc = DeclSyntax("func newName() {}")
          .withLeadingTrivia(node.leadingTrivia!)
          .withTrailingTrivia(node.trailingTrivia!)
        return DeclSyntax(newFunc)
      }
    }
    let rewrittenSourceFile = Rewriter().visit(sourceFile)
    XCTAssertEqual(rewrittenSourceFile.description, """
      class Foo {
        func newName() {}
      }
      """)
  }

  func testParserBuilderInStringInterpolation() {
    let cases = SwitchCaseList {
      for i in 0..<2 {
        SwitchCase("""
        case \(i):
          return \(i + 1)
        """)
      }
      SwitchCase("""
      default:
        return -1
      """)
    }
    let plusOne = FunctionDeclSyntax("""
    func plusOne(base: Int) -> Int {
      switch base {
      \(cases, format: TwoSpacesFormat())
      }
    }
    """)

    AssertStringsEqualWithDiff(plusOne.description.trimmingTrailingWhitespace(), """
    func plusOne(base: Int) -> Int {
      switch base {

      case 0:
        return 1
      case 1:
        return 2
      default:
        return -1
      }
    }
    """)
  }

  func testStringInterpolationInBuilder() {
    let ext = ExtensionDecl(extendedType: TypeSyntax("MyType")) {
      FunctionDecl(
      """
      ///
      /// Satisfies conformance to `SyntaxBuildable`.
      func buildSyntax(format: Format) -> Syntax {
        return Syntax(buildTest(format: format))
      }
      """
      )
    }
    AssertStringsEqualWithDiff(ext.formatted(using: TwoSpacesFormat()).description, """
      extension MyType {
        ///
        /// Satisfies conformance to `SyntaxBuildable`.
        func buildSyntax(format: Format) -> Syntax {
          return Syntax(buildTest(format: format))
        }
      }
      """)
  }
}
