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

/// A Syntax node, possibly with children.
/// If the kind is "SyntaxCollection", then this node is considered a Syntax
/// Collection that will expose itself as a typedef rather than a concrete
/// subclass.
public class Node {
  public let syntaxKind: String
  public let swiftSyntaxKind: String
  public let name: String
  public let nameForDiagnostics: String?
  public let description: String?
  public let baseKind: String
  public let parserFunction: String?
  public let traits: [String]
  public let children: [Child]
  public let nonUnexpectedChildren: [Child]
  public let collectionElementName: String?
  public let collectionElementChoices: [String]?
  public let omitWhenEmpty: Bool
  public let elementsSeparatedByNewline: Bool
  public let collectionElement: String

  /// Returns `true` if this node declares one of the base syntax kinds.
  public var isBase: Bool {
    return SYNTAX_BASE_KINDS.contains(syntaxKind)
  }

  /// Returns `true` if this node is a subclass of SyntaxCollection.
  public var isSyntaxCollection: Bool {
    return baseKind == "SyntaxCollection"
  }

  /// Returns `true` if this node should have a `validate` method associated.
  public var requiresValidation: Bool {
    return isBuildable
  }

  /// Returns `true` if this node is an `Unknown` syntax subclass.
  public var isUnknown: Bool {
    return syntaxKind.contains("Unknown")
  }

  /// Returns `true` if this node is an `Unknown` syntax subclass.
  public var isMissing: Bool {
    return syntaxKind.contains("Missing")
  }

  /// Returns `true` if this node should have a builder associated.
  public var isBuildable: Bool {
    return !isBase && !isUnknown && !isMissing && !isSyntaxCollection
  }

  /// Returns 'True' if this node shall not be created while parsing if it has no children.
  public var shallBeOmittedWhenEmpty: Bool {
    return omitWhenEmpty
  }

  /// Returns true if this child has a token kind.
  public var isToken: Bool {
    return syntaxKind.contains("Token") || collectionElement.contains("Token")
  }

  public var isVisitable: Bool {
    return !isBase
  }

  public var hasOptionalBaseTypeChild: Bool {
    return children.contains { child in
      if child.hasOptionalBaseType {
        return true
      } else {
        return false
      }
    }
  }

  public var grammar: String {
    guard !children.isEmpty else {
      return ""
    }

    return """
      ### Children

      \(GrammarGenerator.childrenList(for: children))
      """
      .split(separator: "\n", omittingEmptySubsequences: false)
      .map { "/// \($0)" }
      .joined(separator: "\n")
  }

  init(
    name: String,
    nameForDiagnostics: String?,
    description: String? = nil,
    kind: String,
    traits: [String] = [],
    parserFunction: String? = nil,
    children: [Child] = [],
    element: String = "",
    elementName: String? = nil,
    elementChoices: [String]? = nil,
    omitWhenEmpty: Bool = false,
    elementsSeparatedByNewline: Bool = false
  ) {
    self.syntaxKind = name
    self.swiftSyntaxKind = lowercaseFirstWord(name: name)
    self.name = kindToType(kind: self.syntaxKind)
    self.nameForDiagnostics = nameForDiagnostics
    self.description = description
    self.parserFunction = parserFunction
    self.traits = traits
    self.baseKind = kind

    if kind == "SyntaxCollection" {
      self.children = children
    } else if children.count > 0 {
      // Add implicitly generated UnexpectedNodes children between
      // any two defined children
      self.children =
        children.enumerated().flatMap { (i, child) -> [Child] in
          let unexpectedName: String
          if i == 0 {
            unexpectedName = "UnexpectedBefore\(child.name)"
          } else {
            unexpectedName = "UnexpectedBetween\(children[i - 1].name)And\(child.name)"
          }
          return [
            Child(
              name: unexpectedName,
              kind: .collection(kind: "UnexpectedNodes", collectionElementName: unexpectedName),
              isOptional: true
            ),
            child,
          ]
        }
        + (!children.isEmpty
          ? [
            Child(
              name: "UnexpectedAfter\(children.last!.name)",
              kind: .collection(kind: "UnexpectedNodes", collectionElementName: "UnexpectedAfter\(children.last!.name)"),
              isOptional: true
            )
          ] : [])
    } else {
      self.children = [
        Child(name: "Unexpected", kind: .collection(kind: "UnexpectedNodes", collectionElementName: "Unexpected"), isOptional: true)
      ]
    }

    self.nonUnexpectedChildren = children.filter { !$0.isUnexpectedNodes }

    if !SYNTAX_BASE_KINDS.contains(baseKind) {
      fatalError("unknown base kind '\(baseKind)' for node '\(syntaxKind)'")
    }

    self.omitWhenEmpty = omitWhenEmpty
    self.collectionElement = element

    // If there's a preferred name for the collection element that differs
    // from its supertype, use that.
    self.collectionElementName = elementName ?? self.collectionElement
    self.collectionElementChoices = elementChoices ?? []
    self.elementsSeparatedByNewline = elementsSeparatedByNewline

    // For SyntaxCollections make sure that the elementName is set.
    precondition(!isSyntaxCollection || elementName != nil || element != "")
  }
}
