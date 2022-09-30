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

/// Returns a string that describes `missingNodes`.
/// `missingNodes` are expected to all be children of `commonParent`.
private func missingNodesDescription(missingNodes: [Syntax], commonParent: Syntax?) -> String {
  assert(missingNodes.allSatisfy({ $0.parent == commonParent }))

  // If all tokens in the parent are missing, return the parent type name.
  if let commonParent = commonParent,
     commonParent.isMissingAllTokens,
     let firstToken = commonParent.firstToken(viewMode: .all),
     let lastToken = commonParent.lastToken(viewMode: .all),
     missingNodes.contains(Syntax(firstToken)),
     missingNodes.contains(Syntax(lastToken)) {
    switch commonParent.as(SyntaxEnum.self) {
    case .codeBlock:
      return "code block"
    case .memberDeclBlock:
      return "member block"
    default:
      if let nodeTypeName = commonParent.nodeTypeNameForDiagnostics {
        return nodeTypeName
      }
    }
  }

  enum DescriptionPart {
    case tokensWithDefaultText([TokenSyntax])
    case tokenWithoutDefaultText(RawTokenKind)
    case node(Syntax)

    var description: String {
      switch self {
      case .tokensWithDefaultText(let tokens):
        let tokenContents = tokens.map({ Format().format(syntax: $0).description }).joined()
        return "'\(tokenContents.trimmingSpaces())'"
      case .tokenWithoutDefaultText(let tokenKind):
        return tokenKind.nameForDiagnostics
      case .node(let node):
        if let parent = node.parent,
           let childName = parent.childNameForDiagnostics(node.index) {
          return "\(childName)"
        } else {
          return "\(node.nodeTypeNameForDiagnostics ?? "syntax")"
        }
      }
    }
  }

  var parts: [DescriptionPart] = []
  for missingNode in missingNodes {
    if let missingToken = missingNode.as(TokenSyntax.self) {
      let newPart: DescriptionPart
      let (rawKind, text) = missingToken.tokenKind.decomposeToRaw()
      if let text = text, !text.isEmpty {
        let presentToken = TokenSyntax(missingToken.tokenKind, presence: .present)
        newPart = .tokensWithDefaultText([presentToken])
      } else {
        if let defaultText = rawKind.defaultText {
          let newKind = TokenKind.fromRaw(kind: rawKind, text: String(syntaxText: defaultText))
          let presentToken = TokenSyntax(newKind, presence: .present)
          newPart = .tokensWithDefaultText([presentToken])
        } else {
          newPart = .tokenWithoutDefaultText(rawKind)
        }
      }

      switch (parts.last, newPart) {
      case (.tokensWithDefaultText(let previousTokens), .tokensWithDefaultText(let newTokens)):
        parts[parts.count - 1] = .tokensWithDefaultText(previousTokens + newTokens)
      default:
        parts.append(newPart)
      }
    } else {
      parts.append(.node(missingNode))
    }
  }
  let partDescriptions = parts.map({ $0.description })
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

// MARK: - Error

public struct MissingNodesError: ParserError {
  public let missingNodes: [Syntax]
  public let commonParent: Syntax?

  init(missingNodes: [Syntax]) {
    assert(!missingNodes.isEmpty)
    self.missingNodes = missingNodes
    self.commonParent = missingNodes.first?.parent
    assert(missingNodes.allSatisfy({ $0.parent == self.commonParent }))
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
    guard let anchorParent = commonParent?.ancestorOrSelf(where: { $0.nodeTypeNameForDiagnostics != nil }) else {
      return nil
    }
    let anchorTypeName = anchorParent.nodeTypeNameForDiagnostics!
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
    var message = "expected \(missingNodesDescription(missingNodes: missingNodes, commonParent: commonParent))"
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
  public let commonParent: Syntax?

  init(missingNodes: [Syntax]) {
    assert(!missingNodes.isEmpty)
    self.missingNodes = missingNodes
    self.commonParent = missingNodes.first?.parent
    assert(missingNodes.allSatisfy({ $0.parent == self.commonParent }))
  }

  public var message: String { "Insert \(missingNodesDescription(missingNodes: missingNodes, commonParent: commonParent))" }
}

// MARK: - Generate Error

extension ParseDiagnosticsGenerator {
  func handleMissingSyntax<T: SyntaxProtocol>(_ node: T) -> SyntaxVisitorContinueKind {
    if shouldSkip(node) {
      return .skipChildren
    }

    // Walk all upcoming sibling to see if they are also missing to handle them in this diagnostic.
    // If this is the case, handle all of them in this diagnostic.
    var missingNodes = [Syntax(node)]
    if let parent = node.parent {
      let siblings = parent.children(viewMode: .all)
      let siblingsAfter = siblings[siblings.index(after: node.index)...]
      for sibling in siblingsAfter {
        if sibling.as(TokenSyntax.self)?.presence == .missing {
          // Handle missing sibling tokens
          missingNodes += [sibling]
        } else if sibling.raw.kind.isMissing {
          // Handle missing sibling nodes (e.g. MissingDeclSyntax)
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
      changes: missingNodes.map(FixIt.Change.makePresent)
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
