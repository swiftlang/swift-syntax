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

@_spi(Testing) import SwiftParser
@_spi(Testing) import SwiftSyntax
import XCTest

final class MemoryLayoutTest: XCTestCase {

  func testMemoryLayouts() throws {
    #if !arch(x86_64) && !arch(arm64)
    throw XCTSkip("Only runs on x86_64 and arm64")
    #endif

    /// This test result is just for tracking the memory footprint of the lexer
    /// and parser, and they are totally informative purpose. Although we want to
    /// keep the numbers as low as possible, nothing should rely on them, and are
    /// not hard limits in any way.
    /// If this fails, just update the numbers.
    ///
    /// A ``Lexer/Cursor`` is stored in every ``Lexer/Lexeme``, and a
    /// ``Lexer/LexemeSequence`` is copied to start every ``Parser/Lookahead``,
    /// so these sizes are multiplied several times over on the hot path.
    let expected: [String: SyntaxMemoryLayout.Value] = [
      "Lexer.Cursor": .init(size: 32, stride: 32, alignment: 8),
      "Lexer.Cursor.Position": .init(size: 17, stride: 24, alignment: 8),
      "Lexer.Cursor.State": .init(size: 10, stride: 16, alignment: 8),
      "Lexer.Cursor.StateStack": .init(size: 8, stride: 8, alignment: 8),
      "Lexer.Lexeme": .init(size: 72, stride: 72, alignment: 8),
      "Lexer.LexemeSequence": .init(size: 128, stride: 128, alignment: 8),

      "Parser.Lookahead": .init(size: 224, stride: 224, alignment: 8),
      "TokenSpec": .init(size: 5, stride: 5, alignment: 1),
    ]

    let values = ParserMemoryLayout.values
    XCTAssertEqual(values.count, expected.count)
    for exp in expected {
      let actualValue = try XCTUnwrap(values[exp.key], "Missing '\(exp.key)'")
      XCTAssertEqual(actualValue, exp.value, "Matching '\(exp.key)' values")
    }
  }

  func testCopyingLookaheadTypes() throws {
    /// Whether a copy of each type is a move, tracked the same way as the sizes
    /// above and equally informative.
    ///
    /// Starting a ``Parser/Lookahead`` copies the parser's
    /// ``Lexer/LexemeSequence``, at roughly a hundred call sites. Where the
    /// copied type holds nothing that has to be retained, that copy is a move
    /// and discarding the lookahead costs nothing; where it holds a reference,
    /// both become calls out to a value witness.
    let expected: [String: Bool] = [
      "Lexer.Cursor": true,
      "Lexer.Lexeme": true,
      "Lexer.LexemeSequence": true,
      "Parser.Lookahead": true,
    ]
    XCTAssertEqual(ParserMemoryLayout.trivialTypes, expected)
  }
}
