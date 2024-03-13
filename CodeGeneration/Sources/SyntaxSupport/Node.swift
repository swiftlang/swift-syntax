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

import Foundation
import SwiftSyntax

/// The definition of a syntax node that, when generated, conforms to
/// `SyntaxProtocol`.
///
/// There are two fundamentally different kinds of nodes:
///  - Layout nodes contain a fixed number of children of possibly different,
///    but fixed types.
///  - Collection nodes contains an arbitrary number of children but all those
///    children are of the same type.
public class Node {
  fileprivate enum Data {
    case layout(children: [Child], traits: [String])
    case collection(choices: [SyntaxNodeKind])
  }

  /// Contains the layout or collection specific data of this syntax node.
  ///
  /// To access this, use the `layoutNode` or `collectionNode` properties, which
  /// offer the members.
  fileprivate let data: Data

  /// The kind of the node. There must be exactly one `Node` for every case in
  /// `SyntaxNodeKind`.
  public let kind: SyntaxNodeKind

  /// The kind of node’s supertype. This kind must have `isBase == true`
  public let base: SyntaxNodeKind

  /// The experimental feature the node is part of, or `nil` if this isn't
  /// for an experimental feature.
  public let experimentalFeature: ExperimentalFeature?

  /// When the node name is printed for diagnostics, this name is used.
  /// If `nil`, `nameForDiagnostics` will print the parent node’s name.
  public let nameForDiagnostics: String?

  /// A doc comment describing the node.
  ///
  /// The comment does not end with a newline.
  public let documentation: SwiftSyntax.Trivia

  /// If the syntax node can be constructed by parsing a string, the parser
  /// function that should be invoked to create this node.
  public let parserFunction: TokenSyntax?

  /// If `true`, this is for an experimental language feature, and any public
  /// API generated should be SPI.
  public var isExperimental: Bool { experimentalFeature != nil }

  /// A name for this node that is suitable to be used as a variables or enum
  /// case's name.
  public var varOrCaseName: TokenSyntax {
    return kind.varOrCaseName
  }

  /// If this is a layout node, return a view of the node that provides access
  /// to the layout-node specific properties.
  public var layoutNode: LayoutNode? {
    switch data {
    case .layout:
      if kind.isBase {
        return nil
      } else {
        return LayoutNode(node: self)
      }
    default:
      return nil
    }
  }

  /// If this is a collection node, return a view of the node that provides access
  /// to the collection node specific properties.
  public var collectionNode: CollectionNode? {
    switch data {
    case .layout:
      return nil
    default:
      return CollectionNode(node: self)
    }
  }

  /// Retrieve the attributes that should be printed on any API for the
  /// generated node. If `forRaw` is true, this is for the raw syntax node.
  public func apiAttributes(forRaw: Bool = false) -> AttributeListSyntax {
    let attrList = AttributeListSyntax {
      if isExperimental {
        // SPI for enum cases currently requires Swift 5.8 to work correctly.
        let experimentalSPI: AttributeListSyntax = """
          #if compiler(>=5.8)
          @_spi(ExperimentalLanguageFeatures)
          #endif
          """
        experimentalSPI.with(\.trailingTrivia, .newline)
      }
      if forRaw {
        "@_spi(RawSyntax)"
      }
    }
    return attrList.with(\.trailingTrivia, attrList.isEmpty ? [] : .newline)
  }

  /// The documentation note to print for an experimental feature.
  public var experimentalDocNote: SwiftSyntax.Trivia {
    let comment = experimentalFeature.map {
      """
      - Experiment: Requires experimental feature `\($0.token)`.
      """
    }
    return SwiftSyntax.Trivia.docCommentTrivia(from: comment)
  }

  /// Construct the specification for a layout syntax node.
  init(
    kind: SyntaxNodeKind,
    base: SyntaxNodeKind,
    experimentalFeature: ExperimentalFeature? = nil,
    nameForDiagnostics: String?,
    documentation: String? = nil,
    parserFunction: TokenSyntax? = nil,
    traits: [String] = [],
    children: [Child] = []
  ) {
    precondition(base != .syntaxCollection)
    precondition(base.isBase, "unknown base kind '\(base)' for node '\(kind)'")

    self.kind = kind
    self.base = base
    self.experimentalFeature = experimentalFeature
    self.nameForDiagnostics = nameForDiagnostics
    self.documentation = SwiftSyntax.Trivia.docCommentTrivia(from: documentation)
    self.parserFunction = parserFunction

    let childrenWithUnexpected: [Child]
    if children.isEmpty {
      childrenWithUnexpected = [
        Child(name: "unexpected", kind: .collection(kind: .unexpectedNodes, collectionElementName: "Unexpected"), isOptional: true)
      ]
    } else {
      // Add implicitly generated UnexpectedNodes children between
      // any two defined children
      childrenWithUnexpected =
        children.enumerated().flatMap { (i, child) -> [Child] in
          let childName = child.name.withFirstCharacterUppercased

          let unexpectedName: String
          let unexpectedDeprecatedName: String?

          if i == 0 {
            unexpectedName = "unexpectedBefore\(childName)"
            unexpectedDeprecatedName = child.deprecatedName.map { "unexpectedBefore\($0.withFirstCharacterUppercased)" }
          } else {
            unexpectedName = "unexpectedBetween\(children[i - 1].name.withFirstCharacterUppercased)And\(childName)"
            if let deprecatedName = children[i - 1].deprecatedName?.withFirstCharacterUppercased {
              unexpectedDeprecatedName = "unexpectedBetween\(deprecatedName)And\(child.deprecatedName?.withFirstCharacterUppercased ?? childName)"
            } else if let deprecatedName = child.deprecatedName?.withFirstCharacterUppercased {
              unexpectedDeprecatedName = "unexpectedBetween\(children[i - 1].name.withFirstCharacterUppercased)And\(deprecatedName)"
            } else {
              unexpectedDeprecatedName = nil
            }
          }
          let unexpectedBefore = Child(
            name: unexpectedName,
            deprecatedName: unexpectedDeprecatedName,
            kind: .collection(kind: .unexpectedNodes, collectionElementName: unexpectedName),
            isOptional: true
          )
          return [unexpectedBefore, child]
        } + [
          Child(
            name: "unexpectedAfter\(children.last!.name.withFirstCharacterUppercased)",
            deprecatedName: children.last!.deprecatedName.map { "unexpectedAfter\($0.withFirstCharacterUppercased)" },
            kind: .collection(kind: .unexpectedNodes, collectionElementName: "UnexpectedAfter\(children.last!.name.withFirstCharacterUppercased)"),
            isOptional: true
          )
        ]
    }
    self.data = .layout(children: childrenWithUnexpected, traits: traits)
  }

  /// A doc comment that lists all the nodes in which this node occurs as a child in.
  public var containedIn: SwiftSyntax.Trivia {
    if kind == .unexpectedNodes {
      // We don't want to generate a 'Contained In' section for UnexpectedNodesSyntax
      // because all nodes contain an UnexpectedNodesSyntax.
      return []
    }
    var childIn: [(node: SyntaxNodeKind, child: Child?)] = []
    for node in SYNTAX_NODES where !node.isExperimental {
      if let layout = node.layoutNode {
        for child in layout.children {
          if child.kinds.contains(self.kind) {
            childIn.append((node.kind, child))
          }
        }
      } else if let collection = node.collectionNode {
        if collection.elementChoices.contains(self.kind) {
          childIn.append((node.kind, nil))
        }
      }
    }

    guard !childIn.isEmpty else {
      return []
    }

    let list =
      childIn
      .map {
        if let childName = $0.child?.varOrCaseName {
          // This will repeat the syntax type before and after the dot, which is
          // a little unfortunate, but it's the only way I found to get docc to
          // generate a fully-qualified type + member.
          return " - \($0.node.doccLink).``\($0.node.syntaxType)/\(childName)``"
        } else {
          return " - \($0.node.doccLink)"
        }
      }
      .joined(separator: "\n")

    return .docCommentTrivia(
      from: """
        ### Contained in

        \(list)
        """
    )
  }

  /// A doc comment that lists all the subtypes in which this node occurs as a base type in.
  public var subtypes: SwiftSyntax.Trivia {
    if kind == .unexpectedNodes {
      return []
    }

    let list =
      SYNTAX_NODES
      .filter { $0.base == self.kind && !$0.isExperimental }
      .map { "- \($0.kind.doccLink)" }
      .joined(separator: "\n")

    guard !list.isEmpty else {
      return []
    }

    return .docCommentTrivia(
      from: """
        ### Subtypes

        \(list)
        """
    )
  }

  /// Construct the specification for a collection syntax node.
  ///
  /// `base` must be `.syntaxCollection`.
  init(
    kind: SyntaxNodeKind,
    base: SyntaxNodeKind,
    experimentalFeature: ExperimentalFeature? = nil,
    nameForDiagnostics: String?,
    documentation: String? = nil,
    parserFunction: TokenSyntax? = nil,
    elementChoices: [SyntaxNodeKind]
  ) {
    self.kind = kind
    precondition(base == .syntaxCollection)
    self.base = base
    self.experimentalFeature = experimentalFeature
    self.nameForDiagnostics = nameForDiagnostics
    self.documentation = SwiftSyntax.Trivia.docCommentTrivia(from: documentation)
    self.parserFunction = parserFunction

    assert(!elementChoices.isEmpty)
    self.data = .collection(choices: elementChoices)
  }
}

/// Provides a view into a layout node that offers access to the layout-specific
/// properties.
@dynamicMemberLookup
public struct LayoutNode {
  /// The underlying node
  public let node: Node

  fileprivate init(node: Node) {
    switch node.data {
    case .layout:
      break
    default:
      preconditionFailure("NodeLayoutView must wrap a `Node` with data `.layout`")
    }
    self.node = node
  }

  /// Allow transparent accesss to the properties of the underlying `Node`.
  public subscript<T>(dynamicMember keyPath: KeyPath<Node, T>) -> T {
    return node[keyPath: keyPath]
  }

  /// The children of the layout node.
  ///
  /// This includes unexpected children
  public var children: [Child] {
    switch node.data {
    case .layout(children: let children, traits: _):
      return children
    case .collection:
      preconditionFailure("NodeLayoutView must wrap a Node with data `.layout`")
    }
  }

  /// All children in the node that are not unexpected.
  public var nonUnexpectedChildren: [Child] {
    return children.filter { !$0.isUnexpectedNodes }
  }

  /// Traits that the node conforms to.
  public var traits: [String] {
    switch node.data {
    case .layout(children: _, traits: let traits):
      return traits
    case .collection:
      preconditionFailure("NodeLayoutView must wrap a Node with data `.layout`")
    }
  }

  public var grammar: SwiftSyntax.Trivia {
    guard !children.isEmpty else {
      return []
    }

    return .docCommentTrivia(
      from: """
        ### Children

        \(GrammarGenerator.childrenList(for: children))
        """
    )
  }
}

/// Provides a view into a collection node that offers access to the
/// collection-specific properties.
@dynamicMemberLookup
public struct CollectionNode {
  /// The underlying node
  public let node: Node

  fileprivate init(node: Node) {
    switch node.data {
    case .collection:
      break
    default:
      preconditionFailure("NodeLayoutView must wrap a `Node` with data `.layout`")
    }
    self.node = node
  }

  /// Allow transparent access to the properties of the underlying `Node`.
  public subscript<T>(dynamicMember keyPath: KeyPath<Node, T>) -> T {
    return node[keyPath: keyPath]
  }

  /// The kinds the elements can have.
  ///
  /// This can be more than one in which case each element can have either of
  /// these kinds.
  public var elementChoices: [SyntaxNodeKind] {
    switch node.data {
    case .layout:
      preconditionFailure("NodeLayoutView must wrap a Node with data `.collection`")
    case .collection(choices: let choices):
      return choices
    }
  }

  public var grammar: SwiftSyntax.Trivia {
    let grammar: String
    if let onlyElement = elementChoices.only {
      grammar = "\(onlyElement.doccLink) `*`"
    } else {
      grammar = "(\(elementChoices.map { "\($0.doccLink)" }.joined(separator: " | "))) `*`"
    }

    return .docCommentTrivia(
      from: """
        ### Children

        \(grammar)
        """
    )
  }
}

fileprivate extension Child {
  var kinds: [SyntaxNodeKind] {
    switch kind {
    case .node(let kind):
      return [kind]
    case .nodeChoices(let choices):
      return choices.flatMap(\.kinds)
    case .collection(kind: let kind, _, _, _):
      return [kind]
    case .token:
      return [.token]
    }
  }
}
