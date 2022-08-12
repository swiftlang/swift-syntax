//// Automatically Generated From CommonNodes.swift.gyb.
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

let COMMON_NODES: [Node] = [
  Node(name: "Decl",
       kind: "Syntax"),

  Node(name: "Expr",
       kind: "Syntax"),

  Node(name: "Stmt",
       kind: "Syntax"),

  Node(name: "Type",
       kind: "Syntax"),

  Node(name: "Pattern",
       kind: "Syntax"),

  Node(name: "UnknownDecl",
       kind: "Decl"),

  Node(name: "UnknownExpr",
       kind: "Expr"),

  Node(name: "UnknownStmt",
       kind: "Stmt"),

  Node(name: "UnknownType",
       kind: "Type"),

  Node(name: "UnknownPattern",
       kind: "Pattern"),

  Node(name: "Missing",
       kind: "Syntax"),

  Node(name: "MissingDecl",
       kind: "Decl",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Modifiers",
               kind: "ModifierList",
               isOptional: true,
               collectionElementName: "Modifier")
       ]),

  Node(name: "MissingExpr",
       kind: "Expr"),

  Node(name: "MissingStmt",
       kind: "Stmt"),

  Node(name: "MissingType",
       kind: "Type"),

  Node(name: "MissingPattern",
       kind: "Pattern"),

  Node(name: "CodeBlockItem",
       description: "A CodeBlockItem is any Syntax node that appears on its own line insidea CodeBlock.",
       kind: "Syntax",
       children: [
         Child(name: "Item",
               kind: "Syntax",
               description: "The underlying node inside the code block.",
               nodeChoices: [
                 Child(name: "Decl",
                       kind: "Decl"),
                 Child(name: "Stmt",
                       kind: "Stmt"),
                 Child(name: "Expr",
                       kind: "Expr"),
                 Child(name: "TokenList",
                       kind: "TokenList"),
                 Child(name: "NonEmptyTokenList",
                       kind: "NonEmptyTokenList")
               ]),
         Child(name: "Semicolon",
               kind: "SemicolonToken",
               description: "If present, the trailing semicolon at the end of the item.",
               isOptional: true,
               tokenChoices: [
                 "Semicolon"
               ]),
         Child(name: "ErrorTokens",
               kind: "Syntax",
               isOptional: true)
       ],
       omitWhenEmpty: true),

  Node(name: "CodeBlockItemList",
       kind: "SyntaxCollection",
       element: "CodeBlockItem",
       elementsSeparatedByNewline: true),

  Node(name: "CodeBlock",
       kind: "Syntax",
       traits: [
         "Braced",
         "WithStatements"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: "LeftBraceToken",
               tokenChoices: [
                 "LeftBrace"
               ]),
         Child(name: "Statements",
               kind: "CodeBlockItemList",
               collectionElementName: "Statement",
               isIndented: true),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               tokenChoices: [
                 "RightBrace"
               ],
               requiresLeadingNewline: true)
       ]),

  Node(name: "GarbageNodes",
       description: "A collection of syntax nodes that occurred in the source code butcould not be used to form a valid syntax tree.",
       kind: "SyntaxCollection",
       element: "Syntax"),

]
