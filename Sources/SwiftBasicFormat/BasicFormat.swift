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
@_spi(RawSyntax) public import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

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

  /// As we reach a new indentation level, its indentation will be added to the
  /// stack. As we exit that indentation level, the indentation will be popped.
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

  /// The number of ancestors that are `StringLiteralExprSyntax`.
  private var stringLiteralNestingLevel = 0

  /// Whether we are currently visiting the subtree of a `StringLiteralExprSyntax`.
  private var isInsideStringLiteral: Bool {
    return stringLiteralNestingLevel > 0
  }

  public init(
    indentationWidth: Trivia? = nil,
    initialIndentation: Trivia = [],
    viewMode: SyntaxTreeViewMode = .sourceAccurate
  ) {
    // Default to 4 spaces if no indentation was passed.
    // In the future, we could consider inferring the indentation width from the
    // source file to format in case it is already partially formatted.
    self.indentationWidth = indentationWidth ?? .spaces(4)
    self.indentationStack = [(indentation: initialIndentation, isUserDefined: false)]
    super.init(viewMode: viewMode)
  }

  /// Clears all stateful data from this `BasicFormat`.
  ///
  /// This needs to be called between multiple `rewrite` calls to a syntax tree.
  func reset() {
    indentationStack = [indentationStack.first!]
    anchorPoints = [:]
    previousToken = nil
    stringLiteralNestingLevel = 0
  }

  // MARK: - Updating indentation level

  public func increaseIndentationLevel(to userDefinedIndentation: Trivia? = nil) {
    if let userDefinedIndentation {
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
    if node.is(StringLiteralExprSyntax.self) {
      stringLiteralNestingLevel += 1
    }
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
    if node.is(StringLiteralExprSyntax.self) {
      stringLiteralNestingLevel -= 1
    }
    if requiresIndent(node) {
      decreaseIndentationLevel()
    }
  }

  // MARK: - Helper functions

  private func isInsideStringInterpolation(_ token: TokenSyntax) -> Bool {
    return token.ancestorOrSelf { $0.as(ExpressionSegmentSyntax.self) } != nil
  }

  private func childrenSeparatedByNewline(_ node: Syntax) -> Bool {
    switch node.kind {
    case .accessorDeclList:
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
  private func anchorPointIndentation(for token: TokenSyntax) -> Trivia {
    var ancestor: Syntax = Syntax(token)
    while let parent = ancestor.parent {
      ancestor = parent
      if let firstToken = parent.firstToken(viewMode: viewMode),
        let anchorPointIndentation = anchorPoints[firstToken]
      {
        return anchorPointIndentation
      }
    }
    return Trivia()
  }

  // MARK: - Customization points

  /// If we are formatting a subtree and the line that the initial token occurs on is indented,
  /// use that line indentation for the first token in the subtree to format.
  ///
  /// For example, when formatting only the code block in the following,
  /// then the opening `{` should be indented by four spaces.
  /// ```
  ///     func test() {
  ///         print(1)
  ///     }
  /// ```
  open var inferInitialTokenIndentation: Bool { true }

  /// Whether a leading newline on `token` should be added.
  open func requiresIndent(_ node: some SyntaxProtocol) -> Bool {
    guard let keyPath = node.keyPathInParent else {
      return false
    }
    switch keyPath {
    case \AccessorBlockSyntax.accessors:
      return true
    case \ArrayExprSyntax.elements:
      return true
    case \ClosureExprSyntax.statements:
      return true
    case \ClosureParameterClauseSyntax.parameters:
      return true
    case \CodeBlockSyntax.statements:
      return true
    case \DictionaryElementSyntax.value:
      return true
    case \DictionaryExprSyntax.content:
      return true
    case \EnumCaseParameterClauseSyntax.parameters:
      return true
    case \FunctionCallExprSyntax.arguments:
      return true
    case \FunctionTypeSyntax.parameters:
      return true
    case \MemberDeclBlockSyntax.members:
      return true
    case \ParameterClauseSyntax.parameters:
      return true
    case \SwitchCaseSyntax.statements:
      return true
    case \TupleExprSyntax.elements:
      return true
    case \TupleTypeSyntax.elements:
      return true
    default:
      return false
    }
  }

  /// Returns `true` if `token` is the opening brace of a closure that is being
  /// parsed in an expression with `ExprFlavor.stmtCondition`.
  ///
  /// In these cases, adding a newline changes whether the closure gets parsed
  /// as a closure or if it gets interpreted as the statements body. We should
  /// thus be conservative and not add a newline after the `{` in `BasicFormat`.
  private func isLeftBraceOfClosureInStmtConditionExpr(_ token: TokenSyntax?) -> Bool {
    guard let token, token.keyPathInParent == \ClosureExprSyntax.leftBrace else {
      return false
    }
    return token.ancestorOrSelf(mapping: {
      switch $0.keyPathInParent {
      case \CatchItemSyntax.pattern,
        \ConditionElementSyntax.condition,
        \ExpressionPatternSyntax.expression,
        \ForStmtSyntax.sequence,
        \ForStmtSyntax.whereClause,
        \SwitchExprSyntax.subject:
        return $0
      default:
        return nil
      }
    }) != nil
  }

  open func requiresNewline(between first: TokenSyntax?, and second: TokenSyntax?) -> Bool {
    // We don't want to add newlines inside string interpolation.
    // When first or second ``TokenSyntax`` is a multiline quote we want special handling
    // even if it's inside a string interpolation, because it still requires newline
    // after open quote and before close quote.
    if let first,
      isInsideStringInterpolation(first),
      first.tokenKind != .multilineStringQuote,
      second?.tokenKind != .multilineStringQuote
    {
      return false
    } else if isLeftBraceOfClosureInStmtConditionExpr(first) {
      return false
    } else if let second {
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
      (.rightParen, .multilineStringQuote),  // ending a multi-line string literal that has a string interpolation segment at its end
      (.poundEndif, _),
      (_, .poundElse),
      (_, .poundElseif),
      (_, .poundEndif),
      (_, .rightBrace):
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
      (.endOfFile, _),
      (.exclamationMark, .leftParen),  // myOptionalClosure!()
      (.exclamationMark, .period),  // myOptionalBar!.foo()
      (.regexPoundDelimiter, .leftParen),  // opening extended regex delimiter should never be separate by a space
      (.regexPoundDelimiter, .regexSlash),  // opening extended regex delimiter should never be separate by a space
      (.identifier, .leftAngle),  // MyType<Int>
      (.identifier, .leftParen),  // foo()
      (.identifier, .leftSquare),  // myArray[1]
      (.identifier, .period),  // a.b
      (.integerLiteral, .period),  // macOS 11.2.1
      (.keyword(.Any), .period),  // Any.Type
      (.keyword(.`init`), .leftAngle),  // init<T>()
      (.keyword(.`init`), .leftParen),  // init()
      (.keyword(.self), .period),  // self.someProperty
      (.keyword(.self), .leftParen),  // self()
      (.keyword(.self), .leftSquare),  // self[]
      (.keyword(.Self), .period),  // Self.someProperty
      (.keyword(.Self), .leftParen),  // Self()
      (.keyword(.Self), .leftSquare),  // Self[]
      (.keyword(.set), .leftParen),  // var mVar: Int { set(value) {} }
      (.keyword(.subscript), .leftParen),  // subscript(x: Int)
      (.keyword(.super), .period),  // super.someProperty
      (.leftBrace, .rightBrace),  // {}
      (.leftParen, _),
      (.leftSquare, _),
      (.multilineStringQuote, .rawStringPoundDelimiter),  // closing raw string delimiter should never be separate by a space
      (.period, _),
      (.postfixQuestionMark, .leftAngle),  // init?<T>()
      (.postfixQuestionMark, .leftParen),  // init?() or myOptionalClosure?()
      (.postfixQuestionMark, .period),  // someOptional?.someProperty
      (.pound, _),
      (.poundUnavailable, .leftParen),  // #unavailable(...)
      (.prefixAmpersand, _),
      (.prefixOperator, _),
      (.rawStringPoundDelimiter, .leftParen),  // opening raw string delimiter should never be separate by a space
      (.rawStringPoundDelimiter, .multilineStringQuote),  // opening raw string delimiter should never be separate by a space
      (.rawStringPoundDelimiter, .singleQuote),  // opening raw string delimiter should never be separate by a space
      (.rawStringPoundDelimiter, .stringQuote),  // opening raw string delimiter should never be separate by a space
      (.rawStringPoundDelimiter, .period),  // opening raw string delimiter should never be separate by a space
      (.regexLiteralPattern, _),
      (.regexPoundDelimiter, .period),  // #/myRegex/#.someMember
      (.regexSlash, .regexPoundDelimiter),  // closing extended regex delimiter should never be separate by a space
      (.regexSlash, .period),  // /myRegex/.someMember
      (.rightAngle, .leftParen),  // func foo<T>(x: T)
      (.rightAngle, .period),  // Foo<T>.bar
      (.rightBrace, .leftParen),  // { return 1 }()
      (.rightParen, .leftParen),  // returnsClosure()()
      (.rightParen, .period),  // foo().bar
      (.rightSquare, .period),  // myArray[1].someProperty
      (.singleQuote, .rawStringPoundDelimiter),  // closing raw string delimiter should never be separate by a space
      (.stringQuote, .rawStringPoundDelimiter),  // closing raw string delimiter should never be separate by a space
      (.stringQuote, .period),  // "test".lowercased
      (.stringSegment, _),
      (_, .comma),
      (_, .ellipsis),
      (_, .endOfFile),
      (_, .exclamationMark),
      (_, .postfixOperator),
      (_, .postfixQuestionMark),
      (_, .rightParen),
      (_, .rightSquare),
      (_, .semicolon),
      (_, nil),
      (nil, _):
      return false
    case (_, .colon):
      if second?.keyPathInParent != \TernaryExprSyntax.colon
        && second?.keyPathInParent != \UnresolvedTernaryExprSyntax.colon
      {
        return false
      }
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
      \SimpleStringLiteralExprSyntax.openingQuote,
      \StringLiteralExprSyntax.openingQuote,
      \RegexLiteralExprSyntax.openingSlash:
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

  /// Change the text of a token during formatting.
  ///
  /// This allows formats to e.g. replace missing tokens by placeholder tokens.
  ///
  /// - Parameter token: The token whose text should be changed
  /// - Returns: The new text or `nil` if the text should not be changed
  open func transformTokenText(_ token: TokenSyntax) -> String? {
    return nil
  }

  /// Change the presence of a token during formatting.
  ///
  /// This allows formats to e.g. replace missing tokens by placeholder tokens.
  ///
  /// - Parameter token: The token whose presence should be changed
  /// - Returns: The new presence or `nil` if the presence should not be changed
  open func transformTokenPresence(_ token: TokenSyntax) -> SourcePresence? {
    return nil
  }

  // MARK: - Formatting a token

  open override func visit(_ token: TokenSyntax) -> TokenSyntax {
    defer {
      self.previousToken = token
    }
    let isInitialToken = self.previousToken == nil
    let previousToken = self.previousToken ?? token.previousToken(viewMode: viewMode)
    let nextToken = token.nextToken(viewMode: viewMode)
    let transformedTokenText = self.transformTokenText(token)
    let transformedTokenPresence = self.transformTokenPresence(token)

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

    /// This method does not consider any possible mutations to `previousToken`
    /// because newlines should be added to the next token's leading trivia.
    let previousTokenWillEndWithNewline: Bool = {
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

    let previousTokenIsStringLiteralEndingInNewline: Bool = {
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
    let nextTokenWillStartWithNewline: Bool = {
      guard let nextToken = nextToken else {
        return false
      }
      if nextToken.leadingTrivia.startsWithNewline {
        return true
      }
      if nextToken.leadingTrivia.isEmpty {
        if nextToken.text.first?.isNewline ?? false {
          return true
        }
        if nextToken.text.isEmpty && nextToken.trailingTrivia.startsWithNewline {
          return true
        }
      }
      if requiresNewline(between: token, and: nextToken),
        isMutable(nextToken),
        !token.trailingTrivia.endsWithNewline,
        !token.isStringSegmentWithLastCharacterBeingNewline
      {
        return true
      }
      return false
    }()

    var leadingTrivia = token.leadingTrivia
    var trailingTrivia = token.trailingTrivia

    /// This token's trailing trivia + any spaces or tabs at the start of the
    /// next token's leading trivia.
    let combinedTrailingTrivia: Trivia = {
      let nextTokenLeadingWhitespace = nextToken?.leadingTrivia.prefix(while: { $0.isSpaceOrTab }) ?? []
      return trailingTrivia + Trivia(pieces: nextTokenLeadingWhitespace)
    }()

    /// Whether the leading trivia of the token is followed by a newline.
    let leadingTriviaIsFollowedByNewline: Bool = {
      if (transformedTokenText ?? token.text).isEmpty && token.trailingTrivia.startsWithNewline {
        return true
      } else if token.text.first?.isNewline ?? false {
        return true
      } else if (transformedTokenText ?? token.text).isEmpty && token.trailingTrivia.isEmpty && nextTokenWillStartWithNewline {
        return true
      } else {
        return false
      }
    }()

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

    if leadingTrivia.indentation(isOnNewline: isInitialToken || previousTokenWillEndWithNewline) == [] && !token.isStringSegment {
      // If the token starts on a new line and does not have indentation, this
      // is the last non-indented token. Store its indentation level.
      // But never consider string segments as anchor points since you can’t
      // indent individual lines of a multi-line string literals without breaking
      // their integrity.
      anchorPoints[token] = currentIndentationLevel
    }

    if inferInitialTokenIndentation
      && isInitialToken
      && token.presence == .present
    {
      let indentationOfLine = token.indentationOfLine
      if token.leadingTrivia.pieces.suffix(indentationOfLine.pieces.count) != indentationOfLine.pieces {
        leadingTrivia += indentationOfLine
      }
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

    let leadingTriviaIndentation: Trivia
    let trailingTriviaIndentation: Trivia

    // If the trivia contains user-defined indentation, find their anchor point
    // and indent the token relative to that anchor point.
    //
    // Always indent string literals relative to their anchor point because
    // their indentation has structural meaning and we just want to maintain
    // what the user wrote.
    if leadingTrivia.containsIndentation(isOnNewline: previousTokenWillEndWithNewline) || isInsideStringLiteral {
      leadingTriviaIndentation = anchorPointIndentation(for: token)
    } else {
      leadingTriviaIndentation = currentIndentationLevel
    }
    if combinedTrailingTrivia.containsIndentation(isOnNewline: previousTokenWillEndWithNewline) {
      trailingTriviaIndentation = anchorPointIndentation(for: token)
    } else {
      trailingTriviaIndentation = currentIndentationLevel
    }

    leadingTrivia = leadingTrivia.indented(
      indentation: leadingTriviaIndentation,
      isOnNewline: previousTokenIsStringLiteralEndingInNewline || previousTokenWillEndWithNewline
    )
    trailingTrivia = trailingTrivia.indented(
      indentation: trailingTriviaIndentation,
      isOnNewline: false,
      // Don't add indentation to the last newline.
      // Its indentation will be added to the next token's leading trivia, which
      // might have a different indentation scope than this token (in particular
      // if this token is a closing brace).
      addIndentationAfterLastNewline: false
    )

    leadingTrivia = leadingTrivia.trimmingTrailingWhitespaceBeforeNewline(isBeforeNewline: leadingTriviaIsFollowedByNewline)
    trailingTrivia = trailingTrivia.trimmingTrailingWhitespaceBeforeNewline(isBeforeNewline: nextTokenWillStartWithNewline)

    var result = token.detached
    if leadingTrivia != result.leadingTrivia {
      result = result.with(\.leadingTrivia, leadingTrivia)
    }
    if trailingTrivia != result.trailingTrivia {
      result = result.with(\.trailingTrivia, trailingTrivia)
    }
    if let transformedTokenText {
      let newKind = TokenKind.fromRaw(kind: token.tokenKind.decomposeToRaw().rawKind, text: transformedTokenText)
      result = result.with(\.tokenKind, newKind).with(\.presence, .present)
    }
    if let transformedTokenPresence {
      result = result.with(\.presence, transformedTokenPresence)
    }
    return result
  }
}

fileprivate extension TokenSyntax {
  var isStringSegment: Bool {
    if case .stringSegment = self.tokenKind {
      return true
    } else {
      return false
    }
  }

  var isStringSegmentWithLastCharacterBeingNewline: Bool {
    switch self.tokenKind {
    case .stringSegment(let segment):
      return segment.last?.isNewline ?? false
    default:
      return false
    }
  }
}

fileprivate extension SyntaxProtocol {
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
}
