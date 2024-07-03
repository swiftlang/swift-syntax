//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftSyntax

extension SyntaxProtocol {
  /// Given syntax node position, returns all available labeled statements.
  @_spi(Compiler) @_spi(Testing) public func lookupLabeledStmts() -> [LabeledStmtSyntax] {
    return lookupLabeledStmts(at: self)
  }

  /// Given syntax node position, returns the current switch case and it's fallthrough destination.
  @_spi(Compiler) @_spi(Testing) public func lookupFallthroughSourceAndDest()
    -> (source: SwitchCaseSyntax?, destination: SwitchCaseSyntax?)
  {
    return lookupFallthroughSourceAndDestination(at: self)
  }

  /// Given syntax node position, returns the closest ancestor catch node.
  @_spi(Compiler) @_spi(Testing) public func lookupCatchNode() -> Syntax? {
    return lookupCatchNodeHelper(at: Syntax(self), traversedCatchClause: false)
  }

  // MARK: - lookupLabeledStmts

  /// Given syntax node position, returns all available labeled statements.
  private func lookupLabeledStmts(at syntax: SyntaxProtocol) -> [LabeledStmtSyntax] {
    return walkParentTreeUpToFunctionBoundary(
      at: syntax.parent,
      collect: LabeledStmtSyntax.self
    )
  }

  // MARK: - lookupFallthroughSourceAndDest

  /// Given syntax node position, returns the current switch case and it's fallthrough destination.
  private func lookupFallthroughSourceAndDestination(at syntax: SyntaxProtocol)
    -> (SwitchCaseSyntax?, SwitchCaseSyntax?)
  {
    guard
      let originalSwitchCase = walkParentTreeUpToFunctionBoundary(
        at: Syntax(syntax),
        collect: SwitchCaseSyntax.self
      )
    else {
      return (nil, nil)
    }

    let nextSwitchCase = lookupNextSwitchCase(at: originalSwitchCase)

    return (originalSwitchCase, nextSwitchCase)
  }

  /// Given a switch case, returns the case that follows according to the parent.
  private func lookupNextSwitchCase(at switchCaseSyntax: SwitchCaseSyntax) -> SwitchCaseSyntax? {
    guard let switchCaseListSyntax = switchCaseSyntax.parent?.as(SwitchCaseListSyntax.self) else { return nil }

    var visitedOriginalCase = false

    for child in switchCaseListSyntax.children(viewMode: .sourceAccurate) {
      if let thisCase = child.as(SwitchCaseSyntax.self) {
        if thisCase.id == switchCaseSyntax.id {
          visitedOriginalCase = true
        } else if visitedOriginalCase {
          return thisCase
        }
      }
    }

    return nil
  }

  // MARK: - lookupCatchNode

  /// Given syntax node location, finds where an error could be caught. If set to `true`, `traverseCatchClause`lookup will skip the next do statement.
  private func lookupCatchNodeHelper(at syntax: Syntax?, traversedCatchClause: Bool) -> Syntax? {
    guard let syntax else { return nil }

    switch syntax.as(SyntaxEnum.self) {
    case .doStmt:
      if traversedCatchClause {
        return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: false)
      } else {
        return syntax
      }
    case .catchClause:
      return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: true)
    case .tryExpr(let tryExpr):
      if tryExpr.questionOrExclamationMark != nil {
        return syntax
      } else {
        return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: traversedCatchClause)
      }
    case .functionDecl, .accessorDecl, .initializerDecl, .deinitializerDecl, .closureExpr:
      return syntax
    case .exprList(let exprList):
      if let tryExpr = exprList.first?.as(TryExprSyntax.self), tryExpr.questionOrExclamationMark != nil {
        return Syntax(tryExpr)
      }
      return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: traversedCatchClause)
    default:
      return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: traversedCatchClause)
    }
  }

  // MARK: - walkParentTree helper methods

  /// Callect the first syntax node matching the collection type up to a function boundary.
  private func walkParentTreeUpToFunctionBoundary<T: SyntaxProtocol>(
    at syntax: Syntax?,
    collect: T.Type
  ) -> T? {
    walkParentTreeUpToFunctionBoundary(at: syntax, collect: collect, stopWithFirstMatch: true).first
  }

  /// Callect syntax nodes matching the collection type up to a function boundary.
  private func walkParentTreeUpToFunctionBoundary<T: SyntaxProtocol>(
    at syntax: Syntax?,
    collect: T.Type,
    stopWithFirstMatch: Bool = false
  ) -> [T] {
    walkParentTree(
      upTo: [
        MemberBlockSyntax.self,
        FunctionDeclSyntax.self,
        InitializerDeclSyntax.self,
        DeinitializerDeclSyntax.self,
        AccessorDeclSyntax.self,
        ClosureExprSyntax.self,
      ],
      at: syntax,
      collect: collect,
      stopWithFirstMatch: stopWithFirstMatch
    )
  }

  /// Callect syntax nodes matching the collection type up until encountering one of the specified syntax nodes.
  private func walkParentTree<T: SyntaxProtocol>(
    upTo stopAt: [SyntaxProtocol.Type],
    at syntax: Syntax?,
    collect: T.Type,
    stopWithFirstMatch: Bool = false
  ) -> [T] {
    guard let syntax, !stopAt.contains(where: { syntax.is($0) }) else { return [] }
    if let matchedSyntax = syntax.as(T.self) {
      if stopWithFirstMatch {
        return [matchedSyntax]
      } else {
        return [matchedSyntax]
          + walkParentTree(
            upTo: stopAt,
            at: syntax.parent,
            collect: collect,
            stopWithFirstMatch: stopWithFirstMatch
          )
      }
    } else {
      return walkParentTree(
        upTo: stopAt,
        at: syntax.parent,
        collect: collect,
        stopWithFirstMatch: stopWithFirstMatch
      )
    }
  }
}
