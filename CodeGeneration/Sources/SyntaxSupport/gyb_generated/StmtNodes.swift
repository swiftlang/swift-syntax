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

public let STMT_NODES: [Node] = [
  Node(name: "LabeledStmt",
       nameForDiagnostics: "labeled statement",
       kind: "Stmt",
       children: [
         Child(name: "LabelName",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "LabelColon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Statement",
               kind: "Stmt")
       ]),

  Node(name: "ContinueStmt",
       nameForDiagnostics: "'continue' statement",
       kind: "Stmt",
       children: [
         Child(name: "ContinueKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "continue"
               ]),
         Child(name: "Label",
               kind: "IdentifierToken",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ])
       ]),

  Node(name: "WhileStmt",
       nameForDiagnostics: "'while' statement",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "WhileKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "while"
               ]),
         Child(name: "Conditions",
               kind: "ConditionElementList",
               collectionElementName: "Condition"),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "DeferStmt",
       nameForDiagnostics: "'defer' statement",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "DeferKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "defer"
               ]),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "SwitchCaseList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "SwitchCase",
       elementChoices: ["SwitchCase", "IfConfigDecl"],
       elementsSeparatedByNewline: true),

  Node(name: "RepeatWhileStmt",
       nameForDiagnostics: "'repeat' statement",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "RepeatKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "repeat"
               ]),
         Child(name: "Body",
               kind: "CodeBlock"),
         Child(name: "WhileKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "while"
               ]),
         Child(name: "Condition",
               kind: "Expr")
       ]),

  Node(name: "GuardStmt",
       nameForDiagnostics: "'guard' statement",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "GuardKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "guard"
               ]),
         Child(name: "Conditions",
               kind: "ConditionElementList",
               collectionElementName: "Condition"),
         Child(name: "ElseKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "else"
               ]),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "WhereClause",
       nameForDiagnostics: "'where' clause",
       kind: "Syntax",
       children: [
         Child(name: "WhereKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "where"
               ]),
         Child(name: "GuardResult",
               kind: "Expr")
       ]),

  Node(name: "ForInStmt",
       nameForDiagnostics: "'for' statement",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "ForKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "for"
               ]),
         Child(name: "TryKeyword",
               kind: "TryToken",
               isOptional: true),
         Child(name: "AwaitKeyword",
               kind: "IdentifierToken",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ],
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
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "in"
               ]),
         Child(name: "SequenceExpr",
               kind: "Expr"),
         Child(name: "WhereClause",
               kind: "WhereClause",
               isOptional: true),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "SwitchStmt",
       nameForDiagnostics: "'switch' statement",
       kind: "Stmt",
       traits: [
         "Braced"
       ],
       children: [
         Child(name: "SwitchKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "switch"
               ]),
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "LeftBrace",
               kind: "LeftBraceToken",
               tokenChoices: [
                 "LeftBrace"
               ]),
         Child(name: "Cases",
               kind: "SwitchCaseList",
               collectionElementName: "Case"),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               tokenChoices: [
                 "RightBrace"
               ],
               requiresLeadingNewline: true)
       ]),

  Node(name: "CatchClauseList",
       nameForDiagnostics: "'catch' clause",
       kind: "SyntaxCollection",
       element: "CatchClause"),

  Node(name: "DoStmt",
       nameForDiagnostics: "'do' statement",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "DoKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "do"
               ]),
         Child(name: "Body",
               kind: "CodeBlock"),
         Child(name: "CatchClauses",
               kind: "CatchClauseList",
               isOptional: true,
               collectionElementName: "CatchClause")
       ]),

  Node(name: "ReturnStmt",
       nameForDiagnostics: "'return' statement",
       kind: "Stmt",
       children: [
         Child(name: "ReturnKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "return"
               ]),
         Child(name: "Expression",
               kind: "Expr",
               isOptional: true)
       ]),

  Node(name: "YieldStmt",
       nameForDiagnostics: "'yield' statement",
       kind: "Stmt",
       children: [
         Child(name: "YieldKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "yield"
               ]),
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
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "ElementList",
               kind: "YieldExprList",
               collectionElementName: "Element"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "FallthroughStmt",
       nameForDiagnostics: "'fallthrough' statement",
       kind: "Stmt",
       children: [
         Child(name: "FallthroughKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "fallthrough"
               ])
       ]),

  Node(name: "BreakStmt",
       nameForDiagnostics: "'break' statement",
       kind: "Stmt",
       children: [
         Child(name: "BreakKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "break"
               ]),
         Child(name: "Label",
               kind: "IdentifierToken",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ])
       ]),

  Node(name: "CaseItemList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "CaseItem"),

  Node(name: "CatchItemList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "CatchItem"),

  Node(name: "ConditionElement",
       nameForDiagnostics: nil,
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
                 Child(name: "MatchingPattern",
                       kind: "MatchingPatternCondition"),
                 Child(name: "OptionalBinding",
                       kind: "OptionalBindingCondition"),
                 Child(name: "HasSymbol",
                       kind: "HasSymbolCondition")
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "AvailabilityCondition",
       nameForDiagnostics: "availability condition",
       kind: "Syntax",
       children: [
         Child(name: "AvailabilityKeyword",
               kind: "Token",
               tokenChoices: [
                 "PoundAvailable",
                 "PoundUnavailable"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "AvailabilitySpec",
               kind: "AvailabilitySpecList",
               collectionElementName: "AvailabilityArgument"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "MatchingPatternCondition",
       nameForDiagnostics: "pattern matching",
       kind: "Syntax",
       children: [
         Child(name: "CaseKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "case"
               ]),
         Child(name: "Pattern",
               kind: "Pattern"),
         Child(name: "TypeAnnotation",
               kind: "TypeAnnotation",
               isOptional: true),
         Child(name: "Initializer",
               kind: "InitializerClause")
       ]),

  Node(name: "OptionalBindingCondition",
       nameForDiagnostics: "optional binding",
       kind: "Syntax",
       children: [
         Child(name: "LetOrVarKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "let",
                 "var"
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

  Node(name: "HasSymbolCondition",
       nameForDiagnostics: "'#_hasSymbol' condition",
       kind: "Syntax",
       children: [
         Child(name: "HasSymbolKeyword",
               kind: "HasSymbolToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "ConditionElementList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "ConditionElement"),

  Node(name: "ThrowStmt",
       nameForDiagnostics: "'throw' statement",
       kind: "Stmt",
       children: [
         Child(name: "ThrowKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "throw"
               ]),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "IfStmt",
       nameForDiagnostics: "'if' statement",
       kind: "Stmt",
       traits: [
         "WithCodeBlock"
       ],
       children: [
         Child(name: "IfKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "if"
               ]),
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

  Node(name: "SwitchCase",
       nameForDiagnostics: "switch case",
       kind: "Syntax",
       traits: [
         "WithStatements"
       ],
       parserFunction: "parseSwitchCase",
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
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "DefaultKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "default"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ])
       ]),

  Node(name: "CaseItem",
       nameForDiagnostics: nil,
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
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "CatchItem",
       nameForDiagnostics: nil,
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
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "SwitchCaseLabel",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "CaseKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "case"
               ]),
         Child(name: "CaseItems",
               kind: "CaseItemList",
               collectionElementName: "CaseItem"),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ])
       ]),

  Node(name: "CatchClause",
       nameForDiagnostics: "'catch' clause",
       kind: "Syntax",
       traits: [
         "WithCodeBlock"
       ],
       parserFunction: "parseCatchClause",
       children: [
         Child(name: "CatchKeyword",
               kind: "KeywordToken",
               tokenChoices: [
                 "Keyword"
               ],
               textChoices: [
                 "catch"
               ]),
         Child(name: "CatchItems",
               kind: "CatchItemList",
               isOptional: true,
               collectionElementName: "CatchItem"),
         Child(name: "Body",
               kind: "CodeBlock")
       ]),

  Node(name: "PoundAssertStmt",
       nameForDiagnostics: "'#assert' directive",
       kind: "Stmt",
       children: [
         Child(name: "PoundAssert",
               kind: "PoundAssertToken",
               tokenChoices: [
                 "PoundAssert"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Condition",
               kind: "Expr",
               description: "The assertion condition."),
         Child(name: "Comma",
               kind: "CommaToken",
               description: "The comma after the assertion condition.",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "Message",
               kind: "StringLiteralExpr",
               description: "The assertion message.",
               isOptional: true),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

]
