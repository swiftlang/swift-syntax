//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftSyntaxMacros

private extension DeclSyntaxProtocol {
  var isObservableStoredProperty: Bool {
    if let property = self.as(VariableDeclSyntax.self),
      let binding = property.bindings.first,
      let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
      identifier.text != "_registrar", identifier.text != "_storage",
      binding.accessorBlock == nil
    {
      return true
    }

    return false
  }
}

public struct ObservableMacro: MemberMacro, MemberAttributeMacro {

  // MARK: - MemberMacro

  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let identified = declaration.asProtocol(NamedDeclSyntax.self) else {
      return []
    }

    let parentName = identified.name

    let registrar: DeclSyntax =
      """
      let _registrar = ObservationRegistrar<\(parentName)>()
      """

    let addObserver: DeclSyntax =
      """
      public nonisolated func addObserver(_ observer: some Observer<\(parentName)>) {
        _registrar.addObserver(observer)
      }
      """

    let removeObserver: DeclSyntax =
      """
      public nonisolated func removeObserver(_ observer: some Observer<\(parentName)>) {
        _registrar.removeObserver(observer)
      }
      """

    let withTransaction: DeclSyntax =
      """
      private func withTransaction<T>(_ apply: () throws -> T) rethrows -> T {
        _registrar.beginAccess()
        defer { _registrar.endAccess() }
        return try apply()
      }
      """

    let memberList = declaration.memberBlock.members.filter {
      $0.decl.isObservableStoredProperty
    }

    let storageStruct: DeclSyntax =
      """
      private struct Storage {
      \(memberList)
      }
      """

    let storage: DeclSyntax =
      """
      private var _storage = Storage()
      """

    return [
      registrar,
      addObserver,
      removeObserver,
      withTransaction,
      storageStruct,
      storage,
    ]
  }

  // MARK: - MemberAttributeMacro

  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingAttributesFor member: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [SwiftSyntax.AttributeSyntax] {
    guard member.isObservableStoredProperty else {
      return []
    }

    return [
      AttributeSyntax(
        attributeName: IdentifierTypeSyntax(
          name: .identifier("ObservableProperty")
        )
      )
    ]
  }

}

extension ObservableMacro: ExtensionMacro {
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    [try ExtensionDeclSyntax("extension \(type): Observable {}")]
  }
}

public struct ObservablePropertyMacro: AccessorMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AccessorDeclSyntax] {
    guard let property = declaration.as(VariableDeclSyntax.self),
      let binding = property.bindings.first,
      let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
      binding.accessorBlock == nil
    else {
      return []
    }

    let getAccessor: AccessorDeclSyntax =
      """
      get {
        _registrar.beginAccess(\\.\(identifier))
        defer { _registrar.endAccess() }
        return _storage.\(identifier)
      }
      """

    let setAccessor: AccessorDeclSyntax =
      """
      set {
        _registrar.beginAccess(\\.\(identifier))
        _registrar.register(observable: self, willSet: \\.\(identifier), to: newValue)
        defer {
          _registrar.register(observable: self, didSet: \\.\(identifier))
          _registrar.endAccess()
        }
        _storage.\(identifier) = newValue
      }
      """

    return [getAccessor, setAccessor]
  }
}
