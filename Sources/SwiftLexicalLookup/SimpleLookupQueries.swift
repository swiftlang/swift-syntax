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

import SwiftSyntax

extension SyntaxProtocol {
  /// Returns all labeled statements available at a particular syntax node.
  ///
  /// - Returns: Available labeled statements at a particular syntax node
  /// in the exact order they appear in the source code, starting with the innermost statement.
  ///
  /// Example usage:
  /// ```swift
  /// one: while cond1 {
  ///   func foo() {
  ///     two: while cond2 {
  ///       three: while cond3 {
  ///         break // 1
  ///       }
  ///       break // 2
  ///     }
  ///   }
  ///   break // 3
  /// }
  /// ```
  /// When calling this function at the first `break`, it returns `three` and `two` in this exact order.
  /// For the second `break`, it returns only `two`.
  /// The results don't include `one`, which is unavailable at both locations due to the encapsulating function body.
  /// For `break` numbered 3, the result is `one`, as it's outside the function body and within the labeled statement.
  /// The function returns an empty array when there are no available labeled statements.
  @_spi(Experimental) public func lookupLabeledStmts() -> [LabeledStmtSyntax] {
    collectNodesOfTypeUpToFunctionBoundary(LabeledStmtSyntax.self)
  }

  /// Returns the catch node responsible for handling an error thrown at a particular syntax node.
  ///
  /// - Returns: The catch node responsible for handling an error thrown at the lookup source node.
  /// This could be a `do` statement, `try?`, `try!`, `init`, `deinit`, accessors, closures, or function declarations.
  ///
  /// Example usage:
  /// ```swift
  /// func x() {
  ///   do {
  ///     try foo()
  ///     try? bar()
  ///   } catch {
  ///     throw error
  ///   }
  /// }
  /// ```
  /// When calling this function on `foo`, it returns the `do` statement.
  /// Calling the function on `bar` results in `try?`.
  /// When used on `error`, the function returns the function declaration `x`.
  /// The function returns `nil` when there's no available catch node.
  @_spi(Experimental) public func lookupCatchNode() -> Syntax? {
    lookupCatchNodeHelper(traversedCatchClause: false)
  }

  // MARK: - lookupCatchNode

  /// Given syntax node location, finds where an error could be caught.
  /// If `traverseCatchClause` is set to `true` lookup will skip the next do statement.
  private func lookupCatchNodeHelper(traversedCatchClause: Bool) -> Syntax? {
    guard let parent else { return nil }

    switch parent.as(SyntaxEnum.self) {
    case .doStmt:
      if traversedCatchClause {
        return parent.lookupCatchNodeHelper(traversedCatchClause: false)
      } else {
        return parent
      }
    case .catchClause:
      return parent.lookupCatchNodeHelper(traversedCatchClause: true)
    case .tryExpr(let tryExpr):
      if tryExpr.questionOrExclamationMark != nil {
        return parent
      } else {
        return parent.lookupCatchNodeHelper(traversedCatchClause: traversedCatchClause)
      }
    case .functionDecl, .accessorDecl, .initializerDecl, .deinitializerDecl, .closureExpr:
      return parent
    case .exprList(let exprList):
      if let tryExpr = exprList.first?.as(TryExprSyntax.self), tryExpr.questionOrExclamationMark != nil {
        return Syntax(tryExpr)
      }
      return parent.lookupCatchNodeHelper(traversedCatchClause: traversedCatchClause)
    default:
      return parent.lookupCatchNodeHelper(traversedCatchClause: traversedCatchClause)
    }
  }

  // MARK: - walkParentTree helper methods

  /// Returns the innermost node of the specified type up to a function boundary.
  fileprivate func innermostNodeOfTypeUpToFunctionBoundary<T: SyntaxProtocol>(
    _ type: T.Type
  ) -> T? {
    collectNodesOfTypeUpToFunctionBoundary(type, stopWithFirstMatch: true).first
  }

  /// Collect syntax nodes matching the collection type up until encountering one of the specified syntax nodes.
  /// The nodes in the array are inside out, with the innermost node being the first.
  fileprivate func collectNodesOfTypeUpToFunctionBoundary<T: SyntaxProtocol>(
    _ type: T.Type,
    stopWithFirstMatch: Bool = false
  ) -> [T] {
    collectNodes(
      ofType: type,
      upTo: [
        MemberBlockSyntax.self,
        FunctionDeclSyntax.self,
        InitializerDeclSyntax.self,
        DeinitializerDeclSyntax.self,
        AccessorDeclSyntax.self,
        ClosureExprSyntax.self,
        SubscriptDeclSyntax.self,
      ],
      stopWithFirstMatch: stopWithFirstMatch
    )
  }

  /// Collect syntax nodes matching the collection type up until encountering one of the specified syntax nodes.
  private func collectNodes<T: SyntaxProtocol>(
    ofType type: T.Type,
    upTo stopAt: [SyntaxProtocol.Type],
    stopWithFirstMatch: Bool = false
  ) -> [T] {
    var matches: [T] = []
    var nextSyntax: Syntax? = Syntax(self)
    while let currentSyntax = nextSyntax {
      if stopAt.contains(where: { currentSyntax.is($0) }) {
        break
      }

      if let matchedSyntax = currentSyntax.as(T.self) {
        matches.append(matchedSyntax)
        if stopWithFirstMatch {
          break
        }
      }

      nextSyntax = currentSyntax.parent
    }

    return matches
  }
}

extension FallThroughStmtSyntax {
  /// Returns the source and destination of a `fallthrough`.
  ///
  /// - Returns: `source` as the switch case that encapsulates the `fallthrough` keyword and
  /// `destination` as the switch case that the `fallthrough` directs to.
  ///
  /// Example usage:
  /// ```swift
  /// switch value {
  /// case 2:
  ///   doSomething()
  ///   fallthrough
  /// case 1:
  ///   doSomethingElse()
  /// default:
  ///   break
  /// }
  /// ```
  /// When calling this function at the `fallthrough`, it returns `case 2` and `case 1` in this exact order.
  /// The `nil` results handle ill-formed code: there's no `source` if the `fallthrough` is outside of a case.
  /// There's no `destination` if there is no case or `default` after the source case.
  @_spi(Experimental) public func lookupFallthroughSourceAndDestintation()
    -> (source: SwitchCaseSyntax?, destination: SwitchCaseSyntax?)
  {
    guard
      let originalSwitchCase = innermostNodeOfTypeUpToFunctionBoundary(
        SwitchCaseSyntax.self
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
}
