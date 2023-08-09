//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftParser
@_spi(SyntaxTransformVisitor) import SwiftSyntax

final class SyntaxTransformVisitorTest: XCTestCase {
  public func testFunctionCounter() {
    struct FuncCounter: SyntaxTransformVisitor {
      public func visitAny(_ node: Syntax) -> Int {
        visitChildren(node).reduce(0, +)
      }

      public func visit(_ node: FunctionDeclSyntax) -> Int {
        visitChildren(node).reduce(1, +)
      }
    }
    _ = {
      let parsed = Parser.parse(
        source: """
          func foo() {
            public func foo() {
              func foo() {
                /*Unknown token */0xG
              }
              func bar() {
                /*Unknown token */0xG
              }
            }
          }
          """
      )
      let count = FuncCounter().visit(parsed)
      XCTAssertEqual(count, 4)
    }()
  }

  public func testPrintFunctionType() {
    /// Assuming there is a single functioned declaration in the source file, print the type of that function.
    struct PrintFunctionType: SyntaxTransformVisitor {
      func visitAny(_ node: SwiftSyntax.Syntax) -> String {
        fatalError("Not implemented")
      }

      public func visit(_ node: CodeBlockItemSyntax) -> String { visit(node.item) }

      public func visit(_ node: SourceFileSyntax) -> String {
        assert(node.statements.count == 1)
        return visit(node.statements.first!.item)
      }

      public func visit(_ node: FunctionDeclSyntax) -> String {
        let argStrings = node.signature.parameterClause.parameters
          .compactMap { $0.type }
          .compactMap(visit)

        let resultString: String
        if let returnClause = node.signature.returnClause {
          resultString = visit(returnClause.type)
        } else {
          resultString = "Void"
        }

        return "(" + argStrings.joined(separator: ", ") + ") -> " + resultString
      }

      public func visit(_ node: IdentifierTypeSyntax) -> String {
        node.name.text
      }

      public func visit(_ node: ArrayTypeSyntax) -> String {
        "[" + visit(node.element) + "]"
      }
    }
    _ = {
      let parsed = Parser.parse(
        source: """
          func foo(a: Int, b: Foo, c: [Int]) -> Result {
          }
          """
      )
      let stringified = PrintFunctionType().visit(parsed)
      XCTAssertEqual(stringified, "(Int, Foo, [Int]) -> Result")
    }()
    _ = {
      let parsed = Parser.parse(
        source: """
          func foo() {
          }
          """
      )
      let stringified = PrintFunctionType().visit(parsed)
      XCTAssertEqual(stringified, "() -> Void")
    }()
    _ = {
      let parsed = Parser.parse(
        source: """
          func foo(a: Int) -> [Result] {
          }
          """
      )
      let stringified = PrintFunctionType().visit(parsed)
      XCTAssertEqual(stringified, "(Int) -> [Result]")
    }()
  }
}
