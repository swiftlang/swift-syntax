//// Automatically Generated From GenericNodes.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

let STMT_NODES: [Node] = [
  Node(name: "ContinueStmt",
       kind: "Stmt",
       children: [
         Child(name: "ContinueKeyword",
               kind: "ContinueToken"),
         Child(name: "Label",
               kind: "IdentifierToken",
               isOptional: true)
       ]),

  Node(name: "WhileStmt",
       kind: "Stmt",
       traits: [
         "WithCodeBlock",
         "Labeled"
       ],
       children: [
         Child(name: "LabelName",
               kind: "IdentifierToken",
               isOptional: true),
         Child(name: "LabelColon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "WhileKeyword",
               kind: "WhileToken"),
         Child(name: "Conditions",
               kind: "ConditionElementList",
               collectionElementName: "Condition"),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "DeferStmt",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "DeferKeyword",
               kind: "DeferToken"),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "ExpressionStmt",
       kind: "Stmt",
       children: [
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "SwitchCaseList",
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "SwitchCase",
       elementChoices: ["SwitchCase", "IfConfigDecl"],
       elementsSeparatedByNewline: true),

  Node(name: "RepeatWhileStmt",
       kind: "Stmt",
       traits: [
         "WithCodeBlock",
         "Labeled"
       ],
       children: [
         Child(name: "LabelName",
               kind: "IdentifierToken",
               isOptional: true),
         Child(name: "LabelColon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "RepeatKeyword",
               kind: "RepeatToken"),
         Child(name: "Body",
               kind: "CodeBlock"),
         Child(name: "WhileKeyword",
               kind: "WhileToken"),
         Child(name: "Condition",
               kind: "Expr")
       ]),

  Node(name: "GuardStmt",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "GuardKeyword",
               kind: "GuardToken"),
         Child(name: "Conditions",
               kind: "ConditionElementList",
               collectionElementName: "Condition"),
         Child(name: "ElseKeyword",
               kind: "ElseToken"),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "WhereClause",
       kind: "Syntax",
       children: [
         Child(name: "WhereKeyword",
               kind: "WhereToken"),
         Child(name: "GuardResult",
               kind: "Expr")
       ]),

  Node(name: "ForInStmt",
       kind: "Stmt",
       traits: [
         "WithCodeBlock",
         "Labeled"
       ],
       children: [
         Child(name: "LabelName",
               kind: "IdentifierToken",
               isOptional: true),
         Child(name: "LabelColon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "ForKeyword",
               kind: "ForToken"),
         Child(name: "TryKeyword",
               kind: "TryToken",
               isOptional: true),
         Child(name: "AwaitKeyword",
               kind: "IdentifierToken",
               isOptional: true,
               textChoices: [
                 "await"
               ],
               classification: "Keyword"),
         Child(name: "CaseKeyword",
               kind: "CaseToken",
               isOptional: true),
         Child(name: "Pattern",
               kind: "Pattern"),
         Child(name: "TypeAnnotation",
               kind: "TypeAnnotation",
               isOptional: true),
         Child(name: "InKeyword",
               kind: "InToken"),
         Child(name: "SequenceExpr",
               kind: "Expr"),
         Child(name: "WhereClause",
               kind: "WhereClause",
               isOptional: true),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "SwitchStmt",
       kind: "Stmt",
       traits: [
         "Braced",
         "Labeled"
       ],
       children: [
         Child(name: "LabelName",
               kind: "IdentifierToken",
               isOptional: true),
         Child(name: "LabelColon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "SwitchKeyword",
               kind: "SwitchToken"),
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "LeftBrace",
               kind: "LeftBraceToken"),
         Child(name: "Cases",
               kind: "SwitchCaseList",
               collectionElementName: "Case"),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               requiresLeadingNewline: true)
       ]),

  Node(name: "CatchClauseList",
       kind: "SyntaxCollection",
       element: "CatchClause"),

  Node(name: "DoStmt",
       kind: "Stmt",
       traits: [
         "WithCodeBlock",
         "Labeled"
       ],
       children: [
         Child(name: "LabelName",
               kind: "IdentifierToken",
               isOptional: true),
         Child(name: "LabelColon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "DoKeyword",
               kind: "DoToken"),
         Child(name: "Body",
               kind: "CodeBlock"),
         Child(name: "CatchClauses",
               kind: "CatchClauseList",
               isOptional: true,
               collectionElementName: "CatchClause")
       ]),

  Node(name: "ReturnStmt",
       kind: "Stmt",
       children: [
         Child(name: "ReturnKeyword",
               kind: "ReturnToken"),
         Child(name: "Expression",
               kind: "Expr",
               isOptional: true)
       ]),

  Node(name: "YieldStmt",
       kind: "Stmt",
       children: [
         Child(name: "YieldKeyword",
               kind: "YieldToken"),
         Child(name: "Yields",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "YieldList",
                       kind: "YieldList"),
                 Child(name: "SimpleYield",
                       kind: "Expr")
               ])
       ]),

  Node(name: "YieldList",
       kind: "Syntax",
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "ElementList",
               kind: "ExprList",
               collectionElementName: "Element"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "FallthroughStmt",
       kind: "Stmt",
       children: [
         Child(name: "FallthroughKeyword",
               kind: "FallthroughToken")
       ]),

  Node(name: "BreakStmt",
       kind: "Stmt",
       children: [
         Child(name: "BreakKeyword",
               kind: "BreakToken"),
         Child(name: "Label",
               kind: "IdentifierToken",
               isOptional: true)
       ]),

  Node(name: "CaseItemList",
       kind: "SyntaxCollection",
       element: "CaseItem"),

  Node(name: "CatchItemList",
       kind: "SyntaxCollection",
       element: "CatchItem"),

  Node(name: "ConditionElement",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Condition",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "Expression",
                       kind: "Expr"),
                 Child(name: "Availability",
                       kind: "AvailabilityCondition"),
                 Child(name: "Unavailability",
                       kind: "UnavailabilityCondition"),
                 Child(name: "MatchingPattern",
                       kind: "MatchingPatternCondition"),
                 Child(name: "OptionalBinding",
                       kind: "OptionalBindingCondition")
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "AvailabilityCondition",
       kind: "Syntax",
       children: [
         Child(name: "PoundAvailableKeyword",
               kind: "PoundAvailableToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "AvailabilitySpec",
               kind: "AvailabilitySpecList",
               collectionElementName: "AvailabilityArgument"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "MatchingPatternCondition",
       kind: "Syntax",
       children: [
         Child(name: "CaseKeyword",
               kind: "CaseToken"),
         Child(name: "Pattern",
               kind: "Pattern"),
         Child(name: "TypeAnnotation",
               kind: "TypeAnnotation",
               isOptional: true),
         Child(name: "Initializer",
               kind: "InitializerClause")
       ]),

  Node(name: "OptionalBindingCondition",
       kind: "Syntax",
       children: [
         Child(name: "LetOrVarKeyword",
               kind: "Token",
               tokenChoices: [
                 "Let",
                 "Var"
               ]),
         Child(name: "Pattern",
               kind: "Pattern"),
         Child(name: "TypeAnnotation",
               kind: "TypeAnnotation",
               isOptional: true),
         Child(name: "Initializer",
               kind: "InitializerClause",
               isOptional: true)
       ]),

  Node(name: "UnavailabilityCondition",
       kind: "Syntax",
       children: [
         Child(name: "PoundUnavailableKeyword",
               kind: "PoundUnavailableToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "AvailabilitySpec",
               kind: "AvailabilitySpecList",
               collectionElementName: "AvailabilityArgument"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "ConditionElementList",
       kind: "SyntaxCollection",
       element: "ConditionElement"),

  Node(name: "DeclarationStmt",
       kind: "Stmt",
       children: [
         Child(name: "Declaration",
               kind: "Decl")
       ]),

  Node(name: "ThrowStmt",
       kind: "Stmt",
       children: [
         Child(name: "ThrowKeyword",
               kind: "ThrowToken"),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "IfStmt",
       kind: "Stmt",
       traits: [
         "WithCodeBlock",
         "Labeled"
       ],
       children: [
         Child(name: "LabelName",
               kind: "IdentifierToken",
               isOptional: true),
         Child(name: "LabelColon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "IfKeyword",
               kind: "IfToken"),
         Child(name: "Conditions",
               kind: "ConditionElementList",
               collectionElementName: "Condition"),
         Child(name: "Body",
               kind: "CodeBlock"),
         Child(name: "ElseKeyword",
               kind: "ElseToken",
               isOptional: true),
         Child(name: "ElseBody",
               kind: "Syntax",
               isOptional: true,
               nodeChoices: [
                 Child(name: "IfStmt",
                       kind: "IfStmt"),
                 Child(name: "CodeBlock",
                       kind: "CodeBlock")
               ])
       ]),

  Node(name: "ElseIfContinuation",
       kind: "Syntax",
       children: [
         Child(name: "IfStatement",
               kind: "IfStmt")
       ]),

  Node(name: "ElseBlock",
       kind: "Syntax",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "ElseKeyword",
               kind: "ElseToken"),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "SwitchCase",
       kind: "Syntax",
       traits: [
         "WithStatements"
       ],
       children: [
         Child(name: "UnknownAttr",
               kind: "Attribute",
               isOptional: true),
         Child(name: "Label",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "Default",
                       kind: "SwitchDefaultLabel"),
                 Child(name: "Case",
                       kind: "SwitchCaseLabel")
               ]),
         Child(name: "Statements",
               kind: "CodeBlockItemList",
               collectionElementName: "Statement",
               isIndented: true)
       ]),

  Node(name: "SwitchDefaultLabel",
       kind: "Syntax",
       children: [
         Child(name: "DefaultKeyword",
               kind: "DefaultToken"),
         Child(name: "Colon",
               kind: "ColonToken")
       ]),

  Node(name: "CaseItem",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Pattern",
               kind: "Pattern"),
         Child(name: "WhereClause",
               kind: "WhereClause",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "CatchItem",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Pattern",
               kind: "Pattern",
               isOptional: true),
         Child(name: "WhereClause",
               kind: "WhereClause",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "SwitchCaseLabel",
       kind: "Syntax",
       children: [
         Child(name: "CaseKeyword",
               kind: "CaseToken"),
         Child(name: "CaseItems",
               kind: "CaseItemList",
               collectionElementName: "CaseItem"),
         Child(name: "Colon",
               kind: "ColonToken")
       ]),

  Node(name: "CatchClause",
       kind: "Syntax",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "CatchKeyword",
               kind: "CatchToken"),
         Child(name: "CatchItems",
               kind: "CatchItemList",
               isOptional: true,
               collectionElementName: "CatchItem"),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "PoundAssertStmt",
       kind: "Stmt",
       children: [
         Child(name: "PoundAssert",
               kind: "PoundAssertToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Condition",
               kind: "Expr",
               description: "The assertion condition."),
         Child(name: "Comma",
               kind: "CommaToken",
               description: "The comma after the assertion condition.",
               isOptional: true),
         Child(name: "Message",
               kind: "StringLiteralToken",
               description: "The assertion message.",
               isOptional: true),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

]
