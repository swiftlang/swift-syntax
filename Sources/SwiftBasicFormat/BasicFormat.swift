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
  /// `isUserDefined` is `true` if the indentation was inferred from something
  /// the user provided manually instead of being inferred from the nesting
  /// level.
  public var indentationStack: [(indentation: Trivia, isUserDefined: Bool)]

  /// The trivia by which tokens should currently be indented.
  public var currentIndentationLevel: Trivia {
    // `decreaseIndentationLevel` guarantees that there is always one item on the stack.
    return indentationStack.last!.indentation
  }

  /// For every token that is being put on a new line but did not have
  /// user-specified indentation, the generated indentation.
  ///
  /// This is used as a reference-point to indent user-indented code.
  private var anchorPoints: [TokenSyntax: Trivia] = [:]

  /// The previously visited token. This is faster than accessing
  /// `token.previousToken` inside `visit(_:TokenSyntax)`. `nil` if no token has
  /// been visited yet.
  private var previousToken: TokenSyntax? = nil

  public init(indentationWidth: Trivia = .spaces(4), initialIndentation: Trivia = []) {
    self.indentationWidth = indentationWidth
    self.indentationStack = [(indentation: initialIndentation, isUserDefined: false)]
  }

  // MARK: - Updating indentation level

  public func increaseIndentationLevel(to userDefinedIndentation: Trivia? = nil) {
    if let userDefinedIndentation = userDefinedIndentation {
      indentationStack.append((indentation: userDefinedIndentation, isUserDefined: false))
    } else {
      indentationStack.append((indentation: currentIndentationLevel + indentationWidth, isUserDefined: false))
    }
  }

  public func decreaseIndentationLevel() {
    if indentationStack.count == 1 {
      assertionFailure("Popping more indentation levels than have been pushed")
      return
    }
    indentationStack.removeLast()
  }

  open override func visitPre(_ node: Syntax) {
    if requiresIndent(node) {
      if let firstToken = node.firstToken(viewMode: .sourceAccurate),
        let tokenIndentation = firstToken.leadingTrivia.indentation(isOnNewline: false),
        !tokenIndentation.isEmpty,
        let lastNonUserDefinedIndentation = indentationStack.last(where: { !$0.isUserDefined })?.indentation
      {
        // If the first token in this block is indented, infer the indentation level from it.
        increaseIndentationLevel(to: lastNonUserDefinedIndentation + tokenIndentation)
      } else {
        increaseIndentationLevel()
      }
    }
  }

  open override func visitPost(_ node: Syntax) {
    if requiresIndent(node) {
      decreaseIndentationLevel()
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
      if ancestor.position != token.position {
        break
      }
      if let ancestorsParent = ancestor.parent, childrenSeparatedByNewline(ancestorsParent) {
        return true
      }
    }

    return false
  }

  open func requiresWhitespace(between first: TokenSyntax?, and second: TokenSyntax?) -> Bool {
    switch (first?.tokenKind, second?.tokenKind) {
    case (.leftParen, .leftBrace),  // Ensures there is not a space in `.map({ $0.foo })`
      (.exclamationMark, .leftParen),  // Ensures there is not a space in `myOptionalClosure!()`
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

    if first?.requiresTrailingSpace ?? false {
      return true
    }
    if second?.requiresLeadingSpace ?? false {
      return true
    }
    return false
  }

  // MARK: - Formatting a token

  open override func visit(_ token: TokenSyntax) -> TokenSyntax {
    defer {
      self.previousToken = token
    }
    let previousToken = self.previousToken ?? token.previousToken(viewMode: .sourceAccurate)
    let nextToken = token.nextToken(viewMode: .sourceAccurate)

    lazy var previousTokenWillEndWithWhitespace: Bool = {
      guard let previousToken = previousToken else {
        return false
      }
      return previousToken.trailingTrivia.endsWithWhitespace
        || requiresWhitespace(between: previousToken, and: token)
    }()

    lazy var previousTokenWillEndWithNewline: Bool = {
      guard let previousToken = previousToken else {
        // Assume that the start of the tree is equivalent to a newline so we
        // don't add a leading newline to the file.
        return true
      }
      if previousToken.trailingTrivia.endsWithNewline {
        return true
      }
      if case .stringSegment(let segment) = previousToken.tokenKind, segment.last?.isNewline ?? false {
        return true
      }
      return false
    }()

    lazy var previousTokenIsStringLiteralEndingInNewline: Bool = {
      guard let previousToken = previousToken else {
        // Assume that the start of the tree is equivalent to a newline so we
        // don't add a leading newline to the file.
        return true
      }
      if case .stringSegment(let segment) = previousToken.tokenKind, segment.last?.isNewline ?? false {
        return true
      }
      return false
    }()

    lazy var nextTokenWillStartWithNewline: Bool = {
      guard let nextToken = nextToken else {
        return false
      }
      return nextToken.leadingTrivia.startsWithNewline
        || requiresLeadingNewline(nextToken)
    }()

    /// This token's trailing trivia + any spaces or tabs at the start of the
    /// next token's leading trivia.
    lazy var combinedTrailingTrivia: Trivia = {
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
    } else if requiresWhitespace(between: previousToken, and: token) {
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
    if requiresWhitespace(between: token, and: nextToken)
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

    leadingTrivia = leadingTrivia.indented(indentation: leadingTriviaIndentation, isOnNewline: previousTokenIsStringLiteralEndingInNewline)
    trailingTrivia = trailingTrivia.indented(indentation: trailingTriviaIndentation, isOnNewline: false)

    leadingTrivia = leadingTrivia.trimmingTrailingWhitespaceBeforeNewline(isBeforeNewline: false)
    trailingTrivia = trailingTrivia.trimmingTrailingWhitespaceBeforeNewline(isBeforeNewline: nextTokenWillStartWithNewline)

    if leadingTrivia == token.leadingTrivia && trailingTrivia == token.trailingTrivia {
      return token
    }

    return token.detach().with(\.leadingTrivia, leadingTrivia).with(\.trailingTrivia, trailingTrivia)
  }
}
