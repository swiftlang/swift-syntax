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

/// Represents a classification a token can receive for syntax highlighting.
public class SyntaxClassification {
  public let name: String
  public let description: String

  public var swiftName: String {
    lowercaseFirstWord(name: name)
  }

  public init(name: String, description: String) {
    self.name = name
    self.description = description
  }
}

public class ChildClassification {
  public let parent: Node
  public let childIndex: Int
  public let child: Child
  public var isToken: Bool { child.isToken }
  public var classification: SyntaxClassification? { child.classification }
  public var force: Bool { child.forceClassification }

  public init(node: Node, childIndex: Int, child: Child) {
    self.parent = node
    self.childIndex = childIndex
    self.child = child
  }
}

public let SYNTAX_CLASSIFICATIONS: [SyntaxClassification] = [
  SyntaxClassification(name: "Attribute", description: "An attribute starting with an `@`."),
  SyntaxClassification(name: "BlockComment", description: "A block comment starting with `/**` and ending with `*/."),
  SyntaxClassification(name: "BuildConfigId", description: "A build configuration directive like `#if`, `#elseif`, `#else`."),
  SyntaxClassification(name: "DocBlockComment", description: "A doc block comment starting with `/**` and ending with `*/."),
  SyntaxClassification(name: "DocLineComment", description: "A doc line comment starting with `///`."),
  SyntaxClassification(name: "DollarIdentifier", description: "An identifier starting with `$` like `$0`."),
  SyntaxClassification(name: "EditorPlaceholder", description: "An editor placeholder of the form `<#content#>`"),
  SyntaxClassification(name: "FloatingLiteral", description: "A floating point literal."),
  SyntaxClassification(name: "Identifier", description: "A generic identifier."),
  SyntaxClassification(name: "IntegerLiteral", description: "An integer literal."),
  SyntaxClassification(name: "Keyword", description: "A Swift keyword, including contextual keywords."),
  SyntaxClassification(name: "LineComment", description: "A line comment starting with `//`."),
  SyntaxClassification(name: "None", description: "The token should not receive syntax coloring."),
  SyntaxClassification(name: "ObjectLiteral", description: "An image, color, etc. literal."),
  SyntaxClassification(name: "OperatorIdentifier", description: "An identifier referring to an operator."),
  SyntaxClassification(name: "PoundDirectiveKeyword", description: "A `#` keyword like `#warning`."),
  SyntaxClassification(name: "RegexLiteral", description: "A regex literal, including multiline regex literals."),
  SyntaxClassification(name: "StringInterpolationAnchor", description: "The opening and closing parenthesis of string interpolation."),
  SyntaxClassification(name: "StringLiteral", description: "A string literal including multiline string literals."),
  SyntaxClassification(name: "TypeIdentifier", description: "An identifier referring to a type."),
]

func classificationByName(_ name: String?) -> SyntaxClassification? {
  guard let name = name else { return nil }
  for classification in SYNTAX_CLASSIFICATIONS where classification.name == name {
    return classification
  }

  fatalError("Unknown syntax classification '\(name)'")
}
