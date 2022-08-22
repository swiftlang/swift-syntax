//===---------------------- TokenConsumer.swift ---------------------------===//
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

/// A type that can be used in place of a `while true` loop.
/// See `evaluate` for more detail.
struct LoopProgressCondition {
  var currentToken: Lexer.Lexeme?

  init() {}

  /// Check that the loop has made progress since `evaluate` was called the last time.
  /// `currentToken` is the current token of the parser.
  /// In assert builds, this traps if the loop has not made any parser progress in between two iterations,
  /// ie. it checks if the the parser's `currentToken` has changed in between two calls to `evaluate`.
  /// In non-assert builds, `evaluate()` returns `false` if the loop has not made progress, thus aborting the loop.
  mutating func evaluate(_ currentToken: Lexer.Lexeme) -> Bool {
    let hasMadeProgress = self.currentToken?.tokenText.baseAddress != currentToken.tokenText.baseAddress
    self.currentToken = currentToken
    assert(hasMadeProgress, "Loop should always make progress")
    return hasMadeProgress
  }
}
