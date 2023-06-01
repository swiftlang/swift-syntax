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
        name: "Expression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "value"
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
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
        name: "LeftSquare",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "Elements",
        kind: .collection(kind: .arrayElementList, collectionElementName: "Element"),
        isIndented: true
      ),
      Child(
        name: "RightSquare",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
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
        name: "EffectSpecifiers",
        kind: .node(kind: .typeEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "ArrowToken",
        kind: .token(choices: [.token(tokenKind: "ArrowToken")])
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
        name: "Expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "AsTok",
        kind: .token(choices: [.keyword(text: "as")])
      ),
      Child(
        name: "QuestionOrExclamationMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")]),
        isOptional: true
      ),
      Child(
        name: "TypeName",
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
        name: "AssignToken",
        kind: .token(choices: [.token(tokenKind: "EqualToken")])
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
        name: "AwaitKeyword",
        kind: .token(choices: [.keyword(text: "await")])
      ),
      Child(
        name: "Expression",
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
        name: "OperatorToken",
        kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken")])
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
        name: "BooleanLiteral",
        kind: .token(choices: [.keyword(text: "true"), .keyword(text: "false")])
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
        name: "BorrowKeyword",
        kind: .token(choices: [.keyword(text: "_borrow")])
      ),
      Child(
        name: "Expression",
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
        name: "CanImportKeyword",
        kind: .token(choices: [.keyword(text: "canImport")])
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "ImportPath",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "VersionInfo",
        kind: .node(kind: .canImportVersionInfo),
        isOptional: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  Node(
    kind: .canImportVersionInfo,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")])
      ),
      Child(
        name: "Label",
        kind: .token(choices: [.keyword(text: "_version"), .keyword(text: "_underlyingVersion")])
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "VersionTuple",
        kind: .node(kind: .versionTuple)
      ),
    ]
  ),

  // case-item -> pattern where-clause? ','?
  Node(
    kind: .caseItem,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "WhereClause",
        kind: .node(kind: .whereClause),
        isOptional: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .closureCaptureItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.closureCaptureItem]
  ),

  Node(
    kind: .closureCaptureItemSpecifier,
    base: .syntax,
    nameForDiagnostics: "closure capture specifier",
    children: [
      Child(
        name: "Specifier",
        kind: .token(choices: [.keyword(text: "weak"), .keyword(text: "unowned")])
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        isOptional: true
      ),
      Child(
        name: "Detail",
        kind: .token(choices: [.keyword(text: "safe"), .keyword(text: "unsafe")]),
        isOptional: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .closureCaptureItem,
    base: .syntax,
    nameForDiagnostics: "closure capture item",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Specifier",
        kind: .node(kind: .closureCaptureItemSpecifier),
        isOptional: true
      ),
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        isOptional: true
      ),
      Child(
        name: "AssignToken",
        kind: .token(choices: [.token(tokenKind: "EqualToken")]),
        isOptional: true
      ),
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .closureCaptureSignature,
    base: .syntax,
    nameForDiagnostics: "closure capture signature",
    children: [
      Child(
        name: "LeftSquare",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "Items",
        kind: .collection(kind: .closureCaptureItemList, collectionElementName: "Item"),
        isOptional: true
      ),
      Child(
        name: "RightSquare",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
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
        name: "Attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: .modifierList, collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "FirstName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        documentation: "The label of this parameter that will be used when the closure is called."
      ),
      Child(
        name: "SecondName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        documentation:
          "If this is specified, it is the name by which the parameter can be referenced inside the closure body. If it is `nil`, the closure parameter is referenced by the first name.",
        isOptional: true
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        documentation: "The colon separating the parameter's name and type.",
        isOptional: true
      ),
      Child(
        name: "Type",
        kind: .node(kind: .type),
        nameForDiagnostics: "type",
        documentation: "The type of the parameter.",
        isOptional: true
      ),
      Child(
        name: "Ellipsis",
        kind: .token(choices: [.token(tokenKind: "EllipsisToken")]),
        documentation: "If the parameter is variadic, `...` to indicate that.",
        isOptional: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
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
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        documentation: "The '(' to open the parameter clause."
      ),
      Child(
        name: "ParameterList",
        kind: .collection(kind: .closureParameterList, collectionElementName: "Parameter"),
        nameForDiagnostics: "parameters",
        documentation: "The actual parameters.",
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
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
        name: "LeftBrace",
        kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])
      ),
      Child(
        name: "Signature",
        kind: .node(kind: .closureSignature),
        isOptional: true
      ),
      Child(
        name: "Statements",
        kind: .collection(kind: .codeBlockItemList, collectionElementName: "Statement"),
        isIndented: true
      ),
      Child(
        name: "RightBrace",
        kind: .token(choices: [.token(tokenKind: "RightBraceToken")])
      ),
    ]
  ),

  // a, b, c
  Node(
    kind: .closureParamList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.closureParam]
  ),

  Node(
    kind: .closureParam,
    base: .syntax,
    nameForDiagnostics: "closure parameter",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
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
        name: "Attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Capture",
        kind: .node(kind: .closureCaptureSignature),
        isOptional: true
      ),
      Child(
        name: "Input",
        kind: .nodeChoices(choices: [
          Child(
            name: "SimpleInput",
            kind: .node(kind: .closureParamList)
          ),
          Child(
            name: "Input",
            kind: .node(kind: .closureParameterClause)
          ),
        ]),
        isOptional: true
      ),
      Child(
        name: "EffectSpecifiers",
        kind: .node(kind: .typeEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "Output",
        kind: .node(kind: .returnClause),
        isOptional: true
      ),
      Child(
        name: "InTok",
        kind: .token(choices: [.keyword(text: "in")])
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
        name: "Name",
        kind: .node(kind: .token)
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")], requiresTrailingSpace: false)
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
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Arguments",
        kind: .collection(kind: .declNameArgumentList, collectionElementName: "Argument")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
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
        name: "KeyExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "key"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "ValueExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "value",
        isIndented: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
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
        name: "LeftSquare",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "Content",
        kind: .nodeChoices(choices: [
          Child(
            name: "Colon",
            kind: .token(choices: [.token(tokenKind: "ColonToken")], requiresTrailingSpace: false)
          ),
          Child(
            name: "Elements",
            kind: .node(kind: .dictionaryElementList)
          ),
        ]),
        isIndented: true
      ),
      Child(
        name: "RightSquare",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
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
        name: "Wildcard",
        kind: .token(choices: [.token(tokenKind: "WildcardToken")])
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
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
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
        name: "Backslash",
        kind: .token(choices: [.token(tokenKind: "BackslashToken")])
      ),
      Child(
        name: "Delimiter",
        kind: .token(choices: [.token(tokenKind: "RawStringDelimiterToken")]),
        isOptional: true
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        classification: "StringInterpolationAnchor",
        forceClassification: true
      ),
      Child(
        name: "Expressions",
        kind: .collection(kind: .tupleExprElementList, collectionElementName: "Expression")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        classification: "StringInterpolationAnchor",
        forceClassification: true
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
        name: "FloatingDigits",
        kind: .token(choices: [.token(tokenKind: "FloatingLiteralToken")])
      )
    ]
  ),

  // forced-value-expr -> expr '!'
  Node(
    kind: .forcedValueExpr,
    base: .expr,
    nameForDiagnostics: "force unwrap",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "ExclamationMark",
        kind: .token(choices: [.token(tokenKind: "ExclamationMarkToken")])
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
        name: "CalledExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "called expression"
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        isOptional: true
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: .tupleExprElementList, collectionElementName: "Argument"),
        nameForDiagnostics: "arguments",
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        isOptional: true
      ),
      Child(
        name: "TrailingClosure",
        kind: .node(kind: .closureExpr),
        nameForDiagnostics: "trailing closure",
        isOptional: true
      ),
      Child(
        name: "AdditionalTrailingClosures",
        kind: .collection(kind: .multipleTrailingClosureElementList, collectionElementName: "AdditionalTrailingClosure"),
        nameForDiagnostics: "trailing closures",
        isOptional: true
      ),
    ]
  ),

  // An identifier expression.
  Node(
    kind: .identifierExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "Identifier",
        kind: .token(choices: [
          .token(tokenKind: "IdentifierToken"),
          .keyword(text: "self"),
          .keyword(text: "Self"),
          .keyword(text: "init"),
          .token(tokenKind: "DollarIdentifierToken"),
          .token(tokenKind: "BinaryOperatorToken"),
        ])
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: .declNameArguments),
        isOptional: true
      ),
    ]
  ),

  // if-expr -> identifier? ':'? 'if' condition-list code-block
  //   else-clause ';'?
  //
  // This node represents both an 'if' expression, as well as an 'if' statement
  // when wrapped in a ExpressionStmt node.
  Node(
    kind: .ifExpr,
    base: .expr,
    nameForDiagnostics: "'if' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "IfKeyword",
        kind: .token(choices: [.keyword(text: "if")])
      ),
      Child(
        name: "Conditions",
        kind: .collection(kind: .conditionElementList, collectionElementName: "Condition")
      ),
      Child(
        name: "Body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "ElseKeyword",
        kind: .token(choices: [.keyword(text: "else")]),
        isOptional: true
      ),
      Child(
        name: "ElseBody",
        kind: .nodeChoices(choices: [
          Child(
            name: "IfExpr",
            kind: .node(kind: .ifExpr)
          ),
          Child(
            name: "CodeBlock",
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
        name: "Ampersand",
        kind: .token(choices: [.token(tokenKind: "PrefixAmpersandToken")])
      ),
      Child(
        name: "Expression",
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
        name: "LeftOperand",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "OperatorOperand",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "RightOperand",
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
        name: "Digits",
        kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")])
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
      An `is` expression like the following.

      ```swift
      value is Double
      ```

      This node is only generated after operators are folded using the `SwiftOperators` library. Beforehand, the parser does not know the precedences of operators and thus represents `is` by an `UnresolvedIsExpr`.
      """,
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: .expr),
        documentation: "The expression which will be checked to determine whether it can be cast to a specific type."
      ),
      Child(
        name: "IsTok",
        kind: .token(choices: [.keyword(text: "is")]),
        documentation: "The `is` keyword for this expression."
      ),
      Child(
        name: "TypeName",
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
        name: "Period",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")]),
        isOptional: true
      ),
      Child(
        name: "Component",
        kind: .nodeChoices(choices: [
          Child(
            name: "Property",
            kind: .node(kind: .keyPathPropertyComponent)
          ),
          Child(
            name: "Subscript",
            kind: .node(kind: .keyPathSubscriptComponent)
          ),
          Child(
            name: "Optional",
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
        name: "Backslash",
        kind: .token(choices: [.token(tokenKind: "BackslashToken")])
      ),
      Child(
        name: "Root",
        kind: .node(kind: .type),
        nameForDiagnostics: "root",
        isOptional: true
      ),
      Child(
        name: "Components",
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
        name: "QuestionOrExclamationMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")])
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
        name: "Identifier",
        kind: .token(choices: [
          .token(tokenKind: "IdentifierToken"),
          .keyword(text: "self"),
          .keyword(text: "Self"),
          .keyword(text: "init"),
          .token(tokenKind: "DollarIdentifierToken"),
          .token(tokenKind: "BinaryOperatorToken"),
          .token(tokenKind: "IntegerLiteralToken"),
        ])
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: .declNameArguments),
        isOptional: true
      ),
      Child(
        name: "GenericArgumentClause",
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
        name: "LeftBracket",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: .tupleExprElementList, collectionElementName: "Argument"),
        nameForDiagnostics: "arguments"
      ),
      Child(
        name: "RightBracket",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
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
        name: "PoundToken",
        kind: .token(choices: [.token(tokenKind: "PoundToken")]),
        documentation: "The `#` sign."
      ),
      Child(
        name: "Macro",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "GenericArguments",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        isOptional: true
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: .tupleExprElementList, collectionElementName: "Argument")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        isOptional: true
      ),
      Child(
        name: "TrailingClosure",
        kind: .node(kind: .closureExpr),
        isOptional: true
      ),
      Child(
        name: "AdditionalTrailingClosures",
        kind: .collection(kind: .multipleTrailingClosureElementList, collectionElementName: "AdditionalTrailingClosure"),
        isOptional: true
      ),
    ]
  ),

  // expr?.name
  Node(
    kind: .memberAccessExpr,
    base: .expr,
    nameForDiagnostics: "member access",
    children: [
      Child(
        name: "Base",
        kind: .node(kind: .expr),
        nameForDiagnostics: "base",
        isOptional: true
      ),
      Child(
        name: "Dot",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")])
      ),
      Child(
        name: "Name",
        kind: .node(kind: .token),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: .declNameArguments),
        isOptional: true
      ),
    ]
  ),

  // The move expr
  Node(
    kind: .moveExpr,
    base: .expr,
    nameForDiagnostics: "'consume' expression",
    children: [
      Child(
        name: "MoveKeyword",
        kind: .token(choices: [.keyword(text: "_move"), .keyword(text: "consume")])
      ),
      Child(
        name: "Expression",
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
        name: "CopyKeyword",
        kind: .token(choices: [.keyword(text: "copy")])
      ),
      Child(
        name: "Expression",
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
        name: "Label",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        nameForDiagnostics: "label"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Closure",
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
        name: "NilKeyword",
        kind: .token(choices: [.keyword(text: "nil")])
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
        name: "Expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "QuestionMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken")])
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
        name: "EachKeyword",
        kind: .token(choices: [.keyword(text: "each")])
      ),
      Child(
        name: "PackRefExpr",
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
        name: "RepeatKeyword",
        kind: .token(choices: [.keyword(text: "repeat")])
      ),
      Child(
        name: "PatternExpr",
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
        name: "Base",
        kind: .node(kind: .expr),
        isOptional: true
      ),
      Child(
        name: "Config",
        kind: .node(kind: .ifConfigDecl)
      ),
    ]
  ),

  // postfix-unary-expr -> expr postfix-operator
  Node(
    kind: .postfixUnaryExpr,
    base: .expr,
    nameForDiagnostics: "postfix expression",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "OperatorToken",
        kind: .token(choices: [.token(tokenKind: "PostfixOperatorToken")])
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
        name: "OperatorToken",
        kind: .token(choices: [.token(tokenKind: "PrefixOperatorToken")]),
        isOptional: true
      ),
      Child(
        name: "PostfixExpression",
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
        name: "OpeningPounds",
        kind: .token(choices: [.token(tokenKind: "ExtendedRegexDelimiterToken")]),
        isOptional: true
      ),
      Child(
        name: "OpenSlash",
        kind: .token(choices: [.token(tokenKind: "RegexSlashToken")])
      ),
      Child(
        name: "RegexPattern",
        kind: .token(choices: [.token(tokenKind: "RegexLiteralPatternToken")])
      ),
      Child(
        name: "CloseSlash",
        kind: .token(choices: [.token(tokenKind: "RegexSlashToken")])
      ),
      Child(
        name: "ClosingPounds",
        kind: .token(choices: [.token(tokenKind: "ExtendedRegexDelimiterToken")]),
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
        name: "Elements",
        kind: .collection(kind: .exprList, collectionElementName: "Element")
      )
    ]
  ),

  // specialize-expr -> expr generic-argument-clause?
  Node(
    kind: .specializeExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "GenericArgumentClause",
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
        name: "OpenDelimiter",
        kind: .token(choices: [.token(tokenKind: "RawStringDelimiterToken")]),
        isOptional: true
      ),
      Child(
        name: "OpenQuote",
        kind: .token(choices: [.token(tokenKind: "StringQuoteToken"), .token(tokenKind: "MultilineStringQuoteToken"), .token(tokenKind: "SingleQuoteToken")])
      ),
      Child(
        name: "Segments",
        kind: .collection(kind: .stringLiteralSegments, collectionElementName: "Segment")
      ),
      Child(
        name: "CloseQuote",
        kind: .token(choices: [.token(tokenKind: "StringQuoteToken"), .token(tokenKind: "MultilineStringQuoteToken"), .token(tokenKind: "SingleQuoteToken")])
      ),
      Child(
        name: "CloseDelimiter",
        kind: .token(choices: [.token(tokenKind: "RawStringDelimiterToken")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .stringLiteralSegments,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.stringSegment, .expressionSegment]
  ),

  // string literal segment in a string interpolation expression.
  Node(
    kind: .stringSegment,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "Content",
        kind: .token(choices: [.token(tokenKind: "StringSegmentToken")])
      )
    ]
  ),

  // subscript-expr -> expr '[' call-argument-list ']' closure-expr?
  Node(
    kind: .subscriptExpr,
    base: .expr,
    nameForDiagnostics: "subscript",
    children: [
      Child(
        name: "CalledExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "called expression"
      ),
      Child(
        name: "LeftBracket",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: .tupleExprElementList, collectionElementName: "Argument"),
        nameForDiagnostics: "arguments"
      ),
      Child(
        name: "RightBracket",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
      ),
      Child(
        name: "TrailingClosure",
        kind: .node(kind: .closureExpr),
        nameForDiagnostics: "trailing closure",
        isOptional: true
      ),
      Child(
        name: "AdditionalTrailingClosures",
        kind: .collection(kind: .multipleTrailingClosureElementList, collectionElementName: "AdditionalTrailingClosure"),
        nameForDiagnostics: "trailing closures",
        isOptional: true
      ),
    ]
  ),

  // An 'super' expression.
  Node(
    kind: .superRefExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "SuperKeyword",
        kind: .token(choices: [.keyword(text: "super")])
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
        name: "CaseKeyword",
        kind: .token(choices: [.keyword(text: "case")])
      ),
      Child(
        name: "CaseItems",
        kind: .collection(kind: .caseItemList, collectionElementName: "CaseItem")
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")], requiresTrailingSpace: false)
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
        name: "UnknownAttr",
        kind: .node(kind: .attribute),
        isOptional: true
      ),
      Child(
        name: "Label",
        kind: .nodeChoices(choices: [
          Child(
            name: "Default",
            kind: .node(kind: .switchDefaultLabel)
          ),
          Child(
            name: "Case",
            kind: .node(kind: .switchCaseLabel)
          ),
        ]),
        nameForDiagnostics: "label"
      ),
      Child(
        name: "Statements",
        kind: .collection(kind: .codeBlockItemList, collectionElementName: "Statement"),
        isIndented: true
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
        name: "DefaultKeyword",
        kind: .token(choices: [.keyword(text: "default")])
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")], requiresTrailingSpace: false)
      ),
    ]
  ),

  // switch-expr -> identifier? ':'? 'switch' expr '{'
  //   switch-case-list '}' ';'?
  //
  // This node represents both a 'switch' expression, as well as a 'switch'
  // statement when wrapped in a ExpressionStmt node.
  Node(
    kind: .switchExpr,
    base: .expr,
    nameForDiagnostics: "'switch' statement",
    traits: [
      "Braced"
    ],
    children: [
      Child(
        name: "SwitchKeyword",
        kind: .token(choices: [.keyword(text: "switch")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "LeftBrace",
        kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])
      ),
      Child(
        name: "Cases",
        kind: .collection(kind: .switchCaseList, collectionElementName: "Case")
      ),
      Child(
        name: "RightBrace",
        kind: .token(choices: [.token(tokenKind: "RightBraceToken")])
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
        name: "ConditionExpression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "condition"
      ),
      Child(
        name: "QuestionMark",
        kind: .token(choices: [.token(tokenKind: "InfixQuestionMarkToken")])
      ),
      Child(
        name: "FirstChoice",
        kind: .node(kind: .expr),
        nameForDiagnostics: "first choice"
      ),
      Child(
        name: "ColonMark",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "SecondChoice",
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
        name: "TryKeyword",
        kind: .token(choices: [.keyword(text: "try")])
      ),
      Child(
        name: "QuestionOrExclamationMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")], requiresTrailingSpace: true),
        isOptional: true
      ),
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .tupleExprElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.tupleExprElement]
  ),

  // An element inside a tuple element list
  Node(
    kind: .tupleExprElement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Label",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        isOptional: true
      ),
      Child(
        name: "Expression",
        kind: .node(kind: .expr),
        nameForDiagnostics: "value"
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
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
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Elements",
        kind: .collection(kind: .tupleExprElementList, collectionElementName: "Element"),
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
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
        name: "Type",
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
        name: "AsTok",
        kind: .token(choices: [.keyword(text: "as")])
      ),
      Child(
        name: "QuestionOrExclamationMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")]),
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
        name: "IsTok",
        kind: .token(choices: [.keyword(text: "is")])
      )
    ]
  ),
  // unresolved-pattern-expr -> pattern
  Node(
    kind: .unresolvedPatternExpr,
    base: .expr,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "Pattern",
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
        name: "QuestionMark",
        kind: .token(choices: [.token(tokenKind: "InfixQuestionMarkToken")])
      ),
      Child(
        name: "FirstChoice",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "ColonMark",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
    ]
  ),

  Node(
    kind: .yieldExprListElement,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .yieldExprList,
    base: .syntaxCollection,
    nameForDiagnostics: "yield list",
    elementChoices: [.yieldExprListElement]
  ),

]
