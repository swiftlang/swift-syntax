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

public class Trait {
  public let traitName: String
  /// The kind of syntax the trait refines.
  ///
  /// Base kind _must_ be a base syntax node, e.g. `.decl`, `.expr` , or
  /// others. See ``SyntaxNodeKind/isBase`` for more details.
  public let baseKind: SyntaxNodeKind?
  public let protocolName: TokenSyntax
  public let documentation: SwiftSyntax.Trivia
  public let children: [Child]

  init(traitName: String, baseKind: SyntaxNodeKind? = nil, documentation: String? = nil, children: [Child]) {
    precondition(baseKind?.isBase != false, "`baseKind` must be a base syntax node kind")
    self.traitName = traitName
    self.baseKind = baseKind
    self.protocolName = .identifier("\(traitName)Syntax")
    self.documentation = SwiftSyntax.Trivia.docCommentTrivia(from: documentation)
    self.children = children
  }
}

public let TRAITS: [Trait] = [
  Trait(
    traitName: "Braced",
    children: [
      Child(name: "leftBrace", kind: .token(choices: [.token(.leftBrace)])),
      Child(name: "rightBrace", kind: .token(choices: [.token(.rightBrace)])),
    ]
  ),
  Trait(
    traitName: "DeclGroup",
    baseKind: .decl,
    children: [
      Child(name: "attributes", kind: .node(kind: .attributeList)),
      Child(name: "modifiers", kind: .node(kind: .declModifierList)),
      Child(
        name: "introducer",
        kind: .token(choices: [.keyword(.actor), .keyword(.class), .keyword(.enum), .keyword(.extension), .keyword(.protocol), .keyword(.struct)]),
        documentation: "The token that introduces this declaration, eg. `class` for a class declaration."
      ),
      Child(name: "inheritanceClause", kind: .node(kind: .inheritanceClause), isOptional: true),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
      Child(name: "memberBlock", kind: .node(kind: .memberBlock)),
    ]
  ),
  Trait(
    traitName: "EffectSpecifiers",
    children: [
      Child(name: "unexpectedBeforeAsyncSpecifier", kind: .node(kind: .unexpectedNodes), isOptional: true),
      Child(name: "asyncSpecifier", kind: .token(choices: [.keyword(.async), .keyword(.reasync)]), isOptional: true),
      Child(name: "unexpectedBetweenAsyncSpecifierAndThrowsClause", kind: .node(kind: .unexpectedNodes), isOptional: true),
      Child(name: "throwsClause", kind: .node(kind: .throwsClause), isOptional: true),
      Child(name: "unexpectedAfterThrowsClause", kind: .node(kind: .unexpectedNodes), isOptional: true),
    ]
  ),
  Trait(
    traitName: "FreestandingMacroExpansion",
    children: [
      Child(name: "pound", deprecatedName: "poundToken", kind: .token(choices: [.token(.pound)])),
      Child(name: "macroName", deprecatedName: "macro", kind: .token(choices: [.token(.identifier)])),
      Child(name: "genericArgumentClause", kind: .node(kind: .genericArgumentClause), isOptional: true),
      Child(name: "leftParen", kind: .token(choices: [.token(.leftParen)]), isOptional: true),
      Child(name: "arguments", deprecatedName: "argumentList", kind: .node(kind: .labeledExprList)),
      Child(name: "rightParen", kind: .token(choices: [.token(.rightParen)]), isOptional: true),
      Child(name: "trailingClosure", kind: .node(kind: .closureExpr), isOptional: true),
      Child(name: "additionalTrailingClosures", kind: .node(kind: .multipleTrailingClosureElementList)),
    ]
  ),
  Trait(
    traitName: "NamedDecl",
    children: [
      Child(name: "name", kind: .token(choices: [.token(.identifier)]))
    ]
  ),
  Trait(
    traitName: "MissingNode",
    documentation: """
      Represents a layout node that is missing in the source file.

      See the types conforming to this protocol for examples of where missing nodes can occur.
      """,
    children: [
      Child(
        name: "placeholder",
        kind: .token(choices: [.token(.identifier)]),
        documentation: """
          A placeholder, i.e. `<#placeholder#>`, that can be inserted into the source code to represent the missing node.
          """
      )
    ]
  ),
  Trait(
    traitName: "Parenthesized",
    children: [
      Child(name: "leftParen", kind: .token(choices: [.token(.leftParen)])),
      Child(name: "rightParen", kind: .token(choices: [.token(.rightParen)])),
    ]
  ),
  Trait(
    traitName: "WithAttributes",
    children: [
      Child(name: "attributes", kind: .node(kind: .attributeList))
    ]
  ),
  Trait(
    traitName: "WithCodeBlock",
    children: [
      Child(name: "body", kind: .node(kind: .codeBlock))
    ]
  ),
  Trait(
    traitName: "WithGenericParameters",
    documentation: """
      Syntax nodes that have generic parameters.

      For example, functions or nominal types like `class` or `struct` can have generic parameters \
      and have a generic where clause that restricts these generic parameters.
      """,
    children: [
      Child(
        name: "genericParameterClause",
        kind: .node(kind: .genericParameterClause),
        documentation: "The parameter clause that defines the generic parameters.",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
    ]
  ),
  Trait(
    traitName: "WithModifiers",
    children: [
      Child(name: "modifiers", kind: .node(kind: .declModifierList))
    ]
  ),
  Trait(
    traitName: "WithOptionalCodeBlock",
    children: [
      Child(name: "body", kind: .node(kind: .codeBlock), isOptional: true)
    ]
  ),
  Trait(
    traitName: "WithStatements",
    children: [
      Child(name: "statements", kind: .node(kind: .codeBlockItemList))
    ]
  ),
  Trait(
    traitName: "WithTrailingComma",
    children: [
      Child(name: "trailingComma", kind: .token(choices: [.token(.comma)]), isOptional: true)
    ]
  ),
]

//==========================================================================//
// IMPORTANT: If you are tempted to add a trait here please insert in in    //
// alphabetical order above                                                 //
//==========================================================================//
