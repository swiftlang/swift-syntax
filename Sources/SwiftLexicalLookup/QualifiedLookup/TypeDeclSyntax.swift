//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2026 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax

/// A nominal type declaration (struct, enum, class, actor, protocol), type
/// alias, associated type or generic parameter.
@_spi(_QualifiedLookup) public struct TypeDeclSyntax: SyntaxProtocol, SyntaxHashable {
  public private(set) var _syntaxNode: Syntax

  public init?(_ node: __shared some SyntaxProtocol) {
    switch node.kind {
    case .structDecl, .enumDecl, .classDecl, .actorDecl, .protocolDecl, .typeAliasDecl, .associatedTypeDecl,
      .genericParameter:
      _syntaxNode = node._syntaxNode
    default:
      return nil
    }
  }

  public static var structure: SyntaxNodeStructure {
    SyntaxNodeStructure.choices([
      .node(StructDeclSyntax.self),
      .node(EnumDeclSyntax.self),
      .node(ClassDeclSyntax.self),
      .node(ActorDeclSyntax.self),
      .node(ProtocolDeclSyntax.self),
      .node(TypeAliasDeclSyntax.self),
      .node(AssociatedTypeDeclSyntax.self),
      .node(GenericParameterSyntax.self),
    ])
  }
}

// MARK: Name

extension TypeDeclSyntax {
  public var name: TokenSyntax {
    switch _syntaxNode.as(SyntaxEnum.self) {
    case .structDecl(let structDecl):
      return structDecl.name
    case .enumDecl(let enumDecl):
      return enumDecl.name
    case .classDecl(let classDecl):
      return classDecl.name
    case .actorDecl(let actorDecl):
      return actorDecl.name
    case .protocolDecl(let protocolDecl):
      return protocolDecl.name
    case .typeAliasDecl(let typeAliasDecl):
      return typeAliasDecl.name
    case .associatedTypeDecl(let associatedTypeDecl):
      return associatedTypeDecl.name
    case .genericParameter(let genericParameter):
      return genericParameter.name
    default:
      fatalError("[Internal Error] Invalid syntax kind for TypeDeclSyntax: \(_syntaxNode.kind)")
    }
  }
}

// MARK: Upcasts

extension TypeDeclSyntax {
  public init(_ nominalType: some NominalTypeDeclSyntaxProtocol) {
    self = Syntax(nominalType).cast(TypeDeclSyntax.self)
  }

  public init(_ typeAlias: TypeAliasDeclSyntax) {
    self = Syntax(typeAlias).cast(TypeDeclSyntax.self)
  }

  public init(_ associatedType: AssociatedTypeDeclSyntax) {
    self = Syntax(associatedType).cast(TypeDeclSyntax.self)
  }

  public init(_ genericParameter: GenericParameterSyntax) {
    self = Syntax(genericParameter).cast(TypeDeclSyntax.self)
  }
}

// MARK: Debug Description

extension TypeDeclSyntax {
  /// Uses the trimmed description of the type decl and removes
  /// the member block for structs/enums/classes/actors/protocols/extensions,
  /// similar to `DeclGroupSyntax/_memberlessDescription`.
  var _memberlessDescription: String {
    self.as(DeclGroupSyntaxType.self)?._memberlessDescription ?? trimmedDescription
  }
}

extension Attached where Node == TypeDeclSyntax {
  internal var _memberlessDescription: String {
    node._memberlessDescription
  }
}
