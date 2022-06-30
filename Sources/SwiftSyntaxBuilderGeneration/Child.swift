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

/// A child of a node, that may be declared optional or a token with a
/// restricted subset of acceptable kinds or texts.
class Child {
  let name: String
  let syntaxKind: String
  let description: String?
  let collectionElementName: String?
  let forceClassification: Bool
  let isIndented: Bool
  let requiresLeadingNewline: Bool
  let isOptional: Bool
  let textChoices: [String]
  let nodeChoices: [Child]
  let classification: SyntaxClassification?
  /// A restricted set of token kinds that will be accepted for this child.
  let tokenChoices: [Token]

  var swiftName: String {
    return lowercaseFirstWord(name: name)
  }

  var swiftSyntaxKind: String {
    return lowercaseFirstWord(name: syntaxKind)
  }

  var typeName: String {
    return kindToType(kind: syntaxKind)
  }

  /// If the child ends with "token" in the kind, it's considered a token node. Grab the existing reference to that token from the global list.
  var tokenKind: String? {
    if syntaxKind.hasSuffix("Token") {
      return syntaxKind
    } else {
      return nil
    }
  }

  /// Returns `true` if this child has a token kind.
  var isToken: Bool {
    return tokenKind != nil
  }

  var token: Token? {
    guard let tokenKind = tokenKind else { return nil }
    return SYNTAX_TOKEN_MAP[tokenKind]
  }

  /// Returns the first choice from the `tokenChoices` if there are any, otherwise returns `nil`.
  var mainToken: Token? {
    return tokenChoices.first
  }

  /// If a classification is passed, it specifies the color identifiers in
  /// that subtree should inherit for syntax coloring. Must be a member of
  /// SyntaxClassification in SyntaxClassifier.h.gyb
  /// If force_classification is also set to true, all child nodes (not only
  /// identifiers) inherit the syntax classification.
  init(name: String,
       kind: String,
       description: String? = nil,
       isOptional: Bool = false,
       tokenChoices: [String] = [],
       textChoices: [String] = [],
       nodeChoices: [Child] = [],
       collectionElementName: String? = nil,
       classification: String? = nil,
       forceClassification: Bool = false,
       isIndented: Bool = false,
       requiresLeadingNewline: Bool = false) {
    self.name = name
    self.syntaxKind = kind
    self.description = description
    self.collectionElementName = collectionElementName
    self.classification = classificationByName(classification)
    self.forceClassification = forceClassification
    self.isIndented = isIndented
    self.requiresLeadingNewline = requiresLeadingNewline
    self.isOptional = isOptional

    var mappedTokenChoices = [Token]()
    
    if syntaxKind.hasSuffix("Token"), let token = SYNTAX_TOKEN_MAP[syntaxKind] {
      mappedTokenChoices.append(token)
    }

    mappedTokenChoices.append(contentsOf: tokenChoices.compactMap { SYNTAX_TOKEN_MAP[$0] })
    self.tokenChoices = mappedTokenChoices
    
    // A list of valid text for tokens, if specified.
    // This will force validation logic to check the text passed into the
    // token against the choices.
    self.textChoices = textChoices

    // A list of valid choices for a child
    self.nodeChoices = nodeChoices

    // Check the choices are either empty or multiple
    assert(nodeChoices.count != 1)

    // Check node choices are well-formed
    for choice in self.nodeChoices {
      assert(!choice.isOptional, "node choice \(choice.name) cannot be optional")
      assert(choice.nodeChoices.isEmpty, "node choice \(choice.name) cannot have further choices")
    }
  }
}
