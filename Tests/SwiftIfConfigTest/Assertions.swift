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

/// Assert that applying the given build configuration to the source code
/// returns the expected source and diagnostics.
func assertRemoveInactive(
  _ source: String,
  configuration: any BuildConfiguration,
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
