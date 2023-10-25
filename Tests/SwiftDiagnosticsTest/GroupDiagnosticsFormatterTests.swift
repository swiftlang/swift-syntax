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
    diagnosticDescriptors: [DiagnosticDescriptor],
    file: StaticString = #file,
    line: UInt = #line
  ) -> (SourceFileID, [String: AbsolutePosition]) {
    let (markers, source) = extractMarkers(markedSource)
    let tree = Parser.parse(source: source)

    let parserDiagnostics = ParseDiagnosticsGenerator.diagnostics(for: tree)

    var additionalDiagnostics: [Diagnostic] = []

    do {
      additionalDiagnostics = try diagnosticDescriptors.map {
        try $0.createDiagnostic(inSyntaxTree: tree, usingLocationMarkers: markers)
      }
    } catch {
      XCTFail(error.localizedDescription, file: file, line: line)
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
  func testGroupingForMacroExpansion() {
    var group = GroupedDiagnostics()

    // Main source file.
    let (mainSourceID, mainSourceMarkers) = group.addTestFile(
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
          severity: .note
        )
      ]
    )
    let inExpansionNotePos = mainSourceMarkers["1️⃣"]!

    // Expansion source file
    _ = group.addTestFile(
      """
      let __a = pi
      let __b = 3
      if !(__a 1️⃣== __b) {
        fatalError("assertion failed: pi != 3")
      }
      """,
      displayName: "#myAssert",
      parent: (mainSourceID, inExpansionNotePos),
      diagnosticDescriptors: [
        DiagnosticDescriptor(
          locationMarker: "1️⃣",
          message: "no matching operator '==' for types 'Double' and 'Int'",
          severity: .error
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
        │ ╰─ note: in expansion of macro 'myAssert' here
        ╭─── #myAssert ───────────────────────────────────────────────────────
        │1 │ let __a = pi
        │2 │ let __b = 3
        │3 │ if !(__a == __b) {
        │  │          ╰─ error: no matching operator '==' for types 'Double' and 'Int'
        │4 │   fatalError("assertion failed: pi != 3")
        │5 │ }
        ╰─────────────────────────────────────────────────────────────────────
      6 │ print("hello"
        │              ╰─ error: expected ')' to end function call

      """
    )
  }

  func testGroupingForDoubleNestedMacroExpansion() {
    var group = GroupedDiagnostics()

    // Main source file.
    let (mainSourceID, mainSourceMarkers) = group.addTestFile(
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
    let (outerExpansionSourceID, outerExpansionSourceMarkers) = group.addTestFile(
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
    _ = group.addTestFile(
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
