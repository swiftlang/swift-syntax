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

import SwiftIfConfig
@_spi(_QualifiedLookup) @_spi(_QualifiedLookupTests) import SwiftLexicalLookup
@_spi(ExperimentalLanguageFeatures) import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

// Convenience `String` initializer for `TypeDeclSyntax`; will
// crash at runtime if given a non `TypeDeclSyntax`.
extension TypeDeclSyntax: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self = Syntax(DeclSyntax(stringLiteral: value)).cast(TypeDeclSyntax.self)
  }
}

extension TypeReference {
  /// Convenience initializer since we ignore `introducingSyntax` in tests.
  init(module: Identifier? = nil, name: Identifier) {
    self.init(module: module, name: name, introducingSyntax: "")
  }
}

/// Asserts the given type syntax (when parsed prefixed with `typeSyntaxPrefix`),
/// produces the expected result.
func assertPartialResolutionResult(
  typeSyntaxPrefix: String = "let _: ",
  typeSyntax: String,
  result: Result<PartiallyResolvedType, PartialTypeResolutionFailure>,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  // Compute
  let syntax = Attached<TypeSyntax>.parse(typeSyntax, prefix: typeSyntaxPrefix)
  let actualResult = syntax.partiallyResolve()
  // Convert to strings to compare syntax
  let expectedDescription = result._debugDescription
  let actualDescription = actualResult._debugDescription
  // Keep syntax alive until we generate the descriptions
  _ = syntax
  XCTAssert(
    expectedDescription == actualDescription,
    "Wrong partial-resolution result for `\(typeSyntax)`:\nExpected: \(expectedDescription)\nGot     : \(actualDescription)",
    file: file,
    line: line
  )
}

final class PartialTypeResolutionTests: XCTestCase {
  /// Tests leaf non-nominal types (fully resolved)
  func testNonNominalLeaves() {
    // `Any`
    assertPartialResolutionResult(
      typeSyntax: "Any",
      result: .success(.anyType)
    )

    // Suppressed
    assertPartialResolutionResult(
      typeSyntax: "~Copyable",
      result: .success(.anyType)
    )
    assertPartialResolutionResult(
      typeSyntax: "~Escapable",
      result: .success(.anyType)
    )
    assertPartialResolutionResult(
      typeSyntax: "~Unechecked",
      result: .success(.anyType)
    )

    // Tuple
    assertPartialResolutionResult(
      typeSyntax: "(a: Int, Bool, c: String)",
      result: .success(
        .tuple(labels: ["a", nil, "c"])
      )
    )

    // Function
    assertPartialResolutionResult(
      typeSyntax: "(_ a: A, B) -> C",
      result: .failure(.functionType)
    )

    // Missing Type
    assertPartialResolutionResult(
      typeSyntax: "",
      result: .failure(.missingType)
    )
    // Wildcard
    assertPartialResolutionResult(
      typeSyntax: "_",
      result: .failure(.wildcardType)
    )

    // Metatype, named opaque return type, class restriction
    assertPartialResolutionResult(
      typeSyntax: "(() -> A, B).Type",
      result: .success(.metatype(base: "(() -> A, B)"))
    )
    assertPartialResolutionResult(
      typeSyntax: "<T: Hashable> [T]",
      result: .success(.composition([]))
    )
    // I.e. Test `class` in `protocol A: class`.
    assertPartialResolutionResult(
      typeSyntaxPrefix: "protocol A: ",
      typeSyntax: "class",
      result: .success(.composition([]))
    )
  }
  /// Tests identifier types
  func testIdentifiers() {
    // Simply type
    assertPartialResolutionResult(
      typeSyntax: "A",
      result: .success(
        .typeIdentifier(TypeReference(name: "A"))
      )
    )
    // Module selector
    assertPartialResolutionResult(
      typeSyntax: "Module::Type",
      result: .success(
        .typeIdentifier(TypeReference(module: "Module", name: "Type"))
      )
    )
    // Erroneous
    assertPartialResolutionResult(
      typeSyntax: "Module::_",
      result: .failure(.invalidTypeIdentifier)
    )

    // Members
    assertPartialResolutionResult(
      typeSyntax: "(Int & (A, B)).MyMember",
      result: .success(
        .member(
          base: "(Int & (A, B))",
          memberComponent: TypeReference(name: "MyMember")
        )
      )
    )
    // Members with module selectors
    assertPartialResolutionResult(
      typeSyntax: "(A & B).Module::C",
      result: .success(
        .member(
          base: "(A & B)",
          memberComponent: TypeReference(module: "Module", name: "C")
        )
      )
    )
    // Test 'Self' and '`Self`' members (not special)
    assertPartialResolutionResult(
      typeSyntax: "(() -> Int).Self",
      result: .success(
        .member(
          base: "(() -> Int)",
          memberComponent: TypeReference(name: "Self")
        )
      )
    )
    assertPartialResolutionResult(
      typeSyntax: "(() -> Int).`Self`",
      result: .success(
        .member(
          base: "(() -> Int)",
          memberComponent: TypeReference(name: "Self")
        )
      )
    )

    // Keywords that turns into identifiers
    //
    // Escaped `Any`
    assertPartialResolutionResult(
      typeSyntax: "`Any`",
      result: .success(
        .typeIdentifier(TypeReference(name: "Any"))
      )
    )
    // Module+Any keyword -> type identifier
    assertPartialResolutionResult(
      typeSyntax: "MyModule::Any",
      result: .success(.typeIdentifier(TypeReference(module: "MyModule", name: "Any")))
    )
    // Self -> type identifier
    assertPartialResolutionResult(
      typeSyntax: "Self",
      result: .success(.typeIdentifier(TypeReference(name: "Self")))
    )
    assertPartialResolutionResult(
      typeSyntax: "MyModule::Self",
      result: .success(.typeIdentifier(TypeReference(module: "MyModule", name: "Self")))
    )
    // .self -> type identifier
    assertPartialResolutionResult(
      typeSyntax: "A.`self`",
      result: .success(
        .member(base: "A", memberComponent: TypeReference(name: "self"))
      )
    )
    assertPartialResolutionResult(
      typeSyntax: "A.self",
      result: .success(
        .member(base: "A", memberComponent: TypeReference(name: "self"))
      )
    )
    assertPartialResolutionResult(
      typeSyntax: "A.Module::self",
      result: .success(
        .member(base: "A", memberComponent: TypeReference(module: "Module", name: "self"))
      )
    )
  }

  func testKnownNominals() {
    // Optional
    assertPartialResolutionResult(
      typeSyntax: "T?",
      result: .success(
        .typeIdentifier(TypeReference(module: "Swift", name: "Optional"))
      )
    )
    assertPartialResolutionResult(
      typeSyntax: "T!",
      result: .success(
        .typeIdentifier(TypeReference(module: "Swift", name: "Optional"))
      )
    )
    // Array
    assertPartialResolutionResult(
      typeSyntax: "[T]",
      result: .success(
        .typeIdentifier(TypeReference(module: "Swift", name: "Array"))
      )
    )
    // Inline array
    assertPartialResolutionResult(
      typeSyntax: "[_ of T]",
      result: .success(
        .typeIdentifier(
          TypeReference(module: "Swift", name: "InlineArray")
        )
      )
    )
    // Dictionary
    assertPartialResolutionResult(
      typeSyntax: "[T: S]",
      result: .success(
        .typeIdentifier(
          TypeReference(module: "Swift", name: "Dictionary")
        )
      )
    )
  }

  func testNonNominalRecursive() {
    // Single-element tuples
    assertPartialResolutionResult(
      typeSyntax: "(Any,)",
      result: .success(.anyType)
    )
    assertPartialResolutionResult(
      typeSyntax: "((label1: A, _: B))",
      result: .success(.tuple(labels: ["label1", nil]))
    )

    // Attributed type
    assertPartialResolutionResult(
      typeSyntax: "sending (A, B)",
      result: .success(.tuple(labels: [nil, nil]))
    )
    assertPartialResolutionResult(
      typeSyntax: "@escapable @Sendable () -> Int",
      result: .failure(.functionType)
    )

    // Opaque/any types
    assertPartialResolutionResult(
      typeSyntax: "some Proto & Class",
      result: .success(.composition(["Proto", "Class"]))
    )
    assertPartialResolutionResult(
      typeSyntax: "any A",
      result: .success(
        .typeIdentifier(TypeReference(name: "A"))
      )
    )

    // Parameter elements/expansions
    assertPartialResolutionResult(
      typeSyntax: "repeat each T",
      result: .success(
        .typeIdentifier(TypeReference(name: "T"))
      )
    )

    // Compositions
    assertPartialResolutionResult(
      typeSyntax: "Module::MyType & Any",
      result: .success(
        .composition([
          "Module::MyType",
          "Any",
        ])
      )
    )
  }
}
