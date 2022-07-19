//===--------- SyntaxComparison.swift - Syntax Comparison -----------------===//
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
//
// Utility APIs to compare two difference syntax trees for equivalence.
//
//===----------------------------------------------------------------------===//

public enum DifferenceReason {
  case nodeType, presence, missingNode, additionalNode, trivia, tokenKind, tokenText
}

public struct TreeDifference {
  public let node: Syntax
  public let comparison: Syntax
  public let reason: DifferenceReason

  public init(lhs: Syntax, rhs: Syntax, reason: DifferenceReason) {
    self.node = lhs
    self.comparison = rhs
    self.reason = reason
  }
}

public extension Syntax {
  func isEquivalent(to other: Syntax, includeTrivia: Bool = false) -> DifferenceReason? {
    if syntaxNodeType != other.syntaxNodeType {
      return .nodeType
    }

    if isPresent != other.isPresent {
      return .presence
    }

    if let token = `as`(TokenSyntax.self), let otherToken = other.as(TokenSyntax.self) {
      if token.tokenKind.kind != otherToken.tokenKind.kind {
        return .tokenKind
      }
      if token.text != otherToken.text {
        return .tokenText
      }
      if includeTrivia && (leadingTrivia != other.leadingTrivia ||
                           trailingTrivia != other.trailingTrivia) {
        return .trivia
      }
    }
    return nil
  }

  func findFirstDifference(to other: Syntax, includeTrivia: Bool = false) -> TreeDifference? {
    if let reason = isEquivalent(to: other, includeTrivia: includeTrivia) {
      return TreeDifference(lhs: self, rhs: other, reason: reason)
    }

    var iterator = children.makeIterator()
    var otherIterator = other.children.makeIterator()
    while let child = iterator.next() {
      guard let otherChild = otherIterator.next() else {
        return TreeDifference(lhs: child, rhs: other, reason: .additionalNode)
      }

      if let diff = child.findFirstDifference(to: otherChild, includeTrivia: includeTrivia) {
        return diff
      }
    }

    if let otherChild = otherIterator.next() {
      return TreeDifference(lhs: self, rhs: otherChild, reason: .missingNode)
    }
    return nil
  }
}
