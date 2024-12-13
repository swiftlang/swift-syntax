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

#if compiler(>=6)
@_spi(RawSyntax) internal import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

/// A type that can be used to make sure that a loop in the parser makes process.
///
/// See `TokenConsumer.hasProgressed` for details.
struct LoopProgressCondition {
  var currentToken: Lexer.Lexeme?

  init() {}

  /// Implementation of the above `evaluate` methods.
  fileprivate mutating func evaluate(_ currentToken: Lexer.Lexeme) -> Bool {
    defer {
      self.currentToken = currentToken
    }

    guard let previousToken = self.currentToken else {
      return true
    }
    let hasMadeProgress = currentToken.cursor.hasProgressed(comparedTo: previousToken.cursor)
    assert(hasMadeProgress, "Loop should always make progress")
    return hasMadeProgress
  }
}

// Implementing the extension separately on `Parser` and `Parser.Lookahead` is
// ~1.5% faster than implementing it on `TokenConsumer`.

extension Parser {
  /// Check that the token consumer has made progress since `hasProgress` was
  /// called the last time with this `loopProgress`.
  ///
  /// In assert builds, this traps if the loop has not made any parser progress
  /// in between two iterations, ie. it checks if the parser's `currentToken`
  /// has changed in between two calls to `evaluate`.
  /// In non-assert builds, `evaluate()` returns `false` if the loop has not made
  /// progress, thus aborting the loop.
  @inline(__always)
  func hasProgressed(_ loopProgress: inout LoopProgressCondition) -> Bool {
    return loopProgress.evaluate(self.currentToken)
  }
}

extension Parser.Lookahead {
  /// Check that the token consumer has made progress since `hasProgress` was
  /// called the last time with this `loopProgress`.
  ///
  /// In assert builds, this traps if the loop has not made any parser progress
  /// in between two iterations, ie. it checks if the parser's `currentToken`
  /// has changed in between two calls to `evaluate`.
  /// In non-assert builds, `evaluate()` returns `false` if the loop has not made
  /// progress, thus aborting the loop.
  @inline(__always)
  func hasProgressed(_ loopProgress: inout LoopProgressCondition) -> Bool {
    return loopProgress.evaluate(self.currentToken)
  }
}
