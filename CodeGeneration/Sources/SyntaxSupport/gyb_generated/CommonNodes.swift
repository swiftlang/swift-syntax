//// Automatically Generated From CommonNodes.swift.gyb.
//// Do Not Edit Directly!
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

public let COMMON_NODES: [Node] = [
  Node(name: "CodeBlockItemList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "CodeBlockItem",
       elementsSeparatedByNewline: true),

  Node(name: "CodeBlockItem",
       nameForDiagnostics: nil,
       description: "A CodeBlockItem is any Syntax node that appears on its own line inside a CodeBlock.",
       kind: "Syntax",
       children: [
         Child(name: "Item",
               kind: .nodeChoices(choices: [
                 Child(name: "Decl",
                       kind: .node(kind: "Decl")),
                 Child(name: "Stmt",
                       kind: .node(kind: "Stmt")),
                 Child(name: "Expr",
                       kind: .node(kind: "Expr"))
               ]),
               description: "The underlying node inside the code block."),
         Child(name: "Semicolon",
               kind: .token(choices: [.token(tokenKind: "SemicolonToken")]),
               description: "If present, the trailing semicolon at the end of the item.",
               isOptional: true)
       ],
       omitWhenEmpty: true),

  Node(name: "CodeBlock",
       nameForDiagnostics: "code block",
       kind: "Syntax",
       traits: [
         "Braced",
         "WithStatements"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])),
         Child(name: "Statements",
               kind: .collection(kind: "CodeBlockItemList", collectionElementName: "Statement"),
               nameForDiagnostics: "statements",
               isIndented: true),
         Child(name: "RightBrace",
               kind: .token(choices: [.token(tokenKind: "RightBraceToken")]),
               requiresLeadingNewline: true)
       ]),

  Node(name: "DeclEffectSpecifiers",
       nameForDiagnostics: "effect specifiers",
       kind: "Syntax",
       traits: [
         "EffectSpecifiers"
       ],
       children: [
         Child(name: "AsyncSpecifier",
               kind: .token(choices: [.keyword(text: "async"), .keyword(text: "reasync")]),
               isOptional: true),
         Child(name: "ThrowsSpecifier",
               kind: .token(choices: [.keyword(text: "throws"), .keyword(text: "rethrows")]),
               isOptional: true)
       ]),

  Node(name: "Decl",
       nameForDiagnostics: "declaration",
       kind: "Syntax",
       parserFunction: "parseDeclaration"),

  Node(name: "Expr",
       nameForDiagnostics: "expression",
       kind: "Syntax",
       parserFunction: "parseExpression"),

  Node(name: "MissingDecl",
       nameForDiagnostics: "declaration",
       kind: "Decl",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               isOptional: true),
         Child(name: "Modifiers",
               kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
               isOptional: true)
       ]),

  Node(name: "MissingExpr",
       nameForDiagnostics: "expression",
       kind: "Expr"),

  Node(name: "MissingPattern",
       nameForDiagnostics: "pattern",
       kind: "Pattern"),

  Node(name: "MissingStmt",
       nameForDiagnostics: "statement",
       kind: "Stmt"),

  Node(name: "Missing",
       nameForDiagnostics: nil,
       kind: "Syntax"),

  Node(name: "MissingType",
       nameForDiagnostics: "type",
       kind: "Type"),

  Node(name: "Pattern",
       nameForDiagnostics: "pattern",
       kind: "Syntax",
       parserFunction: "parsePattern"),

  Node(name: "Stmt",
       nameForDiagnostics: "statement",
       kind: "Syntax",
       parserFunction: "parseStatement"),

  Node(name: "TypeEffectSpecifiers",
       nameForDiagnostics: "effect specifiers",
       kind: "Syntax",
       traits: [
         "EffectSpecifiers"
       ],
       children: [
         Child(name: "AsyncSpecifier",
               kind: .token(choices: [.keyword(text: "async")]),
               isOptional: true),
         Child(name: "ThrowsSpecifier",
               kind: .token(choices: [.keyword(text: "throws")]),
               isOptional: true)
       ]),

  Node(name: "Type",
       nameForDiagnostics: "type",
       kind: "Syntax",
       parserFunction: "parseType"),

  Node(name: "UnexpectedNodes",
       nameForDiagnostics: nil,
       description: "A collection of syntax nodes that occurred in the source code but could not be used to form a valid syntax tree.",
       kind: "SyntaxCollection",
       element: "Syntax"),

]
