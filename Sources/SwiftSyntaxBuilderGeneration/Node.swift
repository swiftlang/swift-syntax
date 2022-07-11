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

/// A Syntax node, possibly with children.
/// If the kind is "SyntaxCollection", then this node is considered a Syntax
/// Collection that will expose itself as a typedef rather than a concrete
/// subclass.
class Node {
  let syntaxKind: String
  let swiftSyntaxKind: String
  let name: String
  let description: String?
  let baseKind: String
  let traits: [String]
  let children: [Child]
  let collectionElementName: String?
  let collectionElementChoices: [String]?
  let omitWhenEmpty: Bool
  let elementsSeparatedByNewline: Bool
  let collectionElement: String

  /// Returns `True` if this node declares one of the base syntax kinds.
  var isBase: Bool {
    return SyntaxBaseKinds.contains(syntaxKind)
  }

  /// Returns `True` if this node is a subclass of SyntaxCollection.
  var isSyntaxCollection: Bool {
    return baseKind == "SyntaxCollection"
  }

  /// Returns `True` if this node should have a `validate` method associated.
  var requiresValidation: Bool {
    return isBuildable
  }

  /// Returns `True` if this node is an `Unknown` syntax subclass.
  var isUnknown: Bool {
    return syntaxKind.contains("Unknown")
  }

  /// Returns `True` if this node should have a builder associated.
  var isBuildable: Bool {
    return !isBase && !isUnknown && !isSyntaxCollection
  }

  /// Returns 'True' if this node shall not be created while parsing if it has no children.
  var shallBeOmittedWhenEmpty: Bool {
    return omitWhenEmpty
  }

  /// Returns true if this child has a token kind.
  var isToken: Bool {
    return syntaxKind.contains("Token") || collectionElement.contains("Token")
  }

  init(name: String,
       description: String? = nil,
       kind: String,
       traits: [String] = [],
       children: [Child] = [],
       element: String = "",
       elementName: String? = nil,
       elementChoices: [String]? = nil,
       omitWhenEmpty: Bool = false,
       elementsSeparatedByNewline: Bool = false) {
    self.syntaxKind = name
    self.swiftSyntaxKind = lowercaseFirstWord(name: name)
    self.name = kindToType(kind: self.syntaxKind)
    self.description = description

    self.traits = traits
    self.children = children
    self.baseKind = kind

    if !SyntaxBaseKinds.contains(baseKind) {
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
    assert(!isSyntaxCollection || elementName != nil || (element != "" && element != "Syntax"))
  }
}
