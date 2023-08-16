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

/// Lowercases the first word in the provided camelCase or PascalCase string.
/// EOF -> eof
/// IfKeyword -> ifKeyword
/// EOFToken -> eofToken
public func lowercaseFirstWord(name: String) -> String {
  var wordIndex = 0
  let thresholdIndex = 1

  for c in name {
    if c.isLowercase {
      if wordIndex > thresholdIndex {
        wordIndex -= 1
      }
      break

    }
    wordIndex += 1
  }

  if wordIndex == 0 {
    return name
  }

  return name.prefix(wordIndex).lowercased() + name[name.index(name.startIndex, offsetBy: wordIndex)..<name.endIndex]
}

/// Give a (possibly multi-line) string, prepends `///` to each line and creates
/// a `.docLineComment` trivia piece for each line.
public func docCommentTrivia(from string: String?) -> SwiftSyntax.Trivia {
  guard let string else {
    return []
  }
  let lines = string.split(separator: "\n", omittingEmptySubsequences: false)
  let pieces = lines.enumerated().map { (index, line) in
    var line = line
    if index != lines.count - 1 {
      line = "\(line)\n"
    }
    return SwiftSyntax.TriviaPiece.docLineComment("/// \(line)")
  }
  return SwiftSyntax.Trivia(pieces: pieces)
}

public extension Collection {
  /// If the collection contains a single element, return it, otherwise `nil`.
  var only: Element? {
    if !isEmpty && index(after: startIndex) == endIndex {
      return self.first!
    } else {
      return nil
    }
  }
}

public extension TokenSyntax {
  var backtickedIfNeeded: TokenSyntax {
    if Keyword.allCases.map(\.spec).contains(where: {
      $0.name == self.description && ($0.isLexerClassified || $0.name == "Type" || $0.name == "Protocol")
    }) {
      return "`\(self)`"
    } else {
      return self
    }
  }
}
