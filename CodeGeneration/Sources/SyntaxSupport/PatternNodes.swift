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
        name: "Expression",
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
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .keyword(text: "self"), .keyword(text: "init")])
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
        name: "IsKeyword",
        kind: .token(choices: [.keyword(text: "is")])
      ),
      Child(
        name: "Type",
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
        name: "LabelName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
      Child(
        name: "LabelColon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        isOptional: true
      ),
      Child(
        name: "Pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
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
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Elements",
        kind: .collection(kind: .tuplePatternElementList, collectionElementName: "Element")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
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
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Type",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // value-binding-pattern -> 'let' pattern
  //                        | 'var' pattern
  //                        | 'inout' pattern
  Node(
    kind: .valueBindingPattern,
    base: .pattern,
    nameForDiagnostics: "value binding pattern",
    children: [
      Child(
        name: "BindingKeyword",
        kind: .token(choices: [.keyword(text: "let"), .keyword(text: "var"), .keyword(text: "inout")])
      ),
      Child(
        name: "ValuePattern",
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
        name: "Wildcard",
        kind: .token(choices: [.token(tokenKind: "WildcardToken")])
      ),
      Child(
        name: "TypeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
    ]
  ),

]
