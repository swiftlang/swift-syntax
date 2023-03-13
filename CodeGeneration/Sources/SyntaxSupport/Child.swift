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

/// The kind of token a node can contain. Either a token of a specific kind or a
/// keyword with the given text.
public enum TokenChoice {
  case keyword(text: String)
  case token(tokenKind: String)

  public var isKeyword: Bool {
    switch self {
    case .keyword: return true
    case .token: return false
    }
  }
}

public enum ChildKind {
  /// The child always contains a node of the given `kind`.
  case node(kind: String)
  /// The child always contains a node that matches one of the `choices`.
  case nodeChoices(choices: [Child])
  /// The child is a collection of `kind`.
  case collection(kind: String, collectionElementName: String)
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
  public let name: String
  public let kind: ChildKind
  public let nameForDiagnostics: String?
  public let description: String?
  public let forceClassification: Bool
  public let isIndented: Bool
  public let requiresLeadingNewline: Bool
  public let isOptional: Bool
  public let classification: SyntaxClassification?

  public var swiftName: String {
    return lowercaseFirstWord(name: name)
  }

  public var syntaxKind: String {
    switch kind {
    case .node(kind: let kind):
      return kind
    case .nodeChoices:
      return "Syntax"
    case .collection(kind: let kind, collectionElementName: _):
      return kind
    case .token(choices: let choices, requiresLeadingSpace: _, requiresTrailingSpace: _):
      if choices.count == 1 {
        switch choices.first! {
        case .keyword: return "KeywordToken"
        case .token(tokenKind: let tokenKind): return tokenKind
        }
      } else {
        if choices.allSatisfy({ $0.isKeyword }) {
          return "KeywordToken"
        } else {
          return "Token"
        }
      }
    }
  }

  public var swiftSyntaxKind: String {
    return lowercaseFirstWord(name: syntaxKind)
  }

  public var typeName: String {
    return kindToType(kind: syntaxKind)
  }

  /// If the child ends with "token" in the kind, it's considered a token node. Grab the existing reference to that token from the global list.
  public var tokenKind: String? {
    if syntaxKind.hasSuffix("Token") {
      return syntaxKind
    } else {
      return nil
    }
  }

  /// Returns `true` if this child has a token kind.
  public var isToken: Bool {
    return tokenKind != nil
  }

  public var token: TokenSpec? {
    guard let tokenKind = tokenKind else { return nil }
    return SYNTAX_TOKEN_MAP[tokenKind]
  }

  /// Whether this child has syntax kind `UnexpectedNodes`.
  public var isUnexpectedNodes: Bool {
    syntaxKind == "UnexpectedNodes"
  }

  /// Returns `true` if this child's type is one of the base syntax kinds and
  /// it has no node choices.
  public var hasBaseType: Bool {
    switch kind {
    case .nodeChoices(let choices):
      return choices.isEmpty && SYNTAX_BASE_KINDS.contains(syntaxKind)
    case .node,
      .collection,
      .token:
      return SYNTAX_BASE_KINDS.contains(syntaxKind)
    }
  }

  /// Returns `true` if this child's type is one of the base syntax kinds and
  /// it's optional.
  public var hasOptionalBaseType: Bool {
    return hasBaseType && isOptional
  }

  /// If a classification is passed, it specifies the color identifiers in
  /// that subtree should inherit for syntax coloring. Must be a member of
  /// ``SyntaxClassification``.
  /// If `forceClassification` is also set to true, all child nodes (not only
  /// identifiers) inherit the syntax classification.
  init(
    name: String,
    kind: ChildKind,
    nameForDiagnostics: String? = nil,
    description: String? = nil,
    isOptional: Bool = false,
    classification: String? = nil,
    forceClassification: Bool = false,
    isIndented: Bool = false,
    requiresLeadingNewline: Bool = false
  ) {
    self.name = name
    self.kind = kind
    self.nameForDiagnostics = nameForDiagnostics
    self.description = description
    self.classification = classificationByName(classification)
    self.forceClassification = forceClassification
    self.isIndented = isIndented
    self.requiresLeadingNewline = requiresLeadingNewline
    self.isOptional = isOptional
  }
}
