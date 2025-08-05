//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
@_spi(FixItApplier) import SwiftIDEUtils
@_spi(Testing) @_spi(RawSyntax) @_spi(AlternateTokenIntrospection) @_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(RawSyntax) import SwiftParserDiagnostics
@_spi(RawSyntax) import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

// MARK: Lexing Assertions

struct LexemeSpec {
  let rawTokenKind: RawTokenKind
  let leadingTrivia: SyntaxText
  let tokenText: SyntaxText
  let trailingTrivia: SyntaxText
  let errorLocationMarker: String
  let diagnostic: String?
  let flags: Lexer.Lexeme.Flags

  /// The file and line at which this `LexemeSpec` was created, so that assertion failures can be reported at its location.
  let file: StaticString
  let line: UInt

  init(
    _ rawTokenKind: RawTokenKind,
    leading: SyntaxText = "",
    text: SyntaxText,
    trailing: SyntaxText = "",
    errorLocationMarker: String = "1️⃣",
    diagnostic: String? = nil,
    flags: Lexer.Lexeme.Flags = [],
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    self.rawTokenKind = rawTokenKind
    self.leadingTrivia = leading
    self.tokenText = text
    self.trailingTrivia = trailing
    self.errorLocationMarker = errorLocationMarker
    self.diagnostic = diagnostic
    self.flags = flags
    self.file = file
    self.line = line
  }
}

/// Asserts that two lexical streams are structurally equal, including their trivia and any
/// text.
///
/// - Parameters:
///   - lhs: The actual lexeme stream.
///   - rhs: The expected lexeme stream.
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///     which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///     function was called.
private func assertTokens(
  _ actual: [Lexer.Lexeme],
  _ expected: [LexemeSpec],
  markerLocations: [String: Int],
  file: StaticString = #filePath,
  line: UInt = #line
) {
  guard actual.count == expected.count else {
    return XCTFail(
      """
      Expected \(expected.count) tokens but got \(actual.count):
      \(actual.map({ "\($0.rawTokenKind) '\($0.tokenText)'" }).joined(separator: "\n"))
      """,
      file: file,
      line: line
    )
  }

  // The byte offset at which the leading trivia of `actualLexeme` starts.
  var lexemeStartOffset = 0
  for (actualLexeme, expectedLexeme) in zip(actual, expected) {
    defer {
      lexemeStartOffset += actualLexeme.byteLength
    }
    if actualLexeme.rawTokenKind != expectedLexeme.rawTokenKind {
      XCTFail(
        "Expected token kind \(expectedLexeme.rawTokenKind) but got \(actualLexeme.rawTokenKind)",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }

    if actualLexeme.leadingTriviaText != expectedLexeme.leadingTrivia {
      assertStringsEqualWithDiff(
        String(syntaxText: actualLexeme.leadingTriviaText),
        String(syntaxText: expectedLexeme.leadingTrivia),
        "Leading trivia does not match",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }

    if actualLexeme.tokenText.debugDescription != expectedLexeme.tokenText.debugDescription {
      assertStringsEqualWithDiff(
        actualLexeme.tokenText.debugDescription,
        expectedLexeme.tokenText.debugDescription,
        "Token text does not match",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }

    if actualLexeme.trailingTriviaText != expectedLexeme.trailingTrivia {
      assertStringsEqualWithDiff(
        String(syntaxText: actualLexeme.trailingTriviaText),
        String(syntaxText: expectedLexeme.trailingTrivia),
        "Trailing trivia does not match",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }

    switch (actualLexeme.diagnostic, expectedLexeme.diagnostic) {
    case (nil, nil): break
    case (nil, .some):
      XCTFail(
        "Expected an error but did not receive one",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    case (let actualError?, nil):
      XCTFail(
        "Did not expect an error but got \(actualError.kind) at \(actualError.byteOffset)",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    case (let actualError?, let expectedError?):
      // Create a token from the lexeme so we can pass it to `TokenDiagnostic.diagnosticMessage(in:)`
      let arena = ParsingRawSyntaxArena(parseTriviaFunction: TriviaParser.parseTrivia)
      let rawToken = RawTokenSyntax(
        kind: actualLexeme.rawTokenKind,
        wholeText: arena.intern(actualLexeme.wholeText),
        textRange: actualLexeme.textRange,
        presence: .present,
        tokenDiagnostic: actualLexeme.diagnostic,
        arena: arena
      )
      let token = Syntax(raw: RawSyntax(rawToken), rawNodeArena: arena).cast(TokenSyntax.self)
      assertStringsEqualWithDiff(
        actualError.diagnosticMessage(in: token).message,
        expectedError,
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
      if let location = markerLocations[expectedLexeme.errorLocationMarker] {
        XCTAssertEqual(
          Int(actualError.byteOffset),
          location - lexemeStartOffset,
          "Expected location did not match",
          file: expectedLexeme.file,
          line: expectedLexeme.line
        )
      } else {
        XCTFail(
          "Did not find marker \(expectedLexeme.errorLocationMarker) in the source code",
          file: expectedLexeme.file,
          line: expectedLexeme.line
        )
      }
    }

    if actualLexeme.flags != expectedLexeme.flags {
      XCTFail(
        "Expected flags \(expectedLexeme.flags.debugDescription) but got \(actualLexeme.flags.debugDescription)",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }
  }
}

func assertLexemes(
  _ markedSource: String,
  lexemes expectedLexemes: [LexemeSpec],
  experimentalFeatures: Parser.ExperimentalFeatures = [],
  file: StaticString = #filePath,
  line: UInt = #line
) {
  var (markerLocations, source) = extractMarkers(markedSource)
  markerLocations["START"] = 0
  var expectedLexemes = expectedLexemes
  if expectedLexemes.last?.rawTokenKind != .endOfFile {
    expectedLexemes.append(LexemeSpec(.endOfFile, text: ""))
  }
  let lookaheadTracker = UnsafeMutablePointer<LookaheadTracker>.allocate(capacity: 1)
  defer {
    lookaheadTracker.deallocate()
  }
  lookaheadTracker.initialize(to: LookaheadTracker())
  source.withUTF8 { buf in
    var lexemes = [Lexer.Lexeme]()
    for token in Lexer.tokenize(
      buf,
      from: 0,
      lookaheadTracker: lookaheadTracker,
      experimentalFeatures: experimentalFeatures
    ) {
      lexemes.append(token)

      if token.rawTokenKind == .endOfFile {
        break
      }
    }
    assertTokens(lexemes, expectedLexemes, markerLocations: markerLocations, file: file, line: line)
  }
}

// MARK: Parsing Assertions

struct NoteSpec {
  /// The location to which the note should point.
  let locationMarker: String

  /// Asserts that the note has this message.
  let message: String

  /// The file and line at which this ``NoteSpec`` was created, so that assertion failures can be reported at its location.
  let file: StaticString
  let line: UInt

  init(
    locationMarker: String = "ℹ️",
    message: String,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    self.locationMarker = locationMarker
    self.message = message
    self.file = file
    self.line = line
  }
}

/// An abstract data structure to describe how a diagnostic produced by the parser should look like.
struct DiagnosticSpec {
  /// The name of a marker (of the form `1️⃣`) in the source code that marks the location where the diagnostic should be produced.
  let locationMarker: String
  /// If not `nil`, assert that the diagnostic has the given ID.
  let id: MessageID?
  /// If not `nil`, assert that the diagnostic has the given message.
  let message: String?
  /// Assert that the diagnostic has the given severity.
  let severity: DiagnosticSeverity
  /// If not `nil`, assert that the highlighted range has this content.
  let highlight: String?
  /// If not `nil`, assert that the diagnostic contains notes with these messages.
  let notes: [NoteSpec]
  /// If not `nil`, assert that the diagnostic contains fix-its with these messages.
  /// Use the `fixedSource` parameter on `AssertParse` to check that applying the Fix-It yields the expected result.
  let fixIts: [String]

  /// The file and line at which this ``DiagnosticSpec`` was created, so that assertion failures can be reported at its location.
  let file: StaticString
  let line: UInt

  init(
    locationMarker: String = "1️⃣",
    id: MessageID? = nil,
    message: String?,
    severity: DiagnosticSeverity = .error,
    highlight: String? = nil,
    notes: [NoteSpec] = [],
    fixIts: [String] = [],
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    self.locationMarker = locationMarker
    self.id = id
    self.message = message
    self.severity = severity
    self.highlight = highlight
    self.notes = notes
    self.fixIts = fixIts
    self.file = file
    self.line = line
  }
}

/// Assert that `location` is the same as that of `locationMarker` in `tree`.
func assertLocation(
  _ location: SourceLocation,
  in tree: some SyntaxProtocol,
  markerLocations: [String: Int],
  expectedLocationMarker locationMarker: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  if let markerLoc = markerLocations[locationMarker] {
    let locationConverter = SourceLocationConverter(fileName: "", tree: tree)
    let actualLocation = location
    let expectedLocation = locationConverter.location(for: AbsolutePosition(utf8Offset: markerLoc))
    if actualLocation.line != expectedLocation.line || actualLocation.column != expectedLocation.column {
      XCTFail(
        "Expected location \(expectedLocation.line):\(expectedLocation.column) but got \(actualLocation.line):\(actualLocation.column)",
        file: file,
        line: line
      )
    }
  } else {
    XCTFail("Did not find marker \(locationMarker) in the source code", file: file, line: line)
  }
}

/// Assert that the diagnostic `note` produced in `tree` matches `spec`,
/// using `markerLocations` to translate markers to actual source locations.
func assertNote(
  _ note: Note,
  in tree: some SyntaxProtocol,
  markerLocations: [String: Int],
  expected spec: NoteSpec
) {
  XCTAssertEqual(note.message, spec.message, file: spec.file, line: spec.line)
  let locationConverter = SourceLocationConverter(fileName: "", tree: tree)
  assertLocation(
    note.location(converter: locationConverter),
    in: tree,
    markerLocations: markerLocations,
    expectedLocationMarker: spec.locationMarker,
    file: spec.file,
    line: spec.line
  )
}

/// Assert that the diagnostic `diag` produced in `tree` matches `spec`,
/// using `markerLocations` to translate markers to actual source locations.
func assertDiagnostic(
  _ diag: Diagnostic,
  in tree: some SyntaxProtocol,
  markerLocations: [String: Int],
  expected spec: DiagnosticSpec
) {
  let locationConverter = SourceLocationConverter(fileName: "", tree: tree)
  assertLocation(
    diag.location(converter: locationConverter),
    in: tree,
    markerLocations: markerLocations,
    expectedLocationMarker: spec.locationMarker,
    file: spec.file,
    line: spec.line
  )
  if let id = spec.id {
    XCTAssertEqual(diag.diagnosticID, id, file: spec.file, line: spec.line)
  }
  if let message = spec.message {
    assertStringsEqualWithDiff(diag.message, message, file: spec.file, line: spec.line)
  }
  XCTAssertEqual(spec.severity, diag.diagMessage.severity, file: spec.file, line: spec.line)
  if diag.message.contains("\n") {
    XCTFail(
      """
      Diagnostic message should only span a single line. Message was:
      \(diag.message)
      """,
      file: spec.file,
      line: spec.line
    )
  }

  let highlight = spec.highlight ?? diag.node.description
  assertStringsEqualWithDiff(
    diag.highlights.map(\.description).joined().trimmingTrailingWhitespace(),
    highlight.trimmingTrailingWhitespace(),
    "Highlighted source code did not match",
    file: spec.file,
    line: spec.line
  )

  if diag.notes.count != spec.notes.count {
    XCTFail(
      """
      Expected \(spec.notes.count) notes but received \(diag.notes.count):
      \(diag.notes.map(\.debugDescription).joined(separator: "\n"))
      """,
      file: spec.file,
      line: spec.line
    )
  } else {
    for (note, expectedNote) in zip(diag.notes, spec.notes) {
      assertNote(note, in: tree, markerLocations: markerLocations, expected: expectedNote)
    }
  }

  if diag.fixIts.count != spec.fixIts.count {
    XCTFail(
      """
      Expected \(spec.fixIts.count) fix its but received \(diag.fixIts.count):
      \(diag.fixIts.map { $0.message.message }.joined(separator: "\n"))
      """,
      file: spec.file,
      line: spec.line
    )
  } else if spec.fixIts != diag.fixIts.map(\.message.message) {
    assertStringsEqualWithDiff(
      diag.fixIts.map(\.message.message).joined(separator: "\n"),
      spec.fixIts.joined(separator: "\n"),
      file: spec.file,
      line: spec.line
    )
  }
}

class MutatedTreePrinter: SyntaxVisitor {
  private var mutations: [Int: TokenSpec] = [:]
  private var printedSource: [UInt8] = []

  /// Prints `tree` by replacing the tokens whose offset is in `mutations` by
  /// a token that matches the corresponding ``TokenSpec``.
  static func print(tree: Syntax, mutations: [Int: TokenSpec]) -> [UInt8] {
    let printer = MutatedTreePrinter(mutations: mutations)
    printer.walk(tree)
    return printer.printedSource
  }

  private init(mutations: [Int: TokenSpec]) {
    self.mutations = mutations
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    if let mutation = mutations[node.positionAfterSkippingLeadingTrivia.utf8Offset] {
      let token = TokenSyntax(
        mutation.synthesizedTokenKind,
        leadingTrivia: node.leadingTrivia,
        trailingTrivia: node.trailingTrivia,
        presence: .present
      )
      printedSource.append(contentsOf: token.syntaxTextBytes)
      return .skipChildren
    }
    printedSource.append(contentsOf: node.syntaxTextBytes)
    return .skipChildren
  }
}

/// Flip the presence of the `flipTokenAtIndex`-th token in a tree, i.e. making
/// it present if it is missing or missing if it is present. All other nodes are
/// not modified.
class TokenPresenceFlipper: SyntaxRewriter {
  var visitedTokens = 0
  let flipTokenAtIndex: Int

  init(flipTokenAtIndex: Int) {
    self.flipTokenAtIndex = flipTokenAtIndex

    super.init(viewMode: .all)
  }

  override func visit(_ token: TokenSyntax) -> TokenSyntax {
    defer { visitedTokens += 1 }
    if visitedTokens == flipTokenAtIndex {
      switch token.presence {
      case .present:
        return token.with(\.presence, .missing)
      case .missing:
        return token.with(\.presence, .present)
      }
    }

    return token
  }
}

public struct AssertParseOptions: OptionSet, Sendable {
  public var rawValue: UInt8

  public init(rawValue: UInt8) {
    self.rawValue = rawValue
  }

  /// Trivia mismatches in the substructure should cause failures
  public static let substructureCheckTrivia = AssertParseOptions(rawValue: 1 << 0)

  /// Replace all `\r` and `\r\n` in the fixed source by `\n`.
  /// Useful to match source code that contains other line endings to expected
  /// fixed source that has `\n` line endings.
  public static let normalizeNewlinesInFixedSource = AssertParseOptions(rawValue: 1 << 1)
}

extension ParserTestCase {
  /// After a test case has been mutated, assert that the mutated source
  /// round-trips and doesn’t hit any assertion failures in the parser.
  fileprivate static func assertMutationRoundTrip(
    source: [UInt8],
    _ parse: (inout Parser) -> some SyntaxProtocol,
    swiftVersion: Parser.SwiftVersion?,
    experimentalFeatures: Parser.ExperimentalFeatures,
    file: StaticString,
    line: UInt
  ) {
    source.withUnsafeBufferPointer { buf in
      let mutatedSource = String(decoding: buf, as: UTF8.self)
      // Check that we don't hit any assertions in the parser while parsing
      // the mutated source and that it round-trips
      var mutatedParser = Parser(buf, swiftVersion: swiftVersion, experimentalFeatures: experimentalFeatures)
      let mutatedTree = parse(&mutatedParser)
      // Run the diagnostic generator to make sure it doesn’t crash
      _ = ParseDiagnosticsGenerator.diagnostics(for: mutatedTree)
      assertStringsEqualWithDiff(
        "\(mutatedTree)",
        mutatedSource,
        "A mutation of the original test case failed to round-trip.",
        additionalInfo: """
          To debug the failure, add a new `assertParse` test with the following source as input:
          \(mutatedSource)

          Parsed syntax tree of mutation:
          \(mutatedTree.debugDescription)
          """,
        file: file,
        line: line
      )
    }
  }

  enum FixItsApplication {
    /// Apply only the fix-its whose messages are included in `applyFixIts` to generate `fixedSource`.
    case optIn(applyFixIts: [String], fixedSource: String)
    /// Apply all fix-its to generate `fixedSource`.
    case all(fixedSource: String)

    init?(applyFixIts: [String]?, expectedFixedSource: String?) {
      if let applyFixIts {
        self = .optIn(applyFixIts: applyFixIts, fixedSource: expectedFixedSource ?? "")
      } else if let expectedFixedSource {
        self = .all(fixedSource: expectedFixedSource)
      } else {
        return nil
      }
    }

    var applyFixIts: [String]? {
      switch self {
      case .optIn(let applyFixIts, _):
        return applyFixIts
      case .all:
        return nil
      }
    }

    var expectedFixedSource: String {
      switch self {
      case .optIn(_, let fixedSource), .all(let fixedSource):
        return fixedSource
      }
    }
  }

  /// Convenient version of `assertParse` that allows checking a single configuration of applied Fix-Its.
  ///
  /// - Parameters:
  ///   - applyFixIts: Applies only the fix-its with these messages. Nil means applying all fix-its.
  ///   - expectedFixedSource: Asserts that the source after applying fix-its matches
  ///     this string.
  func assertParse(
    _ markedSource: String,
    _ parse: @Sendable (inout Parser) -> some SyntaxProtocol = { SourceFileSyntax.parse(from: &$0) },
    substructure expectedSubstructure: (some SyntaxProtocol)? = Optional<Syntax>.none,
    substructureAfterMarker: String = "START",
    diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
    applyFixIts: [String]? = nil,
    fixedSource expectedFixedSource: String? = nil,
    options: AssertParseOptions = [],
    swiftVersion: Parser.SwiftVersion? = nil,
    experimentalFeatures: Parser.ExperimentalFeatures? = nil,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    assertParse(
      markedSource,
      parse,
      substructure: expectedSubstructure,
      substructureAfterMarker: substructureAfterMarker,
      diagnostics: expectedDiagnostics,
      fixItsApplications: FixItsApplication(applyFixIts: applyFixIts, expectedFixedSource: expectedFixedSource).map {
        [$0]
      } ?? [],
      options: options,
      swiftVersion: swiftVersion,
      experimentalFeatures: experimentalFeatures,
      file: file,
      line: line
    )
  }

  /// Verifies that parsing of `markedSource` produces expected results using a
  /// combination of various testing techniques:
  ///
  /// 1. Asserts that parsing of `markedSource` round-trips, ie. that the printed
  ///    parsed tree is the same as the input.
  /// 2. Checks that parsing produces the expected list of diagnostics. If no
  ///    diagnostics are passed, asserts that the input parses without any errors.
  /// 3. Checks that applying fix-its of the source code results in the
  ///    expected fixed source, effectively testing the Fix-Its.
  /// 4. If a substructure is passed, asserts that the parsed tree contains a
  ///    subtree of that structure.
  /// 5. Mutates the test input by flipping each token's presence (ie. for every
  ///    token, either remove it from the input if it is present in the parsed
  ///    tree or synthesize it if it was missing) and verifies that this
  ///    mutated input round-trips. This test is disabled if the
  ///    `SKIP_LONG_TESTS` environment variable is set.
  /// 6. If swift-syntax is compiled with the
  ///    `SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION` environment variable
  ///    set, mutates the input based on tokens the parse is trying to parse.
  ///    See the *Test Case Mutation* section in CONTRIBUTING.md.
  ///
  ///
  /// - Parameters:
  ///   - markedSource: source that can include markers of the form `1️⃣`,
  ///     to be used as locations in the following parameters.
  ///   - parse: The function with which the source code should be parsed.
  ///     Defaults to parsing as a source file.
  ///   - expectedSubstructure: Asserts the parsed syntax tree contains this structure.
  ///   - substructureAfterMarker: Changes the position to start the structure
  ///     assertion from, ie. allows matching a particular substructure rather
  ///     than the whole source.
  ///   - expectedDiagnostics: Asserts the given diagnostics were output, by default it
  ///     asserts the parse was successful (ie. it has no diagnostics). Note
  ///     that `DiagnosticsSpec` uses the location marked by `1️⃣` by default.
  ///   - fixItsApplications: A list of `FixItsApplication` to check for whether applying certain fix-its to the source
  ///     will generate a certain expected fixed source. An empty list means no fix-its are expected.
  ///   - swiftVersion: The version of Swift using which the file should be parsed.
  ///      Defaults to the latest version.
  ///   - experimentalFeatures: A list of experimental features to enable, or
  ///     `nil` to enable the default set of features provided by the test case.
  func assertParse(
    _ markedSource: String,
    _ parse: @Sendable (inout Parser) -> some SyntaxProtocol = { SourceFileSyntax.parse(from: &$0) },
    substructure expectedSubstructure: (some SyntaxProtocol)? = Optional<Syntax>.none,
    substructureAfterMarker: String = "START",
    diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
    fixItsApplications: [FixItsApplication] = [],
    options: AssertParseOptions = [],
    swiftVersion: Parser.SwiftVersion? = nil,
    experimentalFeatures: Parser.ExperimentalFeatures? = nil,
    file: StaticString = #filePath,
    line: UInt = #line
  ) {
    let experimentalFeatures = experimentalFeatures ?? self.experimentalFeatures

    // Verify the parser can round-trip the source
    var (markerLocations, source) = extractMarkers(markedSource)
    markerLocations["START"] = 0

    var parser = Parser(source, swiftVersion: swiftVersion, experimentalFeatures: experimentalFeatures)
    #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
    if !longTestsDisabled {
      parser.enableAlternativeTokenChoices()
    }
    #endif
    let tree = parse(&parser)

    // Round-trip
    assertStringsEqualWithDiff(
      "\(tree)",
      source,
      "Test case failed to round-trip",
      additionalInfo: """
        Parsed syntax tree:
        \(tree.debugDescription)
        """,
      file: file,
      line: line
    )

    // Substructure
    if let expectedSubstructure {
      let subtreeMatcher = SubtreeMatcher(tree, markers: markerLocations)
      do {
        try subtreeMatcher.assertSameStructure(
          afterMarker: substructureAfterMarker,
          expectedSubstructure,
          includeTrivia: options.contains(.substructureCheckTrivia),
          file: file,
          line: line
        )
      } catch {
        XCTFail("Matching for a subtree failed with error: \(error)", file: file, line: line)
      }
    }

    // Diagnostics
    let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
    if diags.count != expectedDiagnostics.count {
      XCTFail(
        """
        Expected \(expectedDiagnostics.count) diagnostics but received \(diags.count):
        \(diags.map(\.debugDescription).joined(separator: "\n"))
        """,
        file: file,
        line: line
      )
    } else {
      for (diag, expectedDiag) in zip(diags, expectedDiagnostics) {
        assertDiagnostic(diag, in: tree, markerLocations: markerLocations, expected: expectedDiag)
      }
    }

    // Applying Fix-Its
    if expectedDiagnostics.contains(where: { !$0.fixIts.isEmpty }) && fixItsApplications.isEmpty {
      XCTFail("Expected a fixed source if the test case produces diagnostics with Fix-Its", file: file, line: line)
    } else {
      for fixItsApplication in fixItsApplications {
        let applyFixIts = fixItsApplication.applyFixIts
        let fixedTree = FixItApplier.applyFixes(from: diags, filterByMessages: applyFixIts, to: tree)
        var fixedTreeDescription = fixedTree.description
        if options.contains(.normalizeNewlinesInFixedSource) {
          fixedTreeDescription =
            fixedTreeDescription
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
        }
        assertStringsEqualWithDiff(
          fixedTreeDescription.trimmingTrailingWhitespace(),
          fixItsApplication.expectedFixedSource.trimmingTrailingWhitespace(),
          "Applying \(applyFixIts?.description ?? "all Fix-Its") didn’t produce the expected fixed source",
          file: file,
          line: line
        )
      }
    }

    if expectedDiagnostics.allSatisfy({ $0.fixIts.isEmpty }) && !fixItsApplications.isEmpty {
      XCTFail(
        "Fixed source was provided but the test case produces no diagnostics with Fix-Its",
        file: file,
        line: line
      )
    }

    if expectedDiagnostics.isEmpty && diags.isEmpty {
      assertBasicFormat(
        source: source,
        parse: parse,
        swiftVersion: swiftVersion,
        experimentalFeatures: experimentalFeatures,
        file: file,
        line: line
      )
    }

    if !longTestsDisabled {
      DispatchQueue.concurrentPerform(iterations: Array(tree.tokens(viewMode: .all)).count) { tokenIndex in
        let flippedTokenTree = TokenPresenceFlipper(flipTokenAtIndex: tokenIndex).rewrite(Syntax(tree))
        _ = ParseDiagnosticsGenerator.diagnostics(for: flippedTokenTree)
        Self.assertMutationRoundTrip(
          source: flippedTokenTree.syntaxTextBytes,
          parse,
          swiftVersion: swiftVersion,
          experimentalFeatures: experimentalFeatures,
          file: file,
          line: line
        )
      }

      #if SWIFTPARSER_ENABLE_ALTERNATE_TOKEN_INTROSPECTION
      let mutations: [(offset: Int, replacement: TokenSpec)] = parser.alternativeTokenChoices.flatMap {
        offset,
        replacements in
        return replacements.map { (offset, $0) }
      }
      DispatchQueue.concurrentPerform(iterations: mutations.count) { index in
        let mutation = mutations[index]
        let alternateSource = MutatedTreePrinter.print(
          tree: Syntax(tree),
          mutations: [mutation.offset: mutation.replacement]
        )
        Self.assertMutationRoundTrip(
          source: alternateSource,
          parse,
          swiftVersion: swiftVersion,
          experimentalFeatures: experimentalFeatures,
          file: file,
          line: line
        )
      }
      #endif
    }
  }
}

/// Removes trivia from all tokens that don’t occur inside multiline string
/// literals.
///
/// We keep trivia inside multiline string literals because the indentation of
/// the closing quote of a multi-line string literals has impact on how much
/// leading trivia is stripped from the literal’s content.
class TriviaRemover: SyntaxRewriter {
  override func visit(_ node: StringLiteralExprSyntax) -> ExprSyntax {
    if node.openingQuote.tokenKind == .multilineStringQuote {
      return ExprSyntax(node)
    } else {
      return super.visit(node)
    }
  }

  override func visit(_ node: SimpleStringLiteralExprSyntax) -> ExprSyntax {
    if node.openingQuote.tokenKind == .multilineStringQuote {
      return ExprSyntax(node)
    } else {
      return super.visit(node)
    }
  }

  override func visit(_ token: TokenSyntax) -> TokenSyntax {
    return token.with(\.leadingTrivia, []).with(\.trailingTrivia, [])
  }
}

func assertBasicFormat(
  source: String,
  parse: (inout Parser) -> some SyntaxProtocol,
  swiftVersion: Parser.SwiftVersion?,
  experimentalFeatures: Parser.ExperimentalFeatures,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  var parser = Parser(source, swiftVersion: swiftVersion, experimentalFeatures: experimentalFeatures)
  let sourceTree = parse(&parser)
  let withoutTrivia = TriviaRemover(viewMode: .sourceAccurate).rewrite(sourceTree)
  let formatted = withoutTrivia.formatted()

  var formattedParser = Parser(
    formatted.description,
    swiftVersion: swiftVersion,
    experimentalFeatures: experimentalFeatures
  )
  let formattedReparsed = Syntax(parse(&formattedParser))

  do {
    let subtreeMatcher = SubtreeMatcher(formattedReparsed, markers: [:])
    try subtreeMatcher.assertSameStructure(
      sourceTree,
      includeTrivia: false,
      additionalInfo: """
        Removing trivia, formatting using BasicFormat and re-parsing did not produce the same syntax tree.

        Formatted source:
        \(formatted)
        """,
      file: file,
      line: line
    )
  } catch {
    XCTFail("Matching for a subtree failed with error: \(error)", file: file, line: line)
  }
}
