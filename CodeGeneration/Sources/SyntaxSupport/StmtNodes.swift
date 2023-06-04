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
    kind: .availabilityCondition,
    base: .syntax,
    nameForDiagnostics: "availability condition",
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
        name: "AvailabilityArguments",
        kind: .collection(kind: .availabilitySpecList, collectionElementName: "AvailabilityArgument")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  // break-stmt -> 'break' identifier? ';'?
  Node(
    kind: .breakStmt,
    base: .stmt,
    nameForDiagnostics: "'break' statement",
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
    kind: .caseItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.caseItem]
  ),

  // catch-clause-list -> catch-clause catch-clause-list?
  Node(
    kind: .catchClauseList,
    base: .syntaxCollection,
    nameForDiagnostics: "'catch' clause",
    elementChoices: [.catchClause]
  ),

  // catch-clause 'catch' case-item-list? code-block
  Node(
    kind: .catchClause,
    base: .syntax,
    nameForDiagnostics: "'catch' clause",
    parserFunction: "parseCatchClause",
    traits: ["WithCodeBlock"],
    children: [
      Child(
        name: "CatchKeyword",
        kind: .token(choices: [.keyword(text: "catch")])
      ),
      Child(
        name: "CatchItems",
        kind: .collection(kind: .catchItemList, collectionElementName: "CatchItem"),
        isOptional: true
      ),
      Child(
        name: "Body",
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  // catch-item-list -> catch-item catch-item-list?
  Node(
    kind: .catchItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.catchItem]
  ),

  // catch-item -> pattern? where-clause? ','?
  Node(
    kind: .catchItem,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Pattern",
        kind: .node(kind: .pattern),
        isOptional: true
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

  // condition-list -> condition
  //                 | condition ','? condition-list
  Node(
    kind: .conditionElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.conditionElement]
  ),

  // condition -> expression
  //            | availability-condition
  //            | case-condition
  //            | optional-binding-condition
  Node(
    kind: .conditionElement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Condition",
        kind: .nodeChoices(choices: [
          Child(
            name: "Expression",
            kind: .node(kind: .expr)
          ),
          Child(
            name: "Availability",
            kind: .node(kind: .availabilityCondition)
          ),
          Child(
            name: "MatchingPattern",
            kind: .node(kind: .matchingPatternCondition)
          ),
          Child(
            name: "OptionalBinding",
            kind: .node(kind: .optionalBindingCondition)
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
    kind: .continueStmt,
    base: .stmt,
    nameForDiagnostics: "'continue' statement",
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
    kind: .deferStmt,
    base: .stmt,
    nameForDiagnostics: "'defer' statement",
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
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  // do-stmt -> identifier? ':'? 'do' code-block catch-clause-list ';'?
  Node(
    kind: .doStmt,
    base: .stmt,
    nameForDiagnostics: "'do' statement",
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
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "CatchClauses",
        kind: .collection(kind: .catchClauseList, collectionElementName: "CatchClause"),
        isOptional: true
      ),
    ]
  ),

  // expr-stmt -> expression ';'?
  Node(
    kind: .expressionStmt,
    base: .stmt,
    nameForDiagnostics: "expression",
    children: [
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      )
    ]
  ),

  // fallthrough-stmt -> 'fallthrough' ';'?
  Node(
    kind: .fallthroughStmt,
    base: .stmt,
    nameForDiagnostics: "'fallthrough' statement",
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
    kind: .forInStmt,
    base: .stmt,
    nameForDiagnostics: "'for' statement",
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
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "TypeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "InKeyword",
        kind: .token(choices: [.keyword(text: "in")])
      ),
      Child(
        name: "SequenceExpr",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "WhereClause",
        kind: .node(kind: .whereClause),
        isOptional: true
      ),
      Child(
        name: "Body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
    ]
  ),

  // discard-stmt -> 'discard' expr ';'?
  Node(
    kind: .discardStmt,
    base: .stmt,
    nameForDiagnostics: "'discard' statement",
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
        kind: .node(kind: .expr)
      ),
    ]
  ),

  // guard-stmt -> 'guard' condition-list 'else' code-block ';'?
  Node(
    kind: .guardStmt,
    base: .stmt,
    nameForDiagnostics: "'guard' statement",
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
        kind: .collection(kind: .conditionElementList, collectionElementName: "Condition"),
        nameForDiagnostics: "condition"
      ),
      Child(
        name: "ElseKeyword",
        kind: .token(choices: [.keyword(text: "else")])
      ),
      Child(
        name: "Body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
    ]
  ),

  // labeled-stmt -> label ':' stmt
  Node(
    kind: .labeledStmt,
    base: .stmt,
    nameForDiagnostics: "labeled statement",
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
        kind: .node(kind: .stmt)
      ),
    ]
  ),

  Node(
    kind: .matchingPatternCondition,
    base: .syntax,
    nameForDiagnostics: "pattern matching",
    children: [
      Child(
        name: "CaseKeyword",
        kind: .token(choices: [.keyword(text: "case")])
      ),
      Child(
        name: "Pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "TypeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: .initializerClause)
      ),
    ]
  ),

  Node(
    kind: .optionalBindingCondition,
    base: .syntax,
    nameForDiagnostics: "optional binding",
    children: [
      Child(
        name: "BindingKeyword",
        kind: .token(choices: [.keyword(text: "let"), .keyword(text: "var"), .keyword(text: "inout")])
      ),
      Child(
        name: "Pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "TypeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: .initializerClause),
        isOptional: true
      ),
    ]
  ),

  // repeat-while-stmt -> label? ':'? 'repeat' code-block 'while' expr ';'?
  Node(
    kind: .repeatWhileStmt,
    base: .stmt,
    nameForDiagnostics: "'repeat' statement",
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
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "WhileKeyword",
        kind: .token(choices: [.keyword(text: "while")])
      ),
      Child(
        name: "Condition",
        kind: .node(kind: .expr),
        nameForDiagnostics: "condition"
      ),
    ]
  ),

  // return-stmt -> 'return' expr? ';'?
  Node(
    kind: .returnStmt,
    base: .stmt,
    nameForDiagnostics: "'return' statement",
    children: [
      Child(
        name: "ReturnKeyword",
        kind: .token(choices: [.keyword(text: "return")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: .expr),
        isOptional: true
      ),
    ]
  ),

  // throw-stmt -> 'throw' expr ';'?
  Node(
    kind: .throwStmt,
    base: .stmt,
    nameForDiagnostics: "'throw' statement",
    children: [
      Child(
        name: "ThrowKeyword",
        kind: .token(choices: [.keyword(text: "throw")])
      ),
      Child(
        name: "Expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .whereClause,
    base: .syntax,
    nameForDiagnostics: "'where' clause",
    children: [
      Child(
        name: "WhereKeyword",
        kind: .token(choices: [.keyword(text: "where")])
      ),
      Child(
        name: "GuardResult",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  // while-stmt -> label? ':'? 'while' condition-list code-block ';'?
  Node(
    kind: .whileStmt,
    base: .stmt,
    nameForDiagnostics: "'while' statement",
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
        kind: .collection(kind: .conditionElementList, collectionElementName: "Condition")
      ),
      Child(
        name: "Body",
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  Node(
    kind: .yieldList,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "ElementList",
        kind: .collection(kind: .yieldExprList, collectionElementName: "Element")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  // yield-stmt -> 'yield' '('? expr-list? ')'?
  Node(
    kind: .yieldStmt,
    base: .stmt,
    nameForDiagnostics: "'yield' statement",
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
            kind: .node(kind: .yieldList)
          ),
          Child(
            name: "SimpleYield",
            kind: .node(kind: .expr)
          ),
        ])
      ),
    ]
  ),

]
