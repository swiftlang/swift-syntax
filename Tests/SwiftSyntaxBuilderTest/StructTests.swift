import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let buildable = StructDecl(identifier: "TestStruct") {}
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct {
    }
    """)
  }

  func testNestedStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let nestedStruct = StructDecl(
      structKeyword: .struct.withLeadingTrivia(.docLineComment("/// A nested struct\n")),
      identifier: "NestedStruct",
      genericParameterClause: GenericParameterClause {
        GenericParameter(name: "A")
        GenericParameter(name: "B", colon: .colon, inheritedType: "C")
        GenericParameter(name: "D")
      },
      genericWhereClause: GenericWhereClause {
        GenericRequirement(body: ConformanceRequirement(leftTypeIdentifier: "A", rightTypeIdentifier: "X"))
        GenericRequirement(body: SameTypeRequirement(
            leftTypeIdentifier: "A.P", equalityToken: .identifier("=="), rightTypeIdentifier: "D"))
      }
    ) {}
    let testStruct = StructDecl(
      modifiers: [TokenSyntax.public],
      identifier: "TestStruct"
    ) {
      nestedStruct
    }
    let syntax = testStruct.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    // FIXME: We should indent the nested struct by adding the indentation after every newline in the leading trivia.
    XCTAssertEqual(text, """
    ␣public struct TestStruct {
        /// A nested struct
    struct NestedStruct < A, B: C, D > where A: X, A.P==D {
        }
    }
    """)
  }

  func testControlWithLoopAndIf() {
    let myStruct = StructDecl(identifier: "MyStruct") {
      for i in 0..<5 {
        if i.isMultiple(of: 2) {
           VariableDecl(letOrVarKeyword: .let) {
            PatternBinding(
              pattern: IdentifierPattern("var\(i)"),
              typeAnnotation: "String"
            )
          }
        }
      }
    }
    let syntax = myStruct.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, """
    struct MyStruct {
        let var0: String
        let var2: String
        let var4: String
    }
    """)
  }
}
