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

import SwiftDiagnostics
@_spi(Diagnostics) import SwiftParser
@_spi(RawSyntax) import SwiftSyntax

fileprivate extension TokenSyntax {
  /// Assuming this token is a `poundAvailableKeyword` or `poundUnavailableKeyword`
  /// returns the opposite keyword.
  var negatedAvailabilityKeyword: TokenSyntax {
    switch self.tokenKind {
    case .poundAvailableKeyword:
      return self.with(\.tokenKind, .poundUnavailableKeyword)
    case .poundUnavailableKeyword:
      return self.with(\.tokenKind, .poundAvailableKeyword)
    default:
      preconditionFailure("The availability token of an AvailabilityConditionSyntax should always be #available or #unavailable")
    }
  }
}

fileprivate extension DiagnosticSeverity {
  func matches(_ lexerErorSeverity: SwiftSyntax.TokenDiagnostic.Severity) -> Bool {
    switch (self, lexerErorSeverity) {
    case (.error, .error):
      return true
    case (.warning, .warning):
      return true
    default:
      return false
    }
  }
}

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
  /// If `highlights` is `nil` the `node` will be highlighted.
  func addDiagnostic<T: SyntaxProtocol>(
    _ node: T,
    position: AbsolutePosition? = nil,
    _ message: DiagnosticMessage,
    highlights: [Syntax]? = nil,
    notes: [Note] = [],
    fixIts: [FixIt] = [],
    handledNodes: [SyntaxIdentifier] = []
  ) {
    let diagnostic = Diagnostic(node: Syntax(node), position: position, message: message, highlights: highlights, notes: notes, fixIts: fixIts)
    addDiagnostic(diagnostic, handledNodes: handledNodes)
  }

  /// Produce a diagnostic.
  func addDiagnostic(
    _ diagnostic: Diagnostic,
    handledNodes: [SyntaxIdentifier] = []
  ) {
    if suppressRemainingDiagnostics {
      return
    }
    diagnostics.removeAll(where: { handledNodes.contains($0.node.id) })
    diagnostics.append(diagnostic)
    self.handledNodes.append(contentsOf: handledNodes)
  }

  /// Whether the node should be skipped for diagnostic emission.
  /// Every visit method must check this at the beginning.
  func shouldSkip<T: SyntaxProtocol>(_ node: T) -> Bool {
    if !node.hasError && !node.hasWarning {
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
      let misplacedTokens = incorrectContainer.onlyPresentTokens(satisfying: unexpectedTokenCondition)
    else {
      // If there are no unexpected nodes or the unexpected contain multiple tokens, don't emit a diagnostic.
      return
    }

    let correctTokens = correctTokens.compactMap({ $0 })

    // Ignore `correctTokens` that are already present.
    let correctAndMissingTokens = correctTokens.filter({ $0.presence == .missing })
    var changes: [FixIt.MultiNodeChange] = []
    if let misplacedToken = misplacedTokens.only, let correctToken = correctTokens.only,
      misplacedToken.nextToken(viewMode: .all) == correctToken || misplacedToken.previousToken(viewMode: .all) == correctToken,
      correctToken.presence == .missing
    {
      // We are exchanging two adjacent tokens, transfer the trivia from the incorrect token to the corrected token.
      changes += misplacedTokens.map { FixIt.MultiNodeChange.makeMissing($0, transferTrivia: false) }
      changes.append(
        FixIt.MultiNodeChange.makePresent(
          correctToken,
          leadingTrivia: misplacedToken.leadingTrivia,
          trailingTrivia: misplacedToken.trailingTrivia
        )
      )
    } else {
      changes += misplacedTokens.map { FixIt.MultiNodeChange.makeMissing($0) }
      changes += correctAndMissingTokens.map { FixIt.MultiNodeChange.makePresent($0) }
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
      let misplacedToken = unexpected.onlyPresentToken(where: predicate)
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

  private func handleMisplacedEffectSpecifiersAfterArrow<S: EffectSpecifiersSyntax>(effectSpecifiers: S?, misplacedSpecifiers: UnexpectedNodesSyntax?) {
    exchangeTokens(
      unexpected: misplacedSpecifiers,
      unexpectedTokenCondition: { EffectSpecifier(token: $0) != nil },
      correctTokens: [effectSpecifiers?.throwsSpecifier, effectSpecifiers?.asyncSpecifier],
      message: { EffectsSpecifierAfterArrow(effectsSpecifiersAfterArrow: $0) },
      moveFixIt: { MoveTokensInFrontOfFixIt(movedTokens: $0, inFrontOf: .arrow) },
      removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
    )
  }

  private func handleMisplacedEffectSpecifiers<S: EffectSpecifiersSyntax>(effectSpecifiers: S?, output: ReturnClauseSyntax?) {
    handleMisplacedEffectSpecifiersAfterArrow(effectSpecifiers: effectSpecifiers, misplacedSpecifiers: output?.unexpectedBetweenArrowAndReturnType)
    handleMisplacedEffectSpecifiersAfterArrow(effectSpecifiers: effectSpecifiers, misplacedSpecifiers: output?.unexpectedAfterReturnType)
  }

  private func handleEffectSpecifiers<S: EffectSpecifiersSyntax>(_ node: S) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    let specifierInfo = [
      (node.asyncSpecifier, { AsyncEffectSpecifier(token: $0) != nil }, StaticParserError.misspelledAsync),
      (node.throwsSpecifier, { ThrowsEffectSpecifier(token: $0) != nil }, StaticParserError.misspelledThrows),
    ]

    let unexpectedNodes = [node.unexpectedBeforeAsyncSpecifier, node.unexpectedBetweenAsyncSpecifierAndThrowsSpecifier, node.unexpectedAfterThrowsSpecifier]

    // Diagnostics that are emitted later silence previous diagnostics, so check
    // for the most contextual (and thus helpful) diagnostics last.

    for (specifier, isOfSameKind, misspelledError) in specifierInfo {
      guard let specifier = specifier else {
        continue
      }
      for unexpected in unexpectedNodes {
        exchangeTokens(
          unexpected: unexpected,
          unexpectedTokenCondition: isOfSameKind,
          correctTokens: [specifier],
          message: { _ in misspelledError },
          moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacement: specifier) },
          removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
        )
      }
    }

    if let throwsSpecifier = node.throwsSpecifier {
      exchangeTokens(
        unexpected: node.unexpectedAfterThrowsSpecifier,
        unexpectedTokenCondition: { AsyncEffectSpecifier(token: $0) != nil },
        correctTokens: [node.asyncSpecifier],
        message: { AsyncMustPrecedeThrows(asyncKeywords: $0, throwsKeyword: throwsSpecifier) },
        moveFixIt: { MoveTokensInFrontOfFixIt(movedTokens: $0, inFrontOf: throwsSpecifier.tokenKind) },
        removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
      )
    }

    for (specifier, isOfSameKind, _) in specifierInfo {
      guard let specifier = specifier else {
        continue
      }
      if specifier.presence == .present {
        for case .some(let unexpected) in unexpectedNodes {
          for duplicateSpecifier in unexpected.presentTokens(satisfying: isOfSameKind) {
            addDiagnostic(
              duplicateSpecifier,
              DuplicateEffectSpecifiers(correctSpecifier: specifier, unexpectedSpecifier: duplicateSpecifier),
              notes: [Note(node: Syntax(specifier), message: EffectSpecifierDeclaredHere(specifier: specifier))],
              fixIts: [FixIt(message: RemoveRedundantFixIt(removeTokens: [duplicateSpecifier]), changes: [.makeMissing(duplicateSpecifier)])],
              handledNodes: [unexpected.id]
            )
          }
        }
      }
    }
    return .visitChildren
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
    if let tryKeyword = node.onlyPresentToken(where: { $0.tokenKind == .keyword(.try) }),
      let nextToken = tryKeyword.nextToken(viewMode: .sourceAccurate),
      nextToken.tokenKind.isLexerClassifiedKeyword,
      !(node.parent?.is(TypeEffectSpecifiersSyntax.self) ?? false)
    {
      addDiagnostic(node, TryCannotBeUsed(nextToken: nextToken))
    } else if let semicolons = node.onlyPresentTokens(satisfying: { $0.tokenKind == .semicolon }) {
      addDiagnostic(
        node,
        .unexpectedSemicolon,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(semicolons), changes: semicolons.map { FixIt.MultiNodeChange.makeMissing($0) })
        ]
      )
    } else if let firstToken = node.first?.as(TokenSyntax.self),
      firstToken.tokenKind.isIdentifier == true,
      firstToken.presence == .present,
      let previousToken = node.previousToken(viewMode: .sourceAccurate),
      previousToken.tokenKind.isIdentifier,
      previousToken.parent?.is(DeclSyntax.self) == true || previousToken.parent?.is(IdentifierPatternSyntax.self) == true
    {
      // If multiple identifiers are used for a declaration name, offer to join them together.
      let tokens =
        node
        .prefix(while: {
          guard let token = $0.as(TokenSyntax.self) else {
            return false
          }
          return token.tokenKind.isIdentifier == true && token.presence == .present
        })
        .map({ $0.as(TokenSyntax.self)! })
      let joined = previousToken.text + tokens.map(\.text).joined()
      var fixIts: [FixIt] = [
        FixIt(
          message: .joinIdentifiers,
          changes: [
            FixIt.MultiNodeChange(.replace(oldNode: Syntax(previousToken), newNode: Syntax(TokenSyntax(.identifier(joined), trailingTrivia: tokens.last?.trailingTrivia ?? [], presence: .present)))),
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
              FixIt.MultiNodeChange(.replace(oldNode: Syntax(previousToken), newNode: Syntax(TokenSyntax(.identifier(joinedUsingCamelCase), trailingTrivia: tokens.last?.trailingTrivia ?? [], presence: .present)))),
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

  public override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(token) {
      return .skipChildren
    }

    if token.presence == .missing {
      handleMissingToken(token)
    } else {
      if let tokenDiagnostic = token.tokenDiagnostic {
        let message = tokenDiagnostic.diagnosticMessage(in: token)
        precondition(message.severity.matches(tokenDiagnostic.severity))
        self.addDiagnostic(
          token,
          position: token.position.advanced(by: Int(tokenDiagnostic.byteOffset)),
          message,
          fixIts: tokenDiagnostic.fixIts(in: token)
        )
      }
    }

    return .skipChildren
  }

  // MARK: - Specialized diagnostic generation

  public override func visit(_ node: ArrowExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    handleMisplacedEffectSpecifiersAfterArrow(effectSpecifiers: node.effectSpecifiers, misplacedSpecifiers: node.unexpectedAfterArrowToken)

    return .visitChildren
  }

  public override func visit(_ node: AccessorEffectSpecifiersSyntax) -> SyntaxVisitorContinueKind {
    return handleEffectSpecifiers(node)
  }

  public override func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // Emit a custom diagnostic for an unexpected 'each' before an associatedtype
    // name.
    removeToken(
      node.unexpectedBetweenAssociatedtypeKeywordAndIdentifier,
      where: { $0.tokenKind == .keyword(.each) },
      message: { _ in .associatedTypeCannotUsePack }
    )
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

  public override func visit(_ node: AvailabilityArgumentSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let trailingComma = node.trailingComma {
      exchangeTokens(
        unexpected: node.unexpectedBetweenEntryAndTrailingComma,
        unexpectedTokenCondition: { $0.text == "||" },
        correctTokens: [node.trailingComma],
        message: { _ in .joinPlatformsUsingComma },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacement: trailingComma) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: AvailabilityVersionRestrictionSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedBetweenPlatformAndVersion,
      unexpected.onlyPresentToken(where: { $0.tokenKind == .binaryOperator(">=") }) != nil
    {
      addDiagnostic(
        unexpected,
        .versionComparisonNotNeeded,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(unexpected), changes: .makeMissing(unexpected))
        ],
        handledNodes: [unexpected.id]
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: ConditionElementSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let trailingComma = node.trailingComma {
      exchangeTokens(
        unexpected: node.unexpectedBetweenConditionAndTrailingComma,
        unexpectedTokenCondition: { $0.text == "&&" },
        correctTokens: [node.trailingComma],
        message: { _ in .joinConditionsUsingComma },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacement: trailingComma) }
      )
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

  public override func visit(_ node: ClosureSignatureSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    handleMisplacedEffectSpecifiers(effectSpecifiers: node.effectSpecifiers, output: node.output)
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
            FixIt(message: .insertSemicolon, changes: .makePresent(semicolon))
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

  public override func visit(_ node: FunctionEffectSpecifiersSyntax) -> SyntaxVisitorContinueKind {
    return handleEffectSpecifiers(node)
  }

  public override func visit(_ node: GenericRequirementSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpected = node.unexpectedBetweenBodyAndTrailingComma,
      let token = unexpected.presentTokens(satisfying: { $0.tokenKind == .binaryOperator("&&") }).first,
      let trailingComma = node.trailingComma,
      trailingComma.presence == .missing,
      let previous = node.unexpectedBetweenBodyAndTrailingComma?.previousToken(viewMode: .sourceAccurate)
    {

      addDiagnostic(
        unexpected,
        .expectedCommaInWhereClause,
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(replaceTokens: [token], replacement: .commaToken()),
            changes: [
              .makeMissing(token),
              .makePresent(trailingComma),
              FixIt.MultiNodeChange(.replaceTrailingTrivia(token: previous, newTrivia: [])),
            ]
          )
        ],
        handledNodes: [unexpected.id, trailingComma.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: DeinitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedBetweenDeinitKeywordAndBody,
      let name = unexpected.presentTokens(satisfying: { $0.tokenKind.isIdentifier == true }).only?.as(TokenSyntax.self)
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
      unexpectedCondition.presentTokens(withKind: .semicolon).count == 2
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
    } else {  // If it's not a C-style for loop
      if node.sequenceExpr.is(MissingExprSyntax.self) {
        addDiagnostic(node.sequenceExpr, .expectedSequenceExpressionInForEachLoop, handledNodes: [node.sequenceExpr.id])
      }
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
      correctTokens: [node.type.as(AttributedTypeSyntax.self)?.specifier],
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
    handleMisplacedEffectSpecifiers(effectSpecifiers: node.effectSpecifiers, output: node.output)
    return .visitChildren
  }

  public override func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    handleMisplacedEffectSpecifiers(effectSpecifiers: node.effectSpecifiers, output: node.output)
    return .visitChildren
  }

  public override func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // Emit a custom diagnostic for an unexpected '...' after the type name.
    if node.each?.presence == .present {
      removeToken(
        node.unexpectedBetweenNameAndColon,
        where: { $0.tokenKind == .ellipsis },
        message: { _ in .typeParameterPackEllipsis }
      )
    } else if let unexpected = node.unexpectedBetweenNameAndColon,
      let unexpectedEllipsis = unexpected.onlyPresentToken(where: { $0.tokenKind == .ellipsis }),
      let each = node.each
    {
      addDiagnostic(
        unexpected,
        .typeParameterPackEllipsis,
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(replaceTokens: [unexpectedEllipsis], replacement: .keyword(.each)),
            changes: [
              .makeMissing(unexpected),
              .makePresent(each, trailingTrivia: .space),
            ]
          )
        ],
        handledNodes: [unexpected.id, each.id]
      )
    }
    if let inheritedTypeName = node.inheritedType?.as(SimpleTypeIdentifierSyntax.self)?.name {
      exchangeTokens(
        unexpected: node.unexpectedBetweenColonAndInheritedType,
        unexpectedTokenCondition: { $0.tokenKind == .keyword(.class) },
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
    if node.identifier.presence == .missing, let unexpected = node.unexpectedBeforeIdentifier {
      if unexpected.first?.as(TokenSyntax.self)?.tokenKind == .pound {
        addDiagnostic(unexpected, UnknownDirectiveError(unexpected: unexpected), handledNodes: [unexpected.id, node.identifier.id])
      } else if let availability = unexpected.first?.as(AvailabilityConditionSyntax.self) {
        if let prefixOperatorExpr = node.parent?.as(PrefixOperatorExprSyntax.self),
          let operatorToken = prefixOperatorExpr.operatorToken,
          operatorToken.text == "!",
          let conditionElement = prefixOperatorExpr.parent?.as(ConditionElementSyntax.self)
        {
          // Diagnose !#available(...) and !#unavailable(...)

          let negatedAvailabilityKeyword = availability.availabilityKeyword.negatedAvailabilityKeyword
          let negatedCoditionElement = ConditionElementSyntax(
            condition: .availability(availability.with(\.availabilityKeyword, negatedAvailabilityKeyword)),
            trailingComma: conditionElement.trailingComma
          )
          addDiagnostic(
            unexpected,
            NegatedAvailabilityCondition(avaialabilityCondition: availability, negatedAvailabilityKeyword: negatedAvailabilityKeyword),
            fixIts: [
              FixIt(
                message: ReplaceTokensFixIt(replaceTokens: [operatorToken, availability.availabilityKeyword], replacement: negatedAvailabilityKeyword),
                changes: [
                  .replace(oldNode: Syntax(conditionElement), newNode: Syntax(negatedCoditionElement))
                ]
              )
            ],
            handledNodes: [unexpected.id, node.identifier.id]
          )
        } else {
          addDiagnostic(unexpected, AvailabilityConditionInExpression(availabilityCondition: availability), handledNodes: [unexpected.id, node.identifier.id])
        }
      }
    }
    return .visitChildren
  }

  public override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    for clause in node.clauses where clause.hasError {
      if let unexpectedBeforePoundKeyword = clause.unexpectedBeforePoundKeyword,
        clause.poundKeyword.tokenKind == .poundElseifKeyword,
        clause.poundKeyword.presence == .missing
      {
        let unexpectedTokens =
          unexpectedBeforePoundKeyword
          .suffix(2)
          .compactMap { $0.as(TokenSyntax.self) }
        if unexpectedTokens.map(\.tokenKind) == [.poundElseKeyword, .keyword(.if)] {
          addDiagnostic(
            unexpectedBeforePoundKeyword,
            StaticParserError.unexpectedPoundElseSpaceIf,
            fixIts: [
              FixIt(
                message: ReplaceTokensFixIt(replaceTokens: unexpectedTokens, replacement: clause.poundKeyword),
                changes: [
                  .makeMissing(unexpectedBeforePoundKeyword, transferTrivia: false),
                  .makePresent(clause.poundKeyword, leadingTrivia: unexpectedBeforePoundKeyword.leadingTrivia),
                ]
              )
            ],
            handledNodes: [unexpectedBeforePoundKeyword.id, clause.poundKeyword.id]
          )
        }
      }
    }
    return .visitChildren
  }

  public override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if node.conditions.count == 1, node.conditions.first?.as(ConditionElementSyntax.self)?.condition.is(MissingExprSyntax.self) == true, !node.body.leftBrace.isMissingAllTokens {
      addDiagnostic(node.conditions, MissingConditionInStatement(node: node), handledNodes: [node.conditions.id])
    }

    if let leftBrace = node.elseBody?.as(CodeBlockSyntax.self)?.leftBrace, leftBrace.presence == .missing {
      addDiagnostic(leftBrace, .expectedLeftBraceOrIfAfterElse, handledNodes: [leftBrace.id])
    }

    return .visitChildren
  }

  public override func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpected = node.unexpectedBeforeEqual,
      unexpected.first?.as(TokenSyntax.self)?.tokenKind == .binaryOperator("==")
    {
      addDiagnostic(
        unexpected,
        .expectedAssignmentInsteadOfComparisonOperator,
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(replaceTokens: [.binaryOperator("==")], replacement: node.equal),
            changes: [.makeMissing(unexpected), .makePresent(node.equal, leadingTrivia: [])]
          )
        ],
        handledNodes: [unexpected.id, node.equal.id]
      )
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

  public override func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpectedName = node.signature.input.unexpectedBeforeLeftParen,
      let previous = unexpectedName.previousToken(viewMode: .sourceAccurate)
    {
      addDiagnostic(
        unexpectedName,
        .initializerCannotHaveName,
        fixIts: [
          FixIt(
            message: RemoveNodesFixIt(unexpectedName),
            changes: [
              .makeMissing(unexpectedName),
              FixIt.MultiNodeChange(.replaceTrailingTrivia(token: previous, newTrivia: [])),
            ]
          )
        ],
        handledNodes: [unexpectedName.id]
      )
    }

    if let unexpectedOutput = node.signature.unexpectedAfterOutput {
      addDiagnostic(
        unexpectedOutput,
        .initializerCannotHaveResultType,
        handledNodes: [unexpectedOutput.id]
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
            FixIt(message: .insertSemicolon, changes: .makePresent(semicolon))
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
    return handleMissingSyntax(node, additionalHandledNodes: [node.placeholder.id])
  }

  public override func visit(_ node: MissingExprSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node, additionalHandledNodes: [node.placeholder.id])
  }

  public override func visit(_ node: MissingPatternSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node, additionalHandledNodes: [node.placeholder.id])
  }

  public override func visit(_ node: MissingStmtSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node, additionalHandledNodes: [node.placeholder.id])
  }

  public override func visit(_ node: MissingSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node, additionalHandledNodes: [node.placeholder.id])
  }

  public override func visit(_ node: MissingTypeSyntax) -> SyntaxVisitorContinueKind {
    return handleMissingSyntax(node, additionalHandledNodes: [node.placeholder.id])
  }

  override open func visit(_ node: OriginallyDefinedInArgumentsSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let token = node.unexpectedBetweenModuleLabelAndColon?.onlyPresentToken(where: { $0.tokenKind.isIdentifier }),
      node.moduleLabel.presence == .missing
    {
      addDiagnostic(
        node,
        MissingNodesError(missingNodes: [Syntax(node.moduleLabel)]),
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(
              replaceTokens: [token],
              replacement: node.moduleLabel
            ),
            changes: [
              FixIt.MultiNodeChange.makeMissing(token),
              FixIt.MultiNodeChange.makePresent(node.moduleLabel),
            ]
          )
        ],
        handledNodes: [node.moduleLabel.id, token.id]
      )
    }

    return .visitChildren
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
      if let identifier = unexpected.onlyPresentToken(where: { $0.tokenKind.isIdentifier }) {
        message = IdentifierNotAllowedInOperatorName(identifier: identifier)
      } else if let tokens = unexpected.onlyPresentTokens(satisfying: { _ in true }) {
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

  public override func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.value.presence == .missing {
      addDiagnostic(
        Syntax(node.unexpectedBetweenColonAndValue) ?? Syntax(node.value),
        .invalidPrecedenceGroupAssociativity,
        handledNodes: [node.unexpectedBetweenColonAndValue?.id, node.value.id].compactMap({ $0 })
      )
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
        unexpectedTokenCondition: { $0.tokenKind == .keyword(.try) },
        correctTokens: [node.expression?.as(TryExprSyntax.self)?.tryKeyword],
        message: { _ in .tryMustBePlacedOnReturnedExpr },
        moveFixIt: { MoveTokensAfterFixIt(movedTokens: $0, after: .keyword(.return)) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.equalityToken.presence == .missing && node.rightTypeIdentifier.isMissingAllTokens {
      addDiagnostic(
        node.equalityToken,
        .missingConformanceRequirement,
        handledNodes: [node.equalityToken.id, node.rightTypeIdentifier.id]
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

  public override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let singleQuote = node.unexpectedBetweenOpenDelimiterAndOpenQuote?.onlyPresentToken(where: { $0.tokenKind == .singleQuote }) {
      let fixIt = FixIt(
        message: ReplaceTokensFixIt(replaceTokens: [singleQuote], replacement: node.openQuote),
        changes: [
          .makeMissing(singleQuote, transferTrivia: false),
          .makePresent(node.openQuote, leadingTrivia: singleQuote.leadingTrivia),
          .makeMissing(node.unexpectedBetweenSegmentsAndCloseQuote, transferTrivia: false),
          .makePresent(node.closeQuote, trailingTrivia: node.unexpectedBetweenSegmentsAndCloseQuote?.trailingTrivia ?? []),
        ]
      )
      addDiagnostic(
        singleQuote,
        .singleQuoteStringLiteral,
        fixIts: [fixIt],
        handledNodes: [
          node.unexpectedBetweenOpenDelimiterAndOpenQuote?.id,
          node.openQuote.id,
          node.unexpectedBetweenSegmentsAndCloseQuote?.id,
          node.closeQuote.id,
        ].compactMap { $0 }
      )
    }
    for (diagnostic, handledNodes) in MultiLineStringLiteralIndentatinDiagnosticsGenerator.diagnose(node) {
      addDiagnostic(diagnostic, handledNodes: handledNodes)
    }
    if case .stringSegment(let segment) = node.segments.last {
      if let invalidContent = segment.unexpectedBeforeContent?.onlyPresentToken(where: { $0.trailingTrivia.contains(where: { $0.isBackslash }) }) {
        let fixIt = FixIt(
          message: .removeBackslash,
          changes: [
            .makePresent(segment.content),
            .makeMissing(invalidContent, transferTrivia: false),
          ]
        )
        addDiagnostic(
          invalidContent,
          position: invalidContent.endPositionBeforeTrailingTrivia,
          .escapedNewlineAtLatlineOfMultiLineStringLiteralNotAllowed,
          fixIts: [fixIt],
          handledNodes: [segment.id]
        )
      }
    }
    return .visitChildren
  }

  public override func visit(_ node: SubscriptDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedBetweenSubscriptKeywordAndGenericParameterClause,
      let nameTokens = unexpected.onlyPresentTokens(satisfying: { !$0.tokenKind.isLexerClassifiedKeyword })
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
      let nameTokens = unexpected.onlyPresentTokens(satisfying: { !$0.tokenKind.isLexerClassifiedKeyword })
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

  public override func visit(_ node: SwitchExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if node.expression.is(MissingExprSyntax.self) && !node.cases.isEmpty {
      addDiagnostic(node.expression, MissingExpressionInStatement(node: node), handledNodes: [node.expression.id])
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
    if let unexpected = node.unexpectedBetweenDefaultKeywordAndColon, unexpected.first?.as(TokenSyntax.self)?.tokenKind == .keyword(.where) {
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
      unexpectedTokenCondition: { $0.tokenKind == .keyword(.try) },
      correctTokens: [node.expression.as(TryExprSyntax.self)?.tryKeyword],
      message: { _ in .tryMustBePlacedOnThrownExpr },
      moveFixIt: { MoveTokensAfterFixIt(movedTokens: $0, after: .keyword(.throw)) }
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

  public override func visit(_ node: TypeEffectSpecifiersSyntax) -> SyntaxVisitorContinueKind {
    return handleEffectSpecifiers(node)
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

  public override func visit(_ node: UnavailableFromAsyncArgumentsSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let token = node.unexpectedBetweenMessageLabelAndColon?.onlyPresentToken(where: { $0.tokenKind.isIdentifier }),
      token.presence == .present,
      node.messageLabel.presence == .missing
    {
      addDiagnostic(
        node,
        MissingNodesError(missingNodes: [Syntax(node.messageLabel)]),
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(
              replaceTokens: [token],
              replacement: node.messageLabel
            ),
            changes: [
              FixIt.MultiNodeChange.makeMissing(token),
              FixIt.MultiNodeChange.makePresent(node.messageLabel),
            ]
          )
        ],
        handledNodes: [node.messageLabel.id, token.id]
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
      unexpected: node.unexpectedBetweenModifiersAndBindingKeyword,
      unexpectedTokenCondition: { $0.tokenKind == .keyword(.try) },
      correctTokens: missingTries,
      message: { _ in .tryOnInitialValueExpression },
      moveFixIt: { MoveTokensAfterFixIt(movedTokens: $0, after: .equal) },
      removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
    )
    return .visitChildren
  }

  public override func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if node.conditions.count == 1, node.conditions.first?.as(ConditionElementSyntax.self)?.condition.is(MissingExprSyntax.self) == true, !node.body.leftBrace.isMissingAllTokens {
      addDiagnostic(node.conditions, MissingConditionInStatement(node: node), handledNodes: [node.conditions.id])
    }

    return .visitChildren
  }

  //==========================================================================//
  // IMPORTANT: If you are tempted to add a `visit` method here, please       //
  // insert it in alphabetical order above                                    //
  //==========================================================================//
}
