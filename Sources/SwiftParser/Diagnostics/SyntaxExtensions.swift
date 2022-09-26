//===--- SyntaxExtensions.swift -------------------------------------------===//
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

@_spi(RawSyntax) import SwiftSyntax

extension UnexpectedNodesSyntax {
  func tokens(satisfying isIncluded: (TokenSyntax) -> Bool) -> [TokenSyntax] {
    return self.children(viewMode: .sourceAccurate).compactMap({ $0.as(TokenSyntax.self) }).filter(isIncluded)
  }

  func tokens(withKind kind: TokenKind) -> [TokenSyntax] {
    return self.tokens(satisfying: { $0.tokenKind == kind })
  }
}

extension Syntax {
  func hasParent(_ expectedParent: Syntax) -> Bool {
    var walk = self.parent
    while walk != nil {
      if walk == expectedParent {
        return true
      }
      walk = walk?.parent
    }
    return false
  }
}

extension SyntaxProtocol {
  var nodeTypeNameForDiagnostics: String? {
    return Syntax(self).as(SyntaxEnum.self).nameForDiagnostics
  }

  /// If the syntax node (excluding leading and trailing trivia) only spans a
  /// single line and has less than 100 characters (and thus fits into a
  /// diagnostic message), return that. Otherwise, return `nil`.
  var contentForDiagnosticsIfShortSingleLine: String? {
    let contentWithoutTrivia = self.withoutLeadingTrivia().withoutTrailingTrivia().description
    if contentWithoutTrivia.contains("\n") || contentWithoutTrivia.count > 100 {
      return nil
    } else {
      return contentWithoutTrivia
    }
  }

  /// Returns this node or the first ancestor that satisfies `condition`.
  func ancestorOrSelf(where condition: (Syntax) -> Bool) -> Syntax? {
    var walk: Syntax? = Syntax(self)
    while let unwrappedParent = walk {
      if condition(unwrappedParent) {
        return walk
      }
      walk = unwrappedParent.parent
    }
    return nil
  }
}
