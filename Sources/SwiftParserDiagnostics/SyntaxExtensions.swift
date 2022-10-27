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

@_spi(RawSyntax) import SwiftSyntax

extension UnexpectedNodesSyntax {
  func tokens(satisfying isIncluded: (TokenSyntax) -> Bool) -> [TokenSyntax] {
    return self.children(viewMode: .sourceAccurate).compactMap({ $0.as(TokenSyntax.self) }).filter(isIncluded)
  }

  func tokens(withKind kind: TokenKind) -> [TokenSyntax] {
    return self.tokens(satisfying: { $0.tokenKind == kind })
  }

  /// If this only contains a single item that is a token, return that token, otherwise return `nil`.
  var onlyToken: TokenSyntax? {
    return onlyToken(where: { _ in true })
  }

  /// If this only contains a single item, which is a token satisfying `condition`, return that token, otherwise return `nil`.
  func onlyToken(where condition: (TokenSyntax) -> Bool) -> TokenSyntax? {
    if self.count == 1, let token = self.first?.as(TokenSyntax.self), condition(token) {
      return token
    } else {
      return nil
    }
  }

  /// If this only contains tokens satisfying `condition`, return an array containing those tokens, otherwise return `nil`.
  func onlyTokens(satisfying condition: (TokenSyntax) -> Bool) -> [TokenSyntax]? {
    let tokens = tokens(satisfying: condition)
    if tokens.count == self.count {
      return tokens
    } else {
      return nil
    }
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
  /// A name that can be used to describe this node's type in diagnostics or `nil` if there is no good name for this node.
  /// If `allowBlockNames` is `false`, `CodeBlockSyntax` and `MemberDeclBlockSyntax` are not considered to have a good name and will return `nil`.
  func nodeTypeNameForDiagnostics(allowBlockNames: Bool) -> String? {
    let syntax = Syntax(self)
    if !allowBlockNames && (syntax.is(CodeBlockSyntax.self) || syntax.is(MemberDeclBlockSyntax.self)) {
      return nil
    }
    return syntax.kind.nameForDiagnostics
  }

  /// A short description of this node that can be displayed inline in a single line.
  /// If the syntax node (excluding leading and trailing trivia) only spans a
  /// single line and has less than 100 characters (and thus fits into a
  /// diagnostic message), return that.
  /// Otherwise, return a generic message that describes the tokens in this node.
  var shortSingleLineContentDescription: String {
    let contentWithoutTrivia = self.withoutLeadingTrivia().withoutTrailingTrivia().description
    if self.children(viewMode: .sourceAccurate).allSatisfy({ $0.as(TokenSyntax.self)?.tokenKind == .rightBrace }) {
      if self.children(viewMode: .sourceAccurate).count == 1 {
        return "brace"
      } else {
        return "braces"
      }
    } else if let token = Syntax(self).as(UnexpectedNodesSyntax.self)?.onlyTokens(satisfying: { $0.tokenKind.isKeyword })?.only {
      return "'\(token.text)' keyword"
    } else if let token = Syntax(self).as(TokenSyntax.self) {
      return "'\(token.text)' keyword"
    } else if contentWithoutTrivia.contains("\n") || contentWithoutTrivia.count > 100 {
      return "code"
    } else {
      return "code '\(contentWithoutTrivia)'"
    }
  }

  /// Returns this node or the first ancestor that satisfies `condition`.
  func ancestorOrSelf(where condition: (Syntax) -> Bool) -> Syntax? {
    return ancestorOrSelf(mapping: { condition($0) ? $0 : nil })
  }

  /// Returns this node or the first ancestor that satisfies `condition`.
  func ancestorOrSelf<T>(mapping map: (Syntax) -> T?) -> T? {
    var walk: Syntax? = Syntax(self)
    while let unwrappedParent = walk {
      if let mapped = map(unwrappedParent) {
        return mapped
      }
      walk = unwrappedParent.parent
    }
    return nil
  }

  /// Returns `true` if the next token's leading trivia should be made leading trivia
  /// of this mode, when it is switched from being missing to present.
  var shouldBeInsertedAfterNextTokenTrivia: Bool {
    if !self.raw.kind.isMissing,
       let memberDeclItem = self.ancestorOrSelf(mapping: { $0.as(MemberDeclListItemSyntax.self) }),
       memberDeclItem.firstToken(viewMode: .all) == self.firstToken(viewMode: .all) {
      return true
    } else {
      return false
    }
  }
}

extension TokenKind {
  var isIdentifier: Bool {
    switch self {
    case .identifier:
      return true
    default:
      return false
    }
  }

  var isDollarIdentifier: Bool {
    switch self {
    case .dollarIdentifier:
      return true
    default:
      return false
    }
  }
}
