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
//
// Utility APIs to compare two difference syntax trees for structural
// equivalence.
//
//===----------------------------------------------------------------------===//

#if swift(>=6)
public import SwiftSyntax
#else
import SwiftSyntax
#endif

public enum DifferenceReason {
  case nodeType, presence, missingNode, additionalNode, trivia, token
}

public struct TreeDifference {
  /// The `node` that's different to `baseline`, unless `reason` is
  /// `.missingNode`. In that case it's actually the parent that's missing a
  /// child node.
  public let node: Syntax
  /// The corresponding `baseline` that does not match `node`, unless `reason`
  /// is `.additionalNode`. In that case it's what would be the parent (if the
  /// baseline node existed).
  public let baseline: Syntax
  public let reason: DifferenceReason

  public init(node: some SyntaxProtocol, baseline: some SyntaxProtocol, reason: DifferenceReason) {
    self.node = Syntax(node)
    self.baseline = Syntax(baseline)
    self.reason = reason
  }
}

extension TreeDifference: CustomDebugStringConvertible {
  public var debugDescription: String {
    let includeTrivia = reason == .trivia

    let expectedConverter = SourceLocationConverter(fileName: "Baseline.swift", tree: baseline.root)
    let actualConverter = SourceLocationConverter(fileName: "Actual.swift", tree: node.root)

    let expectedDesc = baseline.debugDescription(includeTrivia: includeTrivia, converter: expectedConverter)
    let actualDesc = node.debugDescription(includeTrivia: includeTrivia, converter: actualConverter)

    let message: String
    switch reason {
    case .nodeType, .presence, .trivia, .token:
      message = """
        Trees do not match due to \(reason) in:
        \(actualDesc)
        when expecting:
        \(expectedDesc)
        """
    case .missingNode:
      message = """
        Trees do not match due to a missing node:
        \(expectedDesc)
        in parent:
        \(actualDesc)
        """
    case .additionalNode:
      message = """
        Trees do not match due to an additional node:
        \(actualDesc)
        in parent:
        \(expectedDesc)
        """
    }

    return """
      \(message)

      Full Expected Tree:
      \(baseline.root.debugDescription(includeTrivia: includeTrivia, converter: expectedConverter, mark: baseline))

      Full Actual Tree:
      \(node.root.debugDescription(includeTrivia: includeTrivia, converter: actualConverter, mark: node))
      """
  }
}

public extension SyntaxProtocol {
  /// Compares the current tree against a `baseline`, returning the first
  /// difference it finds.
  func findFirstDifference(baseline: some SyntaxProtocol, includeTrivia: Bool = false) -> TreeDifference? {
    if let reason = isDifferent(baseline: baseline, includeTrivia: includeTrivia) {
      return TreeDifference(node: self, baseline: baseline, reason: reason)
    }

    var iterator = children(viewMode: .all).makeIterator()
    var baseIterator = baseline.children(viewMode: .all).makeIterator()
    while let child = iterator.next() {
      guard let baselineChild = baseIterator.next() else {
        return TreeDifference(node: child, baseline: baseline, reason: .additionalNode)
      }

      if let diff = child.findFirstDifference(baseline: baselineChild, includeTrivia: includeTrivia) {
        return diff
      }
    }

    if let baseChild = baseIterator.next() {
      return TreeDifference(node: self, baseline: baseChild, reason: .missingNode)
    }
    return nil
  }

  private func isDifferent(baseline: some SyntaxProtocol, includeTrivia: Bool = false) -> DifferenceReason? {
    if syntaxNodeType != baseline.syntaxNodeType {
      return .nodeType
    }

    if self.is(TokenSyntax.self) {
      if let token = Syntax(self).as(TokenSyntax.self), let baselineToken = Syntax(baseline).as(TokenSyntax.self) {
        if token.presence != baselineToken.presence {
          return .presence
        }
        if token.tokenKind != baselineToken.tokenKind {
          return .token
        }
        if includeTrivia && (token.leadingTrivia != baselineToken.leadingTrivia || token.trailingTrivia != baselineToken.trailingTrivia) {
          return .trivia
        }
      }
    }
    return nil
  }
}
