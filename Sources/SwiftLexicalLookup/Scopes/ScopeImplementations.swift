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
  /// File Scope doesn't introduce any names.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "FileScope"
  }

  /// In file scope, introduce only from `guard`.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    return statements.flatMap { codeBlockItem in
      if let guardStmt = codeBlockItem.item.as(GuardStmtSyntax.self) {
        return guardStmt.lookupFromSequentialParent(
          identifier,
          at: lookUpPosition,
          with: config
        )
      } else {
        return []
      }
    }
  }
}

@_spi(Experimental) extension CodeBlockSyntax: SequentialScopeSyntax {
  /// Names introduced in the code block scope
  /// accessible after their declaration.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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
  /// Closure capture names introduced in this closure expression.
  var captureNames: [LookupName] {
    signature?.capture?.items.flatMap { element in
      LookupName.getNames(from: element)
    } ?? []
  }

  /// Parameter names introduced in this closure expression.
  var parameterNames: [LookupName] {
    signature?.parameterClause?.children(viewMode: .sourceAccurate).flatMap { parameter in
      if let parameterList = parameter.as(ClosureParameterListSyntax.self) {
        return parameterList.children(viewMode: .sourceAccurate).flatMap { parameter in
          LookupName.getNames(from: parameter)
        }
      } else {
        return LookupName.getNames(from: parameter)
      }
    } ?? []
  }

  /// Names introduced sequentially in body.
  var introducedNamesInBody: [LookupName] {
    statements.flatMap { codeBlockItem in
      LookupName.getNames(from: codeBlockItem.item, accessibleAfter: codeBlockItem.endPosition)
    }
  }

  /// Capture, parameter and body names introduced in this scope.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    captureNames + parameterNames + introducedNamesInBody
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
    let sequentialResults = sequentialLookup(
      in: statements,
      identifier,
      at: lookUpPosition,
      with: config,
      propagateToParent: false
    )

    guard !config.finishInSequentialScope else { return sequentialResults }

    let signatureResults: [LookupResult]

    if signature?.range.contains(lookUpPosition) ?? false {
      signatureResults = []
    } else if parameterNames.isEmpty {
      let filteredCaptureNames = captureNames.filter { name in
        checkIdentifier(identifier, refersTo: name, at: lookUpPosition)
      }

      if let dollarIdentifierStr = identifier?.dollarIdentifierStr {
        signatureResults = LookupResult.getResultArray(
          for: self,
          withNames: filteredCaptureNames + [LookupName.dollarIdentifier(self, strRepresentation: dollarIdentifierStr)]
        )
      } else {
        signatureResults =
          LookupResult.getResultArray(for: self, withNames: filteredCaptureNames)
          + [.mightIntroduceDollarIdentifiers(self)]
      }
    } else {
      signatureResults = LookupResult.getResultArray(
        for: self,
        withNames: (captureNames + parameterNames).filter { name in
          checkIdentifier(identifier, refersTo: name, at: lookUpPosition)
        }
      )
    }

    return sequentialResults + signatureResults + lookupInParent(identifier, at: lookUpPosition, with: config)
  }
}

@_spi(Experimental) extension WhileStmtSyntax: ScopeSyntax {
  /// Names introduced by the `while` loop by its conditions.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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
  /// Member Block Scope doesn't introduce any results.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "MemberBlockScope"
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

    return LookupResult.getResultArray(for: self, withNames: filteredNames)
  }
}

@_spi(Experimental) extension GuardStmtSyntax: IntroducingToSequentialParentScopeSyntax {
  /// Names introduced in `guard` conditions to the sequential parent.
  var namesIntroducedToSequentialParent: [LookupName] {
    conditions.reversed().flatMap { element in
      LookupName.getNames(from: element.condition, accessibleAfter: element.endPosition)
    }
  }

  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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

    let filteredNames = namesIntroducedToSequentialParent.filter { introducedName in
      checkIdentifier(identifier, refersTo: introducedName, at: lookUpPosition)
    }

    return LookupResult.getResultArray(for: self, withNames: filteredNames)
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
    extensionHeader.extendedType.position
  }

  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "ExtensionDeclScope"
  }

  /// Returns results matching lookup, including implicit `Self`,
  /// `lookInGenericParametersOfExtendedType` and `lookInMembers` depending on `lookupPosition`.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if memberBlock.range.contains(lookUpPosition) {
      let implicitSelf: [LookupName] = [.implicit(.Self(self))]
        .filter { name in
          checkIdentifier(identifier, refersTo: name, at: lookUpPosition)
        }

      return LookupResult.getResultArray(for: self, withNames: implicitSelf)
        + [.lookInGenericParametersOfExtendedType(self)]
        + defaultLookupImplementation(identifier, at: lookUpPosition, with: config, propagateToParent: false)
        + [.lookInMembers(self)]
        + lookupInParent(identifier, at: lookUpPosition, with: config)
    } else if !extensionHeader.extendedType.range.contains(lookUpPosition) && extensionHeader.genericWhereClause != nil
    {
      if inRightTypeOrSameTypeRequirement(lookUpPosition) {
        return [.lookInGenericParametersOfExtendedType(self)] + [.lookInMembers(self)]
          + defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
      }

      return [.lookInGenericParametersOfExtendedType(self)]
        + defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
    }

    return [.lookInGenericParametersOfExtendedType(self)]
      + lookupInParent(identifier, at: lookUpPosition, with: config)
  }

  /// Returns `true` if `checkedPosition` is a right type of a
  /// conformance requirement or inside a same type requirement.
  private func inRightTypeOrSameTypeRequirement(
    _ checkedPosition: AbsolutePosition
  ) -> Bool {
    extensionHeader.genericWhereClause?.requirements.contains { elem in
      switch Syntax(elem.requirement).as(SyntaxEnum.self) {
      case .conformanceRequirement(let conformanceRequirement):
        return conformanceRequirement.rightType.range.contains(checkedPosition)
      case .sameTypeRequirement(let sameTypeRequirement):
        return sameTypeRequirement.range.contains(checkedPosition)
      default:
        return false
      }
    } ?? false
  }
}

@_spi(Experimental) extension AccessorDeclSyntax: ScopeSyntax {
  /// Implicit and/or explicit names introduced within the accessor.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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
    guard let parentScope,
      let canInterleaveLaterScope = Syntax(parentScope).asProtocol(SyntaxProtocol.self)
        as? CanInterleaveResultsLaterScopeSyntax
    else {
      return defaultLookupImplementation(identifier, at: lookUpPosition, with: config)
    }

    let implicitSelf: [LookupName] = [.implicit(.self(self))]
      .filter { name in
        checkIdentifier(identifier, refersTo: name, at: lookUpPosition)
      }

    return defaultLookupImplementation(
      identifier,
      at: lookUpPosition,
      with: config,
      propagateToParent: false
    )
      + canInterleaveLaterScope.lookupWithInterleavedResults(
        identifier,
        at: lookUpPosition,
        with: config,
        resultsToInterleave: implicitSelf.isEmpty ? [] : [.fromScope(self, withNames: implicitSelf)]
      )
  }
}

@_spi(Experimental) extension CatchClauseSyntax: ScopeSyntax {
  /// Implicit `error` when there are no catch items.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    let extractedNames = catchItems.flatMap { item in
      guard let pattern = item.pattern else { return [LookupName]() }

      return LookupName.getNames(from: pattern)
    }

    return extractedNames.isEmpty ? [.implicit(.error(self))] : extractedNames
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "CatchClauseScope"
  }

  /// Returns results matching lookup. Includes names possibly introduced by this scope
  /// if `lookupPosition` is either in body or one of the where clauses of catch items.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if body.range.contains(lookUpPosition) || isLookupFromWhereClause(lookUpPosition) {
      return defaultLookupImplementation(
        identifier,
        at: lookUpPosition,
        with: config
      )
    } else {
      return lookupInParent(
        identifier,
        at: lookUpPosition,
        with: config
      )
    }
  }

  /// Returns `true` if `checkedPosition` is in one
  /// of the catch items' where clauses and `false` otherwise.
  func isLookupFromWhereClause(
    _ checkedPosition: AbsolutePosition
  ) -> Bool {
    catchItems.contains { item in
      item.whereClause?.range.contains(checkedPosition) ?? false
    }
  }
}

@_spi(Experimental) extension SwitchCaseSyntax: SequentialScopeSyntax {
  /// Names introduced within `case` items.
  var namesFromLabel: [LookupName] {
    label.as(SwitchCaseLabelSyntax.self)?.caseItems.flatMap { child in
      if let exprPattern = child.pattern.as(ExpressionPatternSyntax.self) {
        return LookupName.getNames(from: exprPattern.expression)
      } else {
        return LookupName.getNames(from: child.pattern)
      }
    } ?? []
  }

  /// Names introduced within `case` items
  /// as well as sequential names from inside this case.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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
    ) + LookupResult.getResultArray(for: self, withNames: filteredNamesFromLabel)
      + (config.finishInSequentialScope ? [] : lookupInParent(identifier, at: lookUpPosition, with: config))
  }
}

@_spi(Experimental) extension ProtocolDeclSyntax: ScopeSyntax, LookInMembersScopeSyntax {
  /// Protocol declarations don't introduce names by themselves.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    [.implicit(.Self(self))]
  }

  @_spi(Experimental) public var lookupMembersPosition: AbsolutePosition {
    protocolHeader.name.positionAfterSkippingLeadingTrivia
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

    if let primaryAssociatedTypeClause = protocolHeader.primaryAssociatedTypeClause,
      primaryAssociatedTypeClause.range.contains(lookUpPosition)
    {
      results = memberBlock.lookupAssociatedTypeDeclarations(
        identifier,
        at: lookUpPosition,
        with: config
      )
    }

    let lookInMembers: [LookupResult]

    if !(protocolHeader.inheritanceClause?.range.contains(lookUpPosition) ?? false) {
      lookInMembers = [.lookInMembers(self)]
    } else {
      lookInMembers = []
    }

    return results
      + defaultLookupImplementation(
        identifier,
        at: lookUpPosition,
        with: config,
        propagateToParent: false
      ) + lookInMembers + lookupInParent(identifier, at: lookUpPosition, with: config)
  }
}

@_spi(Experimental) extension GenericParameterClauseSyntax: GenericParameterScopeSyntax {
  /// Generic parameter names introduced by this clause.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    parameters.children(viewMode: .fixedUp).flatMap { child in
      LookupName.getNames(from: child)
    }
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "GenericParameterClauseScope"
  }
}

@_spi(Experimental) extension FunctionDeclSyntax: FunctionScopeSyntax {
  @_spi(Experimental) public var scopeDebugName: String {
    "FunctionDeclScope"
  }
}

@_spi(Experimental) extension InitializerDeclSyntax: FunctionScopeSyntax {
  @_spi(Experimental) public var scopeDebugName: String {
    "InitializerDeclScope"
  }
}

@_spi(Experimental)
extension SubscriptDeclSyntax: WithGenericParametersScopeSyntax, CanInterleaveResultsLaterScopeSyntax {
  /// Parameters introduced by this subscript and possibly `self` keyword.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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
    lookupWithInterleavedResults(
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
  func lookupWithInterleavedResults(
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

@_spi(Experimental) extension AccessorBlockSyntax: SequentialScopeSyntax, CanInterleaveResultsLaterScopeSyntax {
  /// Names from the accessors or
  /// getters of this accessor block scope.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
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
  func lookupWithInterleavedResults(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    resultsToInterleave: [LookupResult]
  ) -> [LookupResult] {
    guard let parentScope,
      let canInterleaveLaterScope = Syntax(parentScope).asProtocol(SyntaxProtocol.self)
        as? CanInterleaveResultsLaterScopeSyntax
    else {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    }

    return canInterleaveLaterScope.lookupWithInterleavedResults(
      identifier,
      at: lookUpPosition,
      with: config,
      resultsToInterleave: resultsToInterleave
    )
  }
}

@_spi(Experimental) extension TypeAliasDeclSyntax: WithGenericParametersScopeSyntax {
  /// Type alias doesn't introduce any names to it's children.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "TypeAliasDeclScope"
  }
}

@_spi(Experimental) extension VariableDeclSyntax: CanInterleaveResultsLaterScopeSyntax {
  /// Variable decl scope doesn't introduce any
  /// names unless it is a member and is looked
  /// up from inside it's accessor block.
  @_spi(Experimental) public var defaultIntroducedNames: [LookupName] {
    []
  }

  @_spi(Experimental) public var scopeDebugName: String {
    "VariableDeclScope"
  }

  /// If a member and looked up from inside
  /// it's accessor block, introduce implicit
  /// `self` and propagate the lookup further.
  @_spi(Experimental) public func lookup(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig
  ) -> [LookupResult] {
    if bindings.first?.accessorBlock?.range.contains(lookUpPosition) ?? false {
      let isMember = parentScope?.is(MemberBlockSyntax.self) ?? false

      return defaultLookupImplementation(
        in: (isMember ? [.implicit(.self(self))] : LookupName.getNames(from: self)),
        identifier,
        at: lookUpPosition,
        with: config
      )
    } else {
      return lookupInParent(identifier, at: lookUpPosition, with: config)
    }
  }

  /// If a member, introduce results passed in `resultsToInterleave`
  /// and then pass lookup to the parent. Otherwise, perform `lookup`.
  func lookupWithInterleavedResults(
    _ identifier: Identifier?,
    at lookUpPosition: AbsolutePosition,
    with config: LookupConfig,
    resultsToInterleave: [LookupResult]
  ) -> [LookupResult] {
    guard parentScope?.is(MemberBlockSyntax.self) ?? false else {
      return lookup(identifier, at: lookUpPosition, with: config)
    }

    return resultsToInterleave + lookupInParent(identifier, at: lookUpPosition, with: config)
  }
}
