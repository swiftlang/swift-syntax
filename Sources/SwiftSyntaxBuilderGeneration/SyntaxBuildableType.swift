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

/// Wrapper around the syntax kind strings to provide functionality specific to
/// SwiftSyntaxBuilder. In particular, this includes the functionality to create
/// the `*Buildable`, `ExpressibleAs*` and `*Syntax` Swift types from the syntax
/// kind.
struct SyntaxBuildableType: Hashable {
  let syntaxKind: String
  let tokenKind: String?
  let isOptional: Bool

  /// If optional `?`, otherwise the empty string.
  var optionalQuestionMark: String {
    isOptional ? "?" : ""
  }

  /// Whether this is a token.
  var isToken: Bool {
    syntaxKind == "Token"
  }

  /// This type with `isOptional` set to false.
  var nonOptional: Self {
    tokenKind.map { Self(syntaxKind: $0) } ?? Self(syntaxKind: syntaxKind)
  }

  /// The token if this is a token.
  var token: Token? {
    tokenKind.flatMap { SYNTAX_TOKEN_MAP[$0] }
  }

  /// If the type has a default value (because it is optional or a token
  /// with fixed test), return an expression of the form ` = defaultValue`
  /// that can be used as the default value for a function parameter.
  /// Otherwise, return the empty string.
  var defaultInitialization: String {
    if isOptional {
      return " = nil"
    } else if isToken {
      if let token = token, token.text != nil {
        return " = TokenSyntax.`\(lowercaseFirstWord(name: token.name))`"
      } else if tokenKind == "EOFToken" {
        return " = TokenSyntax.eof"
      }
    }
    return ""
  }

  /// Whether the type is a syntax collection.
  var isSyntaxCollection: Bool {
    syntaxKind == "SyntaxCollection"
      || (baseType.map(\.isSyntaxCollection) ?? false)
  }

  /// The raw base name of this kind. Used for the `build*` methods in the
  /// defined in the buildable types.
  var baseName: String {
    syntaxKind
  }

  /// Return the name of the `Buildable` type that is the main entry point for building
  /// SwiftSyntax trees using `SwiftSyntaxBuilder`.
  ///
  /// These names look as follows:
  ///  - For nodes: The node name, e.g. `IdentifierExpr` (these are implemented as structs)
  ///  - For base kinds: `<BaseKind>Buildable`, e.g. `ExprBuildable` (these are implemented as protocols)
  ///  - For token: `TokenSyntax` (tokens don't have a dedicated type in SwiftSyntaxBuilder)
  /// If the type is optional, this terminates with a '?'.
  var buildable: String {
    if isToken {
      // Tokens don't have a dedicated buildable type.
      return "TokenSyntax\(optionalQuestionMark)"
    } else if SYNTAX_BASE_KINDS.contains(syntaxKind) {
      return "\(syntaxKind)Buildable\(optionalQuestionMark)"
    } else {
      return "\(syntaxKind)\(optionalQuestionMark)"
    }
  }

  /// Whether parameters of this type should be initializable by a result builder.
  /// Used for certain syntax collections and block-like structures (e.g. `CodeBlock`,
  /// `MemberDeclList`).
  var isBuilderInitializable: Bool {
    BUILDER_INITIALIZABLE_TYPES.keys.contains(nonOptional.buildable)
  }

  /// A type suitable for initializing this type through a result builder (e.g.
  /// returns `CodeBlockItemList` for `CodeBlock`) and otherwise itself.
  var builderInitializableType: Self {
    let buildable = nonOptional.buildable
    return Self(
      syntaxKind: BUILDER_INITIALIZABLE_TYPES[buildable].flatMap { $0 } ?? buildable,
      isOptional: isOptional
    )
  }

  /// The type from `buildable()` without any question marks attached.
  /// This is used for the `create*` methods defined in the `ExpressibleAs*` protocols.
  var buildableBaseName: String {
    nonOptional.buildable
  }

  /// The `ExpressibleAs*` Swift type for this syntax kind. Tokens don't
  /// have an `ExpressibleAs*` type, so for those this method just returns
  /// `TokenSyntax`. If the type is optional, this terminates with a `?`.
  var expressibleAs: String {
    if isToken {
      // Tokens don't have a dedicated ExpressibleAs type.
      return buildable
    } else {
      return "ExpressibleAs\(buildable)"
    }
  }

  /// The corresponding `*Syntax` type defined in the `SwiftSyntax` module,
  /// which will eventually get built from `SwiftSyntaxBuilder`. If the type
  /// is optional, this terminates with a `?`.
  var syntax: String {
    if syntaxKind == "Syntax" {
      return "Syntax\(optionalQuestionMark)"
    } else {
      return "\(syntaxKind)Syntax\(optionalQuestionMark)"
    }
  }

  /// Assuming that this is a base kind, return the corresponding `*ListBuildable` type.
  var listBuildable: String {
    assert(SYNTAX_BASE_KINDS.contains(syntaxKind), "ListBuildable types only exist for syntax base kinds")
    return "\(syntaxKind)ListBuildable\(optionalQuestionMark)"
  }

  /// Assuming that this is a collection type, the type of the result builder
  /// that can be used to build the collection.
  var resultBuilder: String {
    "\(syntaxKind)Builder\(optionalQuestionMark)"
  }

  /// The collection types in which this type occurs as an element.
  /// We automatically make the `ExpressibleAs*` protocols conform to the
  /// `ExpressibleAs*` protocol of the collection they occur in.
  var elementInCollections: [Self] {
    SYNTAX_NODES
      .filter { $0.isSyntaxCollection && $0.collectionElementType == self }
      .map { $0.type }
  }

  /// Whether this type has the `WithTrailingComma` trait.
  var hasWithTrailingCommaTrait: Bool {
    SYNTAX_NODES.contains { $0.type == self && $0.traits.contains("WithTrailingComma") }
  }

  /// Types that take a single non-optional parameter of this types
  /// and to which this type is thus convertible. We automatically
  /// make the `ExpressibleAs*` of this type conform to the `ExpressibleAs*`
  /// protocol of the convertible types.
  var convertibleToTypes: [Self] {
    (SYNTAX_BUILDABLE_EXPRESSIBLE_AS_CONFORMANCES[buildable] ?? [])
      .map { Self(syntaxKind: $0) }
  }

  /// If this type is not a base kind, its base type (see `SyntaxBuildableNode.base_type()`),
  /// otherwise `nil`.
  var baseType: Self? {
    if !SYNTAX_BASE_KINDS.contains(syntaxKind) && !isToken {
      return Node.from(type: self).baseType
    } else {
      return nil
    }
  }

  /// The types to which this `ExpressibleAs*` type conforms to via
  /// automatically generated conformances.
  var generatedExpressibleAsConformances: [Self] {
    var conformances = elementInCollections + convertibleToTypes
    if let baseType = baseType, baseType.baseName != "SyntaxCollection" {
      conformances.append(baseType)
    }
    return conformances
  }

  /// The types to which this `ExpressibleAs*` type conforms to via
  /// automatically generated conformances, including transitive conformances.
  var transitiveExpressibleAsConformances: [Self] {
    generatedExpressibleAsConformances.flatMap { conformance in
      [conformance] + conformance.transitiveExpressibleAsConformances
    }
  }

  /// The types to which this `ExpressibleAs*` type implicitly conforms
  /// to via transitive conformances. These conformances don't need to be
  /// spelled out explicitly in the source code.
  var impliedExpressibleAsConformances: [Self] {
    generatedExpressibleAsConformances.flatMap { conformance in
      conformance.transitiveExpressibleAsConformances
    }
  }

  init(syntaxKind: String, isOptional: Bool = false) {
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

  /// Generate an expression that converts a variable named `varName`
  /// which is of `expressibleAs` type to an object of type `buildable`.
  func generateExprConvertParamTypeToStorageType(varName: String) -> String {
    if isToken {
      return varName
    } else {
      return "\(varName)\(optionalQuestionMark).create\(buildableBaseName)()"
    }
  }
}
