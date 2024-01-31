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
  Node(
    kind: .expressionPattern,
    base: .pattern,
    nameForDiagnostics: "pattern",
    documentation: """
      A pattern that contains an ``ExprSyntaxProtocol``.

      ### Examples

      Patterns can be used in switch cases like the following example:
      ```swift
      switch raw.kind {
        case .expressionPattern:
          return true
        default:
          return false
      }
      ```
      """,
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      )
    ]
  ),

  Node(
    kind: .identifierPattern,
    base: .pattern,
    nameForDiagnostics: "pattern",
    documentation: """
      A pattern that contains a ``TokenSyntax``.

      ### Examples

      ``IdentifierPatternSyntax`` can be used in simplple variable declarations.
      For example `a` in the exmaple:

      ```swift
      let a = 1
      ```
      """,
    children: [
      Child(
        name: "identifier",
        kind: .token(
          choices: [
            .token(.identifier),
            .keyword(.self),
            .keyword(.`init`),
            .keyword(.`deinit`),
            .keyword(.`subscript`),
          ]
        )
      )
    ]
  ),

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

  Node(
    kind: .tuplePatternElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    documentation: """
      A list of ``TuplePatternElementSyntax``.
      """,
    elementChoices: [.tuplePatternElement]
  ),

  Node(
    kind: .tuplePatternElement,
    base: .syntax,
    nameForDiagnostics: nil,
    documentation: """
      An element that represents a single tuple value in ``TuplePatternElementListSyntax``.
      """,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "label",
        deprecatedName: "labelName",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "label",
        documentation: "The label of the pattern.",
        isOptional: true
      ),
      Child(
        name: "colon",
        deprecatedName: "labelColon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating label and pattern.",
        isOptional: true
      ),
      Child(
        name: "pattern",
        kind: .node(kind: .pattern),
        documentation: "The value of this labeled pattern."
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "The comma separating elements.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .tuplePattern,
    base: .pattern,
    nameForDiagnostics: "tuple pattern",
    documentation: """
      A pattern that contains a list of other pattern.

      ### Examples

      ``TuplePatternSyntax`` can be used in more complex variable declarations.
      For example `(x, y)` in the example:

      ```swift
      let (x, y) = (1, 2)
      ```
      """,
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        documentation: "The parent introducing the tuple."
      ),
      Child(
        name: "elements",
        kind: .collection(kind: .tuplePatternElementList, collectionElementName: "Element")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        documentation: "The paren closing the tuple."
      ),
    ]
  ),

  Node(
    kind: .typeAnnotation,
    base: .syntax,
    nameForDiagnostics: "type annotation",
    children: [
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating previous pattern and the type."
      ),
      Child(
        name: "type",
        kind: .node(kind: .type)
      ),
    ]
  ),

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

  Node(
    kind: .wildcardPattern,
    base: .pattern,
    nameForDiagnostics: "wildcard pattern",
    documentation: """
      A pattern that represent a wildcard.

      ### Examples

      ``WildcardPatternSyntax`` matches and ignores any value.
      For example `_` in the example:

      ```swift
      for _ in 1...3 {
        // ...
      }
      ```
      """,
    children: [
      Child(
        name: "wildcard",
        kind: .token(choices: [.token(.wildcard)])
      )
    ]
  ),

]
