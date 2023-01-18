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
@_spi(RawSyntax) import SwiftSyntax
import SwiftBasicFormat

// MARK: - Shared code

/// Returns the bottommost node that is an ancestor of all nodes in `nodes`.
fileprivate func findCommonAncestor(_ nodes: [Syntax]) -> Syntax? {
  return findCommonAncestorOrSelf(nodes.compactMap({ $0.parent }))
}

fileprivate enum NodesDescriptionPart {
  case tokensWithDefaultText([TokenSyntax])
  case tokenWithoutDefaultText(TokenSyntax)
  case node(Syntax)

  func description(format: Bool) -> String? {
    switch self {
    case .tokensWithDefaultText(var tokens):
      if format {
        tokens = tokens.map({ BasicFormat().visit($0) })
      }
      if !tokens.isEmpty {
        tokens[0] = tokens[0].withLeadingTrivia([])
        tokens[tokens.count - 1] = tokens[tokens.count - 1].withTrailingTrivia([])
      }
      let tokenContents = tokens.map(\.description).joined()
      return "'\(tokenContents)'"
    case .tokenWithoutDefaultText(let token):
      if let childName = token.childNameInParent {
        return childName
      }
      return token.tokenKind.decomposeToRaw().rawKind.nameForDiagnostics
    case .node(let node):
      var walk: Syntax = node
      while true {
        if let childName = walk.childNameInParent {
          return childName
        }
        if let parent = walk.parent, parent.children(viewMode: .all).count == 1 {
          // If walk is the only node in its parent, check if that parent has a childNameForDiagnostics
          walk = parent
        } else {
          break
        }
      }
      return node.nodeTypeNameForDiagnostics(allowBlockNames: true)
    }
  }

  static func descriptionParts<S: Sequence>(for nodes: S) -> [NodesDescriptionPart] where S.Element == Syntax {
    var parts: [NodesDescriptionPart] = []
    for missingNode in nodes {
      if let token = missingNode.as(TokenSyntax.self) {
        let newPart: NodesDescriptionPart
        if token.presence == .present {
          newPart = .tokensWithDefaultText([token])
        } else {
          let (rawKind, text) = token.tokenKind.decomposeToRaw()
          if let text = text, !text.isEmpty {
            let presentToken = TokenSyntax(token.tokenKind, presence: .present)
            newPart = .tokensWithDefaultText([presentToken])
          } else if let defaultText = rawKind.defaultText {
            let newKind = TokenKind.fromRaw(kind: rawKind, text: String(syntaxText: defaultText))
            let presentToken = TokenSyntax(newKind, presence: .present)
            newPart = .tokensWithDefaultText([presentToken])
          } else {
            newPart = .tokenWithoutDefaultText(token)
          }
        }

        switch (parts.last, newPart) {
        case (.tokensWithDefaultText(let previousTokens), .tokensWithDefaultText(let newTokens)):
          parts[parts.count - 1] = .tokensWithDefaultText(previousTokens + newTokens)
        default:
          parts.append(newPart)
        }
      } else {
        let part = NodesDescriptionPart.node(missingNode)
        if part.description(format: false) == nil {
          // If the new part doesn't have a good name, create one from all the tokens that are missing within it.
          parts += descriptionParts(for: missingNode.children(viewMode: .all))
        } else {
          parts.append(part)
        }
      }
    }
    return parts
  }
}

/// Returns a string that describes `missingNodes`.
/// If `commonParent` is not `nil`, `missingNodes` are expected to all be children of `commonParent`.
/// If `format` is `true`, `BasicFormat` will be used to format the tokens prior to printing. This is useful if the nodes have been synthesized.
func nodesDescription<SyntaxType: SyntaxProtocol>(_ nodes: [SyntaxType], format: Bool) -> String {
  return nodesDescriptionAndCommonParent(nodes, format: format).description
}

/// Same as `nodesDescription` but if a common ancestor was used to describe `missingNodes`, also return that `commonAncestor`
func nodesDescriptionAndCommonParent<SyntaxType: SyntaxProtocol>(_ nodes: [SyntaxType], format: Bool) -> (commonAncestor: Syntax?, description: String) {
  let missingSyntaxNodes = nodes.map(Syntax.init)

  // If all tokens in the parent are missing, return the parent type name.
  if let commonAncestor = findCommonAncestor(missingSyntaxNodes),
    commonAncestor.isMissingAllTokens,
    let firstToken = commonAncestor.firstToken(viewMode: .all),
    let lastToken = commonAncestor.lastToken(viewMode: .all),
    missingSyntaxNodes.contains(Syntax(firstToken)),
    missingSyntaxNodes.contains(Syntax(lastToken))
  {
    if let nodeTypeName = commonAncestor.nodeTypeNameForDiagnostics(allowBlockNames: true) {
      return (commonAncestor, nodeTypeName)
    } else if let nodeTypeName = commonAncestor.childNameInParent {
      return (commonAncestor, nodeTypeName)
    }
  }

  let partDescriptions = NodesDescriptionPart.descriptionParts(for: missingSyntaxNodes).map({ $0.description(format: format) ?? "syntax" })
  switch partDescriptions.count {
  case 0:
    return (nil, "syntax")
  case 1:
    return (nil, "\(partDescriptions.first!)")
  case 2:
    return (nil, "\(partDescriptions.first!) and \(partDescriptions.last!)")
  default:
    return (nil, "\(partDescriptions[0..<partDescriptions.count - 1].joined(separator: ", ")), and \(partDescriptions.last!)")
  }
}

fileprivate extension TokenKind {
  var isStartMarker: Bool {
    switch self {
    case .leftBrace, .leftAngle, .leftParen, .leftSquareBracket:
      return true
    default:
      return false
    }
  }

  var isEndMarker: Bool {
    return matchingStartMarkerKind != nil
  }

  var matchingStartMarkerKind: TokenKind? {
    switch self {
    case .rightBrace:
      return .leftBrace
    case .rightAngle:
      return .leftAngle
    case .rightParen:
      return .leftParen
    case .rightSquareBracket:
      return .leftSquareBracket
    case .stringQuote, .multilineStringQuote, .rawStringDelimiter:
      return self
    default:
      return nil
    }
  }
}

/// Checks whether a node contains any tokens (missing or present)
fileprivate class HasTokenChecker: SyntaxAnyVisitor {
  var hasToken: Bool = false

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if hasToken {
      // If we already saw a present token, we don't need to continue.
      return .skipChildren
    } else {
      return .visitChildren
    }
  }

  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    hasToken = true
    return .visitChildren
  }
}

fileprivate extension SyntaxProtocol {
  /// Returns `true` if the tree contains any tokens (either missing or present).
  var hasTokens: Bool {
    let checker = HasTokenChecker(viewMode: .all)
    checker.walk(Syntax(self))
    return checker.hasToken
  }
}

// MARK: - Error

public struct MissingNodesError: ParserError {
  public let missingNodes: [Syntax]

  init(missingNodes: [Syntax]) {
    assert(!missingNodes.isEmpty)
    self.missingNodes = missingNodes
  }

  /// If applicable, returns a string that describes after which node the nodes are expected.
  private var afterClause: String? {
    guard let firstMissingNode = missingNodes.first else {
      return nil
    }
    if let missingDecl = firstMissingNode.as(MissingDeclSyntax.self) {
      if let lastModifier = missingDecl.modifiers?.last {
        return "after '\(lastModifier.name.text)' modifier"
      } else if missingDecl.attributes != nil {
        return "after attribute"
      }
    }

    return nil
  }

  /// If applicable, returns a string that describes the node in which the missing nodes are expected.
  private func parentContextClause(anchor: Syntax?) -> String? {
    // anchorParent is the first parent that has a type name for diagnostics.
    guard
      let (anchorParent, anchorTypeName) = anchor?.ancestorOrSelf(mapping: { (node: Syntax) -> (Syntax, String)? in
        if let name = node.nodeTypeNameForDiagnostics(allowBlockNames: false) {
          return (node, name)
        } else {
          return nil
        }
      })
    else {
      return nil
    }
    if anchorParent.is(SourceFileSyntax.self) {
      return nil
    }

    let isFirstTokenStartMarker = missingNodes.first?.as(TokenSyntax.self)?.tokenKind.isStartMarker ?? false
    let isLastTokenEndMarker = missingNodes.last?.as(TokenSyntax.self)?.tokenKind.isEndMarker ?? false
    switch (isFirstTokenStartMarker, isLastTokenEndMarker) {
    case (true, false) where Syntax(anchorParent.firstToken(viewMode: .all)) == missingNodes.first:
      return "to start \(anchorTypeName)"
    case (false, true) where Syntax(anchorParent.lastToken(viewMode: .all)) == missingNodes.last:
      return "to end \(anchorTypeName)"
    default:
      return "in \(anchorTypeName)"
    }
  }

  public var message: String {
    let (anchor, description) = nodesDescriptionAndCommonParent(missingNodes, format: true)
    var message = "expected \(description)"
    if let afterClause = afterClause {
      message += " \(afterClause)"
    }
    if let parentContextClause = parentContextClause(anchor: anchor?.parent ?? findCommonAncestor(missingNodes)) {
      message += " \(parentContextClause)"
    }
    return message
  }
}

// MARK: - Note

public struct MatchingOpeningTokenNote: ParserNote {
  let openingToken: TokenSyntax

  public var message: String { "to match this opening '\(openingToken.text)'" }
}

// MARK: - Fix-It

public struct InsertTokenFixIt: ParserFixIt {
  public let missingNodes: [Syntax]

  init(missingNodes: [Syntax]) {
    assert(!missingNodes.isEmpty)
    self.missingNodes = missingNodes
  }

  public var message: String { "insert \(nodesDescription(missingNodes, format: true))" }
}

// MARK: - Generate Error

extension ParseDiagnosticsGenerator {
  func handleMissingToken(_ node: TokenSyntax) {
    guard let invalidToken = node.previousToken(viewMode: .all),
      let unexpectedTokens = invalidToken.parent?.as(UnexpectedNodesSyntax.self),
      unexpectedTokens.count == 1
    else {
      _ = handleMissingSyntax(node)
      return
    }

    // The previous token is unexpected, assume that it was intended to be
    // this token.

    if node.tokenKind.isIdentifier {
      let fixIts: [FixIt]
      if invalidToken.tokenKind.isLexerClassifiedKeyword || invalidToken.tokenKind.isDollarIdentifier {
        // TODO: Should the parser add the text with backticks to the missing
        // node? Then this could just make missing/present.
        fixIts = [
          FixIt(
            message: .wrapInBackticks,
            changes: [
              .replace(
                oldNode: Syntax(invalidToken),
                newNode: Syntax(TokenSyntax.identifier("`\(invalidToken.text)`", leadingTrivia: invalidToken.leadingTrivia, trailingTrivia: invalidToken.trailingTrivia))
              )
            ]
          )
        ]
      } else {
        fixIts = []
      }
      addDiagnostic(
        invalidToken,
        InvalidIdentifierError(invalidIdentifier: invalidToken, missingIdentifier: node),
        fixIts: fixIts,
        handledNodes: [unexpectedTokens.id]
      )
    } else if node.tokenKind == .period && invalidToken.tokenKind == .period {
      // Trailing trivia is the cause of this diagnostic, don't transfer it.
      let changes: [FixIt.Changes] = [
        .makeMissing(invalidToken, transferTrivia: false),
        .makePresent(node),
      ]

      if let identifier = node.nextToken(viewMode: .all),
        identifier.rawTokenKind == .identifier,
        identifier.presence == .missing
      {
        // The extraneous whitespace caused a missing identifier, output a
        // diagnostic inserting it instead of a diagnostic to fix the trivia
        // around the period.
        _ = handleMissingSyntax(
          identifier,
          overridePosition: invalidToken.endPositionBeforeTrailingTrivia,
          additionalChanges: changes,
          additionalHandledNodes: [unexpectedTokens.id]
        )
      } else {
        let fixIt = FixIt(message: .removeExtraneousWhitespace, changes: changes)
        addDiagnostic(invalidToken, .invalidWhitespaceAfterPeriod, fixIts: [fixIt], handledNodes: [unexpectedTokens.id])
      }
    } else if node.rawTokenKind == .rawStringDelimiter, invalidToken.rawTokenKind == .rawStringDelimiter {
      let message: DiagnosticMessage
      if node.parent?.is(ExpressionSegmentSyntax.self) == true {
        message = .tooManyRawStringDelimitersToStartInterpolation
      } else {
        assert(
          node.parent?.is(StringLiteralExprSyntax.self) == true,
          "Raw string delimiters should only occur in string interpolation and at the end of a string literal"
        )
        message = .tooManyClosingRawStringDelimiters
      }
      let fixIt = FixIt(
        message: .removeExtraneousDelimiters,
        changes: [
          .makeMissing(invalidToken),
          .makePresentBeforeTrivia(node),
        ]
      )
      addDiagnostic(
        invalidToken,
        position: invalidToken.positionAfterSkippingLeadingTrivia.advanced(by: node.contentLength.utf8Length),
        message,
        fixIts: [fixIt],
        handledNodes: [unexpectedTokens.id]
      )
    } else {
      _ = handleMissingSyntax(node)
    }
  }

  func handleMissingSyntax<T: SyntaxProtocol>(
    _ node: T,
    overridePosition: AbsolutePosition? = nil,
    additionalChanges: [FixIt.Changes] = [],
    additionalHandledNodes: [SyntaxIdentifier] = []
  ) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    /// Ancestors that don't contain any tokens are not very interesting to merge diagnostics (because there can't be any missing tokens we can merge them with).
    /// Find the first ancestor that contains any tokens.
    var ancestorWithTokens = node.parent
    var index = node.index
    while let unwrappedParent = ancestorWithTokens, !unwrappedParent.hasTokens {
      ancestorWithTokens = unwrappedParent.parent
      index = unwrappedParent.index
    }

    // Walk all upcoming sibling to see if they are also missing to handle them in this diagnostic.
    // If this is the case, handle all of them in this diagnostic.
    var missingNodes = [Syntax(node)]
    if let parentWithTokens = ancestorWithTokens {
      let siblings = parentWithTokens.children(viewMode: .all)
      let siblingsAfter = siblings[siblings.index(after: index)...]
      for sibling in siblingsAfter {
        if sibling.as(TokenSyntax.self)?.presence == .missing {
          // Handle missing sibling tokens
          missingNodes += [sibling]
        } else if sibling.raw.kind.isMissing {
          // Handle missing sibling nodes (e.g. MissingDeclSyntax)
          missingNodes += [sibling]
        } else if sibling.isMissingAllTokens && sibling.hasTokens {
          missingNodes += [sibling]
        } else if sibling.isCollection && sibling.children(viewMode: .sourceAccurate).count == 0 {
          // Skip over any syntax collections without any elements while looking ahead for further missing nodes.
        } else {
          // Otherwise we have found a present node, so stop looking ahead.
          break
        }
      }
    } else {
      missingNodes = []
    }

    let changes = missingNodes.enumerated().map { (index, missingNode) -> FixIt.Changes in
      if index == 0,
        let token = missingNode.as(TokenSyntax.self),
        let previousTokenKind = missingNode.previousToken(viewMode: .sourceAccurate)?.tokenKind
      {
        if token.tokenKind.isPunctuation && !previousTokenKind.isPunctuation {
          // Don't want whitespace before punctuation
          return .makePresentBeforeTrivia(token)
        } else if (token.tokenKind.isIdentifier || token.tokenKind.isDollarIdentifier) && previousTokenKind.isPunctuation {
          // Don't want whitespace after punctuation where the following token is an identifier
          return .makePresentBeforeTrivia(token)
        }
      }
      return .makePresent(missingNode)
    }
    let fixIt = FixIt(
      message: InsertTokenFixIt(missingNodes: missingNodes),
      changes: additionalChanges + changes
    )

    var notes: [Note] = []
    if missingNodes.count == 1,
      let token = missingNodes.last?.as(TokenSyntax.self),
      let matchingStartMarkerKind = token.tokenKind.matchingStartMarkerKind,
      let startToken = token.parent?.children(viewMode: .sourceAccurate).lazy.compactMap({ $0.as(TokenSyntax.self) }).first(where: { $0.tokenKind == matchingStartMarkerKind })
    {
      notes.append(Note(node: Syntax(startToken), message: MatchingOpeningTokenNote(openingToken: startToken)))
    }

    let position: AbsolutePosition
    if let overridePosition = overridePosition {
      position = overridePosition
    } else if node.shouldBeInsertedAfterNextTokenTrivia, let nextToken = node.nextToken(viewMode: .sourceAccurate) {
      position = nextToken.positionAfterSkippingLeadingTrivia
    } else {
      position = node.endPosition
    }

    addDiagnostic(
      node,
      position: position,
      MissingNodesError(missingNodes: missingNodes),
      notes: notes,
      fixIts: [fixIt],
      handledNodes: additionalHandledNodes + missingNodes.map(\.id)
    )
    return .visitChildren
  }
}
