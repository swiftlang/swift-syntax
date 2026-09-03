//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(Testing) @_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
import XCTest

final class NamespaceDeclarationTests: ParserTestCase {
  override var languageFeatures: Parser.LanguageFeatures {
    [.namespaces]
  }

  func testFileScopeNamespace() {
    assertParse(
      "namespace HTTP {}",
      substructure: NamespaceDeclSyntax(
        name: .identifier("HTTP"),
        memberBlock: MemberBlockSyntax(members: [])
      )
    )
  }

  func testNamespaceMembers() {
    let source = """
      namespace HTTP {
        struct Request {}
        enum Method {}
        static let defaultPort = 443
        static func connect() {}
      }
      """

    assertParse(source)

    let declarations = namespaceDeclarations(in: source, languageFeatures: languageFeatures)
    XCTAssertEqual(declarations.map(\.name.text), ["HTTP"])
    XCTAssertEqual(declarations[0].memberBlock.members.count, 4)
  }

  func testNestedNamespace() {
    let source = """
      namespace Network {
        namespace HTTP {
          struct Request {}
        }
      }
      """

    assertParse(source)

    let declarations = namespaceDeclarations(in: source, languageFeatures: languageFeatures)
    XCTAssertEqual(declarations.map(\.name.text), ["Network", "HTTP"])
    XCTAssertEqual(declarations[0].memberBlock.members.count, 1)
    XCTAssertEqual(declarations[1].memberBlock.members.count, 1)
  }

  func testNamespaceRemainsAnIdentifierOutsideDeclarationShape() {
    let source = """
      let namespace = 0
      func namespace() {}
      namespace()
      namespace(namespace)
      namespace.member
      namespace {}
      """

    assertParse(source)
    XCTAssertTrue(namespaceDeclarations(in: source, languageFeatures: languageFeatures).isEmpty)

    // Two adjacent identifiers aren't enough to claim a declaration in a
    // mixed statement/declaration context; the member block must be present.
    XCTAssertTrue(
      namespaceDeclarations(
        in: "func f() { namespace value }",
        languageFeatures: languageFeatures
      ).isEmpty
    )
  }

  func testNamespaceDeclarationIsFeatureGated() {
    let declarations = namespaceDeclarations(
      in: "namespace HTTP {}",
      languageFeatures: []
    )

    XCTAssertTrue(declarations.isEmpty)
  }

  func testAttributesAndModifiersAreRetainedForDiagnostics() {
    let source = "@testable public namespace HTTP {}"

    assertParse(source)

    let declaration = namespaceDeclarations(in: source, languageFeatures: languageFeatures)[0]
    XCTAssertEqual(declaration.attributes.count, 1)
    XCTAssertEqual(declaration.modifiers.count, 1)
    XCTAssertEqual(declaration.modifiers.first?.name.text, "public")
  }

  func testMissingMemberBlockAfterModifierEstablishesDeclarationIntent() {
    let declaration = namespaceDeclarations(
      in: "public namespace HTTP",
      languageFeatures: languageFeatures
    )[0]

    XCTAssertEqual(declaration.memberBlock.leftBrace.presence, .missing)
    XCTAssertEqual(declaration.memberBlock.rightBrace.presence, .missing)
  }

  func testMissingNameInDeclarationContext() {
    let declaration = namespaceDeclarations(
      in: "struct Container { namespace {} }",
      languageFeatures: languageFeatures
    )[0]

    XCTAssertEqual(declaration.name.presence, .missing)
    XCTAssertEqual(declaration.memberBlock.leftBrace.presence, .present)
  }

  func testMissingRightBrace() {
    let declaration = namespaceDeclarations(
      in: "namespace HTTP {",
      languageFeatures: languageFeatures
    )[0]

    XCTAssertEqual(declaration.memberBlock.leftBrace.presence, .present)
    XCTAssertEqual(declaration.memberBlock.rightBrace.presence, .missing)
  }

  func testUnsupportedNamespaceHeaderSyntaxIsRecovered() {
    let sourcesAndNames = [
      ("namespace Generic<T> {}", "Generic"),
      ("namespace Inheriting: Protocol {}", "Inheriting"),
      ("namespace Constrained where T: Protocol {}", "Constrained"),
      ("namespace Network.HTTP {}", "Network"),
    ]

    for (source, expectedName) in sourcesAndNames {
      let declaration = namespaceDeclarations(in: source, languageFeatures: languageFeatures)[0]
      XCTAssertEqual(declaration.name.text, expectedName)
      XCTAssertNotNil(declaration.unexpectedBetweenNameAndMemberBlock)
    }
  }

  func testMalformedNamespaceNameIsRecovered() {
    for source in ["namespace class {}", "namespace 123 {}"] {
      let declaration = namespaceDeclarations(in: source, languageFeatures: languageFeatures)[0]
      XCTAssertEqual(declaration.name.presence, .missing)
      XCTAssertNotNil(declaration.unexpectedBetweenNamespaceKeywordAndName)
      XCTAssertEqual(declaration.memberBlock.leftBrace.presence, .present)
    }
  }

  /// Parses without asserting a particular diagnostic spelling. This is useful
  /// for feature-gating and recovery tests, where the important contract is the
  /// syntax shape and lossless round trip.
  private func namespaceDeclarations(
    in source: String,
    languageFeatures: Parser.LanguageFeatures
  ) -> [NamespaceDeclSyntax] {
    var parser = Parser(source, languageFeatures: languageFeatures)
    let tree = SourceFileSyntax.parse(from: &parser)
    XCTAssertEqual(tree.description, source)

    let collector = NamespaceDeclarationCollector(viewMode: .sourceAccurate)
    collector.walk(tree)
    return collector.declarations
  }
}

private final class NamespaceDeclarationCollector: SyntaxVisitor {
  var declarations: [NamespaceDeclSyntax] = []

  override func visit(_ node: NamespaceDeclSyntax) -> SyntaxVisitorContinueKind {
    declarations.append(node)
    return .visitChildren
  }
}
