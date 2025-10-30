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

import SwiftParser
import SwiftSyntax
@_spi(ExperimentalLanguageFeatures) import SwiftWarningControl
import XCTest
import _SwiftSyntaxGenericTestSupport
import _SwiftSyntaxTestSupport

public class WarningGroupControlTests: XCTestCase {
  func testSimpleFunctionWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @warn(GroupID, as: error)
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
      @warn(SomeOtherGroup, as: warning)
      @warn(GroupID, as: error)
      @warn(YetAnotherGroup, as: warning)
      func foo() {
        1️⃣let x = 1
        @warn(GroupID, as: warning)
        func bar() {
          2️⃣let x = 1
          @warn(GroupID, as: ignored)
          @warn(SomeOtherGroup, as: ignored)
          func baz() {
            3️⃣let x = 1
          }
          @warn(GroupID, as: error)
          func qux() {
            4️⃣let x = 1
            @warn(SomeOtherGroup, as: warning)
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

  func testNominalDeclWarningGroupControl() throws {
    try assertWarningGroupControl(
      """
      @warn(GroupID, as: error)
      class Foo {
        1️⃣let x = 1
      }
      @warn(GroupID, as: ignored)
      struct Bar {
        2️⃣let x = 1
      }
      @warn(GroupID, as: warning)
      enum Baz {
        3️⃣let x = 1
      }
      @warn(GroupID, as: error)      
      actor Qux {
        4️⃣let x = 1
        @warn(GroupID, as: ignored)
        struct Quux {
          5️⃣let x = 1
        }
      }
      @warn(GroupID, as: warning)
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
      @warn(GroupID, as: error)
      struct Foo {
        1️⃣let x = 1
        @warn(GroupID, as: ignored)
        init {
          2️⃣let x = 1
        }
        @warn(GroupID, as: warning)
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
      @warn(GroupID, as: error)
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
      @warn(GroupID, as: ignored)
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
      @warn(GroupID, as: ignored)
      struct Foo {
        @warn(GroupID, as: error)
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
      @warn(GroupID, as: ignored)
      struct Foo {
        @warn(GroupID, as: error)
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
      @warn(GroupID, as: ignored)
      struct Foo {
        var property: Int {
          @warn(GroupID, as: error)
          get {
            1️⃣return 11
          }
          @warn(GroupID, as: warning)
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
      @warn(GroupID, as: error)
      func foo() {
        1️⃣let x = 1
      }
      """,
      globalControls: ["GroupID": .warning],
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .error
      ]
    )

    try assertWarningGroupControl(
      """
      func foo() {
        1️⃣let x = 1
        @warn(GroupID, as: ignored)
        func bar() {
          2️⃣let x = 1
        }
      }
      """,
      globalControls: ["GroupID": .error],
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
      globalControls: ["GroupID": .warning],
      diagnosticGroupID: "GroupID",
      states: [
        "1️⃣": .warning
      ]
    )
  }
}

/// Assert that the various marked positions in the source code have the
/// expected warning behavior controls.
private func assertWarningGroupControl(
  _ markedSource: String,
  globalControls: [DiagnosticGroupIdentifier: WarningGroupControl] = [:],
  diagnosticGroupID: DiagnosticGroupIdentifier,
  states: [String: WarningGroupControl?],
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  // Pull out the markers that we'll use to dig out nodes to query.
  let (markerLocations, source) = extractMarkers(markedSource)

  var parser = Parser(source)
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

    let warningControlRegions = tree.warningGroupControlRegionTree(globalControls: globalControls)
    let groupControl = token.warningGroupControl(
      for: diagnosticGroupID,
      globalControls: globalControls
    )
    XCTAssertEqual(groupControl, expectedState)

    let groupControlViaRegions = warningControlRegions.warningGroupControl(
      at: absolutePosition,
      for: diagnosticGroupID
    )
    XCTAssertEqual(groupControlViaRegions, expectedState)
  }
}
