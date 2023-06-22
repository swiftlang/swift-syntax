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

/// A rewriter that performs a "basic" format of the passed tree.
///
/// The base implementation is primarily aimed at adding whitespace where
/// required such that re-parsing the tree's description results in the same
/// tree. But it also makes an attempt at adding in formatting, eg. splitting
/// lines where obvious and some basic indentation at nesting levels.
///
/// Any subclasses *must* return the same node type as given.
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

  public init(
    indentationWidth: Trivia = .spaces(4),
    initialIndentation: Trivia = [],
    viewMode: SyntaxTreeViewMode = .sourceAccurate
  ) {
    self.indentationWidth = indentationWidth
    self.indentationStack = [(indentation: initialIndentation, isUserDefined: false)]
    super.init(viewMode: viewMode)
  }

  // MARK: - Updating indentation level

  public func increaseIndentationLevel(to userDefinedIndentation: Trivia? = nil) {
    if let userDefinedIndentation = userDefinedIndentation {
      indentationStack.append((indentation: userDefinedIndentation, isUserDefined: true))
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

  open override func visit(_ node: UnexpectedNodesSyntax) -> UnexpectedNodesSyntax {
    // Do not perform any formatting on unexpected nodes, the result won't make any
    // sense as we rely on layout nodes to know what formatting to perform.
    return node
  }

  open override func visitPre(_ node: Syntax) {
    if requiresIndent(node) {
      if let firstToken = node.firstToken(viewMode: viewMode),
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
    case .ifConfigClauseList:
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
      if let firstToken = parent.firstToken(viewMode: viewMode),
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

  open func requiresNewline(between first: TokenSyntax?, and second: TokenSyntax?) -> Bool {
    // We don't want to add newlines inside string interpolation.
    // When first or second `TokenSyntax` is a multiline quote we want special handling
    // even if it's inside a string interpolation, because it still requires newline
    // after open quote and before close quote.
    if let first,
      isInsideStringInterpolation(first),
      first.tokenKind != .multilineStringQuote,
      second?.tokenKind != .multilineStringQuote
    {
      return false
    } else if let second {
      if second.requiresLeadingNewline {
        return true
      }

      var ancestor: Syntax = Syntax(second)
      while let parent = ancestor.parent {
        ancestor = parent
        if ancestor.position != second.position || ancestor.firstToken(viewMode: viewMode) != second {
          break
        }
        if let ancestorsParent = ancestor.parent, childrenSeparatedByNewline(ancestorsParent) {
          return true
        }
        switch ancestor.keyPathInParent {
        case \IfConfigClauseSyntax.elements:
          return true
        default:
          break
        }
      }
    }

    switch (first?.tokenKind, second?.tokenKind) {
    case (.multilineStringQuote, .backslash),  // string interpolation segment inside a multi-line string literal
      (.multilineStringQuote, .multilineStringQuote),  // empty multi-line string literal
      (.multilineStringQuote, .stringSegment),  // segment starting a multi-line string literal
      (.stringSegment, .multilineStringQuote),  // ending a multi-line string literal that has a string interpolation segment at its end
      (.rightParen, .multilineStringQuote):  // ending a multi-line string literal that has a string interpolation segment at its end
      return true
    default:
      return false
    }
  }

  open func requiresWhitespace(between first: TokenSyntax?, and second: TokenSyntax?) -> Bool {
    switch (first?.tokenKind, second?.tokenKind) {
    case (.atSign, _),
      (.backslash, _),
      (.backtick, _),
      (.dollarIdentifier, .period),  // a.b
      (.eof, _),
      (.exclamationMark, .leftParen),  // myOptionalClosure!()
      (.exclamationMark, .period),  // myOptionalBar!.foo()
      (.extendedRegexDelimiter, .leftParen),  // opening extended regex delimiter should never be separate by a space
      (.extendedRegexDelimiter, .regexSlash),  // opening extended regex delimiter should never be separate by a space
      (.identifier, .leftAngle),  // MyType<Int>
      (.identifier, .leftParen),  // foo()
      (.identifier, .leftSquareBracket),  // myArray[1]
      (.identifier, .period),  // a.b
      (.integerLiteral, .period),  // macOS 11.2.1
      (.keyword(.Any), .period),  // Any.Type
      (.keyword(.`init`), .leftAngle),  // init<T>()
      (.keyword(.`init`), .leftParen),  // init()
      (.keyword(.self), .period),  // self.someProperty
      (.keyword(.Self), .period),  // self.someProperty
      (.keyword(.set), .leftParen),  // var mYar: Int { set(value) {} }
      (.keyword(.subscript), .leftParen),  // subscript(x: Int)
      (.keyword(.super), .period),  // super.someProperty
      (.leftBrace, .rightBrace),  // {}
      (.leftParen, _),
      (.leftSquareBracket, _),
      (.multilineStringQuote, .rawStringDelimiter),  // closing raw string delimiter should never be separate by a space
      (.period, _),
      (.postfixQuestionMark, .leftAngle),  // init?<T>()
      (.postfixQuestionMark, .leftParen),  // init?() or myOptionalClosure?()
      (.postfixQuestionMark, .period),  // someOptional?.someProperty
      (.pound, _),
      (.poundUnavailableKeyword, .leftParen),  // #unavailable(...)
      (.prefixAmpersand, _),
      (.prefixOperator, _),
      (.rawStringDelimiter, .leftParen),  // opening raw string delimiter should never be separate by a space
      (.rawStringDelimiter, .multilineStringQuote),  // opening raw string delimiter should never be separate by a space
      (.rawStringDelimiter, .singleQuote),  // opening raw string delimiter should never be separate by a space
      (.rawStringDelimiter, .stringQuote),  // opening raw string delimiter should never be separate by a space
      (.regexLiteralPattern, _),
      (.regexSlash, .extendedRegexDelimiter),  // closing extended regex delimiter should never be separate by a space
      (.rightAngle, .leftParen),  // func foo<T>(x: T)
      (.rightBrace, .leftParen),  // { return 1 }()
      (.rightParen, .leftParen),  // returnsClosure()()
      (.rightParen, .period),  // foo().bar
      (.rightSquareBracket, .period),  // myArray[1].someProperty
      (.singleQuote, .rawStringDelimiter),  // closing raw string delimiter should never be separate by a space
      (.stringQuote, .rawStringDelimiter),  // closing raw string delimiter should never be separate by a space
      (.stringSegment, _),
      (_, .colon),
      (_, .comma),
      (_, .ellipsis),
      (_, .eof),
      (_, .exclamationMark),
      (_, .postfixOperator),
      (_, .postfixQuestionMark),
      (_, .rightParen),
      (_, .rightSquareBracket),
      (_, .semicolon),
      (_, nil),
      (nil, _):
      return false
    case (.leftAngle, _) where second?.tokenKind != .rightAngle:  // `<` and `>` need to be separated by a space because otherwise they become an operator
      return false
    case (_, .rightAngle) where first?.tokenKind != .leftAngle:  // `<` and `>` need to be separated by a space because otherwise they become an operator
      return false
    default:
      break
    }

    switch first?.keyPathInParent {
    case \ExpressionSegmentSyntax.backslash,
      \ExpressionSegmentSyntax.rightParen,
      \DeclNameArgumentSyntax.colon,
      \StringLiteralExprSyntax.openQuote,
      \RegexLiteralExprSyntax.openSlash:
      return false
    default:
      break
    }

    return true
  }

  /// Whether the formatter should consider this token as being mutable.
  /// This allows the diagnostic generator to only assume that missing nodes
  /// will be mutated. Thus, if two tokens need to be separated by a space, it
  /// will not be assumed that the space is added to an immutable previous node.
  open func isMutable(_ token: TokenSyntax) -> Bool {
    return true
  }

  // MARK: - Formatting a token

  open override func visit(_ token: TokenSyntax) -> TokenSyntax {
    defer {
      self.previousToken = token
    }
    let previousToken = self.previousToken ?? token.previousToken(viewMode: viewMode)
    let nextToken = token.nextToken(viewMode: viewMode)

    /// In addition to existing trivia of `previousToken`, also considers
    /// `previousToken` as ending with whitespace if it and `token` should be
    /// separated by whitespace.
    /// It does not consider whether a newline should be added between
    /// `previousToken` and the `token` because that newline should be added to
    /// the next token's trailing trivia.
    lazy var previousTokenWillEndWithWhitespace: Bool = {
      guard let previousToken = previousToken else {
        return false
      }
      return previousToken.trailingTrivia.endsWithWhitespace
        || (requiresWhitespace(between: previousToken, and: token) && isMutable(previousToken))
    }()

    /// This method does not consider any posssible mutations to `previousToken`
    /// because newlines should be added to the next token's leading trivia.
    lazy var previousTokenWillEndWithNewline: Bool = {
      guard let previousToken = previousToken else {
        // Assume that the start of the tree is equivalent to a newline so we
        // don't add a leading newline to the file.
        return true
      }
      if previousToken.trailingTrivia.endsWithNewline {
        return true
      }
      return previousToken.isStringSegmentWithLastCharacterBeingNewline
    }()

    lazy var previousTokenIsStringLiteralEndingInNewline: Bool = {
      guard let previousToken = previousToken else {
        // Assume that the start of the tree is equivalent to a newline so we
        // don't add a leading newline to the file.
        return true
      }
      return previousToken.isStringSegmentWithLastCharacterBeingNewline
    }()

    /// Also considers `nextToken` as starting with a whitespace if a newline
    /// should be added to it. It does not check whether `token` and `nextToken`
    /// should be separated by whitespace because the whitespace should be added
    /// to the `token`’s leading trivia.
    lazy var nextTokenWillStartWithWhitespace: Bool = {
      guard let nextToken = nextToken else {
        return false
      }
      return nextToken.leadingTrivia.startsWithWhitespace
        || (requiresNewline(between: token, and: nextToken) && isMutable(nextToken))
    }()

    /// Also considers `nextToken` as starting with a leading newline if `token`
    /// and `nextToken` should be separated by a newline.
    lazy var nextTokenWillStartWithNewline: Bool = {
      guard let nextToken = nextToken else {
        return false
      }
      return nextToken.leadingTrivia.startsWithNewline
        || (requiresNewline(between: token, and: nextToken) && isMutable(nextToken) && !token.trailingTrivia.endsWithNewline && !token.isStringSegmentWithLastCharacterBeingNewline)
    }()

    /// This token's trailing trivia + any spaces or tabs at the start of the
    /// next token's leading trivia.
    lazy var combinedTrailingTrivia: Trivia = {
      let nextTokenLeadingWhitespace = nextToken?.leadingTrivia.prefix(while: { $0.isSpaceOrTab }) ?? []
      return trailingTrivia + Trivia(pieces: nextTokenLeadingWhitespace)
    }()

    var leadingTrivia = token.leadingTrivia
    var trailingTrivia = token.trailingTrivia

    if requiresNewline(between: previousToken, and: token) {
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
      && !nextTokenWillStartWithWhitespace
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

fileprivate extension TokenSyntax {
  var isStringSegmentWithLastCharacterBeingNewline: Bool {
    switch self.tokenKind {
    case .stringSegment(let segment):
      return segment.last?.isNewline ?? false
    default:
      return false
    }
  }
}
