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
  // code-block-item-list -> code-block-item code-block-item-list?
  Node(
    kind: .codeBlockItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.codeBlockItem]
  ),

  // code-block-item = (decl | stmt | expr) ';'?
  Node(
    kind: .codeBlockItem,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: "A CodeBlockItem is any Syntax node that appears on its own line inside a CodeBlock.",
    parserFunction: "parseNonOptionalCodeBlockItem",
    children: [
      Child(
        name: "Item",
        kind: .nodeChoices(choices: [
          Child(
            name: "Decl",
            kind: .node(kind: .decl)
          ),
          Child(
            name: "Stmt",
            kind: .node(kind: .stmt)
          ),
          Child(
            name: "Expr",
            kind: .node(kind: .expr)
          ),
        ]),
        documentation: "The underlying node inside the code block."
      ),
      Child(
        name: "Semicolon",
        kind: .token(choices: [.token(tokenKind: "SemicolonToken")]),
        documentation: "If present, the trailing semicolon at the end of the item.",
        isOptional: true
      ),
    ]
  ),

  // code-block -> '{' stmt-list '}'
  Node(
    kind: .codeBlock,
    base: .syntax,
    nameForDiagnostics: "code block",
    traits: [
      "Braced",
      "WithStatements",
    ],
    children: [
      Child(
        name: "LeftBrace",
        kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])
      ),
      Child(
        name: "Statements",
        kind: .collection(kind: .codeBlockItemList, collectionElementName: "Statement"),
        nameForDiagnostics: "statements",
        isIndented: true
      ),
      Child(
        name: "RightBrace",
        kind: .token(choices: [.token(tokenKind: "RightBraceToken")])
      ),
    ]
  ),

  // accessor-effect-specifiers -> (async)? (throws)?
  Node(
    kind: .accessorEffectSpecifiers,
    base: .syntax,
    nameForDiagnostics: "accessor specifiers",
    traits: [
      "EffectSpecifiers"
    ],
    children: [
      Child(
        name: "AsyncSpecifier",
        kind: .token(choices: [.keyword(text: "async")]),
        isOptional: true
      ),
      Child(
        name: "ThrowsSpecifier",
        kind: .token(choices: [.keyword(text: "throws")]),
        isOptional: true
      ),
    ]
  ),

  // funtion-effect-specifiers -> (async | reasync)? (throws | rethrows)?
  Node(
    kind: .functionEffectSpecifiers,
    base: .syntax,
    nameForDiagnostics: "effect specifiers",
    traits: [
      "EffectSpecifiers"
    ],
    children: [
      Child(
        name: "AsyncSpecifier",
        kind: .token(choices: [.keyword(text: "async"), .keyword(text: "reasync")]),
        isOptional: true
      ),
      Child(
        name: "ThrowsSpecifier",
        kind: .token(choices: [.keyword(text: "throws"), .keyword(text: "rethrows")]),
        isOptional: true
      ),
    ]
  ),

  // deinit-effect-specifiers -> async?
  Node(
    kind: .deinitEffectSpecifiers,
    base: .syntax,
    nameForDiagnostics: "effect specifiers",
    traits: [],
    children: [
      Child(
        name: "AsyncSpecifier",
        kind: .token(choices: [.keyword(text: "async")]),
        isOptional: true
      )
    ]
  ),

  Node(
    kind: .decl,
    base: .syntax,
    nameForDiagnostics: "declaration",
    parserFunction: "parseDeclaration"
  ),

  Node(
    kind: .expr,
    base: .syntax,
    nameForDiagnostics: "expression",
    parserFunction: "parseExpression"
  ),

  Node(
    kind: .missingDecl,
    base: .decl,
    nameForDiagnostics: "declaration",
    documentation: "In case the source code is missing a declaration, this node stands in place of the missing declaration.",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute"),
        documentation: "If there were standalone attributes without a declaration to attach them to, the ``MissingDeclSyntax`` will contain these.",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: .modifierList, collectionElementName: "Modifier"),
        documentation: "If there were standalone modifiers without a declaration to attach them to, the ``MissingDeclSyntax`` will contain these.",
        isOptional: true
      ),
      Child(
        name: "Placeholder",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#decl#>` that can be inserted into the source code to represent the missing declaration.
          This token should always have `presence = .missing`.
          """
      ),
    ]
  ),

  Node(
    kind: .missingExpr,
    base: .expr,
    nameForDiagnostics: "expression",
    documentation: "In case the source code is missing a expression, this node stands in place of the missing expression.",
    children: [
      Child(
        name: "Placeholder",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#expression#>` that can be inserted into the source code to represent the missing expression.
          This token should always have `presence = .missing`.
          """
      )
    ]
  ),

  Node(
    kind: .missingPattern,
    base: .pattern,
    nameForDiagnostics: "pattern",
    documentation: "In case the source code is missing a pattern, this node stands in place of the missing pattern.",
    children: [
      Child(
        name: "Placeholder",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#pattern#>` that can be inserted into the source code to represent the missing pattern.
          This token should always have `presence = .missing`.
          """
      )
    ]
  ),

  Node(
    kind: .missingStmt,
    base: .stmt,
    nameForDiagnostics: "statement",
    documentation: "In case the source code is missing a statement, this node stands in place of the missing statement.",
    children: [
      Child(
        name: "Placeholder",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#statement#>` that can be inserted into the source code to represent the missing pattern.
          This token should always have `presence = .missing`.
          """
      )
    ]
  ),

  Node(
    kind: .missing,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: "In case the source code is missing a syntax node, this node stands in place of the missing node.",
    children: [
      Child(
        name: "Placeholder",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#syntax#>` that can be inserted into the source code to represent the missing pattern.
          This token should always have `presence = .missing`
          """
      )
    ]
  ),

  Node(
    kind: .missingType,
    base: .type,
    nameForDiagnostics: "type",
    documentation: "In case the source code is missing a type, this node stands in place of the missing type.",
    children: [
      Child(
        name: "Placeholder",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#type#>` that can be inserted into the source code to represent the missing type. This token should always have `presence = .missing`.
          """
      )
    ]
  ),

  Node(
    kind: .pattern,
    base: .syntax,
    nameForDiagnostics: "pattern",
    parserFunction: "parsePattern"
  ),

  Node(
    kind: .stmt,
    base: .syntax,
    nameForDiagnostics: "statement",
    parserFunction: "parseStatement"
  ),

  // type-effect-specifiers -> async? throws?
  Node(
    kind: .typeEffectSpecifiers,
    base: .syntax,
    nameForDiagnostics: "effect specifiers",
    traits: [
      "EffectSpecifiers"
    ],
    children: [
      Child(
        name: "AsyncSpecifier",
        kind: .token(choices: [.keyword(text: "async")]),
        isOptional: true
      ),
      Child(
        name: "ThrowsSpecifier",
        kind: .token(choices: [.keyword(text: "throws")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .type,
    base: .syntax,
    nameForDiagnostics: "type",
    parserFunction: "parseType"
  ),

  Node(
    kind: .unexpectedNodes,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    documentation: "A collection of syntax nodes that occurred in the source code but could not be used to form a valid syntax tree.",
    elementChoices: [.syntax]
  ),

]
