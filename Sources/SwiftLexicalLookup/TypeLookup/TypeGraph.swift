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

#if compiler(>=6)
private import SwiftDiagnostics
#else
import SwiftDiagnostics
#endif

/// A directed acyclic graph where type members (`Base > Name`) are nodes and
/// dependencies are edges, each labeled with the declaration group that
/// introduces its target member (see `TypeGraph.md` > The conceptual graph).
///
/// Note: The graph is stored compactly. We only store:
///       1. Admitted nominal types (`namesToTypes`), because resolution must
///          produce a unique reference to each nominal type.
///       2. The state of each admitted extension (`extensionsToState`), because
///          extension binding is incremental, so we must quickly admit and
///          evict extensions.
///       `TypeResolver` recovers the other members (type aliases, redeclarations,
///       missing members) from the type tables on demand.
///
/// Complexity
/// ==========
///
/// Notation:
/// - `h`:   cost of hashing a `GlobalTypeName`; grows with nesting depth
///          Every "O(1)" map access is O(h), but `h` is typically at most 3.
/// - `s`:   # member declarations in one declaration group (`_groupTypeMembers` input)
/// - `m`:   # type members of one declaration group (`TypeTable` entries)
/// - `E_T`: # extensions bound to type `T`
/// - `D_T`: # dependents of type `T`
/// - `d`:   # dependencies of one extension / `DependencyTracker`
///
/// Accesses:
/// 1. Type -> extensions, O(E_T)
///    For qualified lookup, which must see every declaration group of `T`.
/// 2. Extension -> state, O(h)
///    To know if an extension is already admitted; called once per extension
///    binding request, so it must not depend on graph size.
/// 3. Extension -> dependencies, O(d)
///    For cycle detection and for unregistering on removal.
/// 4. Type -> dependents, O(D_T)
///    For eviction when an extension adds/removes a type member of `T`.
/// 5. Extension -> resolved type, O(h)
///    Lookup within an extension almost always first resolves the extended
///    type so we can look for its members, e.g.
///    ```swift
///    struct A { struct B {} }
///    extension A {
///      func f(_: B) // <- Must quickly find that `A>B` is a valid member.
///    }
///    ```
///
/// Operations:
/// 1. `admitType`: O(s + h)
///    Groups the main declaration's members once; one map insert.
/// 2. `findMemberType`: O(E_T + d); O(d) if repeated with the same tracker
///    Scans the main declaration and every bound extension of the base type
///    (bucketed by file/module for shadowing), then de-duplicates against the
///    tracker with a linear scan (`d` is small). Local base types instead
///    regroup their members on every call, O(s).
/// 3. `getExtensionResolvedType`, `updateNominalTypeReference`: O(h)
///    Two map lookups.
/// 4. `admitExtension` (without eviction): O(s + C + E_T + Σ D_T)
///    - O(s): groups the extension's members.
///    - C: cycle detection; DFS over dependency *paths* without a visited set,
///      so exponential in the worst case (shared sub-chains are re-walked)
///      but linear in practice, since dependency chains are short.
///    - O(E_T): binding copies `T`'s `boundExtensions` (copy-on-write, since
///      the old value is still in `namesToTypes`).
///    - O(Σ D_T) over each dependency's type: duplicate check plus
///      copy-on-write of `dependents`.
/// 5. Eviction (`_evictDependents` on `T` with `k` conflicting dependents):
///    O(k · D_T) locally plus one `_evictExtension` per evicted extension
///    Each pop rescans `dependents`. An unbind costs O(m · h + Σ D_T + E_T):
///    it unbinds each member (recursing into nested types) and removes
///    itself from the dependents of each dependency. The cascade is
///    transitive, and evicted extensions are re-admitted later at full
///    admission cost, so one extension may be evicted repeatedly.
/// 6. Debug builds: every checked wrapper (`_x` -> `__x`) runs `_introspect`,
///    which is O(graph size), at each recursion level, so cascades become
///    quadratic.
///
/// Extension binding is challenging because it's incremental, i.e., we process
/// one extension at a time. Hence, we process just one extension at a time
/// using just current lookup results, keeping track of dependencies. This
/// approach allows us to remain in a consistent state. When we add other
/// extensions --and eventually all accessible extensions-- we use those
/// dependencies and the new lookup state to update old results.
///
/// Extension binding is incremental because:
/// 1. Extensions may depend on other extensions, e.g.:
///    ```swift
///    struct A {}
///    extension A.Inner {} // <- Resolving this extension requires finding 'Inner' in `A`
///    extension A { typealias Inner = A }
///    ```
/// 2. We might get a module's extensions later in compilation
///
/// Here's how this would play out in the above example if we wanted to
/// bind all of A's extensions:
/// 1. We start with `extension A.Inner`
///    a. We resolve `A` to '_(MyFile.swift)::A'
///    b. Currently, `A` has no type members, so `A.Inner` doesn't exist
///       This is the desired result, because if our program was just
///         struct A {}; extension A.Inner {}`
///       that's the exact error we'd expect.
///    c. So we mark `extension A.Inner` as invalid and record this result's dependence
///       on the fact that `A` has not memebr `Inner`
/// 2. We look at `extension A`
///    a. We resolve `A` to '_(MyFile.swift)::A' and bind the extension to '_(MyFile.swift)::A'
///    b. Now, `A` gains a type member `Inner`
///    c. We find `extension A.Inner` depended on this member so we recompute
///       it
///    d. Now, `extension A.Inner` resolves to '_(MyFile.swift)::A' depending on
///       the fact that '_(MyFile.swift)::A' has no type member `A`
///       * This dependence comes from resolving `typealias Inner = A`
///    e. Finally, we bind `extension A.Inner` to '_(MyFile.swift)::A'
@_spi(_QualifiedLookupTests)
public struct TypeGraph {
  /// Updates when we register nominal types and bind extensions
  ///
  /// Invariants (see `TypeGraph.md` > Implementation):
  /// - *Registered file roots*: `symbolTable.getFileInfo(type.mainDecl.fileRoot) != nil`.
  /// - *Nested types have parents*: if `name.base != nil`, then `type.mainDecl` is in
  ///   the type table of either:
  ///   a. `namesToTypes[name.base!]?.mainDeclMembers` for the parent main declaration, xor
  ///   b. `namesToTypes[name.base!]?.boundExtensions[module]?[extensionDecl]` for
  ///      the parent extension `extensionDecl`.
  private(set) var namesToTypes: [TypeGraph.GlobalTypeName: NominalType]
  /// Invariant (see `TypeGraph.md` > Implementation):
  /// - *Registered file roots*: `symbolTable.getFileInfo(extensionDecl.fileRoot) != nil`.
  @_spi(_QualifiedLookupTests)
  public private(set) var extensionsToState: [Attached<ExtensionDeclSyntax>: ExtensionState]

  init() {
    namesToTypes = [:]
    extensionsToState = [:]
  }
}

// MARK: TypeGraph.NominalType

extension TypeGraph {
  @_spi(_QualifiedLookupTests)
  public struct NominalType {
    /// Keeps track of mutations to assert data didn't change between calls
    internal private(set) var version = 0

    /// Invariant (see `TypeGraph.md` > Implementation):
    /// - *No readmission*: no other type in `TypeGraph/namesToTypes` has the
    ///   same `mainDecl`.
    fileprivate let mainDecl: Attached<NominalTypeDeclSyntax>
    /// The type members of `mainDecl`
    fileprivate let mainDeclMembers: TypeTable

    /// Invariant (see `TypeGraph.md` > Implementation):
    /// - *Bound extensions*: for the type named `typeName`,
    ///   `boundExtensions[module]?[extensionDecl] != nil` if and only if
    ///   `TypeGraph/extensionsToState[extensionDecl]?.resolvedType == .success(typeName)`,
    ///   where `module` is `extensionDecl`'s module.
    fileprivate(set) var boundExtensions: [ModuleName: [Attached<ExtensionDeclSyntax>: TypeTable]]

    /// Extensions dependending on qualified lookup of `member` on this type.
    ///
    /// This property is part of `NominalType` and not `ExtensionState` because
    /// any extension binding to this nominal type should see that it's evicting
    /// other extensions.
    ///
    /// Invariant (see `TypeGraph.md` > Implementation):
    /// - *Dependencies and dependents match*: for the type named `typeName`,
    ///   `dependents` contains `TypeDependent(memberType: member, dependentExtension: extensionDecl)`
    ///   if and only if
    ///   `TypeGraph/extensionsToState[extensionDecl]?.dependencies` contains a
    ///   dependency with `baseTypeName == typeName` on `member`.
    fileprivate(set) var dependents: [TypeDependent]

    init(mainDecl: Attached<NominalTypeDeclSyntax>, mainDeclMembers: TypeTable) {
      self.mainDecl = mainDecl
      self.mainDeclMembers = mainDeclMembers
      self.boundExtensions = [:]
      self.dependents = []
    }
  }
}

// MARK: TypeGraph.IntroducingExtensionOrMainDecl

@_spi(_QualifiedLookupTests)
public typealias IntroducingExtensionOrMainDecl = Attached<ExtensionDeclSyntax>?

// MARK: TypeGraph.TypeTable

extension TypeGraph {
  /// The direct type members declared by a *single* declaration group (nominal
  /// type or extension).
  struct TypeTable {
    /// Maps each member's name to every declaration introducing it in this
    /// declaration group. More than one declaration for the same name means
    /// the member is ambiguous (redeclared) within this one declaration group.
    ///
    /// Note: This is a `Dictionary`, so it must generally not be iterated to
    /// uphold `SymbolTable`'s determinism requirement.
    fileprivate(set) var typeMembersToDecls: [Identifier: [Attached<TypeDeclSyntax>]]
  }
}

// MARK: TypeGraph.TypeDependent

extension TypeGraph {
  struct TypeDependent: Sendable, Hashable, CustomDebugStringConvertible {
    let memberType: Identifier
    let dependentExtension: Attached<ExtensionDeclSyntax>

    public var debugDescription: String {
      "Self > '\(memberType.name)' => `\(dependentExtension.node._memberlessDescription)`"
    }
  }
}

// MARK: TypeGraph.ExtensionState

extension TypeGraph {
  /// The state of an admitted extension: what type it resolved to and the
  /// dependencies for that resolution result.
  ///
  /// Note: Extension state uses `GlobalTypeName` instead of `GlobalTypeRef`
  /// since the type graph already stores information about types in a
  /// different property.
  @_spi(_QualifiedLookupTests)
  public struct ExtensionState: Sendable {
    // See `ExtensionDependency` docstring for why these properties are *immutable*.

    /// Invariants (see `TypeGraph.md` > Implementation), for the extension `extensionDecl`:
    /// - *Dependencies and dependents match*: See `NominalType/dependents`.
    /// - *Extensions depend on type members*: each member's `decls` equal,
    ///   regardless of order, the declarations of that member in the base
    ///   type's main declaration and bound extensions.
    /// - *No cycles*: following the introducing extensions of `decls`
    ///   recursively never reaches a member with an identifier that
    ///   `extensionDecl` introduces into the resolved type.
    /// - *Extensions depend on type members*: there's at most one dependency
    ///   per base type.
    @_spi(_QualifiedLookupTests) public let dependencies: [ExtensionDependency]
    /// Invariant (see `TypeGraph.md` > Implementation):
    /// - *Bound extensions*: `resolvedType == .success(typeName)` if and only if
    ///   `TypeGraph/namesToTypes[typeName]?.boundExtensions[module]?[extensionDecl] != nil`,
    ///   where `module` is `extensionDecl`'s module.
    @_spi(_QualifiedLookupTests) public let resolvedType: Result<TypeGraph.GlobalTypeName, TypeResolver.Failure>

    @_spi(_QualifiedLookupTests) public init(
      _uncheckedDependencies dependencies: [ExtensionDependency],
      resolvedType: Result<TypeGraph.GlobalTypeName, TypeResolver.Failure>
    ) {
      self.dependencies = dependencies
      self.resolvedType = resolvedType
    }
  }
}

// MARK: TypeGraph.ExtensionDependency

extension TypeGraph {
  /// An extension dependency stores cached information such as what declaration
  /// group the given member was introduced. Normally, we don't store cached
  /// information for types stored in the `TypeGraph` since we must
  /// later update a lot of cached data when we bind/evict an extension.
  /// However, extension dependencies are different because if the dependency
  /// type changes, we necessarily have to evict and recompute the extensions.
  /// Hence, extension dependencies should be created at extension binding and not
  /// be modified (we simply evict the extension and destroy its state along
  /// with any dependencies).
  @_spi(_QualifiedLookupTests)
  public struct ExtensionDependency: Sendable {
    /// The base type on whose members we depend.
    fileprivate let baseTypeName: TypeGraph.GlobalTypeName

    /// The type members of base type on which we depend, in lookup order.
    ///
    /// This is an ordered list rather than a `[Identifier: ...]` dictionary,
    /// because want a deterministic order when evicting extensions to
    /// uphold `SymbolTable`'s determinism requirement.
    ///
    /// Invariant: `members` is nonempty
    fileprivate let members: [(name: Identifier, decls: [Member])]

    /// Precondition: `members` must be nonempty
    @_spi(_QualifiedLookupTests)
    public init(
      dependencyTypeName: TypeGraph.GlobalTypeName,
      members: [(name: Identifier, decls: [Member])]
    ) {
      assert(!members.isEmpty, "`members` must be nonempty")

      self.baseTypeName = dependencyTypeName
      self.members = members
    }
  }
}

// MARK: TypeGraph.ExtensionDependency.Member

extension TypeGraph.ExtensionDependency {
  /// One declaration contributing to a dependency's member, together with
  /// the declaration group that introduced it.
  ///
  /// A member can have more than one contributing declaration when it's
  /// ambiguous. For instance, a type alias declared both in a type's own
  /// body and again in one of its extensions.
  @_spi(_QualifiedLookupTests)
  public struct Member: Hashable, Sendable {
    /// The extension that introduced `typeDecl`, or `nil` if `typeDecl`
    /// was declared in the nominal-type declaration.
    ///
    /// Note: We care about extensions and not nominal-type declarations,
    /// because cycles can only form between extensions.
    @_spi(_QualifiedLookupTests)
    public let introducingExtensionOrMainDecl: IntroducingExtensionOrMainDecl
    @_spi(_QualifiedLookupTests)
    public let typeDecl: Attached<TypeDeclSyntax>

    @_spi(_QualifiedLookupTests)
    public init(
      introducingExtensionOrMainDecl: IntroducingExtensionOrMainDecl,
      typeDecl: Attached<TypeDeclSyntax>
    ) {
      self.introducingExtensionOrMainDecl = introducingExtensionOrMainDecl
      self.typeDecl = typeDecl
    }
  }
}

// MARK: TypeGraph.QualifiedLookupDependency

extension TypeGraph {
  /// A `DependencyTracker` dependency.
  ///
  /// Unlike `ExtensionDependency`, `QualifiedLookupDependency` is built for
  /// tracking the dependency order to allow for more accurate diagnostics in
  /// the future. On the other hand, `ExtensionState/dependencies` groups
  /// dependencies by base type, and member decls by their name to optimize for lookup.
  @_spi(_QualifiedLookupTests)
  public struct QualifiedLookupDependency: Sendable {
    let baseTypeName: TypeGraph.GlobalTypeName
    let member: Identifier
    let memberDecls: [(declGroupParent: Attached<DeclGroupSyntaxType>, typeDecl: Attached<TypeDeclSyntax>)]

    @_spi(_QualifiedLookupTests)
    public init(
      baseTypeName: TypeGraph.GlobalTypeName,
      member: Identifier,
      memberDecls: [(Attached<DeclGroupSyntaxType>, Attached<TypeDeclSyntax>)]
    ) {
      self.baseTypeName = baseTypeName
      self.member = member
      self.memberDecls = memberDecls
    }
  }
}

extension TypeGraph.ExtensionState {
  /// Initializes state after converting `DependencyTracker/dependencies` to
  /// `ExtensionState/dependencies`.
  ///
  /// The dependency tracker dependencies only guarantee there are no duplicates.
  /// Hence, this initializer groups dependencies by type name and member name
  /// to satisfy the `ExtensionState/dependencies` invariants.
  fileprivate init(
    dependencies: [TypeGraph.QualifiedLookupDependency],
    resolvedType: Result<TypeGraph.GlobalTypeName, TypeResolver.Failure>
  ) {
    // Group dependencies by base type and member name, while maintaing order
    var groupedDependencies =
      [
        (
          key: TypeGraph.GlobalTypeName,
          value: [(key: Identifier, value: [(Attached<DeclGroupSyntaxType>, Attached<TypeDeclSyntax>)])]
        )
      ]()

    for dependency in dependencies {
      // Note: We can assign directly because ``DependencyTracker/dependencies`` guarantees
      // that type/member-name pairs have just a single entry.
      groupedDependencies[_key: dependency.baseTypeName, default: []][_key: dependency.member, default: []]
        .append(contentsOf: dependency.memberDecls)
    }

    // Map to `ExtensionDependency`
    let orderedGroupedDependencies: [TypeGraph.ExtensionDependency] = groupedDependencies.map({ (typeName, members) in
      // Note: `members` is nonempty by construction, satisfying the `ExtensionDependency.init` precondition.
      TypeGraph.ExtensionDependency(
        dependencyTypeName: typeName,
        members: members.map({ (name, typeDecls) in
          (
            name: name,
            decls: typeDecls.map({ typeDecl in
              TypeGraph.ExtensionDependency.Member(
                introducingExtensionOrMainDecl: typeDecl.0.as(ExtensionDeclSyntax.self),
                typeDecl: typeDecl.1
              )
            })
          )
        })
      )
    })

    // Note: Grouping satisfies "one dependency per type" invariant
    self.init(
      _uncheckedDependencies: orderedGroupedDependencies,
      resolvedType: resolvedType
    )
  }
}

// MARK: TypeGraph.DependencyTracker

extension TypeGraph {
  @_spi(_QualifiedLookupTests)
  public struct DependencyTracker {
    /// Invariant: There's at most one dependency for the same type/member-name pair.
    @_spi(_QualifiedLookupTests)
    public private(set) var dependencies: [QualifiedLookupDependency]

    @_spi(_QualifiedLookupTests)
    public init(
      _uncheckedDependencies dependencies: [QualifiedLookupDependency] = []
    ) {
      self.dependencies = dependencies
    }

    /// Add the given dependency, maintaining unique dependencies
    fileprivate mutating func _addLookupDependency(
      baseTypeName: TypeGraph.GlobalTypeName,
      memberTypeName: Identifier,
      performLookup: (TypeGraph.GlobalTypeName, Identifier) -> QualifiedLookupDependency
    ) -> [(declGroupParent: Attached<DeclGroupSyntaxType>, typeDecl: Attached<TypeDeclSyntax>)] {
      // Try to find existing request
      //
      // Note: Although this takes O(n) time where `n` is the number of dependencies,
      // we shouldn't have that many dependencies and small arrays are fast
      // at linear search.
      if let existingResult = dependencies.first(where: {
        $0.baseTypeName == baseTypeName && $0.member == memberTypeName
      }) {
        return existingResult.memberDecls
      }

      // Otherwise, compute and add
      let result = performLookup(baseTypeName, memberTypeName)
      dependencies.append(result)
      return result.memberDecls
    }
  }
}

// MARK: Invariants

extension TypeGraph {
  /// Specification invariants (see `_firstInvariantViolation`)
  @_spi(_QualifiedLookupTests)
  public enum GraphFailure {
    /// A nominal-type declaration is admitted under more than one name.
    case duplicateMainDecl
    /// An admitted `Attached<NominalTypeDeclSyntax>` or `Attached<ExtensionDeclSyntax>`
    /// has a file root not registered in the SymbolTable. I.e., `SymbolTable/getFileInfo`
    /// returns nil.
    case noFileInfo
    /// A resolved extension points to a non-admitted type
    case danglingExtension
    /// An extension resolved to a type that doesn't bind it (under the
    /// extension's module).
    case unboundExtension
    /// A type binds an extension whose state doesn't resolve to that type.
    case misboundExtension
    /// An extension has more than one dependency on the same base type.
    case duplicateDependency
    /// A dependency points to a non-admitted type
    case danglingDependency
    /// An extension depends on a type's member, but the type doesn't record
    /// the extension as a dependent.
    case missingDependent
    /// A type records a dependent extension that isn't admitted or doesn't
    /// depend on that member.
    case missingDependency
    /// A dependency's declarations don't match the declarations the type's
    /// main declaration and bound extensions currently introduce for that
    /// member.
    case staleDependency
    /// A nested type isn't a member of its parent type's main declaration or
    /// bound extensions (or the parent isn't admitted).
    case parentlessType
    /// A bound extension's recursive dependencies rely on a member that the
    /// extension introduces.
    case dependencyCycle
  }
}

extension TypeGraph {
  /// Crashes in DEBUG if the graph breaks an invariant (see
  /// `_firstInvariantViolation`).
  fileprivate func _assertInvariants(
    symbolTable: SymbolTable,
    file: StaticString = #file,
    line: UInt = #line,
    function: StaticString = #function
  ) {
    #if DEBUG
    if let violation = _firstInvariantViolation(symbolTable: symbolTable) {
      assertionFailure("\(violation)", file: file, line: line)
    }
    #endif
  }

  /// Returns the first broken invariant (see TypeGraph.md), or `nil` if the
  /// graph is valid.
  ///
  /// Invariants are checked one at a time across the whole graph, so the
  /// returned failure doesn't depend on dictionary order. Later checks assume
  /// earlier ones passed.
  @_spi(_QualifiedLookupTests)
  public func _firstInvariantViolation(symbolTable: SymbolTable) -> GraphFailure? {
    // Each main decl is admitted under one name
    var mainDecls = Set<Attached<NominalTypeDeclSyntax>>()
    for type in namesToTypes.values {
      guard mainDecls.insert(type.mainDecl).inserted else { return .duplicateMainDecl }
    }

    // Admitted types and extensions have registered file roots
    for type in namesToTypes.values {
      guard symbolTable.getFileInfo(type.mainDecl.fileRoot) != nil else { return .noFileInfo }
    }
    for extensionDecl in extensionsToState.keys {
      guard symbolTable.getFileInfo(extensionDecl.fileRoot) != nil else { return .noFileInfo }
    }

    // Extensions resolve to a type iff that type binds them
    for (extensionDecl, state) in extensionsToState {
      guard case .success(let typeName) = state.resolvedType else { continue }
      guard let type = namesToTypes[typeName] else { return .danglingExtension }
      // Force-unwrap by file-root test above.
      let module = symbolTable.getFileInfo(extensionDecl.fileRoot)!.module
      guard type.boundExtensions[module]?[extensionDecl] != nil else { return .unboundExtension }
    }
    for (typeName, type) in namesToTypes {
      for extensionDecl in type.boundExtensions.values.flatMap(\.keys) {
        guard case .success(typeName) = extensionsToState[extensionDecl]?.resolvedType else {
          return .misboundExtension
        }
      }
    }

    // Each extension has at most one dependency per base type
    for state in extensionsToState.values {
      var baseTypeNames = Set<GlobalTypeName>()
      for dependency in state.dependencies {
        guard baseTypeNames.insert(dependency.baseTypeName).inserted else { return .duplicateDependency }
      }
    }

    // Dependencies and dependents match
    for (extensionDecl, state) in extensionsToState {
      for dependency in state.dependencies {
        guard let type = namesToTypes[dependency.baseTypeName] else { return .danglingDependency }
        for member in dependency.members {
          let dependent = TypeDependent(memberType: member.name, dependentExtension: extensionDecl)
          guard type.dependents.contains(dependent) else { return .missingDependent }
        }
      }
    }
    for (typeName, type) in namesToTypes {
      for dependent in type.dependents {
        let dependsOnMember = extensionsToState[dependent.dependentExtension]?.dependencies.contains(where: {
          $0.baseTypeName == typeName && $0.members.contains(where: { $0.name == dependent.memberType })
        })
        guard dependsOnMember == true else { return .missingDependency }
      }
    }

    // Dependencies match the type members in the graph
    for state in extensionsToState.values {
      for dependency in state.dependencies {
        // Force-unwrap because we checked `dependency.baseTypeName`
        // is valid in the previous step.
        let type = namesToTypes[dependency.baseTypeName]!
        for member in dependency.members {
          var currentDecls = (type.mainDeclMembers.typeMembersToDecls[member.name] ?? []).map({
            ExtensionDependency.Member(introducingExtensionOrMainDecl: nil, typeDecl: $0)
          })
          for (extensionDecl, typeTable) in type.boundExtensions.values.joined() {
            currentDecls += (typeTable.typeMembersToDecls[member.name] ?? []).map({
              ExtensionDependency.Member(introducingExtensionOrMainDecl: extensionDecl, typeDecl: $0)
            })
          }
          // Lookup order depends on where the lookup happened, so compare
          // the declarations regardless of order.
          guard member.decls.count == currentDecls.count, Set(member.decls) == Set(currentDecls) else {
            return .staleDependency
          }
        }
      }
    }

    // Nested types are members of their parent's main decl or bound extensions
    //
    // Also, collect parented/nested types for next check.
    var parentedTypes = Set<GlobalTypeName>()
    for (typeName, type) in namesToTypes {
      // Collect the type's main-type & extension declaration groups and type tables.
      let declGroups =
        [(declGroup: Attached<DeclGroupSyntaxType>(type.mainDecl), typeTable: type.mainDeclMembers)]
        + type.boundExtensions.values.joined().map({
          (declGroup: Attached<DeclGroupSyntaxType>($0.key), typeTable: $0.value)
        })
      for (declGroup, typeTable) in declGroups {
        // Force-unwrap by file-root test above.
        let declGroupFileInfo = symbolTable.getFileInfo(declGroup.fileRoot)!
        for (memberName, memberDecls) in typeTable.typeMembersToDecls {
          let memberTypeName = typeName.addingComponent(
            GlobalTypeName.Component(
              name: memberName,
              file: declGroup.fileRoot,
              fileInfo: declGroupFileInfo,
              symbolTable: symbolTable
            )
          )
          guard
            let memberType = namesToTypes[memberTypeName],
            memberDecls.contains(where: { $0.as(NominalTypeDeclSyntax.self) == memberType.mainDecl })
          else { continue }
          parentedTypes.insert(memberTypeName)
        }
      }
    }
    // Diagnose parentless nested types.
    for typeName in namesToTypes.keys where typeName.base != nil {
      guard parentedTypes.contains(typeName) else { return .parentlessType }
    }

    // No bound extension recursively depends on a member it introduces
    for (extensionDecl, state) in extensionsToState {
      // Get the extended-type name and the extension-decl module
      guard case .success(let typeName) = state.resolvedType else { continue }
      // Force-unwrap by file-root and bound-extension checks above.
      let extensionModule = symbolTable.getFileInfo(extensionDecl.fileRoot)!.module
      let cycle = _firstCycle(
        extensionDecl: extensionDecl,
        extensionState: state,
        // Force-unwrap by `dependency.baseTypeName` check above
        extensionMembers: namesToTypes[typeName]!.boundExtensions[extensionModule]![extensionDecl]!
      )
      guard cycle == nil else { return .dependencyCycle }
    }

    return nil
  }
}

// MARK: TypeRef Helpers

extension TypeGraph.GlobalTypeRef {
  init(
    name: TypeGraph.GlobalTypeName,
    nominal: __shared TypeGraph.NominalType
  ) {
    self.init(name: name, mainDecl: nominal.mainDecl, _version: nominal.version)
  }
}

extension TypeGraph {
  /// Helper that forms a reference to the given `GlobalTypeName`, or returns
  /// `nil` if it's not in the graph.
  ///
  /// Useful for getting the final version of a nominal type after binding extensions.
  func getGlobalNominalTypeReference(name: GlobalTypeName) -> TypeGraph.GlobalTypeRef? {
    namesToTypes[name].map({
      TypeGraph.GlobalTypeRef(name: name, nominal: $0)
    })
  }
}

// MARK: - Cycle Detection

extension TypeGraph {
  /// Minimal data structure for DFS on extension dependencies
  fileprivate struct _CycleDetectorFrame {
    /// Identifies a specific dependency type declaration as:
    /// ```
    /// state.dependencies[index.dependency]
    ///       .members[index.member]
    ///       .decls[index.decl]
    /// ```
    typealias Index = (dependency: Int, member: Int, decl: Int)

    let firstExtensionState: ExtensionState
    /// The path to currently visited extension dependency. Note: `idx`
    /// is initialized to `(0,0,0)`.
    ///
    /// Invariant: For all extensions, `extensionsToState[ext]?.dependents`
    /// exists and is nonempty.
    var stack: [(ext: Attached<ExtensionDeclSyntax>, idx: Index)]
    private var descended: Bool = false
  }
}

extension TypeGraph._CycleDetectorFrame {
  fileprivate mutating func advance(newIndex: Index?) {
    if let newIndex {
      stack[stack.count - 1].idx = newIndex
      descended = false
    } else {
      stack.removeLast()
      descended = true
    }
  }
  fileprivate mutating func push(_ extensionDecl: Attached<ExtensionDeclSyntax>, index: Index) {
    assert(
      !descended,
      "Pushed an extension right after a descent without advancing (would descend infinitely)"
    )
    stack.append((extensionDecl, index))
  }

  /// Finds next dependency member given the `descended` and `stack` state.
  ///
  /// Returns: `nil` if no items are left, `Optional(nil)` if we just finished a descent and
  /// need to skip, otherwise returns the next dependency member.
  fileprivate mutating func nextDependencyMember(
    graph: borrowing TypeGraph
  ) -> (
    index: Index?,
    dependency: TypeGraph.ExtensionDependency, memberID: Identifier,
    isFirstDecl: Bool, decl: TypeGraph.ExtensionDependency.Member?
  )?? {
    guard let (extensionDecl, index) = stack.last else { return nil }

    // Use `firstExtensionState` for first stack entry, if provided
    // Pushed extensions introduce a dependency's declaration, so they must be admitted
    let state: TypeGraph.ExtensionState
    if stack.count == 1 {
      state = firstExtensionState
    } else {
      guard let pushedState = graph.extensionsToState[extensionDecl] else {
        fatalError("\(TypeGraph.GraphFailure.staleDependency)")
      }
      state = pushedState
    }
    // Note: The initial access at index `(0,0,0)` is safe because `members` is
    // nonempty according to `ExtensionDependency`, and `dependencies`
    // is nonempty by the `stack` invariant. However, `decls` can be empty
    // (we may depend on the type declarations being empty)
    let dependency = state.dependencies[index.dependency]
    let member = dependency.members[index.member]
    let decl = member.decls.isEmpty ? nil : member.decls[index.decl]

    let newIndex: Index?
    if index.decl + 1 < member.decls.count {
      // If available, move to next decl in the member
      newIndex = (index.dependency, index.member, index.decl + 1)
    } else if index.member + 1 < dependency.members.count {
      // Else, move to next member in the dependency
      newIndex = (index.dependency, index.member + 1, 0)
    } else if index.dependency + 1 < state.dependencies.count {
      // Else, move to next dependency in the extension
      newIndex = (index.dependency + 1, 0, 0)
    } else {
      // Otherwise, we're done with the extension
      newIndex = nil
    }

    // Advance we descended and just came back (we've already visited `memberDecl`)
    guard !descended else {
      advance(newIndex: newIndex)
      return Optional(nil)
    }

    return (newIndex, dependency, member.name, index.decl == 0, decl)
  }

  fileprivate consuming func toCycle(
    graph: borrowing TypeGraph
  ) -> TypeResolver.ExtensionCycle {
    var dependencyPath: [TypeResolver.ExtensionCycleElement] = []
    // First extension is entrypoint; it only introduces the next element
    var previousState = firstExtensionState
    var previousIndex = stack[0].idx
    for (ext, idx) in stack.dropFirst() {
      // Extensions introducing a dependency's declarations must be admitted and bound
      guard let state = graph.extensionsToState[ext], case .success(let extendedType) = state.resolvedType else {
        fatalError("\(TypeGraph.GraphFailure.staleDependency)")
      }
      guard let boundType = graph.getGlobalNominalTypeReference(name: extendedType) else {
        fatalError("\(TypeGraph.GraphFailure.danglingExtension)")
      }
      // The previous extension's current decl introduced this extension (so it exists)
      let introducingDecl = previousState.dependencies[previousIndex.dependency].members[previousIndex.member]
        .decls[previousIndex.decl]
      dependencyPath.append(
        TypeResolver.ExtensionCycleElement(
          introducingTypeDecl: introducingDecl.typeDecl.node,
          extensionDecl: ext.node,
          boundType: boundType
        )
      )
      (previousState, previousIndex) = (state, idx)
    }

    return TypeResolver.ExtensionCycle(
      dependencyPath: dependencyPath,
      // The last extension's current member conflicts with the entrypoint's members
      dependencyMember: previousState.dependencies[previousIndex.dependency].members[previousIndex.member].name
    )
  }
}

extension TypeGraph {
  /// Returns the dependency path through which `extensionDecl` with
  /// state `extensionState`, recursively depends on one of `extensionMembers`.
  /// Otherwise, returns `nil` (*No cycles*, see `TypeGraph.md` > Implementation).
  ///
  /// Used both before binding an extension (`admitExtension`) and to check
  /// bound extensions (`_firstInvariantViolation`).
  ///
  /// Parameters:
  /// - extensionState: The state to use for the given extension (admitted or
  ///   about to be admitted).
  /// Preconditions:
  /// - Every extension introducing a member of `dependencies` recursively,
  ///   is admitted and bound (*Extensions depend on type members*)
  /// Complexity: `O(n)` where `n` is the number of the given extension's
  /// transitive-dependency declarations.
  fileprivate func _firstCycle(
    extensionDecl: Attached<ExtensionDeclSyntax>,
    extensionState: ExtensionState,
    extensionMembers: TypeTable,
  ) -> TypeResolver.ExtensionCycle? {
    // Extensions without dependencies or that aren't bound, don't introduce cycles
    guard !extensionState.dependencies.isEmpty,
      case .success(let extendedTypeName) = extensionState.resolvedType
    else {
      return nil
    }

    // Track path to each dependency
    // We checked `!dependencies.isEmpty` above, so the index `(0,0,0)` is valid.
    var frame = _CycleDetectorFrame(firstExtensionState: extensionState, stack: [(extensionDecl, (0, 0, 0))])
    var visitedExtensions: Set<Attached<ExtensionDeclSyntax>> = [extensionDecl]

    // Visit next transitive dependency
    while let next = frame.nextDependencyMember(
      graph: self
    ) {
      // Skip if `nil` (i.e., when we just finished a descent and we had to call `frame.advance`)
      guard let (newIndex, dependency, memberID, isFirstDecl, memberDecl) = next else { continue }

      // Check if this dependency introduces a cycle
      if isFirstDecl,  // Check only once per member (not every decl)
        extendedTypeName == dependency.baseTypeName,
        extensionMembers.typeMembersToDecls[memberID] != nil
      {
        // Map to the debug-friendly `ExtensionCycle` type
        return frame.toCycle(graph: self)
      }

      // Then, find transitive dependencies
      guard
        // Nominal-type declarations don't introduce dependencies (though,
        // their enclosing extensions might)
        let dependencyExtension = memberDecl?.introducingExtensionOrMainDecl,
        // Stop if we already have a cycle
        visitedExtensions.insert(dependencyExtension).inserted
      else {
        // No transitive dependencies; just advance
        frame.advance(newIndex: newIndex)
        continue
      }
      guard let dependencyState = extensionsToState[dependencyExtension] else {
        fatalError("\(GraphFailure.staleDependency)")
      }
      // Skip if it has no dependencies
      guard !dependencyState.dependencies.isEmpty else {
        frame.advance(newIndex: newIndex)
        continue
      }

      // Push transitively depended-on extension
      // We can assign `(0,0,0)` because we just checked `!dependencies.isEmpty`
      frame.push(dependencyExtension, index: (0, 0, 0))
    }

    return nil
  }
}

// MARK: Array Helpers

extension Array {
  /// Similar to dictionary's `subscript(_:default:)`.
  ///
  /// Only use for small array's and/or when it's important to maintain insertion order.
  fileprivate subscript<Key: Equatable, Value>(
    _key key: Key,
    default defaultValue: Value
  ) -> Value where Element == (key: Key, value: Value) {
    get {
      first(where: { $0.key == key })?.value ?? defaultValue
    }
    _modify {
      let index: Int
      if let existingIndex = firstIndex(where: { $0.key == key }) {
        index = existingIndex
      } else {
        let newIndex = count
        append((key, defaultValue))
        index = newIndex
      }

      yield &self[index].value
    }
  }
}

// MARK: Stubs

extension TypeGraph {
  enum TypeAdmissionFailure: Error {
    /// We don't allow admitting redeclarations. The type resolver should diagnose
    /// redeclarations and not request admitting them to the graph.
    case cannotAdmitRedeclaration
  }
  enum NestedTypeAdmissionFailure: Error {
    case other(TypeAdmissionFailure)

    /// The given decl group syntax unexpectedly isn't registered to the given
    /// base type reference.
    case invalidBaseDeclGroup
    /// The given `baseDeclGroup` must be admitted and match the given `baseType`.
    case invalidBaseType
  }
  enum NominalTypeRefUpdateFailure: Error {
    /// This type is no longer in the symbol table
    case removed
  }
  enum QualifiedTypeLookupFailure: Error {
    /// References non-registered base type
    case invalidBase
    case unregisteredFileRoot(SourceFileSyntax)
  }
}

// MARK: Test Hooks

extension TypeGraph {
  /// Creates a mock graph without checking for invariants; only use for tests.
  @_spi(_QualifiedLookupTests)
  public init(
    _uncheckedNamesToTypes namesToTypes: [TypeGraph.GlobalTypeName: NominalType] = [:],
    extensionsToState: [Attached<ExtensionDeclSyntax>: ExtensionState] = [:]
  ) {
    self.namesToTypes = namesToTypes
    self.extensionsToState = extensionsToState
  }
}

extension TypeGraph.NominalType {
  /// Creates a mock nominal type without checking for invariants; only use
  /// for tests.
  ///
  /// Note: Type tables ignore `#if` configurations.
  @_spi(_QualifiedLookupTests)
  public init(
    _uncheckedMainDecl mainDecl: Attached<NominalTypeDeclSyntax>,
    boundExtensions: [ModuleName: [Attached<ExtensionDeclSyntax>]] = [:],
    dependents: [(memberType: Identifier, dependentExtension: Attached<ExtensionDeclSyntax>)] = []
  ) {
    self.mainDecl = mainDecl
    self.mainDeclMembers = TypeGraph.TypeTable(typeMembersToDecls: mainDecl._groupTypeMembers(configuredRegions: nil))
    self.boundExtensions = boundExtensions.mapValues({ extensions in
      Dictionary(
        uniqueKeysWithValues: extensions.map({
          ($0, TypeGraph.TypeTable(typeMembersToDecls: $0._groupTypeMembers(configuredRegions: nil)))
        })
      )
    })
    self.dependents = dependents.map({
      TypeGraph.TypeDependent(memberType: $0.memberType, dependentExtension: $0.dependentExtension)
    })
  }
}

// MARK: Tests

@_spi(_QualifiedLookupTests)
extension TypeGraph.ExtensionDependency: CustomDebugStringConvertible {
  private func _describe(includeMemberDecls: Bool) -> String {
    let membersDescriptions = members.map({ member in
      let declDescriptions = member.decls.map({
        "`\($0.introducingExtensionOrMainDecl?._memberlessDescription ?? "nil")`"
      })
      let declDescription = " [in \(declDescriptions.isEmpty ? "<none>" : declDescriptions.joined(separator: ", "))]"
      return "'\(member.name.name)'\(includeMemberDecls ? declDescription : "")"
    }).joined(separator: ", ")
    return
      "ExtensionDependency(dependencyTypeName: '\(baseTypeName.debugDescription)', members: [\(membersDescriptions)])"
  }

  /// Debug description but removes the `TypeDeclSyntax` from each `Member` for easier testing.
  fileprivate var _declarationlessDescription: String {
    _describe(includeMemberDecls: false)
  }

  public var debugDescription: String {
    _describe(includeMemberDecls: true)
  }
}

@_spi(_QualifiedLookupTests)
extension TypeGraph.ExtensionState: CustomDebugStringConvertible {
  public var debugDescription: String {
    let dependenciesDescriptions = dependencies.map(\._declarationlessDescription).joined(separator: ",\n    ")
    // We don't use `String/replacing(_:with:)` because it's unavailable during
    // the compiler's bootstrapping step.
    let indentedTypeDescription = String(resolvedType._debugDescription.flatMap({ $0 == "\n" ? "\n  " : String($0) }))
    return """
      GenericExtensionState(
        dependencies: [
          \(dependenciesDescriptions)
        ],
        resolvedType: \(indentedTypeDescription)
      )
      """
  }
}
extension TypeGraph.ExtensionState {
  @_spi(_QualifiedLookupTests)
  public func _visitTypes(
    visitResolved: (TypeGraph.TypeRef) -> Void,
    visitName: (TypeGraph.GlobalTypeName) -> Void
  ) {
    for dependency in dependencies {
      visitName(dependency.baseTypeName)
    }
    switch resolvedType {
    case .success(let name):
      visitName(name)
    case .failure(let failure):
      failure._visitNominals(visitResolved)
    }
  }
}
