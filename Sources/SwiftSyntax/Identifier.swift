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
  /// The sanitized name of the identifier.
  public var name: String {
    String(syntaxText: raw.name)
  }

  /// `true` if the identifier is a dollar identifier.
  public var isDollarIdentifier: Bool {
    raw.original.hasPrefix(SyntaxText("$")) && Int(String(syntaxText: raw.original).dropFirst()) != nil
  }

  @_spi(RawSyntax)
  public let raw: RawIdentifier
  private let arena: RawSyntaxArenaRef?

  public init?(_ token: TokenSyntax) {
    switch token.tokenKind {
    case .identifier, .keyword(.self), .keyword(.Self):
      self.raw = RawIdentifier(token.tokenView.rawText)
      self.arena = token.raw.arenaReference
    case .dollarIdentifier(let dollarIdentifierStr):
      self.arena = token.raw.arenaReference

      if Self.isPaddedDollarIdentifier(dollarIdentfierStr: dollarIdentifierStr),
        let newDollarIdentifierNumber = Int(dollarIdentifierStr.dropFirst())
      {
        let newDollarIdentifierStr = "$\(newDollarIdentifierNumber)"
        let sanitizedDollarIdentifierSyntaxText = token.raw.arenaReference.intern(newDollarIdentifierStr)

        self.raw = RawIdentifier(sanitizedDollarIdentifierSyntaxText)
      } else {
        self.raw = RawIdentifier(token.tokenView.rawText)
      }
    default:
      return nil
    }
  }

  /// Create a new `Identifier` from given `canonicalName`.
  ///
  /// - Precondition: `canonicalName` is a canonical identifier i.e. doesn't
  ///   use backticks and is not a dollar identifier with leading zeros.
  public init(canonicalName: StaticString) {
    precondition(
      Self.isCanonicalRepresentation(canonicalName),
      "\(canonicalName) is not a canonical identifier."
    )

    self.raw = RawIdentifier(SyntaxText(canonicalName))
    self.arena = nil
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.name == rhs.name
  }

  /// Returns `true` if `staticString` is a canonical identifier i.e. doesn't
  /// use backticks and is not a dollar identifier with leading zeros.
  private static func isCanonicalRepresentation(_ staticString: StaticString) -> Bool {
    let text = SyntaxText(staticString)

    guard !Self.hasBackticks(text) else { return false }

    let str = String(syntaxText: text)
    let isDollarIdentifier = str.first == "$" && Int(str.dropFirst()) != nil

    return !(isDollarIdentifier && Self.isPaddedDollarIdentifier(dollarIdentfierStr: str))
  }

  /// Returns `true` if `rawText` doesn't use backticks.
  fileprivate static func hasBackticks(_ rawText: SyntaxText) -> Bool {
    let backtick = SyntaxText("`")
    return rawText.count > 2 && rawText.hasPrefix(backtick) && rawText.hasSuffix(backtick)
  }

  /// Returns `true` if `dollarIdentfierStr` is not a
  /// dollar identifier with leading zeros.
  fileprivate static func isPaddedDollarIdentifier(dollarIdentfierStr: String) -> Bool {
    dollarIdentfierStr.count > 2 && dollarIdentfierStr.hasPrefix("$0")
  }
}

@_spi(RawSyntax)
public struct RawIdentifier: Equatable, Hashable, Sendable {
  fileprivate let original: SyntaxText
  public let name: SyntaxText

  @_spi(RawSyntax)
  fileprivate init(_ rawText: SyntaxText) {
    self.original = rawText

    guard Identifier.hasBackticks(rawText) else {
      self.name = rawText
      return
    }

    let startIndex = rawText.index(after: rawText.startIndex)
    let endIndex = rawText.index(before: rawText.endIndex)
    self.name = SyntaxText(rebasing: rawText[startIndex..<endIndex])
  }
}
