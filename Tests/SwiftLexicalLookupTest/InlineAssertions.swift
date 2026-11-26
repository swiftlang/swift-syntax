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

@_spi(_QualifiedLookup) @_spi(_QualifiedLookupTests) import SwiftLexicalLookup
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest

/// An annotation (used for ``LexicalMatcher`` definitions and expectations)
/// associates testing data with a syntax node in the given ``LexicalLookupSource``.
///
/// Used by ``_assertLexicalLookup``.
protocol LexicalAnnotation {
  associatedtype SyntaxReference: SyntaxProtocol, SyntaxHashable
  func findSyntaxFromToken(_ token: TokenSyntax, verbose: Bool, file: StaticString, line: UInt) -> SyntaxReference?
}

/// A ``LexicalAnnotation`` resolved by ``_assertLexicalLookup`` to include
/// the target syntax and source-location information.
struct ContextualizedAnnotation<Annotation: LexicalAnnotation> {
  let annotation: Annotation
  let syntax: Annotation.SyntaxReference
  let file: StaticString
  let line: UInt
}

/// A matcher asserts a particular expectation with access to the
/// lexical information and definitions collected by `_assertLexicalLookup`.
protocol LexicalMatcher {
  associatedtype Definition: LexicalAnnotation, Identifiable, CustomStringConvertible
  associatedtype Expectation: LexicalAnnotation
  typealias ExpectationFailure = LexicalMatcherExpectationFailure<Definition>

  /// Asserts the given expectation by returning failures.
  ///
  /// ### Implementation Note
  ///
  /// We're given two maps for definitions:
  /// 1. the markers->definitions map helps us convert markers from expectations
  ///    to actual definitions
  /// 2. the syntax->definitions map helps us convert the lookup output's syntax
  ///    to actual definitions
  /// Then, you can use methods like ``LexicalAssertionUtilities/diffLexicalResults``
  /// to diff the expected vs lookup-produced definitions.
  func assertExpectation(
    expectation: ContextualizedAnnotation<Expectation>,
    markersToDefinitions: [Definition.ID: ContextualizedAnnotation<Definition>],
    syntaxToDefinitions: [Definition.SyntaxReference: ContextualizedAnnotation<Definition>],
    verbose: Bool
  ) -> [ExpectationFailure]

  /// Describes the expectation's syntax to provide more useful `XCTFail` messages.
  func describeContextualizedExpectation(_ expectation: ContextualizedAnnotation<Expectation>) -> String
}

/// A source file annotated with definitions and expectations on those definitions.
///
/// All annotations should be placed before the target token.
///
/// Look for examples in `assertTypeResolution` and related assertion methods.
struct LexicalLookupSource<Matcher: LexicalMatcher>: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
  enum Annotation {
    case definition(definition: Matcher.Definition)
    case expectations(expectations: [Matcher.Expectation])
  }
  enum Component {
    case stringFragment(String)
    case annotation(annotation: Annotation, file: StaticString, line: UInt)
  }

  struct Interpolation: ExpressibleByStringInterpolation, StringInterpolationProtocol {
    typealias StringInterpolation = Self

    fileprivate var components: [Component]
    /// A strong reference to identifier tokens used by `allocateIdentifier`
    fileprivate var identifierTokens: [TokenSyntax]

    init(literalCapacity: Int = 0, interpolationCount: Int = 0) {
      components = []
      identifierTokens = []
    }

    init(stringLiteral: String) {
      self.init()
      appendLiteral(stringLiteral)
    }
    init(stringInterpolation: LexicalLookupSource<Matcher>.Interpolation) {
      self = stringInterpolation
    }
    mutating func appendLiteral(_ literal: String) {
      components.append(.stringFragment(literal))
    }
    mutating func append(
      definition: Matcher.Definition,
      file: StaticString = #file,
      line: UInt = #line
    ) {
      components.append(.annotation(annotation: .definition(definition: definition), file: file, line: line))
    }
    mutating func appendInterpolation(
      expects expectations: [Matcher.Expectation],
      file: StaticString = #file,
      line: UInt = #line
    ) {
      components.append(.annotation(annotation: .expectations(expectations: expectations), file: file, line: line))
    }

    /// Merge interpolation
    mutating func appendInterpolation(
      interpolation: Interpolation
    ) {
      self.components.append(contentsOf: interpolation.components)
      self.identifierTokens.append(contentsOf: interpolation.identifierTokens)
    }

    /// A correct way to create identifiers from strings. These identifier's lifetime
    /// is tired to `LexicalLookupSource.Interpolation`, passed onto `LexicalLookupSource`
    /// and should stay alive for `_assertLexicalLookup`.
    mutating func allocateIdentifier(string: String) -> Identifier {
      let token = TokenSyntax.identifier(string)
      identifierTokens.append(token)
      // Force unwrap because we're passing an identifier token.
      return Identifier(token)!
    }
  }

  /// The source with all definitions/expectations removed
  let fileSource: String
  /// Parsed `source`
  let fileSyntax: SourceFileSyntax
  /// A list of annotations, their source index and source location.
  let annotations: [(index: String.Index, annotation: Annotation, file: StaticString, line: UInt)]

  /// Gets the token from the source at the given index of `fileSource`.
  ///
  /// IMPORTANT: Only use for indices acquired from `annotations`.
  func getSourceToken(at index: String.Index) -> TokenSyntax? {
    let sourcePosition = AbsolutePosition(
      utf8Offset: fileSource.distance(
        from: fileSource.startIndex,
        to: index
      )
    )
    return fileSyntax.token(at: sourcePosition)
  }

  init(stringInterpolation: Interpolation) {
    var source = ""
    var annotations = [(index: String.Index, annotation: Annotation, file: StaticString, line: UInt)]()

    for component in stringInterpolation.components {
      switch component {
      case .stringFragment(let str):
        source.append(str)
      case .annotation(let annotation, let file, let line):
        // Get the endIndex so we refer to the token after the expectation
        let index = source.endIndex

        // Diagnose same annotation in the same location
        if let lastAnnotation = annotations.last,
          lastAnnotation.index == index
        {
          XCTFail(
            "[Lookup Failure] Second annotation for same source index is prohibited (original annotation at \(lastAnnotation.file):\(lastAnnotation.line))",
            file: file,
            line: line
          )
          continue
        }
        // Save expectation
        annotations.append((index, annotation, file: file, line: line))
      }
    }

    // Parse file
    var parser = Parser(source)

    self.fileSource = source
    self.fileSyntax = SourceFileSyntax.parse(from: &parser)
    self.annotations = annotations
  }

  init(stringLiteral value: String) {
    // Just use the interpolation initializer
    var interpolation = Interpolation(literalCapacity: 1, interpolationCount: 0)
    interpolation.appendLiteral(value)
    self.init(stringInterpolation: interpolation)
  }
}

/// Used by ``LexicalMatcher/assertExpectation`` to report errors back
/// to `_assertLexicalLookup`.
enum LexicalMatcherExpectationFailure<Definition: LexicalAnnotation & Identifiable> {
  /// This expectation references a marker that wasn't declared in source
  case referencesUndefinedMarker(Definition.ID)
  /// The produced lookup result produces a syntax that hasn't
  /// been annotated with a marker
  case resultReferencesUnmarkedSyntax(syntaxDescription: String)
  /// The result didn't produce the expected marker
  case resultMissesDefinitions([ContextualizedAnnotation<Definition>])
  /// The result added an additional (unexpected) marker
  case resultAddsDefinitions([ContextualizedAnnotation<Definition>])
  /// Results are in the wrong order
  case invalidResultOrder(
    expected: [ContextualizedAnnotation<Definition>],
    actual: [ContextualizedAnnotation<Definition>]
  )
  /// Wrong result type. E.g., expected failure, but succeeded
  case other(failure: String)

  /// Converts this failure to a string for `XCTFail`.
  func describe(describeDefinition: (ContextualizedAnnotation<Definition>) -> String) -> String {
    switch self {
    case .referencesUndefinedMarker(let marker):
      "Expectation references undefined marker '\(marker)'"
    case .resultReferencesUnmarkedSyntax(let syntaxDescription):
      "Lookup result references syntax that wasn't marked: `\(syntaxDescription)`"
    case .resultMissesDefinitions(let definitions):
      "Lookup didn't find expected result '\(definitions.map(describeDefinition))'"
    case .resultAddsDefinitions(let definitions):
      "Lookup introduced unexpected result '\(definitions.map(describeDefinition))'"
    case .invalidResultOrder(let expected, let actual):
      "Lookup returned results in wrong order. Expected: \(expected.map(describeDefinition)). Got: \(actual.map(describeDefinition))"
    case .other(let failure):
      failure
    }
  }
}

// MARK: _assertLexicalLookup

/// Verifies the provided annotated sources and drives `Matcher`
/// to verify lookup results.
///
/// You should wrap this method using a custom `Matcher`
/// for each use-case. See `assertTypeResolution` as an example.
///
/// Note: We don't diagnose unused definition annotations.
func _assertLexicalLookup<Matcher: LexicalMatcher>(
  _ lookupSources: KeyValuePairs<String, LexicalLookupSource<Matcher>>,
  matcher: Matcher,
  file: StaticString,
  line: UInt,
  verbose: Bool = false
) {
  // Find the expected syntax for each definition and expectation.
  //
  // See why we create two maps to definitions: markers->definitions, and
  // syntax->definitions in `LexicalMatcher/assertExpectation`
  var markersToDefinitions = [Matcher.Definition.ID: ContextualizedAnnotation<Matcher.Definition>]()
  var syntaxToDefinitions = [Matcher.Definition.SyntaxReference: ContextualizedAnnotation<Matcher.Definition>]()
  var contextualizedExpectations = [ContextualizedAnnotation<Matcher.Expectation>]()
  for (_, lookupSource) in lookupSources {
    for (annotationSourceIndex, annotation, file, line) in lookupSource.annotations {
      // Get the token at this index (e.g. 'struct')
      let token = lookupSource.getSourceToken(at: annotationSourceIndex)
      guard let token else {
        XCTFail(
          "[Internal Error] Unexpectedly couldn't find token for annotation.",
          file: file,
          line: line
        )
        continue
      }

      // Find the annotated syntax and save
      switch annotation {
      case .definition(let definition):
        // Ensure we're not overwriting a previous one.
        guard markersToDefinitions[definition.id] == nil else {
          XCTFail(
            "Duplicate definition marker '\(definition.id)': Unexpectedly found the same marker in a different lexical definition.",
            file: file,
            line: line
          )
          continue
        }

        // Find annotated syntax
        guard let definitionSyntax = definition.findSyntaxFromToken(token, verbose: verbose, file: file, line: line)
        else {
          // We leave diagnostics to `findSyntaxFromToken` since they'll be more precise
          continue
        }

        // Ensure this syntax has only one marker
        if let existingDefinitionID = syntaxToDefinitions[definitionSyntax] {
          XCTFail(
            "Duplicate marker: Syntax '\(definitionSyntax.trimmedDescription)' was already annotated with '\(existingDefinitionID)' and can't be re-defined as '\(definition.id)'",
            file: file,
            line: line
          )
          continue
        }

        // Save
        let contextualizedDefinition = ContextualizedAnnotation(
          annotation: definition,
          syntax: definitionSyntax,
          file: file,
          line: line
        )
        markersToDefinitions[definition.id] = contextualizedDefinition
        syntaxToDefinitions[definitionSyntax] = contextualizedDefinition
      case .expectations(let expectations):
        for expectation in expectations {
          // Find annotated syntax (like above)
          guard
            let expectationSyntax = expectation.findSyntaxFromToken(token, verbose: verbose, file: file, line: line)
          else {
            // We leave diagnostics to `findSyntaxFromToken` since they'll be more precise
            continue
          }

          // Save
          contextualizedExpectations.append(
            ContextualizedAnnotation(annotation: expectation, syntax: expectationSyntax, file: file, line: line)
          )
        }
      }
    }

    // Try to match each expectation with at least one definition
    for contextualizedExpectation in contextualizedExpectations {
      // Assert the expectations
      let failures = matcher.assertExpectation(
        expectation: contextualizedExpectation,
        markersToDefinitions: markersToDefinitions,
        syntaxToDefinitions: syntaxToDefinitions,
        verbose: verbose
      )
      let syntaxDescription = matcher.describeContextualizedExpectation(contextualizedExpectation)
      for failure in failures {
        let failureDescription = failure.describe(describeDefinition: \.annotation.description)
        XCTFail(
          "[Lookup of `\(syntaxDescription)`] \(failureDescription)",
          file: contextualizedExpectation.file,
          line: contextualizedExpectation.line
        )
      }
    }
  }
}

enum LexicalAssertionUtilities {
  /// Find the direct parent of the given token and cast it to the desired
  /// `Parent` syntax type.
  ///
  /// Parameters:
  /// - annotationKindDescription: Helps make the casting-failure message more
  ///   specific.
  static func findDirectParent<Parent: SyntaxProtocol>(
    from introducerToken: TokenSyntax,
    ofType _: Parent.Type,
    file: StaticString,
    line: UInt,
    annotationKindDescription: String? = nil
  ) -> Parent? {
    // Get parent
    guard let rawParent = introducerToken.parent else {
      XCTFail(
        "Annotation lacks parent: Token '\(introducerToken.trimmedDescription)' has no parent node.",
        file: file,
        line: line
      )
      return nil
    }

    // Cast to right type
    guard let parent = rawParent.as(Parent.self) else {
      // Explains why the casting is necessary
      let messageQualifier: String
      if let annotationKindDescription {
        messageQualifier = " for \(annotationKindDescription) annotations."
      } else {
        messageQualifier = ""
      }

      XCTFail(
        "Invalid annotation placement: Token '\(introducerToken.trimmedDescription)' should have a \(Parent.self) parent (not '\(rawParent.kind)')\(messageQualifier).",
        file: file,
        line: line
      )
      return nil
    }

    return parent
  }

  static func diffLexicalResults<Definition: LexicalAnnotation & Identifiable>(
    expected: [ContextualizedAnnotation<Definition>],
    actual: [ContextualizedAnnotation<Definition>],
    failures: inout [LexicalMatcherExpectationFailure<Definition>]
  ) {
    // Convert to sets
    let expectedMarkers = Set(expected.map(\.annotation.id))
    let actualMarkers = Set(actual.map(\.annotation.id))

    // Calculate differences
    let missingDefinitions = expected.filter({ !actualMarkers.contains($0.annotation.id) })
    if !missingDefinitions.isEmpty {
      failures.append(.resultMissesDefinitions(missingDefinitions))
    }
    let addedDefinitions = actual.filter({ !expectedMarkers.contains($0.annotation.id) })
    if !addedDefinitions.isEmpty {
      failures.append(.resultAddsDefinitions(addedDefinitions))
    }

    // Check order (if there are no misses/additions)
    if missingDefinitions.isEmpty, addedDefinitions.isEmpty,
      expected.map(\.annotation.id) != actual.map(\.annotation.id)
    {
      failures.append(.invalidResultOrder(expected: expected, actual: actual))
    }
  }
}

// MARK: TypeSyntax + String Literal

extension TypeLikeSyntax: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.init(TypeSyntax(stringLiteral: value))
  }
}

// MARK: Attached + String Literal

public protocol ParsableByAttached: SyntaxProtocol {
  static func fileContents(prefix: String?, syntaxString: String) -> String
}

extension TypeSyntax: ParsableByAttached {
  public static func fileContents(prefix: String?, syntaxString: String) -> String {
    "\(prefix ?? "typealias = ")\(syntaxString)"
  }
}
extension NominalTypeDeclSyntax: ParsableByAttached {
  public static func fileContents(prefix: String?, syntaxString: String) -> String {
    // Nominal-type declarations parse as declarations
    syntaxString
  }
}
extension TypeDeclSyntax: ParsableByAttached {
  public static func fileContents(prefix: String?, syntaxString: String) -> String {
    // Type declarations parse as declarations
    syntaxString
  }
}
extension GenericParameterSyntax: ParsableByAttached {
  public static func fileContents(prefix: String?, syntaxString: String) -> String {
    // Create a fake function to parse `< ... >` as a GenericParameterClauseSyntax
    "\(prefix ?? "func ")<\(syntaxString)>"
  }
}
extension GenericParameterClauseSyntax: ParsableByAttached {
  public static func fileContents(prefix: String?, syntaxString: String) -> String {
    // Create a fake function to parse the given `<T1, ..., TN>`
    // as a GenericParameterClauseSyntax
    "\(prefix ?? "func ")\(syntaxString)"
  }
}
extension ExtensionDeclSyntax: ParsableByAttached {
  public static func fileContents(prefix: String?, syntaxString: String) -> String { syntaxString }
}
extension DeclGroupSyntaxType: ParsableByAttached {
  public static func fileContents(prefix: String?, syntaxString: String) -> String { syntaxString }
}

extension Attached: ExpressibleByStringLiteral
    & ExpressibleByExtendedGraphemeClusterLiteral
    & ExpressibleByUnicodeScalarLiteral
where
  Node: ParsableByAttached
{
  public static func parse(
    _ string: String,
    prefix: String? = nil,
    file: StaticString = #file,
    line: UInt = #line
  ) -> Self {
    // Wrap the type syntax in a file
    var parser = Parser(Node.fileContents(prefix: prefix, syntaxString: string))
    let sourceFile = SourceFileSyntax.parse(from: &parser)
    guard let castSyntax = sourceFile.children(ofType: Node.self).first else {
      fatalError("Couldn't parse `\(string)` as \(Node.self).", file: file, line: line)
    }
    // We should now be able to cast to SourceFileRoot
    return Attached(castSyntax)!
  }
  public init(stringLiteral string: String) {
    self = .parse(string)
  }
}
