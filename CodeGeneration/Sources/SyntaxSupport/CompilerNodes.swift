//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public let COMPILER_NODES: [Node] = [
  Node(
    kind: .availabilityMacroDefinitionFile,
    base: .syntax,
    spi: "Compiler",
    nameForDiagnostics: "availability macro definition",
    documentation: """
      Syntax for '-define-availability' compiler arguments, never appear in Swift source code.
      """,
    parserFunction: "parseAvailabilityMacroDefinitionFile",
    children: [
      Child(
        name: "platformVersion",
        kind: .node(kind: .platformVersion)
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "specs",
        kind: .collection(kind: .availabilityArgumentList)
      ),
      Child(
        name: "endOfFileToken",
        kind: .token(choices: [.token(.endOfFile)])
      ),
    ]
  ),

  Node(
    kind: .accessorBlockFile,
    base: .syntax,
    spi: "Compiler",
    nameForDiagnostics: "accessors",
    documentation: """
      Syntax for 'accessor' macro expansion, never appear in Swift source code.
      """,
    parserFunction: "parseAccessorBlockFile",
    children: [
      Child(
        name: "leftBrace",
        kind: .token(choices: [.token(.leftBrace)]),
        isOptional: true
      ),
      Child(
        name: "accessors",
        kind: .collection(kind: .accessorDeclList)
      ),
      Child(
        name: "rightBrace",
        kind: .token(choices: [.token(.rightBrace)]),
        isOptional: true
      ),
      Child(
        name: "endOfFileToken",
        kind: .token(choices: [.token(.endOfFile)])
      ),
    ]
  ),

  Node(
    kind: .attributeClauseFile,
    base: .syntax,
    spi: "Compiler",
    nameForDiagnostics: "attribute list",
    documentation: """
      Syntax for 'memberAttribute' macro expansion or 'swift_attr' attribute in Clang, never appear in Swift source code.
      """,
    parserFunction: "parseAttributeClauseFile",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(
          kind: .attributeList,
          collectionElementName: "Attribute"
        )
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList)
      ),
      Child(
        name: "endOfFileToken",
        kind: .token(choices: [.token(.endOfFile)])
      ),
    ]
  ),

  Node(
    kind: .codeBlockFile,
    base: .syntax,
    spi: "Compiler",
    nameForDiagnostics: "code block",
    documentation: """
      Syntax for 'body' macro expansions, never appear in Swift source code.
      """,
    parserFunction: "parseCodeBlockFile",
    children: [
      Child(
        name: "body",
        kind: .node(kind: .codeBlock)
      ),
      Child(
        name: "endOfFileToken",
        kind: .token(choices: [.token(.endOfFile)])
      ),
    ]
  ),

  Node(
    kind: .memberBlockItemListFile,
    base: .syntax,
    spi: "Compiler",
    nameForDiagnostics: "member list",
    documentation: """
      Syntax for declaration macro expansions in type contexts, never appear in Swift source code.
      """,
    parserFunction: "parseMemberBlockItemListFile",
    children: [
      Child(
        name: "members",
        kind: .collection(kind: .memberBlockItemList)
      ),
      Child(
        name: "endOfFileToken",
        kind: .token(choices: [.token(.endOfFile)])
      ),
    ]
  ),
]
