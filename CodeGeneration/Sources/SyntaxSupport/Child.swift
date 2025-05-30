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
public enum TokenChoice: Equatable, IdentifierConvertible {
  case keyword(Keyword)
  case token(Token)

  public var isKeyword: Bool {
    switch self {
    case .keyword: return true
    case .token: return false
    }
  }

  /// The name of this token choice as an identifier.
  public var identifier: TokenSyntax {
    switch self {
    case .keyword(let keyword):
      return keyword.spec.identifier
    case .token(let token):
      return token.spec.identifier
    }
  }
}

public enum ChildKind {
  /// The child always contains a node of the given `kind`.
  case node(kind: SyntaxNodeKind)
  /// The child always contains a node that matches one of the `choices`.
  case nodeChoices(choices: [Child], childHistory: Child.History = [])
  // FIXME: We don't appear to have ever generated compatibility layers for children of node choices!
  /// The child is a collection of `kind`.
  case collection(kind: SyntaxNodeKind, defaultsToEmpty: Bool = false)
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
    if case .nodeChoices(let nodeChoices, _) = self {
      return nodeChoices.isEmpty
    } else {
      return true
    }
  }
}

/// A child of a node, that may be declared optional or a token with a
/// restricted subset of acceptable kinds or texts.
public class Child: NodeChoiceConvertible {
  /// The name of the child.
  ///
  /// The first character of the name is always uppercase.
  public let name: String

  /// The kind of the child (node, token, collection, ...)
  public let kind: ChildKind

  /// Whether this child is optional and can be `nil`.
  public let isOptional: Bool

  /// Whether this child provides a default value when used as a parameter in a function.
  public let providesDefaultInitialization: Bool

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

  public var syntaxNodeKind: SyntaxNodeKind {
    switch kind {
    case .node(kind: let kind):
      return kind
    case .nodeChoices:
      return .syntax
    case .collection(kind: let kind, _):
      return kind
    case .token:
      return .token
    }
  }

  /// A name of this child as an identifier.
  public var identifier: TokenSyntax {
    return .identifier(lowercaseFirstWord(name: name))
  }

  /// If this child has node choices, the type that the nested `SyntaxChildChoices` type should get.
  ///
  /// For any other kind of child nodes, accessing this property crashes.
  public var syntaxChoicesType: TypeSyntax {
    precondition(kind.isNodeChoices, "Cannot get `syntaxChoicesType` for node that doesn’t have nodeChoices")
    return "\(raw: newestName.withFirstCharacterUppercased)"
  }

  /// If this child only has tokens, the type that the generated `TokenSpecSet` should get.
  ///
  /// For any other kind of child nodes, accessing this property crashes.
  public var tokenSpecSetType: TypeSyntax {
    precondition(kind.isToken, "Cannot get `tokenSpecSetType` for node that isn’t a token")
    return "\(raw: newestName.withFirstCharacterUppercased)Options"
  }

  /// If this child is deprecated, describes the sequence of accesses necessary
  /// to reach the equivalent value using non-deprecated children; if the child
  /// is not deprecated, this array is empty.
  ///
  /// Think of the elements of this array like components in a key path:
  /// `newestChildPath[0]` is a child of the same node `self` is a child of,
  /// `newestChildPath[1]` is a child of the node in `newestChildPath[0]`,
  /// `newestChildPath[2]` is a child of the node in `newestChildPath[1]`,
  /// and so on. To access the current value of this child, you must access each child
  /// in the path *in sequence* on the node returned by the last access.
  ///
  /// ```
  /// // Suppose the `newestChildPath` of `fooBar` looks like:
  /// //
  /// //    [ Child(name: "foo", ...), Child(name: "bar", ...) ]
  /// //
  /// // A compatibility property might look like this:
  /// var fooBar: BarSyntax {
  ///   get {
  ///     return self.foo.bar
  ///   }
  ///   set {
  ///     self.foo.bar = newValue
  ///   }
  /// }
  /// ```
  ///
  /// If the child has only ever had `Refactoring.renamed(from:)`, there will
  /// only be one element in the path; if `Refactoring.extracted` is involved,
  /// there may be many elements.
  ///
  /// - Invariant: `newestChildPath.first`, if present, is always a sibling of `self`.
  /// - Invariant: `newestChildPath.last`, if present, always has the same `kind` as `self`.
  /// - Invariant: All elements in `newestChildPath` are not historical.
  /// - Note: This array does *not* record all of the previous versions
  ///         of the child. That information is not directly available anywhere.
  public let newestChildPath: [Child]

  /// True if this child was created by a `Child.Refactoring`. Such children
  /// are part of the compatibility layer and are therefore deprecated.
  public var isHistorical: Bool {
    !newestChildPath.isEmpty
  }

  /// Replaces the nodes in `newerChildPath` with their own `newerChildPath`s,
  /// if any, to form a child path enitrely of non-historical nodes.
  static private func makeNewestChildPath(from newerChildPath: [Child]) -> [Child] {
    var result: [Child] = []

    // Push the children onto the stack in reverse order so they end up in the right place once they're resolved.
    var workStack = Array(newerChildPath.reversed())

    while let elem = workStack.popLast() {
      if elem.isHistorical {
        // There's an even newer version. Start working on that.
        workStack.append(contentsOf: elem.newestChildPath.reversed())
      } else {
        // We've reached the current version of the child.
        result.append(elem)
      }
    }

    return result
  }

  private var newestName: String {
    return newestChildPath.last?.name ?? name
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
       https://github.com/swiftlang/swift-syntax/issues/2010
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
    case .collection(kind: .unexpectedNodes, _):
      return true
    default:
      return false
    }
  }

  /// Returns `true` if this child's type is one of the base syntax kinds and
  /// it has no node choices.
  public var hasBaseType: Bool {
    switch kind {
    case .nodeChoices(let choices, _):
      return choices.isEmpty
    case .node(let kind):
      return kind.isBase
    case .collection(kind: let kind, _):
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

  init(
    name: String,
    kind: ChildKind,
    experimentalFeature: ExperimentalFeature? = nil,
    nameForDiagnostics: String? = nil,
    documentation: String? = nil,
    isOptional: Bool = false,
    providesDefaultInitialization: Bool = true,
    newerChildPath: [Child] = []
  ) {
    precondition(name.first?.isLowercase ?? true, "The first letter of a child’s name should be lowercase")
    self.name = name
    self.newestChildPath = Self.makeNewestChildPath(from: newerChildPath)
    self.kind = kind
    self.experimentalFeature = experimentalFeature
    self.nameForDiagnostics = nameForDiagnostics
    self.documentationSummary = SwiftSyntax.Trivia.docCommentTrivia(from: documentation)
    self.documentationAbstract = String(documentation?.split(whereSeparator: \.isNewline).first ?? "")
    self.isOptional = isOptional
    self.providesDefaultInitialization = providesDefaultInitialization
  }

  /// Create a node that is a copy of the last node in `newerChildPath`, but
  /// with modifications.
  init(renamingTo replacementName: String? = nil, newerChildPath: [Child]) {
    let other = newerChildPath.last!

    self.name = replacementName ?? other.name
    self.newestChildPath = Self.makeNewestChildPath(from: newerChildPath)
    self.kind = other.kind
    self.experimentalFeature = other.experimentalFeature
    self.nameForDiagnostics = other.nameForDiagnostics
    self.documentationSummary = other.documentationSummary
    self.documentationAbstract = other.documentationAbstract
    self.isOptional = other.isOptional
    self.providesDefaultInitialization = other.providesDefaultInitialization
  }

  /// Create a child for the unexpected nodes between two children (either or
  /// both of which may be `nil`).
  convenience init(forUnexpectedBetween earlier: Child?, and later: Child?, newerChildPath: [Child] = []) {
    let name =
      switch (earlier, later) {
      case (nil, let later?):
        "unexpectedBefore\(later.name.withFirstCharacterUppercased)"
      case (let earlier?, nil):
        "unexpectedAfter\(earlier.name.withFirstCharacterUppercased)"
      case (let earlier?, let later?):
        "unexpectedBetween\(earlier.name.withFirstCharacterUppercased)And\(later.name.withFirstCharacterUppercased)"
      case (nil, nil):
        fatalError("unexpected node has no siblings?")
      }

    self.init(
      name: name,
      kind: .collection(kind: .unexpectedNodes),
      experimentalFeature: earlier?.experimentalFeature ?? later?.experimentalFeature,
      nameForDiagnostics: nil,
      documentation: nil,
      isOptional: true,
      providesDefaultInitialization: true,
      newerChildPath: newerChildPath
    )
  }
}

extension Child: Hashable {
  public static func == (lhs: Child, rhs: Child) -> Bool {
    lhs === rhs
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }
}

extension Child {
  /// A set of changes to the children that were all made simultaneously. The
  /// key is the *new* name of the child; any names in the value are old names.
  public typealias ChangeSet = KeyValuePairs<String, Refactoring>

  /// A history of change sets applied to a group of children, ordered from
  /// most recent set of changes to most distant.
  ///
  /// The first element is the newest set of changes; the last element is the oldest set
  /// of changes. The change sets are applied on top of one another; for
  /// example, this node has a child that was originally named `foo`, then
  /// `bar`, and now `baz`:
  ///
  /// ```swift
  /// Node(
  ///     ...
  ///     children: [
  ///         Child(name: "baz", ...),
  ///     ],
  ///     childHistory: [
  ///         // The key here is "baz", the current name
  ///         [ "baz": .renamed(from: "bar") ],
  ///         // The key here is "bar", the name before the previous change set
  ///         [ "bar": .renamed(from: "foo") ],
  ///     }
  /// }
  /// ```
  public typealias History = [ChangeSet]

  /// Specifies a historical change to a given child, and is able to generate
  /// replacement children to substitute for it in deprecated compatibility
  /// layers.
  public enum Refactoring {
    /// This child was renamed at some point in the past, so a deprecated alias
    /// should be provided. The associated value is the *old*, now-deprecated name.
    case renamed(from: String)

    /// Several adjacent children were extracted into a separate node at some
    /// point in the past, so deprecated aliases that flatten the other node's
    /// children into this node should be provided.
    case extracted
  }
}
