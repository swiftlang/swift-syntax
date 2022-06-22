import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class VariableTests: XCTestCase {
  func testVariableDecl() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = VariableDecl(letOrVarKeyword: .let) {
      PatternBinding(pattern: "a", typeAnnotation: ArrayType(elementType: "Int"))
    }

    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)
    XCTAssertEqual(syntax.description, "␣let a: [Int]")
  }

  func testVariableDeclWithValue() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = VariableDecl(letOrVarKeyword: .var) {
      PatternBinding(
        pattern: "d",
        typeAnnotation: DictionaryType(keyType: "String", valueType: "Int"),
        initializer: InitializerClause(value: DictionaryExpr()))
    }

    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)
    XCTAssertEqual(syntax.description, "␣var d: [String: Int] = [:]")
  }

  func testVariableDeclWithExplictiTrailingCommas() {
    let buildable = VariableDecl(letOrVarKeyword: .let, bindings: [
      PatternBinding(pattern: "a", initializer: InitializerClause(
        value: ArrayExpr(leftSquare: .`leftSquareBracket`.withTrailingTrivia(.newline)) {
          for i in 1...3 {
            ArrayElement(
              expression: IntegerLiteralExpr(i),
              trailingComma: .comma.withoutTrailingTrivia().withTrailingTrivia(.newline))
          }
        }))
    ])
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, "let a = [\n1,\n2,\n3,\n]")
  }

  func testMultiPatternVariableDecl() {
    let buildable = VariableDecl(letOrVarKeyword: .let) {
      PatternBinding(pattern: "a", initializer: InitializerClause(value: ArrayExpr {
        for i in 1...3 {
          ArrayElement(expression: IntegerLiteralExpr(i))
        }
      }))
      PatternBinding(pattern: "d", initializer: InitializerClause(value: DictionaryExpr {
        for i in 1...3 {
          DictionaryElement(keyExpression: StringLiteralExpr("key\(i)"), valueExpression: IntegerLiteralExpr(i))
        }
      }))
      PatternBinding(pattern: "i", typeAnnotation: "Int")
      PatternBinding(pattern: "s", typeAnnotation: "String")
    }
    let syntax = buildable.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, #"let a = [1, 2, 3], d = ["key1": 1, "key2": 2, "key3": 3], i: Int, s: String"#)
  }

  func testConvenienceInitializer() {
    let leadingTrivia = Trivia.garbageText("␣")

    let testCases: [UInt: (TokenSyntax, String, String, String)] = [
      #line: (.let, "foo", "Int", "␣let foo: Int"),
      #line: (.var, "bar", "Baz", "␣var bar: Baz")
    ]

    for (line, testCase) in testCases {
      let (keyword, name, type, expected) = testCase
      let builder = VariableDecl(keyword, name: name, type: type)
      let syntax = builder.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

      XCTAssertEqual(syntax.description, expected, line: line)
    }
  }
}
