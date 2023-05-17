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
    name: "ArrayElementList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "ArrayElement"
  ),

  // element inside an array expression: expression ','?
  Node(
    name: "ArrayElement",
    nameForDiagnostics: "array element",
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr"),
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
    name: "ArrayExpr",
    nameForDiagnostics: "array",
    kind: "Expr",
    children: [
      Child(
        name: "LeftSquare",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "Elements",
        kind: .collection(kind: "ArrayElementList", collectionElementName: "Element"),
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
    name: "ArrowExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "EffectSpecifiers",
        kind: .node(kind: "TypeEffectSpecifiers"),
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
    name: "AsExpr",
    nameForDiagnostics: "'as'",
    kind: "Expr",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
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
        kind: .node(kind: "Type")
      ),
    ]
  ),

  // An = expression.
  Node(
    name: "AssignmentExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
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
    name: "AwaitExpr",
    nameForDiagnostics: "'await' expression",
    kind: "Expr",
    children: [
      Child(
        name: "AwaitKeyword",
        kind: .token(choices: [.keyword(text: "await")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // An operator like + or -.
  // NOTE: This appears only in SequenceExpr.
  Node(
    name: "BinaryOperatorExpr",
    nameForDiagnostics: "operator",
    kind: "Expr",
    children: [
      Child(
        name: "OperatorToken",
        kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken")])
      )
    ]
  ),

  // true or false
  Node(
    name: "BooleanLiteralExpr",
    nameForDiagnostics: "bool literal",
    kind: "Expr",
    children: [
      Child(
        name: "BooleanLiteral",
        kind: .token(choices: [.keyword(text: "true"), .keyword(text: "false")])
      )
    ]
  ),

  // The borrow expr
  Node(
    name: "BorrowExpr",
    nameForDiagnostics: "'_borrow' expression",
    kind: "Expr",
    children: [
      Child(
        name: "BorrowKeyword",
        kind: .token(choices: [.keyword(text: "_borrow")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // case-item -> pattern where-clause? ','?
  Node(
    name: "CaseItem",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Pattern",
        kind: .node(kind: "Pattern")
      ),
      Child(
        name: "WhereClause",
        kind: .node(kind: "WhereClause"),
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
    name: "ClosureCaptureItemList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "ClosureCaptureItem"
  ),

  Node(
    name: "ClosureCaptureItemSpecifier",
    nameForDiagnostics: "closure capture specifier",
    kind: "Syntax",
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
    name: "ClosureCaptureItem",
    nameForDiagnostics: "closure capture item",
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Specifier",
        kind: .node(kind: "ClosureCaptureItemSpecifier"),
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
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "ClosureCaptureSignature",
    nameForDiagnostics: "closure capture signature",
    kind: "Syntax",
    children: [
      Child(
        name: "LeftSquare",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "Items",
        kind: .collection(kind: "ClosureCaptureItemList", collectionElementName: "Item"),
        isOptional: true
      ),
      Child(
        name: "RightSquare",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
      ),
    ]
  ),

  Node(
    name: "ClosureParameter",
    nameForDiagnostics: "parameter",
    kind: "Syntax",
    traits: [
      "WithTrailingComma",
      "WithAttributes",
      "WithModifiers",
    ],
    parserFunction: "parseClosureParameter",
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "FirstName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        description: "The label of this parameter that will be used when the closure is called."
      ),
      Child(
        name: "SecondName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        description: "If this is specified, it is the name by which the parameter can be referenced inside the closure body. If it is `nil`, the closure parameter is referenced by the first name.",
        isOptional: true
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "The colon separating the parameter's name and type.",
        isOptional: true
      ),
      Child(
        name: "Type",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "type",
        description: "The type of the parameter.",
        isOptional: true
      ),
      Child(
        name: "Ellipsis",
        kind: .token(choices: [.token(tokenKind: "EllipsisToken")]),
        description: "If the parameter is variadic, `...` to indicate that.",
        isOptional: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "If the parameter is followed by another parameter, the comma separating them.",
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "ClosureParameterList",
    nameForDiagnostics: "parameter list",
    kind: "SyntaxCollection",
    element: "ClosureParameter"
  ),

  Node(
    name: "ClosureParameterClause",
    nameForDiagnostics: "parameter clause",
    kind: "Syntax",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        description: "The '(' to open the parameter clause."
      ),
      Child(
        name: "ParameterList",
        kind: .collection(kind: "ClosureParameterList", collectionElementName: "Parameter"),
        nameForDiagnostics: "parameters",
        description: "The actual parameters.",
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        description: "The ')' to close the parameter clause."
      ),
    ]
  ),

  Node(
    name: "ClosureExpr",
    nameForDiagnostics: "closure",
    kind: "Expr",
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
        kind: .node(kind: "ClosureSignature"),
        isOptional: true
      ),
      Child(
        name: "Statements",
        kind: .collection(kind: "CodeBlockItemList", collectionElementName: "Statement"),
        isIndented: true
      ),
      Child(
        name: "RightBrace",
        kind: .token(choices: [.token(tokenKind: "RightBraceToken")]),
        requiresLeadingNewline: true
      ),
    ]
  ),

  // a, b, c
  Node(
    name: "ClosureParamList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "ClosureParam"
  ),

  Node(
    name: "ClosureParam",
    nameForDiagnostics: "closure parameter",
    kind: "Syntax",
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
    name: "ClosureSignature",
    nameForDiagnostics: "closure signature",
    kind: "Syntax",
    traits: [
      "WithAttributes"
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Capture",
        kind: .node(kind: "ClosureCaptureSignature"),
        isOptional: true
      ),
      Child(
        name: "Input",
        kind: .nodeChoices(choices: [
          Child(
            name: "SimpleInput",
            kind: .node(kind: "ClosureParamList")
          ),
          Child(
            name: "Input",
            kind: .node(kind: "ClosureParameterClause")
          ),
        ]),
        isOptional: true
      ),
      Child(
        name: "EffectSpecifiers",
        kind: .node(kind: "TypeEffectSpecifiers"),
        isOptional: true
      ),
      Child(
        name: "Output",
        kind: .node(kind: "ReturnClause"),
        isOptional: true
      ),
      Child(
        name: "InTok",
        kind: .token(choices: [.keyword(text: "in")])
      ),
    ]
  ),

  Node(
    name: "DeclNameArgumentList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "DeclNameArgument"
  ),

  // declname-arguments -> '(' declname-argument-list ')'
  // declname-argument-list -> declname-argument*
  // declname-argument -> identifier ':'
  Node(
    name: "DeclNameArgument",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "Name",
        kind: .node(kind: "Token")
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")], requiresTrailingSpace: false)
      ),
    ]
  ),

  Node(
    name: "DeclNameArguments",
    nameForDiagnostics: nil,
    kind: "Syntax",
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
        kind: .collection(kind: "DeclNameArgumentList", collectionElementName: "Argument")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  Node(
    name: "DictionaryElementList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "DictionaryElement"
  ),

  // element inside an array expression: expression ','?
  Node(
    name: "DictionaryElement",
    nameForDiagnostics: "dictionary element",
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "KeyExpression",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "key"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "ValueExpression",
        kind: .node(kind: "Expr"),
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
    name: "DictionaryExpr",
    nameForDiagnostics: "dictionary",
    kind: "Expr",
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
            kind: .node(kind: "DictionaryElementList")
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
    name: "DiscardAssignmentExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "Wildcard",
        kind: .token(choices: [.token(tokenKind: "WildcardToken")])
      )
    ]
  ),

  // <#content#>
  Node(
    name: "EditorPlaceholderExpr",
    nameForDiagnostics: "editor placeholder",
    kind: "Expr",
    children: [
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      )
    ]
  ),

  Node(
    name: "ExprList",
    nameForDiagnostics: nil,
    description: "A list of expressions connected by operators. This list is contained by a `SequenceExprSyntax`.",
    kind: "SyntaxCollection",
    element: "Expr",
    elementName: "Expression"
  ),

  // expression segment in a string interpolation expression.
  Node(
    name: "ExpressionSegment",
    nameForDiagnostics: nil,
    kind: "Syntax",
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
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Expression")
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
    name: "FloatLiteralExpr",
    nameForDiagnostics: "floating literal",
    kind: "Expr",
    children: [
      Child(
        name: "FloatingDigits",
        kind: .token(choices: [.token(tokenKind: "FloatingLiteralToken")])
      )
    ]
  ),

  // forced-value-expr -> expr '!'
  Node(
    name: "ForcedValueExpr",
    nameForDiagnostics: "force unwrap",
    kind: "Expr",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
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
    name: "FunctionCallExpr",
    nameForDiagnostics: "function call",
    kind: "Expr",
    children: [
      Child(
        name: "CalledExpression",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "called expression"
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        isOptional: true
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument"),
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
        kind: .node(kind: "ClosureExpr"),
        nameForDiagnostics: "trailing closure",
        isOptional: true
      ),
      Child(
        name: "AdditionalTrailingClosures",
        kind: .collection(kind: "MultipleTrailingClosureElementList", collectionElementName: "AdditionalTrailingClosure"),
        nameForDiagnostics: "trailing closures",
        isOptional: true
      ),
    ]
  ),

  // An identifier expression.
  Node(
    name: "IdentifierExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "KeywordToken"), .token(tokenKind: "DollarIdentifierToken"), .token(tokenKind: "BinaryOperatorToken")])
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: "DeclNameArguments"),
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
    name: "IfExpr",
    nameForDiagnostics: "'if' statement",
    kind: "Expr",
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
        kind: .collection(kind: "ConditionElementList", collectionElementName: "Condition")
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "ElseKeyword",
        kind: .node(kind: "ElseToken"),
        isOptional: true
      ),
      Child(
        name: "ElseBody",
        kind: .nodeChoices(choices: [
          Child(
            name: "IfExpr",
            kind: .node(kind: "IfExpr")
          ),
          Child(
            name: "CodeBlock",
            kind: .node(kind: "CodeBlock")
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
    name: "InOutExpr",
    nameForDiagnostics: "inout expression",
    kind: "Expr",
    children: [
      Child(
        name: "Ampersand",
        kind: .token(choices: [.token(tokenKind: "PrefixAmpersandToken")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // An infix binary expression like x + y.
  // NOTE: This won't come directly out of the parser. Rather, it is the
  // result of "folding" a SequenceExpr based on knowing the precedence
  // relationships amongst the different infix operators.
  Node(
    name: "InfixOperatorExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "LeftOperand",
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "OperatorOperand",
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "RightOperand",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // An integer literal.
  // 3
  // +3_400
  // +0x4f
  Node(
    name: "IntegerLiteralExpr",
    nameForDiagnostics: "integer literal",
    kind: "Expr",
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
    name: "IsExpr",
    nameForDiagnostics: "'is'",
    kind: "Expr",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "IsTok",
        kind: .token(choices: [.keyword(text: "is")])
      ),
      Child(
        name: "TypeName",
        kind: .node(kind: "Type")
      ),
    ]
  ),

  // The components of a key path
  Node(
    name: "KeyPathComponentList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "KeyPathComponent"
  ),

  // A single key path component.
  Node(
    name: "KeyPathComponent",
    nameForDiagnostics: "key path component",
    kind: "Syntax",
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
            kind: .node(kind: "KeyPathPropertyComponent")
          ),
          Child(
            name: "Subscript",
            kind: .node(kind: "KeyPathSubscriptComponent")
          ),
          Child(
            name: "Optional",
            kind: .node(kind: "KeyPathOptionalComponent")
          ),
        ])
      ),
    ]
  ),

  // e.g. "\a.b[2].a"
  Node(
    name: "KeyPathExpr",
    nameForDiagnostics: "key path",
    kind: "Expr",
    children: [
      Child(
        name: "Backslash",
        kind: .token(choices: [.token(tokenKind: "BackslashToken")])
      ),
      Child(
        name: "Root",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "root",
        isOptional: true
      ),
      Child(
        name: "Components",
        kind: .collection(kind: "KeyPathComponentList", collectionElementName: "KeyPathComponent")
      ),
    ]
  ),

  // A key path component like '?' or '!'.
  Node(
    name: "KeyPathOptionalComponent",
    nameForDiagnostics: "key path optional component",
    kind: "Syntax",
    children: [
      Child(
        name: "QuestionOrExclamationMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")])
      )
    ]
  ),

  // A key path component like .property or .1.
  Node(
    name: "KeyPathPropertyComponent",
    nameForDiagnostics: "key path property component",
    kind: "Syntax",
    children: [
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "KeywordToken"), .token(tokenKind: "DollarIdentifierToken"), .token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "IntegerLiteralToken")])
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: "DeclNameArguments"),
        isOptional: true
      ),
      Child(
        name: "GenericArgumentClause",
        kind: .node(kind: "GenericArgumentClause"),
        isOptional: true
      ),
    ]
  ),

  // A key path component like .[17]
  Node(
    name: "KeyPathSubscriptComponent",
    nameForDiagnostics: "key path subscript component",
    kind: "Syntax",
    children: [
      Child(
        name: "LeftBracket",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument"),
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
    name: "MacroExpansionExpr",
    nameForDiagnostics: "macro expansion",
    kind: "Expr",
    traits: [
      "FreestandingMacroExpansion"
    ],
    children: [
      Child(
        name: "PoundToken",
        kind: .token(choices: [.token(tokenKind: "PoundToken")]),
        description: "The `#` sign."
      ),
      Child(
        name: "Macro",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "GenericArguments",
        kind: .node(kind: "GenericArgumentClause"),
        isOptional: true
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        isOptional: true
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        isOptional: true
      ),
      Child(
        name: "TrailingClosure",
        kind: .node(kind: "ClosureExpr"),
        isOptional: true
      ),
      Child(
        name: "AdditionalTrailingClosures",
        kind: .collection(kind: "MultipleTrailingClosureElementList", collectionElementName: "AdditionalTrailingClosure"),
        isOptional: true
      ),
    ]
  ),

  // expr?.name
  Node(
    name: "MemberAccessExpr",
    nameForDiagnostics: "member access",
    kind: "Expr",
    children: [
      Child(
        name: "Base",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "base",
        isOptional: true
      ),
      Child(
        name: "Dot",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")])
      ),
      Child(
        name: "Name",
        kind: .node(kind: "Token"),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: "DeclNameArguments"),
        isOptional: true
      ),
    ]
  ),

  // The move expr
  Node(
    name: "MoveExpr",
    nameForDiagnostics: "'consume' expression",
    kind: "Expr",
    children: [
      Child(
        name: "MoveKeyword",
        kind: .token(choices: [.keyword(text: "_move"), .keyword(text: "consume")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  Node(
    name: "CopyExpr",
    nameForDiagnostics: "'copy' expression",
    kind: "Expr",
    children: [
      Child(
        name: "CopyKeyword",
        kind: .token(choices: [.keyword(text: "copy")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  Node(
    name: "MultipleTrailingClosureElementList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "MultipleTrailingClosureElement"
  ),

  // trailing-closure-element -> identifier ':' closure-expression
  Node(
    name: "MultipleTrailingClosureElement",
    nameForDiagnostics: "trailing closure",
    kind: "Syntax",
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
        kind: .node(kind: "ClosureExpr")
      ),
    ]
  ),

  // A nil expression.
  Node(
    name: "NilLiteralExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "NilKeyword",
        kind: .token(choices: [.keyword(text: "nil")])
      )
    ]
  ),

  // optional-chaining-expr -> expr '?'
  Node(
    name: "OptionalChainingExpr",
    nameForDiagnostics: "optional chaining",
    kind: "Expr",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "QuestionMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken")])
      ),
    ]
  ),

  // A pack element expr spelled with 'each'.
  Node(
    name: "PackElementExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "EachKeyword",
        kind: .token(choices: [.keyword(text: "each")])
      ),
      Child(
        name: "PackRefExpr",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // A pack expansion expr spelled with 'repeat'.
  Node(
    name: "PackExpansionExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "RepeatKeyword",
        kind: .token(choices: [.keyword(text: "repeat")])
      ),
      Child(
        name: "PatternExpr",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // postfix '#if' expression
  Node(
    name: "PostfixIfConfigExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "Base",
        kind: .node(kind: "Expr"),
        isOptional: true
      ),
      Child(
        name: "Config",
        kind: .node(kind: "IfConfigDecl")
      ),
    ]
  ),

  // postfix-unary-expr -> expr postfix-operator
  Node(
    name: "PostfixUnaryExpr",
    nameForDiagnostics: "postfix expression",
    kind: "Expr",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
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
    name: "PrefixOperatorExpr",
    nameForDiagnostics: "operator",
    kind: "Expr",
    children: [
      Child(
        name: "OperatorToken",
        kind: .token(choices: [.token(tokenKind: "PrefixOperatorToken")]),
        isOptional: true
      ),
      Child(
        name: "PostfixExpression",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // e.g '(a|c)*', the contents of the literal is opaque to the C++ Swift
  // parser though.
  Node(
    name: "RegexLiteralExpr",
    nameForDiagnostics: "regex literal",
    kind: "Expr",
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
    name: "SequenceExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "Elements",
        kind: .collection(kind: "ExprList", collectionElementName: "Element")
      )
    ]
  ),

  // specialize-expr -> expr generic-argument-clause?
  Node(
    name: "SpecializeExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "GenericArgumentClause",
        kind: .node(kind: "GenericArgumentClause")
      ),
    ]
  ),

  // e.g. "abc \(foo()) def"
  Node(
    name: "StringLiteralExpr",
    nameForDiagnostics: "string literal",
    kind: "Expr",
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
        kind: .collection(kind: "StringLiteralSegments", collectionElementName: "Segment")
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
    name: "StringLiteralSegments",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "Syntax",
    elementName: "Segment",
    elementChoices: ["StringSegment", "ExpressionSegment"]
  ),

  // string literal segment in a string interpolation expression.
  Node(
    name: "StringSegment",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "Content",
        kind: .token(choices: [.token(tokenKind: "StringSegmentToken")])
      )
    ]
  ),

  // subscript-expr -> expr '[' call-argument-list ']' closure-expr?
  Node(
    name: "SubscriptExpr",
    nameForDiagnostics: "subscript",
    kind: "Expr",
    children: [
      Child(
        name: "CalledExpression",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "called expression"
      ),
      Child(
        name: "LeftBracket",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument"),
        nameForDiagnostics: "arguments"
      ),
      Child(
        name: "RightBracket",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
      ),
      Child(
        name: "TrailingClosure",
        kind: .node(kind: "ClosureExpr"),
        nameForDiagnostics: "trailing closure",
        isOptional: true
      ),
      Child(
        name: "AdditionalTrailingClosures",
        kind: .collection(kind: "MultipleTrailingClosureElementList", collectionElementName: "AdditionalTrailingClosure"),
        nameForDiagnostics: "trailing closures",
        isOptional: true
      ),
    ]
  ),

  // An 'super' expression.
  Node(
    name: "SuperRefExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "SuperKeyword",
        kind: .token(choices: [.keyword(text: "super")])
      )
    ]
  ),

  // switch-case-label -> 'case' case-item-list ':'
  Node(
    name: "SwitchCaseLabel",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "CaseKeyword",
        kind: .token(choices: [.keyword(text: "case")])
      ),
      Child(
        name: "CaseItems",
        kind: .collection(kind: "CaseItemList", collectionElementName: "CaseItem")
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")], requiresTrailingSpace: false)
      ),
    ]
  ),

  // switch-case-list -> switch-case switch-case-list?
  Node(
    name: "SwitchCaseList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "Syntax",
    elementName: "SwitchCase",
    elementChoices: ["SwitchCase", "IfConfigDecl"],
    elementsSeparatedByNewline: true
  ),

  // switch-case -> unknown-attr? switch-case-label stmt-list
  //              | unknown-attr? switch-default-label stmt-list
  Node(
    name: "SwitchCase",
    nameForDiagnostics: "switch case",
    kind: "Syntax",
    traits: [
      "WithStatements"
    ],
    parserFunction: "parseSwitchCase",
    children: [
      Child(
        name: "UnknownAttr",
        kind: .node(kind: "Attribute"),
        isOptional: true
      ),
      Child(
        name: "Label",
        kind: .nodeChoices(choices: [
          Child(
            name: "Default",
            kind: .node(kind: "SwitchDefaultLabel")
          ),
          Child(
            name: "Case",
            kind: .node(kind: "SwitchCaseLabel")
          ),
        ]),
        nameForDiagnostics: "label"
      ),
      Child(
        name: "Statements",
        kind: .collection(kind: "CodeBlockItemList", collectionElementName: "Statement"),
        isIndented: true
      ),
    ]
  ),

  // switch-default-label -> 'default' ':'
  Node(
    name: "SwitchDefaultLabel",
    nameForDiagnostics: nil,
    kind: "Syntax",
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
    name: "SwitchExpr",
    nameForDiagnostics: "'switch' statement",
    kind: "Expr",
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
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "LeftBrace",
        kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])
      ),
      Child(
        name: "Cases",
        kind: .collection(kind: "SwitchCaseList", collectionElementName: "Case")
      ),
      Child(
        name: "RightBrace",
        kind: .token(choices: [.token(tokenKind: "RightBraceToken")]),
        requiresLeadingNewline: true
      ),
    ]
  ),

  // a ? 1 : 0
  // NOTE: This won't come directly out of the parser. Rather, it is the
  // result of "folding" a SequenceExpr based on knowing the precedence
  // relationships amongst the different infix operators.
  Node(
    name: "TernaryExpr",
    nameForDiagnostics: "ternay expression",
    kind: "Expr",
    children: [
      Child(
        name: "ConditionExpression",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "condition"
      ),
      Child(
        name: "QuestionMark",
        kind: .token(choices: [.token(tokenKind: "InfixQuestionMarkToken")])
      ),
      Child(
        name: "FirstChoice",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "first choice"
      ),
      Child(
        name: "ColonMark",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "SecondChoice",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "second choice"
      ),
    ]
  ),

  // The try operator.
  // try foo()
  // try? foo()
  // try! foo()
  Node(
    name: "TryExpr",
    nameForDiagnostics: "'try' expression",
    kind: "Expr",
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
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  Node(
    name: "TupleExprElementList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "TupleExprElement"
  ),

  // An element inside a tuple element list
  Node(
    name: "TupleExprElement",
    nameForDiagnostics: nil,
    kind: "Syntax",
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
        kind: .node(kind: "Expr"),
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
    name: "TupleExpr",
    nameForDiagnostics: "tuple",
    kind: "Expr",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "ElementList",
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Element"),
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
    name: "TypeExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "Type",
        kind: .node(kind: "Type")
      )
    ]
  ),

  // 'as' ('?'|'!')
  // "as" type casting operator without operands.
  // NOTE: This appears only in SequenceExpr.
  Node(
    name: "UnresolvedAsExpr",
    nameForDiagnostics: "'as'",
    kind: "Expr",
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
    name: "UnresolvedIsExpr",
    nameForDiagnostics: "'is'",
    kind: "Expr",
    children: [
      Child(
        name: "IsTok",
        kind: .token(choices: [.keyword(text: "is")])
      )
    ]
  ),
  // unresolved-pattern-expr -> pattern
  Node(
    name: "UnresolvedPatternExpr",
    nameForDiagnostics: nil,
    kind: "Expr",
    children: [
      Child(
        name: "Pattern",
        kind: .node(kind: "Pattern")
      )
    ]
  ),

  // ? expr :
  // Ternary expression without the condition and the second choice.
  // NOTE: This appears only in SequenceExpr.
  Node(
    name: "UnresolvedTernaryExpr",
    nameForDiagnostics: "ternary operator",
    kind: "Expr",
    children: [
      Child(
        name: "QuestionMark",
        kind: .token(choices: [.token(tokenKind: "InfixQuestionMarkToken")])
      ),
      Child(
        name: "FirstChoice",
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "ColonMark",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
    ]
  ),

  Node(
    name: "YieldExprListElement",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "YieldExprList",
    nameForDiagnostics: "yield list",
    kind: "SyntaxCollection",
    element: "YieldExprListElement",
    elementName: "Yields"
  ),

]
