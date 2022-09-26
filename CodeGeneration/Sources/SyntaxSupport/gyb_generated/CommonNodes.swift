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

public let COMMON_NODES: [Node] = [
  Node(name: "Decl",
       nameForDiagnostics: "declaration",
       kind: "Syntax"),

  Node(name: "Expr",
       nameForDiagnostics: "expression",
       kind: "Syntax"),

  Node(name: "Stmt",
       nameForDiagnostics: "statement",
       kind: "Syntax"),

  Node(name: "Type",
       nameForDiagnostics: "type",
       kind: "Syntax"),

  Node(name: "Pattern",
       nameForDiagnostics: "pattern",
       kind: "Syntax"),

  Node(name: "UnknownDecl",
       nameForDiagnostics: "declaration",
       kind: "Decl"),

  Node(name: "UnknownExpr",
       nameForDiagnostics: "expression",
       kind: "Expr"),

  Node(name: "UnknownStmt",
       nameForDiagnostics: "statement",
       kind: "Stmt"),

  Node(name: "UnknownType",
       nameForDiagnostics: "type",
       kind: "Type"),

  Node(name: "UnknownPattern",
       nameForDiagnostics: "pattern",
       kind: "Pattern"),

  Node(name: "Missing",
       nameForDiagnostics: nil,
       kind: "Syntax"),

  Node(name: "MissingDecl",
       nameForDiagnostics: "declaration",
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
       nameForDiagnostics: "expression",
       kind: "Expr"),

  Node(name: "MissingStmt",
       nameForDiagnostics: "statement",
       kind: "Stmt"),

  Node(name: "MissingType",
       nameForDiagnostics: "type",
       kind: "Type"),

  Node(name: "MissingPattern",
       nameForDiagnostics: "pattern",
       kind: "Pattern"),

  Node(name: "CodeBlockItem",
       nameForDiagnostics: nil,
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
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "CodeBlockItem",
       elementsSeparatedByNewline: true),

  Node(name: "CodeBlock",
       nameForDiagnostics: nil,
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

  Node(name: "UnexpectedNodes",
       nameForDiagnostics: nil,
       description: "A collection of syntax nodes that occurred in the source code butcould not be used to form a valid syntax tree.",
       kind: "SyntaxCollection",
       element: "Syntax"),

]
