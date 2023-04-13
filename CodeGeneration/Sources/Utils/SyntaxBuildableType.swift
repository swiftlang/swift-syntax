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

  public init(syntaxKind: String, isOptional: Bool = false) {
    self.isOptional = isOptional
    if syntaxKind.hasSuffix("Token") {
      // There are different token kinds but all of them are represented by `Token` in the Swift source (see `kindToType` in `SyntaxSupport/Utils.swift`).
      self.syntaxKind = "Token"
      self.tokenKind = syntaxKind
    } else {
      self.syntaxKind = syntaxKind
      self.tokenKind = nil
    }
  }

  /// Whether this is a token.
  public var isToken: Bool {
    syntaxKind == "Token"
  }

  /// The token if this is a token.
  public var token: TokenSpec? {
    tokenKind.flatMap { SYNTAX_TOKEN_MAP[$0] }
  }

  public var isBaseType: Bool {
    return SYNTAX_BASE_KINDS.contains(syntaxKind)
  }

  /// If the type has a default value (because it is optional or a token
  /// with fixed test), return an expression that can be used as the
  /// default value for a function parameter. Otherwise, return `nil`.
  public var defaultValue: ExprSyntax? {
    if isOptional {
      return ExprSyntax(NilLiteralExprSyntax())
    } else if let token = token {
      if token.isKeyword {
        return ExprSyntax(".\(raw: token.swiftKind)()")
      } else if token.text != nil {
        return ExprSyntax(".\(raw: lowercaseFirstWord(name: token.name))Token()")
      }
    } else if tokenKind == "EOFToken" {
      return ExprSyntax(".eof()")
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
  public var buildable: TypeSyntax {
    optionalWrapped(type: SimpleTypeIdentifierSyntax(name: .identifier(syntaxBaseName)))
  }

  /// Whether parameters of this type should be initializable by a result builder.
  /// Used for certain syntax collections and block-like structures (e.g. `CodeBlock`,
  /// `MemberDeclList`).
  public var isBuilderInitializable: Bool {
    BUILDER_INITIALIZABLE_TYPES.keys.contains(syntaxKind)
  }

  /// A type suitable for initializing this type through a result builder (e.g.
  /// returns `CodeBlockItemList` for `CodeBlock`) and otherwise itself.
  public var builderInitializableType: Self {
    Self(
      syntaxKind: BUILDER_INITIALIZABLE_TYPES[syntaxKind].flatMap { $0 } ?? syntaxKind,
      isOptional: isOptional
    )
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
  public var syntax: TypeSyntax {
    return optionalWrapped(type: SimpleTypeIdentifierSyntax(name: .identifier(syntaxBaseName)))
  }

  /// The type that is used for paramters in SwiftSyntaxBuilder that take this
  /// type of syntax node.
  public var parameterBaseType: String {
    if isBaseType {
      return "\(syntaxBaseName)Protocol"
    } else {
      return syntaxBaseName
    }
  }

  public var parameterType: TypeSyntax {
    return optionalWrapped(type: SimpleTypeIdentifierSyntax(name: .identifier(parameterBaseType)))
  }

  /// Assuming that this is a collection type, the non-optional type of the result builder
  /// that can be used to build the collection.
  public var resultBuilderBaseName: String {
    "\(syntaxKind)Builder"
  }

  /// Whether this type has the `WithTrailingComma` trait.
  public var hasWithTrailingCommaTrait: Bool {
    SYNTAX_NODES.contains { $0.type == self && $0.traits.contains("WithTrailingComma") }
  }

  /// If this type is not a base kind, its base type (see `SyntaxBuildableNode.base_type()`),
  /// otherwise `nil`.
  public var baseType: Self? {
    if !isBaseType && !isToken {
      return Node.from(type: self).baseType
    } else {
      return nil
    }
  }

  /// Wraps a type in an optional depending on whether `isOptional` is true.
  public func optionalWrapped<TypeNode: TypeSyntaxProtocol>(type: TypeNode) -> TypeSyntax {
    if isOptional {
      return TypeSyntax(OptionalTypeSyntax(wrappedType: type))
    } else {
      return TypeSyntax(type)
    }
  }

  /// Wraps a type in an optional chaining depending on whether `isOptional` is true.
  public func optionalChained<ExprNode: ExprSyntaxProtocol>(expr: ExprNode) -> ExprSyntax {
    if isOptional {
      return ExprSyntax(OptionalChainingExprSyntax(expression: expr))
    } else {
      return ExprSyntax(expr)
    }
  }

  /// Wraps a type in a force unwrap expression depending on whether `isOptional` is true.
  public func forceUnwrappedIfNeeded<ExprNode: ExprSyntaxProtocol>(expr: ExprNode) -> ExprSyntax {
    if isOptional {
      return ExprSyntax(ForcedValueExprSyntax(expression: expr))
    } else {
      return ExprSyntax(expr)
    }
  }
}
