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

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

extension TokenSyntax {
  /// The indentation of this token
  ///
  /// In contrast to `indentationOfLine`, this does not walk to previous tokens to
  /// find the indentation of the line this token occurs on.
  private var indentation: Trivia? {
    let previous = self.previousToken(viewMode: .sourceAccurate)
    return ((previous?.trailingTrivia ?? []) + leadingTrivia).indentation(isOnNewline: previous == nil)
  }

  /// Returns the indentation of the line this token occurs on
  public var indentationOfLine: Trivia {
    var token: TokenSyntax = self
    if let indentation = token.indentation {
      return indentation
    }
    while let previous = token.previousToken(viewMode: .sourceAccurate) {
      token = previous
      if let indentation = token.indentation {
        return indentation
      }
    }

    return []
  }
}
