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

@_spi(_QualifiedLookupTests)
public enum GenericUnqualifiedTypeLookupResult<Scope: Sendable> {
  /// Resolve the given type decl, collecting redeclarations and
  /// the parent 'with-statements' scope containing these declarations.
  case nonNestedTypeDecl(
    decl: Attached<TypeDeclSyntax>,
    redeclarations: [Attached<TypeDeclSyntax>],
    parentScope: Scope
  )

  /// Parameters are guaranteed to be nonempty.
  case genericParameters(
    firstMatch: Attached<GenericParameterSyntax>,
    redeclarations: [Attached<GenericParameterSyntax>],
    genericClause: Attached<GenericParameterClauseSyntax>
  )

  /// Search for the given type declaration as a member of `declGroupParent`.
  /// If `lookForSelf==true`, then we're not looking for the identifier `Self`,
  /// but for implicit `Self` instead.
  case lookForMember(declGroupParent: Attached<DeclGroupSyntaxType>, lookForSelf: Bool)

  /// E.g.
  /// ```swift
  /// extension Array {
  ///   func f(_: Element) {} // <- Element refers to a generic parameter
  /// }
  /// ```
  case lookForGenericParameters(extensionDecl: Attached<ExtensionDeclSyntax>)
}

@_spi(_QualifiedLookupTests)
public typealias UnqualifiedTypeLookupResult = GenericUnqualifiedTypeLookupResult<Attached<CodeBlockItemListSyntax>>

extension Attached /* <SyntaxNode> */ {
  @_spi(_QualifiedLookupTests)
  public func findUnqualifiedType(
    _ typeName: Identifier,
    configuredRegions: ConfiguredRegions?
  ) -> [UnqualifiedTypeLookupResult] {
    let results: [LookupResult] = node.lookup(
      typeName,
      with: LookupConfig(
        configuredRegions: configuredRegions,
        _lookupTopScope: true,
        _dontFindGenericParametersForExtendedType: true
      )
    )

    // We force unwrap because unqualified lookup just visits outer
    // scopes in the file, so we should still have a file root
    func castChild<S: SyntaxProtocol>(_ syntax: S) -> Attached<S> {
      Attached<S>(syntax)!
    }

    let filteredResults = results.compactMap({ result -> UnqualifiedTypeLookupResult? in
      switch result {
      case .fromScope(let scope, let names):
        // Handle generic parameters separately
        if let genericParameterClause = scope.as(GenericParameterClauseSyntax.self) {
          // Cast parameters to `GenericParameterSyntax`
          let parameters = names.map({ name in
            guard
              case .identifier(let rawParameter, _) = name,
              let parameter = rawParameter.as(GenericParameterSyntax.self)
            else {
              fatalError(
                "[SwiftLexicalLookup] Internal error: Got unexpected name '\(name)' from a `GenericParameterClauseSyntax` scope."
              )
            }
            return castChild(parameter)
          })
          guard let firstParameter = parameters.first else {
            fatalError(
              "[SwiftLexicalLookup] Internal error: Unqualified lookup unexpectedly returned empty names in `.fromScope`."
            )
          }
          return UnqualifiedTypeLookupResult.genericParameters(
            firstMatch: firstParameter,
            redeclarations: Array(parameters[1...]),
            genericClause: castChild(genericParameterClause)
          )
        }

        // Note that we skip non-type declarations, even if they have the same name.
        // For instance:
        //   struct A {
        //     func f() {
        //       let A = 1
        //       func A() {}
        //       var hey: A  = self
        //     }
        //   }
        var typeDecls = [Attached<TypeDeclSyntax>]()
        for name: LookupName in names {
          switch name {
          case .implicit(.`Self`(let decl)):
            // According to the docs, `decl` is either a protocol or extension decl.
            guard let declGroup = decl.as(DeclGroupSyntaxType.self) else {
              fatalError(
                "[SwiftLexicalLookup] Internal error: Expected syntax in .implicit(.Self) to be a declaration group but got \(decl.kind) instead."
              )
            }
            // Only return implicit `Self` if we don't have other matching
            // declarations (also named `Self`).
            guard typeDecls.isEmpty else { continue }

            return UnqualifiedTypeLookupResult.lookForMember(
              declGroupParent: castChild(declGroup),
              lookForSelf: true
            )
          case .declaration(let decl):
            // Skip non-type declarations
            //
            // Note: We handle extensions above
            guard let typeDecl = TypeDeclSyntax(decl) else { continue }

            typeDecls.append(castChild(typeDecl))
          case .identifier(let identifierSyntax, accessibleAfter: _):
            // The only `TypeDeclSyntax` "identifiers" are generic parameters.
            guard let genericParameter = identifierSyntax.as(GenericParameterSyntax.self) else { continue }
            typeDecls.append(castChild((TypeDeclSyntax(genericParameter))))

          // `self`, `newValue`, `error`, and `oldValue` can't be type decls.
          // Also, `equivalentNames` always refers to variable identifiers in
          // switch cases
          case .implicit(.`self`), .implicit(.newValue), .implicit(.oldValue),
            .implicit(.error), .equivalentNames:
            return nil
          }
        }

        // Skip if we couldn't find type declarations
        guard let firstTypeDecl = typeDecls.first else { return nil }
        let redeclarations = Array(typeDecls[1...])

        // Return based on scope: either nested (under a decl group) or
        // non-nested (directly under a CodeBlockItemListSyntax, like a
        // source file or function body)
        //
        // Note: Type decls in a `.fromScope` result should be introduced
        // by a `WithStatementsSyntax` scope. The only non-`WithStatementsSyntax`
        // scopes are:
        // 1. implicit `Self` inside an `AccessorDeclSyntax` or an `ExtensionDeclSyntax`,
        // 2. `associatedtype`s inside `protocol` declarations
        // 3. (generic parameters inside a generic-parameter clause -- handled above)
        // 4. (`guard` statements -- which can't introduce types)
        //
        // Rationale: We surface regular type decls introduced in a declaration
        // group with `.lookForMembers`, since qualified lookup needs to handle
        // those, e.g.:
        // ```swift
        // struct A {
        //   struct B {
        //     func f(_: B) {} // <- Look up here
        //   }
        // }
        // ```
        // We defer to qualified lookup because if we later had
        // `extension A { typealias B = () }`, we'd need to diagnose the
        // ambiguity.
        if let statementScope = scope.asProtocol((any WithStatementsSyntax).self) {
          return UnqualifiedTypeLookupResult.nonNestedTypeDecl(
            decl: firstTypeDecl,
            redeclarations: redeclarations,
            parentScope: castChild(statementScope.statements)
          )
        } else if let protocolParent = scope.as(ProtocolDeclSyntax.self) {
          // As described above, this happens only for associated types.
          // We'll find all types, not just the associated types.
          //
          // Note `typealias`es of associated types in protocol extensions are peculiar.
          // They don't participate in lookup; they just act like defaults for associated
          // types, e.g.:
          // ```swift
          // protocol P {
          //     associatedtype T
          // }
          // extension P {
          //     typealias T = Int
          //     func f(x: T) {
          //         let int: Int = x
          //         // ❌ error: cannot convert value of type 'Self.T' to specified type 'Int'
          //     }
          // }
          // struct A: P { typealias T = () }
          // // ✅ No redeclaration error
          //
          // struct B: P {}
          // // ✅ `T` inferred as `Int`
          //
          // let _: (any P).T = 0
          // let _: P.T = 0
          // // ❌ error: cannot access associated type 'T' from 'any P'
          // ```
          return UnqualifiedTypeLookupResult.lookForMember(
            declGroupParent: castChild(DeclGroupSyntaxType(protocolParent)),
            lookForSelf: false
          )
        } else {
          fatalError(
            "[SwiftLexicalLookup] Internal error: Expected a `WithStatementsSyntax` or `protocol` scope but got `\(scope.kind)` for names: \(names)"
          )
        }
      case .lookForMembers(let parentSyntax):
        guard let declGroupParent = DeclGroupSyntaxType(parentSyntax) else {
          fatalError(
            "[SwiftLexicalLookup] Internal error; Expected .lookForMembers to have a DeclGroupSyntax but found \(parentSyntax.kind)."
          )
        }
        return UnqualifiedTypeLookupResult.lookForMember(
          declGroupParent: castChild(declGroupParent),
          lookForSelf: false
        )
      case .lookForGenericParameters(let extensionDecl):
        return UnqualifiedTypeLookupResult.lookForGenericParameters(extensionDecl: castChild(extensionDecl))
      // Closure parameters can't be type declarations
      case .lookForImplicitClosureParameters(_):
        return nil
      }
    })
    return filteredResults
  }
}

// MARK: Debug

extension GenericUnqualifiedTypeLookupResult {
  @_spi(_QualifiedLookupTests)
  public func _describe(describeScope: (Scope) -> String) -> String {
    switch self {
    case .nonNestedTypeDecl(let decl, let redeclarations, let parentScope):
      let declsDescription = ([decl] + redeclarations).map({ "`\($0._memberlessDescription)`" }).joined(separator: ", ")
      return
        ".nonNestedTypeDecl(decls: \(declsDescription), parentScope: '\(describeScope(parentScope))')"
    case .genericParameters(let firstMatch, let redeclarations, let genericClause):
      let params = [firstMatch] + redeclarations
      let paramsDescription = params.map(\.node.name.trimmedDescription).joined(separator: ", ")
      return
        ".genericParameters(parameters: \(paramsDescription), genericClause: \(genericClause.trimmedDescription))"
    case .lookForMember(let declGroupParent, let lookForSelf):
      return ".lookForMember(declGroupParent: `\(declGroupParent._memberlessDescription)`, lookForSelf: \(lookForSelf))"
    case .lookForGenericParameters(let extensionDecl):
      return ".lookForGenericParameters(in: `\(extensionDecl._memberlessDescription)`)"
    }
  }

  /// Compact form of `debugDescription` for logging
  private func _describeSuccinctly(lookedUpName: Identifier, describeScope: (Scope) -> String) -> String {
    switch self {
    case .nonNestedTypeDecl(let decl, redeclarations: _, let parentScope):
      return "`\(decl._memberlessDescription)` [in '\(describeScope(parentScope))']"
    case .genericParameters(let firstMatch, let redeclarations, let genericClause):
      let params = [firstMatch] + redeclarations
      let paramsDescription = params.map(\.node.name.trimmedDescription).joined(separator: ", ")
      return
        ".genericParameters(parameters: \(paramsDescription), genericClause: \(genericClause.trimmedDescription))"
    case .lookForMember(let declGroupParent, let lookForSelf):
      // E.g. 'extension A {}' > 'B'
      let memberSearchDescription = " > '\(lookedUpName.name)'"
      return "`\(declGroupParent._memberlessDescription)`\(lookForSelf ? memberSearchDescription : "")"
    case .lookForGenericParameters(let extensionDecl):
      return "'\(extensionDecl._memberlessDescription)' > generic parameters"
    }
  }
}

@_spi(_QualifiedLookupTests)
extension UnqualifiedTypeLookupResult: CustomDebugStringConvertible {
  public var debugDescription: String {
    _describe(describeScope: { scope in
      String(reflecting: scope.parent?.parent?.kind)
    })
  }
  func _describeSuccinctly(lookedUpName: Identifier) -> String {
    _describeSuccinctly(
      lookedUpName: lookedUpName,
      describeScope: { scope in
        String(reflecting: scope.parent?.parent?.kind)
      }
    )
  }
}
