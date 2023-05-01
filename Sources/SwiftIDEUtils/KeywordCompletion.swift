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

import SwiftSyntax

extension SyntaxProtocol {
  static func completions(at keyPath: AnyKeyPath, visitedNodeKinds: inout [SyntaxProtocol.Type]) -> (completions: Set<TokenKind>, hasRequiredToken: Bool) {
    visitedNodeKinds.append(Self.self)
    if let keyPath = keyPath as? KeyPath<Self, TokenSyntax> {
      return (Set(keyPath.tokenChoices), true)
    } else if let keyPath = keyPath as? KeyPath<Self, TokenSyntax?> {
      return (Set(keyPath.tokenChoices), false)
    } else if let value = type(of: keyPath).valueType as? SyntaxOrOptionalProtocol.Type {
      switch value.syntaxOrOptionalProtocolType {
      case .optional(let syntaxType):
        return (syntaxType.completionsAtStartOfNode(visitedNodeKinds: &visitedNodeKinds).completions, false)
      case .nonOptional(let syntaxType):
        return (syntaxType.completionsAtStartOfNode(visitedNodeKinds: &visitedNodeKinds).completions, !syntaxType.structure.isCollection)
      }
    } else {
      assertionFailure("Unexpected keypath")
      return ([], false)
    }
  }

  static func completionsAtStartOfNode(visitedNodeKinds: inout [SyntaxProtocol.Type]) -> (completions: Set<TokenKind>, hasRequiredToken: Bool) {
    if visitedNodeKinds.contains(where: { $0 == Self.self }) {
      return ([], true)
    }
    if self == Syntax.self {
      return ([], true)
    }

    var hasRequiredToken: Bool
    var completions: Set<TokenKind> = []

    switch self.structure {
    case .layout(let keyPaths):
      hasRequiredToken = false  // Only relevant if keyPaths is empty and the loop below isn't traversed
      for keyPath in keyPaths {
        let res = self.completions(at: keyPath, visitedNodeKinds: &visitedNodeKinds)
        completions.formUnion(res.completions)
        hasRequiredToken = hasRequiredToken || res.hasRequiredToken
        if hasRequiredToken {
          break
        }
      }
    case .collection(let collectionElementType):
      return collectionElementType.completionsAtStartOfNode(visitedNodeKinds: &visitedNodeKinds)
    case .choices(let choices):
      hasRequiredToken = true
      for choice in choices {
        switch choice {
        case .node(let nodeType):
          let res = nodeType.completionsAtStartOfNode(visitedNodeKinds: &visitedNodeKinds)
          completions.formUnion(res.completions)
          hasRequiredToken = hasRequiredToken && res.hasRequiredToken
        case .token(let tokenKind):
          completions.insert(tokenKind)
        }
      }
    }

    return (completions, hasRequiredToken)
  }
}

extension SyntaxProtocol {
  func completions(after keyPath: AnyKeyPath) -> Set<TokenKind> {
    var hasRequiredToken: Bool = false

    var completions: Set<TokenKind> = []
    var visitedNodeKinds: [SyntaxProtocol.Type] = []
    if case .layout(let childrenKeyPaths) = self.kind.syntaxNodeType.structure,
      let index = childrenKeyPaths.firstIndex(of: keyPath)
    {
      for keyPath in childrenKeyPaths[(index + 1)...] {
        let res = self.kind.syntaxNodeType.completions(at: keyPath, visitedNodeKinds: &visitedNodeKinds)
        completions.formUnion(res.completions)
        hasRequiredToken = res.hasRequiredToken
        if hasRequiredToken {
          break
        }
      }
    }
    if !hasRequiredToken, let parent = parent, let keyPathInParent = self.keyPathInParent {
      completions.formUnion(parent.completions(after: keyPathInParent))
    }
    return completions
  }

  public func completions(at position: AbsolutePosition) -> Set<TokenKind> {
    if position <= self.positionAfterSkippingLeadingTrivia {
      var visitedNodeKinds: [SyntaxProtocol.Type] = []
      return Self.completionsAtStartOfNode(visitedNodeKinds: &visitedNodeKinds).completions
    }
    let finder = TokenFinder(targetPosition: position)
    finder.walk(self)
    guard let found = finder.found?.previousToken(viewMode: .sourceAccurate), let parent = found.parent, let keyPathInParent = found.keyPathInParent else {
      return []
    }
    return parent.completions(after: keyPathInParent)
  }
}

/// Finds the first token whose text (ignoring trivia) starts after targetPosition.
class TokenFinder: SyntaxAnyVisitor {
  var targetPosition: AbsolutePosition
  var found: TokenSyntax? = nil

  init(targetPosition: AbsolutePosition) {
    self.targetPosition = targetPosition
    super.init(viewMode: .sourceAccurate)
  }

  override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
    if found != nil || node.endPosition < targetPosition {
      return .skipChildren
    } else {
      return .visitChildren
    }
  }

  override func visit(_ node: TokenSyntax) -> SyntaxVisitorContinueKind {
    if targetPosition <= node.positionAfterSkippingLeadingTrivia, found == nil {
      found = node
    }
    return .skipChildren
  }
}
