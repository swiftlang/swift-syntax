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

import SwiftBasicFormat
import SwiftRefactor
import SwiftSyntax
import SwiftSyntaxBuilder
import XCTest
import _SwiftSyntaxTestSupport

func assertRefactor<R: EditRefactoringProvider>(
  _ input: R.Input,
  context: R.Context,
  provider: R.Type,
  expected: [SourceEdit],
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  let edits = R.textRefactor(syntax: input, in: context)
  guard !edits.isEmpty else {
    if !expected.isEmpty {
      XCTFail(
        """
        Refactoring produced empty result, expected:
        \(expected)
        """,
        file: file,
        line: line
      )
    }
    return
  }

  if edits.count != expected.count {
    XCTFail(
      """
      Refactoring produced incorrect number of edits, expected \(expected.count) not \(edits.count).

      Actual:
      \(edits.map({ $0.debugDescription }).joined(separator: "\n"))

      Expected:
      \(expected.map({ $0.debugDescription }).joined(separator: "\n"))

      """,
      file: file,
      line: line
    )
    return
  }

  for (actualEdit, expectedEdit) in zip(edits, expected) {
    XCTAssertEqual(
      actualEdit,
      expectedEdit,
      "Incorrect edit, expected \(expectedEdit.debugDescription) but actual was \(actualEdit.debugDescription)",
      file: file,
      line: line
    )
    assertStringsEqualWithDiff(
      actualEdit.replacement,
      expectedEdit.replacement,
      file: file,
      line: line
    )
  }
}

func assertRefactor<R: SyntaxRefactoringProvider>(
  _ input: R.Input,
  context: R.Context,
  provider: R.Type,
  expected: R.Output?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  let refactored = R.refactor(syntax: input, in: context)
  guard let refactored = refactored else {
    if expected != nil {
      XCTFail(
        """
        Refactoring produced nil result, expected:
        \(expected?.description ?? "")
        """,
        file: file,
        line: line
      )
    }
    return
  }
  guard let expected = expected else {
    XCTFail(
      """
      Expected nil result, actual:
      \(refactored.description)
      """,
      file: file,
      line: line
    )
    return
  }

  assertStringsEqualWithDiff(
    refactored.description,
    expected.description,
    file: file,
    line: line
  )
}

func assertRefactor<I: SyntaxProtocol, R: EditRefactoringProvider>(
  _ input: I,
  context: R.Context,
  provider: R.Type,
  expected: [SourceEdit],
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  let castInput = try XCTUnwrap(input.as(R.Input.self))
  try assertRefactor(castInput, context: context, provider: provider, expected: expected, file: file, line: line)
}

func assertRefactor<I: SyntaxProtocol, R: SyntaxRefactoringProvider, E: SyntaxProtocol>(
  _ input: I,
  context: R.Context,
  provider: R.Type,
  expected: E?,
  file: StaticString = #filePath,
  line: UInt = #line
) throws {
  let castInput = try XCTUnwrap(input.as(R.Input.self))
  let castExpected: R.Output?
  if let expected = expected {
    castExpected = try XCTUnwrap(expected.as(R.Output.self))
  } else {
    castExpected = nil
  }
  try assertRefactor(castInput, context: context, provider: provider, expected: castExpected, file: file, line: line)
}
