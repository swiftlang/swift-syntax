//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftSyntax
import SwiftSyntaxBuilder
import SyntaxSupport

/// Wrapper around the syntax kind strings to provide functionality specific to
/// SwiftSyntaxBuilder. In particular, this includes the functionality to create
/// the `*Buildable`, `ExpressibleAs*` and `*Syntax` Swift types from the syntax
/// kind.
public struct SyntaxBuildableType: Hashable {
  public let syntaxKind: String
  public let tokenKind: String?
  public let isOptional: Bool

  /// Whether this is a token.
  public var isToken: Bool {
    syntaxKind == "Token"
  }

  /// This type with `isOptional` set to false.
  public var nonOptional: Self {
    tokenKind.map { Self(syntaxKind: $0) } ?? Self(syntaxKind: syntaxKind)
  }

  /// The token if this is a token.
  public var token: TokenSpec? {
    tokenKind.flatMap { SYNTAX_TOKEN_MAP[$0] }
  }

  /// If the type has a default value (because it is optional or a token
  /// with fixed test), return an expression of the form ` = defaultValue`
  /// that can be used as the default value for a function parameter.
  /// Otherwise, return the empty string.
  public var defaultInitialization: ExpressibleAsExprBuildable? {
    if isOptional {
      return NilLiteralExpr()
    } else if isToken {
      if let token = token, token.text != nil {
        return MemberAccessExpr(base: "Token", name: lowercaseFirstWord(name: token.name).backticked)
      } else if tokenKind == "EOFToken" {
        return MemberAccessExpr(base: "Token", name: "eof")
      }
    }
    return nil
  }

  /// Whether the type is a syntax collection.
  public var isSyntaxCollection: Bool {
    syntaxKind == "SyntaxCollection"
      || (baseType.map(\.isSyntaxCollection) ?? false)
  }

  /// The raw base name of this kind. Used for the `build*` methods in the
  /// defined in the buildable types.
  public var baseName: String {
    syntaxKind
  }

  /// Return the `Buildable` type that is the main entry point for building
  /// SwiftSyntax trees using `SwiftSyntaxBuilder`.
  ///
  /// These names look as follows:
  ///  - For nodes: The node name, e.g. `IdentifierExpr` (these are implemented as structs)
  ///  - For base kinds: `<BaseKind>Buildable`, e.g. `ExprBuildable` (these are implemented as protocols)
  ///  - For token: `TokenSyntax` (tokens don't have a dedicated type in SwiftSyntaxBuilder)
  /// If the type is optional, the type is wrapped in an `OptionalType`.
  public var buildable: TypeBuildable {
    optionalWrapped(type: buildableBaseName).createTypeBuildable()
  }

  /// Whether parameters of this type should be initializable by a result builder.
  /// Used for certain syntax collections and block-like structures (e.g. `CodeBlock`,
  /// `MemberDeclList`).
  public var isBuilderInitializable: Bool {
    BUILDER_INITIALIZABLE_TYPES.keys.contains(buildableBaseName)
  }

  /// A type suitable for initializing this type through a result builder (e.g.
  /// returns `CodeBlockItemList` for `CodeBlock`) and otherwise itself.
  public var builderInitializableType: Self {
    Self(
      syntaxKind: BUILDER_INITIALIZABLE_TYPES[buildableBaseName].flatMap { $0 } ?? buildableBaseName,
      isOptional: isOptional
    )
  }

  /// The type from `buildable()` without any question marks attached.
  /// This is used for the `create*` methods defined in the `ExpressibleAs*` protocols.
  public var buildableBaseName: String {
    if SYNTAX_BASE_KINDS.contains(syntaxKind) {
      return "\(syntaxKind)Buildable"
    } else {
      return syntaxKind
    }
  }

  /// The `ExpressibleAs*` Swift type for this syntax kind without any
  /// question marks attached.
  public var expressibleAsBaseName: String {
    if isToken {
      // Tokens don't have a dedicated ExpressibleAs type.
      return buildableBaseName
    } else {
      return "ExpressibleAs\(buildableBaseName)"
    }
  }

  /// The `ExpressibleAs*` Swift type for this syntax kind. Tokens don't
  /// have an `ExpressibleAs*` type, so for those this method just returns
  /// `TokenSyntax`. If the type is optional, this terminates with a `?`.
  public var expressibleAs: TypeBuildable {
    optionalWrapped(type: expressibleAsBaseName)
  }

  /// The corresponding `*Syntax` type defined in the `SwiftSyntax` module,
  /// without any question marks attached.
  public var syntaxBaseName: String {
    if syntaxKind == "Syntax" {
      return "Syntax"
    } else {
      return "\(syntaxKind)Syntax"
    }
  }

  /// The corresponding `*Syntax` type defined in the `SwiftSyntax` module,
  /// which will eventually get built from `SwiftSyntaxBuilder`. If the type
  /// is optional, this terminates with a `?`.
  public var syntax: TypeBuildable {
    optionalWrapped(type: syntaxBaseName)
  }

  /// Assuming that this is a base kind, return the corresponding `*ListBuildable` type
  /// without any question marks attached.
  public var listBuildableBaseName: String {
    assert(SYNTAX_BASE_KINDS.contains(syntaxKind), "ListBuildable types only exist for syntax base kinds")
    return "\(syntaxKind)ListBuildable"
  }

  /// Assuming that this is a base kind, return the corresponding `*ListBuildable` type.
  public var listBuildable: TypeBuildable {
    optionalWrapped(type: listBuildableBaseName)
  }

  /// Assuming that this is a collection type, the non-optional type of the result builder
  /// that can be used to build the collection.
  public var resultBuilderBaseName: String {
    "\(syntaxKind)Builder"
  }

  /// Assuming that this is a collection type, the type of the result builder
  /// that can be used to build the collection.
  public var resultBuilder: ExpressibleAsTypeBuildable {
    optionalWrapped(type: resultBuilderBaseName)
  }

  /// The collection types in which this type occurs as an element.
  /// We automatically make the `ExpressibleAs*` protocols conform to the
  /// `ExpressibleAs*` protocol of the collection they occur in.
  public var elementInCollections: [Self] {
    SYNTAX_NODES
      .filter { $0.isSyntaxCollection && $0.collectionElementType == self }
      .map { $0.type }
  }

  /// Whether this type has the `WithTrailingComma` trait.
  public var hasWithTrailingCommaTrait: Bool {
    SYNTAX_NODES.contains { $0.type == self && $0.traits.contains("WithTrailingComma") }
  }

  /// Types that take a single non-optional parameter of this types
  /// and to which this type is thus convertible. We automatically
  /// make the `ExpressibleAs*` of this type conform to the `ExpressibleAs*`
  /// protocol of the convertible types.
  public var convertibleToTypes: [Self] {
    (SYNTAX_BUILDABLE_EXPRESSIBLE_AS_CONFORMANCES[buildableBaseName] ?? [])
      .map { Self(syntaxKind: $0) }
  }

  /// If this type is not a base kind, its base type (see `SyntaxBuildableNode.base_type()`),
  /// otherwise `nil`.
  public var baseType: Self? {
    if !SYNTAX_BASE_KINDS.contains(syntaxKind) && !isToken {
      return Node.from(type: self).baseType
    } else {
      return nil
    }
  }

  /// The types to which this `ExpressibleAs*` type conforms to via
  /// automatically generated conformances.
  public var generatedExpressibleAsConformances: [Self] {
    var conformances = elementInCollections + convertibleToTypes
    if let baseType = baseType, baseType.baseName != "SyntaxCollection" {
      conformances.append(baseType)
    }
    return conformances
  }

  /// The types to which this `ExpressibleAs*` type conforms to via
  /// automatically generated conformances, including transitive conformances.
  public var transitiveExpressibleAsConformances: [Self] {
    generatedExpressibleAsConformances.flatMap { conformance in
      [conformance] + conformance.transitiveExpressibleAsConformances
    }
  }

  /// The types to which this `ExpressibleAs*` type implicitly conforms
  /// to via transitive conformances. These conformances don't need to be
  /// spelled out explicitly in the source code.
  public var impliedExpressibleAsConformances: [Self] {
    generatedExpressibleAsConformances.flatMap { conformance in
      conformance.transitiveExpressibleAsConformances
    }
  }

  public init(syntaxKind: String, isOptional: Bool = false) {
    self.isOptional = isOptional
    if syntaxKind.hasSuffix("Token") {
      // There are different token kinds but all of them are represented by `Token` in the Swift source (see `kind_to_type` in `gyb_syntax_support`).
      self.syntaxKind = "Token"
      self.tokenKind = syntaxKind
    } else {
      self.syntaxKind = syntaxKind
      self.tokenKind = nil
    }
  }

  /// Wraps a type in an optional depending on whether `isOptional` is true.
  public func optionalWrapped(type: ExpressibleAsTypeBuildable) -> TypeBuildable {
    if isOptional {
      return OptionalType(wrappedType: type)
    } else {
      return type.createTypeBuildable()
    }
  }

  /// Wraps a type in an optional chaining depending on whether `isOptional` is true.
  public func optionalChained(expr: ExpressibleAsExprBuildable) -> ExpressibleAsExprBuildable {
    if isOptional {
      return OptionalChainingExpr(expression: expr)
    } else {
      return expr
    }
  }

  /// Wraps a type in a force unwrap expression depending on whether `isOptional` is true.
  public func forceUnwrappedIfNeeded(expr: ExpressibleAsExprBuildable) -> ExpressibleAsExprBuildable {
    if isOptional {
      return ForcedValueExpr(expression: expr)
    } else {
      return expr
    }
  }

  /// Generate an expression that converts a variable named `varName`
  /// which is of `expressibleAs` type to an object of type `buildable`.
  public func generateExprConvertParamTypeToStorageType(varName: String) -> ExpressibleAsExprBuildable {
    if isToken {
      return varName
    } else {
      return FunctionCallExpr(calledExpression: MemberAccessExpr(base: optionalChained(expr: varName), name: "create\(buildableBaseName)"))
    }
  }
}
