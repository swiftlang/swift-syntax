//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

extension TokenSyntax {
  /// Whether the token text is an editor placeholder or not.
  public var isEditorPlaceholder: Bool {
    rawTokenKind == .identifier && isPlaceholder(syntaxText: rawText)
  }

  @_spi(RawSyntax)
  public var rawEditorPlaceHolderData: RawEditorPlaceholderData? {
    RawEditorPlaceholderData(syntaxText: rawText)
  }
}

/// Placeholder text must start with '<#' and end with
/// '#>'. Placeholders can be one of the following formats:
///
/// Typed:
/// ```
///   'T##' display-string '##' type-string ('##' type-for-expansion-string)?
///   'T##' display-and-type-string
/// ```
///
/// Basic:
/// ```
///   display-string
/// ```
///
/// NOTE: It is required that '##' is not a valid substring of display-string
/// or type-string. If this ends up not the case for some reason, we can consider
/// adding escaping for '##'.
@_spi(RawSyntax)
public struct RawEditorPlaceholderData {
  /// The part that is displayed in the editor.
  public var displayText: SyntaxText

  /// The type text for the placeholder.
  /// It can be same as `displayText`. `nil` if the placeholder is not "Typed".
  public var typeText: SyntaxText?

  /// The type text to be considered for placeholder expansion.
  /// It can be same as `typeText`. `nil` if the placeholder is not "Typed".
  public var typeForExpansionText: SyntaxText?

  public init(displayText: SyntaxText, typeText: SyntaxText? = nil, typeForExpansionText: SyntaxText? = nil) {
    self.displayText = displayText
    self.typeText = typeText
    self.typeForExpansionText = typeForExpansionText
  }

  public init?(syntaxText: SyntaxText) {
    guard isPlaceholder(syntaxText: syntaxText) else {
      return nil
    }
    self = parseEditorPlaceholder(syntaxText: syntaxText)
  }
}

private let placeholderStart: SyntaxText = "<#"
private let placeholderEnd: SyntaxText = "#>"

private func isPlaceholder(syntaxText: SyntaxText) -> Bool {
  syntaxText.hasPrefix(placeholderStart) && syntaxText.hasSuffix(placeholderEnd)
}

private func parseEditorPlaceholder(syntaxText: SyntaxText) -> RawEditorPlaceholderData {
  assert(isPlaceholder(syntaxText: syntaxText))
  var text = SyntaxText(rebasing: syntaxText.dropFirst(2).dropLast(2))

  if !text.hasPrefix("T##") {
    // Basic, no type texts.
    return RawEditorPlaceholderData(displayText: text)
  }

  // Typed, drop 'T##'
  text = SyntaxText(rebasing: text.dropFirst(3))

  guard let sep = text.firstRange(of: "##") else {
    return RawEditorPlaceholderData(displayText: text, typeText: text, typeForExpansionText: text)
  }
  let displayText = SyntaxText(rebasing: text[..<sep.lowerBound])
  text = SyntaxText(rebasing: text[sep.upperBound...])

  guard !text.isEmpty else {
    return RawEditorPlaceholderData(displayText: displayText, typeText: displayText, typeForExpansionText: displayText)
  }

  guard let sep = text.firstRange(of: "##") else {
    return RawEditorPlaceholderData(displayText: displayText, typeText: text, typeForExpansionText: text)
  }
  let typeText = SyntaxText(rebasing: text[..<sep.lowerBound])
  text = SyntaxText(rebasing: text[sep.upperBound...])

  guard !text.isEmpty else {
    return RawEditorPlaceholderData(displayText: displayText, typeText: typeText, typeForExpansionText: typeText)
  }

  return RawEditorPlaceholderData(displayText: displayText, typeText: typeText, typeForExpansionText: text)
}
