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

import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

final class VariableTests: XCTestCase {
  func testVariableDecl() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let buildable = VariableDeclSyntax(leadingTrivia: leadingTrivia, bindingSpecifier: .keyword(.let)) {
      PatternBindingSyntax(pattern: PatternSyntax("a"), typeAnnotation: TypeAnnotationSyntax(type: ArrayTypeSyntax(element: TypeSyntax("Int"))))
    }

    assertBuildResult(buildable, "␣let a: [Int]")
  }

  func testInoutBindingDecl() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let buildable = VariableDeclSyntax(leadingTrivia: leadingTrivia, bindingSpecifier: .keyword(.inout)) {
      PatternBindingSyntax(pattern: PatternSyntax("a"), typeAnnotation: TypeAnnotationSyntax(type: ArrayTypeSyntax(element: TypeSyntax("Int"))))
    }

    assertBuildResult(buildable, "␣inout a: [Int]")
  }

  func testVariableDeclWithStringParsing() {
    let testCases: [UInt: (DeclSyntax, String)] = [
      #line: (
        DeclSyntax("let content = try? String(contentsOf: url)"),
        "let content = try? String(contentsOf: url)"
      ),
      #line: (
        DeclSyntax("inout content = try? String(contentsOf: url)"),
        "inout content = try? String(contentsOf: url)"
      ),
      #line: (
        DeclSyntax("let content = try! String(contentsOf: url)"),
        "let content = try! String(contentsOf: url)"
      ),
      #line: (
        DeclSyntax("var newLayout: ContiguousArray<RawSyntax?>?"),
        "var newLayout: ContiguousArray<RawSyntax?>?"
      ),
      #line: (
        DeclSyntax("var foo: String { myOptional!.someProperty }"),
        """
        var foo: String {
            myOptional!.someProperty
        }
        """
      ),
      #line: (
        DeclSyntax("inout foo: String { myOptional!.someProperty }"),
        """
        inout foo: String {
            myOptional!.someProperty
        }
        """
      ),
      #line: (
        DeclSyntax("var foo: String? { myOptional?.someProperty }"),
        """
        var foo: String? {
            myOptional?.someProperty
        }
        """
      ),
      #line: (
        DeclSyntax("let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)"),
        """
        let absoluteRaw = AbsoluteRawSyntax(raw: raw!, info: info)
        """
      ),
      #line: (
        DeclSyntax("var foo: String { bar(baz!) }"),
        """
        var foo: String {
            bar(baz!)
        }
        """
      ),
      #line: (
        DeclSyntax(#"var foo: String { bar ?? "" }"#),
        #"""
        var foo: String {
            bar ?? ""
        }
        """#
      ),
      #line: (
        DeclSyntax("let bar = try! (foo())"),
        """
        let bar = try! (foo())
        """
      ),
      #line: (
        DeclSyntax("let bar = try! !functionThatThrows()"),
        """
        let bar = try! !functionThatThrows()
        """
      ),
      #line: (
        DeclSyntax("var bar: Foo { bar.map(Foo.init(raw:)) }"),
        """
        var bar: Foo {
            bar.map(Foo.init(raw:))
        }
        """
      ),
      #line: (
        DeclSyntax("var bar: Foo { bar.map(Foo.init(raw:otherParam:)) }"),
        """
        var bar: Foo {
            bar.map(Foo.init(raw:otherParam:))
        }
        """
      ),
      #line: (
        DeclSyntax("var bar: [String] { bar.map({ $0.description }) }"),
        """
        var bar: [String] {
            bar.map({
                    $0.description
                })
        }
        """
      ),
      #line: (
        DeclSyntax("inout bar: [String] { bar.map({ $0.description }) }"),
        """
        inout bar: [String] {
            bar.map({
                    $0.description
                })
        }
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }

  func testVariableDeclWithValue() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let buildable = VariableDeclSyntax(leadingTrivia: leadingTrivia, bindingSpecifier: .keyword(.var)) {
      PatternBindingSyntax(
        pattern: PatternSyntax("d"),
        typeAnnotation: TypeAnnotationSyntax(type: DictionaryTypeSyntax(key: TypeSyntax("String"), value: TypeSyntax("Int"))),
        initializer: InitializerClauseSyntax(value: DictionaryExprSyntax())
      )
    }

    assertBuildResult(buildable, "␣var d: [String: Int] = [:]")
  }

  func testVariableDeclWithExplicitTrailingCommas() {
    let buildable = VariableDeclSyntax(
      bindingSpecifier: .keyword(.let),
      bindings: [
        PatternBindingSyntax(
          pattern: PatternSyntax("a"),
          initializer: InitializerClauseSyntax(
            value: ArrayExprSyntax {
              for i in 1...3 {
                ArrayElementSyntax(
                  expression: IntegerLiteralExprSyntax(i),
                  trailingComma: .commaToken().with(\.trailingTrivia, .spaces(3))
                )
              }
            }
          )
        )
      ]
    )
    assertBuildResult(
      buildable,
      """
      let a = [1,   2,   3,   ]
      """
    )
  }

  func testMultiPatternVariableDecl() {
    let buildable = VariableDeclSyntax(bindingSpecifier: .keyword(.let)) {
      PatternBindingSyntax(
        pattern: PatternSyntax("a"),
        initializer: InitializerClauseSyntax(
          value: ArrayExprSyntax {
            for i in 1...3 {
              ArrayElementSyntax(expression: IntegerLiteralExprSyntax(i))
            }
          }
        )
      )
      PatternBindingSyntax(
        pattern: PatternSyntax("d"),
        initializer: InitializerClauseSyntax(
          value: DictionaryExprSyntax {
            for i in 1...3 {
              DictionaryElementSyntax(key: StringLiteralExprSyntax(content: "key\(i)"), value: IntegerLiteralExprSyntax(i))
            }
          }
        )
      )
      PatternBindingSyntax(pattern: PatternSyntax("i"), typeAnnotation: TypeAnnotationSyntax(type: TypeSyntax("Int")))
      PatternBindingSyntax(pattern: PatternSyntax("s"), typeAnnotation: TypeAnnotationSyntax(type: TypeSyntax("String")))
    }
    assertBuildResult(buildable, #"let a = [1, 2, 3], d = ["key1": 1, "key2": 2, "key3": 3], i: Int, s: String"#)
  }

  func testClosureTypeVariableDecl() {
    let type = FunctionTypeSyntax(
      parameters: [TupleTypeElementSyntax(type: TypeSyntax("Int"))],
      returnClause: ReturnClauseSyntax(type: TypeSyntax("Bool"))
    )
    let buildable = VariableDeclSyntax(bindingSpecifier: .keyword(.let)) {
      PatternBindingSyntax(pattern: PatternSyntax("c"), typeAnnotation: TypeAnnotationSyntax(type: type))
    }
    assertBuildResult(buildable, "let c: (Int) -> Bool")
  }

  func testComputedProperty() throws {
    let testCases: [UInt: (VariableDeclSyntax, String)] = try [
      #line: (
        VariableDeclSyntax("var test: Int") {
          SequenceExprSyntax {
            IntegerLiteralExprSyntax(4)
            BinaryOperatorExprSyntax(text: "+")
            IntegerLiteralExprSyntax(5)
          }
        },
        """
        var test: Int {
            4 + 5
        }
        """
      ),
      #line: (
        try VariableDeclSyntax("var foo: String") {
          StmtSyntax(#"return "hello world""#)
        },
        """
        var foo: String {
            return "hello world"
        }
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }

  func testAccessorList() throws {
    let buildable = try VariableDeclSyntax("var test: Int") {
      AccessorDeclSyntax(accessorSpecifier: .keyword(.get)) {
        SequenceExprSyntax {
          IntegerLiteralExprSyntax(4)
          BinaryOperatorExprSyntax(text: "+")
          IntegerLiteralExprSyntax(5)
        }
      }

      AccessorDeclSyntax(accessorSpecifier: .keyword(.willSet)) {}
    }

    assertBuildResult(
      buildable,
      """
      var test: Int {
          get {
              4 + 5
          }
          willSet {
          }
      }
      """
    )
  }

  func testAccessorWithEffectSpecifier() throws {
    let buildable = try VariableDeclSyntax("var test: Int") {
      AccessorDeclSyntax(
        accessorSpecifier: .keyword(.get),
        effectSpecifiers: AccessorEffectSpecifiersSyntax(
          asyncSpecifier: .keyword(.async),
          throwsClause: ThrowsClauseSyntax(throwsSpecifier: .keyword(.throws))
        )
      ) {}
    }

    assertBuildResult(
      buildable,
      """
      var test: Int {
          get async throws {
          }
      }
      """
    )
  }

  func testAttributedVariables() throws {
    let testCases: [UInt: (VariableDeclSyntax, String)] = try [
      #line: (
        VariableDeclSyntax(
          attributes: AttributeListSyntax { AttributeSyntax(attributeName: TypeSyntax("Test")) },
          .var,
          name: "x",
          type: TypeAnnotationSyntax(type: TypeSyntax("Int"))
        ),
        """
        @Test var x: Int
        """
      ),
      #line: (
        VariableDeclSyntax("@Test var y: String") {
          StringLiteralExprSyntax(content: "Hello world!")
        },
        """
        @Test var y: String {
            "Hello world!"
        }
        """
      ),
      #line: (
        VariableDeclSyntax("@WithArgs(value1, label: value2) var z: Float") {
          FloatLiteralExprSyntax(0.0)
        },
        """
        @WithArgs(value1, label: value2) var z: Float {
            0.0
        }
        """
      ),
      #line: (
        VariableDeclSyntax(
          attributes: AttributeListSyntax {
            AttributeSyntax("WithArgs") {
              LabeledExprSyntax(expression: ExprSyntax("value"))
            }
          },
          modifiers: [DeclModifierSyntax(name: .keyword(.public))],
          .let,
          name: "z",
          type: TypeAnnotationSyntax(type: TypeSyntax("Float"))
        ),
        """
        @WithArgs(value) public let z: Float
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      assertBuildResult(builder, expected, line: line)
    }
  }

  // https://github.com/apple/swift-syntax/issues/1815
  func testSpacingInDictionaryType() throws {
    let buildable = try VariableDeclSyntax("static var mirror: Dictionary<String, Any.Type>") {}

    assertBuildResult(
      buildable,
      """
      static var mirror: Dictionary<String, Any.Type> {
      }
      """
    )
  }
}
