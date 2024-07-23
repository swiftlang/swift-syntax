//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
import SwiftDiagnostics
import SwiftIfConfig
import SwiftParser
import SwiftSyntax
@_spi(XCTestFailureLocation) import SwiftSyntaxMacrosGenericTestSupport
import XCTest
import _SwiftSyntaxGenericTestSupport
import _SwiftSyntaxTestSupport

/// Assert the results of evaluating the condition within an `#if` against the
/// given build configuration.
func assertIfConfig(
  _ condition: ExprSyntax,
  _ expectedState: ConfiguredRegionState?,
  configuration: some BuildConfiguration = TestingBuildConfiguration(),
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  file: StaticString = #filePath,
  line: UInt = #line
) {
  // Evaluate the condition to check the state.
  var actualDiagnostics: [Diagnostic] = []
  do {
    let actualState = try ConfiguredRegionState(condition: condition, configuration: configuration) { diag in
      actualDiagnostics.append(diag)
    }
    XCTAssertEqual(actualState, expectedState, file: file, line: line)
  } catch {
    XCTAssertNil(expectedState, file: file, line: line)
  }

  // Check the diagnostics.
  if actualDiagnostics.count != expectedDiagnostics.count {
    XCTFail(
      """
      Expected \(expectedDiagnostics.count) diagnostics, but got \(actualDiagnostics.count):
      \(actualDiagnostics.map(\.debugDescription).joined(separator: "\n"))
      """,
      file: file,
      line: line
    )
  } else {
    for (actualDiag, expectedDiag) in zip(actualDiagnostics, expectedDiagnostics) {
      assertDiagnostic(
        actualDiag,
        in: .tree(condition),
        expected: expectedDiag,
        failureHandler: {
          XCTFail($0.message, file: $0.location.staticFilePath, line: $0.location.unsignedLine)
        }
      )
    }
  }
}

/// Assert that the various marked positions in the source code have the
/// expected active states.
func assertActiveCode(
  _ markedSource: String,
  configuration: some BuildConfiguration = TestingBuildConfiguration(),
  states: [String: ConfiguredRegionState],
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  // Pull out the markers that we'll use to dig out nodes to query.
  let (markerLocations, source) = extractMarkers(markedSource)

  var parser = Parser(source)
  let tree = SourceFileSyntax.parse(from: &parser)

  let configuredRegions = tree.configuredRegions(in: configuration)

  for (marker, location) in markerLocations {
    guard let expectedState = states[marker] else {
      XCTFail("Missing marker \(marker) in expected states", file: file, line: line)
      continue
    }

    guard let token = tree.token(at: AbsolutePosition(utf8Offset: location)) else {
      XCTFail("Unable to find token at location \(location)", file: file, line: line)
      continue
    }

    let actualState = try token.isActive(in: configuration)
    XCTAssertEqual(actualState, expectedState, "isActive(in:) at marker \(marker)", file: file, line: line)

    let actualViaRegions = token.isActive(inConfiguredRegions: configuredRegions)
    XCTAssertEqual(
      actualViaRegions,
      expectedState,
      "isActive(inConfiguredRegions:) at marker \(marker)",
      file: file,
      line: line
    )
  }
}

/// Assert that applying the given build configuration to the source code
/// returns the expected source and diagnostics.
func assertRemoveInactive(
  _ source: String,
  configuration: some BuildConfiguration,
  diagnostics expectedDiagnostics: [DiagnosticSpec] = [],
  expectedSource: String,
  file: StaticString = #filePath,
  line: UInt = #line
) {
  var parser = Parser(source)
  let tree = SourceFileSyntax.parse(from: &parser)

  let (treeWithoutInactive, actualDiagnostics) = tree.removingInactive(in: configuration)

  // Check the resulting tree.
  assertStringsEqualWithDiff(
    treeWithoutInactive.description,
    expectedSource,
    file: file,
    line: line
  )

  // Check the diagnostics.
  if actualDiagnostics.count != expectedDiagnostics.count {
    XCTFail(
      """
      Expected \(expectedDiagnostics.count) diagnostics, but got \(actualDiagnostics.count):
      \(actualDiagnostics.map(\.debugDescription).joined(separator: "\n"))
      """,
      file: file,
      line: line
    )
  } else {
    for (actualDiag, expectedDiag) in zip(actualDiagnostics, expectedDiagnostics) {
      assertDiagnostic(
        actualDiag,
        in: .tree(tree),
        expected: expectedDiag,
        failureHandler: {
          XCTFail($0.message, file: $0.location.staticFilePath, line: $0.location.unsignedLine)
        }
      )
    }
  }
}
