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

@_spi(RawSyntax) import SwiftSyntax

// MARK: - Unexpected nodes

extension RawUnexpectedNodesSyntax {
  /// Returns `true` if this contains a token that satisfies `condition`.
  func containsToken(where condition: (RawTokenSyntax) -> Bool) -> Bool {
    return self.elements.contains(where: { node in
      if let token = node.as(RawTokenSyntax.self) {
        return condition(token)
      } else {
        return false
      }
    })
  }

  /// If `nodes` is not empty, construct a `RawUnexpectedNodesSyntax`
  /// containing those tokens, otherwise return `nil`.
  init?<SyntaxType: RawSyntaxNodeProtocol>(_ nodes: [SyntaxType], arena: SyntaxArena) {
    if nodes.isEmpty {
      return nil
    } else {
      self.init(elements: nodes.map(RawSyntax.init), arena: arena)
    }
  }

  /// If `nodes` contains non-`nil` values, construct a `RawUnexpectedNodesSyntax`
  /// containing those tokens, otherwise return `nil`.
  init?<SyntaxType: RawSyntaxNodeProtocol>(_ nodes: [SyntaxType?], arena: SyntaxArena) {
    self.init(nodes.compactMap({ $0 }), arena: arena)
  }
}

// MARK: Combining unexpected nodes

/// Implementation detail of `RawUnexpectedNodesSyntax.init(combining:arena)`.
protocol UnexpectedNodesCombinable {
  var elements: [RawSyntax] { get }
}

extension Array: UnexpectedNodesCombinable where Element: UnexpectedNodesCombinable {
  var elements: [RawSyntax] { self.flatMap { $0.elements } }
}

extension Optional: UnexpectedNodesCombinable where Wrapped: UnexpectedNodesCombinable {
  var elements: [RawSyntax] {
    if let self = self {
      return self.elements
    } else {
      return []
    }
  }
}

extension RawTokenSyntax: UnexpectedNodesCombinable {
  var elements: [RawSyntax] {
    return [RawSyntax(self)]
  }
}

extension RawUnexpectedNodesSyntax: UnexpectedNodesCombinable {}

extension RawUnexpectedNodesSyntax {
  init?<T1: UnexpectedNodesCombinable, T2: UnexpectedNodesCombinable>(combining syntax1: T1, _ syntax2: T2, arena: SyntaxArena) {
    self.init(syntax1.elements + syntax2.elements, arena: arena)
  }

  init?<T1: UnexpectedNodesCombinable, T2: UnexpectedNodesCombinable, T3: UnexpectedNodesCombinable>(combining syntax1: T1, _ syntax2: T2, _ syntax3: T3, arena: SyntaxArena) {
    self.init(syntax1.elements + syntax2.elements + syntax3.elements, arena: arena)
  }
}

// MARK: - Misc

extension SyntaxText {
  var isEditorPlaceholder: Bool {
    return self.starts(with: SyntaxText("<#")) && self.hasSuffix(SyntaxText("#>"))
  }
}

extension RawTokenKind {
  func `is`(any kinds: [RawTokenKind]) -> Bool {
    return kinds.contains(self)
  }
}
