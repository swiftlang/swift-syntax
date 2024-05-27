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
    String(syntaxText: rawIdentifier.name)
  }

  @_spi(RawSyntax)
  public let rawIdentifier: RawIdentifier

  let arena: RetainedSyntaxArena

  public init?(_ token: TokenSyntax) {
    guard case .identifier(let text) = token.tokenKind else {
      return nil
    }

    var rawText = text.contains("`") ? text.trimmingCharacters(in: "`") : Substring(text)

    let syntaxArena = SyntaxArena()

    let name = rawText.withUTF8 {
      syntaxArena.intern(
        SyntaxText(buffer: SyntaxArenaAllocatedBufferPointer<UInt8>($0))
      )
    }

    self.rawIdentifier = RawIdentifier(name: name)
    self.arena = RetainedSyntaxArena(syntaxArena)
  }

  public static func == (lhs: Identifier, rhs: Identifier) -> Bool {
    lhs.rawIdentifier == rhs.rawIdentifier
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(rawIdentifier)
  }
}

@_spi(RawSyntax)
public struct RawIdentifier: Equatable, Hashable, Sendable {
  public let name: SyntaxText
}
