//===------------------- Syntax+Assertions.swift  -------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
//
// Syntax assertion helpers.
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxParser
import XCTest

/// Verifies that there is a next item returned by the iterator and that it
/// satisfies the given predicate.
public func XCTAssertNext<Iterator: IteratorProtocol>(
  _ iterator: inout Iterator,
  satisfies predicate: (Iterator.Element) throws -> Bool,
  file: StaticString = #filePath, line: UInt = #line
) throws {
  let next = try XCTUnwrap(iterator.next(), file: file, line: line)
  XCTAssertTrue(try predicate(next), file: file, line: line)
}

/// Verifies that the iterator is exhausted.
public func XCTAssertNextIsNil<Iterator: IteratorProtocol>(_ iterator: inout Iterator) {
  XCTAssertNil(iterator.next())
}

/// Parses `actual`, builds an expected tree from `expected`, and then
/// verifies that two trees are equivalent, ie. they have the same structure
/// and optionally the same trivia if `includeTrivia` is set. The default
/// formatting when building `expected` can be controlled by passing in your
/// own `format`.
public func XCTAssertEquivalent(_ actual: String, _ expected: SourceFile,
                                format: Format = .init(), includeTrivia: Bool = false,
                                file: StaticString = #filePath, line: UInt = #line) throws {
  let actualTree: SourceFileSyntax = try SyntaxParser.parse(source: actual)
  let expectedTree: Syntax = expected.buildSyntax(format: format)
  return XCTAssertEquivalent(Syntax(actualTree), expectedTree, includeTrivia: includeTrivia, file: file, line: line)
}

/// Verifies that two trees are equivalent, ie. they have the same structure
/// and optionally the same trivia if `includeTrivia` is set.
public func XCTAssertEquivalent<SyntaxType: SyntaxProtocol>(_ actual: SyntaxType, _ expected: SyntaxType, includeTrivia: Bool = false,
                                                            file: StaticString = #filePath, line: UInt = #line) {
  return XCTAssertEquivalent(Syntax(actual), Syntax(expected), includeTrivia: includeTrivia, file: file, line: line)
}

/// Verifies that two trees are equivalent, ie. they have the same structure
/// and optionally the same trivia if `includeTrivia` is set.
public func XCTAssertEquivalent(_ actual: Syntax, _ expected: Syntax, includeTrivia: Bool = false,
                                file: StaticString = #filePath, line: UInt = #line) {
  guard let diff = actual.findFirstDifference(to: expected, includeTrivia: includeTrivia) else {
    return
  }

  let verbose = diff.reason == .trivia
  XCTAssert(false,
            """
            Trees do not match due to \(diff.reason).

            Expected:
            \(diff.comparison.debugDescription(includeChildren: false, includeTrivia: verbose))

            Actual:
            \(diff.node.debugDescription(includeChildren: false, includeTrivia: verbose))

            Expected Tree:
            \(expected.debugDescription(includeTrivia: verbose, mark: diff.comparison))

            Actual Tree:
            \(actual.debugDescription(includeTrivia: verbose, mark: diff.node))
            """, file: file, line: line)
}
