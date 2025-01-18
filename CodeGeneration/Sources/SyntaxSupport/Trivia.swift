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

public struct TriviaTraits: OptionSet {
  public var rawValue: UInt8

  public init(rawValue: UInt8) {
    self.rawValue = rawValue
  }

  // Indicates this is a whitespace.
  public static var whitespace: Self { .init(rawValue: 1 << 0) }

  // Indicates a newline in Swift source code.
  public static var newline: Self { .init(rawValue: 1 << 1) }

  // Horizontal space.
  public static var spaceOrTab: Self { .init(rawValue: 1 << 2) }

  // Comment in Swift source code.
  public static var comment: Self { .init(rawValue: 1 << 3) }
}

public class Trivia {
  /// The name of the trivia.
  public let name: TokenSyntax

  /// The doc comment describing the trivia.
  public let comment: SwiftSyntax.Trivia

  /// The characters that make up the trivia.
  public let characters: String?

  /// The traits.
  public let traits: TriviaTraits

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

  /// Indicates if the trivia is a collection of characters.
  ///
  /// If `true`, the trivia is made up of multiple characters.
  public var isCollection: Bool { characters != nil }

  /// Initializes a new `Trivia` instance.
  ///
  /// - Parameters:
  ///   - name: A name of the trivia.
  ///   - comment: A doc comment describing the trivia.
  ///   - characters: A list of characters that make up the trivia.
  ///   - isComment: Indicates if the trivia represents a comment.
  init(
    name: TokenSyntax,
    comment: SwiftSyntax.Trivia,
    characters: String? = nil,
    traits: TriviaTraits = []
  ) {
    self.name = name
    self.comment = comment
    self.characters = characters
    self.traits = traits
  }
}

public let TRIVIAS: [Trivia] = [
  Trivia(
    name: "Backslash",
    comment: #"A backslash that is at the end of a line in a multi-line string literal to escape the newline."#,
    characters: "\\"
  ),

  Trivia(
    name: "BlockComment",
    comment: #"A developer block comment, starting with '/*' and ending with '*/'."#,
    traits: [.comment]
  ),

  Trivia(
    name: "CarriageReturn",
    comment: #"A newline '\r' character."#,
    characters: "\r",
    traits: [.whitespace, .newline]
  ),

  Trivia(
    name: "CarriageReturnLineFeed",
    comment: #"A newline consists of contiguous '\r' and '\n' characters."#,
    characters: "\r\n",
    traits: [.whitespace, .newline]
  ),

  Trivia(
    name: "DocBlockComment",
    comment: #"A documentation block comment, starting with '/**' and ending with '*/'."#,
    traits: [.comment]
  ),

  Trivia(
    name: "DocLineComment",
    comment: #"A documentation line comment, starting with '///' and excluding the trailing newline."#,
    traits: [.comment]
  ),

  // Swift don't support form feed '\f' so we use the raw unicode
  Trivia(
    name: "Formfeed",
    comment: #"A form-feed 'f' character."#,
    characters: "\u{000C}",
    traits: [.whitespace]
  ),

  Trivia(
    name: "LineComment",
    comment: #"A developer line comment, starting with '//' and excluding the trailing newline."#,
    traits: [.comment]
  ),

  Trivia(
    name: "Newline",
    comment: #"A newline '\n' character."#,
    characters: "\n",
    traits: [.whitespace, .newline]
  ),

  Trivia(
    name: "Pound",
    comment: #"A '#' that is at the end of a line in a multi-line string literal to escape the newline."#,
    characters: "#"
  ),

  Trivia(
    name: "Space",
    comment: #"A space ' ' character."#,
    characters: " ",
    traits: [.whitespace, .spaceOrTab]
  ),

  Trivia(
    name: "Tab",
    comment: #"A tab '\t' character."#,
    characters: "\t",
    traits: [.whitespace, .spaceOrTab]
  ),

  Trivia(
    name: "UnexpectedText",
    comment: #"Any skipped unexpected text."#
  ),

  // Swift don't support vertical tab '\v' so we use the raw unicode
  Trivia(
    name: "VerticalTab",
    comment: #"A vertical tab '\v' character."#,
    characters: "\u{000B}",
    traits: [.whitespace]
  ),
]
