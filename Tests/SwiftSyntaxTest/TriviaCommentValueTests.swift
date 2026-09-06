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

import SwiftParser
@_spi(SourceKitLSP) import SwiftSyntax
import XCTest

class TriviaCommentValueTests: XCTestCase {

  func testDocLineCommentValues() {
    assertCommentValue("///", docCommentValue: "")
    assertCommentValue("/// Some doc line comment", docCommentValue: "Some doc line comment")
    assertCommentValue(
      """
      /// Some doc line comment
      /// Another
      """,
      docCommentValue: """
        Some doc line comment
        Another
        """
    )
    assertCommentValue(
      """
      /// - Task
      ///   - Subtask
      /// - Task 2
      """,
      docCommentValue: """
        - Task
          - Subtask
        - Task 2
        """
    )
    assertCommentValue(
      """
      ///- Task
      ///  - Subtask
      ///- Task 2
      """,
      docCommentValue: """
        - Task
          - Subtask
        - Task 2
        """
    )
    assertCommentValue(
      """
      /// included
      // ignored
      """,
      docCommentValue: "included"
    )
    assertCommentValue(
      """
      /** not included */
      /// included
      """,
      docCommentValue: "included"
    )
    assertCommentValue(
      """
      /// not included
      /* abc */
      /// included
      """,
      docCommentValue: "included"
    )
    assertCommentValue(
      """
      /// not included
      //
      /// included
      """,
      docCommentValue: "included"
    )
    assertCommentValue(
      """
      /// not included
      \("")
      /// included
      /// also included
      """,
      docCommentValue: """
        included
        also included
        """
    )
    assertCommentValue(
      """
      ///not included
      \("")
      /// included
      /// also included
      """,
      docCommentValue: """
        included
        also included
        """
    )
  }

  func testDocBlockCommentValues() {
    assertCommentValue(
      """
      /** Some doc block comment */
      """,
      docCommentValue: "Some doc block comment"
    )
    assertCommentValue(
      """
      /** Some doc block comment
      * spread on many lines */
      """,
      docCommentValue: """
        Some doc block comment
        * spread on many lines
        """
    )
    assertCommentValue(
      """
      /** Some doc block comment
      * spread on many lines
      */
      """,
      docCommentValue: """
        Some doc block comment
        * spread on many lines
        """
    )
    assertCommentValue(
      """
      /**
      Some doc block comment
      spread on many lines
      */
      """,
      docCommentValue: """
        Some doc block comment
        spread on many lines
        """
    )
    assertCommentValue(
      """
      /**
      *  Some doc block comment
      *  spread on many lines
      */
      """,
      docCommentValue: """
        *  Some doc block comment
        *  spread on many lines
        """
    )
    assertCommentValue(
      """
      /**
       *  Some doc block comment
       *  with a line comment
       */
      """,
      docCommentValue: """
        *  Some doc block comment
        *  with a line comment
        """
    )
    assertCommentValue(
      """
          /**
          Some block comment
          with another line
          */
      """,
      docCommentValue: """
        Some block comment
        with another line
        """
    )
    assertCommentValue(
      """
      /**
       Some block comment
       with another line
      */
      """,
      docCommentValue: """
         Some block comment
         with another line
        """
    )
    assertCommentValue(
      """
      /**
      *  Some doc block comment
      *  // spread on many lines
      *  with a line comment
      */
      """,
      docCommentValue: """
        *  Some doc block comment
        *  // spread on many lines
        *  with a line comment
        """
    )
    assertCommentValue(
      """
      /**
      * Some doc block comment
      * // spread on many lines
      * with a line comment
      */
      """,
      docCommentValue: """
        * Some doc block comment
        * // spread on many lines
        * with a line comment
        """
    )
    assertCommentValue("/**     abc     */", docCommentValue: "abc")
    assertCommentValue(
      """
      /**     \("")
      abc
      */
      """,
      docCommentValue: "abc"
    )
    assertCommentValue(
      """
      /**

      First paragraph.

      Second paragraph.

      */
      """,
      docCommentValue: """

        First paragraph.

        Second paragraph.

        """
    )
  }

  func testMixedStyleCommentValues() {
    assertCommentValue(
      """
      /** Some doc block comment
        * spread on many lines */
      /// Some doc line comment
      /// Some line comment
      """,
      docCommentValue: """
        Some doc line comment
        Some line comment
        """
    )
    assertCommentValue(
      """
      /** abc */
      /** def */
      """,
      docCommentValue: "def"
    )
    assertCommentValue(
      """
      /* abc */
      /** def */
      """,
      docCommentValue: "def"
    )
  }
  func testDocCommentLinePositions() {
    assertCommentLines(
      "/// hi",
      docCommentLines: ["hi"]
    )

    assertCommentLines(
      """
      /// Some doc line comment
      /// Another
      """,
      docCommentLines: ["Some doc line comment", "Another"]
    )

    assertCommentLines(
      """
      /// - Task
      ///   - Subtask
      /// - Task 2
      """,
      docCommentLines: ["- Task", "  - Subtask", "- Task 2"]
    )

    assertCommentLines(
      """
      ///- Task
      ///  - Subtask
      """,
      docCommentLines: ["- Task", "  - Subtask"]
    )

    assertCommentLines(
      "/** Some doc block comment */",
      docCommentLines: ["Some doc block comment"]
    )

    assertCommentLines(
      """
      /**
      Some doc block comment
      spread on many lines
      */
      """,
      docCommentLines: ["Some doc block comment", "spread on many lines"]
    )

    assertCommentLines(
      """
      /**
       *  Some doc block comment
       *  with a line comment
       */
      """,
      docCommentLines: ["*  Some doc block comment", "*  with a line comment"]
    )
  }
}

private func assertCommentValue(
  _ input: String,
  docCommentValue expected: String?,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let trivia = parseTrivia(from: input)
  XCTAssertEqual(trivia.docCommentValue, expected, file: file, line: line)
}

private func assertCommentLines(
  _ input: String,
  docCommentLines expectedTexts: [String],
  file: StaticString = #filePath,
  line: UInt = #line
) {
  guard let commentToken = parseCommentToken(from: input) else {
    XCTFail("Failed to find comment token", file: file, line: line)
    return
  }

  guard let actualLines = commentToken.leadingTrivia.docCommentLines(startingAt: commentToken.position) else {
    XCTFail("Expected doc comment lines but got nil", file: file, line: line)
    return
  }

  XCTAssertEqual(actualLines.count, expectedTexts.count, "line count mismatch", file: file, line: line)

  let wrappedSource = "let _ = 0\n\(input)\nlet _ = 1"
  for (actual, expectedText) in zip(actualLines, expectedTexts) {
    XCTAssertEqual(String(actual.text), expectedText, file: file, line: line)

    guard let range = wrappedSource.range(of: expectedText) else {
      XCTFail("Expected text '\(expectedText)' not found in wrapped source", file: file, line: line)
      continue
    }
    let expectedOffset = wrappedSource.utf8.distance(from: wrappedSource.utf8.startIndex, to: range.lowerBound)
    XCTAssertEqual(
      actual.position.utf8Offset,
      expectedOffset,
      "position mismatch for line '\(expectedText)'",
      file: file,
      line: line
    )
  }
}

private func parseCommentToken(from input: String) -> TokenSyntax? {
  let wrappedSource = "let _ = 0\n\(input)\nlet _ = 1"
  let sourceFile = Parser.parse(source: wrappedSource)
  return sourceFile.tokens(viewMode: .sourceAccurate).first(where: {
    $0.leadingTrivia.contains(where: { $0.isComment })
  })
}

private func parseTrivia(from input: String) -> Trivia {
  parseCommentToken(from: input)?.leadingTrivia ?? []
}
