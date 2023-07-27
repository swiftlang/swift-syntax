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
  public let protocolName: TokenSyntax
  public let documentation: SwiftSyntax.Trivia
  public let children: [Child]

  init(traitName: String, documentation: String? = nil, children: [Child]) {
    self.traitName = traitName
    self.protocolName = .identifier("\(traitName)Syntax")
    self.documentation = docCommentTrivia(from: documentation)
    self.children = children
  }
}

public let TRAITS: [Trait] = [
  Trait(
    traitName: "Braced",
    children: [
      Child(name: "LeftBrace", kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])),
      Child(name: "RightBrace", kind: .token(choices: [.token(tokenKind: "RightBraceToken")])),
    ]
  ),
  Trait(
    traitName: "DeclGroup",
    children: [
      Child(name: "Attributes", kind: .node(kind: .attributeList), isOptional: true),
      Child(name: "Modifiers", kind: .node(kind: .declModifierList), isOptional: true),
      Child(name: "InheritanceClause", kind: .node(kind: .inheritanceClause), isOptional: true),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: .genericWhereClause),
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
      Child(name: "MemberBlock", kind: .node(kind: .memberBlock)),
    ]
  ),
  Trait(
    traitName: "EffectSpecifiers",
    children: [
      Child(name: "UnexpectedBeforeAsyncSpecifier", kind: .node(kind: .unexpectedNodes), isOptional: true),
      Child(name: "AsyncSpecifier", kind: .token(choices: [.keyword(text: "async"), .keyword(text: "reasync")]), isOptional: true),
      Child(name: "UnexpectedBetweenAsyncSpecifierAndThrowsSpecifier", kind: .node(kind: .unexpectedNodes), isOptional: true),
      Child(name: "ThrowsSpecifier", kind: .token(choices: [.keyword(text: "throws"), .keyword(text: "rethrows")]), isOptional: true),
      Child(name: "UnexpectedAfterThrowsSpecifier", kind: .node(kind: .unexpectedNodes), isOptional: true),
    ]
  ),
  Trait(
    traitName: "FreestandingMacroExpansion",
    children: [
      Child(name: "PoundToken", kind: .token(choices: [.token(tokenKind: "PoundToken")])),
      Child(name: "Macro", kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
      Child(name: "GenericArgumentClause", kind: .node(kind: .genericArgumentClause), isOptional: true),
      Child(name: "LeftParen", kind: .token(choices: [.token(tokenKind: "LeftParenToken")]), isOptional: true),
      Child(name: "ArgumentList", kind: .node(kind: .labeledExprList)),
      Child(name: "RightParen", kind: .token(choices: [.token(tokenKind: "RightParenToken")]), isOptional: true),
      Child(name: "TrailingClosure", kind: .node(kind: .closureExpr), isOptional: true),
      Child(name: "AdditionalTrailingClosures", kind: .node(kind: .multipleTrailingClosureElementList), isOptional: true),
    ]
  ),
  Trait(
    traitName: "NamedDecl",
    children: [
      Child(name: "Name", kind: .token(choices: [.token(tokenKind: "IdentifierToken")]))
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
        name: "Placeholder",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        documentation: """
          A placeholder, i.e. `<#placeholder#>`, that can be inserted into the source code to represent the missing node.
          """
      )
    ]
  ),
  Trait(
    traitName: "Parenthesized",
    children: [
      Child(name: "LeftParen", kind: .token(choices: [.token(tokenKind: "LeftParenToken")])),
      Child(name: "RightParen", kind: .token(choices: [.token(tokenKind: "RightParenToken")])),
    ]
  ),
  Trait(
    traitName: "WithAttributes",
    children: [
      Child(name: "Attributes", kind: .node(kind: .attributeList), isOptional: true)
    ]
  ),
  Trait(
    traitName: "WithCodeBlock",
    children: [
      Child(name: "Body", kind: .node(kind: .codeBlock))
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
        name: "GenericParameterClause",
        kind: .node(kind: .genericParameterClause),
        documentation: "The parameter clause that defines the generic parameters.",
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: .genericWhereClause),
        documentation: "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
    ]
  ),
  Trait(
    traitName: "WithModifiers",
    children: [
      Child(name: "Modifiers", kind: .node(kind: .declModifierList), isOptional: true)
    ]
  ),
  Trait(
    traitName: "WithStatements",
    children: [
      Child(name: "Statements", kind: .node(kind: .codeBlockItemList))
    ]
  ),
  Trait(
    traitName: "WithTrailingComma",
    children: [
      Child(name: "TrailingComma", kind: .token(choices: [.token(tokenKind: "CommaToken")]), isOptional: true)
    ]
  ),
]

//==========================================================================//
// IMPORTANT: If you are tempted to add a trait here please insert in in    //
// alphabetical order above                                                 //
//==========================================================================//
