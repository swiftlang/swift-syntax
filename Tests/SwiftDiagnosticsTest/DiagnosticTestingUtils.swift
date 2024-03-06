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

/// A typealias representing a location marker.
///
/// This string serves to pinpoint the exact location of a particular token in the SwiftSyntax tree.
/// Once the token location is identified, it can be leveraged for various test-specific operations such as inserting diagnostics, notes, or fix-its,
/// or for closer examination of the syntax tree.
///
/// Markers are instrumental in writing unit tests that require precise location data. They are commonly represented using emojis like 1️⃣, 2️⃣, 3️⃣, etc., to improve readability.
///
/// ### Example
///
/// In the following test code snippet, the emojis 1️⃣ and 2️⃣ are used as location markers:
///
/// ```swift
/// func foo() -> Int {
///   if 1️⃣1 != 0 2️⃣{
///     return 0
///   }
///   return 1
/// }
/// ```
typealias LocationMarker = String

/// Represents a descriptor for constructing a diagnostic in testing.
struct DiagnosticDescriptor {
  /// Represents errors that can occur while creating a `Diagnostic` instance.
  private struct DiagnosticCreationError: Error, LocalizedError {
    /// A human-readable message describing what went wrong.
    let message: String

    /// A localized message describing what went wrong. Required by `LocalizedError`.
    var errorDescription: String? { message }
  }

  /// The marker pointing to location in source code.
  let locationMarker: LocationMarker

  /// The ID associated with the message, used for categorizing or referencing it.
  let id: MessageID

  /// The textual content of the message to be displayed.
  let message: String

  /// The severity level of the diagnostic message.
  let severity: DiagnosticSeverity

  /// The syntax elements to be highlighted for this diagnostic message.
  let highlight: [Syntax]  // TODO: How to create an abstract model for this?

  /// Descriptors for any accompanying notes for this diagnostic message.
  let noteDescriptors: [NoteDescriptor]

  /// Descriptors for any Fix-Its that can be applied for this diagnostic message.
  let fixIts: [FixIt]  // TODO: How to create an abstract model for this?

  /// Initializes a new `DiagnosticDescriptor`.
  ///
  /// - Parameters:
  ///   - locationMarker: The marker pointing to location in source code.
  ///   - id: The message ID of the diagnostic.
  ///   - message: The textual message to display for the diagnostic.
  ///   - severity: The severity level of the diagnostic. Default is `.error`.
  ///   - highlight: The syntax elements to be highlighted. Default is an empty array.
  ///   - noteDescriptors: An array of note descriptors for additional context. Default is an empty array.
  ///   - fixIts: An array of Fix-It descriptors for quick fixes. Default is an empty array.
  init(
    locationMarker: LocationMarker,
    id: MessageID = MessageID(domain: "test", id: "conjured"),
    message: String,
    severity: DiagnosticSeverity = .error,
    highlight: [Syntax] = [],
    noteDescriptors: [NoteDescriptor] = [],
    fixIts: [FixIt] = []
  ) {
    self.locationMarker = locationMarker
    self.id = id
    self.message = message
    self.severity = severity
    self.highlight = highlight
    self.noteDescriptors = noteDescriptors
    self.fixIts = fixIts
  }

  /// Creates a ``Diagnostic`` instance from a given ``DiagnosticDescriptor``, syntax tree, and location markers.
  ///
  /// - Parameters:
  ///   - tree: The syntax tree where the diagnostic is rooted.
  ///   - markers: A dictionary mapping location markers to their respective offsets in the source code.
  ///
  /// - Throws:
  ///   - Error if the location marker is not found in the source code.
  ///   - Error if a node corresponding to a given marker is not found in the syntax tree.
  ///
  /// - Returns: A ``Diagnostic`` instance populated with details from the ``DiagnosticDescriptor``.
  func createDiagnostic(
    inSyntaxTree tree: some SyntaxProtocol,
    usingLocationMarkers markers: [LocationMarker: Int]
  ) throws -> Diagnostic {
    func node(at marker: LocationMarker) throws -> Syntax {
      guard let markedOffset = markers[marker] else {
        throw DiagnosticCreationError(message: "Marker \(marker) not found in the marked source")
      }
      let markedPosition = AbsolutePosition(utf8Offset: markedOffset)
      guard let token = tree.token(at: markedPosition) else {
        throw DiagnosticCreationError(message: "Node not found at marker \(marker)")
      }
      return Syntax(token)
    }

    let diagnosticNode = try node(at: self.locationMarker)

    let notes = try self.noteDescriptors.map { noteDescriptor in
      Note(
        node: try node(at: noteDescriptor.locationMarker),
        message: SimpleNoteMessage(message: noteDescriptor.message, noteID: noteDescriptor.id)
      )
    }

    return Diagnostic(
      node: diagnosticNode,
      message: SimpleDiagnosticMessage(
        message: self.message,
        diagnosticID: self.id,
        severity: self.severity
      ),
      highlights: self.highlight,
      notes: notes,
      fixIts: self.fixIts
    )
  }
}

/// Represents a descriptor for constructing a note message in testing.
struct NoteDescriptor {
  /// The marker pointing to location in source code.
  let locationMarker: LocationMarker

  /// The ID associated with the note message.
  let id: MessageID

  /// The textual content of the note to be displayed.
  let message: String
}

/// A simple implementation of the `NoteMessage` protocol for testing.
/// This struct holds the message text and a fix-it ID for a note.
struct SimpleNoteMessage: NoteMessage {
  /// The textual content of the note to be displayed.
  let message: String

  /// The unique identifier for this note message.
  let noteID: MessageID
}

/// A simple implementation of the `DiagnosticMessage` protocol for testing.
/// This struct holds the message text, diagnostic ID, and severity for a diagnostic.
struct SimpleDiagnosticMessage: DiagnosticMessage {
  /// The textual content of the diagnostic message to be displayed.
  let message: String

  /// The ID associated with the diagnostic message for categorization or referencing.
  let diagnosticID: MessageID

  /// The severity level of the diagnostic message.
  let severity: DiagnosticSeverity
}

/// Asserts that the annotated source generated from diagnostics matches an expected annotated source.
///
/// - Parameters:
///   - markedSource: The source code with location markers `LocationMarker` for diagnostics.
///   - withDiagnostics: An array of diagnostic descriptors to generate diagnostics.
///   - matches: The expected annotated source after applying the diagnostics.
///   - file: The file in which failure occurred.
///   - line: The line number on which failure occurred.
func assertAnnotated(
  markedSource: String,
  withDiagnostics diagnosticDescriptors: [DiagnosticDescriptor],
  matches expectedAnnotatedSource: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  let (markers, source) = extractMarkers(markedSource)
  let tree = Parser.parse(source: source)

  var diagnostics: [Diagnostic] = []

  do {
    diagnostics = try diagnosticDescriptors.map {
      try $0.createDiagnostic(inSyntaxTree: tree, usingLocationMarkers: markers)
    }
  } catch {
    XCTFail(error.localizedDescription, file: file, line: line)
  }

  let annotatedSource = DiagnosticsFormatter.annotatedSource(tree: tree, diags: diagnostics)

  assertStringsEqualWithDiff(
    annotatedSource,
    expectedAnnotatedSource,
    file: file,
    line: line
  )
}
