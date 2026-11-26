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

/// Protocol encapsulating `NominalTypeDeclSyntax`. Only `[Struct/Enum/Class/Actor/Protocol]DeclSyntax`
/// should conform.
@_spi(_QualifiedLookup) public protocol NominalTypeDeclSyntaxProtocol: DeclGroupSyntax, NamedDeclSyntax {}

/// A nominal type declaration (struct, enum, class, actor, protocol).
@_spi(_QualifiedLookup) public struct NominalTypeDeclSyntax: NominalTypeDeclSyntaxProtocol, SyntaxHashable {
  public private(set) var _syntaxNode: Syntax

  public init?(_ node: __shared some SyntaxProtocol) {
    switch node.kind {
    case .structDecl, .enumDecl, .classDecl, .actorDecl, .protocolDecl:
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
    ])
  }
}

// MARK: Properties

extension NominalTypeDeclSyntax: DeclGroupSyntax {
  private func _getGroupProp<T>(_ prop: KeyPath<any NominalTypeDeclSyntaxProtocol, T>) -> T {
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
    default:
      fatalError("[Internal Error] Invalid syntax kind for NominalTypeDeclSyntax \(_syntaxNode.kind)")
    }
  }

  private mutating func _setGroupProp<T>(
    _ keyPath: WritableKeyPath<any NominalTypeDeclSyntaxProtocol, T>,
    newValue: T
  ) {
    switch _syntaxNode.as(SyntaxEnum.self) {
    case .structDecl(let declGroup):
      var box: any NominalTypeDeclSyntaxProtocol = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .enumDecl(let declGroup):
      var box: any NominalTypeDeclSyntaxProtocol = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .classDecl(let declGroup):
      var box: any NominalTypeDeclSyntaxProtocol = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .actorDecl(let declGroup):
      var box: any NominalTypeDeclSyntaxProtocol = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    case .protocolDecl(let declGroup):
      var box: any NominalTypeDeclSyntaxProtocol = declGroup
      box[keyPath: keyPath] = newValue
      _syntaxNode = box._syntaxNode
    default:
      fatalError("[Internal Error] Invalid syntax kind for DeclGroupSyntaxType: \(_syntaxNode.kind)")
    }
  }

  public init(_ syntax: __shared some NominalTypeDeclSyntaxProtocol) {
    self = Syntax(syntax).cast(Self.self)
  }

  public var name: TokenSyntax {
    get { _getGroupProp(\.name) }
    set { _setGroupProp(\.name, newValue: newValue) }
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
}

// MARK: Generic Parameters

extension NominalTypeDeclSyntax {
  /// Find the given generic parameter in this nominal-type declaration.
  /// Empty for protocols (they only have associated types)
  func findGenericParameters(withName name: Identifier?) -> [GenericParameterSyntax] {
    // Extract the parameter clause, or `nil` for protocols.
    let parameterClause: GenericParameterClauseSyntax?
    switch _syntaxNode.as(SyntaxEnum.self) {
    case .structDecl(let nonProtocolDecl):
      parameterClause = nonProtocolDecl.genericParameterClause
    case .enumDecl(let nonProtocolDecl):
      parameterClause = nonProtocolDecl.genericParameterClause
    case .classDecl(let nonProtocolDecl):
      parameterClause = nonProtocolDecl.genericParameterClause
    case .actorDecl(let nonProtocolDecl):
      parameterClause = nonProtocolDecl.genericParameterClause
    case .protocolDecl:
      parameterClause = nil
    default:
      assertionFailure(
        "[SwiftLexicalLookup] Internal error: Unexpectedly got nominal type declaration of unrecognized kind '\(kind)'."
      )
      return []
    }

    guard let parameterClause else { return [] }

    // Return all parameters if we don't filter by name
    guard let name else { return Array(parameterClause.parameters) }
    return parameterClause.parameters.filter({ parameter in
      parameter.name.identifier == name
    })
  }
}

// MARK: Upcasts

extension Attached where Node == TypeDeclSyntax {
  init<S: NominalTypeDeclSyntaxProtocol>(_ node: __shared Attached<S>) {
    // All nominal-type declarations are type declarations.
    self = node.as(TypeDeclSyntax.self)!
  }
}
