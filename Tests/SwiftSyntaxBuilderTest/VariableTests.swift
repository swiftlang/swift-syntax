import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class VariableTests: XCTestCase {
  func testVariableDecl() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = VariableDecl(letOrVarKeyword: .let, bindingsBuilder: {
      PatternBinding(pattern: "a", typeAnnotation: ArrayType(elementType: "Int"))
    })

    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)
    XCTAssertEqual(syntax.description, "␣let a: [Int]")
  }

  func testVariableDeclWithValue() {
    let leadingTrivia = Trivia.garbageText("␣")

    let buildable = VariableDecl(letOrVarKeyword: .var, bindingsBuilder: {
      PatternBinding(
        pattern: "d",
        typeAnnotation: DictionaryType(keyType: "String", valueType: "Int"),
        initializer: InitializerClause(value: DictionaryExpr()))
    })

    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)
    XCTAssertEqual(syntax.description, "␣var d: [String: Int] = [:]")
  }

  func testMultiPatternVariableDecl() {
    let buildable = VariableDecl(letOrVarKeyword: .let, bindingsBuilder: {
      PatternBinding(
        pattern: "a",
        initializer: InitializerClause(
          value: ArrayExpr(elementsBuilder: {
            ArrayElement(expression: IntegerLiteralExpr(1), trailingComma: .comma)
            ArrayElement(expression: IntegerLiteralExpr(2), trailingComma: .comma)
            ArrayElement(expression: IntegerLiteralExpr(3))
          })),
        trailingComma: .comma)
      PatternBinding(
        pattern: "d",
        initializer: InitializerClause(value: DictionaryExpr(
          contentBuilder: {
            DictionaryElement(keyExpression: StringLiteralExpr("key1"), valueExpression: "1", trailingComma: .comma)
            DictionaryElement(keyExpression: StringLiteralExpr("key2"), valueExpression: "2", trailingComma: .comma)
            DictionaryElement(keyExpression: StringLiteralExpr("key3"), valueExpression: "3")
        })),
        trailingComma: .comma)
      PatternBinding(pattern: "i", typeAnnotation: "Int", trailingComma: .comma)
      PatternBinding(pattern: "s", typeAnnotation: "String")
    })
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
