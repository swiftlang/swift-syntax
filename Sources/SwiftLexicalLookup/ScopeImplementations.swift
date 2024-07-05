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
  /// Parent scope of this syntax node, or scope introduced by this syntax node.
  var scope: ScopeSyntax? {
    switch Syntax(self).as(SyntaxEnum.self) {
    case .sourceFile(let sourceFile):
      sourceFile
    case .codeBlock(let codeBlock):
      codeBlock
    case .forStmt(let forStmt):
      forStmt
    case .closureExpr(let closureExpr):
      closureExpr
    case .whileStmt(let whileStmt):
      whileStmt
    case .ifExpr(let ifExpr):
      ifExpr
    case .memberBlock(let memberBlock):
      memberBlock
    default:
      self.parent?.scope
    }
  }
}

extension SourceFileSyntax: ScopeSyntax {
  var parentScope: ScopeSyntax? {
    nil
  }

  var introducedNames: [LookupName] {
    []
  }

  func lookup(for name: String, at syntax: SyntaxProtocol) -> [LookupName] {
    []
  }
}

extension CodeBlockSyntax: ScopeSyntax {
  var introducedNames: [LookupName] {
    statements.flatMap { codeBlockItem in
      LookupName.getNames(from: codeBlockItem.item)
    }
  }

  func lookup(for name: String, at syntax: SyntaxProtocol) -> [LookupName] {
    defaultLookupImplementation(for: name, at: syntax, positionSensitive: true)
  }
}

extension ForStmtSyntax: ScopeSyntax {
  var introducedNames: [LookupName] {
    LookupName.getNames(from: pattern)
  }

  func lookup(for name: String, at syntax: SyntaxProtocol) -> [LookupName] {
    defaultLookupImplementation(for: name, at: syntax)
  }
}

extension ClosureExprSyntax: ScopeSyntax {
  var introducedNames: [LookupName] {
    signature?.parameterClause?.children(viewMode: .sourceAccurate).flatMap { parameter in
      if let parameterList = parameter.as(ClosureParameterListSyntax.self) {
        parameterList.children(viewMode: .sourceAccurate).flatMap { parameter in
          LookupName.getNames(from: parameter)
        }
      } else {
        LookupName.getNames(from: parameter)
      }
    } ?? []
  }

  func lookup(for name: String, at syntax: SyntaxProtocol) -> [LookupName] {
    defaultLookupImplementation(for: name, at: syntax)
  }
}

extension WhileStmtSyntax: ScopeSyntax {
  var introducedNames: [LookupName] {
    conditions.flatMap { element in
      LookupName.getNames(from: element.condition)
    }
  }

  func lookup(for name: String, at syntax: SyntaxProtocol) -> [LookupName] {
    defaultLookupImplementation(for: name, at: syntax)
  }
}

extension IfExprSyntax: ScopeSyntax {
  var parentScope: ScopeSyntax? {
    getParent(for: self.parent, previousIfElse: self.elseKeyword == nil)
  }

  /// Finds the parent scope, omitting parent `if` statements if part of their `else if` clause.
  private func getParent(for syntax: Syntax?, previousIfElse: Bool) -> ScopeSyntax? {
    guard let syntax else { return nil }

    if let lookedUpScope = syntax.scope, lookedUpScope.id != self.id {
      if let currentIfExpr = lookedUpScope.as(IfExprSyntax.self), previousIfElse {
        return getParent(for: syntax.parent, previousIfElse: currentIfExpr.elseKeyword == nil)
      } else {
        return lookedUpScope
      }
    } else {
      return getParent(for: syntax.parent, previousIfElse: previousIfElse)
    }
  }

  var introducedNames: [LookupName] {
    conditions.flatMap { element in
      LookupName.getNames(from: element.condition)
    }
  }

  func lookup(for name: String, at syntax: SyntaxProtocol) -> [LookupName] {
    if let elseBody, elseBody.position <= syntax.position, elseBody.endPosition >= syntax.position {
      parentScope?.lookup(for: name, at: syntax) ?? []
    } else {
      defaultLookupImplementation(for: name, at: syntax, positionSensitive: true)
    }
  }
}

extension MemberBlockSyntax: ScopeSyntax {
  var introducedNames: [LookupName] {
    members.flatMap { member in
      LookupName.getNames(from: member.decl)
    }
  }

  func lookup(for name: String, at syntax: SyntaxProtocol) -> [LookupName] {
    defaultLookupImplementation(for: name, at: syntax)
  }
}
