import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let buildable = StructDecl(leadingTrivia: leadingTrivia, identifier: "TestStruct") {}
    let syntax = buildable.buildSyntax()

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct {
    }
    """)
  }

  func testNestedStruct() {
    let nestedStruct = StructDecl(
      leadingTrivia: [
        .docLineComment("/// A nested struct"),
        .newlines(1),
        .docLineComment("/// with multi line comment"),
        .newlines(1)
      ],
      structKeyword: .struct,
      identifier: "NestedStruct",
      genericParameterClause: GenericParameterClause(rightAngleBracket: .rightAngle.withTrailingTrivia([])) {
        GenericParameter(name: "A")
        GenericParameter(name: "B", colon: .colon, inheritedType: "C")
        GenericParameter(name: "D")
      },
      genericWhereClause: GenericWhereClause {
        GenericRequirement(body: ConformanceRequirement(leftTypeIdentifier: "A", rightTypeIdentifier: "X"))
        GenericRequirement(body: SameTypeRequirement(
            leftTypeIdentifier: "A.P", equalityToken: .spacedBinaryOperator("=="), rightTypeIdentifier: "D"))
      }
    ) {}
    
    let carriateReturnsStruct = StructDecl(
        leadingTrivia: [
          .docLineComment("/// A nested struct"),
          .carriageReturns(1),
          .docLineComment("/// with multi line comment where the newline is a CR"),
          .carriageReturns(1)
        ],
        structKeyword: .struct,
        identifier: "CarriateReturnsStruct"
      )
      let carriageReturnFormFeedsStruct = StructDecl(
          leadingTrivia: [
            .docLineComment("/// A nested struct"),
            .carriageReturnLineFeeds(1),
            .docLineComment("/// with multi line comment where the newline is a CRLF"),
            .carriageReturnLineFeeds(1),
          ],
          structKeyword: .struct,
          identifier: "CarriageReturnFormFeedsStruct"
        )
    let testStruct = StructDecl(
      modifiers: [Token.public],
      identifier: "TestStruct"
    ) {
      nestedStruct
      carriateReturnsStruct
      carriageReturnFormFeedsStruct
    }
    let syntax = testStruct.buildSyntax()

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    public struct TestStruct {
        /// A nested struct
        /// with multi line comment
        struct NestedStruct < A, B: C, D > where A: X, A.P == D {
        }
        /// A nested struct\r\
        /// with multi line comment where the newline is a CR\r\
        struct CarriateReturnsStruct {
        }
        /// A nested struct\r\n\
        /// with multi line comment where the newline is a CRLF\r\n\
        struct CarriageReturnFormFeedsStruct {
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
    let syntax = myStruct.buildSyntax()
    XCTAssertEqual(syntax.description, """
    struct MyStruct {
        let var0: String
        let var2: String
        let var4: String
    }
    """)
  }
}
