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

extension GroupedDiagnostics {
  /// Add a new test file to the group, starting with marked source and using
  /// the markers to add any suggested extra diagnostics at the marker
  /// positions.
  mutating func addTestFile(
    _ markedSource: String,
    displayName: String,
    parent: (SourceFileID, AbsolutePosition)? = nil,
    diagnosticDescriptors: [DiagnosticDescriptor]
  ) throws -> (SourceFileID, [String: AbsolutePosition]) {
    let (markers, source) = extractMarkers(markedSource)
    let tree = Parser.parse(source: source)

    let parserDiagnostics = ParseDiagnosticsGenerator.diagnostics(for: tree)

    let additionalDiagnostics = try diagnosticDescriptors.compactMap {
      try $0.createDiagnostic(inSyntaxTree: tree, usingLocationMarkers: markers)
    }

    let id = addSourceFile(
      tree: tree,
      displayName: displayName,
      parent: parent,
      diagnostics: parserDiagnostics + additionalDiagnostics
    )

    let markersWithAbsPositions = markers.map { (marker, pos) in
      (marker, AbsolutePosition(utf8Offset: pos))
    }

    return (id, Dictionary(uniqueKeysWithValues: markersWithAbsPositions))
  }
}

final class GroupedDiagnosticsFormatterTests: XCTestCase {
  func testSourceLocations() throws {
    var group = GroupedDiagnostics()

    // Main source file.
    _ = try group.addTestFile(
      """
      #sourceLocation(file: "other.swift", line: 123)
      let pi = 3.14159 x
      """,
      displayName: "main.swift",
      diagnosticDescriptors: []
    )
    let annotated = DiagnosticsFormatter.annotateSources(in: group)
    assertStringsEqualWithDiff(
      annotated,
      """
      other.swift:123:17: error: consecutive statements on a line must be separated by newline or ';'
      1 │ #sourceLocation(file: "other.swift", line: 123)
      2 │ let pi = 3.14159 x
        │                 ╰─ error: consecutive statements on a line must be separated by newline or ';'

      """
    )
  }

  func testGroupingForMacroExpansion() throws {
    var group = GroupedDiagnostics()

    // Main source file.
    let (mainSourceID, mainSourceMarkers) = try group.addTestFile(
      """


      // test
      let pi = 3.14159
      1️⃣#myAssert(pi == 3)
      print("hello"
      """,
      displayName: "main.swift",
      diagnosticDescriptors: [
        DiagnosticDescriptor(
          locationMarker: "1️⃣",
          message: "in expansion of macro 'myAssert' here",
          severity: .note,
          noteDescriptors: [
            NoteDescriptor(locationMarker: "1️⃣", message: "first additional note"),
            NoteDescriptor(locationMarker: "1️⃣", message: "second additional note"),
            NoteDescriptor(locationMarker: "1️⃣", message: "last additional note"),
          ]
        )
      ]
    )
    let inExpansionNotePos = mainSourceMarkers["1️⃣"]!

    // Expansion source file
    _ = try group.addTestFile(
      """
      let __a = pi
      let __b = 3
      if 2️⃣!(__a 1️⃣== __b) {
        fatalError("assertion failed: pi != 3")
      }
      """,
      displayName: "#myAssert",
      parent: (mainSourceID, inExpansionNotePos),
      diagnosticDescriptors: [
        DiagnosticDescriptor(
          locationMarker: "1️⃣",
          message: "no matching operator '==' for types 'Double' and 'Int'",
          severity: .error,
          noteDescriptors: [NoteDescriptor(locationMarker: "2️⃣", message: "in this condition element")]
        )
      ]
    )

    let annotated = DiagnosticsFormatter.annotateSources(in: group)
    assertStringsEqualWithDiff(
      annotated,
      """
      main.swift:6:14: error: expected ')' to end function call
      3 │ // test
      4 │ let pi = 3.14159
      5 │ #myAssert(pi == 3)
        │ ├─ note: in expansion of macro 'myAssert' here
        │ ├─ note: first additional note
        │ ├─ note: second additional note
        │ ╰─ note: last additional note
        ╭─── #myAssert ───────────────────────────────────────────────────────
        │1 │ let __a = pi
        │2 │ let __b = 3
        │3 │ if !(__a == __b) {
        │  │    │     ╰─ error: no matching operator '==' for types 'Double' and 'Int'
        │  │    ╰─ note: in this condition element
        │4 │   fatalError("assertion failed: pi != 3")
        │5 │ }
        ╰─────────────────────────────────────────────────────────────────────
      6 │ print("hello"
        │      │       ╰─ error: expected ')' to end function call
        │      ╰─ note: to match this opening '('

      """
    )
  }

  func testGroupingForDoubleNestedMacroExpansion() throws {
    var group = GroupedDiagnostics()

    // Main source file.
    let (mainSourceID, mainSourceMarkers) = try group.addTestFile(
      """
      let pi = 3.14159
      1️⃣#myAssert(pi == 3)
      print("hello")
      """,
      displayName: "main.swift",
      diagnosticDescriptors: [
        DiagnosticDescriptor(locationMarker: "1️⃣", message: "in expansion of macro 'myAssert' here", severity: .note)
      ]
    )
    let inExpansionNotePos = mainSourceMarkers["1️⃣"]!

    // Outer expansion source file
    let (outerExpansionSourceID, outerExpansionSourceMarkers) = try group.addTestFile(
      """
      let __a = pi
      let __b = 3
      if 1️⃣#invertedEqualityCheck(__a, __b) {
        fatalError("assertion failed: pi != 3")
      }
      """,
      displayName: "#myAssert",
      parent: (mainSourceID, inExpansionNotePos),
      diagnosticDescriptors: [
        DiagnosticDescriptor(locationMarker: "1️⃣", message: "in expansion of macro 'invertedEqualityCheck' here", severity: .note)
      ]
    )
    let inInnerExpansionNotePos = outerExpansionSourceMarkers["1️⃣"]!

    // Expansion source file
    _ = try group.addTestFile(
      """
      !(__a 1️⃣== __b)
      """,
      displayName: "#invertedEqualityCheck",
      parent: (outerExpansionSourceID, inInnerExpansionNotePos),
      diagnosticDescriptors: [
        DiagnosticDescriptor(locationMarker: "1️⃣", message: "no matching operator '==' for types 'Double' and 'Int'", severity: .error)
      ]
    )

    let annotated = DiagnosticsFormatter.annotateSources(in: group)
    assertStringsEqualWithDiff(
      annotated,
      """
      #invertedEqualityCheck:1:7: error: no matching operator '==' for types 'Double' and 'Int'
      ╰─ main.swift:2:1: note: expanded code originates here
      1 │ let pi = 3.14159
      2 │ #myAssert(pi == 3)
        │ ╰─ note: in expansion of macro 'myAssert' here
        ╭─── #myAssert ───────────────────────────────────────────────────────
        │1 │ let __a = pi
        │2 │ let __b = 3
        │3 │ if #invertedEqualityCheck(__a, __b) {
        │  │    ╰─ note: in expansion of macro 'invertedEqualityCheck' here
        │  ╭─── #invertedEqualityCheck ───────────────────────────────────────
        │  │1 │ !(__a == __b)
        │  │  │       ╰─ error: no matching operator '==' for types 'Double' and 'Int'
        │  ╰──────────────────────────────────────────────────────────────────
        │4 │   fatalError("assertion failed: pi != 3")
        │5 │ }
        ╰─────────────────────────────────────────────────────────────────────
      3 │ print("hello")

      """
    )
  }
}
