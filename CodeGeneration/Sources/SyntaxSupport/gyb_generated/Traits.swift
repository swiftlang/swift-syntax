//// Automatically Generated From Traits.swift.gyb.
//// Do Not Edit Directly!
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
  Trait(traitName: "Attributed",
        children: [
          Child(name: "Attributes", kind: "AttributeList", isOptional: true),
        ]
  ),
  Trait(traitName: "DeclGroup",
        children: [
          Child(name: "Attributes", kind: "AttributeList", isOptional: true),
          Child(name: "Modifiers", kind: "ModifierList", isOptional: true),
          Child(name: "Members", kind: "MemberDeclBlock"),
        ]
  ),
  Trait(traitName: "Braced",
        children: [
          Child(name: "LeftBrace", kind: "LeftBraceToken"),
          Child(name: "RightBrace", kind: "RightBraceToken"),
        ]
  ),
  Trait(traitName: "IdentifiedDecl",
        children: [
          Child(name: "Identifier", kind: "IdentifierToken"),
        ]
  ),
  Trait(traitName: "WithCodeBlock",
        children: [
          Child(name: "Body", kind: "CodeBlock"),
        ]
  ),
  Trait(traitName: "Parenthesized",
        children: [
          Child(name: "LeftParen", kind: "LeftParenToken"),
          Child(name: "RightParen", kind: "RightParenToken"),
        ]
  ),
  Trait(traitName: "FreestandingMacroExpansion",
        children: [
          Child(name: "PoundToken", kind: "PoundToken"),
          Child(name: "Macro", kind: "IdentifierToken"),
          Child(name: "GenericArguments", kind: "GenericArgumentClause", isOptional: true),
          Child(name: "LeftParen", kind: "LeftParenToken", isOptional: true),
          Child(name: "ArgumentList", kind: "TupleExprElementList"),
          Child(name: "RightParen", kind: "RightParenToken", isOptional: true),
          Child(name: "TrailingClosure", kind: "ClosureExpr", isOptional: true),
          Child(name: "AdditionalTrailingClosures", kind: "MultipleTrailingClosureElementList", isOptional: true),
        ]
  ),
  Trait(traitName: "WithTrailingComma",
        children: [
          Child(name: "TrailingComma", kind: "CommaToken", isOptional: true),
        ]
  ),
  Trait(traitName: "WithStatements",
        children: [
          Child(name: "Statements", kind: "CodeBlockItemList"),
        ]
  ),
  Trait(traitName: "EffectSpecifiers",
        children: [
          Child(name: "UnexpectedBeforeAsyncSpecifier", kind: "UnexpectedNodes", isOptional: true),
          Child(name: "AsyncSpecifier", kind: "KeywordToken", isOptional: true),
          Child(name: "UnexpectedBetweenAsyncSpecifierAndThrowsSpecifier", kind: "UnexpectedNodes", isOptional: true),
          Child(name: "ThrowsSpecifier", kind: "KeywordToken", isOptional: true),
          Child(name: "UnexpectedAfterThrowsSpecifier", kind: "UnexpectedNodes", isOptional: true),
        ]
  ),
]
