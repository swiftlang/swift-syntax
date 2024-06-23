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
  /// Scope at the syntax node. Could be inherited from parent or introduced at the node.
  var scope: Scope? {
    switch self.syntaxNodeType {
    case is SourceFileSyntax.Type:
      FileScope(syntax: self)
    default:
      parent?.scope
    }
  }
}

protocol Scope {
  var parent: Scope? { get }

  var sourceSyntax: SyntaxProtocol { get }

  func getDeclarationFor(name: String, at syntax: SyntaxProtocol) -> Syntax?
}

extension Scope {
  var parent: Scope? {
    getParentScope(forSyntax: sourceSyntax)
  }

  private func getParentScope(forSyntax syntax: SyntaxProtocol?) -> Scope? {
    if let lookedUpScope = syntax?.scope, lookedUpScope.sourceSyntax.id == syntax?.id {
      return getParentScope(forSyntax: sourceSyntax.parent)
    } else {
      return syntax?.scope
    }
  }

  // MARK: - lookupLabeledStmts

  func lookupLabeledStmts(at syntax: SyntaxProtocol) -> [LabeledStmtSyntax] {
    var result = [LabeledStmtSyntax]()
    lookupLabeledStmtsHelper(at: syntax.parent, accumulator: &result)
    return result
  }

  private func lookupLabeledStmtsHelper(at syntax: Syntax?, accumulator: inout [LabeledStmtSyntax]) {
    guard let syntax, !syntax.is(MemberBlockSyntax.self) else { return }
    if let labeledStmtSyntax = syntax.as(LabeledStmtSyntax.self) {
      accumulator.append(labeledStmtSyntax)
      lookupLabeledStmtsHelper(at: labeledStmtSyntax.parent, accumulator: &accumulator)
    } else {
      lookupLabeledStmtsHelper(at: syntax.parent, accumulator: &accumulator)
    }
  }

  // MARK: - lookupFallthroughSourceAndDest

  func lookupFallthroughSourceAndDest(at syntax: SyntaxProtocol) -> (SwitchCaseSyntax?, SwitchCaseSyntax?) {
    guard let originalSwitchCase = lookupClosestSwitchCaseSyntaxAncestor(at: syntax) else { return (nil, nil) }

    let nextSwitchCase = lookupNextSwitchCase(at: originalSwitchCase)

    return (originalSwitchCase, nextSwitchCase)
  }

  private func lookupClosestSwitchCaseSyntaxAncestor(at syntax: SyntaxProtocol?) -> SwitchCaseSyntax? {
    guard let syntax else { return nil }

    if let switchCaseSyntax = syntax.as(SwitchCaseSyntax.self) {
      return switchCaseSyntax
    } else {
      return lookupClosestSwitchCaseSyntaxAncestor(at: syntax.parent)
    }
  }

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

  func lookupCatchNode(at syntax: Syntax) -> Syntax? {
    return lookupCatchNodeHelper(at: syntax, traversedCatchClause: false)
  }

  private func lookupCatchNodeHelper(at syntax: Syntax?, traversedCatchClause: Bool) -> Syntax? {
    guard let syntax else { return nil }

    switch syntax.syntaxNodeType {
    case is DoStmtSyntax.Type:
      if traversedCatchClause {
        return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: false)
      } else {
        return syntax
      }
    case is CatchClauseSyntax.Type:
      return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: true)
    case is TryExprSyntax.Type:
      if syntax.as(TryExprSyntax.self)!.questionOrExclamationMark != nil {
        return syntax
      } else {
        return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: traversedCatchClause)
      }
    case is FunctionDeclSyntax.Type:
      if syntax.as(FunctionDeclSyntax.self)!.signature.effectSpecifiers?.throwsClause != nil {
        return syntax
      } else {
        return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: traversedCatchClause)
      }
    default:
      return lookupCatchNodeHelper(at: syntax.parent, traversedCatchClause: traversedCatchClause)
    }
  }
}
