//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

/// An abstraction for sanitized values on a token.
public struct Identifier: Equatable, Hashable, Sendable {
  /// The sanitized `text` of a token.
  public var name: String {
    String(syntaxText: raw.name)
  }

  @_spi(RawSyntax)
  public let raw: RawIdentifier

  public init?(_ token: TokenSyntax) {
    guard case .identifier = token.tokenKind else {
      return nil
    }

    self.raw = RawIdentifier(token.tokenView)
  }
}

@_spi(RawSyntax)
public struct RawIdentifier: Equatable, Hashable, Sendable {
  public let name: SyntaxText

  private let arena: RetainedSyntaxArena

  @_spi(RawSyntax)
  fileprivate init(_ raw: RawSyntaxTokenView) {
    let backtick = SyntaxText(StaticString(stringLiteral: "`"))
    let arena = SyntaxArena()
    if raw.rawText.count > 2 && raw.rawText.hasPrefix(backtick) && raw.rawText.hasSuffix(backtick) {
      let startIndex = raw.rawText.index(after: raw.rawText.startIndex)
      let endIndex = raw.rawText.index(before: raw.rawText.endIndex)

      self.name = arena.intern(SyntaxText(rebasing: raw.rawText[startIndex..<endIndex]))
    } else {
      self.name = arena.intern(raw.rawText)
    }
    self.arena = RetainedSyntaxArena(arena)
  }

  public static func == (lhs: RawIdentifier, rhs: RawIdentifier) -> Bool {
    lhs.name == rhs.name
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
