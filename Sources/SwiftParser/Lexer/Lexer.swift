//===----------------------------------------------------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax

/// A lexical analyzer for the Swift programming language.
///
/// - Seealso: ``Lexer/Lexeme``
/// - Seealso: ``Lexer/Cursor``
public enum Lexer {
  public static func lexToEndOfInterpolatedExpression(_ input: UnsafeBufferPointer<UInt8>, _ IsMultilineString: Bool) -> Int {
    let cursor = Lexer.Cursor(input: input, previous: 0, state: .normal)
    let advancedCursor = Lexer.Cursor.skipToEndOfInterpolatedExpression(cursor, IsMultilineString)
    return advancedCursor.input.baseAddress! - cursor.input.baseAddress!
  }
}
