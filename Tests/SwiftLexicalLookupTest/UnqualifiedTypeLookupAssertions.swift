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

/// Asserts the annotated `IdentifierTypeSyntax` expectation produces
/// the expected unqualified-type-lookup results (with the right
/// `CodeBlockItemListSyntax` scopes).
struct UnqualifiedTypeLookupMatcher {
  /// Marks a given 'CodeBlockItemListSyntax' in source.
  struct Definition {
    let typeDeclMarker: Character
  }

  /// Annotates an `IdentifierTypeSyntax` with the expected
  /// unqualified type lookup results (at that position).
  struct Expectation {
    let results: [GenericUnqualifiedTypeLookupResult<Character?>]
  }

  let lookupFile: SourceFileSyntax
  let configuredRegions: ConfiguredRegions?
}

// MARK: `Definition` Conformances

extension UnqualifiedTypeLookupMatcher.Definition: LexicalAnnotation, Identifiable, CustomStringConvertible {
  typealias SyntaxReference = CodeBlockItemListSyntax
  func findSyntaxFromToken(
    _ token: SwiftSyntax.TokenSyntax,
    verbose: Bool,
    file: StaticString,
    line: UInt
  ) -> CodeBlockItemListSyntax? {
    // Get the code block, then the statements
    LexicalAssertionUtilities.findDirectParent(
      from: token,
      ofType: CodeBlockSyntax.self,
      file: file,
      line: line
    )?.statements
  }

  var id: Character {
    typeDeclMarker
  }

  var description: String {
    typeDeclMarker.description
  }
}

// MARK: `Expectation` Conformances

extension UnqualifiedTypeLookupMatcher.Expectation: LexicalAnnotation {
  typealias SyntaxReference = IdentifierTypeSyntax

  func findSyntaxFromToken(
    _ token: TokenSyntax,
    verbose: Bool,
    file: StaticString,
    line: UInt
  ) -> IdentifierTypeSyntax? {
    LexicalAssertionUtilities.findDirectParent(
      from: token,
      ofType: IdentifierTypeSyntax.self,
      file: file,
      line: line
    )
  }
}

// MARK: `LexicalMatcher` Conformance

extension UnqualifiedTypeLookupMatcher: LexicalMatcher {
  func describeContextualizedExpectation(_ expectation: ContextualizedAnnotation<Expectation>) -> String {
    expectation.syntax.trimmedDescription
  }

  func assertExpectation(
    expectation: ContextualizedAnnotation<Expectation>,
    markersToDefinitions: [Character: ContextualizedAnnotation<Definition>],
    syntaxToDefinitions: [CodeBlockItemListSyntax: ContextualizedAnnotation<Definition>],
    verbose: Bool
  ) -> [ExpectationFailure] {
    var failures = [ExpectationFailure]()

    // File scope is has a `nil` marker
    let defaultFileName = "MyFile.swift"

    // Map the decls to their definitions
    //
    // Force unwrap because the syntax was parsed from a source file, so it
    // should be 'Attached'.
    let expectationSyntax = Attached(expectation.syntax)!
    let typeNameToken = TokenSyntax.identifier(expectation.syntax.trimmedDescription)
    let actualResults: [String] = expectationSyntax.findUnqualifiedType(
      Identifier(validating: typeNameToken)!,
      configuredRegions: configuredRegions
    )
    .compactMap({ lookupResult -> String? in
      let lookupResultDescription: String = lookupResult._describe(describeScope: { scopeSyntax -> String in
        // A file scope doesn't have a marker; return the file name instead
        if scopeSyntax.node.parent?.is(SourceFileSyntax.self) == true {
          return defaultFileName
        }

        // Get the scope's marker, or report the error
        guard let definition = syntaxToDefinitions[scopeSyntax.node] else {
          // Most CodeBlockItemListSyntax are part of an actual `With[Optional]CodeBlockSyntax`
          // scope; we get the latter for nicer diagnostics.
          let actualScope = scopeSyntax.node.parent?.parent
          let scopeDescription: String
          if let withCodeBlock = actualScope?.asProtocol((any WithCodeBlockSyntax).self) {
            scopeDescription = withCodeBlock.with(\.body, CodeBlockSyntax(statements: [])).trimmedDescription
          } else if let withCodeBlock = actualScope?.asProtocol((any WithOptionalCodeBlockSyntax).self) {
            scopeDescription = withCodeBlock.with(\.body, CodeBlockSyntax(statements: [])).trimmedDescription
          } else {
            // Fallback descriptions
            scopeDescription = actualScope?.trimmedDescription ?? "<no CodeBlockItemListSyntax grandparent>"
          }
          failures.append(
            ExpectationFailure.resultReferencesUnmarkedSyntax(
              syntaxDescription: "'\(lookupResult)' references `\(scopeDescription)`"
            )
          )
          return ""
        }
        return definition.annotation.typeDeclMarker.description
      })
      return lookupResultDescription
    })

    // Map the expectations to definitions
    let expectedResults: [String] = expectation.annotation.results
      .compactMap({ result -> String? in
        result._describe(describeScope: { scopeMarker in
          // `nil` marker indicates file scope
          guard let scopeMarker else { return defaultFileName }

          // Report invalid markers
          if markersToDefinitions[scopeMarker] == nil {
            failures.append(ExpectationFailure.referencesUndefinedMarker(scopeMarker))
          }
          return scopeMarker.description
        })
      })

    // If there are undefined markers / syntax nodes (i.e. failures isn't empty),
    // the comparison will be inaccurate, so give up now.
    guard failures.isEmpty else { return failures }

    // Diff results
    if actualResults != expectedResults {
      let expectedDescription = expectedResults.map({ "    \($0),\n" }).joined(separator: "")
      let actualDescription = actualResults.map({ "    \($0),\n" }).joined(separator: "")
      failures.append(
        .other(
          failure:
            "Invalid unqualified type-lookup results. Expected: [\n\(expectedDescription)]\nBut got:  [\n\(actualDescription)]"
        )
      )
    }

    return failures
  }
}

// MARK: Assert Function

/// A lookup source is an annotated string parsed as a `SourceFileSyntax`. Using
/// string interpolation, you can annotate `IdentifierTypeSyntax` nodes with
/// the expected `GenericUnqualifiedTypeLookupResult<Character?>` results.
/// These results use `Character?` markers as scopes; these markers should be
/// attached to `CodeBlockItemListSyntax` scopes.
///
/// See ``UnqualifiedTypeLookupTests`` for examples.
func assertUnqualifiedTypeLookup(
  _ lookupSource: LexicalLookupSource<UnqualifiedTypeLookupMatcher>,
  configuredRegions: ConfiguredRegions? = nil,
  file: StaticString = #file,
  line: UInt = #line,
  verbose: Bool = false
) {
  _assertLexicalLookup(
    ["MyFile": lookupSource],
    matcher: UnqualifiedTypeLookupMatcher(lookupFile: lookupSource.fileSyntax, configuredRegions: configuredRegions),
    file: file,
    line: line,
    verbose: verbose
  )
}

extension LexicalLookupSource.Interpolation where Matcher == UnqualifiedTypeLookupMatcher {
  /// Defines a `CodeBlockItemListSyntax`.
  mutating func appendInterpolation(
    _ marker: Character,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    append(definition: UnqualifiedTypeLookupMatcher.Definition(typeDeclMarker: marker), file: file, line: line)
  }

  /// Adds an expectation to a `DeclGroupSyntax` that the `findDirectMembers`
  /// with the parameters in `TestLookup` will return the value declarations
  /// with the given markers.
  mutating func appendInterpolation(
    results: [GenericUnqualifiedTypeLookupResult<Character?>],
    file: StaticString = #file,
    line: UInt = #line
  ) {
    appendInterpolation(
      expects: [UnqualifiedTypeLookupMatcher.Expectation(results: results)],
      file: file,
      line: line
    )
  }
}

// MARK: Convenience Constructors

extension GenericUnqualifiedTypeLookupResult where Scope == Character? {
  /// Creates a `GenericUnqualifiedTypeLookupResult.nonNestedTypeDecl`
  /// Parameters:
  /// - parent: The parent scope's marker, or `nil` for top-level (file scope).
  static func decls(
    _ decls: [Attached<TypeDeclSyntax>],
    inScope parentScope: Character?
  ) -> GenericUnqualifiedTypeLookupResult<Character?> {
    GenericUnqualifiedTypeLookupResult.nonNestedTypeDecl(
      decl: decls[0],
      redeclarations: Array(decls[1...]),
      parentScope: parentScope
    )
  }

  static func genericParameters(
    _ params: [Attached<GenericParameterSyntax>],
    inClause genericClause: Attached<GenericParameterClauseSyntax>
  ) -> GenericUnqualifiedTypeLookupResult<Character?> {
    GenericUnqualifiedTypeLookupResult.genericParameters(
      firstMatch: params[0],
      redeclarations: Array(params[1...]),
      genericClause: genericClause
    )
  }
}
