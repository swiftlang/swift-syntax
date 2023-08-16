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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.arrayElement]
  ),

  // element inside an array expression: expression ','?
  Node(
    kind: .arrayElement,
    base: .syntax,
    nameForDiagnostics: "array element",
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

  // Array literal, e.g. [1, 2, 3]
  Node(
    kind: .arrayExpr,
    base: .expr,
    nameForDiagnostics: "array",
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

  // arrow-expr -> 'async'? 'throws'? '->'
  // NOTE: This appears only in SequenceExpr.
  Node(
    kind: .arrowExpr,
    base: .expr,
    nameForDiagnostics: nil,
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

  // expression as TypeName
  // NOTE: This won't come directly out of the parser. Rather, it is the
  // result of "folding" a SequenceExpr based on knowing the precedence
  // relationships amongst the different infix operators.
  Node(
    kind: .asExpr,
    base: .expr,
    nameForDiagnostics: "'as'",
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

  // An = expression.
  Node(
    kind: .assignmentExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "equal",
        deprecatedName: "assignToken",
        kind: .token(choices: [.token(.equal)])
      )
    ]
  ),

  // The await operator.
  // await foo()
  Node(
    kind: .awaitExpr,
    base: .expr,
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

  // An operator like + or -.
  // NOTE: This appears only in SequenceExpr.
  Node(
    kind: .binaryOperatorExpr,
    base: .expr,
    nameForDiagnostics: "operator",
    children: [
      Child(
        name: "operator",
        deprecatedName: "operatorToken",
        kind: .token(choices: [.token(.binaryOperator)])
      )
    ]
  ),

  // true or false
  Node(
    kind: .booleanLiteralExpr,
    base: .expr,
    nameForDiagnostics: "bool literal",
    children: [
      Child(
        name: "literal",
        deprecatedName: "booleanLiteral",
        kind: .token(choices: [.keyword(.true), .keyword(.false)])
      )
    ]
  ),

  // The borrow expr
  Node(
    kind: .borrowExpr,
    base: .expr,
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

  // the canImport expr in if config expression
  Node(
    kind: .canImportExpr,
    base: .expr,
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
        kind: .node(kind: .canImportVersionInfo),
        isOptional: true
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .canImportVersionInfo,
    base: .expr,
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

  // case-item -> pattern where-clause? ','?
  Node(
    kind: .switchCaseItem,
    base: .syntax,
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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.closureCapture]
  ),

  Node(
    kind: .closureCaptureSpecifier,
    base: .syntax,
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
    base: .syntax,
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
        kind: .token(choices: [.token(.identifier)]),
        isOptional: true
      ),
      Child(
        name: "equal",
        deprecatedName: "assignToken",
        kind: .token(choices: [.token(.equal)]),
        isOptional: true
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
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
    base: .syntax,
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
    base: .syntax,
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
    base: .syntaxCollection,
    nameForDiagnostics: "parameter list",
    elementChoices: [.closureParameter]
  ),

  Node(
    kind: .closureParameterClause,
    base: .syntax,
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
    base: .expr,
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

  // a, b, c
  Node(
    kind: .closureShorthandParameterList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.closureShorthandParameter]
  ),

  Node(
    kind: .closureShorthandParameter,
    base: .syntax,
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
    base: .syntax,
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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.declNameArgument]
  ),

  // declname-arguments -> '(' declname-argument-list ')'
  // declname-argument-list -> declname-argument*
  // declname-argument -> identifier ':'
  Node(
    kind: .declNameArgument,
    base: .syntax,
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
    base: .syntax,
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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.dictionaryElement]
  ),

  // element inside an array expression: expression ','?
  Node(
    kind: .dictionaryElement,
    base: .syntax,
    nameForDiagnostics: "dictionary element",
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

  // Dictionary literal, e.g. [1:1, 2:2, 3:3]
  Node(
    kind: .dictionaryExpr,
    base: .expr,
    nameForDiagnostics: "dictionary",
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

  // A _ expression.
  Node(
    kind: .discardAssignmentExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "wildcard",
        kind: .token(choices: [.token(.wildcard)])
      )
    ]
  ),

  // <#content#>
  Node(
    kind: .editorPlaceholderExpr,
    base: .expr,
    nameForDiagnostics: "editor placeholder",
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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    documentation: "A list of expressions connected by operators. This list is contained by a ``SequenceExprSyntax``.",
    elementChoices: [.expr]
  ),

  // expression segment in a string interpolation expression.
  Node(
    kind: .expressionSegment,
    base: .syntax,
    nameForDiagnostics: nil,
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

  // A floating-point literal
  // 4.0
  // -3.9
  // +4e20
  Node(
    kind: .floatLiteralExpr,
    base: .expr,
    nameForDiagnostics: "floating literal",
    children: [
      Child(
        name: "literal",
        deprecatedName: "floatingDigits",
        kind: .token(choices: [.token(.floatLiteral)])
      )
    ]
  ),

  // forced-value-expr -> expr '!'
  Node(
    kind: .forceUnwrapExpr,
    base: .expr,
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

  // call-expr -> expr '(' call-argument-list ')' closure-expr?
  //            | expr closure-expr
  Node(
    kind: .functionCallExpr,
    base: .expr,
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
        kind: .collection(kind: .multipleTrailingClosureElementList, collectionElementName: "AdditionalTrailingClosure", defaultsToEmpty: true),
        nameForDiagnostics: "trailing closures"
      ),
    ]
  ),

  // An identifier expression.
  Node(
    kind: .declReferenceExpr,
    base: .expr,
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

  // if-expr -> identifier? ':'? 'if' condition-list code-block
  //   else-clause ';'?
  //
  // This node represents both an 'if' expression, as well as an 'if' statement
  // when wrapped in an ExpressionStmt node.
  Node(
    kind: .ifExpr,
    base: .expr,
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

  // An inout expression.
  // &x
  Node(
    kind: .inOutExpr,
    base: .expr,
    nameForDiagnostics: "inout expression",
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

  // An infix binary expression like x + y.
  // NOTE: This won't come directly out of the parser. Rather, it is the
  // result of "folding" a SequenceExpr based on knowing the precedence
  // relationships amongst the different infix operators.
  Node(
    kind: .infixOperatorExpr,
    base: .expr,
    nameForDiagnostics: nil,
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

  // An integer literal.
  // 3
  // +3_400
  // +0x4f
  Node(
    kind: .integerLiteralExpr,
    base: .expr,
    nameForDiagnostics: "integer literal",
    children: [
      Child(
        name: "literal",
        deprecatedName: "digits",
        kind: .token(choices: [.token(.integerLiteral)])
      )
    ]
  ),

  // expression is TypeName
  // NOTE: This won't come directly out of the parser. Rather, it is the
  // result of "folding" a SequenceExpr based on knowing the precedence
  // relationships amongst the different infix operators.
  Node(
    kind: .isExpr,
    base: .expr,
    nameForDiagnostics: "'is'",
    documentation: """
      Checks if an expression is of a given type.

      An example of an `is` expression is

      ```swift
      value is Double
      ```

      This node is only generated after operators are folded using the `SwiftOperators` library. Beforehand, the parser does not know the precedences of operators and thus represents `is` by an `UnresolvedIsExpr`.
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
        documentation: "The type against which the expression will be checked to see if the expression can be cast to it."
      ),
    ]
  ),

  // The components of a key path
  Node(
    kind: .keyPathComponentList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.keyPathComponent]
  ),

  // A single key path component.
  Node(
    kind: .keyPathComponent,
    base: .syntax,
    nameForDiagnostics: "key path component",
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

  // e.g. "\a.b[2].a"
  Node(
    kind: .keyPathExpr,
    base: .expr,
    nameForDiagnostics: "key path",
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

  // A key path component like '?' or '!'.
  Node(
    kind: .keyPathOptionalComponent,
    base: .syntax,
    nameForDiagnostics: "key path optional component",
    children: [
      Child(
        name: "questionOrExclamationMark",
        kind: .token(choices: [.token(.postfixQuestionMark), .token(.exclamationMark)])
      )
    ]
  ),

  // A key path component like .property or .1.
  Node(
    kind: .keyPathPropertyComponent,
    base: .syntax,
    nameForDiagnostics: "key path property component",
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

  // A key path component like .[17]
  Node(
    kind: .keyPathSubscriptComponent,
    base: .syntax,
    nameForDiagnostics: "key path subscript component",
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

  // e.g., "#embed("filename.txt")"
  Node(
    kind: .macroExpansionExpr,
    base: .expr,
    nameForDiagnostics: "macro expansion",
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
        kind: .collection(kind: .multipleTrailingClosureElementList, collectionElementName: "AdditionalTrailingClosure", defaultsToEmpty: true)
      ),
    ]
  ),

  // expr?.name
  Node(
    kind: .memberAccessExpr,
    base: .expr,
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

  // The move expr
  Node(
    kind: .consumeExpr,
    base: .expr,
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
    base: .expr,
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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.multipleTrailingClosureElement]
  ),

  // trailing-closure-element -> identifier ':' closure-expression
  Node(
    kind: .multipleTrailingClosureElement,
    base: .syntax,
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

  // A nil expression.
  Node(
    kind: .nilLiteralExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "nilKeyword",
        kind: .token(choices: [.keyword(.nil)])
      )
    ]
  ),

  // optional-chaining-expr -> expr '?'
  Node(
    kind: .optionalChainingExpr,
    base: .expr,
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

  // A pack element expr spelled with 'each'.
  Node(
    kind: .packElementExpr,
    base: .expr,
    nameForDiagnostics: nil,
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

  // A pack expansion expr spelled with 'repeat'.
  Node(
    kind: .packExpansionExpr,
    base: .expr,
    nameForDiagnostics: nil,
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

  // postfix '#if' expression
  Node(
    kind: .postfixIfConfigExpr,
    base: .expr,
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

  // postfix-unary-expr -> expr postfix-operator
  Node(
    kind: .postfixOperatorExpr,
    base: .expr,
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

  // A prefix operator expression.
  // -x
  // !true
  Node(
    kind: .prefixOperatorExpr,
    base: .expr,
    nameForDiagnostics: "operator",
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

  // e.g '(a|c)*', the contents of the literal is opaque to the C++ Swift
  // parser though.
  Node(
    kind: .regexLiteralExpr,
    base: .expr,
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

  // A flat list of expressions before sequence folding, e.g. 1 + 2 + 3.
  Node(
    kind: .sequenceExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "elements",
        kind: .collection(kind: .exprList, collectionElementName: "Element")
      )
    ]
  ),

  // specialize-expr -> expr generic-argument-clause?
  Node(
    kind: .genericSpecializationExpr,
    base: .expr,
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

  // e.g. "abc \(foo()) def"
  Node(
    kind: .stringLiteralExpr,
    base: .expr,
    nameForDiagnostics: "string literal",
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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.stringSegment, .expressionSegment]
  ),

  Node(
    kind: .simpleStringLiteralExpr,
    base: .expr,
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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    documentation: "String literal segments that only can contain non string interpolated or extended escaped strings",
    elementChoices: [.stringSegment]
  ),

  // string literal segment in a string interpolation expression.
  Node(
    kind: .stringSegment,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "content",
        kind: .token(choices: [.token(.stringSegment)])
      )
    ]
  ),

  // subscript-expr -> expr '[' call-argument-list ']' closure-expr?
  Node(
    kind: .subscriptCallExpr,
    base: .expr,
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
        kind: .collection(kind: .multipleTrailingClosureElementList, collectionElementName: "AdditionalTrailingClosure", defaultsToEmpty: true),
        nameForDiagnostics: "trailing closures"
      ),
    ]
  ),

  // An 'super' expression.
  Node(
    kind: .superExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "superKeyword",
        kind: .token(choices: [.keyword(.super)])
      )
    ]
  ),

  // switch-case-label -> 'case' case-item-list ':'
  Node(
    kind: .switchCaseLabel,
    base: .syntax,
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

  // switch-case-list -> switch-case switch-case-list?
  Node(
    kind: .switchCaseList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.switchCase, .ifConfigDecl]
  ),

  // switch-case -> unknown-attr? switch-case-label stmt-list
  //              | unknown-attr? switch-default-label stmt-list
  Node(
    kind: .switchCase,
    base: .syntax,
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

  // switch-default-label -> 'default' ':'
  Node(
    kind: .switchDefaultLabel,
    base: .syntax,
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

  // switch-expr -> identifier? ':'? 'switch' expr '{'
  //   switch-case-list '}' ';'?
  //
  // This node represents both a 'switch' expression, as well as a 'switch'
  // statement when wrapped in an ExpressionStmt node.
  Node(
    kind: .switchExpr,
    base: .expr,
    nameForDiagnostics: "'switch' statement",
    traits: [
      "Braced"
    ],
    children: [
      Child(
        name: "switchKeyword",
        kind: .token(choices: [.keyword(.switch)])
      ),
      Child(
        name: "subject",
        deprecatedName: "expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "leftBrace",
        kind: .token(choices: [.token(.leftBrace)])
      ),
      Child(
        name: "cases",
        kind: .collection(kind: .switchCaseList, collectionElementName: "Case")
      ),
      Child(
        name: "rightBrace",
        kind: .token(choices: [.token(.rightBrace)])
      ),
    ]
  ),

  // a ? 1 : 0
  // NOTE: This won't come directly out of the parser. Rather, it is the
  // result of "folding" a SequenceExpr based on knowing the precedence
  // relationships amongst the different infix operators.
  Node(
    kind: .ternaryExpr,
    base: .expr,
    nameForDiagnostics: "ternay expression",
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

  // The try operator.
  // try foo()
  // try? foo()
  // try! foo()
  Node(
    kind: .tryExpr,
    base: .expr,
    nameForDiagnostics: "'try' expression",
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
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.labeledExpr]
  ),

  // An element inside a tuple element list
  Node(
    kind: .labeledExpr,
    base: .syntax,
    nameForDiagnostics: nil,
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
    base: .expr,
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

  // Type
  Node(
    kind: .typeExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "type",
        kind: .node(kind: .type)
      )
    ]
  ),

  // 'as' ('?'|'!')
  // "as" type casting operator without operands.
  // NOTE: This appears only in SequenceExpr.
  Node(
    kind: .unresolvedAsExpr,
    base: .expr,
    nameForDiagnostics: "'as'",
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

  // 'is'
  // "is" type casting operator without operands.
  // NOTE: This appears only in SequenceExpr.
  Node(
    kind: .unresolvedIsExpr,
    base: .expr,
    nameForDiagnostics: "'is'",
    children: [
      Child(
        name: "isKeyword",
        deprecatedName: "isTok",
        kind: .token(choices: [.keyword(.is)])
      )
    ]
  ),
  // unresolved-pattern-expr -> pattern
  Node(
    kind: .patternExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      )
    ]
  ),

  // ? expr :
  // Ternary expression without the condition and the second choice.
  // NOTE: This appears only in SequenceExpr.
  Node(
    kind: .unresolvedTernaryExpr,
    base: .expr,
    nameForDiagnostics: "ternary operator",
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
    base: .syntax,
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
    base: .syntaxCollection,
    nameForDiagnostics: "yield list",
    elementChoices: [.yieldedExpression]
  ),

]
