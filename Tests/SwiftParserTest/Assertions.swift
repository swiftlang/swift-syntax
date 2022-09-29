import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax)  import SwiftParser
import SwiftDiagnostics
import _SwiftSyntaxTestSupport

// MARK: Lexing Assertions

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
func AssertEqualTokens(_ actual: [Lexer.Lexeme], _ expected: [Lexer.Lexeme], file: StaticString = #file, line: UInt = #line) {
  guard actual.count == expected.count else {
    return XCTFail("Number of tokens does not match! \(actual.count) != \(expected.count)", file: file, line: line)
  }

  for (idx, (l, r)) in zip(actual, expected).enumerated() {
    guard l.tokenKind == r.tokenKind else {
      return XCTFail("Token at index \(idx) does not match! \(l.tokenKind) != \(r.tokenKind)", file: file, line: line)
    }

    guard l.leadingTriviaText == r.leadingTriviaText else {
      return XCTFail("""
        Token at index \(idx) does not have matching leading trivia! \
        \(l.leadingTriviaText.debugDescription) != \(r.leadingTriviaText.debugDescription)
        """, file: file, line: line)
    }

    guard l.tokenText == r.tokenText else {
      return XCTFail("""
        Text at index \(idx) does not have matching text! \
        \(l.tokenText.debugDescription) != \(r.tokenText.debugDescription)"
        """, file: file, line: line)
    }

    guard l.trailingTriviaText == r.trailingTriviaText else {
      return XCTFail("""
        Token at index \(idx) does not have matching trailing trivia! \
        \(l.trailingTriviaText.debugDescription) != \(r.trailingTriviaText.debugDescription)
        """, file: file, line: line)
    }
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
    locationMarker: String = "NOTE",
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
  /// The name of a maker (of the form `#^DIAG^#`) in the source code that marks the location where the diagnostis should be produced.
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
    locationMarker: String = "DIAG",
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

  init(diagnostics: [Diagnostic]) {
    self.changes = diagnostics.flatMap({ $0.fixIts }).flatMap({ $0.changes })
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

  /// Applies all Fix-Its in `diagnostics` to `tree` and returns the fixed syntax tree.
  public static func applyFixes<T: SyntaxProtocol>(in diagnostics: [Diagnostic], to tree: T) -> Syntax {
    let applier = FixItApplier(diagnostics: diagnostics)
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
       let expectedColumn = expectedLocation.column {
      if actualLine != expectedLine || actualColumn != expectedColumn {
        XCTFail("Expected location \(expectedLine):\(expectedColumn) but got \(actualLine):\(actualColumn)", file: file, line: line)
      }
    } else {
      XCTFail("Failed to resolve diagnostic location to line/column", file: file, line: line)
    }
  } else {
    XCTFail("Did not find marker #^\(locationMarker)^# in the source code", file: file, line: line)
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
    XCTFail("""
      Diagnostic message should only span a single line. Message was:
      \(diag.message)
      """)
  }
  if let highlight = spec.highlight {
    AssertStringsEqualWithDiff(diag.highlights.map(\.description).joined(), highlight, file: file, line: line)
  }
  if let notes = spec.notes {
    if diag.notes.count != notes.count {
      XCTFail("""
      Expected \(notes.count) notes but received \(diag.notes.count):
      \(diag.notes.map(\.debugDescription).joined(separator: "\n"))
      """, file: file, line: line)
    } else {
      for (note, expectedNote) in zip(diag.notes, notes) {
        AssertNote(note, in: tree, markerLocations: markerLocations, expected: expectedNote, file: expectedNote.file, line: expectedNote.line)
      }
    }
  }
  if let fixIts = spec.fixIts {
    XCTAssertEqual(
      fixIts, diag.fixIts.map(\.message.message),
      "Fix-Its for diagnostic did not match expected Fix-Its",
      file: file, line: line
    )
  }
}

/// Parse `markedSource` and perform the following assertions:
///  - The parsed syntax tree should be printable back to the original source code (round-tripping)
///  - Parsing produced the given `diagnostics` (`diagnostics = []` asserts that the parse was successful)
///  - If `fixedSource` is not `nil`, assert that applying all fixes from the diagnostics produces `fixedSource`
/// The source file can be marked with markers of the form `#^DIAG^#` to mark source locations that can be referred to by `diagnostics`.
/// These markers are removed before parsing the source file.
/// By default, `DiagnosticSpec` asserts that the diagnostics is produced at a location marked by `#^DIAG^#`.
/// `parseSyntax` can be used to adjust the production that should be used as the entry point to parse the source code.
/// If `substructure` is not `nil`, asserts that the parsed syntax tree contains this substructure.
func AssertParse(
  _ markedSource: String,
  substructure expectedSubstructure: Syntax? = nil,
  substructureAfterMarker: String = "START",
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  fixedSource expectedFixedSource: String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  return AssertParse(markedSource,
                     { $0.parseSourceFile() },
                     substructure: expectedSubstructure,
                     substructureAfterMarker: substructureAfterMarker,
                     diagnostics: expectedDiagnostics,
                     fixedSource: expectedFixedSource,
                     file: file,
                     line: line)
}

/// Parse `markedSource` and perform the following assertions:
///  - The parsed syntax tree should be printable back to the original source code (round-tripping)
///  - Parsing produced the given `diagnostics` (`diagnostics = []` asserts that the parse was successful)
///  - If `fixedSource` is not `nil`, assert that applying all fixes from the diagnostics produces `fixedSource`
/// The source file can be marked with markers of the form `#^DIAG^#` to mark source locations that can be referred to by `diagnostics`.
/// These markers are removed before parsing the source file.
/// By default, `DiagnosticSpec` asserts that the diagnostics is produced at a location marked by `#^DIAG^#`.
/// `parseSyntax` can be used to adjust the production that should be used as the entry point to parse the source code.
/// If `substructure` is not `nil`, asserts that the parsed syntax tree contains this substructure.
func AssertParse<Node: RawSyntaxNodeProtocol>(
  _ markedSource: String,
  _ parseSyntax: (inout Parser) -> Node,
  substructure expectedSubstructure: Syntax? = nil,
  substructureAfterMarker: String = "START",
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  fixedSource expectedFixedSource: String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  // Verify the parser can round-trip the source
  var (markerLocations, source) = extractMarkers(markedSource)
  markerLocations["START"] = 0
  var src = source
  src.withUTF8 { buf in
    var parser = Parser(buf)
    withExtendedLifetime(parser) {
      let tree = Syntax(raw: parseSyntax(&parser).raw)

      // Round-trip
      AssertStringsEqualWithDiff("\(tree)", source, additionalInfo: """
      Source failed to round-trip.

      Actual syntax tree:
      \(tree.recursiveDescription)
      """, file: file, line: line)

      // Substructure
      if let expectedSubstructure = expectedSubstructure {
        let subtreeMatcher = SubtreeMatcher(Syntax(tree), markers: markerLocations)
        do {
          try subtreeMatcher.assertSameStructure(afterMarker: substructureAfterMarker, Syntax(expectedSubstructure), file: file, line: line)
        } catch {
          XCTFail("Matching for a subtree failed with error: \(error)", file: file, line: line)
        }
      }

      // Diagnostics
      let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
      if diags.count != expectedDiagnostics.count {
        XCTFail("""
        Expected \(expectedDiagnostics.count) diagnostics but received \(diags.count):
        \(diags.map(\.debugDescription).joined(separator: "\n"))
        """, file: file, line: line)
      } else {
        for (diag, expectedDiag) in zip(diags, expectedDiagnostics) {
          AssertDiagnostic(diag, in: tree, markerLocations: markerLocations, expected: expectedDiag, file: expectedDiag.file, line: expectedDiag.line)
        }
      }

      // Applying Fix-Its
      if let expectedFixedSource = expectedFixedSource {
        let fixedTree = FixItApplier.applyFixes(in: diags, to: tree)
        AssertStringsEqualWithDiff(fixedTree.description, expectedFixedSource, file: file, line: line)
      }
    }
  }
}

/// Asserts that the two strings are equal, providing Unix `diff`-style output if they are not.
///
/// - Parameters:
///   - actual: The actual string.
///   - expected: The expected string.
///   - message: An optional description of the failure.
///   - additionalInfo: Additional information about the failed test case that will be printed after the diff
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///     which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///     function was called.
func AssertStringsEqualWithDiff(
  _ actual: String,
  _ expected: String,
  _ message: String = "",
  additionalInfo: @autoclosure () -> String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  if actual == expected {
    return
  }
  FailStringsEqualWithDiff(
    actual, expected, message,
    additionalInfo: additionalInfo(),
    file: file, line: line)
}

/// Asserts that the two data are equal, providing Unix `diff`-style output if they are not.
///
/// - Parameters:
///   - actual: The actual string.
///   - expected: The expected string.
///   - message: An optional description of the failure.
///   - additionalInfo: Additional information about the failed test case that will be printed after the diff
///   - file: The file in which failure occurred. Defaults to the file name of the test case in
///     which this function was called.
///   - line: The line number on which failure occurred. Defaults to the line number on which this
///     function was called.
func AssertDataEqualWithDiff(
  _ actual: Data,
  _ expected: Data,
  _ message: String = "",
  additionalInfo: @autoclosure () -> String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  if actual == expected {
    return
  }

  // NOTE: Converting to `Stirng` here looses invalid UTF8 sequence difference,
  // but at least we can see something is different.
  FailStringsEqualWithDiff(
    String(decoding: actual, as: UTF8.self),
    String(decoding: expected, as: UTF8.self),
    message,
    additionalInfo: additionalInfo(),
    file: file, line: line)
}

/// `XCTFail` with `diff`-style output.
private func FailStringsEqualWithDiff(
  _ actual: String,
  _ expected: String,
  _ message: String = "",
  additionalInfo: @autoclosure () -> String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  // Use `CollectionDifference` on supported platforms to get `diff`-like line-based output. On
  // older platforms, fall back to simple string comparison.
  if #available(macOS 10.15, *) {
    let actualLines = actual.components(separatedBy: .newlines)
    let expectedLines = expected.components(separatedBy: .newlines)

    let difference = actualLines.difference(from: expectedLines)

    var result = ""

    var insertions = [Int: String]()
    var removals = [Int: String]()

    for change in difference {
      switch change {
      case .insert(let offset, let element, _):
        insertions[offset] = element
      case .remove(let offset, let element, _):
        removals[offset] = element
      }
    }

    var expectedLine = 0
    var actualLine = 0

    while expectedLine < expectedLines.count || actualLine < actualLines.count {
      if let removal = removals[expectedLine] {
        result += "-\(removal)\n"
        expectedLine += 1
      } else if let insertion = insertions[actualLine] {
        result += "+\(insertion)\n"
        actualLine += 1
      } else {
        result += " \(expectedLines[expectedLine])\n"
        expectedLine += 1
        actualLine += 1
      }
    }

    let failureMessage = "Actual output (+) differed from expected output (-):\n\(result)"
    var fullMessage = message.isEmpty ? failureMessage : "\(message) - \(failureMessage)"
    if let additionalInfo = additionalInfo() {
      fullMessage = """
      \(fullMessage)
      \(additionalInfo)
      """
    }
    XCTFail(fullMessage, file: file, line: line)
  } else {
    // Fall back to simple message on platforms that don't support CollectionDifference.
    let failureMessage = "Actual output differed from expected output:"
    let fullMessage = message.isEmpty ? failureMessage : "\(message) - \(failureMessage)"
    XCTFail(fullMessage, file: file, line: line)
  }
}
