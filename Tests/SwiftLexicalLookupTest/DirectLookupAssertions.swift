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
@_spi(_QualifiedLookup) @_spi(_QualifiedLookupTests) @_spi(Experimental) import SwiftLexicalLookup
import SwiftSyntax
import XCTest

/// Asserts that the annotated `ValueDeclSyntax` matches the given
/// declaration-name references.
struct DirectLookupMatcher {
  /// Marks a given 'ValueDeclSyntax' in source.
  struct Definition {
    let valueDeclMarker: Character
  }

  /// Annotates `ValueDeclSyntax` with the expected declaration-name references
  /// and the other results that each reference should yield.
  struct Expectation {
    let nameReference: DeclNameReference
    let kind: MemberKind
    let results: [Character]
  }

  let lookupFile: SourceFileSyntax
}

// MARK: `Definition` Conformances

extension DirectLookupMatcher.Definition: LexicalAnnotation, Identifiable, CustomStringConvertible {
  typealias SyntaxReference = ValueDeclSyntax
  func findSyntaxFromToken(
    _ token: SwiftSyntax.TokenSyntax,
    verbose: Bool,
    file: StaticString,
    line: UInt
  ) -> ValueDeclSyntax? {
    LexicalAssertionUtilities.findDirectParent(
      from: token,
      ofType: ValueDeclSyntax.self,
      file: file,
      line: line
    )
  }

  var id: Character {
    valueDeclMarker
  }

  var description: String {
    valueDeclMarker.description
  }
}

// MARK: `Expectation` Conformances

extension DirectLookupMatcher.Expectation: LexicalAnnotation {
  typealias SyntaxReference = DeclGroupSyntaxType

  func findSyntaxFromToken(
    _ token: TokenSyntax,
    verbose: Bool,
    file: StaticString,
    line: UInt
  ) -> DeclGroupSyntaxType? {
    LexicalAssertionUtilities.findDirectParent(
      from: token,
      ofType: DeclGroupSyntaxType.self,
      file: file,
      line: line
    )
  }
}

// MARK: `LexicalMatcher` Conformance

extension DirectLookupMatcher: LexicalMatcher {
  func describeContextualizedExpectation(_ expectation: ContextualizedAnnotation<Expectation>) -> String {
    // Remove member block for readability
    "`\(expectation.syntax._memberlessDescription)` > \(expectation.annotation.nameReference) \(expectation.annotation.kind)"
  }

  func assertExpectation(
    expectation: ContextualizedAnnotation<Expectation>,
    markersToDefinitions: [Character: ContextualizedAnnotation<Definition>],
    syntaxToDefinitions: [ValueDeclSyntax: ContextualizedAnnotation<Definition>],
    verbose: Bool
  ) -> [ExpectationFailure] {
    var failures = [ExpectationFailure]()

    // Map the decls to their definitions
    let actualResults = expectation.syntax.findDirectMembers(
      name: expectation.annotation.nameReference,
      kind: expectation.annotation.kind
    )
    .compactMap({ valueDecl -> ContextualizedAnnotation<Definition>? in
      guard let valueDecl = syntaxToDefinitions[valueDecl] else {
        failures.append(
          ExpectationFailure.resultReferencesUnmarkedSyntax(syntaxDescription: valueDecl.trimmedDescription)
        )
        return nil
      }
      return valueDecl
    })

    // Map the expectations to definitions
    let expectedResults = expectation.annotation.results
      .compactMap({ marker -> ContextualizedAnnotation<Definition>? in
        guard let valueDecl = markersToDefinitions[marker] else {
          failures.append(ExpectationFailure.referencesUndefinedMarker(marker))
          return nil
        }
        return valueDecl
      })

    // Diff results
    LexicalAssertionUtilities.diffLexicalResults(
      expected: expectedResults,
      actual: actualResults,
      failures: &failures
    )

    return failures
  }
}

// MARK: Assert Function

/// A lookup source is an annotated string parsed as a `SourceFileSyntax`. Using
/// string interpolation, you can mark `ValueDeclSyntax` nodes, and attach
/// expectations to a `DeclGroupSyntaxType` (nominal type or extension). We
/// test the results of `DeclGroupSyntax/findDirectMembers`.
///
/// ### Usage
///
/// We 'define' `ValueDeclSyntax` nodes by prepending `\("🟥")`. Then, we attach
/// expectations before a declaration group with:
/// ```swift
/// \(members: [
///   TestLookup(...): ["🟥", ...]
/// ])
/// ```
/// `TestLookup` specifies the name and member kind passed to
/// ``DeclGroupSyntax/findDirectMembers``. We expect lookup to return the
/// declarations with the given markers, e.g., the declaration marked '🟥'.
///
/// See ``DirectLookupTests`` for examples.
func assertDirectLookup(
  _ lookupSource: LexicalLookupSource<DirectLookupMatcher>,
  configuredRegions: ConfiguredRegions? = nil,
  file: StaticString = #file,
  line: UInt = #line,
  verbose: Bool = false
) {
  _assertLexicalLookup(
    ["MyFile": lookupSource],
    matcher: DirectLookupMatcher(lookupFile: lookupSource.fileSyntax),
    file: file,
    line: line,
    verbose: verbose
  )
}

// MARK: String-Interpolation Helpers

extension Identifier: ExpressibleByStringLiteral {
  /// Important: Only use for testing
  public init(stringLiteral value: StaticString) {
    self.init(canonicalName: value)
  }
}

/// Specifies the `DeclNameReferenceBase` and `MemberKind` to use
/// as filters when performing direct lookup on the given declaration.
///
/// See `assertDirectLookup` for more.
struct TestLookup {
  var name: DeclNameReferenceBase
  var kind: MemberKind

  init(_ name: DeclNameReferenceBase, kind: MemberKind = .default) {
    self.name = name
    self.kind = kind
  }
}

extension LexicalLookupSource.Interpolation where Matcher == DirectLookupMatcher {
  /// Defines a `ValueDeclSyntax`.
  mutating func appendInterpolation(
    _ marker: Character,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    append(definition: DirectLookupMatcher.Definition(valueDeclMarker: marker), file: file, line: line)
  }

  /// Adds an expectation to a `DeclGroupSyntax` that the `findDirectMembers`
  /// with the parameters in `TestLookup` will return the value declarations
  /// with the given markers.
  mutating func appendInterpolation(
    members: KeyValuePairs<TestLookup, [Character]>,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    appendInterpolation(
      expects: members.map({
        DirectLookupMatcher.Expectation(nameReference: DeclNameReference(baseName: $0.name), kind: $0.kind, results: $1)
      }),
      file: file,
      line: line
    )
  }
}
