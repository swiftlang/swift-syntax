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
    file: StaticString = #filePath,
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
  func testSourceLocations() {
    var group = GroupedDiagnostics()

    // Main source file.
    _ = group.addTestFile(
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
      1 | #sourceLocation(file: "other.swift", line: 123)
      2 | let pi = 3.14159 x
        |                 `- error: consecutive statements on a line must be separated by newline or ';'

      """
    )
  }

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
      3 | // test
      4 | let pi = 3.14159
      5 | #myAssert(pi == 3)
        | `- note: in expansion of macro 'myAssert' here
        +--- #myAssert -------------------------------------------------------
        |1 | let __a = pi
        |2 | let __b = 3
        |3 | if !(__a == __b) {
        |  |          `- error: no matching operator '==' for types 'Double' and 'Int'
        |4 |   fatalError("assertion failed: pi != 3")
        |5 | }
        +---------------------------------------------------------------------
      6 | print("hello"
        |      |       `- error: expected ')' to end function call
        |      `- note: to match this opening '('

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
        DiagnosticDescriptor(
          locationMarker: "1️⃣",
          message: "in expansion of macro 'invertedEqualityCheck' here",
          severity: .note
        )
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
      #invertedEqualityCheck:1:7: error: no matching operator '==' for types 'Double' and 'Int'
      `- main.swift:2:1: note: expanded code originates here
      1 | let pi = 3.14159
      2 | #myAssert(pi == 3)
        | `- note: in expansion of macro 'myAssert' here
        +--- #myAssert -------------------------------------------------------
        |1 | let __a = pi
        |2 | let __b = 3
        |3 | if #invertedEqualityCheck(__a, __b) {
        |  |    `- note: in expansion of macro 'invertedEqualityCheck' here
        |  +--- #invertedEqualityCheck ---------------------------------------
        |  |1 | !(__a == __b)
        |  |  |       `- error: no matching operator '==' for types 'Double' and 'Int'
        |  +------------------------------------------------------------------
        |4 |   fatalError("assertion failed: pi != 3")
        |5 | }
        +---------------------------------------------------------------------
      3 | print("hello")

      """
    )
  }

  func testGroupingForSameLineDiagnostics() {
    var group = GroupedDiagnostics()

    // Main source file.
    let (mainSourceID, mainSourceMarkers) = group.addTestFile(
      """
      1️⃣let pi = 2️⃣"3.14159"
      3️⃣#myAssert(pi == 4️⃣3)
      print("hello")
      """,
      displayName: "main.swift",
      diagnosticDescriptors: [
        DiagnosticDescriptor(
          locationMarker: "3️⃣",
          message: "in expansion of macro 'myAssert' here", 
          severity: .note,
          noteDescriptors: [
            NoteDescriptor(
              locationMarker: "1️⃣", id: MessageID(domain: "test", id: "conjured"), 
              message: "Inferred type 'String' here"
            ),
            NoteDescriptor(
              locationMarker: "4️⃣", id: MessageID(domain: "test", id: "conjured"), 
              message: "Inferred type 'Int' here"
            )
          ]
        )
      ]
    )
    let inExpansionNotePos = mainSourceMarkers["3️⃣"]!

    // Outer expansion source file
    let (outerExpansionSourceID, outerExpansionSourceMarkers) = group.addTestFile(
      """
      let 1️⃣__a = pi
      let 2️⃣__b = 3
      if 3️⃣#invertedEqualityCheck(__a, __b) {
        fatalError("assertion failed: pi != 3")
      }
      """,
      displayName: "#myAssert",
      parent: (mainSourceID, inExpansionNotePos),
      diagnosticDescriptors: [
        DiagnosticDescriptor(
          locationMarker: "3️⃣",
          message: "in expansion of macro 'invertedEqualityCheck' here",
          severity: .note,
          noteDescriptors: [
            NoteDescriptor(
              locationMarker: "3️⃣", 
              id: MessageID(domain: "test", id: "conjured"), 
              message: "#invertedEqualityCheck expects operands of the same type"
            ),
            NoteDescriptor(
              locationMarker: "3️⃣", 
              id: MessageID(domain: "test", id: "conjured"), 
              message: "#invertedEqualityCheck expects '__a' and '__b' to have the same type"
            ),
            NoteDescriptor(
              locationMarker: "1️⃣", 
              id: MessageID(domain: "test", id: "conjured"), 
              message: "Inferred type 'String' here"
            ),
            NoteDescriptor(
              locationMarker: "2️⃣", 
              id: MessageID(domain: "test", id: "conjured"), 
              message: "Inferred type 'Int' here"
            )
          ]
        )
      ]
    )
    let inInnerExpansionNotePos = outerExpansionSourceMarkers["3️⃣"]!

    // Expansion source file
    _ = group.addTestFile(
      """
      1️⃣!(2️⃣__a 3️⃣== 4️⃣__b)
      """,
      displayName: "#invertedEqualityCheck",
      parent: (outerExpansionSourceID, inInnerExpansionNotePos),
      diagnosticDescriptors: [
        DiagnosticDescriptor(
          locationMarker: "3️⃣",
          message: "no matching operator '==' for types 'String' and 'Int'",
          severity: .error,
          noteDescriptors: [
            NoteDescriptor(
              locationMarker: "1️⃣", 
              id: MessageID(domain: "test", id: "conjured"), 
              message: "#invertedEqualityCheck expects operands of the same type"
            ),
            NoteDescriptor(
              locationMarker: "2️⃣",
              id: MessageID(domain: "test", id: "conjured"), 
              message: "Inferred type 'String' here"
            ),
            NoteDescriptor(
              locationMarker: "4️⃣", 
              id: MessageID(domain: "test", id: "conjured"), 
              message: "Inferred type 'Int' here"
            ),
          ]
        ),
        DiagnosticDescriptor(
          locationMarker: "3️⃣",
          id: MessageID(domain: "test", id: "conjuredError2"),
          message: "operator `==` is unavailable: unavailable in embedded Swift",
          severity: .error
        ),
        DiagnosticDescriptor(
          locationMarker: "3️⃣",
          id: MessageID(domain: "test", id: "conjuredError2"),
          message: "#invertedEqualityCheck expects operands to be integer literals",
          severity: .error
        )
      ]
    )

    let annotated = DiagnosticsFormatter.annotateSources(in: group)
    print("Annotated:", annotated)
    assertStringsEqualWithDiff(
      annotated,
      """
      #invertedEqualityCheck:1:7: error: no matching operator '==' for types 'String' and 'Int'
      `- main.swift:2:1: note: expanded code originates here
      1 | let pi = "3.14159"
        | `- note: Inferred type 'String' here
      2 | #myAssert(pi == 3)
        | |               `- note: Inferred type 'Int' here
        | `- note: in expansion of macro 'myAssert' here
        +--- #myAssert -------------------------------------------------------
        |1 | let __a = pi
        |  |     `- note: Inferred type 'String' here
        |2 | let __b = 3
        |  |     `- note: Inferred type 'Int' here
        |3 | if #invertedEqualityCheck(__a, __b) {
        |  |    |- note: in expansion of macro 'invertedEqualityCheck' here
        |  |    |- note: #invertedEqualityCheck expects operands of the same type
        |  |    `- note: #invertedEqualityCheck expects '__a' and '__b' to have the same type
        |  +--- #invertedEqualityCheck ---------------------------------------
        |  |1 | !(__a == __b)
        |  |  | | |   |  `- note: Inferred type 'Int' here
        |  |  | | |   |- error: no matching operator '==' for types 'String' and 'Int'
        |  |  | | |   |- error: operator `==` is unavailable: unavailable in embedded Swift
        |  |  | | |   `- error: #invertedEqualityCheck expects operands to be integer literals
        |  |  | | `- note: Inferred type 'String' here
        |  |  | `- note: #invertedEqualityCheck expects operands of the same type
        |  +------------------------------------------------------------------
        |4 |   fatalError("assertion failed: pi != 3")
        |5 | }
        +---------------------------------------------------------------------
      3 | print("hello")
      
      """
    )
  }

  func testCategoryFootnotes() {
    let categories = [
      DiagnosticCategory(
        name: "StrictMemorySafety",
        documentationURL: "http://example.com/memory-safety"
      ),
      DiagnosticCategory(
        name: "deprecated",
        documentationURL: "http://example.com/deprecated"
      ),
      DiagnosticCategory(name: "nothing", documentationURL: nil),
    ]

    assertStringsEqualWithDiff(
      DiagnosticsFormatter().categoryFootnotes(
        categories,
        leadingText: "Footnotes:\n"
      ),
      """
      Footnotes:
      [#deprecated]: <http://example.com/deprecated>
      [#StrictMemorySafety]: <http://example.com/memory-safety>
      """
    )
  }
}
