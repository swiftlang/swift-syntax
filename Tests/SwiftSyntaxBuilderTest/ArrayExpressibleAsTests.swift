import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class ArrayExpressibleAsTests: XCTestCase {
  func testSimpleModifierList() {
    let modifiers: ExpressibleAsModifierList = [Token.public, Token.static]

    var result = ""
    modifiers.createModifierList().buildSyntax().write(to: &result)
    XCTAssertEqual(result, "public static ")
  }

  func testHeterogeneousList() {
    let modifiers: ExpressibleAsModifierList = [Token.open, DeclModifier(name: Token.internal)]

    var result = ""
    modifiers.createModifierList().buildSyntax().write(to: &result)
    XCTAssertEqual(result, "open internal ")
  }

  func testExplicitlyTypeErasedList() {
    let modifiers: [DeclModifier] = [DeclModifier(name: Token.private)]
    let expressible: ExpressibleAsModifierList = modifiers as [ExpressibleAsDeclModifier]

    var result = ""
    expressible.createModifierList().buildSyntax().write(to: &result)
    XCTAssertEqual(result, "private ")
  }

  func testFunctionParameters() {
    let signature = FunctionSignature(
      input: ParameterClause {
        FunctionParameter(
          attributes: nil,
          firstName: .wildcard,
          secondName: .identifier("args"),
          colon: .colon,
          type: ArrayType(elementType: "String")
        )
      },
      output: "Int"
    )

    var result = ""
    signature.buildSyntax().write(to: &result)
    XCTAssertEqual(result, "(_ args: [String]) -> Int")
  }
}
