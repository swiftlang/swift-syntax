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
               isOptional: true),
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
               kind: "LeftBraceToken"),
         Child(name: "Statements",
               kind: "CodeBlockItemList",
               collectionElementName: "Statement",
               isIndented: true),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               requiresLeadingNewline: true)
       ]),

]
