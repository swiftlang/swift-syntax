//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(ExperimentalLanguageFeatures) import SwiftSyntax
@_spi(ExperimentalLanguageFeatures) import SwiftWarningControl
import XCTest
import _SwiftSyntaxGenericTestSupport
import _SwiftSyntaxTestSupport

public class WarningGroupControlTests: XCTestCase {
  func testSimpleFunctionWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: error)
      func foo() {
        1️⃣let x = 1
      }
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error
      ]
    )
  }

  func testNestedFunctionWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(SomeOtherGroup, as: warning)
      @diagnose(GroupID, as: error)
      @diagnose(YetAnotherGroup, as: warning)
      func foo() {
        1️⃣let x = 1
        @diagnose(GroupID, as: warning)
        func bar() {
          2️⃣let x = 1
          @diagnose(GroupID, as: ignored)
          @diagnose(SomeOtherGroup, as: ignored)
          func baz() {
            3️⃣let x = 1
          }
          @diagnose(GroupID, as: error)
          func qux() {
            4️⃣let x = 1
            @diagnose(SomeOtherGroup, as: warning)
            func corge() {
              5️⃣let x = 1
            }
          }
        }
      }
      func grault() {
        6️⃣let x = 1
      }
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error,
        "2️⃣": .warning,
        "3️⃣": .ignored,
        "4️⃣": .error,
        "5️⃣": .error,
        "6️⃣": nil,
      ]
    )
  }

  func testEnabledGroupIdentifiers() throws {
    let source =
      """
      @diagnose(Group1, as: warning)
      @diagnose(Group2, as: error)
      @diagnose(Group3, as: ignored)
      func foo() {
        @diagnose(Group4, as: warning)
        func bar() {
          @diagnose(Group5, as: ignored)
          @diagnose(Group6, as: ignored)
          func baz() {}
          @diagnose(Group7, as: error)
          func qux() {
            @diagnose(Group8, as: warning)
            func corge() {}
          }
        }
      }
      """
    var parser = Parser(source)
    let parseTree = SourceFileSyntax.parse(from: &parser)
    let warningControlTree = parseTree.warningGroupControlRegionTree()
    let enabledDiagnosticGroups = warningControlTree.enabledGroups
    XCTAssertTrue(enabledDiagnosticGroups.contains("Group1"))
    XCTAssertTrue(enabledDiagnosticGroups.contains("Group2"))
    XCTAssertFalse(enabledDiagnosticGroups.contains("Group3"))
    XCTAssertTrue(enabledDiagnosticGroups.contains("Group4"))
    XCTAssertFalse(enabledDiagnosticGroups.contains("Group5"))
    XCTAssertFalse(enabledDiagnosticGroups.contains("Group6"))
    XCTAssertTrue(enabledDiagnosticGroups.contains("Group7"))
    XCTAssertTrue(enabledDiagnosticGroups.contains("Group8"))
  }

  func testNominalDeclWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: error)
      class Foo {
        1️⃣let x = 1
      }
      @diagnose(GroupID, as: ignored)
      struct Bar {
        2️⃣let x = 1
      }
      @diagnose(GroupID, as: warning)
      enum Baz {
        3️⃣let x = 1
      }
      @diagnose(GroupID, as: error)      
      actor Qux {
        4️⃣let x = 1
        @diagnose(GroupID, as: ignored)
        struct Quux {
          5️⃣let x = 1
        }
      }
      @diagnose(GroupID, as: warning)
      protocol Proto {
        6️⃣let x = 1
      }      
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error,
        "2️⃣": .ignored,
        "3️⃣": .warning,
        "4️⃣": .error,
        "5️⃣": .ignored,
        "6️⃣": .warning,
      ]
    )
  }

  func testInitializerWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: error)
      struct Foo {
        1️⃣let x = 1
        @diagnose(GroupID, as: ignored)
        init {
          2️⃣let x = 1
        }
        @diagnose(GroupID, as: warning)
        deinit {
          3️⃣let x = 1
        }
      }
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error,
        "2️⃣": .ignored,
        "3️⃣": .warning,
      ]
    )
  }

  func testExtensionWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: error)
      extension Foo {
        1️⃣let x = 1
      }
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error
      ]
    )
  }

  func testImportWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: ignored)
      import1️⃣ Foo
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .ignored
      ]
    )
  }

  func testSubscriptWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: ignored)
      struct Foo {
        @diagnose(GroupID, as: error)
        subscript(index: Int) -> Value {
          1️⃣let x = 1
        }
      }      
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error
      ]
    )
  }

  func testComputedPropertyWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: ignored)
      struct Foo {
        @diagnose(GroupID, as: error)
        var property: Int {
          1️⃣return 11
        }
      }      
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error
      ]
    )
  }

  func testAccessorWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: ignored)
      struct Foo {
        var property: Int {
          @diagnose(GroupID, as: error)
          get {
            1️⃣return 11
          }
          @diagnose(GroupID, as: warning)
          set {
            2️⃣let x = 1
          }
        }
      }      
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error,
        "2️⃣": .warning,
      ]
    )
  }

  func testEnclosingGlobalControlOverride() throws {
    // Global control does not override syntactic control
    try assertWarningGroupControl(
      """
      @diagnose(GroupID, as: error)
      func foo() {
        1️⃣let x = 1
      }
      """,
      globalControls: [("GroupID", .warning)],
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error
      ]
    )

    try assertWarningGroupControl(
      """
      func foo() {
        1️⃣let x = 1
        @diagnose(GroupID, as: ignored)
        func bar() {
          2️⃣let x = 1
        }
      }
      """,
      globalControls: [("GroupID", .error)],
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error,
        "2️⃣": .ignored,
      ]
    )
  }

  func testEnclosingGlobalControlOnly() throws {
    // Global control used in absense of a syntactic control
    try assertWarningGroupControl(
      """
      func foo() {
        1️⃣let x = 1
      }
      """,
      globalControls: [("GroupID", .warning)],
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .warning
      ]
    )
  }

  func testSubGroupInheritance() throws {
    try assertWarningGroupControl(
      """
      @diagnose(SuperGroupID, as: error)
      func foo() {
        1️⃣let x = 1
      }
      @diagnose(SuperSuperGroupID, as: ignored)
      func bar() {
        2️⃣let x = 1
      }
      """,
      groupInheritanceTree: DiagnosticGroupInheritanceTree(subGroups: [
        "SuperGroupID": ["GroupID"],
        "SuperSuperGroupID": ["SuperGroupID"],
      ]),
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error,
        "2️⃣": .ignored,
      ]
    )
  }

  func testInheritanceTreeCycle() throws {
    XCTAssertThrowsError(
      try DiagnosticGroupInheritanceTree(subGroups: [
        "SuperGroupID": ["GroupID"],
        "GroupID": ["SuperGroupID"],
      ])
    ) { (error: any Error) in
      XCTAssertEqual(
        error as? WarningControlError,
        .groupInheritanceCycle
      )
    }
  }

  func testOrderedGlobalControls() throws {
    // Parent group is ignored, followed by sub-group treated as warning
    try assertWarningGroupControl(
      """
      func foo() {
        1️⃣let x = 1
      }
      """,
      globalControls: [("SuperGroupID", .ignored), ("GroupID", .warning)],
      groupInheritanceTree: DiagnosticGroupInheritanceTree(subGroups: [
        "SuperGroupID": ["GroupID"]
      ]),
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .warning
      ]
    )

    // Parent group is treated as warning, followed by ignored sub-group
    try assertWarningGroupControl(
      """
      func foo() {
        1️⃣let x = 1
      }
      """,
      globalControls: [("SuperGroupID", .warning), ("GroupID", .ignored)],
      groupInheritanceTree: DiagnosticGroupInheritanceTree(subGroups: [
        "SuperGroupID": ["GroupID"]
      ]),
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .ignored
      ]
    )
  }

  func testFileScopeUsingWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      0️⃣let x = 1
      @diagnose(GroupID, as: warning)
      struct Bar {
        1️⃣let y = 1
      }
      struct Foo {
        @diagnose(GroupID, as: ignored)
        var property: Int {
          2️⃣return 11
        }
      }
      using @diagnose(GroupID, as: error)
      3️⃣let k = 1
      """,
      experimentalFeatures: [.defaultIsolationPerFile],
      diagnosticGroupID: "GroupID",
      states: [
        "0️⃣": .error,
        "1️⃣": .warning,
        "2️⃣": .ignored,
        "3️⃣": .error,
      ]
    )
  }

  func testDeclScopeUsingIgnored() throws {
    try assertWarningGroupControl(
      """
      0️⃣let x = 1
      @diagnose(GroupID, as: warning)
      struct Bar {
        1️⃣let y = 1
      }
      struct Foo {
        using @diagnose(GroupID, as: error)
        var property: Int {
          2️⃣return 11
        }
      }

      """,
      experimentalFeatures: [.defaultIsolationPerFile],
      diagnosticGroupID: "GroupID",
      states: [
        "0️⃣": .none,
        "1️⃣": .warning,
        "2️⃣": .none,
      ]
    )
  }

  func testWarnSpellingBackwardCompat() throws {
    // The old @warn spelling should continue to work as an alias
    try assertWarningGroupControl(
      """
      @warn(GroupID, as: error)
      func foo() {
        1️⃣let x = 1
        @warn(GroupID, as: ignored)
        func bar() {
          2️⃣let x = 1
        }
      }
      """,
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error,
        "2️⃣": .ignored,
      ]
    )
  }
}

/// Assert that the various marked positions in the source code have the
/// expected warning behavior controls.
private func assertWarningGroupControl(
  _ markedSource: String,
  globalControls: [(DiagnosticGroupIdentifier, WarningGroupControl)] = [],
  groupInheritanceTree: DiagnosticGroupInheritanceTree? = nil,
  experimentalFeatures: Parser.ExperimentalFeatures? = nil,
  diagnosticGroupID: DiagnosticGroupIdentifier,
  states: [String: WarningGroupControl?],
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  // Pull out the markers that we'll use to dig out nodes to query.
  let (markerLocations, source) = extractMarkers(markedSource)
  let experimentalFeatures = experimentalFeatures ?? []
  var parser = Parser(source, experimentalFeatures: experimentalFeatures)
  let tree = SourceFileSyntax.parse(from: &parser)
  for (marker, location) in markerLocations {
    guard let expectedState = states[marker] else {
      XCTFail("Missing marker \(marker) in expected states", file: file, line: line)
      continue
    }

    let absolutePosition = AbsolutePosition(utf8Offset: location)
    guard let token = tree.token(at: absolutePosition) else {
      XCTFail("Unable to find token at location \(location)", file: file, line: line)
      continue
    }

    let warningControlRegions = tree.warningGroupControlRegionTree(
      globalControls: globalControls,
      groupInheritanceTree: groupInheritanceTree
    )

    let groupControl = token.warningGroupControl(
      for: diagnosticGroupID,
      globalControls: globalControls,
      groupInheritanceTree: groupInheritanceTree
    )
    XCTAssertEqual(groupControl, expectedState)

    let groupControlViaRegions = warningControlRegions.warningGroupControl(
      at: absolutePosition,
      for: diagnosticGroupID
    )
    XCTAssertEqual(groupControlViaRegions, expectedState)
  }
}
