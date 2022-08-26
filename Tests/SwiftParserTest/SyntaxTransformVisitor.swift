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
  public func testFunctionCounter() {
    struct FuncCounter: SyntaxTransformVisitor {
      public func visit(_ node: FunctionDeclSyntax) -> [Int] {
        return [visitChildren(node).reduce(1, +)]
      }
    }
    XCTAssertNoThrow(try {
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
      XCTAssertEqual(count.first!, 4)
    }())
  }
  
  public func testStringify() {
    struct Stringify: SyntaxTransformVisitor {
      public func visitType(_ paramType: TypeSyntaxProtocol) -> String? {
        if let id = SimpleTypeIdentifierSyntax(Syntax(fromProtocol: paramType)) {
          return visit(id).first ?? "<Unknown>"
        }
        if let arr = ArrayTypeSyntax(Syntax(fromProtocol: paramType)) {
          return visit(arr).first ?? "<Unknown>"
        }
        return "<Unknown>"
      }
      
      public func visit(_ node: FunctionDeclSyntax) -> [String] {
        let argStrings = node.signature.input.parameterList
          .compactMap { $0.type }
          .compactMap(visitType)
        
        let resultString: String
        if let out = node.signature.output {
          resultString = visitType(out.returnType) ?? "<Unknown>"
        } else {
          resultString = "Void"
        }
        
        return ["(" + argStrings.joined(separator: ", ") + ") -> " + resultString]
      }
      
      public func visit(_ node: SimpleTypeIdentifierSyntax) -> [String] {
        [node.name.text]
      }

      public func visit(_ node: ArrayTypeSyntax) -> [String] {
        if let type = visitType(node.elementType) {
          return ["[" + type + "]"]
        }
        return ["[Unknown]"]
      }
    }
    XCTAssertNoThrow(try {
      let parsed = try Parser.parse(source: """
          func foo(a: Int, b: Foo, c: [Int]) -> Result {
          }
          """)
      let stringified = Stringify().visit(parsed)
      XCTAssertEqual(stringified.first!, "(Int, Foo, [Int]) -> Result")
    }())
    XCTAssertNoThrow(try {
      let parsed = try Parser.parse(source: """
          func foo() {
          }
          """)
      let stringified = Stringify().visit(parsed)
      XCTAssertEqual(stringified.first!, "() -> Void")
    }())
    XCTAssertNoThrow(try {
      let parsed = try Parser.parse(source: """
          func foo(a: Int) -> [Result] {
          }
          """)
      let stringified = Stringify().visit(parsed)
      XCTAssertEqual(stringified.first!, "(Int) -> [Result]")
    }())
  }
}
