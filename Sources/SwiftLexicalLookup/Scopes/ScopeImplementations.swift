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

  /// This node's line and column separated by `:`.
  var debugLineWithColumnDescription: String {
    let location = SourceLocationConverter(fileName: "", tree: root).location(for: position)

    return "\(location.line):\(location.column)"
  }
}

@_spi(Experimental) extension SourceFileSyntax: SequentialScopeSyntax {
  /// All names introduced in the file scope
  /// according to the default strategy: `memberBlockUpToLastDecl`.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    introducedNames(using: .memberBlockUpToLastDecl)
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "FileScope"
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
      guard config.includeMembers else { return [] }
      
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

      return (members.isEmpty || !config.includeMembers ? [] : [.fromFileScope(self, withNames: members)]) + sequentialNames
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

  @_spi(Experimental) public var scopeDebugName: String {
    "CodeBlockScope"
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

  @_spi(Experimental) public var scopeDebugName: String {
    "ForStmtScope"
  }

  /// Returns results with names matching lookup.
  /// Doesn't include names introduced at this scope
  /// if lookup started inside it's `pattern` or `sequence`.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if pattern.range.contains(lookUpPosition) || sequence.range.contains(lookUpPosition) {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    } else {
      return defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
    }
  }
}

@_spi(Experimental) extension ClosureExprSyntax: SequentialScopeSyntax {
  /// Names introduced in this closure's signature.
  var introducedNamesInSignature: [LookupName] {
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

  /// Names introduced sequentially in body.
  var introducedNamesInBody: [LookupName] {
    statements.flatMap { codeBlockItem in
      LookupName.getNames(from: codeBlockItem.item, accessibleAfter: codeBlockItem.endPosition)
    }
  }

  @_spi(Experimental) public var introducedNames: [LookupName] {
    introducedNamesInSignature + introducedNamesInBody
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "ClosureExprScope"
  }

  /// All names introduced by the closure signature and its body.
  /// Could be closure captures, (shorthand) parameters or
  /// sequential results from the body.
  ///
  /// ### Example
  /// ```swift
  /// let x = { [weak self, a] b, _ in
  ///   let c = 42
  ///   // <--
  ///   let d = 42
  /// }
  /// ```
  /// During lookup, names available at the marked place are:
  /// `self`, `a`, `b` and `c`.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    let filteredSignatureNames: [LookupName]

    if let signature, signature.range.contains(lookUpPosition) {
      filteredSignatureNames = []
    } else {
      filteredSignatureNames = introducedNamesInSignature.filter { name in
        checkIdentifier(identifier, refersTo: name, at: lookUpPosition)
      }
    }

    return sequentialLookup(
      in: statements,
      identifier,
      at: lookUpPosition,
      with: config,
      propagateToParent: false
    ) + (filteredSignatureNames.isEmpty ? [] : [.fromScope(self, withNames: filteredSignatureNames)])
      + (config.finishInSequentialScope ? [] : lookupInParent(identifier, at: lookUpPosition, with: config))
  }
}

@_spi(Experimental) extension WhileStmtSyntax: ScopeSyntax {
  /// Names introduced by the `while` loop by its conditions.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    conditions.reversed().flatMap { element in
      LookupName.getNames(from: element.condition, accessibleAfter: element.endPositionBeforeTrailingTrivia)
    }
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "WhileStmtScope"
  }
}

@_spi(Experimental) extension IfExprSyntax: ScopeSyntax {
  /// Parent scope, omitting ancestor `if` statements if part of their `else if` clause.
  @_spi(Experimental) public var parentScope: ScopeSyntax? {
    getParent(for: self.parent, previousIfElse: self.elseKeyword == nil)
  }

  /// Finds parent scope, omitting ancestor `if` statements if part of their `else if` clause.
  ///
  /// ### Example
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
    conditions.reversed().flatMap { element in
      LookupName.getNames(from: element.condition, accessibleAfter: element.endPosition)
    }
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "IfExprScope"
  }

  /// Returns names matching lookup.
  /// Lookup triggered from inside of `else`
  /// clause is immediately forwarded to parent scope.
  ///
  /// ### Example
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

  @_spi(Experimental) public var scopeDebugName: String {
    "MemberBlockScope"
  }

  /// Lookup results from this member block scope.
  /// Bypasses names from this scope if `includeMembers` set to `false`.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if config.includeMembers {
      return defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
    } else {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    }
  }

  /// Creates a result from associated type declarations
  /// made by it's members.
  func lookupAssociatedTypeDeclarations(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    let filteredNames = members.flatMap { member in
      guard member.decl.kind == .associatedTypeDecl else { return [LookupName]() }

      return LookupName.getNames(from: member.decl)
    }.filter { name in
      checkIdentifier(identifier, refersTo: name, at: lookUpPosition)
    }

    return filteredNames.isEmpty ? [] : [.fromScope(self, withNames: filteredNames)]
  }
}

@_spi(Experimental) extension GuardStmtSyntax: IntroducingToSequentialParentScopeSyntax {
  var namesIntroducedToSequentialParent: [LookupName] {
    conditions.reversed().flatMap { element in
      LookupName.getNames(from: element.condition, accessibleAfter: element.endPosition)
    }
  }

  @_spi(Experimental) public var introducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "GuardStmtScope"
  }

  /// Returns results matching lookup that should be
  /// interleaved with sequential parent's results.
  /// Lookup triggered from within of the `else` body
  /// returns no names.
  ///
  /// ### Example
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

@_spi(Experimental) extension ActorDeclSyntax: NominalTypeDeclSyntax {
  @_spi(Experimental) public var scopeDebugName: String {
    "ActorDeclScope"
  }
}
@_spi(Experimental) extension ClassDeclSyntax: NominalTypeDeclSyntax {
  @_spi(Experimental) public var scopeDebugName: String {
    "ClassDeclScope"
  }
}
@_spi(Experimental) extension StructDeclSyntax: NominalTypeDeclSyntax {
  @_spi(Experimental) public var scopeDebugName: String {
    "StructDeclScope"
  }
}
@_spi(Experimental) extension EnumDeclSyntax: NominalTypeDeclSyntax {
  @_spi(Experimental) public var scopeDebugName: String {
    "EnumDeclScope"
  }
}
@_spi(Experimental) extension ExtensionDeclSyntax: LookInMembersScopeSyntax {
  @_spi(Experimental) public var lookupMembersPosition: AbsolutePosition {
    extendedType.position
  }

  @_spi(Experimental) public var introducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "ExtensionDeclScope"
  }

  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if memberBlock.range.contains(lookUpPosition) {
      return [.lookInMembers(self)] + defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
    } else {
      return defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
    }
  }
}

@_spi(Experimental) extension AccessorDeclSyntax: ScopeSyntax {
  /// Implicit and/or explicit names introduced within the accessor.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    let names: [LookupName]

    if let parameters {
      names = LookupName.getNames(from: parameters)
    } else {
      switch accessorSpecifier.tokenKind {
      case .keyword(.set), .keyword(.willSet):
        names = [.implicit(.newValue(self))]
      case .keyword(.didSet):
        names = [.implicit(.oldValue(self))]
      default:
        names = []
      }
    }

    return names
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "AccessorDeclScope"
  }
  
  /// Returns result with matching names from
  /// this scope and passes result with implicit `self`
  /// to be introduced after the `subscript`
  /// declaration scope grandparent.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    guard let parentAccessorBlockScope = parentScope?.as(AccessorBlockSyntax.self) else {
      return defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
    }
    
    return defaultLookupImplementation(
      identifier,
      at: lookUpPosition,
      with: config,
      propagateToParent: false
    ) + parentAccessorBlockScope.interleaveAccessorResultsAfterSubscriptLookup(
      identifier,
      at: lookUpPosition,
      with: config,
      resultsToInterleave: [.fromScope(self, withNames: [.implicit(.self(self))])]
    )
  }
}

@_spi(Experimental) extension CatchClauseSyntax: ScopeSyntax {
  /// Implicit `error` when there are no catch items.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    return catchItems.isEmpty ? [.implicit(.error(self))] : []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "CatchClauseScope"
  }
}

@_spi(Experimental) extension SwitchCaseSyntax: SequentialScopeSyntax {
  /// Names introduced within `case` items.
  var namesFromLabel: [LookupName] {
    label.as(SwitchCaseLabelSyntax.self)?.caseItems.flatMap { child in
      LookupName.getNames(from: child.pattern)
    } ?? []
  }

  /// Names introduced within `case` items
  /// as well as sequential names from inside this case.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    statements.flatMap { codeBlockItem in
      LookupName.getNames(from: codeBlockItem.item, accessibleAfter: codeBlockItem.endPosition)
    } + namesFromLabel
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "SwitchCaseScope"
  }

  /// Returns results with names matching lookup.
  /// Includes names introduced in it's label and sequentially
  /// introduced names from inside this case.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    let filteredNamesFromLabel = namesFromLabel.filter { name in
      checkIdentifier(identifier, refersTo: name, at: lookUpPosition)
    }

    return sequentialLookup(
      in: statements,
      identifier,
      at: lookUpPosition,
      with: config,
      propagateToParent: false
    ) + (filteredNamesFromLabel.isEmpty ? [] : [.fromScope(self, withNames: filteredNamesFromLabel)])
    + (config.finishInSequentialScope ? [] : lookupInParent(identifier, at: lookUpPosition, with: config))
  }
}

@_spi(Experimental) extension ProtocolDeclSyntax: ScopeSyntax {
  /// Protocol declarations don't introduce names by themselves.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "ProtocolDeclScope"
  }

  /// For the lookup initiated from inside primary
  /// associated type clause, this function also finds
  /// all associated type declarations made inside the
  /// protocol member block.
  ///
  /// ### Example
  /// ```swift
  /// class A {}
  ///
  /// protocol Foo<A/*<-- lookup here>*/> {
  ///  associatedtype A
  ///  class A {}
  /// }
  /// ```
  /// For the lookup started at the primary associated type `A`,
  /// the function returns exactly two results. First associated with the member
  /// block that consists of the `associatedtype A` declaration and
  /// the latter one from the file scope and `class A` exactly in this order.
  public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    var results: [LookupResult] = []

    if let primaryAssociatedTypeClause,
      primaryAssociatedTypeClause.range.contains(lookUpPosition)
    {
      results = memberBlock.lookupAssociatedTypeDeclarations(
        identifier,
        at: lookUpPosition,
        with: config
      )
    }

    return results + defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
  }
}

@_spi(Experimental) extension GenericParameterClauseSyntax: GenericParameterScopeSyntax {
  /// Generic parameter names introduced by this clause.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    parameters.children(viewMode: .fixedUp).flatMap { child in
      LookupName.getNames(from: child)
    }
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "GenericParameterClauseScope"
  }
}

@_spi(Experimental) extension FunctionDeclSyntax: WithGenericParametersScopeSyntax {
  /// Function parameters introduced by this function's signature.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    signature.parameterClause.parameters.flatMap { parameter in
      LookupName.getNames(from: parameter)
    } + (parentScope?.is(MemberBlockSyntax.self) ?? false ? [.implicit(.self(self))] : [])
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "FunctionDeclScope"
  }

  /// Lookup results from this function scope.
  /// Routes to generic parameter clause scope if exists.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    var thisScopeResults: [LookupResult] = []

    if !signature.range.contains(lookUpPosition) {
      thisScopeResults = defaultLookupImplementation(
        identifier,
        at: position,
        with: config,
        propagateToParent: false
      )
    }

    return thisScopeResults
      + lookupThroughGenericParameterScope(
        identifier,
        at: lookUpPosition,
        with: config
      )
  }
}

@_spi(Experimental) extension SubscriptDeclSyntax: WithGenericParametersScopeSyntax {
  /// Parameters introduced by this subscript and possibly `self` keyword.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    let parameters = parameterClause.parameters.flatMap { parameter in
      LookupName.getNames(from: parameter)
    }

    if let accessorBlock, case .getter = accessorBlock.accessors {
      return parameters + [.implicit(.self(self))]
    } else {
      return parameters
    }
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "SubscriptDeclScope"
  }

  /// Lookup results from this subscript scope.
  /// Routes to generic parameter clause scope if exists.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    interleaveResultsAfterThisSubscriptLookup(
      identifier,
      at: lookUpPosition,
      with: config,
      resultsToInterleave: []
    )
  }
  
  /// Lookup names in this scope and add `resultsToInterleave`
  /// after results from this scope.
  ///
  /// It's used to handle implicit `self` introduction
  /// at the boundaries of accessors in this subscript.
  /// ```swift
  /// class X {
  ///   subscript(self: Int) -> Int {
  ///     get {
  ///       self // <-- lookup here
  ///     }
  ///   }
  /// }
  /// ```
  /// In this case, the `self` reference references the `self`
  /// function parameter which shadows implicit `self`
  /// introduced at the boundary of the getter. That's why
  /// this function needs to ensure the implicit `self` passed
  /// from inside the accessor block is added after `subscript` parameters.
  func interleaveResultsAfterThisSubscriptLookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    resultsToInterleave: [LookupResult]
  ) -> [LookupResult] {
    var thisScopeResults: [LookupResult] = []

    if !parameterClause.range.contains(lookUpPosition) && !returnClause.range.contains(lookUpPosition) {
      thisScopeResults = defaultLookupImplementation(
        identifier,
        at: position,
        with: config,
        propagateToParent: false
      )
    }

    return thisScopeResults + resultsToInterleave
      + lookupThroughGenericParameterScope(
        identifier,
        at: lookUpPosition,
        with: config
      )
  }
}

@_spi(Experimental) extension AccessorBlockSyntax: SequentialScopeSyntax {
  /// Names from the accessors or
  /// getters of this accessor block scope.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    switch accessors {
    case .getter(let codeBlockItems):
      return codeBlockItems.flatMap { codeBlockItem in
        LookupName.getNames(from: codeBlockItem.item)
      }
    case .accessors:
      return []
    }
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "AccessorBlockScope"
  }

  /// Names introduced in this accessir block scope.
  /// If `accessor` is of `.getter` kind, introduced
  /// it's items sequentially. Otherwise, propagate to parent.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    switch accessors {
    case .getter(let codeBlockItems):
      return sequentialLookup(in: codeBlockItems, identifier, at: lookUpPosition, with: config)
    case .accessors:
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    }
  }
  
  /// Used by children accessors to interleave
  /// their results with parent `subscript` declaration scope.
  func interleaveAccessorResultsAfterSubscriptLookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    resultsToInterleave: [LookupResult]
  ) -> [LookupResult] {
    guard let parentSubscriptScope = parentScope?.as(SubscriptDeclSyntax.self) else {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    }
    
    return parentSubscriptScope.interleaveResultsAfterThisSubscriptLookup(
      identifier,
      at: lookUpPosition,
      with: config,
      resultsToInterleave: resultsToInterleave
    )
  }
}

@_spi(Experimental) extension TypeAliasDeclSyntax: WithGenericParametersScopeSyntax {
  /// Type alias doesn't introduce any names to it's children.
  @_spi(Experimental) public var introducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "TypeAliasDeclScope"
  }
}
