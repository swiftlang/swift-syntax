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
  Node(
    kind: .codeBlockItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.codeBlockItem]
  ),

  Node(
    kind: .codeBlockItem,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: "A CodeBlockItem is any Syntax node that appears on its own line inside a CodeBlock.",
    parserFunction: "parseNonOptionalCodeBlockItem",
    children: [
      Child(
        name: "item",
        kind: .nodeChoices(choices: [
          Child(
            name: "decl",
            kind: .node(kind: .decl)
          ),
          Child(
            name: "stmt",
            kind: .node(kind: .stmt)
          ),
          Child(
            name: "expr",
            kind: .node(kind: .expr)
          ),
        ]),
        documentation: "The underlying node inside the code block."
      ),
      Child(
        name: "semicolon",
        kind: .token(choices: [.token(.semicolon)]),
        documentation: "If present, the trailing semicolon at the end of the item.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .codeBlock,
    base: .syntax,
    nameForDiagnostics: "code block",
    parserFunction: "parseCodeBlock",
    traits: [
      "Braced",
      "WithStatements",
    ],
    children: [
      Child(
        name: "leftBrace",
        kind: .token(choices: [.token(.leftBrace)]),
        documentation: "The brace introducing the code block."
      ),
      Child(
        name: "statements",
        kind: .collection(kind: .codeBlockItemList, collectionElementName: "Statement"),
        nameForDiagnostics: "statements"
      ),
      Child(
        name: "rightBrace",
        kind: .token(choices: [.token(.rightBrace)]),
        documentation: "The brace closing the code block."
      ),
    ]
  ),

  Node(
    kind: .throwsClause,
    base: .syntax,
    nameForDiagnostics: "throws clause",
    children: [
      Child(
        name: "throwsSpecifier",
        kind: .token(choices: [.keyword(.throws), .keyword(.rethrows)]),
        documentation: "The `throws` keyword."
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        documentation: "The '(' to open the thrown error type specification.",
        isOptional: true
      ),
      Child(
        name: "type",
        kind: .node(kind: .type),
        nameForDiagnostics: "thrown type",
        documentation: "The thrown error type.",
        isOptional: true
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        documentation: "The ')' to close the thrown error type specification.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .accessorEffectSpecifiers,
    base: .syntax,
    nameForDiagnostics: "accessor specifiers",
    traits: [
      "EffectSpecifiers"
    ],
    children: [
      Child(
        name: "asyncSpecifier",
        kind: .token(choices: [.keyword(.async)]),
        documentation: "The `async` keyword.",
        isOptional: true
      ),
      Child(
        name: "throwsClause",
        kind: .node(kind: .throwsClause),
        documentation: "The clause specifying thrown errors",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .functionEffectSpecifiers,
    base: .syntax,
    nameForDiagnostics: "effect specifiers",
    traits: [
      "EffectSpecifiers"
    ],
    children: [
      Child(
        name: "asyncSpecifier",
        kind: .token(choices: [.keyword(.async), .keyword(.reasync)]),
        documentation: "The `async` or `reasync` keyword.",
        isOptional: true
      ),
      Child(
        name: "throwsClause",
        kind: .node(kind: .throwsClause),
        documentation: "The clause specifying thrown errors",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .deinitializerEffectSpecifiers,
    base: .syntax,
    nameForDiagnostics: "effect specifiers",
    traits: [],
    children: [
      Child(
        name: "asyncSpecifier",
        kind: .token(choices: [.keyword(.async)]),
        documentation: "The `async` keyword.",
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
      "MissingNode",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        documentation: "If there were standalone attributes without a declaration to attach them to, the ``MissingDeclSyntax`` will contain these."
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        documentation: "If there were standalone modifiers without a declaration to attach them to, the ``MissingDeclSyntax`` will contain these."
      ),
      Child(
        name: "placeholder",
        kind: .token(choices: [.token(.identifier)], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#decl#>`, that can be inserted into the source code to represent the missing declaration.

          This token should always have `presence = .missing`.
          """
      ),
    ]
  ),

  Node(
    kind: .missingExpr,
    base: .expr,
    nameForDiagnostics: "expression",
    documentation: "In case the source code is missing an expression, this node stands in place of the missing expression.",
    traits: [
      "MissingNode"
    ],
    children: [
      Child(
        name: "placeholder",
        kind: .token(choices: [.token(.identifier)], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#expression#>`, that can be inserted into the source code to represent the missing expression.

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
    traits: [
      "MissingNode"
    ],
    children: [
      Child(
        name: "placeholder",
        kind: .token(choices: [.token(.identifier)], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#pattern#>`, that can be inserted into the source code to represent the missing pattern.

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
    traits: [
      "MissingNode"
    ],
    children: [
      Child(
        name: "placeholder",
        kind: .token(choices: [.token(.identifier)], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#statement#>`, that can be inserted into the source code to represent the missing pattern.

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
    traits: [
      "MissingNode"
    ],
    children: [
      Child(
        name: "placeholder",
        kind: .token(choices: [.token(.identifier)], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#syntax#>`, that can be inserted into the source code to represent the missing pattern.

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
    traits: [
      "MissingNode"
    ],
    children: [
      Child(
        name: "placeholder",
        kind: .token(choices: [.token(.identifier)], requiresLeadingSpace: false, requiresTrailingSpace: false),
        documentation: """
          A placeholder, i.e. `<#type#>`, that can be inserted into the source code to represent the missing type.

          This token should always have `presence = .missing`.
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

  Node(
    kind: .typeEffectSpecifiers,
    base: .syntax,
    nameForDiagnostics: "effect specifiers",
    traits: [
      "EffectSpecifiers"
    ],
    children: [
      Child(
        name: "asyncSpecifier",
        kind: .token(choices: [.keyword(.async)]),
        isOptional: true
      ),
      Child(
        name: "throwsClause",
        kind: .node(kind: .throwsClause),
        documentation: "The clause specifying thrown errors",
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
