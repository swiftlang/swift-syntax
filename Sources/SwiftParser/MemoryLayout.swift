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

@_spi(Testing) public import SwiftSyntax

/// The memory layout of `T`, as a ``SyntaxMemoryLayout/Value``.
///
/// `SyntaxMemoryLayout.Value` has an initializer that takes a type, but it is
/// internal to `SwiftSyntax`.
func layout<T>(_: T.Type) -> SyntaxMemoryLayout.Value {
  return SyntaxMemoryLayout.Value(
    size: MemoryLayout<T>.size,
    stride: MemoryLayout<T>.stride,
    alignment: MemoryLayout<T>.alignment
  )
}

// See `MemoryLayoutTest.swift`.
@_spi(Testing) public enum ParserMemoryLayout: Sendable {
  public static var values: [String: SyntaxMemoryLayout.Value] {
    let uniq: (SyntaxMemoryLayout.Value, SyntaxMemoryLayout.Value) -> SyntaxMemoryLayout.Value = { _, _ in
      preconditionFailure()
    }

    var result: [String: SyntaxMemoryLayout.Value] = [:]
    result.merge(LexerMemoryLayouts, uniquingKeysWith: uniq)
    result.merge(ParserMemoryLayouts, uniquingKeysWith: uniq)
    return result
  }

  /// Whether a value of the type is copied without any extra work, i.e. whether
  /// it holds nothing that has to be retained or released.
  ///
  /// A ``Parser/Lookahead`` is made by copying the parser's lexeme sequence, so
  /// these staying trivial is what keeps starting and discarding a lookahead
  /// down to a move.
  public static var trivialTypes: [String: Bool] {
    return [
      "Lexer.Cursor": _isPOD(Lexer.Cursor.self),
      "Lexer.Lexeme": _isPOD(Lexer.Lexeme.self),
      "Lexer.LexemeSequence": _isPOD(Lexer.LexemeSequence.self),
      "Parser.Lookahead": _isPOD(Parser.Lookahead.self),
    ]
  }
}

/// The lexer types. See `ParserMemoryLayout`.
///
/// These live here rather than beside the types they measure, because unlike
/// their counterparts in `SwiftSyntax` none of them is file private, so keeping
/// them here saves their files from importing the `Testing` SPI.
let LexerMemoryLayouts: [String: SyntaxMemoryLayout.Value] = [
  "Lexer.Cursor": layout(Lexer.Cursor.self),
  "Lexer.Cursor.Position": layout(Lexer.Cursor.Position.self),
  "Lexer.Cursor.State": layout(Lexer.Cursor.State.self),
  "Lexer.Cursor.StateStack": layout(Lexer.Cursor.StateStack.self),
  "Lexer.Lexeme": layout(Lexer.Lexeme.self),
  "Lexer.LexemeSequence": layout(Lexer.LexemeSequence.self),
]

/// The parser types. See `ParserMemoryLayout`.
let ParserMemoryLayouts: [String: SyntaxMemoryLayout.Value] = [
  "Parser.Lookahead": layout(Parser.Lookahead.self),
  "TokenSpec": layout(TokenSpec.self),
]
