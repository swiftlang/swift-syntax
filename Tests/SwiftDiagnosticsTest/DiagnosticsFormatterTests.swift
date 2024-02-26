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
import SwiftSyntax
import XCTest

final class DiagnosticsFormatterTests: XCTestCase {
  func testSimpleFunctionWithIfStatementDiagnosticAppearsAtCorrectLocation() {
    assertAnnotated(
      markedSource: """
        func foo() -> Int {
          if 1️⃣1 != 0 {
            return 0
          }
          return 1
        }
        """,
      withDiagnostics: [
        DiagnosticDescriptor(
          locationMarker: "1️⃣",
          message: "My message goes here!",
          severity: .error
        )
      ],
      matches: """
        1 │ func foo() -> Int {
        2 │   if 1 != 0 {
          │      ╰─ error: My message goes here!
        3 │     return 0
        4 │   }

        """
    )
  }

  func testClassMethodWithDefaultInitializerDiagnosticAndNoteAppearAtCorrectLocations() {
    assertAnnotated(
      markedSource: """
        final class Bar {
          var counter = 1

          init(counter: Int = 1) {
            self.counter = counter
          }

          func foo() -> Int {
            if 1️⃣1 != 0 {
              return 0
            }
            return 2️⃣1
          }
        }
        """,
      withDiagnostics: [
        DiagnosticDescriptor(
          locationMarker: "2️⃣",
          message: "Diagnostic message",
          severity: .error,
          noteDescriptors: [NoteDescriptor(locationMarker: "1️⃣", message: "Note message")]
        )
      ],
      matches: """
         7 │ 
         8 │   func foo() -> Int {
         9 │     if 1 != 0 {
           │        ╰─ note: Note message
        10 │       return 0
        11 │     }
        12 │     return 1
           │            ╰─ error: Diagnostic message
        13 │   }
        14 │ }

        """
    )
  }

  func testClassWithInitializerShowsRemarkAndNoteAtCorrectLocations() {
    assertAnnotated(
      markedSource: """
        final class 1️⃣Bar {
          var counter = 1

          2️⃣init(counter: Int = 1) {
            self.counter = counter
          }

          func foo() -> Int {
            if 1 != 0 {
              return 0
            }
            return 1
          }
        }
        """,
      withDiagnostics: [
        DiagnosticDescriptor(
          locationMarker: "2️⃣",
          message: "Diagnostic message",
          severity: .remark,
          noteDescriptors: [NoteDescriptor(locationMarker: "1️⃣", message: "Note message")]
        )
      ],
      matches: """
         1 │ final class Bar {
           │             ╰─ note: Note message
         2 │   var counter = 1
         3 │ 
         4 │   init(counter: Int = 1) {
           │   ╰─ remark: Diagnostic message
         5 │     self.counter = counter
         6 │   }

        """
    )
  }

  func testSimpleFunctionWithIfStatementMultipleNotesAndDiagnosticAppear() {
    assertAnnotated(
      markedSource: """
        func foo() -> Int {
          if 1️⃣1 != 0 2️⃣{
            return 0
          }
          return 1
        }
        """,
      withDiagnostics: [
        DiagnosticDescriptor(
          locationMarker: "1️⃣",
          message: "My message goes here!",
          noteDescriptors: [
            NoteDescriptor(locationMarker: "1️⃣", message: "First message"),
            NoteDescriptor(locationMarker: "1️⃣", message: "Second message"),
            NoteDescriptor(locationMarker: "2️⃣", message: "Other message"),
          ]
        )
      ],
      matches: """
        1 │ func foo() -> Int {
        2 │   if 1 != 0 {
          │      │      ╰─ note: Other message
          │      ├─ error: My message goes here!
          │      ├─ note: First message
          │      ╰─ note: Second message
        3 │     return 0
        4 │   }

        """
    )
  }

  func testSimpleFunctionWithIfStatementNotesAndDiagnosticAtDifferentMarkers() {
    assertAnnotated(
      markedSource: """
        func foo2️⃣() -> Int {
          if 1️⃣1 != 0 {
            return 0
          }
          return 1
        }
        """,
      withDiagnostics: [
        DiagnosticDescriptor(
          locationMarker: "1️⃣",
          message: "My message goes here!",
          noteDescriptors: [
            NoteDescriptor(locationMarker: "1️⃣", message: "First message"),
            NoteDescriptor(locationMarker: "2️⃣", message: "Second message"),
          ]
        )
      ],
      matches: """
        1 │ func foo() -> Int {
          │         ╰─ note: Second message
        2 │   if 1 != 0 {
          │      ├─ error: My message goes here!
          │      ╰─ note: First message
        3 │     return 0
        4 │   }

        """
    )
  }

  func testBasicMacroExpansionContextMultipleMethodsMultipleDiagnosticsAndNotes() {
    assertAnnotated(
      markedSource: """
        extension BasicMacroExpansionContext {
          /// Detach the given node, and record where it came from.
          public func5️⃣ detach<Node: SyntaxProtocol>(_ node: Node) -> Node {
            let detached = 1️⃣node.detached
            detachedNodes[Syntax(detached)] = Syntax(node)
            return 3️⃣detached
          }

          /// Fold all operators in `node` and associate the ``KnownSourceFile``
          /// information of `node` with the original new, folded tree.
          func foldAllOperators(of node: some SyntaxProtocol, with operatorTable: OperatorTable) -> Syntax {
            let folded = operatorTable.foldAll(node, errorHandler: { _ in /*ignore*/ })
            if let originalSourceFile = node.root.as(SourceFileSyntax.self),
              let 8️⃣newSourceFile = folded.root.as(SourceFileSyntax.self)
            {
              // Folding operators doesn't change the source file and its associated locations
              // Record the `KnownSourceFile` information for the folded tree.
              sourceFiles[4️⃣newSourceFile] 6️⃣= sourceFiles[2️⃣originalSourceFile]
            }
            7️⃣return folded
          }
        }
        """,
      withDiagnostics: [
        DiagnosticDescriptor(
          locationMarker: "1️⃣",
          message: "My message goes here!",
          noteDescriptors: [
            NoteDescriptor(locationMarker: "1️⃣", message: "First message"),
            NoteDescriptor(locationMarker: "2️⃣", message: "Second message"),
            NoteDescriptor(locationMarker: "2️⃣", message: "Make sure to validate source files."),
            NoteDescriptor(locationMarker: "3️⃣", message: "Another message!"),
            NoteDescriptor(locationMarker: "4️⃣", message: "This is related"),
            NoteDescriptor(locationMarker: "5️⃣", message: "Consider refactoring this method."),
            NoteDescriptor(locationMarker: "5️⃣", message: "Consider refactoring this method..."),
            NoteDescriptor(locationMarker: "5️⃣", message: "Consider refactoring this method......"),
            NoteDescriptor(locationMarker: "5️⃣", message: "Consider refactoring this method......."),
            NoteDescriptor(locationMarker: "6️⃣", message: "Verify the type constraints."),
            NoteDescriptor(locationMarker: "7️⃣", message: "Make sure to validate source files."),
            NoteDescriptor(locationMarker: "8️⃣", message: "Check returned object types"),
          ]
        )
      ],
      matches: """
         1 │ extension BasicMacroExpansionContext {
         2 │   /// Detach the given node, and record where it came from.
         3 │   public func detach<Node: SyntaxProtocol>(_ node: Node) -> Node {
           │          ├─ note: Consider refactoring this method.
           │          ├─ note: Consider refactoring this method...
           │          ├─ note: Consider refactoring this method......
           │          ╰─ note: Consider refactoring this method.......
         4 │     let detached = node.detached
           │                    ├─ error: My message goes here!
           │                    ╰─ note: First message
         5 │     detachedNodes[Syntax(detached)] = Syntax(node)
         6 │     return detached
           │            ╰─ note: Another message!
         7 │   }
         8 │ 
           ┆
        12 │     let folded = operatorTable.foldAll(node, errorHandler: { _ in /*ignore*/ })
        13 │     if let originalSourceFile = node.root.as(SourceFileSyntax.self),
        14 │       let newSourceFile = folded.root.as(SourceFileSyntax.self)
           │           ╰─ note: Check returned object types
        15 │     {
        16 │       // Folding operators doesn't change the source file and its associated locations
        17 │       // Record the `KnownSourceFile` information for the folded tree.
        18 │       sourceFiles[newSourceFile] = sourceFiles[originalSourceFile]
           │                   │              │             ├─ note: Second message
           │                   │              │             ╰─ note: Make sure to validate source files.
           │                   │              ╰─ note: Verify the type constraints.
           │                   ╰─ note: This is related
        19 │     }
        20 │     return folded
           │     ╰─ note: Make sure to validate source files.
        21 │   }
        22 │ }

        """
    )
  }
}
