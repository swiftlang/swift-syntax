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

import SwiftSyntax

public class Trivia {
  /// The name of the trivia.
  public let name: TokenSyntax

  /// The doc comment describing the trivia.
  public let comment: SwiftSyntax.Trivia

  /// The list of characters that make up the trivia.
  ///
  /// Useful for multi-character trivias like `\r\n`.
  public let characters: [Character]

  /// The list of characters as they would appear in Swift code.
  ///
  /// This might differ from `characters` due to Swift's character escape requirements.
  public let swiftCharacters: [Character]

  /// Indicates if the trivia represents a comment.
  ///
  /// If `true`, the trivia is some form of a comment in the Swift code.
  public let isComment: Bool

  /// The name of the trivia in lowercase.
  public var lowerName: TokenSyntax { .identifier(lowercaseFirstWord(name: name.text)) }

  /// The name of the trivia when used as an enum case.
  ///
  /// This is typically the plural form of the `lowerName`, with exceptions for certain trivias.
  public var enumCaseName: TokenSyntax {
    if self.isCollection {
      if lowerName.text == "backslash" {
        return "backslashes"
      } else {
        return .identifier("\(lowerName)s")
      }
    } else {
      return lowerName
    }
  }

  /// The length of the `characters` array.
  public var charactersLen: Int { characters.count }

  /// Indicates if the trivia is a collection of characters.
  ///
  /// If `true`, the trivia is made up of multiple characters.
  public var isCollection: Bool { charactersLen > 0 }

  /// Indicates if the trivia contains only whitespace characters.
  public var isBlank: Bool {
    characters.contains { $0.isWhitespace }
  }

  /// Indicates if the trivia contains newline characters.
  public var isNewLine: Bool {
    characters.contains { $0.isNewline }
  }

  /// Initializes a new `Trivia` instance.
  ///
  /// - Parameters:
  ///   - name: A name of the trivia.
  ///   - comment: A doc comment describing the trivia.
  ///   - characters: A list of characters that make up the trivia.
  ///   - swiftCharacters: A list of characters as they would appear in Swift code.
  ///   - isComment: Indicates if the trivia represents a comment.
  init(
    name: TokenSyntax,
    comment: SwiftSyntax.Trivia,
    characters: [Character] = [],
    swiftCharacters: [Character] = [],
    isComment: Bool = false
  ) {
    self.name = name
    self.comment = comment
    self.isComment = isComment
    self.characters = characters

    // Swift sometimes doesn't support escaped characters like \f or \v;
    // we should allow specifying alternatives explicitly.
    if !swiftCharacters.isEmpty {
      self.swiftCharacters = swiftCharacters
    } else {
      self.swiftCharacters = characters
    }
  }
}

public let TRIVIAS: [Trivia] = [
  Trivia(
    name: "Backslash",
    comment: #"A backslash that is at the end of a line in a multi-line string literal to escape the newline."#,
    characters: [
      Character("\\")
    ],
    swiftCharacters: [
      Character("\\")
    ]
  ),

  Trivia(
    name: "BlockComment",
    comment: #"A developer block comment, starting with '/*' and ending with '*/'."#,
    isComment: true
  ),

  Trivia(
    name: "CarriageReturn",
    comment: #"A newline '\r' character."#,
    characters: [
      Character("\r")
    ],
    swiftCharacters: [
      Character("\r")
    ]
  ),

  Trivia(
    name: "CarriageReturnLineFeed",
    comment: #"A newline consists of contiguous '\r' and '\n' characters."#,
    characters: [
      Character("\r"),
      Character("\n"),
    ],
    swiftCharacters: [
      Character("\r"),
      Character("\n"),
    ]
  ),

  Trivia(
    name: "DocBlockComment",
    comment: #"A documentation block comment, starting with '/**' and ending with '*/'."#,
    isComment: true
  ),

  Trivia(
    name: "DocLineComment",
    comment: #"A documentation line comment, starting with '///'."#,
    isComment: true
  ),

  // Swift don't support form feed '\f' so we use the raw unicode
  Trivia(
    name: "Formfeed",
    comment: #"A form-feed 'f' character."#,
    characters: [
      Character("\u{c}")
    ],
    swiftCharacters: [
      Character("\u{240C}")
    ]
  ),

  Trivia(
    name: "LineComment",
    comment: #"A developer line comment, starting with '//'"#,
    isComment: true
  ),

  Trivia(
    name: "Newline",
    comment: #"A newline '\n' character."#,
    characters: [
      Character("\n")
    ],
    swiftCharacters: [
      Character("\n")
    ]
  ),

  Trivia(
    name: "Pound",
    comment: #"A '#' that is at the end of a line in a multi-line string literal to escape the newline."#,
    characters: [
      Character("#")
    ],
    swiftCharacters: [
      Character("#")
    ]
  ),

  Trivia(
    name: "Space",
    comment: #"A space ' ' character."#,
    characters: [
      Character(" ")
    ],
    swiftCharacters: [
      Character(" ")
    ]
  ),

  Trivia(
    name: "Tab",
    comment: #"A tab '\t' character."#,
    characters: [
      Character("\t")
    ],
    swiftCharacters: [
      Character("\t")
    ]
  ),

  Trivia(
    name: "UnexpectedText",
    comment: #"Any skipped unexpected text."#
  ),

  // Swift don't support vertical tab '\v' so we use the raw unicode
  Trivia(
    name: "VerticalTab",
    comment: #"A vertical tab '\v' character."#,
    characters: [
      Character("\u{b}")
    ],
    swiftCharacters: [
      Character("\u{2B7F}")
    ]
  ),
]
