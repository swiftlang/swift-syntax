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

public struct QualifiedLookupConfig {
  public var configuredRegions: ConfiguredRegions? = nil

  public init(configuredRegions: ConfiguredRegions? = nil) {
    self.configuredRegions = configuredRegions
  }
}
public struct QualifiedTableLookupConfig {
  public var lookupSuperprotocols: Bool
  public var lookupSuperclasses: Bool
  public var configuredRegions: ConfiguredRegions?

  /// Parameters:
  /// - lookupSuperprotocols: Whether to recursively look up
  ///       inherited or conformed-to protocols.
  /// - lookupSuperclasses: Whether to recursively look up
  ///       superclasses, and the protocols they conform to (if
  ///       `lookupSuperprotocols` is true).
  public init(
    lookupSuperprotocols: Bool = false,
    lookupSuperclasses: Bool = false,
    configuredRegions: ConfiguredRegions? = nil
  ) {
    self.lookupSuperprotocols = lookupSuperprotocols
    self.lookupSuperclasses = lookupSuperclasses
    self.configuredRegions = configuredRegions
  }
}

public struct DeclGroupSyntaxType: DeclGroupSyntax {
  private var box: any DeclGroupSyntax

  public init?(_ node: __shared some SyntaxProtocol) {
    if let castNode = node.as(StructDeclSyntax.self) {
      box = castNode
    } else if let castNode = node.as(EnumDeclSyntax.self) {
      box = castNode
    } else if let castNode = node.as(ClassDeclSyntax.self) {
      box = castNode
    } else if let castNode = node.as(ActorDeclSyntax.self) {
      box = castNode
    } else if let castNode = node.as(ProtocolDeclSyntax.self) {
      box = castNode
    } else if let castNode = node.as(ExtensionDeclSyntax.self) {
      box = castNode
    } else {
      return nil
    }
  }

  public var attributes: SwiftSyntax.AttributeListSyntax {
    get { box.attributes }
    set { box.attributes = newValue }
  }

  public var modifiers: SwiftSyntax.DeclModifierListSyntax {
    get { box.modifiers }
    set { box.modifiers = newValue }
  }

  public var introducer: SwiftSyntax.TokenSyntax {
    get { box.introducer }
    set { box.introducer = newValue }
  }

  public var inheritanceClause: SwiftSyntax.InheritanceClauseSyntax? {
    get { box.inheritanceClause }
    set { box.inheritanceClause = newValue }
  }

  public var genericWhereClause: SwiftSyntax.GenericWhereClauseSyntax? {
    get { box.genericWhereClause }
    set { box.genericWhereClause = newValue }
  }

  public var memberBlock: SwiftSyntax.MemberBlockSyntax {
    get { box.memberBlock }
    set { box.memberBlock = newValue }
  }

  public var _syntaxNode: SwiftSyntax.Syntax {
    box._syntaxNode
  }

  public static let structure: SwiftSyntax.SyntaxNodeStructure = .choices([
    .node(StructDeclSyntax.self), .node(EnumDeclSyntax.self), .node(ClassDeclSyntax.self),
    .node(ActorDeclSyntax.self), .node(ProtocolDeclSyntax.self), .node(ExtensionDeclSyntax.self),
  ])
}

/// Contains the results of a qualified lookup request
public enum QualifiedLookupResult {
  /// Explicitly declared members.
  ///
  /// Includes static/class/instance stored and computed properties,
  /// functions, subscripts and initializers, dynamic-member-lookup
  /// results, along with nested types, type aliases and associated
  /// types. E.g.
  /// ```
  /// struct MyStruct<T> {
  ///   func callAsFunction() {}
  /// }
  /// ```
  /// Qualified lookup within the `MyStruct` scope would
  /// return the `callAsFunction()` function declaration.
  /// Note that qualified lookup won't surface
  /// operator functions, objc functions using dynamic lookup, and
  /// generic parameters like `MyStruct.T` (semantically wrong).
  case members([DeclSyntax], introducedIn: DeclSyntax)
  /// Members declared in conditional extensions, e.g.
  /// ```
  /// extension Array where Element == Int {
  ///   func sum() -> Int { reduce(0, +) }
  /// }
  /// ```
  /// Qualified lookup will return the `sum()` declaration in
  /// the extension above together with the `where Element == Int`
  /// clause.
  case conditionalMembers(
    [DeclSyntax],
    introducedIn: DeclSyntax,
    inheritanceClause: InheritanceClauseSyntax?,
    genericClause: GenericWhereClauseSyntax?
  )
  /// Implicit members in the given group declaration like `self`,
  /// `Type` and synthesized initializers.
  case implicitMembers([DeclSyntax], introducedIn: DeclGroupSyntaxType)
  /// Types and protocols annotated with `@dynamicMemberLookup` have
  /// one or more subscripts with a `dynamicMember` string or keypath
  /// argument. We defer to the type-checker to determine what members
  /// these subscripts can produce.
  case lookForDynamicMembers(
    dynamicMemberSubscripts: [SubscriptDeclSyntax],
    introducedIn: DeclGroupSyntaxType
  )
  /// Any unknown attributes that could be attached macros or property
  /// wrappers that expand to more declarations, e.g.
  /// ```swift
  /// struct MyView {
  ///   @State var myState = 0
  /// }
  /// ```
  /// In this case, we instruct the tooling to look up what the
  /// `@State` attribute expands to in the variable declaration above
  /// (if anything).
  case lookForMacros(
    potentialMacroDecl: [DeclSyntax],
    introducedIn: DeclGroupSyntaxType
  )
  /// Look for any types we encountered in the lookup that weren't in
  /// the SymbolTable syntax trees (e.g. the looked up type conforms to
  /// a protocol from a different module).
  case lookForSupertypes(
    inheritedFrom: InheritanceClauseSyntax,
    genericClause: GenericWhereClauseSyntax?
  )
}

public class SymbolTable {
  let fileSyntax: SourceFileSyntax

  /// Construct a table for caching symbol lookup
  /// for the given file syntax.
  public init(fileSyntax: SourceFileSyntax) {
    self.fileSyntax = fileSyntax
  }
}

extension DeclGroupSyntax {
  /// Search for members matching given identifier.
  /// Parameters:
  /// - lookUpPosition: Indicates position where we should
  ///     start lookup. Will enable future expansion that filters
  ///     by access control.
  func lookupMember(
    _ identifier: Identifier?,
    // TODO: Consider changing this and unqualified lookup to "lookupPosition"
    // since "lookup" functions as a noun here.
    from lookUpPosition: AbsolutePosition?,
    with config: QualifiedLookupConfig = QualifiedLookupConfig()
  ) -> [QualifiedLookupResult] {
    []
  }

  // Same as above but can look up supertypes in SymbolTable
  func lookupMember(
    _ identifier: Identifier?,
    from lookUpPosition: AbsolutePosition?,
    using symbolTable: SymbolTable,
    with config: QualifiedTableLookupConfig = QualifiedTableLookupConfig()
  ) -> [QualifiedLookupResult] {
    []
  }
}
