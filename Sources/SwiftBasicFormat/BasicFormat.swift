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

open class BasicFormat: SyntaxRewriter {
  /// How much indentation should be added at a new indentation level.
  public let indentationWidth: Trivia

  /// As we reach a new indendation level, its indentation will be added to the
  /// stack. As we exit that indentation level, the indendation will be popped.
  public var indentationStack: [Trivia]

  /// The trivia by which tokens should currently be indented.
  public var currentIndentationLevel: Trivia {
    // `popIndentationLevel` guarantees that there is always one item on the stack.
    return indentationStack.last!
  }

  /// For every token that is being put on a new line but did not have
  /// user-specified indentation, the generated indentation.
  ///
  /// This is used as a reference-point to indent user-indented code.
  private var anchorPoints: [TokenSyntax: Trivia] = [:]

  public init(indentationIncrement: Trivia = .spaces(4), initialIndentation: Trivia = []) {
    self.indentationWidth = indentationIncrement
    self.indentationStack = [initialIndentation]
  }

  // MARK: - Updating indentation level

  public func pushIndentationLevel(increasingIndentationBy: Trivia) {
    indentationStack.append(currentIndentationLevel + increasingIndentationBy)
  }

  public func popIndentationLevel() {
    precondition(indentationStack.count > 1, "Popping more indentation levels than have been pushed")
    indentationStack.removeLast()
  }

  open override func visitPre(_ node: Syntax) {
    if requiresIndent(node) {
      if let firstToken = node.firstToken(viewMode: .sourceAccurate),
        let tokenIndentation = firstToken.leadingTrivia.indentation(isOnNewline: false),
        !tokenIndentation.isEmpty
      {
        // If the first token in this block is indented, infer the indentation level from it.
        pushIndentationLevel(increasingIndentationBy: tokenIndentation)
      } else {
        pushIndentationLevel(increasingIndentationBy: indentationWidth)
      }
    }
  }

  open override func visitPost(_ node: Syntax) {
    if requiresIndent(node) {
      popIndentationLevel()
    }
  }

  // MARK: - Helper functions

  private func isInsideStringInterpolation(_ token: TokenSyntax) -> Bool {
    var ancestor: Syntax = Syntax(token)
    while let parent = ancestor.parent {
      ancestor = parent
      if ancestor.is(ExpressionSegmentSyntax.self) {
        return true
      }
    }
    return false
  }

  private func childrenSeparatedByNewline(_ node: Syntax) -> Bool {
    switch node.as(SyntaxEnum.self) {
    case .accessorList:
      return true
    case .codeBlockItemList:
      return true
    case .memberDeclList:
      return true
    case .switchCaseList:
      return true
    default:
      return false
    }
  }

  /// Find the indentation of the nearest ancestor whose first token is an
  /// anchor point (see `anchorPoints`).
  private func anchorPointIndentation(for token: TokenSyntax) -> Trivia? {
    var ancestor: Syntax = Syntax(token)
    while let parent = ancestor.parent {
      ancestor = parent
      if let firstToken = parent.firstToken(viewMode: .sourceAccurate),
        let anchorPointIndentation = anchorPoints[firstToken]
      {
        return anchorPointIndentation
      }
    }
    return nil
  }

  // MARK: - Customization points

  /// Whether a leading newline on `token` should be added.
  open func requiresIndent<T: SyntaxProtocol>(_ node: T) -> Bool {
    return node.requiresIndent
  }

  /// Whether a leading newline on `token` should be added.
  open func requiresLeadingNewline(_ token: TokenSyntax) -> Bool {
    // We don't want to add newlines inside string interpolation
    if isInsideStringInterpolation(token) {
      return false
    }

    if token.requiresLeadingNewline {
      return true
    }

    var ancestor: Syntax = Syntax(token)
    while let parent = ancestor.parent {
      ancestor = parent
      if ancestor.firstToken(viewMode: .sourceAccurate) != token {
        break
      }
      if let ancestorsParent = ancestor.parent, childrenSeparatedByNewline(ancestorsParent) {
        return true
      }
    }

    return false
  }

  /// Whether a leading space on `token` should be added.
  open func requiresLeadingWhitespace(_ token: TokenSyntax) -> Bool {
    switch (token.previousToken(viewMode: .sourceAccurate)?.tokenKind, token.tokenKind) {
    case (.leftParen, .leftBrace):  // Ensures there is not a space in `.map({ $0.foo })`
      return false
    default:
      break
    }

    return token.requiresLeadingSpace
  }

  /// Whether a trailing space on `token` should be added.
  open func requiresTrailingWhitespace(_ token: TokenSyntax) -> Bool {
    switch (token.tokenKind, token.nextToken(viewMode: .sourceAccurate)?.tokenKind) {
    case (.exclamationMark, .leftParen),  // Ensures there is not a space in `myOptionalClosure!()`
      (.exclamationMark, .period),  // Ensures there is not a space in `myOptionalBar!.foo()`
      (.keyword(.as), .exclamationMark),  // Ensures there is not a space in `as!`
      (.keyword(.as), .postfixQuestionMark),  // Ensures there is not a space in `as?`
      (.keyword(.try), .exclamationMark),  // Ensures there is not a space in `try!`
      (.keyword(.try), .postfixQuestionMark),  // Ensures there is not a space in `try?`:
      (.postfixQuestionMark, .leftParen),  // Ensures there is not a space in `init?()` or `myOptionalClosure?()`s
      (.postfixQuestionMark, .rightAngle),  // Ensures there is not a space in `ContiguousArray<RawSyntax?>`
      (.postfixQuestionMark, .rightParen):  // Ensures there is not a space in `myOptionalClosure?()`
      return false
    default:
      break
    }

    return token.requiresTrailingSpace
  }

  // MARK: - Formatting a token

  open override func visit(_ token: TokenSyntax) -> TokenSyntax {
    lazy var previousTokenWillEndWithWhitespace: Bool = {
      guard let previousToken = token.previousToken(viewMode: .sourceAccurate) else {
        return false
      }
      return previousToken.trailingTrivia.pieces.last?.isWhitespace ?? false
        || requiresTrailingWhitespace(previousToken)
    }()

    lazy var previousTokenWillEndWithNewline: Bool = {
      guard let previousToken = token.previousToken(viewMode: .sourceAccurate) else {
        // Assume that the start of the tree is equivalent to a newline so we
        // don't add a leading newline to the file.
        return true
      }
      return previousToken.trailingTrivia.endsWithNewline
    }()

    lazy var nextTokenWillStartWithNewline: Bool = {
      guard let nextToken = token.nextToken(viewMode: .sourceAccurate) else {
        return false
      }
      return nextToken.leadingTrivia.startsWithNewline
        || requiresLeadingNewline(nextToken)
    }()

    /// This token's trailing trivia + any spaces or tabs at the start of the
    /// next token's leading trivia.
    lazy var combinedTrailingTrivia: Trivia = {
      let nextToken = token.nextToken(viewMode: .sourceAccurate)
      let nextTokenLeadingWhitespace = nextToken?.leadingTrivia.prefix(while: { $0.isSpaceOrTab }) ?? []
      return trailingTrivia + Trivia(pieces: nextTokenLeadingWhitespace)
    }()

    var leadingTrivia = token.leadingTrivia
    var trailingTrivia = token.trailingTrivia

    if requiresLeadingNewline(token) {
      // Add a leading newline if the token requires it unless
      //  - it already starts with a newline or
      //  - the previous token ends with a newline
      if !leadingTrivia.startsWithNewline && !previousTokenWillEndWithNewline {
        // Add a leading newline if the token requires it and
        //  - it doesn't already start with a newline and
        //  - the previous token didn't end with a newline
        leadingTrivia = .newline + leadingTrivia
      }
    } else if requiresLeadingWhitespace(token) {
      // Add a leading space if the token requires it unless
      //  - it already starts with a whitespace or
      //  - the previous token ends with a whitespace after the rewrite
      if !leadingTrivia.startsWithWhitespace && !previousTokenWillEndWithWhitespace {
        leadingTrivia += .space
      }
    }

    if leadingTrivia.indentation(isOnNewline: previousTokenWillEndWithNewline) == [] {
      // If the token starts on a new line and does not have indentation, this
      // is the last non-indented token. Store its indentation level
      anchorPoints[token] = currentIndentationLevel
    }

    // Add a trailing space to the token unless
    //  - it already ends with a whitespace or
    //  - the next token will start starts with a newline after the rewrite
    //    because newlines should be preferred to spaces as a whitespace
    if requiresTrailingWhitespace(token)
      && !trailingTrivia.endsWithWhitespace
      && !nextTokenWillStartWithNewline
    {
      trailingTrivia += .space
    }

    var leadingTriviaIndentation = self.currentIndentationLevel
    var trailingTriviaIndentation = self.currentIndentationLevel

    // If the trivia contain user-defined indentation, find their anchor point
    // and indent the token relative to that anchor point.
    if leadingTrivia.containsIndentation(isOnNewline: previousTokenWillEndWithNewline),
      let anchorPointIndentation = self.anchorPointIndentation(for: token)
    {
      leadingTriviaIndentation = anchorPointIndentation
    }
    if combinedTrailingTrivia.containsIndentation(isOnNewline: previousTokenWillEndWithNewline),
      let anchorPointIndentation = self.anchorPointIndentation(for: token)
    {
      trailingTriviaIndentation = anchorPointIndentation
    }

    leadingTrivia = leadingTrivia.indented(indentation: leadingTriviaIndentation, isOnNewline: false)
    trailingTrivia = trailingTrivia.indented(indentation: trailingTriviaIndentation, isOnNewline: false)

    leadingTrivia = leadingTrivia.trimmingTrailingWhitespaceBeforeNewline(isBeforeNewline: false)
    trailingTrivia = trailingTrivia.trimmingTrailingWhitespaceBeforeNewline(isBeforeNewline: nextTokenWillStartWithNewline)

    return token.with(\.leadingTrivia, leadingTrivia).with(\.trailingTrivia, trailingTrivia)
  }
}
