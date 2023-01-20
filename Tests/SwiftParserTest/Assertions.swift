//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing)@_spi(RawSyntax) import SwiftParser
@_spi(RawSyntax) import SwiftParserDiagnostics
import SwiftDiagnostics
import _SwiftSyntaxTestSupport

// MARK: Lexing Assertions

struct LexemeSpec {
  let rawTokenKind: RawTokenKind
  let leadingTrivia: SyntaxText
  let tokenText: SyntaxText
  let trailingTrivia: SyntaxText
  let errorLocationMarker: String
  let error: String?
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
    error: String? = nil,
    flags: Lexer.Lexeme.Flags = [],
    file: StaticString = #file,
    line: UInt = #line
  ) {
    self.rawTokenKind = rawTokenKind
    self.leadingTrivia = leading
    self.tokenText = text
    self.trailingTrivia = trailing
    self.errorLocationMarker = errorLocationMarker
    self.error = error
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
private func AssertTokens(
  _ actual: [Lexer.Lexeme],
  _ expected: [LexemeSpec],
  markerLocations: [String: Int],
  file: StaticString = #file,
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
      lexemeStartOffset = actualLexeme.byteLength
    }
    if actualLexeme.rawTokenKind != expectedLexeme.rawTokenKind {
      XCTFail(
        "Expected token kind \(expectedLexeme.rawTokenKind) but got \(actualLexeme.rawTokenKind)",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }

    if actualLexeme.leadingTriviaText != expectedLexeme.leadingTrivia {
      FailStringsEqualWithDiff(
        String(syntaxText: actualLexeme.leadingTriviaText),
        String(syntaxText: expectedLexeme.leadingTrivia),
        "Leading trivia does not match",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }

    if actualLexeme.tokenText.debugDescription != expectedLexeme.tokenText.debugDescription {
      FailStringsEqualWithDiff(
        actualLexeme.tokenText.debugDescription,
        expectedLexeme.tokenText.debugDescription,
        "Token text does not match",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }

    if actualLexeme.trailingTriviaText != expectedLexeme.trailingTrivia {
      FailStringsEqualWithDiff(
        String(syntaxText: actualLexeme.trailingTriviaText),
        String(syntaxText: expectedLexeme.trailingTrivia),
        "Trailing trivia does not match",
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
    }

    switch (actualLexeme.error, expectedLexeme.error) {
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
      AssertStringsEqualWithDiff(
        actualError.diagnostic(tokenText: actualLexeme.tokenText).message,
        expectedError,
        file: expectedLexeme.file,
        line: expectedLexeme.line
      )
      if let location = markerLocations[expectedLexeme.errorLocationMarker] {
        XCTAssertEqual(
          Int(actualError.byteOffset),
          location - lexemeStartOffset - actualLexeme.leadingTriviaByteLength,
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

func AssertLexemes(
  _ markedSource: String,
  lexemes expectedLexemes: [LexemeSpec],
  file: StaticString = #file,
  line: UInt = #line
) {
  var (markerLocations, source) = extractMarkers(markedSource)
  var expectedLexemes = expectedLexemes
  if expectedLexemes.last?.rawTokenKind != .eof {
    expectedLexemes.append(LexemeSpec(.eof, text: ""))
  }
  source.withUTF8 { buf in
    var lexemes = [Lexer.Lexeme]()
    for token in Lexer.tokenize(buf, from: 0) {
      lexemes.append(token)

      if token.rawTokenKind == .eof {
        break
      }
    }
    AssertTokens(lexemes, expectedLexemes, markerLocations: markerLocations, file: file, line: line)
  }
}

// MARK: Parsing Assertions

struct NoteSpec {
  /// The location to which the note should point.
  let locationMarker: String

  /// Asserts that the note has this message.
  let message: String

  /// The file and line at which this `NoteSpec` was created, so that assertion failures can be reported at its location.
  let file: StaticString
  let line: UInt

  init(
    locationMarker: String = "ℹ️",
    message: String,
    file: StaticString = #file,
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
  /// The name of a maker (of the form `1️⃣`) in the source code that marks the location where the diagnostis should be produced.
  let locationMarker: String
  /// If not `nil`, assert that the diagnostic has the given ID.
  let id: MessageID?
  /// If not `nil`, assert that the diagnostic has the given message.
  let message: String?
  /// If not `nil`, assert that the highlighted range has this content.
  let highlight: String?
  /// If not `nil`, assert that the diagnostic contains notes with these messages.
  let notes: [NoteSpec]?
  /// If not `nil`, assert that the diagnostic contains fix-its with these messages.
  /// Use the `fixedSource` parameter on `AssertParse` to check that applying the Fix-It yields the expected result.
  let fixIts: [String]?

  /// The file and line at which this `DiagnosticSpec` was created, so that assertion failures can be reported at its location.
  let file: StaticString
  let line: UInt

  init(
    locationMarker: String = "1️⃣",
    id: MessageID? = nil,
    message: String?,
    highlight: String? = nil,
    notes: [NoteSpec]? = nil,
    fixIts: [String]? = nil,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    self.locationMarker = locationMarker
    self.id = id
    self.message = message
    self.highlight = highlight
    self.notes = notes
    self.fixIts = fixIts
    self.file = file
    self.line = line
  }
}

class FixItApplier: SyntaxRewriter {
  var changes: [FixIt.Change]

  init(diagnostics: [Diagnostic], withMessages messages: [String]?) {
    self.changes =
      diagnostics
      .flatMap { $0.fixIts }
      .filter {
        if let messages = messages {
          return messages.contains($0.message.message)
        } else {
          return true
        }
      }
      .flatMap { $0.changes.changes }
  }

  public override func visitAny(_ node: Syntax) -> Syntax? {
    for change in changes {
      switch change {
      case .replace(oldNode: let oldNode, newNode: let newNode) where oldNode.id == node.id:
        return newNode
      default:
        break
      }
    }
    return nil
  }

  override func visit(_ node: TokenSyntax) -> TokenSyntax {
    var modifiedNode = node
    for change in changes {
      switch change {
      case .replaceLeadingTrivia(token: let changedNode, newTrivia: let newTrivia) where changedNode.id == node.id:
        modifiedNode = node.withLeadingTrivia(newTrivia)
      case .replaceTrailingTrivia(token: let changedNode, newTrivia: let newTrivia) where changedNode.id == node.id:
        modifiedNode = node.withTrailingTrivia(newTrivia)
      default:
        break
      }
    }
    return modifiedNode
  }

  /// If `messages` is `nil`, applies all Fix-Its in `diagnostics` to `tree` and returns the fixed syntax tree.
  /// If `messages` is not `nil`, applies only Fix-Its whose message is in `messages`.
  public static func applyFixes<T: SyntaxProtocol>(in diagnostics: [Diagnostic], withMessages messages: [String]?, to tree: T) -> Syntax {
    let applier = FixItApplier(diagnostics: diagnostics, withMessages: messages)
    return applier.visit(Syntax(tree))
  }
}

/// Assert that `location` is the same as that of `locationMarker` in `tree`.
func AssertLocation<T: SyntaxProtocol>(
  _ location: SourceLocation,
  in tree: T,
  markerLocations: [String: Int],
  expectedLocationMarker locationMarker: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  if let markerLoc = markerLocations[locationMarker] {
    let locationConverter = SourceLocationConverter(file: "", source: tree.description)
    let actualLocation = location
    let expectedLocation = locationConverter.location(for: AbsolutePosition(utf8Offset: markerLoc))
    if let actualLine = actualLocation.line,
      let actualColumn = actualLocation.column,
      let expectedLine = expectedLocation.line,
      let expectedColumn = expectedLocation.column
    {
      if actualLine != expectedLine || actualColumn != expectedColumn {
        XCTFail("Expected location \(expectedLine):\(expectedColumn) but got \(actualLine):\(actualColumn)", file: file, line: line)
      }
    } else {
      XCTFail("Failed to resolve diagnostic location to line/column", file: file, line: line)
    }
  } else {
    XCTFail("Did not find marker \(locationMarker) in the source code", file: file, line: line)
  }
}

/// Assert that the diagnostic `note` produced in `tree` matches `spec`,
/// using `markerLocations` to translate markers to actual source locations.
func AssertNote<T: SyntaxProtocol>(
  _ note: Note,
  in tree: T,
  markerLocations: [String: Int],
  expected spec: NoteSpec,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  XCTAssertEqual(note.message, spec.message, file: file, line: line)
  let locationConverter = SourceLocationConverter(file: "", source: tree.description)
  AssertLocation(
    note.location(converter: locationConverter),
    in: tree,
    markerLocations: markerLocations,
    expectedLocationMarker: spec.locationMarker,
    file: file,
    line: line
  )
}

/// Assert that the diagnostic `diag` produced in `tree` matches `spec`,
/// using `markerLocations` to translate markers to actual source locations.
func AssertDiagnostic<T: SyntaxProtocol>(
  _ diag: Diagnostic,
  in tree: T,
  markerLocations: [String: Int],
  expected spec: DiagnosticSpec,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let locationConverter = SourceLocationConverter(file: "", source: tree.description)
  AssertLocation(
    diag.location(converter: locationConverter),
    in: tree,
    markerLocations: markerLocations,
    expectedLocationMarker: spec.locationMarker,
    file: file,
    line: line
  )
  if let id = spec.id {
    XCTAssertEqual(diag.diagnosticID, id, file: file, line: line)
  }
  if let message = spec.message {
    AssertStringsEqualWithDiff(diag.message, message, file: file, line: line)
  }
  if diag.message.contains("\n") {
    XCTFail(
      """
      Diagnostic message should only span a single line. Message was:
      \(diag.message)
      """,
      file: file,
      line: line
    )
  }
  if let highlight = spec.highlight {
    AssertStringsEqualWithDiff(
      diag.highlights.map(\.description).joined().trimmingTrailingWhitespace(),
      highlight.trimmingTrailingWhitespace(),
      file: file,
      line: line
    )
  }
  if let notes = spec.notes {
    if diag.notes.count != notes.count {
      XCTFail(
        """
        Expected \(notes.count) notes but received \(diag.notes.count):
        \(diag.notes.map(\.debugDescription).joined(separator: "\n"))
        """,
        file: file,
        line: line
      )
    } else {
      for (note, expectedNote) in zip(diag.notes, notes) {
        AssertNote(note, in: tree, markerLocations: markerLocations, expected: expectedNote, file: expectedNote.file, line: expectedNote.line)
      }
    }
  }
  if let fixIts = spec.fixIts {
    if fixIts != diag.fixIts.map(\.message.message) {
      FailStringsEqualWithDiff(
        diag.fixIts.map(\.message.message).joined(separator: "\n"),
        fixIts.joined(separator: "\n"),
        file: file,
        line: line
      )
    }
  }
}

/// Same as `AssertParse` overload with a `(String) -> S` `parse`,
/// parsing the resulting `String` as a `SourceFileSyntax`.
func AssertParse(
  _ markedSource: String,
  substructure expectedSubstructure: Syntax? = nil,
  substructureAfterMarker: String = "START",
  substructureCheckTrivia: Bool = false,
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  applyFixIts: [String]? = nil,
  fixedSource expectedFixedSource: String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  AssertParse(
    markedSource,
    { SourceFileSyntax.parse(from: &$0) },
    substructure: expectedSubstructure,
    substructureAfterMarker: substructureAfterMarker,
    substructureCheckTrivia: substructureCheckTrivia,
    diagnostics: expectedDiagnostics,
    applyFixIts: applyFixIts,
    fixedSource: expectedFixedSource,
    file: file,
    line: line
  )
}

/// Same as `AssertParse` overload with a `(String) -> S` `parse`,
/// constructing a `Parser` from the given `String` and passing that to
/// `parse` instead.
func AssertParse<S: SyntaxProtocol>(
  _ markedSource: String,
  _ parse: (inout Parser) -> S,
  substructure expectedSubstructure: Syntax? = nil,
  substructureAfterMarker: String = "START",
  substructureCheckTrivia: Bool = false,
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  applyFixIts: [String]? = nil,
  fixedSource expectedFixedSource: String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  AssertParse(
    markedSource,
    { (source: String) -> S in
      var parser = Parser(source)
      return parse(&parser)
    },
    substructure: expectedSubstructure,
    substructureAfterMarker: substructureAfterMarker,
    substructureCheckTrivia: substructureCheckTrivia,
    diagnostics: expectedDiagnostics,
    applyFixIts: applyFixIts,
    fixedSource: expectedFixedSource,
    file: file,
    line: line
  )
}

/// Removes any test markers from `markedSource` (1) and parses the result
/// using `parse`. By default it only checks if the parsed syntax tree is
/// printable back to the origin source, ie. it round trips.
///
/// (1) `markedSource` is source that can include markers of the form `1️⃣`,
/// to be used as locations in the following parameters when they exist.
///
/// - Parameters:
///   - substructure: Asserts the parsed syntax tree contains this structure.
///   - substructureAfterMarker: Changes the position to start the structure
///     assertion from, ie. allows matching a particular substructure rather
///     than the whole source.
///   - diagnostics: Asserts the given diagnostics were output, by default it
///     asserts the parse was successful (ie. it has no diagnostics). Note
///     that `DiagnosticsSpec` uses the location marked by `1️⃣` by default.
///   - applyFixIts: Applies only the fix-its with these messages.
///   - fixedSource: Asserts that the source after applying fix-its matches
///     this string.
func AssertParse<S: SyntaxProtocol>(
  _ markedSource: String,
  _ parse: (String) -> S,
  substructure expectedSubstructure: Syntax? = nil,
  substructureAfterMarker: String = "START",
  substructureCheckTrivia: Bool = false,
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  applyFixIts: [String]? = nil,
  fixedSource expectedFixedSource: String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  // Verify the parser can round-trip the source
  var (markerLocations, source) = extractMarkers(markedSource)
  markerLocations["START"] = 0

  let tree: S = parse(source)

  // Round-trip
  AssertStringsEqualWithDiff(
    "\(tree)",
    source,
    additionalInfo: """
      Source failed to round-trip.

      Actual syntax tree:
      \(tree.recursiveDescription)
      """,
    file: file,
    line: line
  )

  // Substructure
  if let expectedSubstructure = expectedSubstructure {
    let subtreeMatcher = SubtreeMatcher(Syntax(tree), markers: markerLocations)
    do {
      try subtreeMatcher.assertSameStructure(afterMarker: substructureAfterMarker, Syntax(expectedSubstructure), includeTrivia: substructureCheckTrivia, file: file, line: line)
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
      AssertDiagnostic(diag, in: tree, markerLocations: markerLocations, expected: expectedDiag, file: expectedDiag.file, line: expectedDiag.line)
    }
  }

  // Applying Fix-Its
  if let expectedFixedSource = expectedFixedSource {
    let fixedTree = FixItApplier.applyFixes(in: diags, withMessages: applyFixIts, to: tree)
    AssertStringsEqualWithDiff(
      fixedTree.description.trimmingTrailingWhitespace(),
      expectedFixedSource.trimmingTrailingWhitespace(),
      file: file,
      line: line
    )
  }
}
