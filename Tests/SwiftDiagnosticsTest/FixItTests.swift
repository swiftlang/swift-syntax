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
import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

struct SimpleFixItMessage: FixItMessage {
  let message: String

  var fixItID: MessageID {
    MessageID(domain: "here", id: "this")
  }
}

final class FixItTests: XCTestCase {
  func testEditsForFixIt() throws {
    let markedSource = "protocol 1️⃣Multi2️⃣ 3️⃣ident 4️⃣{}"
    let (markers, source) = extractMarkers(markedSource)
    let positions = markers.mapValues { AbsolutePosition(utf8Offset: $0) }
    XCTAssertEqual(positions.count, 4)

    let expectedEdits = [
      SourceEdit(range: positions["1️⃣"]!..<positions["2️⃣"]!, replacement: "Multiident"),
      SourceEdit(range: positions["3️⃣"]!..<positions["4️⃣"]!, replacement: ""),
    ]
    let tree = Parser.parse(source: source)
    let diags = ParseDiagnosticsGenerator.diagnostics(for: tree)
    XCTAssertEqual(diags.count, 1)
    let diag = try XCTUnwrap(diags.first)
    XCTAssertEqual(diag.fixIts.count, 2)

    let fixIt = try XCTUnwrap(diag.fixIts.first)
    let changes = fixIt.changes
    let edits = fixIt.edits
    XCTAssertNotEqual(changes.count, edits.count)
    XCTAssertEqual(expectedEdits, edits)
  }

  func testTextualReplacement() throws {
    let five = AbsolutePosition(utf8Offset: 5)
    let fifteen = AbsolutePosition(utf8Offset: 15)
    let change = FixIt(
      message: SimpleFixItMessage(message: "fix it please"),
      changes: [
        .replaceText(
          range: five..<fifteen,
          with: "yours",
          in: Syntax("func myFunction() { }" as SourceFileSyntax)
        )
      ]
    )
    XCTAssertEqual(change.edits.count, 1)
    XCTAssertEqual(change.edits[0].range, five..<fifteen)
    XCTAssertEqual(change.edits[0].replacement, "yours")
  }
}
