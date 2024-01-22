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

/// The kind of token a node can contain. Either a token of a specific kind or a
/// keyword with the given text.
public enum TokenChoice: Equatable {
  case keyword(Keyword)
  case token(Token)

  public var isKeyword: Bool {
    switch self {
    case .keyword: return true
    case .token: return false
    }
  }

  public var varOrCaseName: TokenSyntax {
    switch self {
    case .keyword(let keyword):
      return keyword.spec.varOrCaseName
    case .token(let token):
      return token.spec.varOrCaseName
    }
  }
}

public enum ChildKind {
  /// The child always contains a node of the given `kind`.
  case node(kind: SyntaxNodeKind)
  /// The child always contains a node that matches one of the `choices`.
  case nodeChoices(choices: [Child])
  /// The child is a collection of `kind`.
  case collection(kind: SyntaxNodeKind, collectionElementName: String, defaultsToEmpty: Bool = false, deprecatedCollectionElementName: String? = nil)
  /// The child is a token that matches one of the given `choices`.
  /// If `requiresLeadingSpace` or `requiresTrailingSpace` is not `nil`, it
  /// overrides the default leading/trailing space behavior of the token.
  case token(choices: [TokenChoice], requiresLeadingSpace: Bool? = nil, requiresTrailingSpace: Bool? = nil)

  public var isNodeChoices: Bool {
    if case .nodeChoices = self {
      return true
    } else {
      return false
    }
  }

  public var isToken: Bool {
    if case .token = self {
      return true
    } else {
      return false
    }
  }

  public var isNodeChoicesEmpty: Bool {
    if case .nodeChoices(let nodeChoices) = self {
      return nodeChoices.isEmpty
    } else {
      return true
    }
  }
}

/// A child of a node, that may be declared optional or a token with a
/// restricted subset of acceptable kinds or texts.
public class Child {
  /// The name of the child.
  ///
  /// The first character of the name is always uppercase.
  public let name: String

  /// If the child has been renamed, its old, now deprecated, name.
  ///
  /// This is used to generate deprecated compatibility layers.
  public let deprecatedName: String?

  /// The kind of the child (node, token, collection, ...)
  public let kind: ChildKind

  /// Whether this child is optional and can be `nil`.
  public let isOptional: Bool

  /// The experimental feature the child represents, or `nil` if this isn't
  /// for an experimental feature.
  public let experimentalFeature: ExperimentalFeature?

  /// A name of this child that can be shown in diagnostics.
  ///
  /// This is used to e.g. describe the child if all of its tokens are missing in the source file.
  public let nameForDiagnostics: String?

  /// A summary of a doc comment describing the child. Full docc comment for the
  /// child is available in ``Child/documentation``, and includes detailed list
  /// of possible choices for the child if it's a token kind.
  public let documentationSummary: SwiftSyntax.Trivia

  /// A docc comment describing the child, including the trivia provided when
  /// initializing the ``Child``, and the list of possible token choices inferred automatically.
  public var documentation: SwiftSyntax.Trivia {
    if case .token(let choices, _, _) = kind {
      let tokenChoicesTrivia = SwiftSyntax.Trivia.docCommentTrivia(
        from: GrammarGenerator.childTokenChoices(for: choices)
      )

      return SwiftSyntax.Trivia(joining: [documentationSummary, tokenChoicesTrivia])
    }

    // If this child is not a token kind, return documentation summary without the choices list.
    return documentationSummary
  }

  /// The first line of the child's documentation
  public let documentationAbstract: String

  /// If `true`, this is for an experimental language feature, and any public
  /// API generated should be SPI.
  public var isExperimental: Bool { experimentalFeature != nil }

  public var syntaxNodeKind: SyntaxNodeKind {
    switch kind {
    case .node(kind: let kind):
      return kind
    case .nodeChoices:
      return .syntax
    case .collection(kind: let kind, _, _, _):
      return kind
    case .token:
      return .token
    }
  }

  /// A name of this child that's suitable to be used for variable or enum case names.
  public var varOrCaseName: TokenSyntax {
    return .identifier(lowercaseFirstWord(name: name))
  }

  /// If this child has node choices, the type that the nested `SyntaxChildChoices` type should get.
  ///
  /// For any other kind of child nodes, accessing this property crashes.
  public var syntaxChoicesType: TypeSyntax {
    precondition(kind.isNodeChoices, "Cannot get `syntaxChoicesType` for node that doesn’t have nodeChoices")
    return "\(raw: name.withFirstCharacterUppercased)"
  }

  /// If this child only has tokens, the type that the generated `TokenSpecSet` should get.
  ///
  /// For any other kind of child nodes, accessing this property crashes.
  public var tokenSpecSetType: TypeSyntax {
    precondition(kind.isToken, "Cannot get `tokenSpecSetType` for node that isn’t a token")
    return "\(raw: name.withFirstCharacterUppercased)Options"
  }

  /// The deprecated name of this child that's suitable to be used for variable or enum case names.
  public var deprecatedVarName: TokenSyntax? {
    guard let deprecatedName = deprecatedName else {
      return nil
    }
    return .identifier(lowercaseFirstWord(name: deprecatedName))
  }

  /// Determines if this child has a deprecated name
  public var hasDeprecatedName: Bool {
    return deprecatedName != nil
  }

  /// If the child ends with "token" in the kind, it's considered a token node.
  /// Grab the existing reference to that token from the global list.
  public var tokenKind: Token? {
    switch kind {
    case .token(let choices, _, _):
      if choices.count == 1 {
        switch choices.first! {
        case .keyword: return .keyword
        case .token(let token): return token
        }
      } else if choices.allSatisfy(\.isKeyword) {
        return .keyword
      } else {
        /*
       FIXME: Technically, returning `.unknown` is not correct here.
       The old string-based implementation returned "Token" to ensure that `tokenKind` is not nil
       and that `isToken` computed-property will return true, but the value "Token" had never been
       used in other cases. We should try to remove this computed property altogether in the issue:
       https://github.com/apple/swift-syntax/issues/2010
       */
        return .unknown
      }
    default:
      return nil
    }
  }

  /// Returns `true` if this child has a token kind.
  public var isToken: Bool {
    tokenKind != nil
  }

  public var token: TokenSpec? {
    tokenKind?.spec
  }

  /// Whether this child has syntax kind `UnexpectedNodes`.
  public var isUnexpectedNodes: Bool {
    switch kind {
    case .collection(kind: .unexpectedNodes, _, _, _):
      return true
    default:
      return false
    }
  }

  /// Returns `true` if this child's type is one of the base syntax kinds and
  /// it has no node choices.
  public var hasBaseType: Bool {
    switch kind {
    case .nodeChoices(let choices):
      return choices.isEmpty
    case .node(let kind):
      return kind.isBase
    case .collection(kind: let kind, _, _, _):
      return kind.isBase
    case .token:
      return false
    }
  }

  /// The attributes that should be printed on any API for the this child.
  ///
  /// This is typically used to mark APIs as SPI when the keyword is part of
  /// an experimental language feature.
  public var apiAttributes: AttributeListSyntax {
    guard isExperimental else { return "" }
    return AttributeListSyntax("@_spi(ExperimentalLanguageFeatures)").with(\.trailingTrivia, .newline)
  }

  /// If a classification is passed, it specifies the color identifiers in
  /// that subtree should inherit for syntax coloring. Must be a member of
  /// ``SyntaxClassification``.
  /// If `forceClassification` is also set to true, all child nodes (not only
  /// identifiers) inherit the syntax classification.
  init(
    name: String,
    deprecatedName: String? = nil,
    kind: ChildKind,
    experimentalFeature: ExperimentalFeature? = nil,
    nameForDiagnostics: String? = nil,
    documentation: String? = nil,
    isOptional: Bool = false
  ) {
    precondition(name.first?.isLowercase ?? true, "The first letter of a child’s name should be lowercase")
    precondition(deprecatedName?.first?.isLowercase ?? true, "The first letter of a child’s deprecatedName should be lowercase")
    self.name = name
    self.deprecatedName = deprecatedName
    self.kind = kind
    self.experimentalFeature = experimentalFeature
    self.nameForDiagnostics = nameForDiagnostics
    self.documentationSummary = SwiftSyntax.Trivia.docCommentTrivia(from: documentation)
    self.documentationAbstract = String(documentation?.split(whereSeparator: \.isNewline).first ?? "")
    self.isOptional = isOptional
  }
}
