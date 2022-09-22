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

/// Converts a SyntaxKind to a type name, checking to see if the kind is
/// Syntax or SyntaxCollection first.
/// A type name is the same as the SyntaxKind name with the suffix "Syntax"
/// added.
func kindToType(kind: String) -> String {
  if ["Syntax", "SyntaxCollection"].contains(kind) {
    return kind
  } else if kind.hasSuffix("Token") {
    return "TokenSyntax"
  }

  return kind + "Syntax"
}

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
