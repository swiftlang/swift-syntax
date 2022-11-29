//// Automatically Generated From Trivia.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
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
  public let isNewLine: Bool
  public let isComment: Bool
  
  public var lowerName: String { lowercaseFirstWord(name: name) }
  
  public var charactersLen: Int { characters.count }
  
  public var isCollection: Bool { charactersLen > 0 }
  
  init(name: String,
       comment: String,
       characters: [Character] = [],
       swiftCharacters: [Character] = [],
       isNewLine: Bool = false,
       isComment: Bool = false){
    self.name = name
    self.comment = comment
    self.isNewLine = isNewLine
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
  Trivia(name: "Space",
         comment: #"A space ' ' character."#,
         characters: [
           Character(#" "#)
         ],
         swiftCharacters: [
          Character(#" "#)
        ]),
  Trivia(name: "Tab",
         comment: #"A tab '\t' character."#,
         characters: [
           Character(#"\t"#)
         ],
         swiftCharacters: [
          Character(#"\t"#)
        ]),
  Trivia(name: "VerticalTab",
         comment: #"A vertical tab '\v' character."#,
         characters: [
           Character(#"\v"#)
         ],
         swiftCharacters: [
          Character(#"\u{2B7F}"#)
        ]),
  Trivia(name: "Formfeed",
         comment: #"A form-feed 'f' character."#,
         characters: [
           Character(#"\f"#)
         ],
         swiftCharacters: [
          Character(#"\u{240C}"#)
        ]),
  Trivia(name: "Newline",
         comment: #"A newline '\n' character."#,
         characters: [
           Character(#"\n"#)
         ],
         swiftCharacters: [
          Character(#"\n"#)
        ],
         isNewLine: true),
  Trivia(name: "CarriageReturn",
         comment: #"A newline '\r' character."#,
         characters: [
           Character(#"\r"#)
         ],
         swiftCharacters: [
          Character(#"\r"#)
        ],
         isNewLine: true),
  Trivia(name: "CarriageReturnLineFeed",
         comment: #"A newline consists of contiguous '\r' and '\n' characters."#,
         characters: [
           Character(#"\r"#),
           Character(#"\n"#)
         ],
         swiftCharacters: [
          Character(#"\r"#),
          Character(#"\n"#)
        ],
         isNewLine: true),
  Trivia(name: "LineComment",
         comment: #"A developer line comment, starting with '//'"#,
         isComment: true),
  Trivia(name: "BlockComment",
         comment: #"A developer block comment, starting with '/*' and ending with '*/'."#,
         isComment: true),
  Trivia(name: "DocLineComment",
         comment: #"A documentation line comment, starting with '///'."#,
         isComment: true),
  Trivia(name: "DocBlockComment",
         comment: #"A documentation block comment, starting with '/**' and ending with '*/'."#,
         isComment: true),
  Trivia(name: "UnexpectedText",
         comment: #"Any skipped unexpected text."#),
  Trivia(name: "Shebang",
         comment: #"A script command, starting with '#!'."#),
]
