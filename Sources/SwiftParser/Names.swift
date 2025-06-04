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

#if compiler(>=6)
@_spi(RawSyntax) internal import SwiftSyntax
#else
@_spi(RawSyntax) import SwiftSyntax
#endif

extension Parser {
  /// Parse an identifier or operator.
  ///
  /// - Note: If you expect a module selector, parse it before calling this method; it will consume module selectors
  ///   as unexpected syntax.
  mutating func parseAnyIdentifier() -> (RawUnexpectedNodesSyntax?, RawTokenSyntax) {
    let moduleSelector = unexpected(self.parseModuleSelector())
    if let token = self.consume(if: .identifier) {
      return (moduleSelector, token)
    } else if let (_, handle) = self.at(anyIn: Operator.self) {
      return (moduleSelector, self.eat(handle))
    } else {
      return (moduleSelector, RawTokenSyntax(missing: .identifier, arena: arena))
    }
  }

  mutating func parseArgumentLabel() -> (RawUnexpectedNodesSyntax?, RawTokenSyntax) {
    let unexpectedSelector = unexpected(self.parseModuleSelector())
    guard self.atArgumentLabel(allowDollarIdentifier: true) else {
      return (unexpectedSelector, missingToken(.identifier))
    }
    if let dollarIdent = self.consume(if: .dollarIdentifier) {
      return (
        RawUnexpectedNodesSyntax(combining: unexpectedSelector, dollarIdent, arena: self.arena),
        self.missingToken(.identifier)
      )
    } else {
      if let wildcardToken = self.consume(if: .wildcard) {
        return (unexpectedSelector, wildcardToken)
      }
      return (unexpectedSelector, self.consumeAnyToken(remapping: .identifier))
    }
  }
}

private enum StructuralTokens: TokenSpecSet {
  case comma
  case colon
  case leftParen
  case leftBrace
  case leftSquare
  case leftAngle
  case rightParen
  case rightBrace
  case rightSquare
  case rightAngle

  init?(lexeme: Lexer.Lexeme, experimentalFeatures: Parser.ExperimentalFeatures) {
    switch lexeme.rawTokenKind {
    case .comma: self = .comma
    case .colon: self = .colon
    case .leftParen: self = .leftParen
    case .leftBrace: self = .leftBrace
    case .leftSquare: self = .leftSquare
    case .leftAngle : self = .leftAngle
    case .rightParen: self = .rightParen
    case .rightBrace: self = .rightBrace
    case .rightSquare: self = .rightSquare
    case .rightAngle: self = .rightAngle
    default: return nil
    }
  }

  var spec: TokenSpec {
    switch self {
    case .comma: return .comma
    case .colon: return .colon
    case .leftParen: return .leftParen
    case .leftBrace: return .leftBrace
    case .leftSquare: return .leftSquare
    case .leftAngle: return .leftAngle
    case .rightParen: return .rightParen
    case .rightBrace: return .rightBrace
    case .rightSquare: return .rightSquare
    case .rightAngle: return .rightAngle
    }
  }
}

extension TokenConsumer {
  /// Do the subsequent tokens have the form of a module selector? Encompasses some invalid syntax which nonetheless
  /// can be handled by `consumeModuleSelectorTokens()`.
  ///
  /// - Postcondition: If `true`, either the current token or the next token is `.colonColon`.
  mutating func isAtModuleSelector() -> Bool {
    // If this is a module selector, the next token should be `::`.
    guard self.peek(isAt: .colonColon) else {
      // ...however, we will also allow the *current* token to be `::`. `consumeModuleSelectorTokens()` will create a
      // missing identifier.
      return self.at(.colonColon)
    }

    // Technically the current token *should* be an identifier, but we also want to diagnose other tokens that might be
    // used by accident (particularly keywords and `_`). However, we don't want to consume tokens which would make the
    // surrounding structure mis-parse.
    return self.at(anyIn: StructuralTokens.self) == nil
  }

  mutating func unlessPeekModuleSelector<T>(_ operation: (inout Self) -> T?) -> T? {
    var lookahead = self.lookahead()
    lookahead.skipSingle()
    if lookahead.isAtModuleSelector() {
      return nil
    }
    return operation(&self)
  }

  /// If the subsequent tokens have the form of a module selector, valid or otherwise, consume and return them;
  /// otherwise consume nothing and return `nil`. Additionally consumes invalid chained module selectors.
  ///
  /// Returns a tuple comprised of:
  ///
  ///  - `moduleNameOrUnexpected`: The module name if present; in a valid module selector, this will be a present
  ///     identifier, but either of those can be untrue in invalid code.
  ///  - `colonColonToken`: The `::` indicating this module selector. Always `.colonColon`, always present.
  ///  - `extra`: Tokens for additional trailing module selectors. There is no situation in which two module selectors
  ///    can be validly chained.
  mutating func consumeModuleSelectorTokens() -> (moduleNameOrUnexpected: Token, colonColonToken: Token, extra: [Token])? {
    guard self.isAtModuleSelector() else {
      return nil
    }

    let moduleName: Token
    let colonColonToken: Token

    // Did we forget the module name?
    if let earlyColonColon = self.consume(if: .colonColon) {
      moduleName = self.missingToken(.identifier)
      colonColonToken = earlyColonColon
    } else {
      // Consume whatever comes before the `::`, plus the `::` itself. (Whether or not the "name" is an identifier is
      // checked elsewhere.)
      moduleName = self.consumeAnyToken()
      colonColonToken = self.eat(.colonColon)
    }

    var extra: [Token] = []
    while self.isAtModuleSelector() {
      if !self.at(.colonColon) {
        extra.append(self.consumeAnyToken())
      }
      extra.append(self.eat(.colonColon))
    }
    return (moduleName, colonColonToken, extra)
  }
}

extension Parser {
  /// Parses one or more module selectors, if present.
  mutating func parseModuleSelector() -> RawModuleSelectorSyntax? {
    guard let (moduleNameOrUnexpected, colonColon, extra) = consumeModuleSelectorTokens() else {
      return nil
    }

    let leadingUnexpected: [RawSyntax]
    let moduleName: RawTokenSyntax
    let trailingUnexpected: [RawSyntax]

    if moduleNameOrUnexpected.tokenKind == .identifier {
      leadingUnexpected = []
      moduleName = moduleNameOrUnexpected
    } else {
      leadingUnexpected = [RawSyntax(moduleNameOrUnexpected)]
      moduleName = RawTokenSyntax.init(missing: .identifier, arena: arena)
    }

    trailingUnexpected = extra.map { RawSyntax($0) }

    return RawModuleSelectorSyntax(
      RawUnexpectedNodesSyntax(elements: leadingUnexpected, arena: arena),
      moduleName: moduleName,
      colonColon: colonColon,
      RawUnexpectedNodesSyntax(elements: trailingUnexpected, arena: arena),
      arena: arena
    )
  }

  /// Convert a raw syntax node to `RawUnexpectedNodesSyntax` by extracting its tokens.
  func unexpected(_ node: (some RawSyntaxNodeProtocol)?) -> RawUnexpectedNodesSyntax? {
    var tokens: [RawTokenSyntax] = []

    func collect(from child: (some RawSyntaxNodeProtocol)?) {
      guard let child else { return }

      guard let token = child.as(RawTokenSyntax.self) else {
        for child in child.raw.layoutView!.children {
          collect(from: child)
        }
        return
      }

      if !token.isMissing {
        tokens.append(token)
      }
    }

    collect(from: node)

    guard !tokens.isEmpty else {
      return nil
    }
    return RawUnexpectedNodesSyntax(tokens, arena: self.arena)
  }

  /// Inject `moduleSelector` into `node`, its first child, its first child's first child, etc. If necessary,
  /// `moduleSelector`'s tokens will be inserted into an unexpected syntax node rather than the selector itself being
  /// inserted. This should only be called when `node` comes *immediately* after `moduleSelector`.
  ///
  /// Use this method to "prepend" a module selector to a tree of syntax nodes. Doing so can avoid threading the module
  /// selector through a lot of code, which can consume a lot of stack space and be fairly error-prone.
  ///
  /// - Precondition: `node` must, at minimum, have a descendant with an unexpected nodes child; it therefore cannot be
  ///   a token or an empty collection.
  func attach<Node: RawSyntaxNodeProtocol>(_ moduleSelector: RawModuleSelectorSyntax?, to node: Node) -> Node {
    guard let moduleSelector else {
      return node
    }

    /// Recursively walk `node` and its descendants, looking for a place to attach `moduleSelector`.
    ///
    /// - Returns: `nil` if no suitable attachment point was found inside `node`; otherwise, a copy of `node` with
    ///   `moduleSelector` or its tokens injected somewhere.
    func rewrite<ChildNode: RawSyntaxNodeProtocol>(attachingTo node: ChildNode) -> ChildNode? {
      // If we hit a token, we won't be able to insert here. The parent will have to take care of it.
      guard let layout = node.raw.layoutView else {
        return nil
      }

      /// Returns a copy of `node` with the child at `index` replaced by `newChild`.
      func makeNode(withChildAt index: Int, replacedBy newChild: (some RawSyntaxNodeProtocol)?) -> ChildNode {
        return layout.replacingChild(
          at: index, with: newChild?.raw, arena: self.arena
        ).cast(ChildNode.self)
      }

      // Try to incorporate `self` into `node` or one of its children in a node-specific way.
      switch node.raw.kind {
      case .token:
        fatalError("should have early returned")

      case .moduleSelector:
        // Don't try to insert within a module selector.
        return nil

      case .unexpectedNodes:
        // We can just insert `self` here.
        return RawUnexpectedNodesSyntax(
          combining: unexpected(moduleSelector), node.cast(RawUnexpectedNodesSyntax.self),
          arena: self.arena
        )?.cast(ChildNode.self)

      case .declReferenceExpr, .identifierType:
        // This node has an expected module selector at child 1.
        let nodeUnexpectedBeforeModuleSelector = layout.children[0]
        let nodeModuleSelector = layout.children[1]

        // If `node` doesn't already have a module selector or some unexpected syntax before one, attach
        // `moduleSelector` there.
        //
        // Note: The `nodeModuleSelector` check here is defensive. It's probably impossible for only
        // `nodeModuleSelector` to be non-nil because the `parseModuleSelector()` call that created `moduleSelector`
        // should have consumed the tokens that would have gone into `nodeModuleSelector`. However, if it *does* turn
        // out to be possible, we may want to insert `nodeModuleSelector` into
        // `moduleSelector.unexpectedAfterColonColon` to get slightly nicer diagnostics.
        if nodeUnexpectedBeforeModuleSelector == nil && nodeModuleSelector == nil {
          return makeNode(withChildAt: 1, replacedBy: moduleSelector)
        }

      default:
        // Try to attach `moduleSelector` to the first suitable child.
        func isInsertionPoint(_ child: RawSyntax?) -> Bool {
          guard let child else {
            return false
          }
          // Skip empty collections, but don't skip nodes with missing tokens (which are also `isEmpty`).
          return !child.isEmpty || !child.kind.isSyntaxCollection
        }

        if let childIndex = layout.children.firstIndex(where: isInsertionPoint(_:)),
          let replacementChild = rewrite(attachingTo: layout.children[childIndex]!) {
          return makeNode(withChildAt: childIndex, replacedBy: replacementChild)
        }
      }

      // Last chance: If this is *not* a collection, child 0 is unexpected nodes; we can put `moduleSelector` there.
      if !node.raw.kind.isSyntaxCollection {
        assert(layout.children[0] == nil)
        return makeNode(withChildAt: 0, replacedBy: unexpected(moduleSelector))
      }

      // Out of options.
      return nil
    }

    guard let rewrittenNode = rewrite(attachingTo: node) else {
      // We should *never* parse a module selector and then have nothing to attach it to; if there's a situation where
      // we do, we should not have parsed it in the first place.
      preconditionFailure(
        """
        No way to attach module selector to node!
        Module selector: \(String(reflecting: moduleSelector))
        Attachment point: \(String(reflecting: node))
        """
      )
    }

    return rewrittenNode
  }
}

extension Parser {
  struct DeclNameOptions: OptionSet {
    var rawValue: UInt8

    /// If passed, operator basenames are allowed.
    static let operators = Self(rawValue: 1 << 0)

    /// If passed, names that coincide with keywords are allowed. Used after a
    /// dot to enable things like '.init' and '.default'.
    static let keywords = Self(rawValue: 1 << 1)

    /// If passed, 'deinit' and 'subscript' should be parsed as special names,
    /// not ordinary identifiers.
    static let keywordsUsingSpecialNames: Self = [.keywords, Self(rawValue: 1 << 2)]
    /// If passed, compound names with argument lists are allowed, unless they
    /// have empty argument lists.
    static let compoundNames = Self(rawValue: 1 << 4)

    /// If passed, compound names with empty argument lists are allowed.
    static let zeroArgCompoundNames: Self = [.compoundNames, Self(rawValue: 1 << 5)]
  }

  mutating func parseDeclReferenceExpr(moduleSelector: RawModuleSelectorSyntax?, _ flags: DeclNameOptions = []) -> RawDeclReferenceExprSyntax {
    // Consume the base name.
    let base: RawTokenSyntax
    if let identOrSelf = self.consume(if: .identifier, .keyword(.self), .keyword(.Self))
      ?? self.consume(if: .keyword(.`init`))
    {
      base = identOrSelf
    } else if flags.contains(.operators), let (_, _) = self.at(anyIn: Operator.self) {
      base = self.consumeAnyToken(remapping: .binaryOperator)
    } else if flags.contains(.keywordsUsingSpecialNames),
      let special = self.consume(if: .keyword(.`deinit`), .keyword(.`subscript`))
    {
      base = special
    } else if flags.contains(.keywords) && self.currentToken.isLexerClassifiedKeyword {
      base = self.consumeAnyToken(remapping: .identifier)
    } else {
      base = missingToken(.identifier)
    }

    // Parse an argument list, if the flags allow it and it's present.
    let args = self.parseArgLabelList(flags)
    return RawDeclReferenceExprSyntax(
      moduleSelector: moduleSelector,
      baseName: base,
      argumentNames: args,
      arena: self.arena
    )
  }

  mutating func parseArgLabelList(_ flags: DeclNameOptions) -> RawDeclNameArgumentsSyntax? {
    guard flags.contains(.compoundNames) else {
      return nil
    }

    // Is the current token a left paren?
    guard self.at(TokenSpec(.leftParen, allowAtStartOfLine: false)) else {
      return nil
    }

    // Okay, let's look ahead and see if the next token is something that could
    // be in an arg label list...
    // A close parenthesis, if empty lists are allowed.
    let nextIsRParen = flags.contains(.zeroArgCompoundNames) && peek(isAt: .rightParen)
    // An argument label.
    let nextIsArgLabel = peek().isArgumentLabel() || peek(isAt: .colon)

    guard nextIsRParen || nextIsArgLabel else {
      return nil
    }

    guard self.lookahead().canParseArgumentLabelList() else {
      return nil
    }
    return self.parsePresentArgumentLabelList()
  }

  mutating func parsePresentArgumentLabelList() -> RawDeclNameArgumentsSyntax {
    let (unexpectedBeforeLParen, lparen) = self.expect(.leftParen)
    var elements = [RawDeclNameArgumentSyntax]()
    do {
      var loopProgress = LoopProgressCondition()
      while !self.at(.endOfFile, .rightParen) && self.hasProgressed(&loopProgress) {
        // Check to see if there is an argument label.
        precondition(self.atArgumentLabel(followedByColon: true))
        let name = self.consumeAnyToken()
        let (unexpectedBeforeColon, colon) = self.expect(.colon)
        elements.append(
          RawDeclNameArgumentSyntax(
            name: name,
            unexpectedBeforeColon,
            colon: colon,
            arena: arena
          )
        )
      }
    }
    let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
    return RawDeclNameArgumentsSyntax(
      unexpectedBeforeLParen,
      leftParen: lparen,
      arguments: RawDeclNameArgumentListSyntax(elements: elements, arena: self.arena),
      unexpectedBeforeRParen,
      rightParen: rparen,
      arena: arena
    )
  }
}

extension Parser {
  mutating func parseQualifiedDeclarationName() -> RawExprSyntax {
    let type: RawExprSyntax?
    let period: RawTokenSyntax?

    if self.lookahead().canParseBaseTypeForQualifiedDeclName() {
      type = RawExprSyntax(RawTypeExprSyntax(type: self.parseQualifiedTypeIdentifier(), arena: self.arena))
      period = self.expectWithoutRecovery(prefix: ".", as: .period)
    } else {
      type = nil
      period = nil
    }

    let moduleSelector = self.parseModuleSelector()
    let declName = self.parseDeclReferenceExpr(
      moduleSelector: moduleSelector,
      [.zeroArgCompoundNames, .keywordsUsingSpecialNames, .operators]
    )
    if let period = period {
      return RawExprSyntax(
        RawMemberAccessExprSyntax(
          base: type,
          period: period,
          declName: declName,
          arena: self.arena
        )
      )
    } else {
      return RawExprSyntax(declName)
    }
  }

  mutating func parseQualifiedTypeIdentifier() -> RawTypeSyntax {
    let moduleSelector = self.parseModuleSelector()
    let identifierType = attach(moduleSelector, to: self.parseTypeIdentifier())
    var result = RawTypeSyntax(identifierType)

    // There are no nested types inside `Any`.
    if case TokenSpec.keyword(.Any) = identifierType.name {
      return result
    }

    func hasAnotherMember() -> Bool {
      // If qualified name base type cannot be parsed from the current
      // point (i.e. the next type identifier is not followed by a '.'),
      // then the next identifier is the final declaration name component.
      var lookahead = self.lookahead()
      return lookahead.consume(ifPrefix: ".", as: .period) != nil && lookahead.canParseBaseTypeForQualifiedDeclName()
    }

    guard hasAnotherMember() else {
      return result
    }

    var keepGoing = self.consume(if: .period)
    var loopProgress = LoopProgressCondition()
    while keepGoing != nil && self.hasProgressed(&loopProgress) {
      let memberModuleSelector = self.parseModuleSelector()
      let (unexpectedBeforeName, name) = self.expect(
        .identifier,
        .keyword(.self),
        TokenSpec(.Self, remapping: .identifier),
        default: .identifier
      )
      let generics: RawGenericArgumentClauseSyntax?
      if self.at(prefix: "<") {
        generics = self.parseGenericArguments()
      } else {
        generics = nil
      }
      result = RawTypeSyntax(
        RawMemberTypeSyntax(
          baseType: result,
          period: keepGoing!,
          moduleSelector: memberModuleSelector,
          unexpectedBeforeName,
          name: name,
          genericArgumentClause: generics,
          arena: self.arena
        )
      )

      guard hasAnotherMember() else {
        break
      }

      keepGoing = self.consume(if: .period)
    }

    return result
  }
}

extension Parser.Lookahead {
  func canParseBaseTypeForQualifiedDeclName() -> Bool {
    var lookahead = self.lookahead()
    _ = lookahead.consumeModuleSelectorTokens()
    guard lookahead.canParseTypeIdentifier() else {
      return false
    }
    return lookahead.at(prefix: ".")
  }
}

extension Parser.Lookahead {
  func canParseArgumentLabelList() -> Bool {
    var lookahead = self.lookahead()
    guard lookahead.consume(if: .leftParen) != nil else {
      return false
    }

    var loopProgress = LoopProgressCondition()
    while !lookahead.at(.endOfFile, .rightParen) && lookahead.hasProgressed(&loopProgress) {
      // Check to see if there is an argument label.
      guard lookahead.atArgumentLabel(followedByColon: true) else {
        return false
      }

      lookahead.consumeAnyToken()
      guard lookahead.consume(if: .colon) != nil else {
        return false
      }
    }

    guard lookahead.consume(if: .rightParen) != nil else {
      return false
    }

    return true
  }
}

extension Lexer.Lexeme {
  func isArgumentLabel(allowDollarIdentifier: Bool = false) -> Bool {
    switch self {
    case .identifier, .wildcard:
      // Identifiers, escaped identifiers, and '_' can be argument labels.
      return true
    case .dollarIdentifier:
      return allowDollarIdentifier
    case .keyword(.inout):
      // `inout` cannot be an argument label for historical reasons.
      return false
    default:
      // All other keywords can be argument labels.
      return self.isLexerClassifiedKeyword
    }
  }

  func isContextualPunctuator(_ name: SyntaxText) -> Bool {
    // Currently we can ignore experimental features since a new kind of
    // non-prefix/infix/postfix operator seems unlikely.
    return Operator(lexeme: self, experimentalFeatures: []) != nil && self.tokenText == name
  }

  var isLexerClassifiedKeyword: Bool {
    // Only lexer-classified lexemes have ``RawTokenKind`` of `keyword.
    // Contextual keywords will only be made keywords when a ``RawTokenSyntax`` is
    // constructed from them.
    return self.rawTokenKind == .keyword
  }
}
