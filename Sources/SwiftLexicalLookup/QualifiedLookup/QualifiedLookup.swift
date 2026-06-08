// //===----------------------------------------------------------------------===//
// //
// // This source file is part of the Swift.org open source project
// //
// // Copyright (c) 2014 - 2024 Apple Inc. and the Swift project authors
// // Licensed under Apache License v2.0 with Runtime Library Exception
// //
// // See https://swift.org/LICENSE.txt for license information
// // See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
// //
// //===----------------------------------------------------------------------===//
//
// import SwiftIfConfig
// import SwiftSyntax
//
// public struct QualifiedLookupConfig {
//   public var configuredRegions: ConfiguredRegions? = nil
//
//   public init(configuredRegions: ConfiguredRegions? = nil) {
//     self.configuredRegions = configuredRegions
//   }
// }
// public struct QualifiedTableLookupConfig {
//   public var lookupSuperprotocols: Bool
//   public var lookupSuperclasses: Bool
//   public var configuredRegions: ConfiguredRegions?
//
//   /// Parameters:
//   /// - lookupSuperprotocols: Whether to recursively look up
//   ///       inherited or conformed-to protocols.
//   /// - lookupSuperclasses: Whether to recursively look up
//   ///       superclasses, and the protocols they conform to (if
//   ///       `lookupSuperprotocols` is true).
//   public init(
//     lookupSuperprotocols: Bool = false,
//     lookupSuperclasses: Bool = false,
//     configuredRegions: ConfiguredRegions? = nil
//   ) {
//     self.lookupSuperprotocols = lookupSuperprotocols
//     self.lookupSuperclasses = lookupSuperclasses
//     self.configuredRegions = configuredRegions
//   }
// }
//
// // public enum QualifiedLookupResult2 {
// //   case members([DeclSyntax], constraints: [GenericWhereClauseSyntax])
// // }
//
// /// Contains the results of a qualified lookup request
// @_spi(_QualifiedLookup) public enum QualifiedLookupResult {
//   public enum ImplicitDeclaration {
//     case `Type`
//     case `self`
//   }
//
//   /// Explicitly declared members.
//   ///
//   /// Includes static/class/instance stored and computed properties,
//   /// functions, subscripts and initializers, dynamic-member-lookup
//   /// results, along with nested types, type aliases and associated
//   /// types. E.g.
//   /// ```
//   /// struct MyStruct<T> {
//   ///   func callAsFunction() {}
//   /// }
//   /// ```
//   /// Qualified lookup within the `MyStruct` scope would
//   /// return the `callAsFunction()` function declaration.
//   /// Note that qualified lookup won't surface
//   /// operator functions, objc functions using dynamic lookup, and
//   /// generic parameters like `MyStruct.T` (semantically wrong).
//   case members([ValueDeclSyntax], introducedIn: DeclGroupSyntaxType)
//   /// Members declared in conditional extensions, e.g.
//   /// ```
//   /// extension Array where Element == Int {
//   ///   func sum() -> Int { reduce(0, +) }
//   /// }
//   /// ```
//   /// Qualified lookup will return the `sum()` declaration in
//   /// the extension above together with the `where Element == Int`
//   /// clause.
//   case conditionalMembers(
//     [ValueDeclSyntax],
//     introducedIn: DeclGroupSyntaxType,
//     inheritanceClause: InheritanceClauseSyntax?,
//     genericClause: GenericWhereClauseSyntax?
//   )
//   /// Implicit members in the given group declaration like `self`,
//   /// `Type` and synthesized initializers.
//   case implicitMembers([ImplicitDeclaration], introducedIn: DeclGroupSyntaxType)
//   /// Types and protocols annotated with `@dynamicMemberLookup` have
//   /// one or more subscripts with a `dynamicMember` string or keypath
//   /// argument. We defer to the type-checker to determine what members
//   /// these subscripts can produce.
//   case lookForDynamicMembers(
//     dynamicMemberSubscripts: [SubscriptDeclSyntax],
//     introducedIn: DeclGroupSyntaxType
//   )
//   /// Any unknown attributes that could be attached macros or property
//   /// wrappers that expand to more declarations, e.g.
//   /// ```swift
//   /// struct MyView {
//   ///   @State var myState = 0
//   /// }
//   /// ```
//   /// In this case, we instruct the tooling to look up what the
//   /// `@State` attribute expands to in the variable declaration above
//   /// (if anything).
//   case lookForMacros(
//     potentialMacroDecl: [ValueDeclSyntax],
//     introducedIn: DeclGroupSyntaxType
//   )
//   /// Look for any "supertypes" we encountered in the lookup and which
//   /// we didn't retrieve from the symbol table (if we performed `SymbolTable`
//   /// lookup with the `lookupSuperprotocols` or `lookupSuperclasses`
//   /// options).
//   case lookForSupertypes(
//     inheritedFrom: InheritanceClauseSyntax,
//     genericClause: GenericWhereClauseSyntax?
//   )
// }
//
// // indirect enum ResolvedType: Hashable {
// //   case id(IdentifierTypeSyntax)
// //   case member(MemberTypeSyntax, baseTypeMap: ResolvedType)
// //   // TODO: Other types
// //
// //   case idMap(IdentifierTypeSyntax, canonicalType: ResolvedType, using: TypeAliasDeclSyntax)
// //   case memberMap(MemberTypeSyntax, canonicalType: ResolvedType, using: TypeAliasDeclSyntax)
// //
// //   static func from(type: TypeSyntax, nestedAliases: borrowing [ResolvedType?: [Identifier: [TypeAliasDeclSyntax]]) -> [ResolvedType] {
// //     // TODO: Other types
// //     if let idType = type.as(IdentifierTypeSyntax.self) {
// //       // Can't do anything with non-identifier name
// //       guard let identifier = idType.name.identifier else { return [] }
// //       // nil because it's not nested
// //       let relevantMappings = nestedAliases[ResolvedType?.none, default: [:]][identifier, default: []]
// //       let possibleResolutions = relevantMappings.map {
// //         ResolvedType.idMap(idType, canonicalIdentifier: )
// //       }
// //     } else if let memberType = type.as(MemberTypeSyntax)
// //   }
// //
// //   func hash(into hasher: inout Hasher) {
// //     hasher.combine(canonicalType)
// //   }
// //   static func == (a: ResolvedType, b: ResolvedType) -> Bool {
// //     a.canonicalType == b.canonicalType
// //   }
// //
// //   var canonicalType: TypeSyntax {
// //     // switch self {
// //     // case let .id(idType):
// //     //   TypeSyntax(idType)
// //     // case let .member(memberType, baseTypeMap):
// //     //   TypeSyntax(memberType.with(\.baseType, baseTypeMap.canonicalType))
// //     // case let .idMap(idType, resolvedType, _):
// //     //   resolvedType.canonicalType
// //     // case let .memberMap(memberType, resolvedMemberType, _):
// //     //   let canonicalMemberType = resolvedMemberType.canonicalType
// //     //   switch resolvedMemberType {
// //     //     case let .id(idType):
// //     //       memberType.with(\.name, idType.name)
// //     //     case let .
// //     //   }
// //     //   TypeSyntax(memberType.with(\.name, TokenSyntax.identifier(canonicalIdentifier.name)))
// //     // }
// //   }
// // }
// // TODO: Implement kinda like above
// // FIXME: Add type-alias resolving
// // E.g.
// // struct LongStructNameElement {}
// // struct LongStructName {
// //   struct LongNestedName {}
// //   typealias Element = LongStructNameElement
// // }
// // extension LongStructName.Element {} // This should match LongStructNameElement
//
// // A unique way to refer to types.
// //
// // Note that at this stage, there may be multiple main
// // declarations for each resolved type (invalid but diagnosed later),
// // or none (e.g. extension references unknown type without type-aliases).
// // `CanonicalType`s just provide unique identifier for looking up types.
// struct CanonicalType: Hashable {
//   private let _type: TypeSyntax
//   private init(_type: TypeSyntax) {
//     self._type = _type
//   }
//
//   static func from(type: TypeSyntax) -> [CanonicalType] {
//     [CanonicalType(_type: type)]
//   }
//
//   /// Note that the resulting type may not refer to any valid main declaration
//   init(baseType: CanonicalType? = nil, mainDeclID id: Identifier) {
//     let nameToken = TokenSyntax.identifier(id.name)
//     if let baseType {
//       _type = TypeSyntax(MemberTypeSyntax(baseType: baseType._type, name: nameToken))
//     } else {
//       _type = TypeSyntax(IdentifierTypeSyntax(name: nameToken))
//     }
//   }
//
//   // /// Returns nil if id token can't be converted to an identifier
//   // private init?(_topLevelNominalType name: TokenSyntax) {
//   //   guard name.identifier != nil else { return nil }
//   //   _type = TypeSyntax(IdentifierTypeSyntax(name: name))
//   // }
//   // /// Nil if type's name can't be converted to an identifier.
//   // init?(topLevelDecl: some NominalTypeDeclSyntax) {
//   //   self.init(_topLevelNominalType: topLevelDecl.name)
//   // }
//   // /// Nil if type's name can't be converted to an identifier.
//   // init?(topLevelDecl: ProtocolDeclSyntax) {
//   //   self.init(_topLevelNominalType: topLevelDecl.name)
//   // }
// }
//
// public class SymbolTable {
//   let declScope: CodeBlockItemListSyntax
//   lazy var globalGroups:
//     (
//       types: [Identifier: [DeclGroupSyntaxType]],
//       extensions: [CanonicalType: [ExtensionDeclSyntax]],
//       aliases: [Identifier: [TypeAliasDeclSyntax]]
//     ) = SymbolTable._getTypes(of: declScope)
//   /// Construct a table for caching symbol lookup
//   /// for the given declaration scope.
//   public init(declScope: CodeBlockItemListSyntax) {
//     self.declScope = declScope
//   }
//   public convenience init(sourceFile: SourceFileSyntax) {
//     self.init(declScope: sourceFile.statements)
//   }
//
//   static func _addCodeBlock(
//     decl: DeclSyntax,
//     types: inout [Identifier: [DeclGroupSyntaxType]],
//     // TODO: Consider making this lazy
//     // Useful for quick member(nested)-type lookup. E.g.
//     // `UnicodeScalarIndex {}` is canonicalized to `String.UnicodeScalarView.Index`
//     extensions: inout [CanonicalType: [ExtensionDeclSyntax]],
//     aliases: inout [Identifier: [TypeAliasDeclSyntax]]
//   ) {
//     // Look for declaration groups:
//     //   1. nominal types (structs, enums, classes, actors)
//     if let nominalType = decl.asProtocol((any NominalTypeDeclSyntax).self),
//       let typeName = nominalType.name.identifier
//     {
//       types[typeName, default: []].append(DeclGroupSyntaxType(exactly: nominalType))
//     }
//     //   2. protocols (same as nominal types)
//     else if let protocolDecl = decl.as(ProtocolDeclSyntax.self),
//       let typeName = protocolDecl.name.identifier
//     {
//       types[typeName, default: []].append(DeclGroupSyntaxType(exactly: protocolDecl))
//     }
//     //   3. extensions (different because extensions can have a member type, e.g. `extension A.B {}`)
//     //    TODO: Only do at file scope
//     else if let extensionDecl = decl.as(ExtensionDeclSyntax.self) {
//       // Check the extended type isn't `Any` or `Self`; these are caught in Semantic Analysis
//       // but we don't want name lookup to get confused
//       // TODO: Check if this actually happens
//       // Make sure
//       guard extensionDecl.extendedType.description != "Any",
//         extensionDecl.extendedType.description != "Self"
//       else {
//         return
//       }
//
//       let possibleResolutions = CanonicalType.from(type: extensionDecl.extendedType)
//       for resolvedType in possibleResolutions {
//         extensions[resolvedType, default: []].append(extensionDecl)
//       }
//     }
//     // Look for type aliases
//     else if let typeAlias = decl.as(TypeAliasDeclSyntax.self),
//       let typeName = typeAlias.name.identifier
//     {
//       aliases[typeName, default: []].append(typeAlias)
//     }
//   }
//
//   // TODO: Technically, we know this can never be a protocol/extension (we can't nest
//   //       these under types)
//   //
//   /// Retrieve all types nested in the given declaration group (no recursion).
//   static func _getNestedTypes(
//     of group: DeclGroupSyntaxType
//   ) -> (
//     nestedTypes: [Identifier: [DeclGroupSyntaxType]],
//     aliases: [Identifier: [TypeAliasDeclSyntax]]
//   ) {
//     var nestedTypes = [Identifier: [DeclGroupSyntaxType]]()
//     var aliases = [Identifier: [TypeAliasDeclSyntax]]()
//     for member in group.memberBlock.members {
//       var nestedExtensions = [CanonicalType: [ExtensionDeclSyntax]]()
//       _addCodeBlock(decl: member.decl, types: &nestedTypes, extensions: &nestedExtensions, aliases: &aliases)
//       // TODO Handle extensions (tho they can't actually be nested, we could do it for diagnostic purposes)
//       _ = nestedExtensions
//     }
//
//     return (nestedTypes, aliases)
//   }
//
//   /// Retrieve all declaration groups in the top level of the given declaration scope
//   /// (no recursion).
//   static func _getTypes(
//     of declScope: CodeBlockItemListSyntax
//   ) -> (
//     types: [Identifier: [DeclGroupSyntaxType]],
//     extensions: [CanonicalType: [ExtensionDeclSyntax]],
//     aliases: [Identifier: [TypeAliasDeclSyntax]]
//   ) {
//     var types = [Identifier: [DeclGroupSyntaxType]]()
//     var extensions = [CanonicalType: [ExtensionDeclSyntax]]()
//     var aliases = [Identifier: [TypeAliasDeclSyntax]]()
//
//     for stmt in declScope {
//       // Only declarations can introduce types
//       guard case .decl(let decl) = stmt.item else { continue }
//       // Process
//       _addCodeBlock(decl: decl, types: &types, extensions: &extensions, aliases: &aliases)
//     }
//     return (types, extensions, aliases)
//   }
// }
//
// // extension DeclGroupSyntax {
// //   /// Search for members matching given identifier.
// //   /// Parameters:
// //   /// - lookUpPosition: Indicates position where we should
// //   ///     start lookup. Will enable future expansion that filters
// //   ///     by access control.
// //   public func lookupMember(
// //     _ identifier: Identifier?,
// //     // TODO: Consider changing this and unqualified lookup to "lookupPosition"
// //     // since "lookup" functions as a noun here.
// //     from lookUpPosition: AbsolutePosition?,
// //     with config: QualifiedLookupConfig = QualifiedLookupConfig()
// //   ) -> [CanonicalType: [QualifiedLookupResult]] {
// //     // FIXME: Implement
// //     []
// //   }
// //
// //   /// Search for members matching given identifier in the given symbol table.
// //   /// Parameters:
// //   /// - lookUpPosition: Indicates position where we should
// //   ///     start lookup. Will enable future expansion that filters
// //   ///     by access control.
// //   public func lookupMember(
// //     _ identifier: Identifier?,
// //     from lookUpPosition: AbsolutePosition?,
// //     using symbolTable: SymbolTable,
// //     with config: QualifiedTableLookupConfig = QualifiedTableLookupConfig()
// //   ) -> [CanonicalType: [QualifiedLookupResult]] {
// //     // FIXME: Implement
// //     []
// //   }
// // }
//
// // TODO: Extend to types within functions
// extension SymbolTable {
//   // FIXME: Should support all Types
//   // where identifier -> base global lookup
//   //       member -> recursive on first, then it's our bread&butter
//   //       compositions -> look into composing protocols&/types
//   //       some T -> look into T (protocol or composition thereof, or class)
//   //       any T -> look into (protocol or composition thereof, or class)
//   //                (don't care if it's final; will be diagnosed later)
//   //       T.self -> look into static members of T (look for static members)
//   //       tuple -> if arity is known, return `.0, .1, ...` (no other members because
//   //                that's not allowed for non-nominal types)
//   //       [unwrapped]optional, array, dictionary, inline array,
//   //       class restriction -> look into said class?
//   //       function -> definitionally no results
//   //       pack element -> look into inheritance/where clauses of pack decl?
//   //       suppressed type -> can't do anything yet (return dedicated result type)
//   // TODO: Handle cycles
//   // TODO: Consider getting the "type context" from `type` for handling types in type
//   //       aliases like typealias Many<T> = Array<T> or, e.g., `Self` inside a struct
//   //       (but unqualified lookup already does this).
//   /// Look up the member of the given type using the sumbol table.
//   /// Filter members by the given `identifier` and/or `memberKind`,
//   /// if provided. The `config` resolves if-configs, if provided.
//   private func _lookUpTypeMember(
//     type: TypeSyntax,
//     name: DeclNameRef?,
//     kind memberKind: MemberKind,
//     config: QualifiedTableLookupConfig,
//     into results: inout [CanonicalType: [QualifiedLookupResult]]
//   ) {
//     if let identifierType = type.as(IdentifierTypeSyntax.self) {
//       _lookUpGlobalTypeMember(
//         type: identifierType,
//         name: name,
//         kind: memberKind,
//         config: config,
//         into: &results
//       )
//     } else if let memberType = type.as(MemberTypeSyntax.self) {
//       _lookUpNestedTypeMember(
//         type: memberType,
//         name: name,
//         kind: memberKind,
//         config: config,
//         into: &results
//       )
//     } else {
//       fatalError("[SwiftLexicalLookup] Internal error: This type lookup \(type.kind) isn't implemented")
//     }
//   }
//
//   private func _visitSupertypes(
//     of groupDecl: DeclGroupSyntax,
//     lookingFor name: DeclNameRef?,
//     kind memberKind: MemberKind,
//     results: inout [CanonicalType: [QualifiedLookupResult]]
//   ) {
//     print("[SwiftLexicalLookup] Internal warning: Supertypes not implemented yet.")
//     // Supertypes show up in:
//     // 1. inheritance clauses
//     //    (for nominal types+protocols+extensions)
//     // 2. where clauses of the form `Self : Supertype`
//     //    (also for nominal types+protocols+extensions)
//     //    Note that it will always be `Self` because:
//     //    1. A supertype constraint in that position is a generic parameter or `Self`
//     //       1. It can't be a reference of `Self` like a typealias because the following fails:
//     //          typealias A<T> = B<T>
//     //          struct B<T> where A<T>: CustomStringConvertible {}
//     //    2. Contraints on generic parameter's don't impose supertype constraints on `Self`
//     //
//     // TODO: Consider attaching inheritance&where clauses from extensions/typealiases to qualified-lookup results
//   }
//
//   private func _lookUpGroupMembers(
//     group: DeclGroupSyntaxType,
//     type: CanonicalType,
//     name: DeclNameRef?,
//     kind memberKind: MemberKind,
//     config: QualifiedTableLookupConfig,
//     into results: inout [CanonicalType: [QualifiedLookupResult]]
//   ) {
//     // print(
//     //   ">>Looking for group members for ref '\(name?.debugDescription ?? "_")' in group decl: '\(group.trimmedDescription)'"
//     // )
//     // Add direct members
//     let directMembers = group.findDirectMembers(
//       name: name,
//       kind: memberKind,
//       configuredRegions: config.configuredRegions
//     )
//     results[type, default: []].append(.members(directMembers, introducedIn: group))
//
//     // Visit supertypes
//     _visitSupertypes(of: group, lookingFor: name, kind: memberKind, results: &results)
//   }
//
//   // Finds decl groups nested in identifier types
//   private func _lookUpGlobalTypeMember(
//     type: IdentifierTypeSyntax,
//     name: DeclNameRef?,
//     kind memberKind: MemberKind,
//     config: QualifiedTableLookupConfig,
//     into results: inout [CanonicalType: [QualifiedLookupResult]]
//   ) {
//     // FIXME: Handle modules and module selectors
//     precondition(
//       type.moduleSelector == nil,
//       "[SwiftLexicalLookup] Internal error: Module selector not implemented yet."
//     )
//     // Ensure type identifier is valid (can't do lookup with invalid identifier)
//     guard let typeIdentifier = type.name.identifier else { return }
//
//     // Find group declarations matching type identifier.
//     //
//     // If there are many declarations, prefer types over type aliases.
//     // If we still have multiple declarations, assume last one is valid.
//     // Multiple global declarations with the same name (without access control)
//     // are invalid, but we don't diagnose here.
//     // TODO: Check if compiler also gets the last decl
//     // TODO: Consider the following test case (should we do lookup on Int or not)?
//     //   struct A {}
//     //   typealias A = Int
//     // here, do we look up `Int` too?
//     guard let matchingTypeDecl = globalGroups.types[typeIdentifier]?.last else {
//       // No declarations matched, check for type alaises
//       guard let matchingTypeAlias = globalGroups.aliases[typeIdentifier]?.last else {
//         return
//       }
//       // Look up aliased type
//       let aliasedType = matchingTypeAlias.initializer.value
//       _lookUpTypeMember(
//         type: aliasedType,
//         name: name,
//         kind: memberKind,
//         config: config,
//         into: &results
//       )
//       return
//     }
//
//     // Since we found a main declaration, we can construct a canonical type.
//     let canonicalType = CanonicalType(mainDeclID: typeIdentifier)
//     // Perform direct lookup
//     _lookUpGroupMembers(
//       group: matchingTypeDecl,
//       type: canonicalType,
//       name: name,
//       kind: memberKind,
//       config: config,
//       into: &results
//     )
//     // Check extensions using this canonical type
//     for extensionDecl in globalGroups.extensions[canonicalType, default: []] {
//       _lookUpGroupMembers(
//         group: DeclGroupSyntaxType(exactly: extensionDecl),
//         type: canonicalType,
//         name: name,
//         kind: memberKind,
//         config: config,
//         into: &results
//       )
//     }
//   }
//
//   func _lookUpNestedTypeMember(
//     type: MemberTypeSyntax,
//     name: DeclNameRef?,
//     kind memberKind: MemberKind,
//     config: QualifiedTableLookupConfig,
//     into results: inout [CanonicalType: [QualifiedLookupResult]]
//   ) {
//     // FIXME: Handle modules and module selectors
//     precondition(
//       type.moduleSelector == nil,
//       "[SwiftLexicalLookup] Internal error: Module selector not implemented yet."
//     )
//     // Process "implicit" self
//     guard type.name.tokenKind != .keyword(.self) else {
//       // Forward lookup to the base type
//       _lookUpTypeMember(type: type.baseType, name: name, kind: memberKind, config: config, into: &results)
//       return
//     }
//
//     // TODO: Figure out how to handle this (currently we include nothing)
//     // I guess we could include `.Type` itself.
//     // Note: The metatype of a metatype is a distinct canonical type from the
//     // metatype. E.g. Int.Type != Int.Type.Type:
//     //   func test() {
//     //     var metaInt: Int.Type = Int.self
//     //     // Succeeds if Int.Type is a subtype of Int.Type.Type
//     //     let metaMetaInt: Int.Type.Type = metaInt
//     //     // Succeeds if Int.Type.Type is a subtype of Int.Type
//     //     metaInt /*: Int.Type */ = metaMetaInt
//     //   }
//     // Both fail, showing that Int.Type.Type != Int.Type
//     guard type.name.tokenKind != .keyword(.Type) else { return }
//
//     // TODO: Handle
//     guard type.name.tokenKind != .keyword(.Protocol) else { return }
//
//     // Ensure identifier is valid (can't do lookup with invalid identifier)
//     guard let typeIdentifier = Identifier(validating: type.name) else { return }
//
//     let typeName = DeclNameRef(baseName: .identifier(identifier: typeIdentifier))
//
//     // Two scopes can introduce members in nested types. The main declaration
//     // and any top-level extensions (nested extensions are currently illegal).
//     // Each of these scopes can either have member declarations or introduce
//     // supertypes.
//
//     // For one, get the possible main declaration for each canonical type matching
//     // the given identifier.
//     // Get possible declarations by looking up through the base type.
//     //
//     // In a valid program where we filter by identifier and access control,
//     // this will be a single canonical type mapped to one main declaration.
//     // Here's an example of two canonical types for one identifier (assuming
//     // no access-control filters):
//     //   // FileA.swift
//     //   fileprivate struct A {}
//     //   // FileB.swift
//     //   fileprivate struct A {}
//     // Here's an example of two main declarations:
//     //   // FileA.swift
//     //   struct A {}
//     //   extension A {
//     //     fileprivate struct Nested {}
//     //   }
//     //   // FileB.swift
//     //   extension A {
//     //     fileprivate struct Nested {}
//     //   }
//     // This results in one canonical type `A` but two main declarations:
//     // one in "FileA.swift" and one in "FileB.swift".
//     var nestedTypeMainDecls = [CanonicalType: [QualifiedLookupResult]]()
//     _lookUpTypeMember(
//       type: type.baseType,
//       name: typeName,
//       kind: memberKind.onlyStatic(),
//       config: config,
//       into: &nestedTypeMainDecls
//     )
//
//     // Filter down to nominal-type declarations.
//     //
//     // At this point, we may have many such declarations. Here's a
//     // well-formed example:
//     //    // FileA.swift
//     //    struct A { fileprivate struct B {} }
//     //    // FileB.swift
//     //    extension A { fileprivate struct B {} }
//     // But putting these in the same file makes the above an illegal program.
//     // Either way, for now we keep both.
//     // TODO: Look at how compiler handles many
//     // TODO: Look at how potential access control influences lookup
//     // TODO: Look at how to handle `lookFor[..]` queries
//     var extendedLookup = [CanonicalType: [QualifiedLookupResult]]()
//     var mainDecls = [CanonicalType: [any NominalTypeDeclSyntax]]()
//     for (canonicalType, results) in nestedTypeMainDecls {
//       for result in results {
//         switch result {
//         case .members(let decls, _),
//           // Ignore inheritance/where clauses for now
//           .conditionalMembers(let decls, _, _, _):
//           mainDecls[canonicalType, default: []].append(
//             contentsOf: decls.lazy.map({
//               // Ensure look up gave us nominal declarations
//               guard let nominalType = $0.asProtocol((any NominalTypeDeclSyntax).self) else {
//                 fatalError(
//                   "[SwiftLexicalLookup] Internal assertion failure: Expected only nominal types after performing type-only lookup."
//                 )
//               }
//               // Ensure we got a matching identifier
//               assert(nominalType.name.identifier == typeIdentifier)
//               return nominalType
//             })
//           )
//         case .implicitMembers(_, _):
//           // Handled above so lookup shouldn't surface implicit members when the requested
//           // identifier isn't one.
//           assertionFailure(
//             "[SwiftLexicalLookup] Internal assertion failure: Expected no implicit members aftering filtering out `Type` and `self`."
//           )
//         case .lookForDynamicMembers, .lookForSupertypes, .lookForMacros:
//           extendedLookup[canonicalType, default: []].append(result)
//         }
//       }
//     }
//
//     // Look up each possible canonical type
//     for (canonicalType, mainDecls) in mainDecls {
//       // We know all main declarations have the same identifier (by assertion above)
//       let nestedCanonicalType = CanonicalType(baseType: canonicalType, mainDeclID: typeIdentifier)
//
//       // Look up each possible main declaration
//       for mainDecl in mainDecls {
//         // Find members
//         let directMembers = mainDecl.findDirectMembers(
//           name: name,
//           kind: memberKind,
//           configuredRegions: config.configuredRegions,
//         )
//
//         // Add to results
//         results[canonicalType, default: []].append(
//           QualifiedLookupResult.members(
//             directMembers,
//             introducedIn: DeclGroupSyntaxType(exactly: mainDecl)
//           )
//         )
//       }
//
//       // Add extension declaration matching this canonical type
//       for extensionDecl in globalGroups.extensions[canonicalType, default: []] {
//         _lookUpGroupMembers(
//           group: DeclGroupSyntaxType(exactly: extensionDecl),
//           type: nestedCanonicalType,
//           name: name,
//           kind: memberKind,
//           config: config,
//           into: &results
//         )
//       }
//     }
//   }
// }
//
// // MARK: - Compiler Validation
//
// extension SymbolTable {
//   // enum NLOptions : unsigned {
//   //   /// Consider declarations within protocols to which the context type conforms.
//   //   NL_ProtocolMembers = 1 << 0,
//   //
//   //   /// Remove non-visible declarations from the set of results.
//   //   NL_RemoveNonVisible = 1 << 1,
//   //
//   //   /// Remove overridden declarations from the set of results.
//   //   NL_RemoveOverridden = 1 << 2,
//   //
//   //   /// Remove associated type declarations from the set of results. This is used
//   //   /// by conformance checking for resolving type witnesses.
//   //   NL_RemoveAssociatedTypes = 1 << 3,
//   //
//   //   /// Don't check access when doing lookup into a type.
//   //   ///
//   //   /// When performing lookup into a module, this option only applies to
//   //   /// declarations in the same module the lookup is coming from.
//   //   NL_IgnoreAccessControl = 1 << 4,
//   //
//   //   /// This lookup should only return type declarations.
//   //   NL_OnlyTypes = 1 << 5,
//   //
//   //   /// Include synonyms declared with @_implements()
//   //   NL_IncludeAttributeImplements = 1 << 6,
//   //
//   //   // Include @usableFromInline and @inlinable
//   //   NL_IncludeUsableFromInline = 1 << 7,
//   //
//   //   /// Exclude names introduced by macro expansions in the top-level module.
//   //   NL_ExcludeMacroExpansions = 1 << 8,
//   //
//   //   /// This lookup should only return macro declarations.
//   //   NL_OnlyMacros = 1 << 9,
//   //
//   //   /// Include members that would otherwise be filtered out because they come
//   //   /// from a module that has not been imported.
//   //   NL_IgnoreMissingImports = 1 << 10,
//   //
//   //   /// If @abi attributes are present, return the decls representing the ABI,
//   //   /// not the API.
//   //   NL_ABIProviding = 1 << 11,
//   //
//   //   /// The default set of options used for qualified name lookup.
//   //   ///
//   //   /// FIXME: Eventually, add NL_ProtocolMembers to this, once all of the
//   //   /// callers can handle it.
//   //   NL_QualifiedDefault = NL_RemoveNonVisible | NL_RemoveOverridden,
//   //
//   //   /// The default set of options used for unqualified name lookup.
//   //   NL_UnqualifiedDefault = NL_RemoveNonVisible | NL_RemoveOverridden
//   // };
//   public struct LookupOptions: OptionSet, Sendable {
//     // TODO: Convert to option sets
//
//     // enum Source: UInt8 { case superProtocols, superClasses, macroExpansions, abi, implements }
//     // let sources: Set<Source>
//     // let includeMissingImports: Bool
//     //
//     // enum TargetDecl: UInt8 { case macros, static(onlyTypes: Bool = false), protocolMembers(withAssociatedTypes: Bool = true),   }
//     // let targetDecls: Set<TargetDecl>
//     // let nonVisible
//
//     public let rawValue: UInt32
//     public init(rawValue: UInt32) {
//       self.rawValue = rawValue
//     }
//
//     /// Consider declarations within protocols to which the context type conforms.
//     public static let protocolMembers =
//       LookupOptions(rawValue: 1 << 0)
//
//     /// Remove non-visible declarations from the set of results.
//     public static let removeNonVisible =
//       LookupOptions(rawValue: 1 << 1)
//
//     /// Remove overridden declarations from the set of results.
//     public static let removeOverridden =
//       LookupOptions(rawValue: 1 << 2)
//
//     /// Remove associated type declarations from the set of results.
//     /// This is used by conformance checking for resolving type witnesses.
//     public static let removeAssociatedTypes =
//       LookupOptions(rawValue: 1 << 3)
//
//     /// Don't check access when doing lookup into a type.
//     ///
//     /// When performing lookup into a module, this option only applies to
//     /// declarations in the same module the lookup is coming from.
//     public static let ignoreAccessControl =
//       LookupOptions(rawValue: 1 << 4)
//
//     /// This lookup should only return type declarations.
//     public static let onlyTypes =
//       LookupOptions(rawValue: 1 << 5)
//
//     /// Include synonyms declared with @_implements()
//     public static let includeAttributeImplements =
//       LookupOptions(rawValue: 1 << 6)
//
//     /// Include @usableFromInline and @inlinable
//     public static let includeUsableFromInline =
//       LookupOptions(rawValue: 1 << 7)
//
//     /// Exclude names introduced by macro expansions in the top-level module.
//     public static let excludeMacroExpansions =
//       LookupOptions(rawValue: 1 << 8)
//
//     /// This lookup should only return macro declarations.
//     public static let onlyMacros =
//       LookupOptions(rawValue: 1 << 9)
//
//     /// Include members that would otherwise be filtered out because they come
//     /// from a module that has not been imported.
//     public static let ignoreMissingImports =
//       LookupOptions(rawValue: 1 << 10)
//
//     /// If @abi attributes are present, return the decls representing the ABI,
//     /// not the API.
//     public static let abiProviding =
//       LookupOptions(rawValue: 1 << 11)
//
//     /// The default set of options used for qualified name lookup.
//     ///
//     /// FIXME: Eventually, add `protocolMembers` to this, once all callers can handle it.
//     public static let qualifiedDefault: LookupOptions = [.removeNonVisible, .removeOverridden]
//
//     /// The default set of options used for unqualified name lookup.
//     public static let unqualifiedDefault: LookupOptions = [.removeNonVisible, .removeOverridden]
//   }
//
//   /// Look for the set of declarations with the given name within a type,
//   /// its extensions and, optionally, its supertypes.
//   ///
//   /// This routine performs name lookup within a given type, its extensions
//   /// and, optionally, its supertypes and their extensions, from the perspective
//   /// of the current DeclContext. It can eliminate non-visible, hidden, and
//   /// overridden declarations from the result set. It does not, however, perform
//   /// any filtering based on the semantic usefulness of the results.
//   ///
//   /// \param type The type to look into.
//   ///
//   /// \param member The member to search for.
//   ///
//   /// \param options Options that control name lookup, based on the
//   /// \c NL_* constants in \c NameLookupOptions.
//   ///
//   /// \param[out] decls Will be populated with the declarations found by name
//   /// lookup.
//   ///
//   /// \returns true if anything was found.
//   // bool lookupQualified(Type type, DeclNameRef member,
//   //                      SourceLoc loc, NLOptions options,
//   //                      SmallVectorImpl<ValueDecl *> &decls) const;
//   func lookupMember(
//     withName name: DeclNameRef,
//     inType type: TypeSyntax,
//     fromLocation location: AbsolutePosition,
//     options: LookupOptions
//   ) -> [ValueDeclSyntax] {
//     var perTypeResults = [CanonicalType: [QualifiedLookupResult]]()
//     _lookUpTypeMember(
//       type: type,
//       name: name,
//       kind: options.contains(.onlyTypes) ? .includeTypes : .includeAllMembers,
//       config: QualifiedTableLookupConfig(
//         lookupSuperprotocols: options.contains(.protocolMembers),
//         lookupSuperclasses: true,  // TODO: I don't know if this is the compiler's default
//         configuredRegions: nil
//       ),
//       into: &perTypeResults
//     )
//
//     return perTypeResults.flatMap({ (_, results: [QualifiedLookupResult]) -> [ValueDeclSyntax] in
//       results.flatMap({ (result: QualifiedLookupResult) -> [ValueDeclSyntax] in
//         switch result {
//         case .members(let decls, _), .conditionalMembers(let decls, _, _, _):
//           decls
//         case .implicitMembers, .lookForDynamicMembers, .lookForMacros, .lookForSupertypes:
//           []
//         }
//       })
//     })
//   }
//
//   /// Look for the set of declarations with the given name within the
//   /// given set of nominal type declarations.
//   ///
//   /// \param types The type declarations to look into.
//   ///
//   /// \param member The member to search for.
//   ///
//   /// \param options Options that control name lookup, based on the
//   /// \c NL_* constants in \c NameLookupOptions.
//   ///
//   /// \param[out] decls Will be populated with the declarations found by name
//   /// lookup.
//   ///
//   /// \returns true if anything was found.
//   // bool lookupQualified(ArrayRef<NominalTypeDecl *> types, DeclNameRef member,
//   //                      SourceLoc loc, NLOptions options,
//   //                      SmallVectorImpl<ValueDecl *> &decls) const;
//   func lookupMember(
//     withName name: DeclNameRef?,
//     inDeclGroup declGroup: DeclGroupSyntaxType,
//     fromLocation location: AbsolutePosition,
//     memberKind: MemberKind = .default,
//     lookupSupertypes: Bool = false
//   ) -> [ValueDeclSyntax] {
//     var perTypeResults = [CanonicalType: [QualifiedLookupResult]]()
//
//     _lookUpGroupMembers(
//       group: declGroup,
//       type: CanonicalType(baseType: nil, mainDeclID: Identifier(canonicalName: "")),
//       name: name,
//       kind: memberKind,
//       config: QualifiedTableLookupConfig(
//         lookupSuperprotocols: lookupSupertypes,
//         lookupSuperclasses: lookupSupertypes,
//         configuredRegions: nil
//       ),
//       into: &perTypeResults
//     )
//
//     return perTypeResults.flatMap({ (_, results: [QualifiedLookupResult]) -> [ValueDeclSyntax] in
//       results.flatMap({ (result: QualifiedLookupResult) -> [ValueDeclSyntax] in
//         switch result {
//         case .members(let decls, _), .conditionalMembers(let decls, _, _, _):
//           decls
//         case .implicitMembers, .lookForDynamicMembers, .lookForMacros, .lookForSupertypes:
//           []
//         }
//       })
//     })
//   }
//
// }
