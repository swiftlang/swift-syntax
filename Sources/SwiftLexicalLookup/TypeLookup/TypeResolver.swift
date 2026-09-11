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

/// Finds the main declaration and qualified name of the nominal types
/// to which the the given type syntax refers.
@_spi(_QualifiedLookupTests)
public struct TypeResolver {
  var logPrefix = [String]()

  fileprivate mutating func withLogging<T>(
    request: String,
    describe: (T) -> String,
    perform action: (_ mutableSelf: inout TypeResolver) -> T,
    file: StaticString = #file,
    line: UInt = #line
  ) -> T {
    if let nestingLimit = self._logNestingLimit, logPrefix.count >= nestingLimit {
      fatalError(
        "Exceeded log nesting limit of \(nestingLimit), suggesting there's an infinite loop. If you think this is a mistake, you may change the limit in `TypeQualifier`."
      )
    }
    logPrefix.append(request)
    symbolTable.log("Resolving...", file: file, line: line)
    let result = action(&self)
    symbolTable.log("Resolved \(describe(result))", file: file, line: line)
    logPrefix.removeLast()
    return result
  }

  let symbolTable: SymbolTable

  /// The ordered type syntax we visited; only access through
  /// `insertVisitedTypeSyntax` and `removeVisitedTypeSyntax`.
  private var _visitedTypeSyntax: [Attached<TypeSyntax>] = []
  /// The set of type syntax we visited; only access through
  /// `insertVisitedTypeSyntax` and `removeVisitedTypeSyntax`.
  private var _visitedTypeSyntaxToIndex: [Attached<TypeSyntax>: Int] = [:]
  private(set) var dependencyTracker: DependencyTracker = DependencyTracker()

  /// The number of `withLogging` calls we can nest. Useful for debugging infinite loops
  /// that otherwise fill up standard output and become illegible.
  let _logNestingLimit: Int?
  let _checkNominalInCompositionIsClassOrProtocol = true

  public init(symbolTable: SymbolTable, _logNestingLimit: Int? = nil) {
    self.symbolTable = symbolTable
    self._logNestingLimit = _logNestingLimit
  }

  /// Gets the module of an an attached node. Assumes the file is registered;
  /// traps otherwise.
  func extractFileInfo<S: SyntaxProtocol>(syntax: Attached<S>) -> FileInfo {
    guard let fileInfo = symbolTable.getFileInfo(syntax.fileRoot) else {
      // Should be checked upon entrance in `resolveSyntax`
      fatalError("[SwiftLexicalLookup] Internal error: Unexpectedly found unregistered file: ```\(syntax.fileRoot)```")
    }
    return fileInfo
  }
}

// MARK: Visited Syntax

extension TypeResolver {
  /// Marks the type syntax as visited, or returns the already-visited type syntax
  /// if there's a cycle. Make sure to add a matching `removeVisitedTypeSyntax`.
  private mutating func pushTypeSyntax(_ typeSyntax: Attached<TypeSyntax>) -> [TypeSyntax]? {
    // If we've already seen this syntax, there's a cycle so return it
    if let existingIndex = _visitedTypeSyntaxToIndex[typeSyntax] {
      // We might have valid references before the actual cycle; chop those off
      // to isolate the cycle.
      //
      // E.g.:
      //   typealias A = B
      //   typealias B = A
      //   func f(_: A) // <- Lookup here
      // Starting from `A`, `visitedTypeSyntax` would be:
      //   [
      //     A // from f(_: A),
      //     B // from typealias A = B
      //     A // from typealias B = A
      //   ]
      // And we isolate to the cycle [B, A]
      return _visitedTypeSyntax[existingIndex...].map(\.node)
    }
    // Add this syntax to the hash map and the array
    _visitedTypeSyntaxToIndex[typeSyntax] = _visitedTypeSyntax.count
    _visitedTypeSyntax.append(typeSyntax)
    return nil
  }
  private mutating func popVisitedTypeSyntax(
    _ typeSyntax: Attached<TypeSyntax>,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    let expectedIndex = _visitedTypeSyntax.count - 1
    // Get the syntax's index, or trap
    guard _visitedTypeSyntaxToIndex[typeSyntax] == expectedIndex else {
      fatalError(
        "[SwiftLexicalLookup] Internal error: Unexpectedly asked to remove non-visited/non-last `\(typeSyntax.debugDescription)` with visited \(_visitedTypeSyntax).",
        file: file,
        line: line
      )
    }
    // Remove
    _visitedTypeSyntax.remove(at: expectedIndex)
    _visitedTypeSyntaxToIndex[typeSyntax] = nil
  }
}

// MARK: Disambiguation

extension TypeResolver {
  /// Disambiguate the given declarations. This allows for custom shadowing/member-visibility handlers.
  fileprivate func disambiguateResults<T>(results: [T], declOfResult: (T) -> TypeDeclSyntax, callsite: Syntax) -> [T] {
    // TODO: Filter out according to access control, and by shadowing in external top-level types
    results
  }
}

// MARK: Type Syntax

extension TypeResolver {
  public mutating func resolve(
    typeSyntax: Attached<TypeSyntax>
  ) -> TypeResult {
    withLogging(
      request: "Resolve syntax `\(typeSyntax.trimmedDescription)`",
      describe: \.debugDescription,
      perform: { $0._resolve(typeSyntax: typeSyntax) }
    )
  }

  /// Implements `resolve`
  fileprivate mutating func _resolve(
    typeSyntax: Attached<TypeSyntax>
  ) -> TypeResult {
    // Ensure we're not forming a cycle
    if let cycle = pushTypeSyntax(typeSyntax) {
      return .failure(Failure.cyclicalTypeReference(cycle: cycle))
    }
    // Append this type syntax
    defer { popVisitedTypeSyntax(typeSyntax) }

    // We assert the file root is registered in the symbol table.
    guard let fileInfo = symbolTable.getFileInfo(typeSyntax.fileRoot) else {
      return .failure(Failure.syntaxNotInSymbolTable(typeSyntax.fileRoot))
    }
    // Further, ensure the given syntax is active.
    guard fileInfo.configuredRegions.isActive(typeSyntax.node) == .active else {
      return .failure(Failure.syntaxInDisabledRegion)
    }

    // Partially resolve the type and handle each case accordingly
    let partialType: Result<PartiallyResolvedType, PartialTypeResolutionFailure> = typeSyntax.partiallyResolve()
    switch partialType {
    case .success(.anyType):
      return TypeResult.anyType
    case .success(.tuple(let labels)):
      return .tuple(labels: labels)
    case .success(.typeIdentifier(let component)):
      return resolveUnqualifiedReference(typeComponent: component)
    case .success(.metatype(let baseTypeSyntax)):
      let baseTypeResult = resolve(typeSyntax: baseTypeSyntax)
      // Wrap the base type/failure and return
      switch baseTypeResult {
      case .failure(let baseFailure):
        return .failure(Failure.nested(.invalidBaseType(baseFailure)))
      default:
        return TypeResult.metatype(base: baseTypeResult)
      }
    case .success(.member(let baseTypeSyntax, let memberComponent)):
      let baseTypeResult = resolve(typeSyntax: baseTypeSyntax)
      return resolveMember(baseType: baseTypeResult, typeMember: memberComponent)
    case .success(.composition(let childTypes)):
      var syntaxToTypes = [
        (
          childSyntax: Attached<TypeSyntax>,
          childResult: TypeResult
        )
      ]()
      for childTypeSyntax in childTypes {
        let childResult = resolve(typeSyntax: childTypeSyntax)
        syntaxToTypes.append((childTypeSyntax, childResult))
      }
      return reduceComposition(syntaxToTypes)
    case .failure(let failure):
      return .failure(Failure.partialTypeResolutionFailure(failure))
    }
  }

  /// Combines the given types into one type result.
  func reduceComposition(
    _ syntaxToTypes: [(
      childSyntax: Attached<TypeSyntax>,
      childResult: TypeResult
    )]
  ) -> TypeResult {
    // Collect valid types and failures
    var anyTypeCounter = 0
    var types = [ResolvedTypeSyntax]()
    var failures = [(TypeSyntax, Failure)]()
    for (childTypeSyntax, childTypeResult) in syntaxToTypes {
      switch childTypeResult {
      // Only nominals are valid in compositions
      case .nominalTypes(let nominals):
        if _checkNominalInCompositionIsClassOrProtocol {
          switch (nominals.count, nominals.first?.type.mainDecl.kind) {
          // If we have one nominal, check it's a protocol or class.
          // If we have multiple, i.e., a composition, we've already  checked it recursively.
          case (1, .protocolDecl), (1, .classDecl), (2..., _):
            break
          // If we have no nominals, e.g., `Int.Type`, or a single nominal that's not
          // a struct/enum/actor, we throw an error
          default:
            failures.append(
              (
                childSyntax: childTypeSyntax.node,
                childFailure: Failure.cannotComposeNonClassOrProtocol(resolved: childTypeResult)
              )
            )
          }
        }
        // Append types we don't already have
        for nominal in nominals {
          // This search takes linear time but we don't expect compositions to
          // reference a large number of nominal types.
          guard !types.contains(where: { $0.type.mainDecl == nominal.type.mainDecl }) else {
            continue
          }
          types.append(nominal)
        }
      // Tuples/function/metatypes
      case .function, .tuple, .metatype:
        failures.append(
          (
            childSyntax: childTypeSyntax.node,
            childFailure: Failure.cannotComposeNonClassOrProtocol(
              resolved: childTypeResult
            )
          )
        )
      // `Any` doesn't contribute any types but IS valid
      // E.g. `Codable & Any` ✅
      // But: `Codable & Int.Type` ❌
      case .anyType:
        anyTypeCounter += 1
      // Ignore if this particular type didn't contain the type member.
      // E.g.
      //   protocol A { typealias T = Int }
      //   protocol B {}
      //   let ab: (A & B).T // ✅
      case .failure(Failure.noTypeMember):
        continue
      case .failure(let resolutionFailure):
        failures.append(
          (
            childSyntax: childTypeSyntax.node,
            childFailure: resolutionFailure
          )
        )
      }
    }

    // Stop even if we only have one failure
    guard failures.isEmpty else {
      return .failure(Failure.nested(.invalidComposition(failures)))
    }

    // We get `anyType` only when all the child types are `any`,
    // and have at least one children.
    //
    // We need to check we have more than one children because,
    // for instance, `Int.Type` returns an empty array which
    // doesn't equal the `Any` type.
    if anyTypeCounter > 0, anyTypeCounter == syntaxToTypes.count {
      return TypeResult.anyType
    }

    return TypeResult.nominalTypes(types)
  }
}

// MARK: Unqualified References

extension TypeResolver {
  /// Resolves the given type reference (an optional module selector +
  /// the type-name identifier) by performing unqualified lookup.
  ///
  /// E.g. The syntax `A & MyModule::B` will issue two `resolveUnqualifiedReference`
  /// calls: one for `A` and one for `MyModule::B`. Type members are handled
  /// in other functions.
  ///
  /// Notes:
  /// 1. We don't resolve generic parameters.
  /// 2. To resolve a type, we have to know its declaration context, e.g.:
  ///   ```swift
  ///   extension String.UTF8View { <- (3) Resolve
  ///     struct A { // <- (2) Resolve
  ///       struct B {} // <- (1) Look up here
  ///     }
  ///   }
  ///   ```
  fileprivate mutating func resolveUnqualifiedReference(
    typeComponent: TypeReference
  ) -> TypeResult {
    return withLogging(
      request: "Type reference `\(typeComponent.debugDescription)`",
      describe: \.debugDescription,
      perform: { $0._resolveUnqualifiedReference(typeComponent: typeComponent) }
    )
  }

  enum DeclContext {
    case declGroup(Attached<DeclGroupSyntaxType>)
    case codeBlock(Attached<CodeBlockItemListSyntax>)

    fileprivate var syntax: Syntax {
      switch self {
      case .declGroup(let syntax):
        return Syntax(syntax.node)
      case .codeBlock(let syntax):
        return Syntax(syntax.node)
      }
    }
  }
  func _describeDeclContext(_ declContext: DeclContext) -> String {
    switch declContext {
    case .declGroup(let declGroup):
      return declGroup._memberlessDescription
    case .codeBlock(let codeBlock):
      // Get the file scope (global)
      guard let sourceFileScope = codeBlock.parent?.as(SourceFileSyntax.self) else {
        // Get the scope description (local)
        return codeBlock.node._prettyScope.prettyDescription
      }
      return extractFileInfo(syntax: sourceFileScope).name
    }
  }

  /// Performs top-level unqualified lookup for types, optionally
  /// just in an external module.
  ///
  /// Note: `moduleSelector` can be set to the internal module.
  func findTopLevelTypes(
    originatingFile: SourceFileSyntax,
    moduleSelector: Identifier?,
    name: Identifier
  ) -> [Attached<TypeDeclSyntax>] {
    // TODO: Implement
    []
  }

  /// Implements `resolveUnqualifiedReference`
  fileprivate mutating func _resolveUnqualifiedReference(
    typeComponent: TypeReference
  ) -> TypeResult {
    /// Get the results for this file
    let fileResults: [UnqualifiedTypeLookupResult]
    ///
    /// If fileResults is empty, specifies the module to search in.
    /// The module is `nil` if we should perform regular lookup or
    /// specified if we want to search in a particular external module.
    let topLevelModuleLookup: ModuleName?
    if let module = typeComponent.module {
      // Top-level means that we look for declarations at the file scope of an
      // external module. For instance:
      //   // MyModule>MyFile.swift
      //   extension Int {
      //     func f() { MyModule::f() } // ❌ Member `f` not imported through `MyModule`
      //   }
      fileResults = []
      topLevelModuleLookup = module
    } else {
      // Scoped unqualified lookup in this module
      fileResults = typeComponent.introducingSyntax.findUnqualifiedType(
        typeComponent.name,
        configuredRegions: extractFileInfo(syntax: typeComponent.introducingSyntax).configuredRegions
      )
      // Perform
      topLevelModuleLookup = nil
    }

    symbolTable.log("Lookup results: \(fileResults.map(\.debugDescription))")

    // === File Lookup ===
    //
    // Find first matching type declaration in file
    for lookupResult: UnqualifiedTypeLookupResult in fileResults {
      // The enclosing type, and whether to look for the selected member.
      //
      // `lookForSelectedMember` is false if we can return the enclosing type
      // itself; true if we need to perform qualified lookup and return a type
      // member.
      let enclosingType: TypeResult
      let lookForSelectedMember: Bool

      logPrefix.append("Trying \(lookupResult._describeSuccinctly(lookedUpName: typeComponent.name))")
      defer { logPrefix.removeLast() }

      switch lookupResult {
      case .nonNestedTypeDecl(let typeDecl, redeclarations: _, let parentCodeBlock):
        enclosingType = resolveTypeDecl(
          typeDecl: typeDecl,
          declContext: DeclContext.codeBlock(parentCodeBlock),
          originatingSyntax: Attached<TypeLikeSyntax>(typeComponent.introducingSyntax)
        )
        lookForSelectedMember = false
      case .lookForMember(let declGroupParent, let lookForSelf):
        // We might have to look inside an extension
        // For instance:
        //   extension Int {
        //     struct A {
        //       typealias B = String
        //     }
        //   }
        //   extension Int {
        //     func f(_: A.B) {} // Look up `A.B` here
        //   }
        // To find `A.B`, we first need to perform unqualified type lookup to find the base `A`
        // and then look for the member chain `.B`.
        // One of the lookup results will be to look for `A` in `extension Int`.
        // The enclosing type is `Swift::Int.(MyFile.swift)::A`. Then, to find `A.B` we'll
        // just append `.A` to the member chain. Hence, we look for `.A.B` in `Swift::Int`
        let declGroupResult: Result<ResolvedTypeSyntax, Failure> = resolveDeclGroup(
          declGroup: declGroupParent,
          originatingSyntax: Attached<TypeLikeSyntax>(typeComponent.introducingSyntax)
        )
        // Set the enclosing type
        switch declGroupResult {
        case .success(let nominalType):
          enclosingType = .nominalTypes([nominalType])
        case .failure(let failure):
          enclosingType = .failure(failure)
        }
        // To find the member
        lookForSelectedMember = !lookForSelf

      case .genericParameters(let firstMatch, let redeclarations, genericClause: _):
        guard redeclarations.isEmpty else {
          return .failure(
            .ambiguousTypeDecl([TypeDeclSyntax(firstMatch.node)] + redeclarations.map({ TypeDeclSyntax.init($0.node) }))
          )
        }
        return .failure(.genericParameterOrAssociatedType)

      case .lookForGenericParameters(let extensionDecl):
        // Resolve extended type
        let baseType: GloballyResolvedTypeSyntax
        switch symbolTable.bindExtension(extensionDecl) {
        case .success(let type):
          baseType = type
        case .failure(let failure):
          return .failure(Failure.nested(.invalidBaseType(failure)))
        }

        // Get the matching generic parameters
        let matchingGenericParameters = baseType.type.mainDecl.node.findGenericParameters(
          withName: typeComponent.name
        )
        // If the result is empty, continue
        guard let matchingGenericParameter = matchingGenericParameters.first else { continue }
        // Diagnose ambiguities
        guard matchingGenericParameters.count <= 1 else {
          return .failure(
            .ambiguousTypeDecl(matchingGenericParameters.map(TypeDeclSyntax.init(_:)))
          )
        }

        symbolTable.log("Found generic parameter `\(matchingGenericParameter.trimmedDescription)`")

        // We don't resolve generic parameters (same as ``resolveTypeDecl``).
        enclosingType = .failure(.genericParameterOrAssociatedType)
        lookForSelectedMember = false
      }

      // Continue to next scope if unqualified lookup didn't find the
      // (enclosing/not) type in this scope
      if case .failure(.noTypeInScope) = enclosingType { continue }

      // If we don't have to look for a member, return the type
      if !lookForSelectedMember { return enclosingType }

      // Look for the member
      let memberType: TypeResult = resolveMember(
        baseType: enclosingType,
        typeMember: typeComponent
      )

      // Skip if we got `.noTypeMember`
      //
      // Note: `resolveMember` wraps the underlying error in ``Failure.invalidMembers``
      if case .failure(.noTypeMember) = memberType {
        // Continue like above
        continue
      }

      return memberType
    }

    // === Top-Level Lookup ===
    let topLevelTypes: [Attached<TypeDeclSyntax>] = findTopLevelTypes(
      originatingFile: typeComponent.introducingSyntax.fileRoot,
      moduleSelector: topLevelModuleLookup,
      name: typeComponent.name
    )
    let diambiguatedTopLevelTypes = disambiguateResults(
      results: topLevelTypes,
      declOfResult: \.node,
      callsite: Syntax(typeComponent.introducingSyntax.node)
    )
    guard let topLevelType = diambiguatedTopLevelTypes.first else {
      // No type matched
      return .failure(Failure.noTypeInScope)
    }
    guard diambiguatedTopLevelTypes.count == 1 else {
      return .failure(Failure.ambiguousTypeDecl(diambiguatedTopLevelTypes.map(\.node)))
    }
    symbolTable.log("Found top-level type `\(topLevelType._memberlessDescription)`")
    return resolveTypeDecl(
      typeDecl: topLevelType,
      declContext: DeclContext.codeBlock(topLevelType.fileRootStatements),
      originatingSyntax: Attached<TypeLikeSyntax>(typeComponent.introducingSyntax)
    )
  }

  fileprivate mutating func resolveDeclGroup(
    declGroup: Attached<DeclGroupSyntaxType>,
    originatingSyntax: Attached<TypeLikeSyntax>
  ) -> Result<ResolvedTypeSyntax, Failure> {
    withLogging(
      request: "Decl group `\(declGroup._memberlessDescription)`",
      describe: \._debugDescription,
      perform: { $0._resolveDeclGroup(declGroup: declGroup, originatingSyntax: originatingSyntax) }
    )
  }

  /// Helper for `resolveDeclGroup`
  fileprivate func _findDeclContext(ofDeclGroup node: Attached<DeclGroupSyntaxType>) -> DeclContext {
    var currentAncestor: Attached<Syntax>? = node.parent
    while let ancestor = currentAncestor {
      if let codeBlockScope = ancestor.as(CodeBlockItemListSyntax.self),
        // `#if` aren't true scopes
        codeBlockScope.parent?.is(IfConfigClauseSyntax.self) != true
      {
        return DeclContext.codeBlock(codeBlockScope)
      } else if let declGroupScope = ancestor.as(DeclGroupSyntaxType.self) {
        return DeclContext.declGroup(declGroupScope)
      } else {
        currentAncestor = ancestor.parent
      }
    }
    // Shouldn't happen because `Attached<DeclGroupSyntaxType>` has
    // a `SourceFileSyntax` root that we should have run into.
    fatalError(
      "[SwiftLexicalLookup] Internal error: Unexpectedly didn't find declaration context of attached decl group `\(node._memberlessDescription)`."
    )
  }

  fileprivate mutating func _resolveDeclGroup(
    declGroup: Attached<DeclGroupSyntaxType>,
    originatingSyntax: Attached<TypeLikeSyntax>
  ) -> Result<ResolvedTypeSyntax, Failure> {
    let declContext: DeclContext = _findDeclContext(ofDeclGroup: declGroup)

    symbolTable.log(
      "Found decl context `\(_describeDeclContext(declContext))` containing `\(declGroup._memberlessDescription)`"
    )

    if let nominalTypeDecl = declGroup.as(NominalTypeDeclSyntax.self) {
      return resolveNominalTypeDecl(
        nominalDecl: nominalTypeDecl,
        declContext: declContext,
        originatingSyntax: originatingSyntax
      )

    } else if let extensionDecl = declGroup.as(ExtensionDeclSyntax.self) {
      guard
        case .codeBlock(let fileStatements) = declContext,
        fileStatements.node == extensionDecl.fileRoot.statements
      else {
        return .failure(Failure.extensionNotAtFileScope(extensionDecl: extensionDecl.node))
      }
      // Wrap the global reference
      return symbolTable.bindExtension(extensionDecl).map(ResolvedTypeSyntax.init(global:))
    } else {
      fatalError(
        "[SwiftLexicalLookup] Internal error: Expected decl group to be either a nominal type or extension decl; instead found \(declGroup.kind)."
      )
    }
  }

  /// Resolves the nominal-type declaration in the given declaration context.
  fileprivate mutating func resolveNominalTypeDecl(
    nominalDecl: Attached<NominalTypeDeclSyntax>,
    declContext: DeclContext,
    originatingSyntax: Attached<TypeLikeSyntax>
  ) -> Result<ResolvedTypeSyntax, Failure> {
    withLogging(
      request: "Nominal `\(nominalDecl._memberlessDescription)`",
      describe: \._debugDescription,
      perform: {
        $0._resolveNominalTypeDecl(
          nominalDecl: nominalDecl,
          declContext: declContext,
          originatingSyntax: originatingSyntax
        )
      }
    )
  }

  /// Finds the member type-decl of a nominal base type.
  ///
  /// A helper for `resolveNominalTypeDecl` and `resolveMember`.
  fileprivate mutating func findNominalTypeMemberDecl(
    resolvedNominalBaseType: TypeGraph.TypeRef,
    memberName: Identifier,
    memberIntroducingSyntax: Attached<TypeLikeSyntax>
  ) -> Result<(declGroupParent: Attached<DeclGroupSyntaxType>, typeDecl: Attached<TypeDeclSyntax>)?, Failure> {
    // Perform direct type lookup and mark dependency
    //
    // First, get the module
    let introducingModule = extractFileInfo(syntax: memberIntroducingSyntax).module
    // Look up
    let memberTypeDeclsResult:
      Result<
        [(declGroupParent: Attached<DeclGroupSyntaxType>, typeDecl: Attached<TypeDeclSyntax>)],
        TypeGraph.QualifiedTypeLookupFailure
      > =
        symbolTable.findMemberType(
          baseType: resolvedNominalBaseType,
          memberTypeName: memberName,
          introducingTypeSyntax: memberIntroducingSyntax,
          introducingModule: introducingModule,
          dependencyTracker: &dependencyTracker
        )

    // Handle failures
    let memberTypeDecls: [(declGroupParent: Attached<DeclGroupSyntaxType>, typeDecl: Attached<TypeDeclSyntax>)]
    switch memberTypeDeclsResult {
    case .success(let success):
      memberTypeDecls = success
    case .failure(.unregisteredFileRoot):
      // We check that the root is a source file in the symbol table
      // at the top of ``resolveSyntax``.
      fatalError(
        "[SwiftLexicalLookup] Internal error: Unexpectedly asked to resolve a type declaration whose root isn't a file or a file not registered in the symbol table."
      )
    case .failure(.invalidBase):
      fatalError(
        "[SwiftLexicalLookup] Internal error: Base type \(resolvedNominalBaseType) was unexpectedly invalid."
      )
    }

    // Process the results
    // 1. Disambiguate so we don't give false positive .ambiguousTypeDecl
    let disambiguatedTypeDecls = disambiguateResults(
      results: memberTypeDecls,
      declOfResult: \.typeDecl.node,
      callsite: Syntax(memberIntroducingSyntax.node)
    )
    // 2. Return `nil` if no such declaration exists.
    guard let firstTypeDecl = disambiguatedTypeDecls.first else {
      return Result.success(nil)
    }
    // 3. Cannot have multiple type declarations named the same.
    //    E.g.
    //    struct A {
    //      typealias B = Int
    //      typealias B = Bool
    //      let b: B // ❌ ambiguous
    //    }
    guard disambiguatedTypeDecls.count == 1 else {
      return Result.failure(
        Failure.ambiguousTypeDecl(disambiguatedTypeDecls.map(\.typeDecl).map(\.node))
      )
    }
    // There's just one member; return that
    return Result.success(firstTypeDecl)
  }

  /// Implements `resolveNominalTypeDecl`
  fileprivate mutating func _resolveNominalTypeDecl(
    nominalDecl: Attached<NominalTypeDeclSyntax>,
    declContext: DeclContext,
    originatingSyntax: Attached<TypeLikeSyntax>
  ) -> Result<ResolvedTypeSyntax, Failure> {
    assert(
      declContext.syntax.range.contains(nominalDecl.node.range),
      "[SwiftLexicalLookup] Internal error: Decl context doesn't contain declaration."
    )

    guard let declName = Identifier(validating: nominalDecl.node.name) else {
      return .failure(Failure.invalidNameToken(nominalDecl.node.name))
    }

    // Extract file info
    let declFile = nominalDecl.fileRoot
    let declFileInfo = extractFileInfo(syntax: nominalDecl)

    switch declContext {
    case .codeBlock(let codeBlockScope):
      let isGlobal: Bool = codeBlockScope.node == declFile.statements

      // Gather type decls with the same name
      var scopeTypeDecls = [TypeDeclSyntax]()
      codeBlockScope.node._visitDirectMembers(
        configuredRegions: extractFileInfo(syntax: codeBlockScope).configuredRegions,
        visit: { valueDecl in
          guard
            let typeDecl = valueDecl.as(TypeDeclSyntax.self),
            typeDecl.name.identifier == declName
          else {
            return
          }
          scopeTypeDecls.append(typeDecl)
        }
      )
      // If we're at top-level, consider other internal declarations
      //
      // We don't need to check external declarations because internal
      // declarations shadow external declarations.
      if isGlobal {
        let topLevelTypes = findTopLevelTypes(
          originatingFile: codeBlockScope.fileRoot,
          moduleSelector: declFileInfo.module,
          name: declName
        )
        scopeTypeDecls.append(contentsOf: topLevelTypes.map(\.node))
      }

      // Diagnose redeclarations

      let disambiguatedTypeDecls = disambiguateResults(

        results: scopeTypeDecls,
        declOfResult: \.self,
        callsite: Syntax(nominalDecl.node)
      )

      guard disambiguatedTypeDecls == [TypeDeclSyntax(nominalDecl.node)] else {
        // Results are already sorted from lookup
        return .failure(Failure.ambiguousTypeDecl(scopeTypeDecls))
      }

      // Register the type
      let resolvedReferenceResult =
        symbolTable.registerNominalType(
          topScopeMainDecl: nominalDecl,
          declName: declName,
          declFileInfo: declFileInfo,
          isGlobal: isGlobal,
          originatingSyntax: originatingSyntax
        ) as Result<ResolvedTypeSyntax, TypeGraph.NominalRegistrationFailure>

      // Extract reference, or trap
      let resolvedReference: ResolvedTypeSyntax
      switch resolvedReferenceResult {
      case .success(let success):
        resolvedReference = success
      case .failure(let registrationFailure):
        switch registrationFailure {
        // Reasoning: We just checked for redeclarations
        case .cannotRegisterRedeclaration:
          fatalError(
            "[SwiftLexicalLookup] Internal error: While registering top-scope `\(nominalDecl._memberlessDescription)`: \(registrationFailure)"
          )
        }
      }

      return .success(resolvedReference)
    case .declGroup(let declGroupParent):
      // Find the base type
      let baseResult: Result<ResolvedTypeSyntax, Failure> = resolveDeclGroup(
        declGroup: declGroupParent,
        originatingSyntax: originatingSyntax
      )
      // Extract the type, or throw
      let baseType: ResolvedTypeSyntax
      switch baseResult {
      case .success(let success):
        baseType = success
      case .failure(let failure):
        return .failure(Failure.nested(.invalidBaseType(failure)))
      }

      // Find this nominal declaration through qualified lookup
      let resolvedBase: ResolvedTypeSyntax
      switch resolveType(typeReference: baseType) {
      case .success(let success):
        resolvedBase = success
      case .failure(let failure):
        return .failure(Failure.nested(.invalidBaseType(failure)))
      }
      let memberResult:
        Result<(declGroupParent: Attached<DeclGroupSyntaxType>, typeDecl: Attached<TypeDeclSyntax>)?, Failure>
      do {
        // Don't track dependencies (only extensions track dependencies)
        let dependencyTracker = self.dependencyTracker
        self.dependencyTracker = DependencyTracker()
        defer { self.dependencyTracker = dependencyTracker }

        memberResult = findNominalTypeMemberDecl(
          resolvedNominalBaseType: resolvedBase.type,
          memberName: declName,
          memberIntroducingSyntax: Attached<TypeLikeSyntax>(nominalDecl),
        )
      }

      // Ensure we exist under the right decl group and there are no duplicates
      switch memberResult {
      case .success((declGroupParent, Attached<TypeDeclSyntax>(nominalDecl))?):
        break
      case .success(let unexpectedResult):
        // We should have diagnosed an ambiguity if there was a different
        // nominal decl or we couldn't find a member
        fatalError(
          "[SwiftLexicalLookup] Internal error: Qualified lookup of \(baseType.debugDescription) > '\(declName.name)' unexpectedly returned `\(unexpectedResult.debugDescription)`"
        )
      case .failure(let failure):
        return .failure(failure)
      }

      // Register the type
      let resolvedReferenceResult =
        symbolTable.registerNominalType(
          nestedMainDecl: nominalDecl,
          declName: declName,
          declFileInfo: declFileInfo,
          baseDeclGroup: declGroupParent,
          baseType: baseType,
          originatingSyntax: originatingSyntax
        ) as Result<ResolvedTypeSyntax, TypeGraph.NestedNominalRegistrationFailure>

      // Extract the reference, or trap
      let resolvedReference: ResolvedTypeSyntax
      switch resolvedReferenceResult {
      case .success(let success):
        resolvedReference = success
      case .failure(let registrationFailure):
        switch registrationFailure {
        // Reasoning:
        // .cannotRegisterRedeclaration -> We just checked for redeclarations
        // .baseNotRegistered, .baseDeclGroupUnbound -> We should have a valid base from the recursive step
        case .other(.cannotRegisterRedeclaration), .baseNotRegistered, .baseDeclGroupUnbound:
          fatalError(
            "[ewiftLexicalLookup] Internal error: While registering '\(baseType.debugDescription)' > '\(nominalDecl._memberlessDescription)': \(registrationFailure)"
          )
        }
      }

      return .success(resolvedReference)
    }
  }

  /// Resolve the given type declaration produced by the given `baseTypeDecl`.
  /// This subrequest was initiated by a request to resolve a ``originatingSyntax``.
  ///
  /// This requests explicitly doesn't resolve associated types and generic-parameter
  /// declarations.
  fileprivate mutating func resolveTypeDecl(
    typeDecl: Attached<TypeDeclSyntax>,
    declContext: DeclContext,
    originatingSyntax: Attached<TypeLikeSyntax>
  ) -> TypeResult {
    withLogging(
      request: "Decl \(typeDecl.kind) `\(typeDecl.node.name.trimmedDescription)`",
      describe: \.debugDescription,
      perform: {
        $0._resolveTypeDecl(typeDecl: typeDecl, declContext: declContext, originatingSyntax: originatingSyntax)
      }
    )
  }

  /// Implements `resolveTypeDecl`
  fileprivate mutating func _resolveTypeDecl(
    typeDecl: Attached<TypeDeclSyntax>,
    declContext: DeclContext,
    originatingSyntax: Attached<TypeLikeSyntax>
  ) -> TypeResult {
    assert(
      declContext.syntax.range.contains(typeDecl.node.range),
      "[SwiftLexicalLookup] Internal error: Decl context doesn't contain declaration."
    )

    // We mainly handle nominal types; type aliases are trivially recursive, and we skip
    // associated types and generic parameters
    if let nominalTypeDecl = typeDecl.as(NominalTypeDeclSyntax.self) {
      // Resolve the main nominal-type decl and wrap it in `MemberLookupResult.memberResults`
      let nominalTypeResult: Result<ResolvedTypeSyntax, Failure> = resolveNominalTypeDecl(
        nominalDecl: nominalTypeDecl,
        declContext: declContext,
        originatingSyntax: originatingSyntax
      )
      switch nominalTypeResult {
      case .success(let nominalType):
        return TypeResult.nominalTypes([nominalType])
      case .failure(let failure):
        return TypeResult.failure(failure)
      }
    } else if let typeAlias = typeDecl.as(TypeAliasDeclSyntax.self) {
      let aliasedTypeSyntax = typeAlias.node.initializer.value
      symbolTable.log(
        "Found aliased type `\(aliasedTypeSyntax)`"
      )

      let aliasedResult: TypeResult = resolve(
        typeSyntax: typeAlias.initializerValue
      )
      // Wrap in a failure unless we're part of a cycle
      switch aliasedResult {
      case .failure(let failure):
        // If we're part of the cycle, return the cycle
        if let nestedCycle = failure.nestedCycle, nestedCycle.contains(aliasedTypeSyntax) {
          return .failure(Failure.cyclicalTypeReference(cycle: nestedCycle))
        }
        // Wrapping the failure indicates the type alias itself isn't the
        // problem; the referenced type is the problem (diagnosed separately).
        return .failure(Failure.nested(.invalidAliasedType(failure)))
      case let success:
        return success
      }
    } else { /* else if it's an associated type or generic parameter */
      // No members for generic parameters and associated types
      return .failure(Failure.genericParameterOrAssociatedType)
    }
  }
}

// MARK: Member Lookup

extension TypeResolver {
  /// Resolves the given member reference of the provided, resolved base type,
  /// recording our dependencies on qualified-lookup queries.
  ///
  /// Note: The base type might have redeclarations, in which case we return
  /// the appropriate error.
  fileprivate mutating func resolveMember(
    baseType: TypeResult,
    typeMember: TypeReference
  ) -> TypeResult {
    withLogging(
      request:
        "Member `\(baseType._succinctDescription)` > `\(typeMember.debugDescription)`",
      describe: \.debugDescription,
      perform: { $0._resolveMember(baseType: baseType, typeMember: typeMember) }
    )
  }

  /// Implements `resolveMember`
  fileprivate mutating func _resolveMember(
    baseType: TypeResult,
    typeMember: TypeReference
  ) -> TypeResult {
    // Extract nominal type or composition thereof
    let baseTypes: [ResolvedTypeSyntax]
    switch baseType {
    // Accept nominals (count == 1) or compositions (count > 1).
    //
    // 'Compositions' of count == 0 (e.g. `Int.Type`) have no nominal types
    // and are automatically diagnosed at the end of the function.
    case .nominalTypes(let types):
      baseTypes = types
    case .anyType:
      return TypeResult.failure(.noTypeMember(member: typeMember, in: TypeResult.anyType))
    case .function(let argumentCount):
      return TypeResult.failure(
        .noTypeMember(member: typeMember, in: TypeResult.function(argumentCount: argumentCount))
      )
    case .tuple(let labels):
      return TypeResult.failure(.noTypeMember(member: typeMember, in: TypeResult.tuple(labels: labels)))
    case .metatype(let base):
      return TypeResult.failure(.noTypeMember(member: typeMember, in: TypeResult.metatype(base: base)))
    case .failure(let failure):
      return TypeResult.failure(.nested(NestedFailure.invalidBaseType(failure)))
    }

    // Perform qualified type lookup and mark the dependencies
    //
    // Note: We collect all types and failures.
    //
    // This approach allows the type checker can check if members of
    // compositions actually resolve to the same type. For instance:
    //   protocol A { typealias T = Int }
    //   final class B { typealias T = [String].Index /* i.e. Int */ }
    //   protocol C { typealias T = Int }
    //   typealias ABC = A & B & C
    //   let a: ABC.T // ✅ T resolves to `Int` in both cases
    // Of course, if we change the class' alias to `typealias T = String`,
    // the compiler will complain that `ABC.T` is ambiguous.
    //
    // Also, collecting all failures surfaces all errors at once for better
    // diagnostics.
    var visitedDecls = Set<Attached<TypeDeclSyntax>>()
    var declsAndResults = [(decl: Attached<TypeDeclSyntax>, result: TypeResult)]()
    var failures = [(Attached<TypeLikeSyntax>, Failure)]()
    var nominalBaseTypes = [ResolvedTypeSyntax]()

    for baseType in baseTypes {
      // We'll collect the result, and type syntax
      //
      // We rely on definite initialization to ensure `memberResult` is
      // initialized exactly once, ensuring each member produces exactly one
      // result.
      let memberResult:
        Result<
          (typeDecl: Attached<TypeDeclSyntax>, result: TypeResult)?,
          Failure
        >
      logPrefix.append("Base `\(baseType.debugDescription)`")
      defer {
        logPrefix.removeLast()
        switch memberResult {
        case Result.success(nil):
          // No results; continue in case next one has a result.
          break
        case Result.success((let memberTypeDecl, let memberResult)?):
          // Add if not already added
          guard visitedDecls.insert(memberTypeDecl).inserted else { break }
          declsAndResults.append((memberTypeDecl, memberResult))
        case Result.failure(let failure):
          failures.append((Attached<TypeLikeSyntax>(typeMember.introducingSyntax), failure))
        }
      }

      // Bind extensions and construct a nominal type.
      // We ignore failures since they're from non-matching extensions and diagnosed separately
      let nominalBaseType: ResolvedTypeSyntax
      switch resolveType(typeReference: baseType) {
      case .success(let success):
        nominalBaseType = success
      case .failure(let failure):
        memberResult = Result.failure(failure)
        continue
      }
      nominalBaseTypes.append(nominalBaseType)

      // Get the member decl
      let memberTypeDeclResult = findNominalTypeMemberDecl(
        resolvedNominalBaseType: nominalBaseType.type,
        memberName: typeMember.name,
        memberIntroducingSyntax: Attached<TypeLikeSyntax>(typeMember.introducingSyntax)
      )
      symbolTable.log("Type members matching '\(typeMember.name.name)': \(memberTypeDeclResult._debugDescription)")
      // Collect; skip if it doesn't exist; throw on failure
      let (memberDeclGroupParent, memberTypeDecl): (Attached<DeclGroupSyntaxType>, Attached<TypeDeclSyntax>)
      switch memberTypeDeclResult {
      case .success(let success?):
        (memberDeclGroupParent, memberTypeDecl) = success
      case .success(nil):
        // Skip if no such member exists, e.g.: in `(Encodable & Collection<Int>).Element`,
        // `Encodable` may not have an `Element` type member.
        memberResult = Result.success(nil)
        continue
      case .failure(let failure):
        memberResult = Result.failure(failure)
        continue
      }

      // Resolve this type declaration and add it to the results
      let typeDeclResult: TypeResult = resolveTypeDecl(
        typeDecl: memberTypeDecl,
        declContext: DeclContext.declGroup(memberDeclGroupParent),
        originatingSyntax: Attached<TypeLikeSyntax>(typeMember.introducingSyntax)
      )
      // Surface any failures
      if case .failure(let failure) = typeDeclResult {
        memberResult = .failure(failure)
        continue
      }
      memberResult = .success((typeDecl: memberTypeDecl, result: typeDeclResult))
    }

    // If there are failures, give up.
    //
    // The compiler also gives up. For instance, if we write the following, we
    // only get an error for the alias:
    //   protocol ValidProto { typealias IntAlias = Int }
    //
    //   typealias InvalidAlias = Int.Type.InvalidMember // ❌ No member 'InvalidMember'
    //   typealias Composition = ValidProto & InvalidAlias
    //   let a: Composition.IntAlias = "" // ✅ No errors yet
    // It's only when we use a valid composition that we get an error, e.g.:
    //   typealias Composition = ValidProto & Any
    //   let a: Composition.IntAlias = "" // ❌ Cannot value of type 'String' to specified type 'Int'
    guard failures.isEmpty else {
      return .failure(
        Failure.nested(.invalidMembers(failures.map({ (typeSyntax, failure) in (typeSyntax.node, failure) })))
      )
    }

    // Disambiguate (so we don't erroneously complain about ambiguous declarations)
    let disambiguatedDecls = disambiguateResults(
      results: declsAndResults,
      declOfResult: \.decl.node,
      callsite: Syntax(typeMember.introducingSyntax.node)
    )
    // Diagnose if we get no results
    // E.g. `(Any & Sendable).MyType` yields no results for either `Any.MyType` or
    //   `Sendable.MyType`; hence, `MyType` isn't a member of `Any & Sendable`.
    guard let (_, firstResult) = disambiguatedDecls.first else {
      return .failure(
        Failure.noTypeMember(
          member: typeMember,
          in: TypeResult.nominalTypes(nominalBaseTypes)
        )
      )
    }
    guard disambiguatedDecls.count == 1 else {
      return .failure(Failure.ambiguousTypeDecl(disambiguatedDecls.map(\.decl.node)))
    }

    return firstResult
  }
}

// MARK: Extended-Type Syntax

extension TypeResolver {
  /// Resolve the given type syntax from an extension declaration
  /// to a single nominal type. Should be called on a newly initialized
  /// `TypeResolver` instance.
  ///
  /// Note that we only diagnose extending tuples/functions and compositions
  /// (e.g. `Codable = Encodable & Decodable`). However, we don't diagnose
  /// things like extending an existential (e.g. `extension any Collection`).
  mutating func resolveExtendedTypeSyntax(
    extensionDecl: Attached<ExtensionDeclSyntax>
  ) -> Result<GloballyResolvedTypeSyntax, Failure> {
    withLogging(
      request: "Extended type syntax `\(extensionDecl.extendedType.trimmedDescription)`",
      describe: \._debugDescription,
      perform: { $0._resolveExtendedTypeSyntax(extensionDecl: extensionDecl) }
    )
  }

  /// Implements `resolveExtendedTypeSyntax`
  mutating func _resolveExtendedTypeSyntax(
    extensionDecl: Attached<ExtensionDeclSyntax>
  ) -> Result<GloballyResolvedTypeSyntax, Failure> {
    guard _visitedTypeSyntax.isEmpty else {
      fatalError(
        "[SwiftLexicalLookup] Internal error: Resolve extended type syntax should only be called on a fresh `TypeResolver` instance."
      )
    }

    // Ensure extension is at file scope
    let declContext = _findDeclContext(ofDeclGroup: Attached<DeclGroupSyntaxType>(extensionDecl))
    guard
      case DeclContext.codeBlock(let scope) = declContext,
      scope.node == extensionDecl.fileRoot.statements
    else {
      return .failure(Failure.extensionNotAtFileScope(extensionDecl: extensionDecl.node))
    }

    let resolvedType: TypeResult = resolve(
      typeSyntax: extensionDecl.extendedType
    )

    // Extract a nominal type
    switch resolvedType {
    case .nominalTypes(let results):
      // We're expecting exactly one nominal type.
      // No types means non-nominal, e.g., `Int.Type` and compositions are
      // also not extensible, e.g., `Encodable & Decodable`.
      guard let nominalType = results.first, results.count == 1 else {
        return .failure(Failure.cannotExtendNonNominal(nonnominal: resolvedType))
      }
      // That types needs to be global (can't extended local types)
      let nominalRef = nominalType.type
      guard case .global(let globalNominalRef) = nominalRef else {
        fatalError(
          "[SwiftLexicalLookup] Internal error: Extended type of top-level extension `\(extensionDecl._memberlessDescription)` unexpectedly evaluated to local type `\(nominalRef._succinctDescription)`."
        )
      }
      // Return global reference
      return .success(
        GloballyResolvedTypeSyntax(
          type: globalNominalRef,
          syntax: nominalType.syntax
        )
      )
    // Functions/tuples/`Any`/metatypes aren't nominal
    case .function, .tuple, .anyType, .metatype:
      return .failure(.cannotExtendNonNominal(nonnominal: resolvedType))
    // Forward failures
    case .failure(let failure):
      return .failure(failure)
    }
  }
}

// MARK: Resolve Nominal

extension TypeResolver {
  /// Resolve a qualified-type name to a nominal type with all accessible
  /// extensions bound.
  @_spi(_QualifiedLookupTests)
  mutating func resolveType(
    typeReference: ResolvedTypeSyntax
  ) -> Result<ResolvedTypeSyntax, Failure> {
    withLogging(
      request: "Extended nominal`\(typeReference.debugDescription)`",
      describe: \._debugDescription,
      perform: { $0._resolveType(typeReference: typeReference) }
    )
  }

  /// Implements `resolveNominalType`
  fileprivate mutating func _resolveType(
    typeReference: ResolvedTypeSyntax
  ) -> Result<ResolvedTypeSyntax, Failure> {
    // Skip extension binding for local declarations.
    //
    // For instance, there's no way to extend `A` in `func f() { struct A {} }`
    // since extensions may only be declared at the top level.
    guard case .global(let qualifiedGlobalRef) = typeReference.type else {
      return .success(typeReference)
    }

    symbolTable.admitExtensions(accessibleFrom: typeReference.syntax.fileRoot)

    // After binding all extensions, get the new nominal type
    guard
      case .success(let finalizedNominalRef) = symbolTable.updateNominalTypeReference(
        oldReference: TypeGraph.TypeRef.global(qualifiedGlobalRef)
      )
    else {
      // We checked the nominal type is registered at the start.
      fatalError(
        "[SwiftLexicalLookup] Internal error: Nominal type unexpectedly removed from symbol table after binding extensions."
      )
    }

    // Wrap the new reference in a `ResolvedNominalTypeReference`
    return .success(
      ResolvedTypeSyntax(
        type: finalizedNominalRef,
        syntax: typeReference.syntax
      )
    )
  }
}
