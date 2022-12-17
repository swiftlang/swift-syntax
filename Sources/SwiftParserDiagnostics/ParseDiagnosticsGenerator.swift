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

import SwiftDiagnostics
@_spi(LexerDiagnostics) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax

public class ParseDiagnosticsGenerator: SyntaxAnyVisitor {
  private var diagnostics: [Diagnostic] = []

  /// IDs of nodes for which we already generated diagnostics in a parent's visit
  /// method and that should thus not be visited.
  private var handledNodes: [SyntaxIdentifier] = []

  /// When set to `true`, no more diagnostics will be emitted.
  /// Useful to stop any diagnostics after a maximum nesting level overflow was detected.
  private var suppressRemainingDiagnostics: Bool = false

  private init() {
    super.init(viewMode: .all)
  }

  public static func diagnostics<SyntaxType: SyntaxProtocol>(
    for tree: SyntaxType
  ) -> [Diagnostic] {
    let diagProducer = ParseDiagnosticsGenerator()
    diagProducer.walk(tree)
    diagProducer.diagnostics.sort {
      if $0.position != $1.position {
        return $0.position < $1.position
      }

      // Emit children diagnostics before parent diagnostics.
      // This makes sure that for missing declarations with attributes, we emit diagnostics on the attribute before we complain about the missing declaration.
      if $0.node.hasParent($1.node) {
        return true
      } else if $1.node.hasParent($0.node) {
        return false
      } else {
        // If multiple tokens are missing at the same location, emit diagnostics about nodes that occur earlier in the tree first.
        return $0.node.id.indexInTree < $1.node.id.indexInTree
      }
    }
    return diagProducer.diagnostics
  }

  // MARK: - Private helper functions

  /// Produce a diagnostic.
  func addDiagnostic<T: SyntaxProtocol>(
    _ node: T,
    position: AbsolutePosition? = nil,
    _ message: DiagnosticMessage,
    highlights: [Syntax] = [],
    notes: [Note] = [],
    fixIts: [FixIt] = [],
    handledNodes: [SyntaxIdentifier] = []
  ) {
    if suppressRemainingDiagnostics {
      return
    }
    diagnostics.removeAll(where: { handledNodes.contains($0.node.id) })
    diagnostics.append(Diagnostic(node: Syntax(node), position: position, message: message, highlights: highlights, notes: notes, fixIts: fixIts))
    self.handledNodes.append(contentsOf: handledNodes)
  }

  /// Whether the node should be skipped for diagnostic emission.
  /// Every visit method must check this at the beginning.
  func shouldSkip<T: SyntaxProtocol>(_ node: T) -> Bool {
    if !node.hasError {
      return true
    }
    return handledNodes.contains(node.id)
  }

  /// Utility function to emit a diagnostic that removes a misplaced token and instead inserts an equivalent token at the corrected location.
  ///
  /// If `incorrectContainer` contains only tokens that satisfy `unexpectedTokenCondition`, emit a diagnostic with message `message` that marks this token as misplaced.
  /// If `correctTokens` contains missing tokens, also emit a Fix-It with message `fixIt` that marks the unexpected token as missing and instead inserts `correctTokens`.
  public func exchangeTokens<Message: DiagnosticMessage>(
    unexpected: UnexpectedNodesSyntax?,
    unexpectedTokenCondition: (TokenSyntax) -> Bool,
    correctTokens: [TokenSyntax?],
    message: (_ misplacedTokens: [TokenSyntax]) -> Message,
    moveFixIt: (_ misplacedTokens: [TokenSyntax]) -> FixItMessage,
    removeRedundantFixIt: (_ misplacedTokens: [TokenSyntax]) -> FixItMessage? = { _ in nil }
  ) {
    guard let incorrectContainer = unexpected,
      let misplacedTokens = incorrectContainer.onlyTokens(satisfying: unexpectedTokenCondition)
    else {
      // If there are no unexpected nodes or the unexpected contain multiple tokens, don't emit a diagnostic.
      return
    }

    let correctTokens = correctTokens.compactMap({ $0 })

    // Ignore `correctTokens` that are already present.
    let correctAndMissingTokens = correctTokens.filter({ $0.presence == .missing })
    var changes: [FixIt.Changes] = []
    if let misplacedToken = misplacedTokens.only, let correctToken = correctTokens.only,
      misplacedToken.nextToken(viewMode: .all) == correctToken || misplacedToken.previousToken(viewMode: .all) == correctToken
    {
      // We are exchanging two adjacent tokens, transfer the trivia from the incorrect token to the corrected token.
      changes += misplacedTokens.map { FixIt.Changes.makeMissing($0, transferTrivia: false) }
      changes.append(
        FixIt.Changes.makePresent(
          correctToken,
          leadingTrivia: misplacedToken.leadingTrivia,
          trailingTrivia: misplacedToken.trailingTrivia
        )
      )
    } else {
      changes += misplacedTokens.map { FixIt.Changes.makeMissing($0) }
      changes += correctAndMissingTokens.map { FixIt.Changes.makePresent($0) }
    }
    var fixIts: [FixIt] = []
    if changes.count > 1 {
      // Only emit a Fix-It if we are moving a token, i.e. also making a token present.
      fixIts.append(FixIt(message: moveFixIt(misplacedTokens), changes: changes))
    } else if !correctTokens.isEmpty, let removeFixIt = removeRedundantFixIt(misplacedTokens) {
      fixIts.append(FixIt(message: removeFixIt, changes: changes))
    }

    addDiagnostic(incorrectContainer, message(misplacedTokens), fixIts: fixIts, handledNodes: [incorrectContainer.id] + correctAndMissingTokens.map(\.id))
  }

  /// If `unexpected` only contains a single token that satisfies `predicate`,
  /// emits a diagnostic with `message` that removes this token.
  public func removeToken<Message: DiagnosticMessage>(
    _ unexpected: UnexpectedNodesSyntax?,
    where predicate: (TokenSyntax) -> Bool,
    message: (TokenSyntax) -> Message
  ) {
    guard let unexpected = unexpected,
      let misplacedToken = unexpected.onlyToken(where: predicate)
    else {
      // If there is no unexpected node or the unexpected doesn't have the
      // expected token, don't emit a diagnostic.
      return
    }
    let fixit = FixIt(
      message: RemoveNodesFixIt(unexpected),
      changes: .makeMissing(unexpected)
    )
    addDiagnostic(
      unexpected,
      message(misplacedToken),
      fixIts: [fixit],
      handledNodes: [unexpected.id]
    )
  }

  // MARK: - Generic diagnostic generation

  public override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    return .visitChildren
  }

  public override func visit(_ node: UnexpectedNodesSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.allSatisfy({ handledNodes.contains($0.id) }) {
      return .skipChildren
    }
    if node.hasMaximumNestingLevelOverflow {
      addDiagnostic(node, .maximumNestingLevelOverflow)
      suppressRemainingDiagnostics = true
      return .skipChildren
    }
    if let tryKeyword = node.onlyToken(where: { $0.tokenKind == .tryKeyword }),
      let nextToken = tryKeyword.nextToken(viewMode: .sourceAccurate),
      nextToken.tokenKind.isKeyword
    {
      addDiagnostic(node, TryCannotBeUsed(nextToken: nextToken))
    } else if let semicolons = node.onlyTokens(satisfying: { $0.tokenKind == .semicolon }) {
      addDiagnostic(
        node,
        .unexpectedSemicolon,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(semicolons), changes: semicolons.map { FixIt.Changes.makeMissing($0) })
        ]
      )
    } else if node.first?.as(TokenSyntax.self)?.tokenKind.isIdentifier == true,
      let previousToken = node.previousToken(viewMode: .sourceAccurate),
      previousToken.tokenKind.isIdentifier,
      previousToken.parent?.is(DeclSyntax.self) == true
    {
      // If multiple identifiers are used for a declaration name, offer to join them together.
      let tokens =
        node
        .prefix(while: { $0.as(TokenSyntax.self)?.tokenKind.isIdentifier == true })
        .map({ $0.as(TokenSyntax.self)! })
      let joined = previousToken.text + tokens.map(\.text).joined()
      var fixIts: [FixIt] = [
        FixIt(
          message: .joinIdentifiers,
          changes: [
            [.replace(oldNode: Syntax(previousToken), newNode: Syntax(TokenSyntax(.identifier(joined), presence: .present)))],
            .makeMissing(tokens),
          ]
        )
      ]
      if tokens.contains(where: { $0.text.first?.isUppercase == false }) {
        let joinedUsingCamelCase = previousToken.text + tokens.map({ $0.text.withFirstLetterUppercased() }).joined()
        fixIts.append(
          FixIt(
            message: .joinIdentifiersWithCamelCase,
            changes: [
              [.replace(oldNode: Syntax(previousToken), newNode: Syntax(TokenSyntax(.identifier(joinedUsingCamelCase), presence: .present)))],
              .makeMissing(tokens),
            ]
          )
        )
      }
      addDiagnostic(node, SpaceSeparatedIdentifiersError(firstToken: previousToken, additionalTokens: tokens), fixIts: fixIts)
    } else {
      addDiagnostic(node, UnexpectedNodesError(unexpectedNodes: node), highlights: [Syntax(node)])
    }
    return .skipChildren
  }

  public override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.presence == .missing {
      // If there is an unexpected token in front of the identifier, we assume
      // that this unexpected token was intended to be the identifier we are missing.
      if node.tokenKind.isIdentifier,
        let invalidIdentifier = node.previousToken(viewMode: .all),
        let previousParent = invalidIdentifier.parent?.as(UnexpectedNodesSyntax.self)
      {
        let fixIts: [FixIt]
        if invalidIdentifier.tokenKind.isKeyword || invalidIdentifier.tokenKind.isDollarIdentifier {
          fixIts = [
            FixIt(
              message: .wrapInBackticks,
              changes: [
                .replace(
                  oldNode: Syntax(invalidIdentifier),
                  newNode: Syntax(TokenSyntax.identifier("`\(invalidIdentifier.text)`", leadingTrivia: invalidIdentifier.leadingTrivia, trailingTrivia: invalidIdentifier.trailingTrivia))
                )
              ]
            )
          ]
        } else {
          fixIts = []
        }

        addDiagnostic(
          invalidIdentifier,
          InvalidIdentifierError(invalidIdentifier: invalidIdentifier, missingIdentifier: node),
          fixIts: fixIts,
          handledNodes: [previousParent.id]
        )
      } else {
        return handleMissingSyntax(node)
      }
    } else if node.hasError {
      node.syntaxTextBytes.withUnsafeBufferPointer { buf in
        var cursor = Lexer.Cursor(input: buf, previous: 0)
        _ = cursor.nextToken(cursor) { [self] offset, diagnostic in
          self.addDiagnostic(node, position: node.position.advanced(by: offset), diagnostic)
        }
      }
    }
    return .skipChildren
  }

  // MARK: - Specialized diagnostic generation

  public override func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    exchangeTokens(
      unexpected: node.unexpectedAfterArrowToken,
      unexpectedTokenCondition: { $0.tokenKind == .contextualKeyword("async") || $0.tokenKind == .throwsKeyword },
      correctTokens: [node.asyncKeyword, node.throwsToken],
      message: { EffectsSpecifierAfterArrow(effectsSpecifiersAfterArrow: $0) },
      moveFixIt: { MoveTokensInFrontOfFixIt(movedTokens: $0, inFrontOf: .arrow) }
    )
    return .visitChildren
  }

  public override func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // Emit a custom diagnostic for an unexpected '...' after an associatedtype
    // name.
    removeToken(
      node.unexpectedBetweenIdentifierAndInheritanceClause,
      where: { $0.tokenKind == .ellipsis },
      message: { _ in .associatedTypeCannotUsePack }
    )
    return .visitChildren
  }

  public override func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let argument = node.argument, argument.isMissingAllTokens {
      addDiagnostic(
        argument,
        MissingAttributeArgument(attributeName: node.attributeName),
        fixIts: [
          FixIt(message: .insertAttributeArguments, changes: .makePresent(argument))
        ],
        handledNodes: [argument.id]
      )
      return .visitChildren
    }
    return .visitChildren
  }

  public override func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.statements.only?.item.is(EditorPlaceholderExprSyntax.self) == true {
      // Only emit a single diagnostic about the editor placeholder and none for the missing '{' and '}'.
      addDiagnostic(node, .editorPlaceholderInSourceFile, handledNodes: [node.id])
      return .skipChildren
    }
    return .visitChildren
  }

  public override func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let semicolon = node.semicolon, semicolon.presence == .missing {
      if !node.item.hasError {
        // Only diagnose the missing semicolon if the item doesn't contain any errors.
        // If the item contains errors, the root cause is most likely something different and not the missing semicolon.
        let position = semicolon.previousToken(viewMode: .sourceAccurate)?.endPositionBeforeTrailingTrivia
        addDiagnostic(
          semicolon,
          position: position,
          .consecutiveStatementsOnSameLine,
          fixIts: [
            FixIt(message: .insertSemicolon, changes: .makePresentBeforeTrivia(semicolon))
          ],
          handledNodes: [semicolon.id]
        )
      } else {
        handledNodes.append(semicolon.id)
      }
    }
    if let semicolon = node.semicolon, semicolon.presence == .present, node.item.isMissingAllTokens {
      addDiagnostic(
        node,
        .standaloneSemicolonStatement,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(semicolon), changes: .makeMissing(semicolon))
        ],
        handledNodes: [node.item.id]
      )
    }
    if let switchCase = node.unexpectedBeforeItem?.only?.as(SwitchCaseSyntax.self) {
      if switchCase.label.is(SwitchDefaultLabelSyntax.self) {
        addDiagnostic(node, .defaultOutsideOfSwitch)
      } else {
        addDiagnostic(node, .caseOutsideOfSwitchOrEnum)
      }
      return .skipChildren
    }
    return .visitChildren
  }

  public override func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedBetweenDeinitKeywordAndBody,
      let name = unexpected.filter({ $0.as(TokenSyntax.self)?.tokenKind.isIdentifier == true }).only?.as(TokenSyntax.self)
    {
      addDiagnostic(
        name,
        .deinitCannotHaveName,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(name), changes: .makeMissing(name))
        ],
        handledNodes: [name.id]
      )
    }
    if let unexpected = node.unexpectedBetweenDeinitKeywordAndBody,
      let signature = unexpected.compactMap({ $0.as(FunctionSignatureSyntax.self) }).only
    {
      addDiagnostic(
        signature,
        .deinitCannotHaveParameters,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(signature), changes: .makeMissing(signature))
        ],
        handledNodes: [signature.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: ForInStmtSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // Detect C-style for loops based on two semicolons which could not be parsed between the 'for' keyword and the '{'
    // This is mostly a proof-of-concept implementation to produce more complex diagnostics.
    if let unexpectedCondition = node.body.unexpectedBeforeLeftBrace,
      unexpectedCondition.tokens(withKind: .semicolon).count == 2
    {
      // FIXME: This is aweful. We should have a way to either get all children between two cursors in a syntax node or highlight a range from one node to another.
      addDiagnostic(
        node,
        .cStyleForLoop,
        highlights: ([
          Syntax(node.pattern),
          Syntax(node.unexpectedBetweenPatternAndTypeAnnotation),
          Syntax(node.typeAnnotation),
          Syntax(node.unexpectedBetweenTypeAnnotationAndInKeyword),
          Syntax(node.inKeyword),
          Syntax(node.unexpectedBetweenInKeywordAndSequenceExpr),
          Syntax(node.sequenceExpr),
          Syntax(node.unexpectedBetweenSequenceExprAndWhereClause),
          Syntax(node.whereClause),
          Syntax(node.unexpectedBetweenWhereClauseAndBody),
          Syntax(unexpectedCondition),
        ] as [Syntax?]).compactMap({ $0 }),
        handledNodes: [node.inKeyword.id, node.sequenceExpr.id, unexpectedCondition.id]
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: FunctionParameterSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    exchangeTokens(
      unexpected: node.unexpectedBetweenModifiersAndFirstName,
      unexpectedTokenCondition: { TypeSpecifier(token: $0) != nil },
      correctTokens: [node.type?.as(AttributedTypeSyntax.self)?.specifier],
      message: { SpecifierOnParameterName(misplacedSpecifiers: $0) },
      moveFixIt: { MoveTokensInFrontOfTypeFixIt(movedTokens: $0) },
      removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
    )
    return .visitChildren
  }

  public override func visit(_ node: FunctionSignatureSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    exchangeTokens(
      unexpected: node.output?.unexpectedBetweenArrowAndReturnType,
      unexpectedTokenCondition: { $0.tokenKind == .throwsKeyword },
      correctTokens: [node.throwsOrRethrowsKeyword],
      message: { _ in .throwsInReturnPosition },
      moveFixIt: { MoveTokensInFrontOfFixIt(movedTokens: $0, inFrontOf: .arrow) }
    )
    return .visitChildren
  }

  public override func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let inheritedTypeName = node.inheritedType?.as(SimpleTypeIdentifierSyntax.self)?.name {
      exchangeTokens(
        unexpected: node.unexpectedBetweenColonAndInheritedType,
        unexpectedTokenCondition: { $0.tokenKind == .classKeyword },
        correctTokens: [inheritedTypeName],
        message: { _ in StaticParserError.classConstraintCanOnlyBeUsedInProtocol },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacement: inheritedTypeName) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: IdentifierExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.identifier.presence == .missing,
      let unexpected = node.unexpectedBeforeIdentifier,
      unexpected.first?.as(TokenSyntax.self)?.tokenKind == .pound
    {
      addDiagnostic(unexpected, UnknownDirectiveError(unexpected: unexpected), handledNodes: [unexpected.id, node.identifier.id])
    }
    return .visitChildren
  }

  public override func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.equal.presence == .missing {
      exchangeTokens(
        unexpected: node.unexpectedBeforeEqual,
        unexpectedTokenCondition: { $0.tokenKind == .colon },
        correctTokens: [node.equal],
        message: { _ in StaticParserError.initializerInPattern },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacement: node.equal) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: MemberDeclListItemSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let semicolon = node.semicolon, semicolon.presence == .missing {
      if !node.decl.hasError {
        // Only diagnose the missing semicolon if the decl doesn't contain any errors.
        // If the decl contains errors, the root cause is most likely something different and not the missing semicolon.
        let position = semicolon.previousToken(viewMode: .sourceAccurate)?.endPositionBeforeTrailingTrivia
        addDiagnostic(
          semicolon,
          position: position,
          .consecutiveDeclarationsOnSameLine,
          fixIts: [
            FixIt(message: .insertSemicolon, changes: .makePresentBeforeTrivia(semicolon))
          ],
          handledNodes: [semicolon.id]
        )
      } else {
        handledNodes.append(semicolon.id)
      }
    }
    return .visitChildren
  }

  public override func visit(_ node: MissingDeclSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingExprSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingPatternSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingStmtSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: MissingTypeSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node)
  }

  public override func visit(_ node: OperatorDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedAfterOperatorPrecedenceAndTypes,
      unexpected.contains(where: { $0.is(PrecedenceGroupAttributeListSyntax.self) }) == true
    {
      addDiagnostic(
        unexpected,
        .operatorShouldBeDeclaredWithoutBody,
        fixIts: [
          FixIt(message: .removeOperatorBody, changes: .makeMissing(unexpected))
        ],
        handledNodes: [unexpected.id]
      )
    }

    func diagnoseIdentifierInOperatorName(unexpected: UnexpectedNodesSyntax?, name: TokenSyntax) {
      guard let unexpected = unexpected else {
        return
      }
      let message: DiagnosticMessage?
      if let identifier = unexpected.onlyToken(where: { $0.tokenKind.isIdentifier }) {
        message = IdentifierNotAllowedInOperatorName(identifier: identifier)
      } else if let tokens = unexpected.onlyTokens(satisfying: { _ in true }) {
        message = TokensNotAllowedInOperatorName(tokens: tokens)
      } else {
        message = nil
      }
      if let message = message {
        let fixIts: [FixIt]
        if node.identifier.presence == .present {
          fixIts = [FixIt(message: RemoveNodesFixIt(unexpected), changes: .makeMissing(unexpected))]
        } else {
          fixIts = []
        }
        addDiagnostic(unexpected, message, highlights: [Syntax(unexpected)], fixIts: fixIts, handledNodes: [unexpected.id, node.identifier.id])
      }
    }

    diagnoseIdentifierInOperatorName(unexpected: node.unexpectedBetweenOperatorKeywordAndIdentifier, name: node.identifier)
    diagnoseIdentifierInOperatorName(unexpected: node.unexpectedBetweenIdentifierAndOperatorPrecedenceAndTypes, name: node.identifier)

    return .visitChildren
  }

  public override func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedBetweenColonAndFlag ?? node.unexpectedAfterFlag, node.flag.presence == .missing {
      addDiagnostic(unexpected, .invalidFlagAfterPrecedenceGroupAssignment, handledNodes: [unexpected.id, node.flag.id])
    }
    return .visitChildren
  }

  public override func visit(_ node: ReturnStmtSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.expression != nil {
      exchangeTokens(
        unexpected: node.unexpectedBeforeReturnKeyword,
        unexpectedTokenCondition: { $0.tokenKind == .tryKeyword },
        correctTokens: [node.expression?.as(TryExprSyntax.self)?.tryKeyword],
        message: { _ in .tryMustBePlacedOnReturnedExpr },
        moveFixIt: { MoveTokensAfterFixIt(movedTokens: $0, after: .returnKeyword) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let extraneous = node.unexpectedBetweenStatementsAndEOFToken, !extraneous.isEmpty {
      addDiagnostic(extraneous, ExtaneousCodeAtTopLevel(extraneousCode: extraneous), handledNodes: [extraneous.id])
    }
    return .visitChildren
  }

  public override func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedBetweenSubscriptKeywordAndGenericParameterClause,
      let nameTokens = unexpected.onlyTokens(satisfying: { !$0.tokenKind.isKeyword })
    {
      addDiagnostic(
        unexpected,
        .subscriptsCannotHaveNames,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(nameTokens), changes: .makeMissing(nameTokens))
        ],
        handledNodes: [unexpected.id]
      )
    }
    if let unexpected = node.indices.unexpectedBeforeLeftParen,
      let nameTokens = unexpected.onlyTokens(satisfying: { !$0.tokenKind.isKeyword })
    {
      addDiagnostic(
        unexpected,
        .subscriptsCannotHaveNames,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(nameTokens), changes: .makeMissing(nameTokens))
        ],
        handledNodes: [unexpected.id]
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.unknownAttr?.isMissingAllTokens != false && node.label.isMissingAllTokens {
      addDiagnostic(
        node.statements,
        .allStatmentsInSwitchMustBeCoveredByCase,
        fixIts: [
          FixIt(message: InsertTokenFixIt(missingNodes: [Syntax(node.label)]), changes: .makePresent(node.label, leadingTrivia: .newline))
        ],
        handledNodes: [node.label.id]
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: SwitchDefaultLabelSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedBetweenDefaultKeywordAndColon, unexpected.first?.as(TokenSyntax.self)?.tokenKind == .whereKeyword {
      addDiagnostic(unexpected, .defaultCannotBeUsedWithWhere, handledNodes: [unexpected.id])
    }
    return .visitChildren
  }

  public override func visit(_ node: ThrowStmtSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    exchangeTokens(
      unexpected: node.unexpectedBeforeThrowKeyword,
      unexpectedTokenCondition: { $0.tokenKind == .tryKeyword },
      correctTokens: [node.expression.as(TryExprSyntax.self)?.tryKeyword],
      message: { _ in .tryMustBePlacedOnThrownExpr },
      moveFixIt: { MoveTokensAfterFixIt(movedTokens: $0, after: .throwKeyword) }
    )
    return .visitChildren
  }

  public override func visit(_ node: TryExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.expression.is(MissingExprSyntax.self) {
      addDiagnostic(
        node.expression,
        .expectedExpressionAfterTry,
        fixIts: [
          FixIt(message: InsertTokenFixIt(missingNodes: [Syntax(node.expression)]), changes: .makePresent(node.expression))
        ],
        handledNodes: [node.expression.id]
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: TupleTypeElementSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    exchangeTokens(
      unexpected: node.unexpectedBetweenInOutAndName,
      unexpectedTokenCondition: { TypeSpecifier(token: $0) != nil },
      correctTokens: [node.type.as(AttributedTypeSyntax.self)?.specifier],
      message: { SpecifierOnParameterName(misplacedSpecifiers: $0) },
      moveFixIt: { MoveTokensInFrontOfTypeFixIt(movedTokens: $0) },
      removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
    )
    return .visitChildren
  }

  public override func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.equal.presence == .missing {
      exchangeTokens(
        unexpected: node.unexpectedBeforeEqual,
        unexpectedTokenCondition: { $0.tokenKind == .colon },
        correctTokens: [node.equal],
        message: { _ in MissingNodesError(missingNodes: [Syntax(node.equal)]) },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacement: node.equal) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: UnresolvedTernaryExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.colonMark.presence == .missing {
      if let siblings = node.parent?.children(viewMode: .all),
        let nextSibling = siblings[siblings.index(after: node.index)...].first,
        nextSibling.is(MissingExprSyntax.self)
      {
        addDiagnostic(
          node.colonMark,
          .missingColonAndExprInTernaryExpr,
          fixIts: [
            FixIt(
              message: InsertTokenFixIt(missingNodes: [Syntax(node.colonMark), Syntax(nextSibling)]),
              changes: [
                .makePresent(node.colonMark),
                .makePresent(nextSibling),
              ]
            )
          ],
          handledNodes: [node.colonMark.id, nextSibling.id]
        )
      } else {
        addDiagnostic(
          node.colonMark,
          .missingColonInTernaryExpr,
          fixIts: [
            FixIt(message: InsertTokenFixIt(missingNodes: [Syntax(node.colonMark)]), changes: .makePresent(node.colonMark))
          ],
          handledNodes: [node.colonMark.id]
        )
      }
    }
    return .visitChildren
  }

  public override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    let missingTries = node.bindings.compactMap({
      return $0.initializer?.value.as(TryExprSyntax.self)?.tryKeyword
    })
    exchangeTokens(
      unexpected: node.unexpectedBetweenModifiersAndLetOrVarKeyword,
      unexpectedTokenCondition: { $0.tokenKind == .tryKeyword },
      correctTokens: missingTries,
      message: { _ in .tryOnInitialValueExpression },
      moveFixIt: { MoveTokensAfterFixIt(movedTokens: $0, after: .equal) },
      removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
    )
    return .visitChildren
  }

  //==========================================================================//
  // IMPORTANT: If you are tempted to add a `visit` method here, please       //
  // insert it in alphabetical order above                                    //
  //==========================================================================//
}
