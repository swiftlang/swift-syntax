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
    if let scopeSyntax = Syntax(self).asProtocol(SyntaxProtocol.self) as? ScopeSyntax {
      scopeSyntax
    } else {
      self.parent?.scope
    }
  }
}

@_spi(Experimental) extension SourceFileSyntax: ScopeSyntax {
  public var introducedNames: [LookupName] {
    introducedNames(using: .memberBlockUpToLastDecl)
  }

  public func introducedNames(using nameIntroductionStrategy: FileScopeNameIntroductionStrategy) -> [LookupName] {
    switch nameIntroductionStrategy {
    case .memberBlockUpToLastDecl:
      var encounteredNonDeclaration = false

      return statements.flatMap { codeBlockItem in
        let item = codeBlockItem.item

        if encounteredNonDeclaration {
          return LookupName.getNames(from: item, accessibleAfter: codeBlockItem.endPosition)
        } else {
          if item.is(DeclSyntax.self) || item.is(VariableDeclSyntax.self) {
            return LookupName.getNames(from: item)
          } else {
            encounteredNonDeclaration = true
            return LookupName.getNames(from: item, accessibleAfter: codeBlockItem.endPosition)
          }
        }
      }
    case .codeBlock:
      return statements.flatMap { codeBlockItem in
        LookupName.getNames(from: codeBlockItem.item, accessibleAfter: codeBlockItem.endPosition)
      }
    case .memberBlock:
      return statements.flatMap { codeBlockItem in
        LookupName.getNames(from: codeBlockItem.item)
      }
    }
  }

  public func lookup(
    for name: String?,
    at syntax: SyntaxProtocol,
    with configDict: LookupConfigDictionary
  ) -> [LookupResult] {
    let nameIntroductionStrategy = configDict[FileScopeNameIntroductionStrategy.self] ?? .memberBlockUpToLastDecl

    let names = introducedNames(using: nameIntroductionStrategy)
      .filter { introducedName in
        does(name: name, referTo: introducedName, at: syntax)
      }

    return names.isEmpty
      ? [] : [.fromFileScope(self, withNames: names, nameIntroductionStrategy: nameIntroductionStrategy)]
  }
}

@_spi(Experimental) extension CodeBlockSyntax: ScopeSyntax {
  public var introducedNames: [LookupName] {
    statements.flatMap { codeBlockItem in
      LookupName.getNames(from: codeBlockItem.item, accessibleAfter: codeBlockItem.endPosition)
    }
  }

  public func lookup(
    for name: String?,
    at syntax: SyntaxProtocol,
    with configDict: LookupConfigDictionary
  ) -> [LookupResult] {
    var result = [LookupResult]()
    var currentChunk = [LookupName]()

    for codeBlockItem in statements {
      if let introducingToParentScope = Syntax(codeBlockItem.item).asProtocol(SyntaxProtocol.self)
        as? IntroducingToParentScopeSyntax
      {
        if !currentChunk.isEmpty {
          result.append(.fromScope(self, withNames: currentChunk))
          currentChunk = []
        }

        result.append(contentsOf: introducingToParentScope.introducedToParent(for: name, at: syntax, with: configDict))
      } else {
        currentChunk.append(
          contentsOf:
            LookupName.getNames(
              from: codeBlockItem.item,
              accessibleAfter: codeBlockItem.endPosition
            ).filter { introducedName in
              does(name: name, referTo: introducedName, at: syntax)
            }
        )
      }
    }

    if !currentChunk.isEmpty {
      result.append(.fromScope(self, withNames: currentChunk))
      currentChunk = []
    }

    return result.reversed() + lookupInParent(for: name, at: syntax, with: configDict)
  }
}

@_spi(Experimental) extension ForStmtSyntax: ScopeSyntax {
  public var introducedNames: [LookupName] {
    LookupName.getNames(from: pattern)
  }
}

@_spi(Experimental) extension ClosureExprSyntax: ScopeSyntax {
  public var introducedNames: [LookupName] {
    let captureNames =
      signature?.capture?.children(viewMode: .sourceAccurate).flatMap { child in
        if let captureList = child.as(ClosureCaptureListSyntax.self) {
          captureList.children(viewMode: .sourceAccurate).flatMap { capture in
            LookupName.getNames(from: capture)
          }
        } else {
          LookupName.getNames(from: child)
        }
      } ?? []

    let parameterNames =
      signature?.parameterClause?.children(viewMode: .sourceAccurate).flatMap { parameter in
        if let parameterList = parameter.as(ClosureParameterListSyntax.self) {
          parameterList.children(viewMode: .sourceAccurate).flatMap { parameter in
            LookupName.getNames(from: parameter)
          }
        } else {
          LookupName.getNames(from: parameter)
        }
      } ?? []

    return captureNames + parameterNames
  }
}

@_spi(Experimental) extension WhileStmtSyntax: ScopeSyntax {
  public var introducedNames: [LookupName] {
    conditions.flatMap { element in
      LookupName.getNames(from: element.condition)
    }
  }
}

@_spi(Experimental) extension IfExprSyntax: ScopeSyntax {
  public var parentScope: ScopeSyntax? {
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

  public var introducedNames: [LookupName] {
    conditions.flatMap { element in
      LookupName.getNames(from: element.condition, accessibleAfter: element.endPosition)
    }
  }

  public func lookup(
    for name: String?,
    at syntax: SyntaxProtocol,
    with configDict: LookupConfigDictionary
  ) -> [LookupResult] {
    if let elseBody, elseBody.position <= syntax.position, elseBody.endPosition >= syntax.position {
      lookupInParent(for: name, at: syntax, with: configDict)
    } else {
      defaultLookupImplementation(for: name, at: syntax, with: configDict)
    }
  }
}

@_spi(Experimental) extension MemberBlockSyntax: ScopeSyntax {
  public var introducedNames: [LookupName] {
    members.flatMap { member in
      LookupName.getNames(from: member.decl)
    }
  }
}

@_spi(Experimental) extension GuardStmtSyntax: IntroducingToParentScopeSyntax {
  public func introducedToParent(
    for name: String?,
    at syntax: SwiftSyntax.SyntaxProtocol,
    with configDict: LookupConfigDictionary
  ) -> [LookupResult] {
    let names = conditions.flatMap { element in
      LookupName.getNames(from: element.condition, accessibleAfter: element.endPosition)
    }.filter { introducedName in
      does(name: name, referTo: introducedName, at: syntax)
    }

    return names.isEmpty ? [] : [.fromScope(self, withNames: names)]
  }

  public var introducedNames: [LookupName] {
    []
  }

  public func lookup(
    for name: String?,
    at syntax: SyntaxProtocol,
    with configDict: LookupConfigDictionary
  ) -> [LookupResult] {
    if body.position <= syntax.position && body.endPosition >= syntax.position {
      lookupInParent(for: name, at: self, with: configDict) // Should we add a new config that will skip certain scopes in lookup? Could be more consistent.
    } else {
      defaultLookupImplementation(for: name, at: syntax, with: configDict)
    }
  }
}
