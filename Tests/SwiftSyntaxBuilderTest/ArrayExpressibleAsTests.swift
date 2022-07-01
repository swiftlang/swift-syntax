import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ArrayExpressibleAsTests: XCTestCase {
  func testSimpleModifierList() {
    let modifiers: ExpressibleAsModifierList = [TokenSyntax.public, TokenSyntax.static]

    var result = ""
    modifiers.createModifierList().buildSyntax(format: Format()).write(to: &result)
    XCTAssertEqual(result, "public static ")
  }

  func testHeterogeneousList() {
    let modifiers: ExpressibleAsModifierList = [TokenSyntax.open, DeclModifier(name: TokenSyntax.internal)]

    var result = ""
    modifiers.createModifierList().buildSyntax(format: Format()).write(to: &result)
    XCTAssertEqual(result, "open internal ")
  }

  func testExplicitlyTypeErasedList() {
    let modifiers: [DeclModifier] = [DeclModifier(name: TokenSyntax.private)]
    let expressible: ExpressibleAsModifierList = modifiers as [ExpressibleAsDeclModifier]

    var result = ""
    expressible.createModifierList().buildSyntax(format: Format()).write(to: &result)
    XCTAssertEqual(result, "private ")
  }

  func testFunctionParameters() {
    let signature = FunctionSignature(
      input: ParameterClause(
        parameterList: [
          FunctionParameter(
            attributes: nil,
            firstName: .wildcard,
            secondName: .identifier("args"),
            colon: .colon,
            type: ArrayType(elementType: "String")
          )
        ],
        rightParen: .rightParen.withTrailingTrivia(.space)
      ),
      output: "Int"
    )

    var result = ""
    signature.buildSyntax(format: Format()).write(to: &result)
    XCTAssertEqual(result, "(_ args: [String]) -> Int")
  }
}
