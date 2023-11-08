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

import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax
import XCTest
import _SwiftSyntaxTestSupport

final class FixItTests: XCTestCase {
  func testEditsForFixIt() throws {
    let markedSource = "protocol 1️⃣Multi 2️⃣ident 3️⃣{}"
    let (markers, source) = extractMarkers(markedSource)
    let positions = markers.mapValues { AbsolutePosition(utf8Offset: $0) }
    XCTAssertEqual(positions.count, 3)

    let expectedEdits = [
      SourceEdit(range: positions["1️⃣"]!..<positions["2️⃣"]!, replacement: "Multiident "),
      SourceEdit(range: positions["2️⃣"]!..<positions["3️⃣"]!, replacement: ""),
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
}
