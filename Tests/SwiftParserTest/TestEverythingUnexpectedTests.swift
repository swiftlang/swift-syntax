//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax
import XCTest

final class TestEverythingUnexpectedTests: ParserTestCase {
  func testEverythingUnexpectedFeature() {
    // The _test_EverythingUnexpected feature parses all content as
    // unexpectedBetweenStatementsAndEndOfFileToken, leaving statements empty.
    // This allows testing that experimental features are correctly
    // passed through to the parser without relying on real language features.

    let source = """
      struct Foo {
        var x: Int
      }
      """

    var parser = Parser(source, experimentalFeatures: ._test_EverythingUnexpected)
    let sourceFile = SourceFileSyntax.parse(from: &parser)

    // With _test_EverythingUnexpected, statements should be empty
    XCTAssertTrue(sourceFile.statements.isEmpty, "Expected empty statements with _test_EverythingUnexpected")

    // All content should be in unexpectedBetweenStatementsAndEndOfFileToken
    XCTAssertNotNil(
      sourceFile.unexpectedBetweenStatementsAndEndOfFileToken,
      "Expected content in unexpectedBetweenStatementsAndEndOfFileToken"
    )

    // Without the feature, parsing should work normally
    var normalParser = Parser(source)
    let normalSourceFile = SourceFileSyntax.parse(from: &normalParser)
    XCTAssertFalse(normalSourceFile.statements.isEmpty, "Expected statements without _test_EverythingUnexpected")
  }
}
