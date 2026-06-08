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

import SwiftIfConfig
import SwiftSyntax

public struct DeclGroupSyntaxType: SyntaxProtocol {
  // TODO: Consider using the underlying syntax node (like ``ValueDeclSyntax``)
  public var _syntaxNode: Syntax

  public init?(_ node: borrowing some SyntaxProtocol) {
    switch node._syntaxNode.kind {
    case .structDecl, .enumDecl, .classDecl, .actorDecl, .protocolDecl, .extensionDecl:
      self._syntaxNode = node._syntaxNode
    default:
      return nil
    }
  }

  public static let structure: SwiftSyntax.SyntaxNodeStructure = .choices([
    .node(StructDeclSyntax.self), .node(EnumDeclSyntax.self), .node(ClassDeclSyntax.self),
    .node(ActorDeclSyntax.self), .node(ProtocolDeclSyntax.self), .node(ExtensionDeclSyntax.self),
  ])
}

@_spi(_QualifiedLookup) extension DeclGroupSyntaxType: DeclGroupSyntax {
  private func _getGroupProp<T>(_ prop: KeyPath<(any DeclGroupSyntax), T>) -> T {
    switch _syntaxNode.as(SyntaxEnum.self) {
    case .structDecl(let declGroup):
      return declGroup[keyPath: prop]
    case .enumDecl(let declGroup):
      return declGroup[keyPath: prop]
    case .classDecl(let declGroup):
      return declGroup[keyPath: prop]
    case .actorDecl(let declGroup):
      return declGroup[keyPath: prop]
    case .protocolDecl(let declGroup):
      return declGroup[keyPath: prop]
    case .extensionDecl(let declGroup):
      return declGroup[keyPath: prop]
    default:
      fatalError("[Internal Error] Invalid syntax kind for DeclGroupSyntaxType: \(_syntaxNode.kind)")
    }
  }
  private mutating func _setGroupProp<T>(
    // _ visitor: some _DeclGroupVisitor<T>, newValue: T
    _ keyPath: WritableKeyPath<(any DeclGroupSyntax), T>,
    newValue: T
  ) {
    switch _syntaxNode.as(SyntaxEnum.self) {
    case .structDecl(let declGroup):
      var box: any DeclGroupSyntax = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .enumDecl(let declGroup):
      var box: any DeclGroupSyntax = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .classDecl(let declGroup):
      var box: any DeclGroupSyntax = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .actorDecl(let declGroup):
      var box: any DeclGroupSyntax = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .protocolDecl(let declGroup):
      var box: any DeclGroupSyntax = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .extensionDecl(let declGroup):
      var box: any DeclGroupSyntax = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    default:
      fatalError("[Internal Error] Invalid syntax kind for DeclGroupSyntaxType: \(_syntaxNode.kind)")
    }
  }

  public init(exactly node: some DeclGroupSyntax) {
    self.init(node)!
  }

  public var attributes: AttributeListSyntax {
    get { _getGroupProp(\.attributes) }
    set { _setGroupProp(\.attributes, newValue: newValue) }
  }

  public var modifiers: DeclModifierListSyntax {
    get { _getGroupProp(\.modifiers) }
    set { _setGroupProp(\.modifiers, newValue: newValue) }
  }
  public var introducer: TokenSyntax {
    get { _getGroupProp(\.introducer) }
    set { _setGroupProp(\.introducer, newValue: newValue) }
  }

  public var inheritanceClause: InheritanceClauseSyntax? {
    get { _getGroupProp(\.inheritanceClause) }
    set { _setGroupProp(\.inheritanceClause, newValue: newValue) }
  }

  public var genericWhereClause: GenericWhereClauseSyntax? {
    get { _getGroupProp(\.genericWhereClause) }
    set { _setGroupProp(\.genericWhereClause, newValue: newValue) }
  }

  public var memberBlock: MemberBlockSyntax {
    get { _getGroupProp(\.memberBlock) }
    set { _setGroupProp(\.memberBlock, newValue: newValue) }
  }

  var _asLookInMembersScope: LookInMembersScopeSyntax? {
    Syntax(self).asProtocol((any SyntaxProtocol).self) as? any LookInMembersScopeSyntax
  }
}

// MARK: Lookup

extension DeclGroupSyntax {
  /// Find named member declarations in the given group declaration.
  ///
  /// Results are filtered in the following ways:
  /// 1. If an identifier is given, only return declaration matching that name.
  /// 2. Only returns declarations matching `memberKind`.
  /// 3. If a configuredRegion is provided, consider only the active clause's
  ///    members.
  ///
  /// Note that implicit members such as `self`, `Type`, or `Protocol` aren't
  /// value declarations (they're not actual members) and we don't return them here.
  @_spi(_QualifiedLookup) public func findDirectMembers(
    name: DeclNameRef?,
    kind memberKind: MemberKind = .default,
    configuredRegions: ConfiguredRegions? = nil
  ) -> [ValueDeclSyntax] {
    /// Filter the given declaration based on the given ``name`` and ``memberKind``
    func filterDecl(_ valueDecl: ValueDeclSyntax) -> ValueDeclSyntax? {
      // Check name matches
      // // TODO: Remove debuggins statement
      // if let name {
      //   print(
      //     "[Lookup Debugging] Match between \(valueDecl.declName) and \(name) is:",
      //     valueDecl.declName.tryMatch(reference: name.baseName),
      //     "with kind match:",
      //     valueDecl.isKind(memberKind)
      //   )
      // }

      // If given a name, check for a match
      if let expectedName = name,
        case .failure = valueDecl.declName.tryMatch(reference: expectedName.baseName)
      {
        return nil
      }
      // Filter for the kind
      guard valueDecl.isKind(memberKind) else { return nil }

      return valueDecl
    }

    /// Process a member or a member nested inside an if-config declaration.
    ///
    /// This pattern is similar to the SyntaxVisitor pattern, but a SyntaxVisitor
    /// doesn't work because we use protocols like `NamedDeclSyntax`
    func processMember(member: MemberBlockItemSyntax) -> [ValueDeclSyntax] {
      // Get only value declarations
      if let valueDecl = member.decl.as(ValueDeclSyntax.self) {
        return if let valueDecl = filterDecl(valueDecl) { [valueDecl] } else { [] }
      }
      // Visit variable declarations to get identifier patterns
      else if let varDecl = member.decl.as(VariableDeclSyntax.self) {
        return varDecl.bindings.compactMap({ binding in
          ValueDeclSyntax(binding.pattern.as(IdentifierPatternSyntax.self)).flatMap(filterDecl(_:))
        })
      }
      // Visit enum cases to get enum elements
      else if let enumCase = member.decl.as(EnumCaseDeclSyntax.self) {
        return enumCase.elements.compactMap({ enumElement in
          filterDecl(ValueDeclSyntax(enumElement))
        })
      }
      // If configuredRegions is set, visit the members of the active clause (if it exists)
      //
      // We do this recursively to handle nested if-config declarations
      else if let ifConfigDecl = member.decl.as(IfConfigDeclSyntax.self),
        let configuredRegions,
        case .decls(let members) = configuredRegions.activeClause(for: ifConfigDecl)?.elements
      {
        return members.flatMap(processMember(member:))
      }
      // If configuredRegions is nil, visit all if-config clauses
      else if let ifConfigDecl = member.decl.as(IfConfigDeclSyntax.self) {
        return ifConfigDecl.clauses.flatMap({ clause -> [ValueDeclSyntax] in
          guard case .decls(let members) = clause.elements else { return [] }
          return members.flatMap(processMember(member:))
        })
      }
      // No name, no gain
      else {
        return []
      }
    }

    // Add each member in the group declaration
    return self.memberBlock.members
      .flatMap(processMember(member:))
  }
}

// MARK: Utilities

extension DeclGroupSyntaxType {
  /// The type syntax of this declaration group. An identifier type syntax for nominal types,
  /// or the extended type for extensions.
  ///
  /// Useful for debugging
  @_spi(_QualifiedLookup) public var type: TypeSyntax? {
    switch _syntaxNode.as(SyntaxEnum.self) {
    case .structDecl(let structDecl):
      return TypeSyntax(IdentifierTypeSyntax(name: structDecl.name))
    case .enumDecl(let enumDecl):
      return TypeSyntax(IdentifierTypeSyntax(enumDecl.name))
    case .classDecl(let classDecl):
      return TypeSyntax(IdentifierTypeSyntax(classDecl.name))
    case .actorDecl(let actorDecl):
      return TypeSyntax(IdentifierTypeSyntax(actorDecl.name))
    case .protocolDecl(let protocolDecl):
      return TypeSyntax(IdentifierTypeSyntax(protocolDecl.name))
    case .extensionDecl(let extensionDecl):
      return extensionDecl.extendedType
    default:
      fatalError("[Internal Error] Invalid syntax kind for DeclGroupSyntaxType: \(_syntaxNode.kind)")
    }
  }
}
