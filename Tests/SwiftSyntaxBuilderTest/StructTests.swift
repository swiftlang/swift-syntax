import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class StructTests: XCTestCase {
  func testEmptyStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let members = MemberDeclList([])
    let buildable = StructDecl(identifier: "TestStruct",
                               members: members)
    let syntax = buildable.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    XCTAssertEqual(text, """
    ␣struct TestStruct{
    }
    """)
  }

  func testNestedStruct() {
    let leadingTrivia = Trivia.garbageText("␣")
    let emptyMembers = MemberDeclList([])
    let nestedStruct = StructDecl(
        structKeyword: .struct.withLeadingTrivia(.docLineComment("/// A nested struct\n")),
        identifier: "NestedStruct",
        genericParameterClause: GenericParameterClause(genericParameterListBuilder: {
          GenericParameter(name: "A")
          GenericParameter(name: "B", colon: .colon, inheritedType: "C")
          GenericParameter(name: "D")
        }),
        genericWhereClause: GenericWhereClause(requirementListBuilder: {
          GenericRequirement(body: ConformanceRequirement(leftTypeIdentifier: "A", rightTypeIdentifier: "X"))
          GenericRequirement(body: SameTypeRequirement(
              leftTypeIdentifier: "A.P", equalityToken: .identifier("=="), rightTypeIdentifier: "D"))
        }),
        members: emptyMembers)
    let members = MemberDeclListItem(decl: nestedStruct)
    let testStruct = StructDecl(identifier: "TestStruct",
                                members: members,
                                attributesBuilder: {
      DeclModifier(name: TokenSyntax.public)
    })
    let syntax = testStruct.buildSyntax(format: Format(), leadingTrivia: leadingTrivia)

    var text = ""
    syntax.write(to: &text)

    // FIXME: We should indent the nested struct by adding the indentation after every newline in the leading trivia.
    XCTAssertEqual(text, """
    ␣public struct TestStruct{
        /// A nested struct
    struct NestedStruct < A, B: C, D > where A: X, A.P==D{
        }
    }
    """)
  }

  func testControlWithLoopAndIf() {
    let myStruct = StructDecl(identifier: "MyStruct", members: MemberDeclBlock(membersBuilder: {
      for i in 0..<5 {
        if i.isMultiple(of: 2) {
           VariableDecl(letOrVarKeyword: .let, bindingsBuilder: {
            PatternBinding(
              pattern: IdentifierPattern("var\(i)"),
              typeAnnotation: "String"
            )
          })
        }
      }
    }))
    let syntax = myStruct.buildSyntax(format: Format())
    XCTAssertEqual(syntax.description, """
    struct MyStruct{
        let var0: String
        let var2: String
        let var4: String
    }
    """)
  }
}
