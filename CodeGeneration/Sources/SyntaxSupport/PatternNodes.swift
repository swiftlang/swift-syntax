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

public let PATTERN_NODES: [Node] = [
  // expr-pattern -> expr
  Node(
    kind: .expressionPattern,
    base: .pattern,
    nameForDiagnostics: "pattern",
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      )
    ]
  ),
  // identifier-pattern -> identifier
  Node(
    kind: .identifierPattern,
    base: .pattern,
    nameForDiagnostics: "pattern",
    children: [
      Child(
        name: "identifier",
        kind: .token(choices: [.token(.identifier), .keyword(.self), .keyword(.`init`)])
      )
    ]
  ),

  // is-type-pattern -> 'is' type
  Node(
    kind: .isTypePattern,
    base: .pattern,
    nameForDiagnostics: "'is' pattern",
    children: [
      Child(
        name: "isKeyword",
        kind: .token(choices: [.keyword(.is)])
      ),
      Child(
        name: "type",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // tuple-pattern-element-list -> tuple-pattern-element
  //  tuple-pattern-element-list?
  Node(
    kind: .tuplePatternElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.tuplePatternElement]
  ),

  // tuple-pattern-element -> identifier? ':' pattern ','?
  Node(
    kind: .tuplePatternElement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "label",
        deprecatedName: "labelName",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
      Child(
        name: "colon",
        deprecatedName: "labelColon",
        kind: .token(choices: [.token(.colon)]),
        isOptional: true
      ),
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  // tuple-pattern -> '(' tuple-pattern-element-list ')'
  Node(
    kind: .tuplePattern,
    base: .pattern,
    nameForDiagnostics: "tuple pattern",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "elements",
        kind: .collection(kind: .tuplePatternElementList, collectionElementName: "Element")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  // type-annotation -> ':' type
  Node(
    kind: .typeAnnotation,
    base: .syntax,
    nameForDiagnostics: "type annotation",
    children: [
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "type",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // value-binding-pattern -> 'let' pattern
  //                        | 'var' pattern
  //                        | 'inout' pattern
  //                        | '_mutating' pattern
  //                        | '_consuming' pattern
  //                        | '_borrowing' pattern
  Node(
    kind: .valueBindingPattern,
    base: .pattern,
    nameForDiagnostics: "value binding pattern",
    children: [
      Child(
        name: "bindingSpecifier",
        deprecatedName: "bindingKeyword",
        kind: .token(choices: [
          .keyword(.let), .keyword(.var), .keyword(.inout),
          .keyword(._mutating), .keyword(._borrowing), .keyword(._consuming),
        ])
      ),
      Child(
        name: "pattern",
        deprecatedName: "valuePattern",
        kind: .node(kind: .pattern)
      ),
    ]
  ),

  // wildcard-pattern -> '_' type-annotation?
  Node(
    kind: .wildcardPattern,
    base: .pattern,
    nameForDiagnostics: "wildcard pattern",
    children: [
      Child(
        name: "wildcard",
        kind: .token(choices: [.token(.wildcard)])
      )
    ]
  ),

]
