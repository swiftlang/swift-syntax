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

import SwiftIfConfig
import SwiftSyntax

// MARK: Requested Extensions

extension SymbolTable {
  struct RequestedExtensions {
    fileprivate private(set) var current: Attached<ExtensionDeclSyntax>?
    /// The extensions that have not yet been admitted to the type graph.
    fileprivate private(set) var unresolvedExtensions: [SourceFileSyntax: [Attached<ExtensionDeclSyntax>]]
    private var requestedArray: [Attached<ExtensionDeclSyntax>]
    private var requestedSet: Set<Attached<ExtensionDeclSyntax>>

    /// Initialize `RequestedExtensions`, keeping track of unresolved extensions.
    ///
    /// Complexity: O(n) where `n` is the number of extensions across all files.
    init(fileToInfo: [SourceFileSyntax: FileInfo]) {
      // Find all the unresolved extensions
      var unresolvedExtensions = [SourceFileSyntax: [Attached<ExtensionDeclSyntax>]]()
      for (file, fileInfo) in fileToInfo {
        // Note: findExtensions gurantees in-order and no duplicates
        unresolvedExtensions[file] = file.findExtensions(configuredRegions: fileInfo.configuredRegions)
      }

      self.current = nil
      (self.requestedArray, self.requestedSet) = ([], [])
      self.unresolvedExtensions = unresolvedExtensions
    }

    /// Appends the requested extensions
    ///
    /// Complexity: O(n) where `n` is the number of `elements`.
    private mutating func append(contentsOf elements: [Attached<ExtensionDeclSyntax>]) {
      for element in elements {
        // Don't add the currently processing array
        guard current != element else { continue }
        // Add the extension if not already in the set.
        guard requestedSet.insert(element).inserted else { continue }
        requestedArray.append(element)
      }
    }

    /// Returns the last index and element of the requestedExtensions without
    /// popping; `nil` if empty.
    ///
    /// Precondition: No extensions are currently bound, i.e., the previous
    /// `current == nil`.
    ///
    /// Complexity: O(1) with respect to the number of requested extensions.
    fileprivate mutating func beginPop() -> Attached<ExtensionDeclSyntax>? {
      // Both of the following calls are O(1)
      guard let extensionDecl = requestedArray.popLast() else { return nil }
      requestedSet.remove(extensionDecl)

      if let current {
        fatalError(
          "[SwiftLexicalLookup] Internal error: Unexpectedly popped extension `\(extensionDecl._memberlessDescription)` while binding other extension `\(current._memberlessDescription)`"
        )
      }
      current = extensionDecl
      return extensionDecl
    }
    /// Removes the requested extension at the given index if it exists, or
    /// returns `nil`.
    ///
    /// Precondition: The given extension is `current`.
    ///
    /// Complexity: O(1) with respect to the number of requested extensions.
    fileprivate mutating func finalizePop(_ extensionDecl: Attached<ExtensionDeclSyntax>) {
      // Ensure we're finalizing the right extension
      precondition(
        extensionDecl == current,
        "[SwiftLexicalLookup] Internal error: Unexpectedly found different requested extension:  popped `\(extensionDecl._memberlessDescription)`; finalized `\(current?._memberlessDescription ?? "nil")`)"
      )
      // Reset the current
      current = nil
    }
  }
}

// MARK: Extension Requests

extension SymbolTable {
  @_spi(_QualifiedLookupTests)
  public func admitExtensions(accessibleFrom sourceFile: SourceFileSyntax) {
    // TODO: Implement
  }

  /// Returns the nominal-type reference with the extension's extended-type
  /// syntax as the originating syntax.
  @_spi(_QualifiedLookupTests)
  public func bindExtension(
    _ extensionDecl: Attached<ExtensionDeclSyntax>
  ) -> Result<TypeResolver.GloballyResolvedTypeSyntax, TypeResolver.Failure> {
    fatalError("TODO")
  }

  func getExtensionResolvedType(
    _ extensionDecl: Attached<ExtensionDeclSyntax>
  ) -> Result<TypeResolver.GloballyResolvedTypeSyntax, TypeResolver.Failure>? {
    fatalError("TODO")
  }
}

// MARK: Qualified-Lookup Requests

extension SymbolTable {
  func findMemberType(
    baseType: TypeGraph.TypeRef,
    memberTypeName: Identifier,
    introducingTypeSyntax: Attached<TypeLikeSyntax>,
    introducingModule: ModuleName,
    dependencyTracker: inout DependencyTracker
  ) -> Result<
    [(declGroupParent: Attached<DeclGroupSyntaxType>, typeDecl: Attached<TypeDeclSyntax>)],
    TypeGraph.QualifiedTypeLookupFailure
  > {
    // TODO: Implement `TypeGraph`-based lookup
    let fileInfo = getFileInfo(introducingTypeSyntax.fileRoot)!
    var typeDecls = [Attached<TypeDeclSyntax>]()
    // Look just in the nominal-type decl
    baseType.mainDecl.node.visitDirectMembers(
      configuredRegions: fileInfo.configuredRegions,
      visit: {
        guard let typeDecl = $0.as(TypeDeclSyntax.self),
          let attachedTypeDecl = Attached(typeDecl)
        else {
          return
        }
        typeDecls.append(attachedTypeDecl)
      }
    )
    return Result.success(
      typeDecls.map({ (declGroupParent: Attached<DeclGroupSyntaxType>(baseType.mainDecl), typeDecl: $0) })
    )
  }
}

// MARK: Registration Requests

extension SymbolTable {
  /// Registers nominal type by forwarding to `TypeGraph/registerNominalType`
  func registerNominalType(
    topScopeMainDecl: Attached<NominalTypeDeclSyntax>,
    declName: Identifier,
    declFileInfo: FileInfo,
    isGlobal: Bool,
    originatingSyntax: Attached<TypeLikeSyntax>
  ) -> Result<TypeResolver.ResolvedTypeSyntax, TypeGraph.NominalRegistrationFailure> {
    fatalError("TODO")
  }
  /// Registers nominal type by forwarding to `TypeGraph/registerNominalType`
  func registerNominalType(
    nestedMainDecl: Attached<NominalTypeDeclSyntax>,
    declName: Identifier,
    declFileInfo: FileInfo,
    baseDeclGroup: Attached<DeclGroupSyntaxType>,
    baseType: TypeResolver.ResolvedTypeSyntax,
    originatingSyntax: Attached<TypeLikeSyntax>
  ) -> Result<TypeResolver.ResolvedTypeSyntax, TypeGraph.NestedNominalRegistrationFailure> {
    fatalError("TODO")
  }
  /// Updates a registered nominal type by forwarding to `TypeGraph/updateNominalTypeReference`.
  func updateNominalTypeReference(
    oldReference: TypeGraph.TypeRef
  ) -> Result<TypeGraph.TypeRef, TypeGraph.NominalTypeRefUpdateFailure> {
    fatalError("TODO")
  }
}
