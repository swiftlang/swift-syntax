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
@_spi(RawSyntax) import SwiftSyntax
import SwiftBasicFormat

// MARK: - Shared code

/// Returns the bottommost node that is an ancestor of all nodes in `nodes`.
fileprivate func findCommonAncestor(_ nodes: [Syntax]) -> Syntax? {
  return findCommonAncestorOrSelf(nodes.compactMap({ $0.parent }))
}

class NoNewlinesFormat: BasicFormat {
  override func requiresLeadingNewline(_ token: TokenSyntax) -> Bool {
    return false
  }
}

fileprivate enum NodesDescriptionPart {
  case tokensWithDefaultText([TokenSyntax])
  case tokenWithoutDefaultText(TokenSyntax)
  case node(Syntax)

  func description(format: Bool) -> String? {
    switch self {
    case .tokensWithDefaultText(var tokens):
      if format {
        tokens = tokens.map({ NoNewlinesFormat(viewMode: .all).visit($0) })
      }
      if !tokens.isEmpty {
        tokens[0] = tokens[0].with(\.leadingTrivia, [])
        tokens[tokens.count - 1] = tokens[tokens.count - 1].with(\.trailingTrivia, [])
      }
      let tokenContents = tokens.map(\.description).joined()
      return "'\(tokenContents)'"
    case .tokenWithoutDefaultText(let token):
      if let childName = token.childNameInParent {
        return childName
      }
      return token.tokenKind.nameForDiagnostics
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
            let presentToken = token.with(\.presence, .present)
            newPart = .tokensWithDefaultText([presentToken])
          } else if let defaultText = rawKind.defaultText {
            let newKind = TokenKind.fromRaw(kind: rawKind, text: String(syntaxText: defaultText))
            let presentToken = token.with(\.tokenKind, newKind).with(\.presence, .present)
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

  let isOnlyTokenWithNonMissingText: Bool
  if let token = nodes.only?.as(TokenSyntax.self) {
    isOnlyTokenWithNonMissingText = token.text != ""
  } else {
    isOnlyTokenWithNonMissingText = false
  }

  // If all tokens in the parent are missing, return the parent type name unless
  // we are replacing by a single token that has explicit text, in which case we
  // return that explicit text.
  if let commonAncestor = findCommonAncestor(missingSyntaxNodes),
    commonAncestor.isMissingAllTokens,
    let firstToken = commonAncestor.firstToken(viewMode: .all),
    let lastToken = commonAncestor.lastToken(viewMode: .all),
    missingSyntaxNodes.contains(Syntax(firstToken)),
    missingSyntaxNodes.contains(Syntax(lastToken)),
    !isOnlyTokenWithNonMissingText
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
    case .regexSlash, .extendedRegexDelimiter:
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
    precondition(!missingNodes.isEmpty)
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

    let missingExpr: ExprSyntax?
    if let expr = firstMissingNode.as(MissingExprSyntax.self) {
      missingExpr = ExprSyntax(expr)
    } else if let typeExpr = firstMissingNode.parent?.as(TypeExprSyntax.self) {
      missingExpr = ExprSyntax(typeExpr)
    } else {
      missingExpr = nil
    }
    if let missingExpr = missingExpr,
      let exprList = missingExpr.parent?.as(ExprListSyntax.self),
      exprList.parent?.is(SequenceExprSyntax.self) ?? false,
      let previousSiblingIndex = exprList.index(missingExpr.index, offsetBy: -1, limitedBy: exprList.startIndex)
    {
      let previousSibling = exprList[previousSiblingIndex]
      if let previousSiblingName = previousSibling.nodeTypeNameForDiagnostics(allowBlockNames: false) {
        return "after \(previousSiblingName)"
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
    } else if let parentContextClause = parentContextClause(anchor: anchor?.parent ?? findCommonAncestor(missingNodes)) {
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
    precondition(!missingNodes.isEmpty)
    self.missingNodes = missingNodes
  }

  public var message: String { "insert \(nodesDescription(missingNodes, format: true))" }
}

// MARK: - Generate Error

extension ParseDiagnosticsGenerator {
  func handleMissingSyntax<T: SyntaxProtocol>(
    _ node: T,
    overridePosition: AbsolutePosition? = nil,
    additionalChanges: [FixIt.MultiNodeChange] = [],
    additionalHandledNodes: [SyntaxIdentifier] = []
  ) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    /// Ancestors that don't contain any tokens are not very interesting to merge diagnostics (because there can't be any missing tokens we can merge them with).
    /// Find the first ancestor that contains any tokens.
    var ancestorWithMoreTokens = node.parent
    var index = node.index
    let nodeTokens = Array(node.tokens(viewMode: .all))
    while let unwrappedParent = ancestorWithMoreTokens, Array(unwrappedParent.tokens(viewMode: .all)) == nodeTokens {
      ancestorWithMoreTokens = unwrappedParent.parent
      index = unwrappedParent.index
    }

    // Walk all upcoming sibling to see if they are also missing to handle them in this diagnostic.
    // If this is the case, handle all of them in this diagnostic.
    var missingNodes = [Syntax(node)]
    if let parentWithTokens = ancestorWithMoreTokens {
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
        } else if sibling.kind.isSyntaxCollection && sibling.children(viewMode: .sourceAccurate).count == 0 {
          // Skip over any syntax collections without any elements while looking ahead for further missing nodes.
        } else {
          // Otherwise we have found a present node, so stop looking ahead.
          break
        }
      }
    }

    let changes = missingNodes.map { FixIt.MultiNodeChange.makePresent($0) }
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
