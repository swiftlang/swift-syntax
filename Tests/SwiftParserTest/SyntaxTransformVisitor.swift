//
//  SyntaxTransformVisitor.swift
//  
//
//  Created by Zoe Carver on 8/25/22.
//

import XCTest
import SwiftParser
import SwiftSyntax

final class SyntaxTransformVisitorTest: XCTestCase {
  public func testFunctionCounter() throws {
    struct FuncCounter: SyntaxTransformVisitor {
      public func visitAny(_ node: Syntax) -> Int {
        visitChildren(node).reduce(0, +)
      }
 
      public func visit(_ node: FunctionDeclSyntax) -> Int {
        visitChildren(node).reduce(1, +)
      }
    }
    _ = try {
      let parsed = try Parser.parse(source: """
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
          """)
      let count = FuncCounter().visit(parsed)
      XCTAssertEqual(count, 4)
    }()
  }
  
  public func testPrintFunctionType() throws {
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
        let argStrings = node.signature.input.parameterList
          .compactMap { $0.type }
          .compactMap(visit)
        
        let resultString: String
        if let out = node.signature.output {
          resultString = visit(out.returnType)
        } else {
          resultString = "Void"
        }
        
        return "(" + argStrings.joined(separator: ", ") + ") -> " + resultString
      }
      
      public func visit(_ node: SimpleTypeIdentifierSyntax) -> String {
        node.name.text
      }

      public func visit(_ node: ArrayTypeSyntax) -> String {
          "[" + visit(node.elementType) + "]"
      }
    }
    _ = try {
      let parsed = try Parser.parse(source: """
          func foo(a: Int, b: Foo, c: [Int]) -> Result {
          }
          """)
      let stringified = PrintFunctionType().visit(parsed)
      XCTAssertEqual(stringified, "(Int, Foo, [Int]) -> Result")
    }()
    _ = try {
      let parsed = try Parser.parse(source: """
          func foo() {
          }
          """)
      let stringified = PrintFunctionType().visit(parsed)
      XCTAssertEqual(stringified, "() -> Void")
    }()
    _ = try {
      let parsed = try Parser.parse(source: """
          func foo(a: Int) -> [Result] {
          }
          """)
      let stringified = PrintFunctionType().visit(parsed)
      XCTAssertEqual(stringified, "(Int) -> [Result]")
    }()
  }
}
