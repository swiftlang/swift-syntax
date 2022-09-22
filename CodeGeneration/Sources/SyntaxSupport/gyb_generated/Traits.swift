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
]
