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
public import SwiftDiagnostics
@_spi(Diagnostics) import SwiftParser
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) public import SwiftSyntax
#else
import SwiftDiagnostics
@_spi(Diagnostics) import SwiftParser
@_spi(RawSyntax) @_spi(ExperimentalLanguageFeatures) import SwiftSyntax
#endif

fileprivate func getTokens(between first: TokenSyntax, and second: TokenSyntax) -> [TokenSyntax] {
  var first = first
  if first.presence == .missing {
    let nextPresentToken = first.nextToken(viewMode: .sourceAccurate)
    guard let nextPresentToken else {
      return []
    }
    first = nextPresentToken
  }
  precondition(first.presence == .present)

  var second = second
  if second.presence == .missing {
    let previousPresentToken = second.previousToken(viewMode: .sourceAccurate)
    guard let previousPresentToken else {
      return []
    }
    second = previousPresentToken
  }
  precondition(second.presence == .present)

  var tokens: [TokenSyntax] = []
  var currentToken = first

  while currentToken != second {
    tokens.append(currentToken)
    guard let nextToken = currentToken.nextToken(viewMode: .sourceAccurate) else {
      assertionFailure("second Token must occur after first Token")
      return tokens
    }
    currentToken = nextToken
  }
  tokens.append(second)
  return tokens
}

fileprivate extension TokenSyntax {
  /// Assuming this token is a `poundAvailableKeyword` or `poundUnavailableKeyword`
  /// returns the opposite keyword.
  var negatedAvailabilityKeyword: TokenSyntax {
    switch self.tokenKind {
    case .poundAvailable:
      return self.with(\.tokenKind, .poundUnavailable)
    case .poundUnavailable:
      return self.with(\.tokenKind, .poundAvailable)
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

  public static func diagnostics(
    for tree: some SyntaxProtocol
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
  func addDiagnostic(
    _ node: some SyntaxProtocol,
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
  func shouldSkip(_ node: some SyntaxProtocol) -> Bool {
    if !node.hasError && !node.hasWarning {
      return true
    }
    return handledNodes.contains(node.id)
  }

  /// Utility function to emit a diagnostic that removes a misplaced token and instead inserts an equivalent token at the corrected location.
  ///
  /// If `incorrectContainer` contains some tokens that satisfy `unexpectedTokenCondition`, emit a diagnostic with message `message` that marks this token as misplaced.
  /// If `correctTokens` contains missing tokens, also emit a Fix-It with message `fixIt` that marks the unexpected token as missing and instead inserts `correctTokens`.
  public func exchangeTokens(
    unexpected: UnexpectedNodesSyntax?,
    unexpectedTokenCondition: (TokenSyntax) -> Bool,
    correctTokens: [TokenSyntax?],
    message: (_ misplacedTokens: [TokenSyntax]) -> some DiagnosticMessage,
    moveFixIt: (_ misplacedTokens: [TokenSyntax]) -> FixItMessage,
    removeRedundantFixIt: (_ misplacedTokens: [TokenSyntax]) -> FixItMessage? = { _ in nil }
  ) {
    guard let incorrectContainer = unexpected else { return }
    let misplacedTokens = incorrectContainer.presentTokens(satisfying: unexpectedTokenCondition)
    if misplacedTokens.isEmpty { return }

    let correctTokens = correctTokens.compactMap({ $0 })

    // Ignore `correctTokens` that are already present.
    let correctAndMissingTokens = correctTokens.filter({ $0.isMissing })
    var changes: [FixIt.MultiNodeChange] = []
    if let misplacedToken = misplacedTokens.only, let correctToken = correctTokens.only,
      misplacedToken.nextToken(viewMode: .all) == correctToken || misplacedToken.previousToken(viewMode: .all) == correctToken,
      correctToken.isMissing
    {
      // We are exchanging two adjacent tokens, transfer the trivia from the incorrect token to the corrected token.
      changes.append(
        FixIt.MultiNodeChange.makePresent(
          correctToken,
          // Transfer any existing trivia. If there is no trivia in the misplaced token, pass `nil` so that `makePresent` can add required trivia, if necessary.
          leadingTrivia: misplacedToken.leadingTrivia.isEmpty ? nil : misplacedToken.leadingTrivia,
          trailingTrivia: misplacedToken.trailingTrivia.isEmpty ? nil : misplacedToken.trailingTrivia
        )
      )
      changes.append(FixIt.MultiNodeChange.makeMissing(misplacedTokens, transferTrivia: false))
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
  public func removeToken(
    _ unexpected: UnexpectedNodesSyntax?,
    where predicate: (TokenSyntax) -> Bool,
    message: (TokenSyntax) -> some DiagnosticMessage
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

  private func handleMisplacedEffectSpecifiersAfterArrow(effectSpecifiers: (some EffectSpecifiersSyntax)?, misplacedSpecifiers: UnexpectedNodesSyntax?) {
    exchangeTokens(
      unexpected: misplacedSpecifiers,
      unexpectedTokenCondition: { EffectSpecifier(token: $0) != nil },
      correctTokens: [effectSpecifiers?.asyncSpecifier, effectSpecifiers?.throwsClause?.throwsSpecifier],
      message: { EffectsSpecifierAfterArrow(effectsSpecifiersAfterArrow: $0) },
      moveFixIt: { MoveTokensInFrontOfFixIt(movedTokens: $0, inFrontOf: .arrow) },
      removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
    )
  }

  private func handleMisplacedEffectSpecifiers(effectSpecifiers: (some EffectSpecifiersSyntax)?, output: ReturnClauseSyntax?) {
    handleMisplacedEffectSpecifiersAfterArrow(effectSpecifiers: effectSpecifiers, misplacedSpecifiers: output?.unexpectedBetweenArrowAndType)
    handleMisplacedEffectSpecifiersAfterArrow(effectSpecifiers: effectSpecifiers, misplacedSpecifiers: output?.unexpectedAfterType)
  }

  private func handleEffectSpecifiers(_ node: some EffectSpecifiersSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    let specifierInfo = [
      (node.asyncSpecifier, { AsyncEffectSpecifier(token: $0) != nil }, StaticParserError.misspelledAsync),
      (node.throwsClause?.throwsSpecifier, { ThrowsEffectSpecifier(token: $0) != nil }, StaticParserError.misspelledThrows),
    ]

    let unexpectedNodes = [
      node.unexpectedBeforeAsyncSpecifier, node.unexpectedBetweenAsyncSpecifierAndThrowsClause,
      node.unexpectedAfterThrowsClause,
    ]

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
          moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacements: [specifier]) },
          removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
        )
      }
    }

    if let throwsClause = node.throwsClause {
      exchangeTokens(
        unexpected: node.unexpectedAfterThrowsClause,
        unexpectedTokenCondition: { AsyncEffectSpecifier(token: $0) != nil },
        correctTokens: [node.asyncSpecifier],
        message: { AsyncMustPrecedeThrows(asyncKeywords: $0, throwsKeyword: throwsClause.throwsSpecifier) },
        moveFixIt: { MoveTokensInFrontOfFixIt(movedTokens: $0, inFrontOf: throwsClause.throwsSpecifier.tokenKind) },
        removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
      )
    }

    for (specifier, isOfSameKind, _) in specifierInfo {
      guard let specifier = specifier else {
        continue
      }
      if specifier.isPresent {
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
      !firstToken.isEditorPlaceholder,
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
            FixIt.MultiNodeChange(
              .replace(
                oldNode: Syntax(previousToken),
                newNode: Syntax(TokenSyntax(.identifier(joined), trailingTrivia: tokens.last?.trailingTrivia ?? [], presence: .present))
              )
            ),
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
              FixIt.MultiNodeChange(
                .replace(
                  oldNode: Syntax(previousToken),
                  newNode: Syntax(TokenSyntax(.identifier(joinedUsingCamelCase), trailingTrivia: tokens.last?.trailingTrivia ?? [], presence: .present))
                )
              ),
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

    if token.isMissing {
      handleMissingToken(token)
    } else {
      if let tokenDiagnostic = token.tokenDiagnostic {
        switch tokenDiagnostic.kind {
        case .extraneousLeadingWhitespaceError, .extraneousLeadingWhitespaceWarning:
          if token.previousToken(viewMode: .fixedUp)?.isMissing ?? false {
            // If the previous token is missing, it doesn't make sense to complain about extraneous whitespace between
            // the previous token and this one.
            return .skipChildren
          }
        case .extraneousTrailingWhitespaceError, .extraneousTrailingWhitespaceWarning:
          if token.nextToken(viewMode: .fixedUp)?.isMissing ?? false {
            // If the next token is missing, it doesn't make sense to complain about extraneous whitespace between
            // this token and the next.
            return .skipChildren
          }
        default:
          break
        }
        let message = tokenDiagnostic.diagnosticMessage(in: token)
        precondition(message.severity.matches(tokenDiagnostic.severity))
        self.addDiagnostic(
          token,
          position: tokenDiagnostic.position(in: token),
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
    handleMisplacedEffectSpecifiersAfterArrow(effectSpecifiers: node.effectSpecifiers, misplacedSpecifiers: node.unexpectedAfterArrow)

    return .visitChildren
  }

  public override func visit(_ node: AccessorEffectSpecifiersSyntax) -> SyntaxVisitorContinueKind {
    return handleEffectSpecifiers(node)
  }

  public override func visit(_ node: AssociatedTypeDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // Emit a custom diagnostic for an unexpected 'each' before an associatedtype
    // name.
    removeToken(
      node.unexpectedBetweenAssociatedtypeKeywordAndName,
      where: { $0.tokenKind == .keyword(.each) },
      message: { _ in .associatedTypeCannotUsePack }
    )
    // Emit a custom diagnostic for an unexpected '...' after an associatedtype
    // name.
    removeToken(
      node.unexpectedBetweenNameAndInheritanceClause,
      where: { $0.tokenKind == .ellipsis },
      message: { _ in .associatedTypeCannotUsePack }
    )
    return .visitChildren
  }

  public override func visit(_ node: ArrayTypeSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if node.leftSquare.isMissing && node.rightSquare.isPresent {
      addDiagnostic(
        node.rightSquare,
        .extraRightBracket,
        fixIts: [.init(message: InsertFixIt(tokenToBeInserted: node.leftSquare), changes: .makePresent(node.leftSquare))],
        handledNodes: [node.leftSquare.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: AttributeSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let arguments = node.arguments, arguments.isMissingAllTokens {
      addDiagnostic(
        arguments,
        MissingAttributeArgument(attributeName: node.attributeName),
        fixIts: [
          FixIt(message: .insertAttributeArguments, changes: .makePresent(arguments))
        ],
        handledNodes: [arguments.id]
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
        unexpected: node.unexpectedBetweenArgumentAndTrailingComma,
        unexpectedTokenCondition: { $0.text == "||" },
        correctTokens: [node.trailingComma],
        message: { _ in .joinPlatformsUsingComma },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacements: [trailingComma]) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: AvailabilityConditionSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpectedAfterRightParen = node.unexpectedAfterRightParen,
      let (_, falseKeyword) = unexpectedAfterRightParen.twoPresentTokens(
        firstSatisfying: { $0.tokenKind == .binaryOperator("==") },
        secondSatisfying: { $0.tokenKind == .keyword(.false) }
      )
    {
      // Diagnose #available used as an expression
      let negatedAvailabilityKeyword = node.availabilityKeyword.negatedAvailabilityKeyword
      let negatedAvailability =
        node
        .with(\.availabilityKeyword, negatedAvailabilityKeyword)
        .with(\.unexpectedAfterRightParen, nil)
      addDiagnostic(
        unexpectedAfterRightParen,
        AvailabilityConditionAsExpression(availabilityToken: node.availabilityKeyword, negatedAvailabilityToken: negatedAvailabilityKeyword),
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(
              replaceTokens: getTokens(between: node.availabilityKeyword, and: falseKeyword),
              replacements: getTokens(between: negatedAvailability.availabilityKeyword, and: negatedAvailability.rightParen)
            ),
            changes: [
              .replace(oldNode: Syntax(node), newNode: Syntax(negatedAvailability))
            ]
          )
        ],
        handledNodes: [unexpectedAfterRightParen.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: PlatformVersionSyntax) -> SyntaxVisitorContinueKind {
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

  public override func visit(_ node: CanImportExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let versionTuple = node.versionInfo?.version,
      let unexpectedVersionTuple = node.unexpectedBetweenVersionInfoAndRightParen
    {
      if versionTuple.major.isMissing {
        addDiagnostic(
          versionTuple,
          CannotParseVersionTuple(versionTuple: unexpectedVersionTuple),
          handledNodes: [versionTuple.id, unexpectedVersionTuple.id]
        )
      } else {
        addDiagnostic(
          unexpectedVersionTuple,
          .canImportWrongNumberOfParameter,
          handledNodes: [unexpectedVersionTuple.id]
        )
      }
    }

    return .visitChildren
  }

  public override func visit(_ node: CanImportVersionInfoSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if node.label.isMissing {
      addDiagnostic(
        node.label,
        .canImportWrongSecondParameterLabel,
        handledNodes: [node.label.id]
      )

      handledNodes.append(contentsOf: [node.unexpectedBetweenLabelAndColon?.id, node.colon.id, node.version.id].compactMap { $0 })
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
        unexpectedTokenCondition: { $0.text == "&&" || $0.tokenKind == .keyword(.where) },
        correctTokens: [node.trailingComma],
        message: { _ in .joinConditionsUsingComma },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacements: [trailingComma]) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let item = node.statements.only?.item.as(DeclReferenceExprSyntax.self), item.baseName.isEditorPlaceholder {
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
    handleMisplacedEffectSpecifiers(effectSpecifiers: node.effectSpecifiers, output: node.returnClause)
    return .visitChildren
  }

  public override func visit(_ node: CodeBlockItemSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let semicolon = node.semicolon, semicolon.isMissing {
      if !node.item.hasError {
        // Only diagnose the missing semicolon if the item doesn't contain any errors.
        // If the item contains errors, the root cause is most likely something different and not the missing semicolon.
        let position = semicolon.previousToken(viewMode: .sourceAccurate)?.endPositionBeforeTrailingTrivia
        var fixIts: [FixIt] = [
          FixIt(message: .insertSemicolon, changes: .makePresent(semicolon))
        ]
        if let firstToken = node.firstToken(viewMode: .sourceAccurate),
          let lastToken = node.lastToken(viewMode: .sourceAccurate)
        {
          fixIts.insert(
            FixIt(
              message: .insertNewline,
              changes: [
                .replaceTrailingTrivia(token: lastToken, newTrivia: lastToken.trailingTrivia + .newlines(1) + firstToken.indentationOfLine)
              ]
            ),
            at: 0
          )
        }

        addDiagnostic(
          semicolon,
          position: position,
          .consecutiveStatementsOnSameLine,
          fixIts: fixIts,
          handledNodes: [semicolon.id]
        )
      } else {
        handledNodes.append(semicolon.id)
      }
    }
    if let semicolon = node.semicolon, semicolon.isPresent, node.item.isMissingAllTokens {
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

    if let unexpected = node.unexpectedBetweenRequirementAndTrailingComma,
      let token = unexpected.presentTokens(satisfying: { $0.tokenKind == .binaryOperator("&&") }).first,
      let trailingComma = node.trailingComma,
      trailingComma.isMissing
    {
      addDiagnostic(
        unexpected,
        .expectedCommaInWhereClause,
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(replaceTokens: [token], replacements: [.commaToken()]),
            changes: [
              .makeMissing(token, transferTrivia: false),
              .makePresent(trailingComma, leadingTrivia: token.leadingTrivia, trailingTrivia: token.trailingTrivia),
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

    let name: TokenSyntax? = node
      .unexpectedBetweenDeinitKeywordAndEffectSpecifiers?
      .presentTokens(satisfying: \.tokenKind.isIdentifier)
      .only

    let params: FunctionParameterClauseSyntax? = node
      .unexpectedBetweenDeinitKeywordAndEffectSpecifiers?
      .compactMap({ $0.as(FunctionParameterClauseSyntax.self) })
      .only

    let returnType: ReturnClauseSyntax? = node
      .unexpectedBetweenEffectSpecifiersAndBody?
      .compactMap({ $0.as(ReturnClauseSyntax.self) })
      .only

    let nodes = [Syntax(name), Syntax(params), Syntax(returnType)].compactMap { $0 }

    if let firstNode = nodes.first {
      addDiagnostic(
        firstNode,
        DeinitializerSignatureError(name: name, params: params, returnClause: returnType),
        highlights: nodes,
        fixIts: [
          FixIt(
            message: RemoveNodesFixIt(nodes),
            changes: .makeMissing(nodes)
          )
        ],
        handledNodes: nodes.map { $0.id }
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: DeinitializerEffectSpecifiersSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    func asThrowsEffectSpecifier(_ syntax: Syntax) -> TokenSyntax? {
      guard let token = syntax.as(TokenSyntax.self) else { return nil }
      if token.isMissing { return nil }
      if ThrowsEffectSpecifier(token: token) != nil { return token }
      return nil
    }

    let unexpectedThrows =
      (node.unexpectedBeforeAsyncSpecifier?.compactMap(asThrowsEffectSpecifier) ?? [])
      + (node.unexpectedAfterAsyncSpecifier?.compactMap(asThrowsEffectSpecifier) ?? [])
    if let throwsKeyword = unexpectedThrows.first {
      addDiagnostic(
        throwsKeyword,
        .deinitCannotThrow,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(unexpectedThrows), changes: .makeMissing(unexpectedThrows))
        ],
        handledNodes: unexpectedThrows.map(\.id)
      )
    }

    let isAsyncEffectSpecifier = { AsyncEffectSpecifier(token: $0) != nil }
    if let asyncSpecifier = node.asyncSpecifier {
      let unexpectedNodes = [node.unexpectedBeforeAsyncSpecifier, node.unexpectedAfterAsyncSpecifier]
      for unexpected in unexpectedNodes {
        exchangeTokens(
          unexpected: unexpected,
          unexpectedTokenCondition: isAsyncEffectSpecifier,
          correctTokens: [asyncSpecifier],
          message: { _ in StaticParserError.misspelledAsync },
          moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacements: [asyncSpecifier]) },
          removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
        )
      }

      if asyncSpecifier.isPresent {
        for case .some(let unexpected) in unexpectedNodes {
          for duplicateSpecifier in unexpected.presentTokens(satisfying: isAsyncEffectSpecifier) {
            addDiagnostic(
              duplicateSpecifier,
              DuplicateEffectSpecifiers(correctSpecifier: asyncSpecifier, unexpectedSpecifier: duplicateSpecifier),
              notes: [Note(node: Syntax(asyncSpecifier), message: EffectSpecifierDeclaredHere(specifier: asyncSpecifier))],
              fixIts: [FixIt(message: RemoveRedundantFixIt(removeTokens: [duplicateSpecifier]), changes: [.makeMissing(duplicateSpecifier)])],
              handledNodes: [unexpected.id]
            )
          }
        }
      }
    }

    return .visitChildren
  }

  public override func visit(_ node: FloatLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.literal.isMissing,
      let (period, integerLiteral) = node.unexpectedAfterLiteral?.twoPresentTokens(
        firstSatisfying: { $0.tokenKind == .period },
        secondSatisfying: { $0.tokenKind.isIntegerLiteral }
      )
    {
      addDiagnostic(
        node,
        InvalidFloatLiteralMissingLeadingZero(decimalDigits: integerLiteral),
        fixIts: [
          FixIt(
            message: InsertFixIt(tokenToBeInserted: .integerLiteral("0")),
            changes: [
              .makePresent(node.literal),
              .makeMissing(period),
              .makeMissing(integerLiteral),
            ]
          )
        ],
        handledNodes: [node.literal.id, period.id, integerLiteral.id]
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: ForStmtSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // Detect C-style for loops based on two semicolons which could not be parsed between the 'for' keyword and the '{'
    // This is mostly a proof-of-concept implementation to produce more complex diagnostics.
    if let unexpectedCondition = node.body.unexpectedBeforeLeftBrace,
      unexpectedCondition.presentTokens(withKind: .semicolon).count == 2
    {
      // FIXME: This is awful. We should have a way to either get all children between two cursors in a syntax node or highlight a range from one node to another.
      addDiagnostic(
        node,
        .cStyleForLoop,
        highlights: ([
          Syntax(node.pattern),
          Syntax(node.unexpectedBetweenPatternAndTypeAnnotation),
          Syntax(node.typeAnnotation),
          Syntax(node.unexpectedBetweenTypeAnnotationAndInKeyword),
          Syntax(node.inKeyword),
          Syntax(node.unexpectedBetweenInKeywordAndSequence),
          Syntax(node.sequence),
          Syntax(node.unexpectedBetweenSequenceAndWhereClause),
          Syntax(node.whereClause),
          Syntax(node.unexpectedBetweenWhereClauseAndBody),
          Syntax(unexpectedCondition),
        ] as [Syntax?]).compactMap({ $0 }),
        handledNodes: [node.inKeyword.id, node.sequence.id, unexpectedCondition.id]
      )
    } else {  // If it's not a C-style for loop
      if node.sequence.is(MissingExprSyntax.self) {
        addDiagnostic(
          node.sequence,
          .expectedSequenceExpressionInForEachLoop,
          fixIts: [
            FixIt(
              message: InsertTokenFixIt(missingNodes: [Syntax(node.sequence)]),
              changes: [.makePresent(node.sequence)]
            )
          ],
          handledNodes: [node.sequence.id]
        )
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
      unexpectedTokenCondition: { SimpleTypeSpecifierSyntax.SpecifierOptions(token: $0) != nil },
      correctTokens: node.type.as(AttributedTypeSyntax.self)?.specifiers.simpleSpecifiers ?? [],
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
    handleMisplacedEffectSpecifiers(effectSpecifiers: node.effectSpecifiers, output: node.returnClause)
    return .visitChildren
  }

  public override func visit(_ node: FunctionTypeSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    handleMisplacedEffectSpecifiers(effectSpecifiers: node.effectSpecifiers, output: node.returnClause)
    return .visitChildren
  }

  public override func visit(_ node: GenericParameterSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // Emit a custom diagnostic for an unexpected '...' after the type name.
    if node.eachKeyword?.isPresent ?? false {
      removeToken(
        node.unexpectedBetweenNameAndColon,
        where: { $0.tokenKind == .ellipsis },
        message: { _ in .typeParameterPackEllipsis }
      )
    } else if let unexpected = node.unexpectedBetweenNameAndColon,
      let unexpectedEllipsis = unexpected.onlyPresentToken(where: { $0.tokenKind == .ellipsis }),
      let each = node.eachKeyword
    {
      addDiagnostic(
        unexpected,
        .typeParameterPackEllipsis,
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(replaceTokens: [unexpectedEllipsis], replacements: [.keyword(.each)]),
            changes: [
              .makeMissing(unexpected),
              .makePresent(each, trailingTrivia: .space),
            ]
          )
        ],
        handledNodes: [unexpected.id, each.id]
      )
    }
    if let inheritedTypeName = node.inheritedType?.as(IdentifierTypeSyntax.self)?.name {
      exchangeTokens(
        unexpected: node.unexpectedBetweenColonAndInheritedType,
        unexpectedTokenCondition: { $0.tokenKind == .keyword(.class) },
        correctTokens: [inheritedTypeName],
        message: { _ in StaticParserError.classConstraintCanOnlyBeUsedInProtocol },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacements: [inheritedTypeName]) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: DeclReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.baseName.isMissing, let unexpected = node.unexpectedBeforeBaseName {
      if unexpected.first?.as(TokenSyntax.self)?.tokenKind == .pound {
        addDiagnostic(unexpected, UnknownDirectiveError(unexpected: unexpected), handledNodes: [unexpected.id, node.baseName.id])
      } else if let availability = unexpected.first?.as(AvailabilityConditionSyntax.self) {
        if let prefixOperatorExpr = node.parent?.as(PrefixOperatorExprSyntax.self),
          prefixOperatorExpr.operator.text == "!",
          let conditionElement = prefixOperatorExpr.parent?.as(ConditionElementSyntax.self)
        {
          // Diagnose !#available(...) and !#unavailable(...)

          let negatedAvailabilityKeyword = availability.availabilityKeyword.negatedAvailabilityKeyword
          let negatedConditionElement = ConditionElementSyntax(
            condition: .availability(availability.with(\.availabilityKeyword, negatedAvailabilityKeyword)),
            trailingComma: conditionElement.trailingComma
          )
          addDiagnostic(
            unexpected,
            NegatedAvailabilityCondition(availabilityCondition: availability, negatedAvailabilityKeyword: negatedAvailabilityKeyword),
            fixIts: [
              FixIt(
                message: ReplaceTokensFixIt(
                  replaceTokens: [prefixOperatorExpr.operator, availability.availabilityKeyword],
                  replacements: [negatedAvailabilityKeyword]
                ),
                changes: [
                  .replace(oldNode: Syntax(conditionElement), newNode: Syntax(negatedConditionElement))
                ]
              )
            ],
            handledNodes: [unexpected.id, node.baseName.id]
          )
        } else {
          addDiagnostic(unexpected, AvailabilityConditionInExpression(availabilityCondition: availability), handledNodes: [unexpected.id, node.baseName.id])
        }
      }
    }
    return .visitChildren
  }

  public override func visit(_ node: EnumCaseElementSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpectedBetweenNameAndParameterClause = node.unexpectedBetweenNameAndParameterClause,
      let genericParameter = unexpectedBetweenNameAndParameterClause.compactMap({ $0.as(GenericParameterClauseSyntax.self) }).only
    {
      addDiagnostic(
        genericParameter,
        .genericParamCantBeUsedInEnumCaseDecl,
        handledNodes: [unexpectedBetweenNameAndParameterClause.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: IfConfigClauseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpectedBetweenConditionAndElements = node.unexpectedBetweenConditionAndElements {
      addDiagnostic(
        unexpectedBetweenConditionAndElements,
        .extraTokensFollowingConditionalCompilationDirective,
        handledNodes: [unexpectedBetweenConditionAndElements.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: IfConfigDeclSyntax) -> SyntaxVisitorContinueKind {
    for clause in node.clauses where clause.hasError {
      if let unexpectedBeforePoundKeyword = clause.unexpectedBeforePoundKeyword,
        clause.poundKeyword.tokenKind == .poundElseif,
        clause.poundKeyword.isMissing
      {
        let unexpectedTokens =
          unexpectedBeforePoundKeyword
          .suffix(2)
          .compactMap { $0.as(TokenSyntax.self) }
        var diagnosticMessage: DiagnosticMessage?

        if unexpectedTokens.map(\.tokenKind) == [.poundElse, .keyword(.if)] {
          diagnosticMessage = StaticParserError.unexpectedPoundElseSpaceIf
        } else if unexpectedTokens.first?.tokenKind == .pound, unexpectedTokens.last?.text == "elif" {
          diagnosticMessage = UnknownDirectiveError(unexpected: unexpectedBeforePoundKeyword)
        }

        if let diagnosticMessage = diagnosticMessage {
          addDiagnostic(
            unexpectedBeforePoundKeyword,
            diagnosticMessage,
            fixIts: [
              FixIt(
                message: ReplaceTokensFixIt(replaceTokens: unexpectedTokens, replacements: [clause.poundKeyword]),
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

    if let unexpectedAfterPoundEndif = node.unexpectedAfterPoundEndif {
      addDiagnostic(
        unexpectedAfterPoundEndif,
        .extraTokensFollowingConditionalCompilationDirective,
        handledNodes: [unexpectedAfterPoundEndif.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if node.conditions.only?.condition.is(MissingExprSyntax.self) == true,
      !node.body.leftBrace.isMissingAllTokens
    {
      addDiagnostic(node.conditions, MissingConditionInStatement(node: node), handledNodes: [node.conditions.id])
    }

    if let leftBrace = node.elseBody?.as(CodeBlockSyntax.self)?.leftBrace, leftBrace.isMissing {
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
            message: ReplaceTokensFixIt(replaceTokens: [.binaryOperator("==")], replacements: [node.equal]),
            changes: [.makeMissing(unexpected), .makePresent(node.equal)]
          )
        ],
        handledNodes: [unexpected.id, node.equal.id]
      )
    }

    if node.equal.isMissing {
      exchangeTokens(
        unexpected: node.unexpectedBeforeEqual,
        unexpectedTokenCondition: { $0.tokenKind == .colon },
        correctTokens: [node.equal],
        message: { _ in StaticParserError.initializerInPattern },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacements: [node.equal]) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpectedName = node.signature.parameterClause.unexpectedBeforeLeftParen,
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

    if let unexpectedOutput = node.signature.unexpectedAfterReturnClause {
      addDiagnostic(
        unexpectedOutput,
        .initializerCannotHaveResultType,
        handledNodes: [unexpectedOutput.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: LabeledSpecializeArgumentSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpectedIdentifier = node.unexpectedBeforeLabel?.onlyPresentToken(where: { $0.tokenKind.isIdentifier }) {
      addDiagnostic(
        unexpectedIdentifier,
        UnknownParameterError(
          parameter: unexpectedIdentifier,
          validParameters: LabeledSpecializeArgumentSyntax.LabelOptions.allCases.map { $0.tokenSyntax }
        ),
        handledNodes: [unexpectedIdentifier.id, node.label.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: MemberBlockItemSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let semicolon = node.semicolon, semicolon.isMissing {
      if !node.decl.hasError {
        // Only diagnose the missing semicolon if the decl doesn't contain any errors.
        // If the decl contains errors, the root cause is most likely something different and not the missing semicolon.
        let position = semicolon.previousToken(viewMode: .sourceAccurate)?.endPositionBeforeTrailingTrivia
        var fixIts: [FixIt] = [
          FixIt(message: .insertSemicolon, changes: .makePresent(semicolon))
        ]
        if let firstToken = node.firstToken(viewMode: .sourceAccurate),
          let lastToken = node.lastToken(viewMode: .sourceAccurate)
        {
          fixIts.insert(
            FixIt(
              message: .insertNewline,
              changes: [
                .replaceTrailingTrivia(token: lastToken, newTrivia: lastToken.trailingTrivia + .newlines(1) + firstToken.indentationOfLine)
              ]
            ),
            at: 0
          )
        }

        addDiagnostic(
          semicolon,
          position: position,
          .consecutiveDeclarationsOnSameLine,
          fixIts: fixIts,
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

  override open func visit(_ node: OriginallyDefinedInAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let token = node.unexpectedBetweenModuleLabelAndColon?.onlyPresentToken(where: { $0.tokenKind.isIdentifier }),
      node.moduleLabel.isMissing
    {
      addDiagnostic(
        node,
        MissingNodesError(missingNodes: [Syntax(node.moduleLabel)]),
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(
              replaceTokens: [token],
              replacements: [node.moduleLabel]
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

    if node.fixitySpecifier.presence == .missing {
      addDiagnostic(
        node.fixitySpecifier,
        .missingFixityInOperatorDeclaration,
        fixIts: [
          FixIt(message: InsertFixIt(tokenToBeInserted: .keyword(.prefix)), changes: .makePresent(node.fixitySpecifier)),
          FixIt(
            message: InsertFixIt(tokenToBeInserted: .keyword(.infix)),
            changes: [
              FixIt.MultiNodeChange(.replace(oldNode: Syntax(node.fixitySpecifier), newNode: Syntax(TokenSyntax(.keyword(.infix), presence: .present))))
            ]
          ),
          FixIt(
            message: InsertFixIt(tokenToBeInserted: .keyword(.postfix)),
            changes: [
              FixIt.MultiNodeChange(.replace(oldNode: Syntax(node.fixitySpecifier), newNode: Syntax(TokenSyntax(.keyword(.postfix), presence: .present))))
            ]
          ),
        ],
        handledNodes: [node.fixitySpecifier.id]
      )
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
      if let message {
        let fixIts: [FixIt]
        if node.name.isPresent {
          fixIts = [FixIt(message: RemoveNodesFixIt(unexpected), changes: .makeMissing(unexpected))]
        } else {
          fixIts = []
        }
        addDiagnostic(unexpected, message, highlights: [Syntax(unexpected)], fixIts: fixIts, handledNodes: [unexpected.id, node.name.id])
      }
    }

    diagnoseIdentifierInOperatorName(unexpected: node.unexpectedBetweenOperatorKeywordAndName, name: node.name)
    diagnoseIdentifierInOperatorName(unexpected: node.unexpectedBetweenNameAndOperatorPrecedenceAndTypes, name: node.name)

    return .visitChildren
  }

  public override func visit(_ node: PoundSourceLocationSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpectedAfterRightParen = node.unexpectedAfterRightParen {
      addDiagnostic(
        unexpectedAfterRightParen,
        .extraTokensAtTheEndOfSourceLocationDirective,
        handledNodes: [unexpectedAfterRightParen.id]
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: PrecedenceGroupAssignmentSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let unexpected = node.unexpectedBetweenColonAndValue ?? node.unexpectedAfterValue, node.value.isMissing {
      addDiagnostic(unexpected, .invalidFlagAfterPrecedenceGroupAssignment, handledNodes: [unexpected.id, node.value.id])
    }
    return .visitChildren
  }

  public override func visit(_ node: PrecedenceGroupAssociativitySyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.value.isMissing {
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

  @_spi(ExperimentalLanguageFeatures)
  public override func visit(_ node: ThenStmtSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    exchangeTokens(
      unexpected: node.unexpectedBeforeThenKeyword,
      unexpectedTokenCondition: { $0.tokenKind == .keyword(.try) },
      correctTokens: [node.expression.as(TryExprSyntax.self)?.tryKeyword],
      message: { _ in .tryMustBePlacedOnThenExpr },
      moveFixIt: { MoveTokensAfterFixIt(movedTokens: $0, after: .keyword(.then)) }
    )
    return .visitChildren
  }

  public override func visit(_ node: SameTypeRequirementSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.equal.isMissing && node.rightType.isMissingAllTokens {
      addDiagnostic(
        node.equal,
        .missingConformanceRequirement,
        handledNodes: [node.equal.id, node.rightType.id]
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: SimpleStringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    var rawDelimiters: [TokenSyntax] = []

    if let unexpectedBeforeOpenQuote = node.unexpectedBeforeOpeningQuote?.onlyPresentToken(where: { $0.tokenKind.isRawStringDelimiter }) {
      rawDelimiters += [unexpectedBeforeOpenQuote]
    }

    if let unexpectedAfterCloseQuote = node.unexpectedAfterClosingQuote?.onlyPresentToken(where: { $0.tokenKind.isRawStringDelimiter }) {
      rawDelimiters += [unexpectedAfterCloseQuote]
    }

    if !rawDelimiters.isEmpty {
      addDiagnostic(
        node,
        .forbiddenExtendedEscapingString,
        fixIts: [
          FixIt(
            message: RemoveNodesFixIt(rawDelimiters),
            changes: .makeMissing(rawDelimiters)
          )
        ],
        handledNodes: rawDelimiters.map { $0.id }
      )
    }

    return .visitChildren
  }

  public override func visit(_ node: SimpleStringLiteralSegmentListSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    for segment in node {
      if let unexpectedAfterContent = segment.unexpectedAfterContent {
        addDiagnostic(
          node,
          .forbiddenInterpolatedString,
          handledNodes: [unexpectedAfterContent.id]
        )
      }
    }

    return .visitChildren
  }

  public override func visit(_ node: SourceFileSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if let extraneous = node.unexpectedBetweenStatementsAndEndOfFileToken, !extraneous.isEmpty {
      addDiagnostic(extraneous, ExtraneousCodeAtTopLevel(extraneousCode: extraneous), handledNodes: [extraneous.id])
    }
    return .visitChildren
  }

  public override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    // recover from Objective-C style literals
    if let atSign = node.unexpectedBetweenOpeningPoundsAndOpeningQuote?.onlyPresentToken(where: { $0.tokenKind == .atSign }) {
      addDiagnostic(
        node,
        .stringLiteralAtSign,
        fixIts: [
          FixIt(message: RemoveNodesFixIt(atSign), changes: .makeMissing(atSign))
        ],
        handledNodes: [atSign.id]
      )
    }
    if let singleQuote = node.unexpectedBetweenOpeningPoundsAndOpeningQuote?.onlyPresentToken(where: { $0.tokenKind == .singleQuote }) {
      let fixIt = FixIt(
        message: ReplaceTokensFixIt(replaceTokens: [singleQuote], replacements: [node.openingQuote]),
        changes: [
          .makeMissing(singleQuote, transferTrivia: false),
          .makePresent(node.openingQuote, leadingTrivia: singleQuote.leadingTrivia),
          .makeMissing(node.unexpectedBetweenSegmentsAndClosingQuote, transferTrivia: false),
          .makePresent(node.closingQuote, trailingTrivia: node.unexpectedBetweenSegmentsAndClosingQuote?.trailingTrivia ?? []),
        ]
      )
      addDiagnostic(
        singleQuote,
        .singleQuoteStringLiteral,
        fixIts: [fixIt],
        handledNodes: [
          node.unexpectedBetweenOpeningPoundsAndOpeningQuote?.id,
          node.openingQuote.id,
          node.unexpectedBetweenSegmentsAndClosingQuote?.id,
          node.closingQuote.id,
        ].compactMap { $0 }
      )
    } else if node.openingQuote.presence == .missing,
      node.unexpectedBetweenOpeningPoundsAndOpeningQuote == nil,
      node.closingQuote.presence == .missing,
      node.unexpectedBetweenClosingQuoteAndClosingPounds == nil,
      !node.segments.isMissingAllTokens
    {
      addDiagnostic(
        node,
        MissingBothStringQuotesOfStringSegments(stringSegments: node.segments),
        fixIts: [
          FixIt(
            message: InsertTokenFixIt(missingNodes: [Syntax(node.openingQuote), Syntax(node.closingQuote)]),
            changes: [
              .makePresent(node.openingQuote),
              .makePresent(node.closingQuote),
            ]
          )
        ],
        handledNodes: [
          node.openingQuote.id,
          node.closingQuote.id,
        ]
      )
    }

    for (diagnostic, handledNodes) in MultiLineStringLiteralIndentationDiagnosticsGenerator.diagnose(node) {
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
          .escapedNewlineAtLastLineOfMultiLineStringLiteralNotAllowed,
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
    if let unexpected = node.parameterClause.unexpectedBeforeLeftParen,
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

    if node.subject.is(MissingExprSyntax.self) && !node.cases.isEmpty {
      addDiagnostic(node.subject, MissingExpressionInStatement(node: node), handledNodes: [node.subject.id])
    }

    return .visitChildren
  }

  public override func visit(_ node: SwitchCaseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.attribute?.isMissingAllTokens != false && node.label.isMissingAllTokens {
      addDiagnostic(
        node.statements,
        .allStatementsInSwitchMustBeCoveredByCase,
        fixIts: [
          FixIt(message: InsertTokenFixIt(missingNodes: [Syntax(node.label)]), changes: .makePresent(node.label))
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
      unexpected: node.unexpectedBetweenInoutKeywordAndFirstName,
      unexpectedTokenCondition: { SimpleTypeSpecifierSyntax.SpecifierOptions(token: $0) != nil },
      correctTokens: node.type.as(AttributedTypeSyntax.self)?.specifiers.simpleSpecifiers ?? [],
      message: { SpecifierOnParameterName(misplacedSpecifiers: $0) },
      moveFixIt: { MoveTokensInFrontOfTypeFixIt(movedTokens: $0) },
      removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
    )
    return .visitChildren
  }

  public override func visit(_ node: TypeEffectSpecifiersSyntax) -> SyntaxVisitorContinueKind {
    return handleEffectSpecifiers(node)
  }

  public override func visit(_ node: InheritanceClauseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpected = node.unexpectedBeforeColon,
      let leftParen = unexpected.onlyPresentToken(where: { $0.tokenKind == .leftParen })
    {

      var handledNodes: [SyntaxIdentifier] = [
        leftParen.id,
        node.colon.id,
      ]

      var changes: [FixIt.MultiNodeChange] = [
        .makePresent(node.colon),
        .makeMissing(unexpected),
      ]

      var replaceTokens = [leftParen]

      if let rightParen = node.unexpectedAfterInheritedTypes?.onlyPresentToken(where: { $0.tokenKind == .rightParen }) {
        handledNodes += [rightParen.id]
        changes += [
          .makeMissing(rightParen)
        ]

        replaceTokens += [rightParen]
      }

      addDiagnostic(
        unexpected,
        .expectedColonClass,
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(replaceTokens: replaceTokens, replacements: [.colonToken()]),
            changes: changes
          )
        ],
        handledNodes: handledNodes
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: TypeInitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }
    if node.equal.isMissing {
      exchangeTokens(
        unexpected: node.unexpectedBeforeEqual,
        unexpectedTokenCondition: { $0.tokenKind == .colon },
        correctTokens: [node.equal],
        message: { _ in MissingNodesError(missingNodes: [Syntax(node.equal)]) },
        moveFixIt: { ReplaceTokensFixIt(replaceTokens: $0, replacements: [node.equal]) }
      )
    }
    return .visitChildren
  }

  public override func visit(_ node: UnavailableFromAsyncAttributeArgumentsSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let equalToken = node.unexpectedBetweenColonAndMessage?.onlyPresentToken(where: { $0.tokenKind == .equal }) {
      addDiagnostic(
        equalToken,
        MissingNodesError(missingNodes: [Syntax(node.colon)]),
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(
              replaceTokens: [equalToken],
              replacements: [node.colon]
            ),
            changes: [
              .makeMissing(equalToken, transferTrivia: false),
              .makePresent(node.colon, leadingTrivia: equalToken.leadingTrivia, trailingTrivia: equalToken.trailingTrivia),
            ]
          )
        ],
        handledNodes: [equalToken.id, node.colon.id]
      )
    }

    if let token = node.unexpectedBetweenMessageLabelAndColon?.onlyPresentToken(where: { $0.tokenKind.isIdentifier }),
      token.isPresent,
      node.messageLabel.isMissing
    {
      addDiagnostic(
        node,
        MissingNodesError(missingNodes: [Syntax(node.messageLabel)]),
        fixIts: [
          FixIt(
            message: ReplaceTokensFixIt(
              replaceTokens: [token],
              replacements: [node.messageLabel]
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
    if node.colon.isMissing {
      if let siblings = node.parent?.children(viewMode: .all),
        let nodeIndex = siblings.index(of: node),
        let nextSibling = siblings[siblings.index(after: nodeIndex)...].first,
        nextSibling.is(MissingExprSyntax.self)
      {
        addDiagnostic(
          node.colon,
          .missingColonAndExprInTernaryExpr,
          fixIts: [
            FixIt(
              message: InsertTokenFixIt(missingNodes: [Syntax(node.colon), nextSibling]),
              changes: [
                .makePresent(node.colon),
                .makePresent(nextSibling),
              ]
            )
          ],
          handledNodes: [node.colon.id, nextSibling.id]
        )
      } else {
        addDiagnostic(
          node.colon,
          .missingColonInTernaryExpr,
          fixIts: [
            FixIt(message: InsertTokenFixIt(missingNodes: [Syntax(node.colon)]), changes: .makePresent(node.colon))
          ],
          handledNodes: [node.colon.id]
        )
      }
    }
    return .visitChildren
  }

  public override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if node.modifiers.hasError {
      for modifier in node.modifiers {
        guard let detail = modifier.detail else {
          continue
        }

        let unexpectedTokens: [TokenSyntax] = [detail.unexpectedBetweenLeftParenAndDetail, detail.unexpectedBetweenDetailAndRightParen]
          .compactMap { $0?.tokens(viewMode: .sourceAccurate) }
          .flatMap { $0 }

        // If there is no unexpected tokens it means we miss a paren or set keyword.
        // So we just skip the handling here
        guard let firstUnexpected = unexpectedTokens.first else {
          continue
        }

        let fixItMessage: ParserFixIt

        if detail.detail.presence == .missing {
          fixItMessage = ReplaceTokensFixIt(replaceTokens: unexpectedTokens, replacements: [detail.detail])
        } else {
          fixItMessage = RemoveNodesFixIt(unexpectedTokens)
        }

        addDiagnostic(
          firstUnexpected,
          MissingNodesError(missingNodes: [Syntax(detail.detail)]),
          fixIts: [
            FixIt(
              message: fixItMessage,
              changes: [
                .makePresent(detail.detail),
                .makeMissing(unexpectedTokens),
              ]
            )
          ],
          handledNodes: [detail.id] + unexpectedTokens.map(\.id)
        )
      }
    }

    let missingTries = node.bindings.compactMap({
      return $0.initializer?.value.as(TryExprSyntax.self)?.tryKeyword
    })
    exchangeTokens(
      unexpected: node.unexpectedBetweenModifiersAndBindingSpecifier,
      unexpectedTokenCondition: { $0.tokenKind == .keyword(.try) },
      correctTokens: missingTries,
      message: { _ in .tryOnInitialValueExpression },
      moveFixIt: { MoveTokensAfterFixIt(movedTokens: $0, after: .equal) },
      removeRedundantFixIt: { RemoveRedundantFixIt(removeTokens: $0) }
    )
    return .visitChildren
  }

  public override func visit(_ node: VersionTupleSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if let unexpectedAfterComponents = node.unexpectedAfterComponents {
      if unexpectedAfterComponents.allSatisfy({ $0.is(VersionComponentSyntax.self) }) {
        addDiagnostic(
          unexpectedAfterComponents,
          TrailingVersionAreIgnored(major: node.major, components: node.components),
          handledNodes: [unexpectedAfterComponents.id]
        )
      } else {
        addDiagnostic(
          unexpectedAfterComponents,
          CannotParseVersionTuple(versionTuple: unexpectedAfterComponents),
          handledNodes: [node.major.id, node.components.id, unexpectedAfterComponents.id]
        )
      }
    }

    return .visitChildren
  }

  public override func visit(_ node: WhileStmtSyntax) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    if node.conditions.only?.condition.is(MissingExprSyntax.self) == true,
      !node.body.leftBrace.isMissingAllTokens
    {
      addDiagnostic(node.conditions, MissingConditionInStatement(node: node), handledNodes: [node.conditions.id])
    }

    return .visitChildren
  }

  //==========================================================================//
  // IMPORTANT: If you are tempted to add a `visit` method here, please       //
  // insert it in alphabetical order above                                    //
  //==========================================================================//
}
