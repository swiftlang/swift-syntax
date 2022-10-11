//===--- MissingNodesError.swift ------------------------------------------===//
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

fileprivate enum MissingNodesDescriptionPart {
  case tokensWithDefaultText([TokenSyntax])
  case tokenWithoutDefaultText(RawTokenKind)
  case node(Syntax)

  var description: String? {
    switch self {
    case .tokensWithDefaultText(let tokens):
      let tokenContents = tokens.map({ BasicFormat().visit($0).description }).joined()
      return "'\(tokenContents.trimmingSpaces())'"
    case .tokenWithoutDefaultText(let tokenKind):
      return tokenKind.nameForDiagnostics
    case .node(let node):
      if let parent = node.parent,
         let childName = parent.childNameForDiagnostics(node.index) {
        return childName
      } else {
        return node.nodeTypeNameForDiagnostics(allowBlockNames: true)
      }
    }
  }

  static func descriptionParts<S: Sequence>(for nodes: S) -> [MissingNodesDescriptionPart] where S.Element == Syntax {
    var parts: [MissingNodesDescriptionPart] = []
    for missingNode in nodes {
      if let missingToken = missingNode.as(TokenSyntax.self) {
        let newPart: MissingNodesDescriptionPart
        let (rawKind, text) = missingToken.tokenKind.decomposeToRaw()
        if let text = text, !text.isEmpty {
          let presentToken = TokenSyntax(missingToken.tokenKind, presence: .present)
          newPart = .tokensWithDefaultText([presentToken])
        } else if let defaultText = rawKind.defaultText {
          let newKind = TokenKind.fromRaw(kind: rawKind, text: String(syntaxText: defaultText))
          let presentToken = TokenSyntax(newKind, presence: .present)
          newPart = .tokensWithDefaultText([presentToken])
        } else {
          newPart = .tokenWithoutDefaultText(rawKind)
        }

        switch (parts.last, newPart) {
        case (.tokensWithDefaultText(let previousTokens), .tokensWithDefaultText(let newTokens)):
          parts[parts.count - 1] = .tokensWithDefaultText(previousTokens + newTokens)
        default:
          parts.append(newPart)
        }
      } else {
        let part = MissingNodesDescriptionPart.node(missingNode)
        if part.description == nil {
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
func missingNodesDescription<SyntaxType: SyntaxProtocol>(_ missingNodes: [SyntaxType]) -> String {
  let missingSyntaxNodes = missingNodes.map(Syntax.init)

  // If all tokens in the parent are missing, return the parent type name.
  if let commonParent = findCommonAncestor(missingSyntaxNodes),
     commonParent.isMissingAllTokens,
     let firstToken = commonParent.firstToken(viewMode: .all),
     let lastToken = commonParent.lastToken(viewMode: .all),
     missingSyntaxNodes.contains(Syntax(firstToken)),
     missingSyntaxNodes.contains(Syntax(lastToken)) {
    if let nodeTypeName = commonParent.nodeTypeNameForDiagnostics(allowBlockNames: true) {
      return nodeTypeName
    }
  }

  let partDescriptions = MissingNodesDescriptionPart.descriptionParts(for: missingSyntaxNodes).map({ $0.description ?? "syntax" })
  switch partDescriptions.count {
  case 0:
    return "syntax"
  case 1:
    return "\(partDescriptions.first!)"
  default:
    return "\(partDescriptions[0..<partDescriptions.count - 1].joined(separator: ", ")) and \(partDescriptions.last!)"
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
  private var parentContextClause: String? {
    // anchorParent is the first parent that has a type name for diagnostics.
    guard let anchorParent = findCommonAncestor(missingNodes)?.ancestorOrSelf(where: {
      $0.nodeTypeNameForDiagnostics(allowBlockNames: false) != nil
    }) else {
      return nil
    }
    let anchorTypeName = anchorParent.nodeTypeNameForDiagnostics(allowBlockNames: false)!
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
    var message = "expected \(missingNodesDescription(missingNodes))"
    if let afterClause = afterClause {
      message += " \(afterClause)"
    }
    if let parentContextClause = parentContextClause {
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

  public var message: String { "insert \(missingNodesDescription(missingNodes))" }
}

// MARK: - Generate Error

extension ParseDiagnosticsGenerator {
  func handleMissingSyntax<T: SyntaxProtocol>(_ node: T) -> SyntaxVisitorContinueKind {
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

    let fixIt = FixIt(
      message: InsertTokenFixIt(missingNodes: missingNodes),
      changes: missingNodes.map({ FixIt.Changes.makePresent(node: $0) })
    )

    var notes: [Note] = []
    if missingNodes.count == 1,
       let token = missingNodes.last?.as(TokenSyntax.self),
       let matchingStartMarkerKind = token.tokenKind.matchingStartMarkerKind,
       let startToken = token.parent?.children(viewMode: .sourceAccurate).lazy.compactMap({ $0.as(TokenSyntax.self) }).first(where: { $0.tokenKind == matchingStartMarkerKind }) {
      notes.append(Note(node: Syntax(startToken), message: MatchingOpeningTokenNote(openingToken: startToken)))
    }

    addDiagnostic(
      node,
      position: node.endPosition,
      MissingNodesError(missingNodes: missingNodes),
      notes: notes,
      fixIts: [fixIt],
      handledNodes: missingNodes.map(\.id)
    )
    return .visitChildren
  }
}
