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

public class Trivia {
  public let name: String
  public let comment: String
  public let characters: [Character]
  public let swiftCharacters: [Character]
  public let isComment: Bool

  public var lowerName: String { lowercaseFirstWord(name: name) }

  public var enumCaseName: String {
    if self.isCollection {
      if lowerName == "backslash" {
        return "backslashes"
      } else {
        return "\(lowerName)s"
      }
    } else {
      return lowerName
    }
  }

  public var charactersLen: Int { characters.count }

  public var isCollection: Bool { charactersLen > 0 }

  public var isBlank: Bool {
    characters.contains { $0.isWhitespace }
  }

  public var isNewLine: Bool {
    characters.contains { $0.isNewline }
  }

  init(
    name: String,
    comment: String,
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
    name: "Shebang",
    comment: #"A script command, starting with '#!'."#
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
