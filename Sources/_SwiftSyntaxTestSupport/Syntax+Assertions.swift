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
