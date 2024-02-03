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
  public let kind: SyntaxOrTokenNodeKind
  public let isOptional: Bool

  public init(kind: SyntaxOrTokenNodeKind, isOptional: Bool = false) {
    self.isOptional = isOptional
    self.kind = kind
  }

  /// Whether this is a token.
  public var isToken: Bool {
    switch kind {
    case .token:
      return true
    default:
      return false
    }
  }

  /// The token if this is a token.
  public var token: TokenSpec? {
    switch kind {
    case .token(let token):
      return token.spec
    default:
      return nil
    }
  }

  public var isBaseType: Bool {
    switch kind {
    case .node(let kind):
      return kind.isBase
    default:
      return false
    }
  }

  /// If the type has a default value (because it is optional or a token
  /// with fixed test), return an expression that can be used as the
  /// default value for a function parameter. Otherwise, return `nil`.
  public var defaultValue: ExprSyntax? {
    if isOptional {
      return ExprSyntax(NilLiteralExprSyntax())
    } else if let token = token {
      if token.text != nil {
        return ExprSyntax(".\(token.varOrCaseName)Token()")
      }
    }
    return nil
  }

  /// Whether the type is a syntax collection.
  public var isSyntaxCollection: Bool {
    kind == .node(kind: .syntaxCollection)
      || (baseType.map(\.isSyntaxCollection) ?? false)
  }

  /// Return the `Buildable` type that is the main entry point for building
  /// SwiftSyntax trees using `SwiftSyntaxBuilder`.
  ///
  /// These names look as follows:
  ///  - For nodes: The node name, e.g. `IdentifierExpr` (these are implemented as structs)
  ///  - For base kinds: `<BaseKind>Buildable`, e.g. `ExprBuildable` (these are implemented as protocols)
  ///  - For token: ``TokenSyntax`` (tokens don't have a dedicated type in SwiftSyntaxBuilder)
  /// If the type is optional, the type is wrapped in an `OptionalType`.
  public var buildable: TypeSyntax {
    optionalWrapped(type: syntaxBaseName)
  }

  /// Whether parameters of this type should be initializable by a result builder.
  /// Used for certain syntax collections and block-like structures (e.g. `CodeBlock`,
  /// `MemberDeclList`).
  public var isBuilderInitializable: Bool {
    switch kind {
    case .node(let kind):
      return BUILDER_INITIALIZABLE_TYPES.keys.contains(kind)
    case .token:
      return false
    }
  }

  /// A type suitable for initializing this type through a result builder (e.g.
  /// returns `CodeBlockItemList` for `CodeBlock`) and otherwise itself.
  public var builderInitializableType: Self {
    switch kind {
    case .node(let kind):
      if case .some(.some(let builderInitializableType)) = BUILDER_INITIALIZABLE_TYPES[kind] {
        return Self(
          kind: .node(kind: builderInitializableType),
          isOptional: isOptional
        )
      } else {
        return self
      }
    case .token:
      return self
    }
  }

  /// The corresponding `*Syntax` type defined in the `SwiftSyntax` module,
  /// without any question marks attached.
  public var syntaxBaseName: TypeSyntax {
    switch kind {
    case .node(kind: let kind):
      return kind.syntaxType
    case .token:
      return "TokenSyntax"
    }
  }

  /// The corresponding `*Syntax` type defined in the `SwiftSyntax` module,
  /// which will eventually get built from `SwiftSyntaxBuilder`. If the type
  /// is optional, this terminates with a `?`.
  public var syntax: TypeSyntax {
    return optionalWrapped(type: syntaxBaseName)
  }

  /// The type that is used for parameters in SwiftSyntaxBuilder that take this
  /// type of syntax node.
  public var parameterBaseType: TypeSyntax {
    if isBaseType {
      return "\(syntaxBaseName)Protocol"
    } else {
      return syntaxBaseName
    }
  }

  /// Assuming that this is a collection type, the non-optional type of the result builder
  /// that can be used to build the collection.
  public var resultBuilderType: TypeSyntax {
    switch kind {
    case .node(kind: let kind):
      return TypeSyntax("\(raw: kind.rawValue.withFirstCharacterUppercased)Builder")
    case .token:
      preconditionFailure("Tokens cannot be constructed using result builders")
    }
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
  public func optionalWrapped(type: some TypeSyntaxProtocol) -> TypeSyntax {
    if isOptional {
      return TypeSyntax(OptionalTypeSyntax(wrappedType: type))
    } else {
      return TypeSyntax(type)
    }
  }

  /// Wraps a type in an optional chaining depending on whether `isOptional` is true.
  public func optionalChained(expr: some ExprSyntaxProtocol) -> ExprSyntax {
    if isOptional {
      return ExprSyntax(OptionalChainingExprSyntax(expression: expr))
    } else {
      return ExprSyntax(expr)
    }
  }

  /// Wraps a type in a force unwrap expression depending on whether `isOptional` is true.
  public func forceUnwrappedIfNeeded(expr: some ExprSyntaxProtocol) -> ExprSyntax {
    if isOptional {
      return ExprSyntax(ForceUnwrapExprSyntax(expression: expr))
    } else {
      return ExprSyntax(expr)
    }
  }
}
