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

#if swift(>=6)
internal import SwiftSyntax
#else
import SwiftSyntax
#endif

extension TokenSyntax {
  var trivia: Trivia {
    return leadingTrivia + trailingTrivia
  }
}

extension Trivia {
  var droppingLeadingWhitespace: Trivia {
    return Trivia(pieces: self.drop(while: \.isWhitespace))
  }

  var droppingTrailingWhitespace: Trivia {
    return Trivia(pieces: self.reversed().drop(while: \.isWhitespace).reversed())
  }
}

extension TypeSyntax {
  var isVoid: Bool {
    switch self.as(TypeSyntaxEnum.self) {
    case .identifierType(let identifierType) where identifierType.name.text == "Void": return true
    case .tupleType(let tupleType) where tupleType.elements.isEmpty: return true
    default: return false
    }
  }
}
