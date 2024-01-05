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
  Node(
    kind: .availabilityCondition,
    base: .syntax,
    nameForDiagnostics: "availability condition",
    children: [
      Child(
        name: "availabilityKeyword",
        kind: .token(choices: [.token(.poundAvailable), .token(.poundUnavailable)])
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "availabilityArguments",
        deprecatedName: "availabilitySpec",
        kind: .collection(kind: .availabilityArgumentList, collectionElementName: "AvailabilityArgument")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .breakStmt,
    base: .stmt,
    nameForDiagnostics: "'break' statement",
    children: [
      Child(
        name: "breakKeyword",
        kind: .token(choices: [.keyword(.break)], requiresTrailingSpace: false)
      ),
      Child(
        name: "label",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .switchCaseItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.switchCaseItem]
  ),

  Node(
    kind: .catchClauseList,
    base: .syntaxCollection,
    nameForDiagnostics: "'catch' clause",
    elementChoices: [.catchClause]
  ),

  Node(
    kind: .catchClause,
    base: .syntax,
    nameForDiagnostics: "'catch' clause",
    parserFunction: "parseCatchClause",
    traits: ["WithCodeBlock"],
    children: [
      Child(
        name: "catchKeyword",
        kind: .token(choices: [.keyword(.catch)])
      ),
      Child(
        name: "catchItems",
        kind: .collection(kind: .catchItemList, collectionElementName: "CatchItem", defaultsToEmpty: true)
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  Node(
    kind: .catchItemList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.catchItem]
  ),

  Node(
    kind: .catchItem,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "pattern",
        kind: .node(kind: .pattern),
        isOptional: true
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
    kind: .conditionElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.conditionElement]
  ),

  Node(
    kind: .conditionElement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "condition",
        kind: .nodeChoices(choices: [
          Child(
            name: "expression",
            kind: .node(kind: .expr)
          ),
          Child(
            name: "availability",
            kind: .node(kind: .availabilityCondition)
          ),
          Child(
            name: "matchingPattern",
            kind: .node(kind: .matchingPatternCondition)
          ),
          Child(
            name: "optionalBinding",
            kind: .node(kind: .optionalBindingCondition)
          ),
        ])
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .continueStmt,
    base: .stmt,
    nameForDiagnostics: "'continue' statement",
    children: [
      Child(
        name: "continueKeyword",
        kind: .token(choices: [.keyword(.continue)])
      ),
      Child(
        name: "label",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "label",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .deferStmt,
    base: .stmt,
    nameForDiagnostics: "'defer' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "deferKeyword",
        kind: .token(choices: [.keyword(.defer)])
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  Node(
    kind: .doStmt,
    base: .stmt,
    nameForDiagnostics: "'do' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "doKeyword",
        kind: .token(choices: [.keyword(.do)])
      ),
      Child(
        name: "throwsClause",
        kind: .node(kind: .throwsClause),
        documentation: "The clause specifying the type of errors thrown from the 'do' block.",
        isOptional: true
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
    kind: .expressionStmt,
    base: .stmt,
    nameForDiagnostics: "expression",
    children: [
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      )
    ]
  ),

  Node(
    kind: .fallThroughStmt,
    base: .stmt,
    nameForDiagnostics: "'fallthrough' statement",
    children: [
      Child(
        name: "fallthroughKeyword",
        kind: .token(choices: [.keyword(.fallthrough)])
      )
    ]
  ),

  Node(
    kind: .forStmt,
    base: .stmt,
    nameForDiagnostics: "'for' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "forKeyword",
        kind: .token(choices: [.keyword(.for)])
      ),
      Child(
        name: "tryKeyword",
        kind: .token(choices: [.keyword(.try)]),
        isOptional: true
      ),
      Child(
        name: "awaitKeyword",
        kind: .token(choices: [.keyword(.await)]),
        isOptional: true
      ),
      Child(
        name: "caseKeyword",
        kind: .token(choices: [.keyword(.case)]),
        isOptional: true
      ),
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "typeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "inKeyword",
        kind: .token(choices: [.keyword(.in)])
      ),
      Child(
        name: "sequence",
        deprecatedName: "sequenceExpr",
        kind: .node(kind: .expr)
      ),
      Child(
        name: "whereClause",
        kind: .node(kind: .whereClause),
        isOptional: true
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
    ]
  ),

  Node(
    kind: .discardStmt,
    base: .stmt,
    nameForDiagnostics: "'discard' statement",
    children: [
      Child(
        name: "discardKeyword",
        kind: .token(choices: [.keyword(.discard)])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .guardStmt,
    base: .stmt,
    nameForDiagnostics: "'guard' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "guardKeyword",
        kind: .token(choices: [.keyword(.guard)])
      ),
      Child(
        name: "conditions",
        kind: .collection(kind: .conditionElementList, collectionElementName: "Condition"),
        nameForDiagnostics: "condition"
      ),
      Child(
        name: "elseKeyword",
        kind: .token(choices: [.keyword(.else)])
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
    ]
  ),

  Node(
    kind: .labeledStmt,
    base: .stmt,
    nameForDiagnostics: "labeled statement",
    children: [
      Child(
        name: "label",
        deprecatedName: "labelName",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "label name"
      ),
      Child(
        name: "colon",
        deprecatedName: "labelColon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "statement",
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
        name: "caseKeyword",
        kind: .token(choices: [.keyword(.case)])
      ),
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "typeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "initializer",
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
        name: "bindingSpecifier",
        deprecatedName: "bindingKeyword",
        kind: .token(choices: [
          .keyword(.let), .keyword(.var), .keyword(.inout), .keyword(._mutating), .keyword(._borrowing),
          .keyword(._consuming),
        ])
      ),
      Child(
        name: "pattern",
        kind: .node(kind: .pattern)
      ),
      Child(
        name: "typeAnnotation",
        kind: .node(kind: .typeAnnotation),
        isOptional: true
      ),
      Child(
        name: "initializer",
        kind: .node(kind: .initializerClause),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .repeatStmt,
    base: .stmt,
    nameForDiagnostics: "'repeat' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "repeatKeyword",
        kind: .token(choices: [.keyword(.repeat)])
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock),
        nameForDiagnostics: "body"
      ),
      Child(
        name: "whileKeyword",
        kind: .token(choices: [.keyword(.while)])
      ),
      Child(
        name: "condition",
        kind: .node(kind: .expr),
        nameForDiagnostics: "condition"
      ),
    ]
  ),

  Node(
    kind: .returnStmt,
    base: .stmt,
    nameForDiagnostics: "'return' statement",
    children: [
      Child(
        name: "returnKeyword",
        kind: .token(choices: [.keyword(.return)])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .throwStmt,
    base: .stmt,
    nameForDiagnostics: "'throw' statement",
    children: [
      Child(
        name: "throwKeyword",
        kind: .token(choices: [.keyword(.throw)])
      ),
      Child(
        name: "expression",
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
        name: "whereKeyword",
        kind: .token(choices: [.keyword(.where)])
      ),
      Child(
        name: "condition",
        deprecatedName: "guardResult",
        kind: .node(kind: .expr)
      ),
    ]
  ),

  Node(
    kind: .whileStmt,
    base: .stmt,
    nameForDiagnostics: "'while' statement",
    traits: [
      "WithCodeBlock"
    ],
    children: [
      Child(
        name: "whileKeyword",
        kind: .token(choices: [.keyword(.while)])
      ),
      Child(
        name: "conditions",
        kind: .collection(kind: .conditionElementList, collectionElementName: "Condition")
      ),
      Child(
        name: "body",
        kind: .node(kind: .codeBlock)
      ),
    ]
  ),

  Node(
    kind: .yieldedExpressionsClause,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "elements",
        deprecatedName: "elementList",
        kind: .collection(kind: .yieldedExpressionList, collectionElementName: "Element")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .yieldStmt,
    base: .stmt,
    nameForDiagnostics: "'yield' statement",
    children: [
      Child(
        name: "yieldKeyword",
        kind: .token(choices: [.keyword(.yield)])
      ),
      Child(
        name: "yieldedExpressions",
        deprecatedName: "yields",
        kind: .nodeChoices(choices: [
          Child(
            name: "multiple",
            deprecatedName: "yieldList",
            kind: .node(kind: .yieldedExpressionsClause)
          ),
          Child(
            name: "single",
            deprecatedName: "simpleYield",
            kind: .node(kind: .expr)
          ),
        ])
      ),
    ]
  ),

  Node(
    kind: .thenStmt,
    base: .stmt,
    experimentalFeature: .thenStatements,
    nameForDiagnostics: "'then' statement",
    documentation: """
      A statement used to indicate the produced value from an if/switch
      expression.

       Written as:
      ```swift
      then <expr>
      ```
      """,
    children: [
      Child(
        name: "thenKeyword",
        kind: .token(choices: [.keyword(.then)])
      ),
      Child(
        name: "expression",
        kind: .node(kind: .expr)
      ),
    ]
  ),
]
