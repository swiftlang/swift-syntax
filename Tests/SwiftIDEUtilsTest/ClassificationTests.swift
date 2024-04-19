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

import SwiftIDEUtils
import SwiftParser
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

class ClassificationTests: XCTestCase {

  public func testClassification() {
    assertClassification(
      """
      // blah.
      let x/*yo*/ = 0
      """,
      expected: [
        ClassificationSpec(source: "// blah.", kind: .lineComment),
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "/*yo*/", kind: .blockComment),
        ClassificationSpec(source: "0", kind: .integerLiteral),
      ]
    )

    assertClassification(
      "x/*yo*/ ",
      in: Range(position: AbsolutePosition(utf8Offset: 1), length: SourceLength(utf8Length: 6)),
      expected: [
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "/*yo*/", kind: .blockComment),
      ]
    )
  }

  public func testClassificationInCertainRange() {
    assertClassification(
      """
      // blah.
      let x/*yo*/ = 0
      """,
      in: Range(position: AbsolutePosition(utf8Offset: 7), length: SourceLength(utf8Length: 8)),
      expected: [
        ClassificationSpec(source: "// blah.", kind: .lineComment),
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "/*yo*/", kind: .blockComment),
      ]
    )
  }

  public func testClassificationInEmptyRange() {
    assertClassification(
      """
      // blah.
      let x/*yo*/ = 0
      """,
      in: Range(position: AbsolutePosition(utf8Offset: 21), length: SourceLength(utf8Length: 2)),
      expected: []
    )
  }

  public func testClassificationAt() throws {
    let tree = Parser.parse(source: "func foo /* a */() {}")

    let keyword = try XCTUnwrap(tree.classification(at: AbsolutePosition(utf8Offset: 3)))
    XCTAssertEqual(keyword.kind, .keyword)
    XCTAssertEqual(keyword.range, Range(position: AbsolutePosition(utf8Offset: 0), length: SourceLength(utf8Length: 4)))

    let identifier = try XCTUnwrap(tree.classification(at: AbsolutePosition(utf8Offset: 6)))
    XCTAssertEqual(identifier.kind, .identifier)
    XCTAssertEqual(
      identifier.range,
      Range(position: AbsolutePosition(utf8Offset: 5), length: SourceLength(utf8Length: 3))
    )
  }

  public func testTokenClassification() {
    assertClassification(
      """
      let x: Int
      """,
      expected: [
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "Int", kind: .type),
      ]
    )
  }

  public func testOperatorTokenClassification() {
    assertClassification(
      """
        let x: Int = 4 + 5 / 6
      """,
      expected: [
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "Int", kind: .type),
        ClassificationSpec(source: "4", kind: .integerLiteral),
        ClassificationSpec(source: "+", kind: .operator),
        ClassificationSpec(source: "5", kind: .integerLiteral),
        ClassificationSpec(source: "/", kind: .operator),
        ClassificationSpec(source: "6", kind: .integerLiteral),
      ]
    )

    assertClassification(
      "infix operator *--*",
      expected: [
        ClassificationSpec(source: "infix", kind: .keyword),
        ClassificationSpec(source: "operator", kind: .keyword),
        ClassificationSpec(source: "*--*", kind: .operator),
      ]
    )
  }

  public func testFuncDeclaration() {
    assertClassification(
      """
      func foo(x: Int, y: Int) -> Int { return x + y }
      """,
      expected: [
        ClassificationSpec(source: "func", kind: .keyword),
        ClassificationSpec(source: "foo", kind: .identifier),
        ClassificationSpec(source: "x", kind: .argumentLabel),
        ClassificationSpec(source: "Int", kind: .type),
        ClassificationSpec(source: "y", kind: .argumentLabel),
        ClassificationSpec(source: "Int", kind: .type),
        ClassificationSpec(source: "Int", kind: .type),
        ClassificationSpec(source: "return", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "+", kind: .operator),
        ClassificationSpec(source: "y", kind: .identifier),
      ]
    )
  }

  public func testDocCommentLine() {
    assertClassification(
      """
      /// Brief.
      ///
      /// Simple case.
      ///
      /// - parameter x: A number
      /// - parameter y: Another number
      /// - returns: single-line, 2 spaces
      """,
      expected: [
        ClassificationSpec(source: "/// Brief.", kind: .docLineComment),
        ClassificationSpec(source: "///", kind: .docLineComment),
        ClassificationSpec(source: "/// Simple case.", kind: .docLineComment),
        ClassificationSpec(source: "///", kind: .docLineComment),
        ClassificationSpec(source: "/// - parameter x: A number", kind: .docLineComment),
        ClassificationSpec(source: "/// - parameter y: Another number", kind: .docLineComment),
        ClassificationSpec(source: "/// - returns: single-line, 2 spaces", kind: .docLineComment),
      ]
    )
  }

  public func testDocCommentBlock() {
    let docCommentBlock =
      """
      /**
        Does pretty much nothing.

        Not a parameter list: improper indentation.
          - Parameters: sdfadsf

        - WARNING: - WARNING: Should only have one field

        - $$$: Not a field.

        Empty field, OK:
      */
      """
    assertClassification(
      docCommentBlock,
      expected: [
        ClassificationSpec(source: docCommentBlock, kind: .docBlockComment)
      ]
    )
  }

  public func testEmptyDocBlockComment() {
    assertClassification(
      "/***/",
      expected: [
        ClassificationSpec(source: "/***/", kind: .docBlockComment)
      ]
    )
  }

  public func testPlaygoundCommentLine() {
    assertClassification(
      "//: playground doc comment line",
      expected: [
        ClassificationSpec(source: "//: playground doc comment line", kind: .lineComment)
      ]
    )
  }

  public func testIfConfig() {
    assertClassification(
      """
      #if os(macOS)
        var x : Int
      #elseif
        var x : Float
      #else
      #endif
      """,
      expected: [
        ClassificationSpec(source: "#if", kind: .ifConfigDirective),
        ClassificationSpec(source: "os", kind: .ifConfigDirective),
        ClassificationSpec(source: "macOS", kind: .ifConfigDirective),
        ClassificationSpec(source: "var", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "Int", kind: .type),
        ClassificationSpec(source: "#elseif", kind: .ifConfigDirective),
        ClassificationSpec(source: "var", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "Float", kind: .type),
        ClassificationSpec(source: "#else", kind: .ifConfigDirective),
        ClassificationSpec(source: "#endif", kind: .ifConfigDirective),
      ]
    )
  }

  public func testIfconfig2() {
    assertClassification(
      """
      #if !CONF
      #else
      """,
      expected: [
        ClassificationSpec(source: "#if", kind: .ifConfigDirective),
        ClassificationSpec(source: "!", kind: .operator),
        ClassificationSpec(source: "CONF", kind: .ifConfigDirective),
        ClassificationSpec(source: "#else", kind: .ifConfigDirective),
      ]
    )
  }

  public func testBuiltinMacros() {
    assertClassification(
      """
      #error("Error")
      #warning("Warning")
      """,
      expected: [
        ClassificationSpec(source: "error", kind: .identifier),
        ClassificationSpec(source: "\"Error\"", kind: .stringLiteral),
        ClassificationSpec(source: "warning", kind: .identifier),
        ClassificationSpec(source: "\"Warning\"", kind: .stringLiteral),
      ]
    )
  }

  public func testSourceLocation() {
    assertClassification(
      #"#sourceLocation(file: "x", line: 1)"#,
      expected: [
        ClassificationSpec(source: "#sourceLocation", kind: .keyword),
        ClassificationSpec(source: "file", kind: .keyword),
        ClassificationSpec(source: #""x""#, kind: .stringLiteral),
        ClassificationSpec(source: "line", kind: .keyword),
        ClassificationSpec(source: "1", kind: .integerLiteral),
      ]
    )
  }

  public func testColorLiteral() {
    assertClassification(
      "#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)",
      expected: [
        ClassificationSpec(source: "colorLiteral", kind: .identifier),
        ClassificationSpec(source: "red", kind: .argumentLabel),
        ClassificationSpec(source: "0", kind: .integerLiteral),
        ClassificationSpec(source: "green", kind: .argumentLabel),
        ClassificationSpec(source: "0", kind: .integerLiteral),
        ClassificationSpec(source: "blue", kind: .argumentLabel),
        ClassificationSpec(source: "0", kind: .integerLiteral),
        ClassificationSpec(source: "alpha", kind: .argumentLabel),
        ClassificationSpec(source: "1", kind: .integerLiteral),
      ]
    )
  }

  public func testImageLiteral() {
    assertClassification(
      "#imageLiteral(resourceName: \"cloud.png\")",
      expected: [
        ClassificationSpec(source: "imageLiteral", kind: .identifier),
        ClassificationSpec(source: "resourceName", kind: .argumentLabel),
        ClassificationSpec(source: "\"cloud.png\"", kind: .stringLiteral),
      ]
    )
  }

  public func testFileLiteral() {
    assertClassification(
      "#fileLiteral(resourceName: \"cloud.png\")",
      expected: [
        ClassificationSpec(source: "fileLiteral", kind: .identifier),
        ClassificationSpec(source: "resourceName", kind: .argumentLabel),
        ClassificationSpec(source: "\"cloud.png\"", kind: .stringLiteral),
      ]
    )
  }

  public func testAttribute() {
    assertClassification(
      """
      @available(iOS 8.0, OSX 10.10, *)
      """,
      expected: [
        ClassificationSpec(source: "@available", kind: .attribute),
        ClassificationSpec(source: "iOS", kind: .keyword),
        ClassificationSpec(source: "8", kind: .integerLiteral),
        ClassificationSpec(source: "0", kind: .integerLiteral),
        ClassificationSpec(source: "OSX", kind: .keyword),
        ClassificationSpec(source: "10", kind: .integerLiteral),
        ClassificationSpec(source: "10", kind: .integerLiteral),
        ClassificationSpec(source: "*", kind: .operator),
      ]
    )
  }

  public func testAttribute2() {
    assertClassification(
      """
      @objc @IBOutlet var foo: String
      """,
      expected: [
        ClassificationSpec(source: "@objc", kind: .attribute),
        ClassificationSpec(source: "@IBOutlet", kind: .attribute),
        ClassificationSpec(source: "var", kind: .keyword),
        ClassificationSpec(source: "foo", kind: .identifier),
        ClassificationSpec(source: "String", kind: .type),
      ]
    )
  }

  public func testIndirectCase() {
    assertClassification(
      """
      enum List {
        indirect case cons(T, List)
      }
      """,
      expected: [
        ClassificationSpec(source: "enum", kind: .keyword),
        ClassificationSpec(source: "List", kind: .identifier),
        ClassificationSpec(source: "indirect", kind: .keyword),
        ClassificationSpec(source: "case", kind: .keyword),
        ClassificationSpec(source: "cons", kind: .identifier),
        ClassificationSpec(source: "T", kind: .type),
        ClassificationSpec(source: "List", kind: .type),
      ]
    )
  }

  public func testMutatingKeyword() {
    assertClassification(
      "mutating func func_mutating_1() {}",
      expected: [
        ClassificationSpec(source: "mutating", kind: .keyword),
        ClassificationSpec(source: "func", kind: .keyword),
        ClassificationSpec(source: "func_mutating_1", kind: .identifier),
      ]
    )
  }

  public func testNonMutatingKeyword() {
    assertClassification(
      "nonmutating func func_mutating_2() {}",
      expected: [
        ClassificationSpec(source: "nonmutating", kind: .keyword),
        ClassificationSpec(source: "func", kind: .keyword),
        ClassificationSpec(source: "func_mutating_2", kind: .identifier),
      ]
    )
  }

  public func testStringLikeLiterals() {
    assertClassification(
      "var s1 = \"abc абвгд あいうえお\"",
      expected: [
        ClassificationSpec(source: "var", kind: .keyword),
        ClassificationSpec(source: "s1", kind: .identifier),
        ClassificationSpec(source: "\"abc абвгд あいうえお\"", kind: .stringLiteral),
      ]
    )
  }

  public func testOperatorDecl() {
    assertClassification(
      """
      infix operator *-* : FunnyPrecedence
      """,
      expected: [
        ClassificationSpec(source: "infix", kind: .keyword),
        ClassificationSpec(source: "operator", kind: .keyword),
        ClassificationSpec(source: "*-*", kind: .operator),
        ClassificationSpec(source: "FunnyPrecedence", kind: .identifier),
      ]
    )
  }

  public func testPrecedenceGroup() {
    assertClassification(
      """
      precedencegroup FunnyPrecedence {
        associativity: left
        higherThan: MultiplicationPrecedence
      }
      """,
      expected: [
        ClassificationSpec(source: "precedencegroup", kind: .keyword),
        ClassificationSpec(source: "FunnyPrecedence", kind: .identifier),
        ClassificationSpec(source: "associativity", kind: .keyword),
        ClassificationSpec(source: "left", kind: .keyword),
        ClassificationSpec(source: "higherThan", kind: .keyword),
        ClassificationSpec(source: "MultiplicationPrecedence", kind: .identifier),
      ]
    )
  }

  public func testInheritence() {
    assertClassification(
      "protocol Prot2 : Prot {}",
      expected: [
        ClassificationSpec(source: "protocol", kind: .keyword),
        ClassificationSpec(source: "Prot2", kind: .identifier),
        ClassificationSpec(source: "Prot", kind: .type),
      ]
    )
  }

  public func testGenericType() {
    assertClassification(
      "func genFn<T : Prot>(_: T) -> Int where T.Blarg : Prot2 {}",
      expected: [
        ClassificationSpec(source: "func", kind: .keyword),
        ClassificationSpec(source: "genFn", kind: .identifier),
        ClassificationSpec(source: "T", kind: .identifier),
        ClassificationSpec(source: "Prot", kind: .type),
        ClassificationSpec(source: "T", kind: .type),
        ClassificationSpec(source: "Int", kind: .type),
        ClassificationSpec(source: "where", kind: .keyword),
        ClassificationSpec(source: "T", kind: .type),
        ClassificationSpec(source: "Blarg", kind: .type),
        ClassificationSpec(source: "Prot2", kind: .type),
      ]
    )
  }

  public func testStringInterpolationAnchor() {
    assertClassification(
      #""This is string \(1) interpolation""#,
      expected: [
        ClassificationSpec(source: #""This is string "#, kind: .stringLiteral),
        ClassificationSpec(source: "1", kind: .integerLiteral),
        ClassificationSpec(source: #" interpolation""#, kind: .stringLiteral),
      ]
    )
  }

  public func testPlaceHolder() {
    assertClassification(
      "func <#test1#> () {}",
      expected: [
        ClassificationSpec(source: "func", kind: .keyword),
        ClassificationSpec(source: "<#test1#>", kind: .editorPlaceholder),
      ]
    )
  }

  public func testUnownedAndUnsafe() {
    assertClassification(
      "unowned(unsafe) var uu",
      expected: [
        ClassificationSpec(source: "unowned", kind: .keyword),
        ClassificationSpec(source: "unsafe", kind: .identifier),
        ClassificationSpec(source: "var", kind: .keyword),
        ClassificationSpec(source: "uu", kind: .identifier),
      ]
    )
  }

  public func testClosure() {
    assertClassification(
      "let closure = { [weak x=bindtox, unowned y=bindtoy, unowned(unsafe) z=bindtoz] in }",
      expected: [
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "closure", kind: .identifier),
        ClassificationSpec(source: "weak", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "bindtox", kind: .identifier),
        ClassificationSpec(source: "unowned", kind: .keyword),
        ClassificationSpec(source: "y", kind: .identifier),
        ClassificationSpec(source: "bindtoy", kind: .identifier),
        ClassificationSpec(source: "unowned", kind: .keyword),
        ClassificationSpec(source: "unsafe", kind: .keyword),
        ClassificationSpec(source: "z", kind: .identifier),
        ClassificationSpec(source: "bindtoz", kind: .identifier),
        ClassificationSpec(source: "in", kind: .keyword),
      ]
    )
  }

  public func testEscapedKeywords() {
    assertClassification(
      """
      func keywordInCaseAndLocalArgLabel(_ for: Int, for in: Int, class _: Int) {
        
      }
      """,
      expected: [
        ClassificationSpec(source: "func", kind: .keyword),
        ClassificationSpec(source: "keywordInCaseAndLocalArgLabel", kind: .identifier),
        ClassificationSpec(source: "for", kind: .identifier),
        ClassificationSpec(source: "Int", kind: .type),
        ClassificationSpec(source: "for", kind: .argumentLabel),
        ClassificationSpec(source: "in", kind: .identifier),
        ClassificationSpec(source: "Int", kind: .type),
        ClassificationSpec(source: "class", kind: .argumentLabel),
        ClassificationSpec(source: "Int", kind: .type),
      ]
    )
  }

  public func testEscapedKeywords2() {
    assertClassification(
      """
      switch(`for`, `in`) {
          case (let x, let y):
            print(x, y)
      }
      """,
      expected: [
        ClassificationSpec(source: "switch", kind: .keyword),
        ClassificationSpec(source: "`for`", kind: .identifier),
        ClassificationSpec(source: "`in`", kind: .identifier),
        ClassificationSpec(source: "case", kind: .keyword),
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "let", kind: .keyword),
        ClassificationSpec(source: "y", kind: .identifier),
        ClassificationSpec(source: "print", kind: .identifier),
        ClassificationSpec(source: "x", kind: .identifier),
        ClassificationSpec(source: "y", kind: .identifier),
      ]
    )
  }

  public func testAttributeFollowedByComment() {
    assertClassification(
      """
      @MyAttribute // some comment
      func foo() {}
      """,
      expected: [
        ClassificationSpec(source: "@MyAttribute", kind: .attribute),
        ClassificationSpec(source: "// some comment", kind: .lineComment),
        ClassificationSpec(source: "func", kind: .keyword),
        ClassificationSpec(source: "foo", kind: .identifier),
      ]
    )
  }

  public func testargumentLabel() {
    assertClassification(
      """
      func foo(arg: Int) {}
      """,
      expected: [
        ClassificationSpec(source: "func", kind: .keyword),
        ClassificationSpec(source: "foo", kind: .identifier),
        ClassificationSpec(source: "arg", kind: .argumentLabel),
        ClassificationSpec(source: "Int", kind: .type),
      ]
    )

    assertClassification(
      """
      foo(arg: 1)
      """,
      expected: [
        ClassificationSpec(source: "foo", kind: .identifier),
        ClassificationSpec(source: "arg", kind: .argumentLabel),
        ClassificationSpec(source: "1", kind: .integerLiteral),
      ]
    )
  }
}
