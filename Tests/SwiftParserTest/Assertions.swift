import XCTest
@_spi(RawSyntax) import SwiftSyntax
@_spi(Testing) @_spi(RawSyntax)  import SwiftParser

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

func AssertParse<Node: RawSyntaxNodeProtocol>(
  _ parseSyntax: (inout Parser) -> Node,
  allowErrors: Bool = true,
  file: StaticString = #file,
  line: UInt = #line,
  _ source: () -> String
) throws {
  // Verify the parser can round-trip the source
  let src = source()
  var source = src
  source.withUTF8 { buf in
    var parser = Parser(buf)
    withExtendedLifetime(parser) {
      let parse = Syntax(raw: parseSyntax(&parser).raw)
      AssertStringsEqualWithDiff("\(parse)", src, additionalInfo: """
      Actual syntax tree:
      \(parse.recursiveDescription)
      """, file: file, line: line)
      if !allowErrors {
        let diagnostics = ParseDiagnosticsGenerator.diagnostics(for: Syntax(raw: parse.raw))
        XCTAssertEqual(
          diagnostics.count, 0,
          """
          Received the following diagnostics while parsing the source code:
          \(diagnostics)
          """,
          file: file, line: line)
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
