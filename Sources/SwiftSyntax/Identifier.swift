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

/// A canonicalized representation of an identifier that strips away backticks.
public struct Identifier: Equatable, Hashable, Sendable {
  /// The sanitized `text` of a token.
  public var name: String {
    String(syntaxText: raw.name)
  }

  @_spi(RawSyntax)
  public let raw: RawIdentifier

  private let arena: SyntaxArenaRef

  public init?(_ token: TokenSyntax) {
    guard case .identifier = token.tokenKind else {
      return nil
    }

    self.raw = RawIdentifier(token.tokenView)
    self.arena = token.tokenView.raw.arenaReference
  }
}

@_spi(RawSyntax)
public struct RawIdentifier: Equatable, Hashable, Sendable {
  public let name: SyntaxText

  @_spi(RawSyntax)
  fileprivate init(_ raw: RawSyntaxTokenView) {
    let backtick = SyntaxText("`")
    if raw.rawText.count > 2 && raw.rawText.hasPrefix(backtick) && raw.rawText.hasSuffix(backtick) {
      let startIndex = raw.rawText.index(after: raw.rawText.startIndex)
      let endIndex = raw.rawText.index(before: raw.rawText.endIndex)
      self.name = SyntaxText(rebasing: raw.rawText[startIndex..<endIndex])
    } else {
      self.name = raw.rawText
    }
  }
}
