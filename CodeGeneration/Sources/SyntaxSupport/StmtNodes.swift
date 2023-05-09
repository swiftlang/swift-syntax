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

public let STMT_NODES: [Node] = [
  // availability-condition -> '#available' '(' availability-spec ')'
  Node(
    name: "AvailabilityCondition",
    nameForDiagnostics: "availability condition",
    kind: "Syntax",
    children: [
      Child(
        name: "AvailabilityKeyword",
        kind: .token(choices: [.token(tokenKind: "PoundAvailableToken"), .token(tokenKind: "PoundUnavailableToken")])
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "AvailabilitySpec",
        kind: .collection(kind: "AvailabilitySpecList", collectionElementName: "AvailabilityArgument")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  // break-stmt -> 'break' identifier? ';'?
  Node(
    name: "BreakStmt",
    nameForDiagnostics: "'break' statement",
    kind: "Stmt",
    children: [
      Child(
        name: "BreakKeyword",
        kind: .token(choices: [.keyword(text: "break")], requiresTrailingSpace: false)
      ),
      Child(
        name: "Label",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
    ]
  ),

  // case-item-list -> case-item case-item-list?
  Node(
    name: "CaseItemList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "CaseItem"
  ),

  // catch-clause-list -> catch-clause catch-clause-list?
  Node(
    name: "CatchClauseList",
    nameForDiagnostics: "'catch' clause",
    kind: "SyntaxCollection",
    element: "CatchClause"
  ),

  // catch-clause 'catch' case-item-list? code-block
  Node(
    name: "CatchClause",
    nameForDiagnostics: "'catch' clause",
    kind: "Syntax",
    traits: [
      "WithCodeBlock"
    ],
    parserFunction: "parseCatchClause",
    children: [
      Child(
        name: "CatchKeyword",
        kind: .token(choices: [.keyword(text: "catch")])
      ),
      Child(
        name: "CatchItems",
        kind: .collection(kind: "CatchItemList", collectionElementName: "CatchItem"),
        isOptional: true
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock")
      ),
    ]
  ),

  // catch-item-list -> catch-item catch-item-list?
  Node(
    name: "CatchItemList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "CatchItem"
  ),

  // catch-item -> pattern? where-clause? ','?
  Node(
    name: "CatchItem",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Pattern",
        kind: .node(kind: "Pattern"),
        isOptional: true
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

  // condition-list -> condition
  //                 | condition ','? condition-list
  Node(
    name: "ConditionElementList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "ConditionElement"
  ),

  // condition -> expression
  //            | availability-condition
  //            | case-condition
  //            | optional-binding-condition
  Node(
    name: "ConditionElement",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Condition",
        kind: .nodeChoices(choices: [
          Child(
            name: "Expression",
            kind: .node(kind: "Expr")
          ),
          Child(
            name: "Availability",
            kind: .node(kind: "AvailabilityCondition")
          ),
          Child(
            name: "MatchingPattern",
            kind: .node(kind: "MatchingPatternCondition")
          ),
          Child(
            name: "OptionalBinding",
            kind: .node(kind: "OptionalBindingCondition")
          ),
        ])
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  // continue-stmt -> 'continue' label? ';'?
  Node(
    name: "ContinueStmt",
    nameForDiagnostics: "'continue' statement",
    kind: "Stmt",
    children: [
      Child(
        name: "ContinueKeyword",
        kind: .token(choices: [.keyword(text: "continue")])
      ),
      Child(
        name: "Label",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
    ]
  ),

  // defer-stmt -> 'defer' code-block ';'?
  Node(
    name: "DeferStmt",
    nameForDiagnostics: "'defer' statement",
    kind: "Stmt",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "DeferKeyword",
        kind: .token(choices: [.keyword(text: "defer")])
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock")
      ),
    ]
  ),

  // do-stmt -> identifier? ':'? 'do' code-block catch-clause-list ';'?
  Node(
    name: "DoStmt",
    nameForDiagnostics: "'do' statement",
    kind: "Stmt",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "DoKeyword",
        kind: .token(choices: [.keyword(text: "do")])
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "CatchClauses",
        kind: .collection(kind: "CatchClauseList", collectionElementName: "CatchClause"),
        isOptional: true
      ),
    ]
  ),

  // expr-stmt -> expression ';'?
  Node(
    name: "ExpressionStmt",
    nameForDiagnostics: "expression",
    kind: "Stmt",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      )
    ]
  ),

  // fallthrough-stmt -> 'fallthrough' ';'?
  Node(
    name: "FallthroughStmt",
    nameForDiagnostics: "'fallthrough' statement",
    kind: "Stmt",
    children: [
      Child(
        name: "FallthroughKeyword",
        kind: .token(choices: [.keyword(text: "fallthrough")])
      )
    ]
  ),

  // for-in-stmt -> label? ':'?
  //   'for' 'try'? 'await'? 'case'? pattern 'in' expr 'where'?
  //   expr code-block ';'?
  Node(
    name: "ForInStmt",
    nameForDiagnostics: "'for' statement",
    kind: "Stmt",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "ForKeyword",
        kind: .token(choices: [.keyword(text: "for")])
      ),
      Child(
        name: "TryKeyword",
        kind: .token(choices: [.keyword(text: "try")]),
        isOptional: true
      ),
      Child(
        name: "AwaitKeyword",
        kind: .token(choices: [.keyword(text: "await")]),
        isOptional: true
      ),
      Child(
        name: "CaseKeyword",
        kind: .token(choices: [.keyword(text: "case")]),
        isOptional: true
      ),
      Child(
        name: "Pattern",
        kind: .node(kind: "Pattern")
      ),
      Child(
        name: "TypeAnnotation",
        kind: .node(kind: "TypeAnnotation"),
        isOptional: true
      ),
      Child(
        name: "InKeyword",
        kind: .token(choices: [.keyword(text: "in")])
      ),
      Child(
        name: "SequenceExpr",
        kind: .node(kind: "Expr")
      ),
      Child(
        name: "WhereClause",
        kind: .node(kind: "WhereClause"),
        isOptional: true
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        nameForDiagnostics: "body"
      ),
    ]
  ),

  // discard-stmt -> 'discard' expr ';'?
  Node(
    name: "DiscardStmt",
    nameForDiagnostics: "'discard' statement",
    kind: "Stmt",
    children: [
      Child(
        name: "DiscardKeyword",
        kind: .token(choices: [
          .keyword(text: "_forget"),  // NOTE: support for deprecated _forget
          .keyword(text: "discard"),
        ])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // guard-stmt -> 'guard' condition-list 'else' code-block ';'?
  Node(
    name: "GuardStmt",
    nameForDiagnostics: "'guard' statement",
    kind: "Stmt",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "GuardKeyword",
        kind: .token(choices: [.keyword(text: "guard")])
      ),
      Child(
        name: "Conditions",
        kind: .collection(kind: "ConditionElementList", collectionElementName: "Condition"),
        nameForDiagnostics: "condition"
      ),
      Child(
        name: "ElseKeyword",
        kind: .token(choices: [.keyword(text: "else")])
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        nameForDiagnostics: "body"
      ),
    ]
  ),

  // labeled-stmt -> label ':' stmt
  Node(
    name: "LabeledStmt",
    nameForDiagnostics: "labeled statement",
    kind: "Stmt",
    children: [
      Child(
        name: "LabelName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "label name"
      ),
      Child(
        name: "LabelColon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Statement",
        kind: .node(kind: "Stmt")
      ),
    ]
  ),

  Node(
    name: "MatchingPatternCondition",
    nameForDiagnostics: "pattern matching",
    kind: "Syntax",
    children: [
      Child(
        name: "CaseKeyword",
        kind: .token(choices: [.keyword(text: "case")])
      ),
      Child(
        name: "Pattern",
        kind: .node(kind: "Pattern")
      ),
      Child(
        name: "TypeAnnotation",
        kind: .node(kind: "TypeAnnotation"),
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: "InitializerClause")
      ),
    ]
  ),

  Node(
    name: "OptionalBindingCondition",
    nameForDiagnostics: "optional binding",
    kind: "Syntax",
    children: [
      Child(
        name: "BindingKeyword",
        kind: .token(choices: [.keyword(text: "let"), .keyword(text: "var"), .keyword(text: "inout")])
      ),
      Child(
        name: "Pattern",
        kind: .node(kind: "Pattern")
      ),
      Child(
        name: "TypeAnnotation",
        kind: .node(kind: "TypeAnnotation"),
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: "InitializerClause"),
        isOptional: true
      ),
    ]
  ),

  // repeat-while-stmt -> label? ':'? 'repeat' code-block 'while' expr ';'?
  Node(
    name: "RepeatWhileStmt",
    nameForDiagnostics: "'repeat' statement",
    kind: "Stmt",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "RepeatKeyword",
        kind: .token(choices: [.keyword(text: "repeat")])
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "WhileKeyword",
        kind: .token(choices: [.keyword(text: "while")])
      ),
      Child(
        name: "Condition",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "condition"
      ),
    ]
  ),

  // return-stmt -> 'return' expr? ';'?
  Node(
    name: "ReturnStmt",
    nameForDiagnostics: "'return' statement",
    kind: "Stmt",
    children: [
      Child(
        name: "ReturnKeyword",
        kind: .token(choices: [.keyword(text: "return")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: "Expr"),
        isOptional: true
      ),
    ]
  ),

  // throw-stmt -> 'throw' expr ';'?
  Node(
    name: "ThrowStmt",
    nameForDiagnostics: "'throw' statement",
    kind: "Stmt",
    children: [
      Child(
        name: "ThrowKeyword",
        kind: .token(choices: [.keyword(text: "throw")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  Node(
    name: "WhereClause",
    nameForDiagnostics: "'where' clause",
    kind: "Syntax",
    children: [
      Child(
        name: "WhereKeyword",
        kind: .token(choices: [.keyword(text: "where")])
      ),
      Child(
        name: "GuardResult",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  // while-stmt -> label? ':'? 'while' condition-list code-block ';'?
  Node(
    name: "WhileStmt",
    nameForDiagnostics: "'while' statement",
    kind: "Stmt",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "WhileKeyword",
        kind: .token(choices: [.keyword(text: "while")])
      ),
      Child(
        name: "Conditions",
        kind: .collection(kind: "ConditionElementList", collectionElementName: "Condition")
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock")
      ),
    ]
  ),

  Node(
    name: "YieldList",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "ElementList",
        kind: .collection(kind: "YieldExprList", collectionElementName: "Element")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  // yield-stmt -> 'yield' '('? expr-list? ')'?
  Node(
    name: "YieldStmt",
    nameForDiagnostics: "'yield' statement",
    kind: "Stmt",
    children: [
      Child(
        name: "YieldKeyword",
        kind: .token(choices: [.keyword(text: "yield")])
      ),
      Child(
        name: "Yields",
        kind: .nodeChoices(choices: [
          Child(
            name: "YieldList",
            kind: .node(kind: "YieldList")
          ),
          Child(
            name: "SimpleYield",
            kind: .node(kind: "Expr")
          ),
        ])
      ),
    ]
  ),

]
