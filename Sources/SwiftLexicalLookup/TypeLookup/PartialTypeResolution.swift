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

import SwiftSyntax

// MARK: Result Types

/// A partially resolved type reference. Non-nominal leaf types are resolved,
/// leaving nominal types for the type resolver.
///
/// We resolve `AnyObject` to a regular nominal type. That's because, it's
/// just an alias for a built-in object defined in the standard library,
/// which we can also shadow:
/// ```swift
/// struct AnyObject {}
/// let a: AnyObject = AnyObject()
/// ```
@_spi(_QualifiedLookupTests)
public enum PartiallyResolvedType {
  /// `Any`, a suppressed type like `~Escapable`, or a composition thereof.
  case anyType
  /// A metatype of a type, e.g., `(A, B).Type`
  case metatype(base: Attached<TypeSyntax>)
  /// A bare type identifier, such as 'A', 'Self', '`Self`', '`Any`',
  /// 'Module::A', or 'Module::Any'.
  case typeIdentifier(TypeReference)
  case tuple(labels: [Identifier?])
  case member(
    base: Attached<TypeSyntax>,
    memberComponent: TypeReference
  )
  /// A composition of type syntax.
  ///
  /// E.g. A & B & (Int) -> Void
  case composition([Attached<TypeSyntax>])
}

@_spi(_QualifiedLookupTests)
public struct TypeReference: Sendable, CustomDebugStringConvertible {
  let module: Identifier?
  let name: Identifier
  /// The `TypeSyntax` or `TokenSyntax` from which we derived this type reference component;
  /// used for targeted diagnostics.
  public let introducingSyntax: Attached<TypeSyntax>

  public init(
    module: Identifier? = nil,
    name: Identifier,
    introducingSyntax: Attached<TypeSyntax>
  ) {
    self.module = module
    self.name = name
    self.introducingSyntax = introducingSyntax
  }

  public var debugDescription: String {
    let modulePrefix: String
    if let module {
      modulePrefix = "\(module.name)::"
    } else {
      modulePrefix = ""
    }
    return "\(modulePrefix)\(name.name)"
  }
}

@_spi(_QualifiedLookupTests)
public enum PartialTypeResolutionFailure: Error {
  /// Function types aren't interesting for lookup; we defer to SEMA.
  case functionType

  /// Missing types produce errors
  case missingType

  /// We defer wildcard types to the type checker (e.g., `_`, `_.MyType`, `any _`).
  case wildcardType
  /// We report unknown supressed types, e.g., `~CustomStringConvertible`
  case unknownSuppressedType

  /// The type identifier of this `IdentifierTypeSyntax` or `MemberTypeSyntax`
  /// is invalid.
  case invalidTypeIdentifier
}

// MARK: Helpers

extension TypeReference {
  // E.g., `Int?` or `Int!` -> `Optional<Int>`
  fileprivate static func _optionalType(type: Attached<TypeSyntax>) -> TypeReference {
    TypeReference(
      module: Identifier(canonicalName: "Swift"),
      name: Identifier(canonicalName: "Optional"),
      introducingSyntax: type
    )
  }
  /// E.g., `[Int]` -> `Array<Int>`
  fileprivate static func _arrayType(type: Attached<TypeSyntax>) -> TypeReference {
    TypeReference(
      module: Identifier(canonicalName: "Swift"),
      name: Identifier(canonicalName: "Array"),
      introducingSyntax: type
    )
  }
  // E.g., `[5 of Int]` -> `InlineArray<5, Int>`
  fileprivate static func _inlineArrayType(
    type: Attached<TypeSyntax>
  ) -> TypeReference {
    TypeReference(
      module: Identifier(canonicalName: "Swift"),
      name: Identifier(canonicalName: "InlineArray"),
      introducingSyntax: type
    )
  }
  // E.g., `[String: Int]` -> `Dictionary<String, Int>`
  fileprivate static func _dictionaryType(type: Attached<TypeSyntax>) -> TypeReference {
    TypeReference(
      module: Identifier(canonicalName: "Swift"),
      name: Identifier(canonicalName: "Dictionary"),
      introducingSyntax: type
    )
  }
}

/// Parses the given module and identifier originating from `typeSyntax`.
/// Otherwise, returns the appropriate failures.
private func _parseModuleAndIdentifier(
  moduleNameToken: TokenSyntax?,
  name: Identifier?,
  typeSyntax: Attached<TypeSyntax>
) -> Result<TypeReference, PartialTypeResolutionFailure> {
  switch (moduleNameToken.map({ Identifier(validating: $0) }), name) {
  // Valid cases are:
  // (a) no module, valid name
  case (nil, let name?):
    return .success(TypeReference(module: nil, name: name, introducingSyntax: typeSyntax))
  // (b) valid module, valid name
  case (let moduleName??, let name?):
    return .success(TypeReference(module: moduleName, name: name, introducingSyntax: typeSyntax))
  // Invalid cases
  // (c) invalid name/module
  case (_, nil), (nil?, _):
    return .failure(.invalidTypeIdentifier)
  }
}

// MARK: Partial Resolution

extension Attached where Node: TypeSyntaxProtocol {
  // We force unwrap because type resolution just visits a type syntax's children.
  fileprivate func _castChild<S: SyntaxProtocol>(_ syntax: S) -> Attached<S> {
    Attached<S>(syntax)!
  }

  @_spi(_QualifiedLookupTests)
  public func partiallyResolve() -> Result<PartiallyResolvedType, PartialTypeResolutionFailure> {
    switch TypeSyntax(node).as(TypeSyntaxEnum.self) {
    // Non-nominal base cases
    //
    // Functions
    case .functionType:
      return Result.failure(PartialTypeResolutionFailure.functionType)
    // Valid tuples (we treat single-element tuples as their only contained type below)
    case .tupleType(let tupleType):
      // Single-element tuples are just the type, e.g., the tuple type syntax
      // `(Int)` is just `Int`.
      // We diagnose single-element labels elsewhere
      if let soleTupleElement = tupleType.elements.first, tupleType.elements.count == 1 {
        // Forward resolution
        return _castChild(soleTupleElement.type).partiallyResolve()
      }

      // Get labels and collect identifier errors
      let labels: [Identifier?] = tupleType.elements.map({ label -> Identifier? in
        // Tuple elements get their labels from the first name.
        //
        // According to the ``TupleTypeSyntax`` docs, the first name is `nil` (implicitly no label),
        // `_` (explicitly no label), or an identifier (the label). So if the first name isn't a
        // valid identifier, the tuple has no label or the parser already diagnosed that.
        guard
          let labelToken = label.firstName,
          let label = Identifier(validating: labelToken)
        else { return nil }
        return label
      })
      // Add tuple type
      return Result.success(PartiallyResolvedType.tuple(labels: labels))
    // Metatypes
    case .metatypeType(let metatypeType):
      return Result.success(PartiallyResolvedType.metatype(base: _castChild(metatypeType.baseType)))

    // Nominal base cases
    case .identifierType(let identifierType):
      // According to the docs, `moduleSelector.moduleName` should be an identifier
      // and `name` is an identifier, `Self`, `Any` or `_`. Here's how we handle each:
      let moduleNameToken = identifierType.moduleSelector?.moduleName
      let name: Identifier?
      switch (identifierType.moduleSelector, identifierType.name.tokenKind) {
      // === Wildcard `_` ===
      // We can't do anything smart, so we defer to the type checker.
      case (_, .wildcard):
        return Result.failure(PartialTypeResolutionFailure.wildcardType)
      // === `Any` ===
      // Without a module selector, the keyword "Any" and the backtick-escaped
      // identifier "`Any`" are completely different in terms of lookup. Hence,
      // we treat the keyword "Any" like we do metatypes below by returning no
      // nominal results.
      //
      // However, if a module selector is specified, we treat it just like an
      // identifier.
      //
      // Here's an example where unqualified "`Any`" doesn't shadow `Any`:
      //   typealias `Any` = Int
      //   func g(a: Any) -> Int {
      //     a + 1 // ❌ cannot convert value of type 'Any' to expected argument type 'Int'
      //   }
      // And here's an example where unqualified "`Any`" doesn't resolve to `Any`:
      //   func g(a: `Any`) -> Int { // ❌ cannot find type 'Any' in scope
      //     a + 1
      //   }
      //
      // Here's an example where `MyModule::Any` acts like an identifier:
      //   func g(a: output::Any) -> Int {} // ❌ cannot find type 'output::Any' in scope
      case (nil, .keyword(.Any)):
        return Result.success(PartiallyResolvedType.anyType)
      case (_?, .keyword(.Any)):
        name = Identifier(canonicalName: "Any")
      // === `Self` ===
      // Basically the opposite of `Any`: Whether with or without a module
      // selector, we treat "Self" like the backtick-escaped identifier
      // "`Self`", because it participates in normal lookup. Hence, we
      // convert the "Self" keyword to an identifier.
      //
      // Here's an example where "`Self`" shadows
      // implicit "Self":
      //  typealias `Self` = Int
      //  func f(a: Self) -> Int { // This is the keyword "Self" not the backtick-escaped "`Self`"
      //    a + 1 // ✅
      //  }
      // And here's an example where "`Self`" resolves to implicit "Self":
      //  struct A {
      //    func f(x: inout `Self`) {
      //      x = A() // ✅
      //    }
      //  }
      //
      // Example with module selector:
      //   struct A {
      //     func f(_: MyModule::Self) {} // ✅
      //     func g(_: MyModule::`Self`) {} // ✅
      //   }
      // Note that `Self` has different module-selector lookup behavior than
      // other identifiers because typically `MyModule::MyType` issues a
      // top-level lookup so writing:
      //   struct A { struct B {}; func f(_: MyModule::B) }
      //  fails because `B` is nested within `A`.
      case (_, .keyword(.Self)):
        name = Identifier(canonicalName: "Self")
      default:
        name = Identifier(validating: identifierType.name)
      }

      // Parse the module name (if provided), and the type name
      let parsedResult = _parseModuleAndIdentifier(
        moduleNameToken: moduleNameToken,
        name: name,
        typeSyntax: _castChild(TypeSyntax(identifierType))
      )
      return parsedResult.map(PartiallyResolvedType.typeIdentifier)
    case .memberType(let memberType):
      // Resolve base type
      //
      // We use a new `baseTypes` array because we'll need to pass the base types
      // into the `.nominalMember` case.
      //
      // However, we pass the same `failures` array because failures record the
      // problematic type syntax so we can trace them back to source. Also, we
      // resolve the base type even if the `moduleName` and `typeName` below
      // are invalid to produce thorough and consistent diagnostics.
      // let baseTypes = memberType.baseType.partiallyResolve()

      // According to the ``MemberTypeSyntax`` docs, `name` is either an identifier
      // or the `self` keyword.
      //
      // Here's an example where "`self`" shadows implicit "self":
      //   struct A {
      //     typealias `self` = Int
      //
      //     func f(a: A.self) -> Int {
      //       a + 1 // ✅
      //     }
      //   }
      // And an example for "`self`" and "self" give identical results when
      // type lookup fails:
      //   let _: Int.`self` // ❌ error: 'self' is not a member type of struct 'output.A'
      //   let _: Int.self   // ❌ error: (same exact error)
      let moduleNameToken = memberType.moduleSelector?.moduleName
      let name: Identifier?
      if memberType.name.tokenKind == .keyword(.`self`) {
        name = Identifier(canonicalName: "self")
      } else {
        name = Identifier(validating: memberType.name)
      }

      // Parse the module name (if provided), and member-type name; then,
      // append to base types
      let parsedResult = _parseModuleAndIdentifier(
        moduleNameToken: moduleNameToken,
        name: name,
        typeSyntax: _castChild(TypeSyntax(memberType))
      )
      return parsedResult.map({
        PartiallyResolvedType.member(base: _castChild(memberType.baseType), memberComponent: $0)
      })

    // Base cases that don't produce types
    case .namedOpaqueReturnType, .classRestrictionType:
      return Result.success(PartiallyResolvedType.composition([]))
    case .suppressedType:
      // Don't diagnose here since suppressed types can be aliased, e.g.:
      //   typealias A = Escapable
      //   struct B: ~A {}
      return Result.success(PartiallyResolvedType.anyType)

    // Invalid base case
    case .missingType:
      return Result.failure(PartialTypeResolutionFailure.missingType)

    // Type-sugar is a nominal-type base case
    case .optionalType(let optionalType):
      return Result.success(
        PartiallyResolvedType.typeIdentifier(
          ._optionalType(type: _castChild(TypeSyntax(optionalType)))
        )
      )
    case .implicitlyUnwrappedOptionalType(let implicitlyUnwrappedOptionalType):
      return Result.success(
        PartiallyResolvedType.typeIdentifier(
          ._optionalType(type: _castChild(TypeSyntax(implicitlyUnwrappedOptionalType)))
        )
      )
    case .arrayType(let arrayType):
      return Result.success(
        PartiallyResolvedType.typeIdentifier(
          ._arrayType(type: _castChild(TypeSyntax(arrayType)))
        )
      )
    case .inlineArrayType(let inlineArrayType):
      return Result.success(
        PartiallyResolvedType.typeIdentifier(
          ._inlineArrayType(type: _castChild(TypeSyntax(inlineArrayType)))
        )
      )
    case .dictionaryType(let dictionaryType):
      return Result.success(
        PartiallyResolvedType.typeIdentifier(
          ._dictionaryType(type: _castChild(TypeSyntax(dictionaryType)))
        )
      )

    // Recursive cases
    case .attributedType(let attributedType):
      return _castChild(attributedType.baseType).partiallyResolve()
    case .someOrAnyType(let someOrAnyTypeType):
      return _castChild(someOrAnyTypeType.constraint).partiallyResolve()
    case .packElementType(let packElementType):
      // Same behavior as the compiler
      return _castChild(packElementType.pack).partiallyResolve()
    case .packExpansionType(let packExpansionType):
      return _castChild(packExpansionType.repetitionPattern).partiallyResolve()
    case .compositionType(let compositionType):
      return Result.success(
        PartiallyResolvedType.composition(
          compositionType.elements.map({ _castChild($0.type) })
        )
      )
    }
  }
}

// MARK: Debug

extension Result where Success: CustomDebugStringConvertible, Failure: CustomDebugStringConvertible {
  @_spi(_QualifiedLookupTests) public var _debugDescription: String {
    switch self {
    case .success(let success):
      return "success(\(success.debugDescription))"
    case .failure(let error):
      return "error(\(error.debugDescription))"
    }
  }
}

extension PartialTypeResolutionFailure: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
    case .functionType: return ".functionType"
    case .missingType: return ".missingType"
    case .unknownSuppressedType: return ".unknownSuppressedType"
    case .wildcardType: return ".wildcardType"
    case .invalidTypeIdentifier: return ".invalidTypeIdentifier"
    }
  }
}

extension PartiallyResolvedType: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
    case .anyType:
      return ".anyType"
    case .typeIdentifier(let component):
      return ".typeIdentifier(\(component.debugDescription))"
    case .tuple(let labels):
      return ".tuple([\(labels.map({ $0?.name ?? "nil" }).joined(separator: ", "))])"
    case .metatype(let base):
      return ".metatype(base: `\(base.trimmedDescription)`)"
    case .member(let base, let memberComponent):
      return ".member(base: `\(base.trimmedDescription)`, memberComponent: \(memberComponent.debugDescription))"
    case .composition(let children):
      return ".composition([\(children.map(\.trimmedDescription))])"
    }
  }
}
