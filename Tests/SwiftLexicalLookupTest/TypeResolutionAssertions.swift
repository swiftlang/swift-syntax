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
@_spi(_QualifiedLookup) @_spi(_QualifiedLookupTests) import SwiftLexicalLookup
import SwiftSyntax
import XCTest

/// Asserts the given annotated `TypeSyntax` resolves to the right `NominalTypeDeclSyntax`
/// and qualified name. Also asserts `ExtensionDeclSyntax`-binding produces the expected
/// `ExtensionBindingState`.
/// and `ExtensionDeclSyntax`
struct TypeResolutionMatcher {
  /// A mock `ResolvedTypeSyntax` representing the name of this
  /// annotated, global `NominalTypeDeclSyntax`.
  struct Definition {
    let nominalType: TypeResolver.ResolvedTypeSyntax
  }
  /// Annotates `TypeSyntax` with a type-resolution result using markers;
  /// also annotates `ExtensionDeclSyntax` with the desired `ExtensionBindingState`.
  enum Expectation {
    case syntaxResolution(TypeResolver.TypeResult)
    case extensionBinding(TypeGraph.ExtensionState)
  }

  let symbolTable: SymbolTable
  let moduleName: Identifier
  let lookupFiles: [(String, SourceFileSyntax)]
}

// MARK: `Definition` Conformances

extension TypeResolutionMatcher.Definition: LexicalAnnotation, Identifiable, CustomStringConvertible {
  typealias SyntaxReference = NominalTypeDeclSyntax
  func findSyntaxFromToken(
    _ token: SwiftSyntax.TokenSyntax,
    verbose: Bool,
    file: StaticString,
    line: UInt
  ) -> NominalTypeDeclSyntax? {
    LexicalAssertionUtilities.findDirectParent(from: token, ofType: NominalTypeDeclSyntax.self, file: file, line: line)
  }

  var id: String { nominalType.debugDescription }

  var description: String { nominalType.debugDescription }
}

// MARK: `Expectation` Conformances

/// Either `TypeSyntax` or `ExtensionDeclSyntax`. Helper
/// for `TypeResolutionMatcher`
struct TypeSyntaxOrExtension: SyntaxProtocol, SyntaxHashable {
  private(set) var _syntaxNode: Syntax
  init?(_ node: __shared some SyntaxProtocol) {
    guard node.is(TypeSyntax.self) || node.is(ExtensionDeclSyntax.self) else { return nil }
    _syntaxNode = Syntax(node)
  }
  static var structure: SyntaxNodeStructure {
    SyntaxNodeStructure.choices([
      .node(TypeSyntax.self),
      .node(ExtensionDeclSyntax.self),
    ])
  }

  // Always succeeding inits
  init(_ node: __shared some TypeSyntaxProtocol) {
    self = Syntax(node).cast(TypeSyntaxOrExtension.self)
  }
  init(_ node: __shared ExtensionDeclSyntax) {
    self = Syntax(node).cast(TypeSyntaxOrExtension.self)
  }
}

extension TypeResolutionMatcher.Expectation: LexicalAnnotation {
  typealias SyntaxReference = TypeSyntaxOrExtension

  /// Find the head type-syntax (because for instance `any Encodable & Decodable`
  /// contains the `Encodable & Decodable` nested type syntax)
  private func _findHeadTypeSyntax(of typeSyntax: TypeSyntax) -> TypeSyntax {
    // Cast the parent to type syntax, or return current type syntax
    //
    // Check for special-cases first (e.g., compositions)
    if typeSyntax.parent?.is(CompositionTypeElementSyntax.self) == true,
      let compositionSyntax = typeSyntax.parent?.parent?.parent?.as(CompositionTypeSyntax.self)
    {
      return _findHeadTypeSyntax(of: TypeSyntax(compositionSyntax))
    }
    // General case
    guard let parentTypeSyntax = typeSyntax.parent?.as(TypeSyntax.self) else { return typeSyntax }
    // Find parent's head type syntax
    return _findHeadTypeSyntax(of: parentTypeSyntax)
  }

  func findSyntaxFromToken(
    _ token: TokenSyntax,
    verbose: Bool,
    file: StaticString,
    line: UInt
  ) -> TypeSyntaxOrExtension? {
    switch self {
    case .extensionBinding:
      // Extensions should be annotated before 'extension' and the direct token
      // parent should be ExtensionDeclSyntax
      return LexicalAssertionUtilities.findDirectParent(
        from: token,
        ofType: ExtensionDeclSyntax.self,
        file: file,
        line: line,
        annotationKindDescription: "extension-binding"
      ).map(TypeSyntaxOrExtension.init(_:))
    case .syntaxResolution:
      // Ensure the token's parent is a type syntax
      guard let baseTypeSyntax = token.parent?.as(TypeSyntax.self) else {
        XCTFail(
          "Invalid type-syntax expectation placement: A qualified-name expectation should be placed right before the target type syntax (parent is '\(String(reflecting: token.parent?.kind))').",
          file: file,
          line: line
        )
        return nil
      }

      let typeSyntax = _findHeadTypeSyntax(of: baseTypeSyntax)

      return TypeSyntaxOrExtension(typeSyntax)
    }
  }
}

// MARK: `LexicalMatcher` Conformance

extension TypeResolutionMatcher: LexicalMatcher {
  func describeContextualizedExpectation(_ expectation: ContextualizedAnnotation<Expectation>) -> String {
    if let extensionDecl = expectation.syntax.as(ExtensionDeclSyntax.self) {
      return extensionDecl._memberlessDescription
    } else if let typeSyntax = expectation.syntax.as(TypeSyntax.self) {
      return typeSyntax.trimmedDescription
    } else {
      fatalError(
        "[SwiftLexicalLookup] Internal test error: Expected TypeSyntaxOrExtension to be either an ExtensionDeclSyntax or TypeSyntax."
      )
    }
  }
  /// Look up extended type if not already resolved
  private func _admitAndGetExtensionState(
    _ extensionDecl: Attached<ExtensionDeclSyntax>,
    verbose: Bool,
    failures: inout [ExpectationFailure]
  ) -> TypeGraph.ExtensionState? {
    // Try to get already-resolved state
    if let existingState = symbolTable.typeGraph.extensionsToState[extensionDecl] {
      return existingState
    }

    // Admit the extension
    if verbose {
      print("Extension `\(extensionDecl.node._memberlessDescription)` not already bound; initating binding.")
    }
    _ = symbolTable.bindExtension(extensionDecl)

    // After binding, we should we have a state
    guard let producedState = symbolTable.typeGraph.extensionsToState[extensionDecl] else {
      let availableExtensions = symbolTable.typeGraph.extensionsToState.keys.map(\.node._memberlessDescription)
      failures.append(
        ExpectationFailure.other(
          failure:
            "No extension state: Couldn't find extension state even after nominal-type resolution; available extensions are: \(availableExtensions)"
        )
      )
      return nil
    }

    return producedState
  }

  func assertExpectation(
    expectation: ContextualizedAnnotation<Expectation>,
    markersToDefinitions: [String: ContextualizedAnnotation<Definition>],
    syntaxToDefinitions: [NominalTypeDeclSyntax: ContextualizedAnnotation<Definition>],
    verbose: Bool
  ) -> [ExpectationFailure] {
    func verifyExpectedNominalDescription(_ nominalTypeDescription: String, failures: inout [ExpectationFailure]) {
      // Ensure we're referencing a marked nominal-type name
      if markersToDefinitions[nominalTypeDescription] == nil {
        failures.append(ExpectationFailure.referencesUndefinedMarker(nominalTypeDescription))
      }
    }
    func verifyActualNominal(_ nominalType: TypeGraph.TypeRef, failures: inout [ExpectationFailure]) {
      // Ensure we've marked syntax with that name
      let mainDecl = nominalType.mainDecl.node
      guard let definition = syntaxToDefinitions[mainDecl] else {
        failures.append(.resultReferencesUnmarkedSyntax(syntaxDescription: mainDecl._memberlessDescription))
        return
      }

      // Ensure the actual name matches the marked name
      let markedName = definition.annotation.nominalType.debugDescription
      guard nominalType._succinctDescription == markedName else {
        failures.append(
          ExpectationFailure.other(
            failure:
              "Expected nominal-type decl `\(mainDecl._memberlessDescription)` to be named '\(markedName)' but instead got name '\(nominalType._succinctDescription)'."
          )
        )
        return
      }
    }
    // Force unwrap we parse from a file
    let expectationSyntax = Attached(expectation.syntax)!

    // Check the given `TypeSyntax` resolution or extension-binding state
    var failures = [ExpectationFailure]()
    let expectedDescription: String
    let actualDescription: String
    switch expectation.annotation {
    case .syntaxResolution(let expectedType):
      guard let typeSyntax = expectationSyntax.as(TypeSyntax.self) else {
        fatalError(
          "[SwiftLexicalLookup] Internal test error: Expected syntax-resolution queries to find 'TypeSyntax' nodes, but got '\(expectation.syntax.kind)'."
        )
      }

      // Perform the lookup to get the `actualResult` (as opposed to `expectedResult`)
      let actualType: TypeResolver.TypeResult = symbolTable.resolve(typeSyntax: typeSyntax)

      // Check the nested nominals
      expectedType._visitNominals({ verifyExpectedNominalDescription($0._succinctDescription, failures: &failures) })
      actualType._visitNominals({ verifyActualNominal($0, failures: &failures) })

      // Describe the types
      (expectedDescription, actualDescription) = (expectedType.debugDescription, actualType.debugDescription)

    case .extensionBinding(let expectedState):
      guard let extensionDecl = expectationSyntax.as(ExtensionDeclSyntax.self) else {
        fatalError(
          "[SwiftLexicalLookup] Internal test error: Expected syntax-resolution queries to find 'ExtensionDeclSyntax' nodes, but got '\(expectation.syntax.kind)'."
        )
      }

      // Give up if we can't get the extension state
      guard let actualState = _admitAndGetExtensionState(extensionDecl, verbose: verbose, failures: &failures) else {
        return failures
      }

      // Check the nested nominals
      expectedState._visitTypes(
        visitResolved: { verifyExpectedNominalDescription($0._succinctDescription, failures: &failures) },
        visitName: { name in
          verifyExpectedNominalDescription(name.debugDescription, failures: &failures)
        }
      )
      actualState._visitTypes(
        visitResolved: { verifyActualNominal($0, failures: &failures) },
        // `GlobalTypeName` doesn't store syntax information like `GlobalTypeRef`,
        // so we can't call `verifyActualNominal`. Of course, we still check if we
        // get the right type result by comparing the descriptions below.
        visitName: { _ in }
      )

      // Describe the states
      (expectedDescription, actualDescription) = (expectedState.debugDescription, actualState.debugDescription)
    }

    // Give up if the expectation/actual results have undefined references
    guard failures.isEmpty else { return failures }

    // Check they're equal
    guard expectedDescription == actualDescription else {
      return [
        .other(failure: "Resolved-type mismatch.\nExpected: \(expectedDescription)\nBut got:  \(actualDescription)")
      ]
    }

    return []
  }
}

// MARK: Assert Function

/// Creates assertions for type resolution
///
/// Note that we don't guarantee that extension binding will
/// happen in a specific order. If name lookup works properly,
/// this arbitrary order may only impact performance. However,
/// when debugging tests, you can place `\(extensionState: ...)`
/// to the first extension you want to bind. After that, it's still
/// up to the dependency graph to decide which extension goes next.
func assertTypeResolution(
  _ lookupSources: KeyValuePairs<String, LexicalLookupSource<TypeResolutionMatcher>>,
  moduleName: StaticString = "MyModule",
  buildConfiguration: StaticBuildConfiguration = StaticBuildConfiguration(
    customConditions: [],
    languageVersion: VersionTuple(5, 5),
    compilerVersion: VersionTuple(6, 0)
  ),
  file: StaticString = #file,
  line: UInt = #line,
  verbose: Bool = false
) {
  // Convert data formats
  let moduleIdentifier = Identifier(canonicalName: moduleName)
  // Map files to name & file syntax
  let lookupFiles: [(String, SourceFileSyntax)] = lookupSources.map({ fileName, lookupSource in
    (fileName, lookupSource.fileSyntax)
  })
  // Test cases should give us unique file names
  let uniquedLookupFiles = Dictionary(uniqueKeysWithValues: lookupFiles)

  _assertLexicalLookup(
    lookupSources,
    matcher: TypeResolutionMatcher(
      symbolTable: SymbolTable(
        moduleName: moduleIdentifier,
        moduleToSources: [moduleIdentifier: uniquedLookupFiles],
        buildConfiguration: buildConfiguration
      )!,
      moduleName: moduleIdentifier,
      lookupFiles: lookupFiles
    ),
    file: file,
    line: line,
    verbose: verbose
  )
}

// MARK: String-Interpolation Helpers

extension LexicalLookupSource.Interpolation where Matcher == TypeResolutionMatcher {
  mutating func appendInterpolation(
    name mockedNominalType: TypeResolver.ResolvedTypeSyntax,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    append(definition: TypeResolutionMatcher.Definition(nominalType: mockedNominalType), file: file, line: line)
  }
  mutating func appendInterpolation(
    extensionState: TypeGraph.ExtensionState,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    appendInterpolation(
      expects: [TypeResolutionMatcher.Expectation.extensionBinding(extensionState)],
      file: file,
      line: line
    )
  }
  mutating func appendInterpolation(
    type: TypeResolver.TypeResult,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    appendInterpolation(expects: [TypeResolutionMatcher.Expectation.syntaxResolution(type)], file: file, line: line)
  }
  mutating func appendInterpolation(
    failure: TypeResolver.Failure,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    appendInterpolation(type: TypeResolver.TypeResult.failure(failure), file: file, line: line)
  }
  mutating func appendInterpolation(
    nominals: [TypeResolver.ResolvedTypeSyntax],
    file: StaticString = #file,
    line: UInt = #line
  ) {
    appendInterpolation(type: TypeResolver.TypeResult.nominalTypes(nominals), file: file, line: line)
  }
  mutating func appendInterpolation(
    nominal: TypeResolver.ResolvedTypeSyntax,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    appendInterpolation(nominals: [nominal], file: file, line: line)
  }
}

// MARK: Convenience Initializers

@_spi(_QualifiedLookupTests)
extension TypeGraph.GlobalTypeName: ExpressibleByStringLiteral {
  public init(stringLiteral string: String) {
    self = ._mock(nameDescription: string)
  }
}

@_spi(_QualifiedLookupTests)
extension TypeGraph.GlobalTypeRef: ExpressibleByStringLiteral {
  public init(stringLiteral string: String) {
    self = TypeGraph.GlobalTypeRef._mock(
      globalName: TypeGraph.GlobalTypeName(stringLiteral: string),
      unusedNominalDecl: "struct"
    )
  }
}

@_spi(_QualifiedLookupTests)
extension TypeResolver.ResolvedTypeSyntax: ExpressibleByStringLiteral {
  /// Mock a global type reference with the given debug description, e.g.,
  /// `_(MyFile.swift)::MyType`.
  public init(stringLiteral string: String) {
    self = ._mock(
      typeRef: TypeGraph.TypeRef.global(
        TypeGraph.GlobalTypeRef(stringLiteral: string)
      ),
      unusedNominalDecl: "struct"
    )
  }

  /// Mock a local type by providing its main declaration without members,
  /// e.g., `struct A {}`.
  static func local(_ nominalDecl: Attached<NominalTypeDeclSyntax>) -> TypeResolver.ResolvedTypeSyntax {
    TypeResolver.ResolvedTypeSyntax._mock(
      typeRef: TypeGraph.TypeRef.local(nominalDecl),
      unusedNominalDecl: "struct"
    )
  }
}

struct IdentifierWrapper: ExpressibleByStringLiteral {
  let identifier: Identifier

  init(stringLiteral value: StaticString) {
    identifier = Identifier(canonicalName: value)
  }

  init(
    string: String,
    allocatingIn lookupSourceInterpolation: inout LexicalLookupSource<TypeResolutionMatcher>.Interpolation
  ) {
    identifier = lookupSourceInterpolation.allocateIdentifier(string: string)
  }
}

extension TypeGraph.ExtensionDependency {
  init(baseType: TypeGraph.GlobalTypeName, members: [IdentifierWrapper]) {
    let mappedMembers: [(name: Identifier, decls: [Member])] = members.map({ member in
      (name: member.identifier, decls: [])
    })
    self.init(dependencyTypeName: baseType, members: mappedMembers)
  }
}

extension TypeGraph.ExtensionState {
  /// Creates a mock extension state to check an extension's dependencies,
  /// bound type, or failure to bind due to cycles.
  ///
  /// Note: Because `GenericBindingFailure` contains `TypeQualifier.Failure`
  /// (which uses actual `ResolvedNominalTypeReference` and not mock types),
  /// it's hard to test type-resolution failures. You may instead use regular
  /// type-resolution tests and only use this initializer to test extension
  /// binding.
  init(
    dependencies: [TypeGraph.ExtensionDependency],
    resolvedType: Result<TypeGraph.GlobalTypeName, TypeResolver.Failure>,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    self.init(
      _uncheckedDependencies: dependencies,
      resolvedType: resolvedType
    )
  }

  static func bound(
    dependencies: [TypeGraph.ExtensionDependency],
    typeName: TypeGraph.GlobalTypeName
  ) -> TypeGraph.ExtensionState {
    TypeGraph.ExtensionState(dependencies: dependencies, resolvedType: .success(typeName))
  }

  static func invalidCycle(
    dependencies: [TypeGraph.ExtensionDependency],
    cycleElements: [(introducingDecl: String?, extension: String, base: TypeGraph.GlobalTypeRef)],
    conflictingMember: IdentifierWrapper,
    file: StaticString = #file,
    line: UInt = #line
  ) -> TypeGraph.ExtensionState {
    let dependencyPath: [TypeResolver.ExtensionCycleElement] = cycleElements.map({
      (
        introducingTypeDeclText,
        extensionDeclText,
        baseTypeName
      ) -> TypeResolver.ExtensionCycleElement in
      let introducingTypeDecl: TypeDeclSyntax?
      if let introducingTypeDeclText {
        let typeDeclRaw = DeclSyntax(stringLiteral: introducingTypeDeclText)
        guard let typeDecl = Syntax(typeDeclRaw).as(TypeDeclSyntax.self) else {
          fatalError(
            "Couldn't cast the cycle element's 'introducingMember' `\(introducingTypeDeclText)` of kind '\(typeDeclRaw.kind)' to TypeDeclSyntax",
            file: file,
            line: line
          )
        }
        introducingTypeDecl = typeDecl
      } else {
        introducingTypeDecl = nil
      }

      let extensionDeclRaw = DeclSyntax(stringLiteral: extensionDeclText)
      guard let extensionDecl = extensionDeclRaw.as(ExtensionDeclSyntax.self) else {
        fatalError(
          "Couldn't cast the cycle element's 'extension' `\(extensionDeclText)` of kind '\(extensionDeclRaw.kind)' to ExtensionDeclSyntax",
          file: file,
          line: line
        )
      }
      return TypeResolver.ExtensionCycleElement(
        introducingTypeDecl: introducingTypeDecl,
        extensionDecl: extensionDecl,
        boundType: baseTypeName
      )
    })

    let cycle = TypeResolver.ExtensionCycle(
      dependencyPath: dependencyPath,
      dependencyMember: conflictingMember.identifier
    )

    return TypeGraph.ExtensionState(
      dependencies: dependencies,
      resolvedType: Result.failure(TypeResolver.Failure.cyclicalExtensionDependency(cycle))
    )
  }
}
