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

@_spi(Experimental) extension SyntaxProtocol {
  /// Parent scope of this syntax node, or scope introduced by this syntax node.
  var scope: ScopeSyntax? {
    if let scopeSyntax = Syntax(self).asProtocol(SyntaxProtocol.self) as? ScopeSyntax {
      return scopeSyntax
    } else {
      return self.parent?.scope
    }
  }
}

@_spi(Experimental) extension SourceFileSyntax: SequentialScopeSyntax {
  /// All names introduced in the file scope
  /// according to the default strategy: `memberBlockUpToLastDecl`.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    introducedNames(using: .memberBlockUpToLastDecl)
  }

  /// All names introduced in the file scope
  /// using the provided configuration.
  ///
  /// Example usage:
  /// ```swift
  /// class a {}
  /// class b {
  ///   // <--
  /// }
  /// let c = 0
  /// class d {}
  /// if true {}
  /// class e {}
  /// let f = 0
  /// ```
  /// During lookup, according to different configurations,
  /// names available at the marked place are:
  /// - for `memberBlockUpToLastDecl` - a, b, c, d
  /// - for `memberBlock` - a, b, c, d, e, f
  /// - for `codeBlock` - a
  @_spi(Experimental) public func introducedNames(using fileScopeHandling: FileScopeHandlingConfig) -> [LookupName] {
    switch fileScopeHandling {
    case .memberBlockUpToLastDecl:
      var encounteredNonDeclaration = false

      return statements.flatMap { codeBlockItem in
        let item = codeBlockItem.item

        if encounteredNonDeclaration {
          return LookupName.getNames(from: item, accessibleAfter: codeBlockItem.endPosition)
        } else {
          if item.is(DeclSyntax.self) {
            return LookupName.getNames(from: item)
          } else {
            encounteredNonDeclaration = true
            return LookupName.getNames(from: item, accessibleAfter: codeBlockItem.endPosition)
          }
        }
      }
    case .memberBlock:
      return statements.flatMap { codeBlockItem in
        LookupName.getNames(from: codeBlockItem.item)
      }
    }
  }

  /// Returns names matching lookup using provided file
  /// scope handling configuration.
  ///
  /// Example usage:
  /// ```swift
  /// class a {}
  /// class b {
  ///   // <--
  /// }
  /// let c = 0
  /// class d {}
  /// if true {}
  /// class e {}
  /// let f = 0
  /// ```
  /// According to different configurations,
  /// names available at the marked place are:
  /// - for `memberBlockUpToLastDecl` - a, b, c, d
  /// - for `memberBlock` - a, b, c, d, e, f
  /// - for `codeBlock` - a
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    switch config.fileScopeHandling {
    case .memberBlock:
      let names = introducedNames(using: .memberBlock)
        .filter { lookupName in
          checkIdentifier(identifier, refersTo: lookupName, at: lookUpPosition)
        }

      return names.isEmpty ? [] : [.fromFileScope(self, withNames: names)]
    case .memberBlockUpToLastDecl:
      var members: [LookupName] = []
      var sequentialItems: [CodeBlockItemSyntax] = []
      var encounteredNonDeclaration = false

      for codeBlockItem in statements {
        let item = codeBlockItem.item

        if encounteredNonDeclaration {
          sequentialItems.append(codeBlockItem)
        } else if item.is(DeclSyntax.self) {
          let foundNames = LookupName.getNames(from: item)
          members.append(
            contentsOf: foundNames.filter { checkIdentifier(identifier, refersTo: $0, at: lookUpPosition) }
          )
        } else {
          encounteredNonDeclaration = true
          sequentialItems.append(codeBlockItem)
        }
      }

      let sequentialNames = sequentialLookup(
        in: sequentialItems,
        identifier,
        at: lookUpPosition,
        with: config
      )

      return (members.isEmpty ? [] : [.fromFileScope(self, withNames: members)]) + sequentialNames
    }
  }
}

@_spi(Experimental) extension CodeBlockSyntax: SequentialScopeSyntax {
  /// Names introduced in the code block scope
  /// accessible after their declaration.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    statements.flatMap { codeBlockItem in
      LookupName.getNames(from: codeBlockItem.item, accessibleAfter: codeBlockItem.endPosition)
    }
  }

  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    sequentialLookup(
      in: statements,
      identifier,
      at: lookUpPosition,
      with: config
    )
  }
}

@_spi(Experimental) extension ForStmtSyntax: ScopeSyntax {
  /// Names introduced in the `for` body.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    LookupName.getNames(from: pattern)
  }
}

@_spi(Experimental) extension ClosureExprSyntax: ScopeSyntax {
  /// All names introduced by the closure signature.
  /// Could be closure captures or (shorthand) parameters.
  ///
  /// Example:
  /// ```swift
  /// let x = { [weak self, a] b, _ in
  ///   // <--
  /// }
  /// ```
  /// During lookup, names available at the marked place are:
  /// `self`, a, b.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    let captureNames =
      signature?.capture?.items.flatMap { element in
        LookupName.getNames(from: element)
      } ?? []

    let parameterNames =
      signature?.parameterClause?.children(viewMode: .sourceAccurate).flatMap { parameter in
        if let parameterList = parameter.as(ClosureParameterListSyntax.self) {
          return parameterList.children(viewMode: .sourceAccurate).flatMap { parameter in
            LookupName.getNames(from: parameter)
          }
        } else {
          return LookupName.getNames(from: parameter)
        }
      } ?? []

    return captureNames + parameterNames
  }
}

@_spi(Experimental) extension WhileStmtSyntax: ScopeSyntax {
  /// Names introduced by the `while` loop by its conditions.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    conditions.flatMap { element in
      LookupName.getNames(from: element.condition)
    }
  }
}

@_spi(Experimental) extension IfExprSyntax: ScopeSyntax {
  /// Parent scope, omitting ancestor `if` statements if part of their `else if` clause.
  @_spi(Experimental) public var parentScope: ScopeSyntax? {
    getParent(for: self.parent, previousIfElse: self.elseKeyword == nil)
  }

  /// Finds parent scope, omitting ancestor `if` statements if part of their `else if` clause.
  ///
  /// Example:
  /// ```swift
  /// func foo() {
  ///   if let a = x {
  ///     // <--
  ///   } else if let b {
  ///     // <--
  ///   } else if y == 1 {
  ///     // <--
  ///   }
  /// }
  /// ```
  /// For each of the marked scopes, resulting parent
  /// is the enclosing code block scope associated with
  /// the function body.
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

  /// Names introduced by the `if` optional binding conditions.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    conditions.flatMap { element in
      LookupName.getNames(from: element.condition, accessibleAfter: element.endPosition)
    }
  }

  /// Returns names matching lookup.
  /// Lookup triggered from inside of `else`
  /// clause is immediately forwarded to parent scope.
  ///
  /// Example:
  /// ```swift
  /// if let a = x {
  ///   // <-- a is visible here
  /// } else {
  ///   // <-- a is not visible here
  /// }
  /// ```
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if let elseBody, elseBody.range.contains(lookUpPosition) {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    } else {
      return defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
    }
  }
}

@_spi(Experimental) extension MemberBlockSyntax: ScopeSyntax {
  /// All names introduced by members of this member scope.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    members.flatMap { member in
      LookupName.getNames(from: member.decl)
    }
  }
}

@_spi(Experimental) extension GuardStmtSyntax: IntroducingToSequentialParentScopeSyntax {
  var namesIntroducedToSequentialParent: [LookupName] {
    conditions.flatMap { element in
      LookupName.getNames(from: element.condition, accessibleAfter: element.endPosition)
    }
  }

  @_spi(Experimental) public var introducedNames: [LookupName] {
    []
  }

  /// Returns results matching lookup that should be
  /// interleaved with sequential parent's results.
  /// Lookup triggered from within of the `else` body
  /// returns no names.
  ///
  /// Example:
  /// ```swift
  /// guard let a = x else {
  ///   return // a is not visible here
  /// }
  /// // a is visible here
  /// ```
  func lookupFromSequentialParent(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    guard !body.range.contains(lookUpPosition) else { return [] }

    let names = namesIntroducedToSequentialParent.filter { introducedName in
      checkIdentifier(identifier, refersTo: introducedName, at: lookUpPosition)
    }

    return names.isEmpty ? [] : [.fromScope(self, withNames: names)]
  }
}

@_spi(Experimental) extension ActorDeclSyntax: TypeScopeSyntax {}
@_spi(Experimental) extension ClassDeclSyntax: TypeScopeSyntax {}
@_spi(Experimental) extension StructDeclSyntax: TypeScopeSyntax {}
@_spi(Experimental) extension EnumDeclSyntax: TypeScopeSyntax {}
@_spi(Experimental) extension ExtensionDeclSyntax: TypeScopeSyntax {}

@_spi(Experimental) extension AccessorDeclSyntax: ScopeSyntax {
  /// Implicit and/or explicit names introduced within the accessor.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    if let parameters {
      return LookupName.getNames(from: parameters)
    } else {
      switch accessorSpecifier.tokenKind {
      case .keyword(.set), .keyword(.willSet):
        return [.implicit(.newValue(self))]
      case .keyword(.didSet):
        return [.implicit(.oldValue(self))]
      default:
        return []
      }
    }
  }
}

@_spi(Experimental) extension CatchClauseSyntax: ScopeSyntax {
  /// Implicit `error` when there are no catch items.
  public var introducedNames: [LookupName] {
    return catchItems.isEmpty ? [.implicit(.error(self))] : []
  }
}
