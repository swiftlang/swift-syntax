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

@_spi(Experimental) extension SourceFileSyntax: ScopeSyntax {
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
    for name: String?,
    at syntax: SyntaxProtocol,
    with config: LookupConfig
  ) -> [LookupResult] {
    let names = introducedNames(using: config.fileScopeHandling)
      .filter { introducedName in
        introducedName.isAccessible(at: syntax) && (name == nil || introducedName.refersTo(name!))
      }

    return [.fromFileScope(self, withNames: names)]
  }
}

@_spi(Experimental) extension CodeBlockSyntax: ScopeSyntax {
  /// Names introduced in the code block scope
  /// accessible after their declaration.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    statements.flatMap { codeBlockItem in
      LookupName.getNames(from: codeBlockItem.item, accessibleAfter: codeBlockItem.endPosition)
    }
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
    for name: String?,
    at syntax: SyntaxProtocol,
    with config: LookupConfig
  ) -> [LookupResult] {
    if let elseBody, elseBody.position <= syntax.position, elseBody.endPosition >= syntax.position {
      return lookupInParent(for: name, at: syntax, with: config)
    } else {
      return defaultLookupImplementation(for: name, at: syntax, with: config)
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

@_spi(Experimental) extension GuardStmtSyntax: ScopeSyntax {
  /// Guard doesn't introduce any names to its children.
  /// It's always empty.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    []
  }

  /// Returns names matching lookup.
  /// Lookup triggered from inside of `else`
  /// clause is immediately forwarded to parent scope.
  ///
  /// Example:
  /// ```swift
  /// guard let a = x else {
  ///   return // a is not visible here
  /// }
  /// // a is visible here
  /// ```
  @_spi(Experimental) public func lookup(
    for name: String?,
    at syntax: SyntaxProtocol,
    with config: LookupConfig
  ) -> [LookupResult] {
    if body.position <= syntax.position && body.endPosition >= syntax.position {
      return lookupInParent(for: name, at: self, with: config)
    } else {
      return defaultLookupImplementation(for: name, at: syntax, with: config)
    }
  }
}
