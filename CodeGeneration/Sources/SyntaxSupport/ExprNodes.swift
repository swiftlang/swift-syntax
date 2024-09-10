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

public let EXPR_NODES: [Node] = [
  Node(
    kind: .arrayElementList,
    nameForDiagnostics: nil,
    elementChoices: [.arrayElement]
  ),

  Node(
    kind: .arrayElement,
    nameForDiagnostics: "array element",
    documentation: "An element inside an array literal.",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "value"
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .arrayExpr,
    nameForDiagnostics: "array",
    documentation: "An array literal.",
    children: [
      Child(
        name: "leftSquare",
        deprecatedName: "leftSquareBracket",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "elements",
        kind: .collection(kind: .arrayElementList, collectionElementName: "Element")
      ),
      Child(
        name: "rightSquare",
        deprecatedName: "rightSquareBracket",
        kind: .token(choices: [.token(.rightSquare)])
      ),
    ]
  ),

  Node(
    kind: .arrowExpr,
    nameForDiagnostics: nil,
    documentation: """
      The arrow when a type is used at a position that syntactically expectes an expression.

      ### Examples

      This represents the arrow in

      ```swift
      let array = [(Int) -> Int]()
      ```
      """,
    children: [
      Child(
        name: "effectSpecifiers",
        kind: .node(kind: .typeEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "arrow",
        deprecatedName: "arrowToken",
        kind: .token(choices: [.token(.arrow)])
      ),
    ]
  ),

  Node(
    kind: .asExpr,
    nameForDiagnostics: "'as'",
    documentation: """
      The cast of an expressison to a different type.

      ### Examples

      ```swift
      dog as Animal
      ``` 

      ```swift
      myPet as? Dog
      ```

      - Note: This node is only generated after operators are folded using the `SwiftOperators` library. 
        Beforehand, the parser does not know the precedences of operators and thus represents `is` by an ``UnresolvedAsExprSyntax``.
      """,
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "asKeyword",
        deprecatedName: "asTok",
        kind: .token(choices: [.keyword(.as)])
      ),
      Child(
        name: "questionOrExclamationMark",
        kind: .token(choices: [.token(.postfixQuestionMark), .token(.exclamationMark)]),
        isOptional: true
      ),
      Child(
        name: "type",
        deprecatedName: "typeName",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .assignmentExpr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "equal",
        deprecatedName: "assignToken",
        kind: .token(choices: [.token(.equal)])
      )
    ]
  ),

  Node(
    kind: .awaitExpr,
    nameForDiagnostics: "'await' expression",
    children: [
      Child(
        name: "awaitKeyword",
        kind: .token(choices: [.keyword(.await)])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .binaryOperatorExpr,
    nameForDiagnostics: "operator",
    documentation: """
      An operator like `+` or `-`.

      This node represents the binary operator itself. It can occur inside a ``SequenceExprSyntax`` 
      after parsing and will be the `operator` child of an ``InfixOperatorExprSyntax`` 
      after folding operator using the `SwiftOperators` library.
      """,
    children: [
      Child(
        name: "operator",
        deprecatedName: "operatorToken",
        kind: .token(choices: [.token(.binaryOperator)])
      )
    ]
  ),

  Node(
    kind: .booleanLiteralExpr,
    nameForDiagnostics: "bool literal",
    children: [
      Child(
        name: "literal",
        deprecatedName: "booleanLiteral",
        kind: .token(choices: [.keyword(.true), .keyword(.false)])
      )
    ]
  ),

  Node(
    kind: .borrowExpr,
    nameForDiagnostics: "'_borrow' expression",
    children: [
      Child(
        name: "borrowKeyword",
        kind: .token(choices: [.keyword(._borrow)])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: ._canImportExpr,
    nameForDiagnostics: "'canImport' expression",
    children: [
      Child(
        name: "canImportKeyword",
        kind: .token(choices: [.keyword(.canImport)])
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "importPath",
        kind: .token(choices: [.token(.identifier)])
      ),
      Child(
        name: "versionInfo",
        kind: .node(kind: ._canImportVersionInfo),
        isOptional: true
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: ._canImportVersionInfo,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)])
      ),
      Child(
        name: "label",
        kind: .token(choices: [.keyword(._version), .keyword(._underlyingVersion)])
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "version",
        deprecatedName: "versionTuple",
        kind: .node(kind: .versionTuple)
      ),
    ]
  ),

  Node(
    kind: .switchCaseItem,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "whereClause",
        kind: .node(kind: .whereClause),
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .closureCaptureList,
    nameForDiagnostics: nil,
    elementChoices: [.closureCapture]
  ),

  Node(
    kind: .closureCaptureSpecifier,
    nameForDiagnostics: "closure capture specifier",
    children: [
      Child(
        name: "specifier",
        kind: .token(choices: [.keyword(.weak), .keyword(.unowned)])
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        isOptional: true
      ),
      Child(
        name: "detail",
        kind: .token(choices: [.keyword(.safe), .keyword(.unsafe)]),
        isOptional: true
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .closureCapture,
    nameForDiagnostics: "closure capture",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "specifier",
        kind: .node(kind: .closureCaptureSpecifier),
        isOptional: true
      ),
      Child(
        name: "name",
        kind: .token(choices: [.token(.identifier), .keyword(.self)])
      ),
      Child(
        name: "initializer",
        kind: .node(kind: .initializerClause),
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .closureCaptureClause,
    nameForDiagnostics: "closure capture clause",
    children: [
      Child(
        name: "leftSquare",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "items",
        kind: .collection(kind: .closureCaptureList, collectionElementName: "Item")
      ),
      Child(
        name: "rightSquare",
        kind: .token(choices: [.token(.rightSquare)])
      ),
    ]
  ),

  Node(
    kind: .closureParameter,
    nameForDiagnostics: "parameter",
    parserFunction: "parseClosureParameter",
    traits: ["WithTrailingComma", "WithAttributes", "WithModifiers"],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "modifiers",
        kind: .collection(kind: .declModifierList, collectionElementName: "Modifier", defaultsToEmpty: true),
        nameForDiagnostics: "modifiers"
      ),
      Child(
        name: "firstName",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        documentation: "The label of this parameter that will be used when the closure is called."
      ),
      Child(
        name: "secondName",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        documentation:
          "If this is specified, it is the name by which the parameter can be referenced inside the closure body. If it is `nil`, the closure parameter is referenced by the first name.",
        isOptional: true
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating the parameter's name and type.",
        isOptional: true
      ),
      Child(
        name: "type",
        kind: .node(kind: .type),
        nameForDiagnostics: "type",
        documentation: "The type of the parameter.",
        isOptional: true
      ),
      Child(
        name: "ellipsis",
        kind: .token(choices: [.token(.ellipsis)]),
        documentation: "If the parameter is variadic, `...` to indicate that.",
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "If the parameter is followed by another parameter, the comma separating them.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .closureParameterList,
    nameForDiagnostics: "parameter list",
    elementChoices: [.closureParameter]
  ),

  Node(
    kind: .closureParameterClause,
    nameForDiagnostics: "parameter clause",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        documentation: "The '(' to open the parameter clause."
      ),
      Child(
        name: "parameters",
        deprecatedName: "parameterList",
        kind: .collection(kind: .closureParameterList, collectionElementName: "Parameter"),
        nameForDiagnostics: "parameters",
        documentation: "The actual parameters."
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        documentation: "The ')' to close the parameter clause."
      ),
    ]
  ),

  Node(
    kind: .closureExpr,
    nameForDiagnostics: "closure",
    traits: [
      "Braced",
      "WithStatements",
    ],
    children: [
      Child(
        name: "leftBrace",
        kind: .token(choices: [.token(.leftBrace)])
      ),
      Child(
        name: "signature",
        kind: .node(kind: .closureSignature),
        isOptional: true
      ),
      Child(
        name: "statements",
        kind: .collection(kind: .codeBlockItemList, collectionElementName: "Statement")
      ),
      Child(
        name: "rightBrace",
        kind: .token(choices: [.token(.rightBrace)])
      ),
    ]
  ),

  Node(
    kind: .closureShorthandParameterList,
    nameForDiagnostics: nil,
    documentation: """
      A list of closure parameters that are not parenthesized and don't have type annotations.

      If the closure parameters are parenthesized, they can also carry type annotations. 
      In that case, the closure parameters are represented by ``ClosureParameterListSyntax``.

      ### Examples

      ```
      let closure = { a, b in
        return a + b
      }
      ```
      """,
    elementChoices: [.closureShorthandParameter]
  ),

  Node(
    kind: .closureShorthandParameter,
    nameForDiagnostics: "closure parameter",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "name",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .closureSignature,
    nameForDiagnostics: "closure signature",
    traits: [
      "WithAttributes"
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        nameForDiagnostics: "attributes"
      ),
      Child(
        name: "capture",
        kind: .node(kind: .closureCaptureClause),
        isOptional: true
      ),
      Child(
        name: "parameterClause",
        deprecatedName: "input",
        kind: .nodeChoices(choices: [
          Child(
            name: "simpleInput",
            kind: .node(kind: .closureShorthandParameterList)
          ),
          Child(
            name: "parameterClause",
            deprecatedName: "input",
            kind: .node(kind: .closureParameterClause)
          ),
        ]),
        isOptional: true
      ),
      Child(
        name: "effectSpecifiers",
        kind: .node(kind: .typeEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "returnClause",
        deprecatedName: "output",
        kind: .node(kind: .returnClause),
        isOptional: true
      ),
      Child(
        name: "inKeyword",
        deprecatedName: "inTok",
        kind: .token(choices: [.keyword(.in)])
      ),
    ]
  ),

  Node(
    kind: .declNameArgumentList,
    nameForDiagnostics: nil,
    elementChoices: [.declNameArgument]
  ),

  Node(
    kind: .declNameArgument,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "name",
        kind: .node(kind: .token)
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)], requiresTrailingSpace: false)
      ),
    ]
  ),

  Node(
    kind: .declNameArguments,
    nameForDiagnostics: nil,
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "arguments",
        kind: .collection(kind: .declNameArgumentList, collectionElementName: "Argument")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .dictionaryElementList,
    nameForDiagnostics: nil,
    elementChoices: [.dictionaryElement]
  ),

  Node(
    kind: .dictionaryElement,
    nameForDiagnostics: "dictionary element",
    documentation: "An element inside a dictionary literal.",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "key",
        deprecatedName: "keyExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "key"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "value",
        deprecatedName: "valueExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "value"
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .dictionaryExpr,
    nameForDiagnostics: "dictionary",
    documentation: "A dictionary literal",
    children: [
      Child(
        name: "leftSquare",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "content",
        kind: .nodeChoices(choices: [
          Child(
            name: "colon",
            kind: .token(choices: [.token(.colon)], requiresTrailingSpace: false)
          ),
          Child(
            name: "elements",
            kind: .node(kind: .dictionaryElementList)
          ),
        ])
      ),
      Child(
        name: "rightSquare",
        kind: .token(choices: [.token(.rightSquare)])
      ),
    ]
  ),

  Node(
    kind: .discardAssignmentExpr,
    nameForDiagnostics: nil,
    documentation: """
      A `_` that discards a value inside an assignment.

      ### Examples

      ```swift
      _ = 42
      ``` 


      ```swift
      if case .foo(_) = myValue
      ```
      """,
    children: [
      Child(
        name: "wildcard",
        kind: .token(choices: [.token(.wildcard)])
      )
    ]
  ),

  Node(
    kind: .doExpr,
    experimentalFeature: .doExpressions,
    nameForDiagnostics: "'do' block",
    documentation: """
      A `do` block with one of more optional `catch` clauses.

      This represents do blocks in both expression and statement postitions
      (where the latter are wrapped in ExpressionStmtSyntax).

      ### Examples

      ```swift
      do {
        let x = 0
        print(x)
      }
      ```

      ```swift
      let x = do {
        try someThrowingFn()
      } catch {
        defaultValue
      }
      ```
      """,
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "doKeyword",
        kind: .token(choices: [.keyword(.do)])
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "catchClauses",
        kind: .collection(kind: .catchClauseList, collectionElementName: "CatchClause", defaultsToEmpty: true)
      ),
    ]
  ),

  Node(
    kind: .editorPlaceholderExpr,
    nameForDiagnostics: "editor placeholder",
    documentation: """
      - Warning: This ``EditorPlaceholderExprSyntax`` node is not generated by the parser anymore. Placeholders are represented by a ``DeclReferenceExprSyntax``.
      """,
    children: [
      Child(
        name: "placeholder",
        deprecatedName: "identifier",
        kind: .token(choices: [.token(.identifier)])
      )
    ]
  ),

  Node(
    kind: .exprList,
    nameForDiagnostics: nil,
    documentation: "A list of expressions connected by operators. This list is contained by a ``SequenceExprSyntax``.",
    elementChoices: [.expr]
  ),

  Node(
    kind: .expressionSegment,
    nameForDiagnostics: nil,
    documentation: """
      An interpolated expression inside a string literal.

      - SeeAlso: ``StringSegmentSyntax``
      """,
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "backslash",
        kind: .token(choices: [.token(.backslash)])
      ),
      Child(
        name: "pounds",
        deprecatedName: "delimiter",
        kind: .token(choices: [.token(.rawStringPoundDelimiter)]),
        isOptional: true
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "expressions",
        kind: .collection(kind: .labeledExprList, collectionElementName: "Expression")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .floatLiteralExpr,
    nameForDiagnostics: "floating literal",
    children: [
      Child(
        name: "literal",
        deprecatedName: "floatingDigits",
        kind: .token(choices: [.token(.floatLiteral)])
      )
    ]
  ),

  Node(
    kind: .forceUnwrapExpr,
    nameForDiagnostics: "force unwrap",
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "exclamationMark",
        kind: .token(choices: [.token(.exclamationMark)])
      ),
    ]
  ),

  Node(
    kind: .functionCallExpr,
    nameForDiagnostics: "function call",
    children: [
      Child(
        name: "calledExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "called expression"
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        isOptional: true
      ),
      Child(
        name: "arguments",
        deprecatedName: "argumentList",
        kind: .collection(kind: .labeledExprList, collectionElementName: "Argument"),
        nameForDiagnostics: "arguments"
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        isOptional: true
      ),
      Child(
        name: "trailingClosure",
        kind: .node(kind: .closureExpr),
        nameForDiagnostics: "trailing closure",
        isOptional: true
      ),
      Child(
        name: "additionalTrailingClosures",
        kind: .collection(
          kind: .multipleTrailingClosureElementList,
          collectionElementName: "AdditionalTrailingClosure",
          defaultsToEmpty: true
        ),
        nameForDiagnostics: "trailing closures"
      ),
    ]
  ),

  Node(
    kind: .declReferenceExpr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "baseName",
        deprecatedName: "identifier",
        kind: .token(choices: [
          .token(.identifier),
          .keyword(.self),
          .keyword(.Self),
          .keyword(.`init`),
          .keyword(.`deinit`),
          .keyword(.`subscript`),
          .token(.dollarIdentifier),
          .token(.binaryOperator),
          .token(.integerLiteral),
        ])
      ),
      Child(
        name: "argumentNames",
        deprecatedName: "declNameArguments",
        kind: .node(kind: .declNameArguments),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .ifExpr,
    nameForDiagnostics: "'if' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "ifKeyword",
        kind: .token(choices: [.keyword(.if)])
      ),
      Child(
        name: "conditions",
        kind: .collection(kind: .conditionElementList, collectionElementName: "Condition")
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "elseKeyword",
        kind: .token(choices: [.keyword(.else)]),
        isOptional: true
      ),
      Child(
        name: "elseBody",
        kind: .nodeChoices(choices: [
          Child(
            name: "ifExpr",
            kind: .node(kind: .ifExpr)
          ),
          Child(
            name: "codeBlock",
            kind: .node(kind: .codeBlock)
          ),
        ]),
        nameForDiagnostics: "else body",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .inOutExpr,
    nameForDiagnostics: "inout expression",
    documentation: "An expression prefixed with `&` to pass an argument to an `inout` parameter.",
    children: [
      Child(
        name: "ampersand",
        kind: .token(choices: [.token(.prefixAmpersand)])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .infixOperatorExpr,
    nameForDiagnostics: nil,
    documentation: """
      An infix operator call like `1 + 2`.

      - Note: This node is only generated after operators are folded using the `SwiftOperators` library. 
        Beforehand, the parser does not know the precedences of operators and thus the operator is just
        a ``BinaryOperatorExprSyntax`` in a ``SequenceExprSyntax``.
      """,
    children: [
      Child(
        name: "leftOperand",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "operator",
        deprecatedName: "operatorOperand",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "rightOperand",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .integerLiteralExpr,
    nameForDiagnostics: "integer literal",
    children: [
      Child(
        name: "literal",
        deprecatedName: "digits",
        kind: .token(choices: [.token(.integerLiteral)])
      )
    ]
  ),

  Node(
    kind: .isExpr,
    nameForDiagnostics: "'is'",
    documentation: """
      Checks if an expression is of a given type.

      An example of an `is` expression is

      ```swift
      value is Double
      ```

      - Note: This node is only generated after operators are folded using the `SwiftOperators` library. 
        Beforehand, the parser does not know the precedences of operators and thus represents `is` by an `UnresolvedIsExpr`.
      """,
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr),
        documentation: "The expression which will be checked to determine whether it can be cast to a specific type."
      ),
      Child(
        name: "isKeyword",
        deprecatedName: "isTok",
        kind: .token(choices: [.keyword(.is)]),
        documentation: "The `is` keyword for this expression."
      ),
      Child(
        name: "type",
        deprecatedName: "typeName",
        kind: .node(kind: .type),
        documentation:
          "The type against which the expression will be checked to see if the expression can be cast to it."
      ),
    ]
  ),

  Node(
    kind: .keyPathComponentList,
    nameForDiagnostics: nil,
    documentation: "The components of a key path",
    elementChoices: [.keyPathComponent]
  ),

  Node(
    kind: .keyPathComponent,
    nameForDiagnostics: "key path component",
    documentation: "A single key path component",
    children: [
      Child(
        name: "period",
        kind: .token(choices: [.token(.period)]),
        isOptional: true
      ),
      Child(
        name: "component",
        kind: .nodeChoices(choices: [
          Child(
            name: "property",
            kind: .node(kind: .keyPathPropertyComponent)
          ),
          Child(
            name: "subscript",
            kind: .node(kind: .keyPathSubscriptComponent)
          ),
          Child(
            name: "optional",
            kind: .node(kind: .keyPathOptionalComponent)
          ),
        ])
      ),
    ]
  ),

  Node(
    kind: .keyPathExpr,
    nameForDiagnostics: "key path",
    documentation: #"""
      A key path.

      ### Examples

      ```swift
      \a.b[2].a
      ```
      """#,
    children: [
      Child(
        name: "backslash",
        kind: .token(choices: [.token(.backslash)])
      ),
      Child(
        name: "root",
        kind: .node(kind: .type),
        nameForDiagnostics: "root",
        isOptional: true
      ),
      Child(
        name: "components",
        kind: .collection(kind: .keyPathComponentList, collectionElementName: "KeyPathComponent")
      ),
    ]
  ),

  Node(
    kind: .keyPathOptionalComponent,
    nameForDiagnostics: "key path optional component",
    documentation: "A key path component like `?` or `!`.",
    children: [
      Child(
        name: "questionOrExclamationMark",
        kind: .token(choices: [.token(.postfixQuestionMark), .token(.exclamationMark)])
      )
    ]
  ),

  Node(
    kind: .keyPathPropertyComponent,
    nameForDiagnostics: "key path property component",
    documentation: "A key path component like `.property` or `.1`.",
    children: [
      Child(
        name: "declName",
        kind: .node(kind: .declReferenceExpr)
      ),
      Child(
        name: "genericArgumentClause",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .keyPathSubscriptComponent,
    nameForDiagnostics: "key path subscript component",
    documentation: "A key path component like `.[17]`",
    children: [
      Child(
        name: "leftSquare",
        deprecatedName: "leftBracket",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "arguments",
        deprecatedName: "argumentList",
        kind: .collection(kind: .labeledExprList, collectionElementName: "Argument"),
        nameForDiagnostics: "arguments"
      ),
      Child(
        name: "rightSquare",
        deprecatedName: "rightBracket",
        kind: .token(choices: [.token(.rightSquare)])
      ),
    ]
  ),

  Node(
    kind: .macroExpansionExpr,
    nameForDiagnostics: "macro expansion",
    documentation: "The expansion of a freestanding macro in a position that expects an expression.",
    traits: [
      "FreestandingMacroExpansion"
    ],
    children: [
      Child(
        name: "pound",
        deprecatedName: "poundToken",
        kind: .token(choices: [.token(.pound)]),
        documentation: "The `#` sign."
      ),
      Child(
        name: "macroName",
        deprecatedName: "macro",
        kind: .token(choices: [.token(.identifier)])
      ),
      Child(
        name: "genericArgumentClause",
        deprecatedName: "genericArguments",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        isOptional: true
      ),
      Child(
        name: "arguments",
        deprecatedName: "argumentList",
        kind: .collection(kind: .labeledExprList, collectionElementName: "Argument")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        isOptional: true
      ),
      Child(
        name: "trailingClosure",
        kind: .node(kind: .closureExpr),
        isOptional: true
      ),
      Child(
        name: "additionalTrailingClosures",
        kind: .collection(
          kind: .multipleTrailingClosureElementList,
          collectionElementName: "AdditionalTrailingClosure",
          defaultsToEmpty: true
        )
      ),
    ]
  ),

  Node(
    kind: .memberAccessExpr,
    nameForDiagnostics: "member access",
    documentation: "An expression that access a member like a function or a property.",
    children: [
      Child(
        name: "base",
        kind: .node(kind: .expr),
        nameForDiagnostics: "base",
        documentation: "The base of the member access, optionally specified.",
        isOptional: true
      ),
      Child(
        name: "period",
        deprecatedName: "dot",
        kind: .token(choices: [.token(.period)])
      ),
      Child(
        name: "declName",
        kind: .node(kind: .declReferenceExpr),
        nameForDiagnostics: "name",
        documentation: "The name of the referenced function or a property."
      ),
    ]
  ),

  Node(
    kind: .consumeExpr,
    nameForDiagnostics: "'consume' expression",
    children: [
      Child(
        name: "consumeKeyword",
        deprecatedName: "moveKeyword",
        kind: .token(choices: [.keyword(._move), .keyword(.consume)])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .copyExpr,
    nameForDiagnostics: "'copy' expression",
    children: [
      Child(
        name: "copyKeyword",
        kind: .token(choices: [.keyword(.copy)])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .multipleTrailingClosureElementList,
    nameForDiagnostics: nil,
    elementChoices: [.multipleTrailingClosureElement]
  ),

  Node(
    kind: .multipleTrailingClosureElement,
    nameForDiagnostics: "trailing closure",
    children: [
      Child(
        name: "label",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        nameForDiagnostics: "label"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "closure",
        kind: .node(kind: .closureExpr)
      ),
    ]
  ),

  Node(
    kind: .nilLiteralExpr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "nilKeyword",
        kind: .token(choices: [.keyword(.nil)])
      )
    ]
  ),

  Node(
    kind: .optionalChainingExpr,
    nameForDiagnostics: "optional chaining",
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "questionMark",
        kind: .token(choices: [.token(.postfixQuestionMark)])
      ),
    ]
  ),

  Node(
    kind: .packElementExpr,
    nameForDiagnostics: nil,
    documentation: "A pack element expression spelled with `each`.",
    children: [
      Child(
        name: "eachKeyword",
        kind: .token(choices: [.keyword(.each)])
      ),
      Child(
        name: "pack",
        deprecatedName: "packRefExpr",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .packExpansionExpr,
    nameForDiagnostics: nil,
    documentation: "A pack expansion expression spelled with `repeat`.",
    children: [
      Child(
        name: "repeatKeyword",
        kind: .token(choices: [.keyword(.repeat)])
      ),
      Child(
        name: "repetitionPattern",
        deprecatedName: "patternExpr",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .postfixIfConfigExpr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "base",
        kind: .node(kind: .expr),
        isOptional: true
      ),
      Child(
        name: "config",
        kind: .node(kind: .ifConfigDecl)
      ),
    ]
  ),

  Node(
    kind: .postfixOperatorExpr,
    nameForDiagnostics: "postfix expression",
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "operator",
        deprecatedName: "operatorToken",
        kind: .token(choices: [.token(.postfixOperator)])
      ),
    ]
  ),

  Node(
    kind: .prefixOperatorExpr,
    nameForDiagnostics: "operator",
    documentation: """
      A prefix operator applied to a value.

      ### Examples

      ```swift
      -x
      ```

      ```swift
      !true
      ```
      """,
    children: [
      Child(
        name: "operator",
        deprecatedName: "operatorToken",
        kind: .token(choices: [.token(.prefixOperator)])
      ),
      Child(
        name: "expression",
        deprecatedName: "postfixExpression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .regexLiteralExpr,
    nameForDiagnostics: "regex literal",
    children: [
      Child(
        name: "openingPounds",
        kind: .token(choices: [.token(.regexPoundDelimiter)]),
        isOptional: true
      ),
      Child(
        name: "openingSlash",
        deprecatedName: "openSlash",
        kind: .token(choices: [.token(.regexSlash)])
      ),
      Child(
        name: "regex",
        deprecatedName: "regexPattern",
        kind: .token(choices: [.token(.regexLiteralPattern)])
      ),
      Child(
        name: "closingSlash",
        deprecatedName: "closeSlash",
        kind: .token(choices: [.token(.regexSlash)])
      ),
      Child(
        name: "closingPounds",
        kind: .token(choices: [.token(.regexPoundDelimiter)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .sequenceExpr,
    nameForDiagnostics: nil,
    documentation: """
      A flat list of expressions before operator folding using the `SwiftOperators` library.

      ### Examples

      ```swift
      1 + 2 + 3
      ```
      """,
    children: [
      Child(
        name: "elements",
        kind: .collection(kind: .exprList, collectionElementName: "Element")
      )
    ]
  ),

  Node(
    kind: .genericSpecializationExpr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "genericArgumentClause",
        kind: .node(kind: .genericArgumentClause)
      ),
    ]
  ),

  Node(
    kind: .stringLiteralExpr,
    nameForDiagnostics: "string literal",
    documentation: #"""
      A string literal.

      ### Examples

      ```swift
      "Hello \(userName())!"
      ```
      """#,
    children: [
      Child(
        name: "openingPounds",
        deprecatedName: "openDelimiter",
        kind: .token(choices: [.token(.rawStringPoundDelimiter)]),
        isOptional: true
      ),
      Child(
        name: "openingQuote",
        deprecatedName: "openQuote",
        kind: .token(choices: [.token(.stringQuote), .token(.multilineStringQuote), .token(.singleQuote)])
      ),
      Child(
        name: "segments",
        kind: .collection(kind: .stringLiteralSegmentList, collectionElementName: "Segment")
      ),
      Child(
        name: "closingQuote",
        deprecatedName: "closeQuote",
        kind: .token(choices: [.token(.stringQuote), .token(.multilineStringQuote), .token(.singleQuote)])
      ),
      Child(
        name: "closingPounds",
        deprecatedName: "closeDelimiter",
        kind: .token(choices: [.token(.rawStringPoundDelimiter)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .stringLiteralSegmentList,
    nameForDiagnostics: nil,
    elementChoices: [.stringSegment, .expressionSegment]
  ),

  Node(
    kind: .simpleStringLiteralExpr,
    nameForDiagnostics: "simple string literal",
    documentation: "A simple string that can’t contain string interpolation and cannot have raw string delimiters.",
    children: [
      Child(
        name: "openingQuote",
        kind: .token(choices: [.token(.stringQuote), .token(.multilineStringQuote)]),
        documentation: "Open quote for the string literal"
      ),
      Child(
        name: "segments",
        kind: .collection(kind: .simpleStringLiteralSegmentList, collectionElementName: "Segment"),
        documentation: "String content"
      ),
      Child(
        name: "closingQuote",
        kind: .token(choices: [.token(.stringQuote), .token(.multilineStringQuote)]),
        documentation: "Close quote for the string literal"
      ),
    ]
  ),

  Node(
    kind: .simpleStringLiteralSegmentList,
    nameForDiagnostics: nil,
    documentation: "String literal segments that only can contain non string interpolated or extended escaped strings",
    elementChoices: [.stringSegment]
  ),

  Node(
    kind: .stringSegment,
    nameForDiagnostics: nil,
    documentation: """
      A literal segment inside a string segment.

      - SeeAlso: ``ExpressionSegmentSyntax``
      """,
    children: [
      Child(
        name: "content",
        kind: .token(choices: [.token(.stringSegment)])
      )
    ]
  ),

  Node(
    kind: .subscriptCallExpr,
    nameForDiagnostics: "subscript",
    children: [
      Child(
        name: "calledExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "called expression"
      ),
      Child(
        name: "leftSquare",
        deprecatedName: "leftBracket",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "arguments",
        deprecatedName: "argumentList",
        kind: .collection(kind: .labeledExprList, collectionElementName: "Argument"),
        nameForDiagnostics: "arguments"
      ),
      Child(
        name: "rightSquare",
        deprecatedName: "rightBracket",
        kind: .token(choices: [.token(.rightSquare)])
      ),
      Child(
        name: "trailingClosure",
        kind: .node(kind: .closureExpr),
        nameForDiagnostics: "trailing closure",
        isOptional: true
      ),
      Child(
        name: "additionalTrailingClosures",
        kind: .collection(
          kind: .multipleTrailingClosureElementList,
          collectionElementName: "AdditionalTrailingClosure",
          defaultsToEmpty: true
        ),
        nameForDiagnostics: "trailing closures"
      ),
    ]
  ),

  Node(
    kind: .superExpr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "superKeyword",
        kind: .token(choices: [.keyword(.super)])
      )
    ]
  ),

  Node(
    kind: .switchCaseLabel,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "caseKeyword",
        kind: .token(choices: [.keyword(.case)])
      ),
      Child(
        name: "caseItems",
        kind: .collection(kind: .switchCaseItemList, collectionElementName: "CaseItem")
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)], requiresTrailingSpace: false)
      ),
    ]
  ),

  Node(
    kind: .switchCaseList,
    nameForDiagnostics: nil,
    elementChoices: [.switchCase, .ifConfigDecl]
  ),

  Node(
    kind: .switchCase,
    nameForDiagnostics: "switch case",
    parserFunction: "parseSwitchCase",
    traits: ["WithStatements"],
    children: [
      Child(
        name: "attribute",
        deprecatedName: "unknownAttr",
        kind: .node(kind: .attribute),
        documentation: "The `@unknown` attribute of a default label, if present.",
        isOptional: true
      ),
      Child(
        name: "label",
        kind: .nodeChoices(choices: [
          Child(
            name: "default",
            kind: .node(kind: .switchDefaultLabel)
          ),
          Child(
            name: "case",
            kind: .node(kind: .switchCaseLabel)
          ),
        ]),
        nameForDiagnostics: "label"
      ),
      Child(
        name: "statements",
        kind: .collection(kind: .codeBlockItemList, collectionElementName: "Statement")
      ),
    ]
  ),

  Node(
    kind: .switchDefaultLabel,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "defaultKeyword",
        kind: .token(choices: [.keyword(.default)])
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)], requiresTrailingSpace: false)
      ),
    ]
  ),

  Node(
    kind: .switchExpr,
    nameForDiagnostics: "'switch' statement",
    documentation: """
      A `switch` expression.

      ### Examples

      This represents the switch expression in

      ```swift
      switch self.foo {
      }
      ```

      A switch ecpression may be declared without any cases.
      """,
    traits: [
      "Braced"
    ],
    children: [
      Child(
        name: "switchKeyword",
        kind: .token(choices: [.keyword(.switch)]),
        documentation: "The `switch` keyword."
      ),
      Child(
        name: "subject",
        deprecatedName: "expression",
        kind: .node(kind: .expr),
        documentation: "The expression to switch over."
      ),
      Child(
        name: "leftBrace",
        kind: .token(choices: [.token(.leftBrace)]),
        documentation: "The brace introducing the switch body."
      ),
      Child(
        name: "cases",
        kind: .collection(kind: .switchCaseList, collectionElementName: "Case"),
        documentation: "The switch's body that contains all possible cases."
      ),
      Child(
        name: "rightBrace",
        kind: .token(choices: [.token(.rightBrace)]),
        documentation: "The brace closing the switch body."
      ),
    ]
  ),

  Node(
    kind: .ternaryExpr,
    nameForDiagnostics: "ternay expression",
    documentation: """
      The ternary operator with operator precedences resolved.

      ### Examples 

      ```swift
      a ? 1 : 0
      ```

      - Note: This node is only generated after operators are folded using the `SwiftOperators` library. 
        Beforehand, the parser does not know the precedences of operators and thus represents the `?` and `:` by an ``UnresolvedTernaryExprSyntax``.
      """,
    children: [
      Child(
        name: "condition",
        deprecatedName: "conditionExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "condition"
      ),
      Child(
        name: "questionMark",
        kind: .token(choices: [.token(.infixQuestionMark)])
      ),
      Child(
        name: "thenExpression",
        deprecatedName: "firstChoice",
        kind: .node(kind: .expr),
        nameForDiagnostics: "first choice"
      ),
      Child(
        name: "colon",
        deprecatedName: "colonMark",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "elseExpression",
        deprecatedName: "secondChoice",
        kind: .node(kind: .expr),
        nameForDiagnostics: "second choice"
      ),
    ]
  ),

  Node(
    kind: .tryExpr,
    nameForDiagnostics: "'try' expression",
    documentation: """
      An expression prefixed with `try`.

      ### Examples

      ```swift
      try foo()
      ```

      ```swift
      try? foo()
      ```

      ```swift
      try! foo()
      ```
      """,
    children: [
      Child(
        name: "tryKeyword",
        kind: .token(choices: [.keyword(.try)])
      ),
      Child(
        name: "questionOrExclamationMark",
        kind: .token(choices: [.token(.postfixQuestionMark), .token(.exclamationMark)], requiresTrailingSpace: true),
        isOptional: true
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .labeledExprList,
    nameForDiagnostics: nil,
    elementChoices: [.labeledExpr]
  ),

  Node(
    kind: .labeledExpr,
    nameForDiagnostics: nil,
    documentation: """
      An expression that is prefixed by a label.

      For example, labeled expressions occur in
      - Function calls, where the label is the parameter label.
      - Tuples, where the label is the name of the tuple element.
      """,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "label",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        isOptional: true
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "value"
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .tupleExpr,
    nameForDiagnostics: "tuple",
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
        deprecatedName: "elementList",
        kind: .collection(kind: .labeledExprList, collectionElementName: "Element")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .typeExpr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "type",
        kind: .node(kind: .type)
      )
    ]
  ),

  Node(
    kind: .unresolvedAsExpr,
    nameForDiagnostics: "'as'",
    documentation: """
      The `as` keyword without any operands.

      - Note: The parser does not know the precedences of operators and thus represents `as` by an ``UnresolvedAsExprSyntax``.
        After operator folding using the `SwiftOperators` library, this gets translated to an ``AsExprSyntax``.
      """,
    children: [
      Child(
        name: "asKeyword",
        deprecatedName: "asTok",
        kind: .token(choices: [.keyword(.as)])
      ),
      Child(
        name: "questionOrExclamationMark",
        kind: .token(choices: [.token(.postfixQuestionMark), .token(.exclamationMark)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .unresolvedIsExpr,
    nameForDiagnostics: "'is'",
    documentation: """
      The `is` keyword without any operands.

      - Note: The parser does not know the precedences of operators and thus represents `is` by an ``UnresolvedIsExprSyntax``.
        After operator folding using the `SwiftOperators` library, this gets translated to an ``IsExprSyntax``.
      """,
    children: [
      Child(
        name: "isKeyword",
        deprecatedName: "isTok",
        kind: .token(choices: [.keyword(.is)])
      )
    ]
  ),

  Node(
    kind: .patternExpr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      )
    ]
  ),

  Node(
    kind: .unresolvedTernaryExpr,
    nameForDiagnostics: "ternary operator",
    documentation: """
      The middle section of a ternary operator between `?` and `:`.

      - Note: The parser does not know the precedences of operators and thus represents the 
        middle section of a ternary operator by an ``UnresolvedTernaryExprSyntax``.
        After operator folding using the `SwiftOperators` library, this gets translated to an ``TernaryExprSyntax``.
      """,
    children: [
      Child(
        name: "questionMark",
        kind: .token(choices: [.token(.infixQuestionMark)])
      ),
      Child(
        name: "thenExpression",
        deprecatedName: "firstChoice",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "colon",
        deprecatedName: "colonMark",
        kind: .token(choices: [.token(.colon)])
      ),
    ]
  ),

  Node(
    kind: .yieldedExpression,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .yieldedExpressionList,
    nameForDiagnostics: "yield list",
    elementChoices: [.yieldedExpression]
  ),

]
