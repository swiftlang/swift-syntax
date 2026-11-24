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

#if compiler(>=6)
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) public import SwiftSyntax
#else
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
#endif

extension ExprSyntax {
  /// Parse an expression using the grammar accepted in an `#if` condition.
  @_spi(ExperimentalLanguageFeatures)
  public static func parseIfConfigCondition(from parser: inout Parser) -> Self {
    defer {
      withExtendedLifetime(parser) {}
    }

    let node = parser.parseSequenceExpression(flavor: .poundIfDirective)
    let raw = RawSyntax(parser.parseRemainder(into: node))
    return Syntax(raw: raw, rawNodeArena: raw.arena).cast(Self.self)
  }
}
