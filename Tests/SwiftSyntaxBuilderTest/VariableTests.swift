import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class VariableTests: XCTestCase {
  func testVariableDecl() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let buildable = VariableDecl(leadingTrivia: leadingTrivia, letOrVarKeyword: .let) {
      PatternBinding(pattern: "a", typeAnnotation: ArrayType(elementType: "Int"))
    }

    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, "␣let a: [Int]")
  }

  func testVariableDeclWithValue() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let buildable = VariableDecl(leadingTrivia: leadingTrivia, letOrVarKeyword: .var) {
      PatternBinding(
        pattern: "d",
        typeAnnotation: DictionaryType(keyType: "String", valueType: "Int"),
        initializer: DictionaryExpr())
    }

    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, "␣var d: [String: Int] = [:]")
  }

  func testVariableDeclWithExplicitTrailingCommas() {
    let buildable = VariableDecl(letOrVarKeyword: .let, bindings: [
      PatternBinding(pattern: "a", initializer: ArrayExpr(leftSquare: .`leftSquareBracket`.withTrailingTrivia(.newline)) {
        for i in 1...3 {
          ArrayElement(
            expression: IntegerLiteralExpr(i),
            trailingComma: .comma.withTrailingTrivia(.newline))
        }
      })
    ])
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, "let a = [\n1,\n2,\n3,\n]")
  }

  func testMultiPatternVariableDecl() {
    let buildable = VariableDecl(letOrVarKeyword: .let) {
      PatternBinding(pattern: "a", initializer: ArrayExpr {
        for i in 1...3 {
          ArrayElement(expression: IntegerLiteralExpr(i))
        }
      })
      PatternBinding(pattern: "d", initializer: DictionaryExpr {
        for i in 1...3 {
          DictionaryElement(keyExpression: StringLiteralExpr("key\(i)"), valueExpression: IntegerLiteralExpr(i))
        }
      })
      PatternBinding(pattern: "i", typeAnnotation: "Int")
      PatternBinding(pattern: "s", typeAnnotation: "String")
    }
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, #"let a = [1, 2, 3], d = ["key1": 1, "key2": 2, "key3": 3], i: Int, s: String"#)
  }

  func testClosureTypeVariableDecl() {
    let type = FunctionType(arguments: [TupleTypeElement(type: "Int")], returnType: "Bool")
    let buildable = VariableDecl(letOrVarKeyword: .let) {
      return PatternBinding(pattern: "c", typeAnnotation: TypeAnnotation(type: type))
    }
    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, "let c: (Int) -> Bool")
  }

  func testConvenienceInitializer() {
    let leadingTrivia = Trivia.unexpectedText("␣")

    let testCases: [UInt: (Token, String, String?, ExpressibleAsExprBuildable?, String)] = [
      #line: (.let, "foo", "Int", nil, "␣let foo: Int"),
      #line: (.var, "bar", "Baz", nil, "␣var bar: Baz"),
      #line: (.var, "typed", "String", StringLiteralExpr("abc"), #"␣var typed: String = "abc""#),
      #line: (.let, "inferred", nil, "typed", "␣let inferred = typed"),
    ]

    for (line, testCase) in testCases {
      let (keyword, name, type, initializer, expected) = testCase
      let builder = VariableDecl(leadingTrivia: leadingTrivia, keyword, name: name, type: type, initializer: initializer)
      let syntax = builder.buildSyntax()

      XCTAssertEqual(syntax.description, expected, line: line)
    }
  }

  func testComputedProperty() {
    let buildable = VariableDecl(name: "test", type: "Int") {
      SequenceExpr {
        IntegerLiteralExpr(4)
        BinaryOperatorExpr("+")
        IntegerLiteralExpr(5)
      }
    }

    let syntax = buildable.buildSyntax()
    XCTAssertEqual(syntax.description, """
      var test: Int {
          4 + 5
      }
      """)
  }

  func testAttributedVariables() {
    let testCases: [UInt: (VariableDecl, String)] = [
      #line: (
        VariableDecl(
          attributes: CustomAttribute("Test"),
          .var,
          name: "x",
          type: "Int"
        ),
        """
        @Test var x: Int
        """
      ),
      #line: (
        VariableDecl(
          attributes: CustomAttribute("Test"),
          name: "y",
          type: "String"
        ) {
          StringLiteralExpr("Hello world!")
        },
        """
        @Test var y: String {
            "Hello world!"
        }
        """
      ),
      #line: (
        VariableDecl(
          attributes: CustomAttribute("WithArgs") {
            TupleExprElement(expression: "value1")
            TupleExprElement(label: "label", expression: "value2")
          },
          name: "z",
          type: "Float"
        ) {
          FloatLiteralExpr(0.0)
        },
        """
        @WithArgs(value1, label: value2) var z: Float {
            0.0
        }
        """
      ),
      #line: (
        VariableDecl(
          attributes: CustomAttribute("WithArgs") {
            TupleExprElement(expression: "value")
          },
          modifiers: [Token.public],
          .let,
          name: "z",
          type: "Float"
        ),
        """
        @WithArgs(value) public let z: Float
        """
      ),
    ]

    for (line, testCase) in testCases {
      let (builder, expected) = testCase
      let syntax = builder.buildSyntax()

      XCTAssertEqual(syntax.description, expected, line: line)
    }
  }
}
