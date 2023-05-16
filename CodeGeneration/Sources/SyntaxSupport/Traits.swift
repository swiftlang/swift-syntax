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

public class Trait {
  public let traitName: String
  public let children: [Child]
  public let description: String?

  init(traitName: String, children: [Child], description: String? = nil) {
    self.traitName = traitName
    self.children = children
    self.description = description
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
      Child(name: "Modifiers", kind: .node(kind: .modifierList), isOptional: true),
      Child(name: "MemberBlock", kind: .node(kind: .memberDeclBlock)),
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
      Child(name: "GenericArguments", kind: .node(kind: .genericArgumentClause), isOptional: true),
      Child(name: "LeftParen", kind: .token(choices: [.token(tokenKind: "LeftParenToken")]), isOptional: true),
      Child(name: "ArgumentList", kind: .node(kind: .tupleExprElementList)),
      Child(name: "RightParen", kind: .token(choices: [.token(tokenKind: "RightParenToken")]), isOptional: true),
      Child(name: "TrailingClosure", kind: .node(kind: .closureExpr), isOptional: true),
      Child(name: "AdditionalTrailingClosures", kind: .node(kind: .multipleTrailingClosureElementList), isOptional: true),
    ]
  ),
  Trait(
    traitName: "IdentifiedDecl",
    children: [
      Child(name: "Identifier", kind: .token(choices: [.token(tokenKind: "IdentifierToken")]))
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
    traitName: "WithModifiers",
    children: [
      Child(name: "Modifiers", kind: .node(kind: .modifierList), isOptional: true)
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
