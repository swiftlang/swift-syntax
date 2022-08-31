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
  /// If not `nil`, assert that the diagnostic contains fix-its with these messages.
  /// Use the `fixedSource` parameter on `AssertParse` to check that applying the Fix-It yields the expected result.
  let fixIts: [String]?

  init(locationMarker: String = "DIAG", id: MessageID? = nil, message: String?, highlight: String? = nil, fixIts: [String]? = nil) {
    self.locationMarker = locationMarker
    self.id = id
    self.message = message
    self.highlight = highlight
    self.fixIts = fixIts
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
  if let markerLoc = markerLocations[spec.locationMarker] {
    let locationConverter = SourceLocationConverter(file: "/test.swift", source: tree.description)
    let actualLocation = diag.location(converter: locationConverter)
    let expectedLocation = locationConverter.location(for: AbsolutePosition(utf8Offset: markerLoc))
    if let actualLine = actualLocation.line,
       let actualColumn = actualLocation.column,
       let expectedLine = expectedLocation.line,
       let expectedColumn = expectedLocation.column {
      XCTAssertEqual(
        actualLine, expectedLine,
        "Expected diagnostic on line \(expectedLine) but got \(actualLine)",
        file: file, line: line
      )
      XCTAssertEqual(
        actualColumn, expectedColumn,
        "Expected diagnostic on column \(expectedColumn) but got \(actualColumn)",
        file: file, line: line
      )
    } else {
      XCTFail("Failed to resolve diagnostic location to line/column", file: file, line: line)
    }
  } else {
    XCTFail("Did not find marker #^\(spec.locationMarker)^# in the source code", file: file, line: line)
  }
  if let id = spec.id {
    XCTAssertEqual(diag.diagnosticID, id, file: file, line: line)
  }
  if let message = spec.message {
    AssertStringsEqualWithDiff(diag.message, message, file: file, line: line)
  }
  if let highlight = spec.highlight {
    AssertStringsEqualWithDiff(diag.highlights.map(\.description).joined(), highlight, file: file, line: line)
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
func AssertParse<Node: RawSyntaxNodeProtocol>(
  _ markedSource: String,
  _ parseSyntax: (inout Parser) -> Node = { $0.parseSourceFile() },
  substructure expectedSubstructure: Syntax? = nil,
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  fixedSource expectedFixedSource: String? = nil,
  file: StaticString = #file,
  line: UInt = #line
) {
  // Verify the parser can round-trip the source
  let (markerLocations, source) = extractMarkers(markedSource)
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
        let subtreeMatcher = SubtreeMatcher(Syntax(tree), markers: [:])
        do {
          try subtreeMatcher.assertSameStructure(Syntax(expectedSubstructure), file: file, line: line)
        } catch {
          XCTFail("Matching for a subtree failed with error: \(error)", file: file, line: line)
        }
      }

      // Diagnostics
      let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
      XCTAssertEqual(diags.count, expectedDiagnostics.count, """
      Expected \(expectedDiagnostics.count) diagnostics but received \(diags.count):
      \(diags.map(\.debugDescription).joined(separator: "\n"))
      """, file: file, line: line)
      for (diag, expectedDiag) in zip(diags, expectedDiagnostics) {
        AssertDiagnostic(diag, in: tree, markerLocations: markerLocations, expected: expectedDiag, file: file, line: line)
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
  // Use `CollectionDifference` on supported platforms to get `diff`-like line-based output. On
  // older platforms, fall back to simple string comparison.
  if #available(macOS 10.15, *) {
    let actualLines = actual.components(separatedBy: .newlines)
    let expectedLines = expected.components(separatedBy: .newlines)

    let difference = actualLines.difference(from: expectedLines)
    if difference.isEmpty { return }

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
    // Fall back to simple string comparison on platforms that don't support CollectionDifference.
    let failureMessage = "Actual output differed from expected output:"
    let fullMessage = message.isEmpty ? failureMessage : "\(message) - \(failureMessage)"
    XCTAssertEqual(actual, expected, fullMessage, file: file, line: line)
  }
}
