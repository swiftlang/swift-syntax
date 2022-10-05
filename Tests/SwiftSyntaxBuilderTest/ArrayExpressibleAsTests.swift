import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftBasicFormat

final class ArrayExpressibleAsTests: XCTestCase {
  func testSimpleModifierList() {
    let modifiers: ExpressibleAsModifierList = [Token.public, Token.static]
    AssertBuildResult(modifiers.createModifierList(), "public static ")
  }

  func testHeterogeneousList() {
    let modifiers: ExpressibleAsModifierList = [Token.open, DeclModifier(name: Token.internal)]
    AssertBuildResult(modifiers.createModifierList(), "open internal ")
  }

  func testExplicitlyTypeErasedList() {
    let modifiers: [DeclModifier] = [DeclModifier(name: Token.private)]
    let expressible: ExpressibleAsModifierList = modifiers as [ExpressibleAsDeclModifier]
    AssertBuildResult(expressible.createModifierList(), "private ")
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
    AssertBuildResult(signature, "(_ args: [String]) -> Int")
  }
}
