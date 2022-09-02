//===--- RawTokenKindSubset.swift -----------------------------------------===//
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

/// Allows callers of `at(anyOf:)` to expect being positioned at a subset of all
/// `RawTokenKind`s.
protocol RawTokenKindSubset: CaseIterable {
  var rawTokenKind: RawTokenKind { get }

  /// Allows more flexible rejection of further token kinds based on the token's
  /// contents or lookahead. Useful to e.g. look for contextual keywords.
  func accepts(lexeme: Lexer.Lexeme, parser: Parser) -> Bool
}

extension RawTokenKindSubset {
  func accepts(lexeme: Lexer.Lexeme, parser: Parser) -> Bool {
    return true
  }
}
