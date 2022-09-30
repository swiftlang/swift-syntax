//// Automatically Generated From ExprNodes.swift.gyb.
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

public let EXPR_NODES: [Node] = [
  Node(name: "InOutExpr",
       nameForDiagnostics: "inout expression",
       kind: "Expr",
       children: [
         Child(name: "Ampersand",
               kind: "PrefixAmpersandToken",
               tokenChoices: [
                 "PrefixAmpersand"
               ]),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "PoundColumnExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "PoundColumn",
               kind: "PoundColumnToken",
               tokenChoices: [
                 "PoundColumn"
               ])
       ]),

  Node(name: "TupleExprElementList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "TupleExprElement"),

  Node(name: "ArrayElementList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "ArrayElement"),

  Node(name: "DictionaryElementList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "DictionaryElement"),

  Node(name: "StringLiteralSegments",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "Segment",
       elementChoices: ["StringSegment", "ExpressionSegment"]),

  Node(name: "TryExpr",
       nameForDiagnostics: "'try' expression",
       kind: "Expr",
       children: [
         Child(name: "TryKeyword",
               kind: "TryToken",
               tokenChoices: [
                 "Try"
               ]),
         Child(name: "QuestionOrExclamationMark",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "PostfixQuestionMark",
                 "ExclamationMark"
               ]),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "AwaitExpr",
       nameForDiagnostics: "'await' expression",
       kind: "Expr",
       children: [
         Child(name: "AwaitKeyword",
               kind: "ContextualKeywordToken",
               tokenChoices: [
                 "ContextualKeyword"
               ],
               textChoices: [
                 "await"
               ]),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "MoveExpr",
       nameForDiagnostics: "'_move' expression",
       kind: "Expr",
       children: [
         Child(name: "MoveKeyword",
               kind: "ContextualKeywordToken",
               tokenChoices: [
                 "ContextualKeyword"
               ],
               textChoices: [
                 "_move"
               ]),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "DeclNameArgument",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "Token"),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ])
       ]),

  Node(name: "DeclNameArgumentList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "DeclNameArgument"),

  Node(name: "DeclNameArguments",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Arguments",
               kind: "DeclNameArgumentList",
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "IdentifierExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Identifier",
               kind: "Token",
               tokenChoices: [
                 "Identifier",
                 "Self",
                 "CapitalSelf",
                 "DollarIdentifier",
                 "SpacedBinaryOperator"
               ]),
         Child(name: "DeclNameArguments",
               kind: "DeclNameArguments",
               isOptional: true)
       ]),

  Node(name: "SuperRefExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "SuperKeyword",
               kind: "SuperToken",
               tokenChoices: [
                 "Super"
               ])
       ]),

  Node(name: "NilLiteralExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "NilKeyword",
               kind: "NilToken",
               tokenChoices: [
                 "Nil"
               ])
       ]),

  Node(name: "DiscardAssignmentExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Wildcard",
               kind: "WildcardToken",
               tokenChoices: [
                 "Wildcard"
               ])
       ]),

  Node(name: "AssignmentExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "AssignToken",
               kind: "EqualToken",
               tokenChoices: [
                 "Equal"
               ])
       ]),

  Node(name: "SequenceExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Elements",
               kind: "ExprList",
               collectionElementName: "Element")
       ]),

  Node(name: "ExprList",
       nameForDiagnostics: nil,
       description: "A list of expressions connected by operators. This list is containedby a `SequenceExprSyntax`.",
       kind: "SyntaxCollection",
       element: "Expr",
       elementName: "Expression"),

  Node(name: "PoundLineExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "PoundLine",
               kind: "PoundLineToken",
               tokenChoices: [
                 "PoundLine"
               ])
       ]),

  Node(name: "PoundFileExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "PoundFile",
               kind: "PoundFileToken",
               tokenChoices: [
                 "PoundFile"
               ])
       ]),

  Node(name: "PoundFileIDExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "PoundFileID",
               kind: "PoundFileIDToken",
               tokenChoices: [
                 "PoundFileID"
               ])
       ]),

  Node(name: "PoundFilePathExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "PoundFilePath",
               kind: "PoundFilePathToken",
               tokenChoices: [
                 "PoundFilePath"
               ])
       ]),

  Node(name: "PoundFunctionExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "PoundFunction",
               kind: "PoundFunctionToken",
               tokenChoices: [
                 "PoundFunction"
               ])
       ]),

  Node(name: "PoundDsohandleExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "PoundDsohandle",
               kind: "PoundDsohandleToken",
               tokenChoices: [
                 "PoundDsohandle"
               ])
       ]),

  Node(name: "SymbolicReferenceExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Identifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "GenericArgumentClause",
               kind: "GenericArgumentClause",
               isOptional: true)
       ]),

  Node(name: "PrefixOperatorExpr",
       nameForDiagnostics: "prefix operator expression",
       kind: "Expr",
       children: [
         Child(name: "OperatorToken",
               kind: "PrefixOperatorToken",
               isOptional: true,
               tokenChoices: [
                 "PrefixOperator"
               ]),
         Child(name: "PostfixExpression",
               kind: "Expr")
       ]),

  Node(name: "BinaryOperatorExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "OperatorToken",
               kind: "BinaryOperatorToken")
       ]),

  Node(name: "ArrowExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "AsyncKeyword",
               kind: "ContextualKeywordToken",
               isOptional: true,
               tokenChoices: [
                 "ContextualKeyword"
               ],
               textChoices: [
                 "async"
               ]),
         Child(name: "ThrowsToken",
               kind: "ThrowsToken",
               isOptional: true,
               tokenChoices: [
                 "Throws"
               ]),
         Child(name: "ArrowToken",
               kind: "ArrowToken",
               tokenChoices: [
                 "Arrow"
               ])
       ]),

  Node(name: "InfixOperatorExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "LeftOperand",
               kind: "Expr"),
         Child(name: "OperatorOperand",
               kind: "Expr"),
         Child(name: "RightOperand",
               kind: "Expr")
       ]),

  Node(name: "FloatLiteralExpr",
       nameForDiagnostics: "floating literal",
       kind: "Expr",
       children: [
         Child(name: "FloatingDigits",
               kind: "FloatingLiteralToken",
               tokenChoices: [
                 "FloatingLiteral"
               ])
       ]),

  Node(name: "TupleExpr",
       nameForDiagnostics: "tuple",
       kind: "Expr",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "ElementList",
               kind: "TupleExprElementList",
               collectionElementName: "Element"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "ArrayExpr",
       nameForDiagnostics: "array",
       kind: "Expr",
       children: [
         Child(name: "LeftSquare",
               kind: "LeftSquareBracketToken",
               tokenChoices: [
                 "LeftSquareBracket"
               ]),
         Child(name: "Elements",
               kind: "ArrayElementList",
               collectionElementName: "Element"),
         Child(name: "RightSquare",
               kind: "RightSquareBracketToken",
               tokenChoices: [
                 "RightSquareBracket"
               ])
       ]),

  Node(name: "DictionaryExpr",
       nameForDiagnostics: "dictionary",
       kind: "Expr",
       children: [
         Child(name: "LeftSquare",
               kind: "LeftSquareBracketToken",
               tokenChoices: [
                 "LeftSquareBracket"
               ]),
         Child(name: "Content",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "Colon",
                       kind: "ColonToken",
                       tokenChoices: [
                         "Colon"
                       ]),
                 Child(name: "Elements",
                       kind: "DictionaryElementList")
               ]),
         Child(name: "RightSquare",
               kind: "RightSquareBracketToken",
               tokenChoices: [
                 "RightSquareBracket"
               ])
       ]),

  Node(name: "TupleExprElement",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Label",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Identifier",
                 "Wildcard"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true,
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "ArrayElement",
       nameForDiagnostics: "array element",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "DictionaryElement",
       nameForDiagnostics: "dictionary element",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "KeyExpression",
               kind: "Expr"),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "ValueExpression",
               kind: "Expr"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "IntegerLiteralExpr",
       nameForDiagnostics: "integer literal",
       kind: "Expr",
       children: [
         Child(name: "Digits",
               kind: "IntegerLiteralToken",
               tokenChoices: [
                 "IntegerLiteral"
               ])
       ]),

  Node(name: "BooleanLiteralExpr",
       nameForDiagnostics: "bool literal",
       kind: "Expr",
       children: [
         Child(name: "BooleanLiteral",
               kind: "Token",
               tokenChoices: [
                 "True",
                 "False"
               ])
       ]),

  Node(name: "UnresolvedTernaryExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "QuestionMark",
               kind: "InfixQuestionMarkToken",
               tokenChoices: [
                 "InfixQuestionMark"
               ]),
         Child(name: "FirstChoice",
               kind: "Expr"),
         Child(name: "ColonMark",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ])
       ]),

  Node(name: "TernaryExpr",
       nameForDiagnostics: "ternay expression",
       kind: "Expr",
       children: [
         Child(name: "ConditionExpression",
               kind: "Expr"),
         Child(name: "QuestionMark",
               kind: "InfixQuestionMarkToken",
               tokenChoices: [
                 "InfixQuestionMark"
               ]),
         Child(name: "FirstChoice",
               kind: "Expr"),
         Child(name: "ColonMark",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "SecondChoice",
               kind: "Expr")
       ]),

  Node(name: "MemberAccessExpr",
       nameForDiagnostics: "member access",
       kind: "Expr",
       children: [
         Child(name: "Base",
               kind: "Expr",
               isOptional: true),
         Child(name: "Dot",
               kind: "Token",
               tokenChoices: [
                 "Period",
                 "PrefixPeriod"
               ]),
         Child(name: "Name",
               kind: "Token"),
         Child(name: "DeclNameArguments",
               kind: "DeclNameArguments",
               isOptional: true)
       ]),

  Node(name: "UnresolvedIsExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "IsTok",
               kind: "IsToken",
               tokenChoices: [
                 "Is"
               ])
       ]),

  Node(name: "IsExpr",
       nameForDiagnostics: "'is' expression",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "IsTok",
               kind: "IsToken",
               tokenChoices: [
                 "Is"
               ]),
         Child(name: "TypeName",
               kind: "Type")
       ]),

  Node(name: "UnresolvedAsExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "AsTok",
               kind: "AsToken",
               tokenChoices: [
                 "As"
               ]),
         Child(name: "QuestionOrExclamationMark",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "PostfixQuestionMark",
                 "ExclamationMark"
               ])
       ]),

  Node(name: "AsExpr",
       nameForDiagnostics: "'as' expression",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "AsTok",
               kind: "AsToken",
               tokenChoices: [
                 "As"
               ]),
         Child(name: "QuestionOrExclamationMark",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "PostfixQuestionMark",
                 "ExclamationMark"
               ]),
         Child(name: "TypeName",
               kind: "Type")
       ]),

  Node(name: "TypeExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Type",
               kind: "Type")
       ]),

  Node(name: "ClosureCaptureItem",
       nameForDiagnostics: "closure capture item",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Specifier",
               kind: "TokenList",
               isOptional: true,
               collectionElementName: "SpecifierToken"),
         Child(name: "Name",
               kind: "IdentifierToken",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "AssignToken",
               kind: "EqualToken",
               isOptional: true,
               tokenChoices: [
                 "Equal"
               ]),
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "ClosureCaptureItemList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "ClosureCaptureItem"),

  Node(name: "ClosureCaptureSignature",
       nameForDiagnostics: "closure capture signature",
       kind: "Syntax",
       children: [
         Child(name: "LeftSquare",
               kind: "LeftSquareBracketToken",
               tokenChoices: [
                 "LeftSquareBracket"
               ]),
         Child(name: "Items",
               kind: "ClosureCaptureItemList",
               isOptional: true,
               collectionElementName: "Item"),
         Child(name: "RightSquare",
               kind: "RightSquareBracketToken",
               tokenChoices: [
                 "RightSquareBracket"
               ])
       ]),

  Node(name: "ClosureParam",
       nameForDiagnostics: "closure parameter",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Name",
               kind: "Token",
               tokenChoices: [
                 "Identifier",
                 "Wildcard"
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "ClosureParamList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "ClosureParam"),

  Node(name: "ClosureSignature",
       nameForDiagnostics: "closure signature",
       kind: "Syntax",
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Capture",
               kind: "ClosureCaptureSignature",
               isOptional: true),
         Child(name: "Input",
               kind: "Syntax",
               isOptional: true,
               nodeChoices: [
                 Child(name: "SimpleInput",
                       kind: "ClosureParamList"),
                 Child(name: "Input",
                       kind: "ParameterClause")
               ]),
         Child(name: "AsyncKeyword",
               kind: "ContextualKeywordToken",
               isOptional: true,
               tokenChoices: [
                 "ContextualKeyword"
               ],
               textChoices: [
                 "async"
               ]),
         Child(name: "ThrowsTok",
               kind: "ThrowsToken",
               isOptional: true,
               tokenChoices: [
                 "Throws"
               ]),
         Child(name: "Output",
               kind: "ReturnClause",
               isOptional: true),
         Child(name: "InTok",
               kind: "InToken",
               tokenChoices: [
                 "In"
               ])
       ]),

  Node(name: "ClosureExpr",
       nameForDiagnostics: "closure",
       kind: "Expr",
       traits: [
         "Braced",
         "WithStatements"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: "LeftBraceToken",
               tokenChoices: [
                 "LeftBrace"
               ]),
         Child(name: "Signature",
               kind: "ClosureSignature",
               isOptional: true),
         Child(name: "Statements",
               kind: "CodeBlockItemList",
               collectionElementName: "Statement",
               isIndented: true),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               tokenChoices: [
                 "RightBrace"
               ],
               requiresLeadingNewline: true)
       ]),

  Node(name: "UnresolvedPatternExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Pattern",
               kind: "Pattern")
       ]),

  Node(name: "MultipleTrailingClosureElement",
       nameForDiagnostics: "trailing closure",
       kind: "Syntax",
       children: [
         Child(name: "Label",
               kind: "Token",
               tokenChoices: [
                 "Identifier",
                 "Wildcard"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Closure",
               kind: "ClosureExpr")
       ]),

  Node(name: "MultipleTrailingClosureElementList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "MultipleTrailingClosureElement"),

  Node(name: "FunctionCallExpr",
       nameForDiagnostics: "function call",
       kind: "Expr",
       children: [
         Child(name: "CalledExpression",
               kind: "Expr"),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               isOptional: true,
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "ArgumentList",
               kind: "TupleExprElementList",
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               isOptional: true,
               tokenChoices: [
                 "RightParen"
               ]),
         Child(name: "TrailingClosure",
               kind: "ClosureExpr",
               isOptional: true),
         Child(name: "AdditionalTrailingClosures",
               kind: "MultipleTrailingClosureElementList",
               isOptional: true,
               collectionElementName: "AdditionalTrailingClosure")
       ]),

  Node(name: "SubscriptExpr",
       nameForDiagnostics: "subscript",
       kind: "Expr",
       children: [
         Child(name: "CalledExpression",
               kind: "Expr"),
         Child(name: "LeftBracket",
               kind: "LeftSquareBracketToken",
               tokenChoices: [
                 "LeftSquareBracket"
               ]),
         Child(name: "ArgumentList",
               kind: "TupleExprElementList",
               collectionElementName: "Argument"),
         Child(name: "RightBracket",
               kind: "RightSquareBracketToken",
               tokenChoices: [
                 "RightSquareBracket"
               ]),
         Child(name: "TrailingClosure",
               kind: "ClosureExpr",
               isOptional: true),
         Child(name: "AdditionalTrailingClosures",
               kind: "MultipleTrailingClosureElementList",
               isOptional: true,
               collectionElementName: "AdditionalTrailingClosure")
       ]),

  Node(name: "OptionalChainingExpr",
       nameForDiagnostics: "optional chaining",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "QuestionMark",
               kind: "PostfixQuestionMarkToken",
               tokenChoices: [
                 "PostfixQuestionMark"
               ])
       ]),

  Node(name: "ForcedValueExpr",
       nameForDiagnostics: "force unwrap",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "ExclamationMark",
               kind: "ExclamationMarkToken",
               tokenChoices: [
                 "ExclamationMark"
               ])
       ]),

  Node(name: "PostfixUnaryExpr",
       nameForDiagnostics: "postfix expression",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "OperatorToken",
               kind: "PostfixOperatorToken",
               tokenChoices: [
                 "PostfixOperator"
               ])
       ]),

  Node(name: "SpecializeExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "GenericArgumentClause",
               kind: "GenericArgumentClause")
       ]),

  Node(name: "StringSegment",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Content",
               kind: "StringSegmentToken",
               tokenChoices: [
                 "StringSegment"
               ])
       ]),

  Node(name: "ExpressionSegment",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "Backslash",
               kind: "BackslashToken",
               tokenChoices: [
                 "Backslash"
               ]),
         Child(name: "Delimiter",
               kind: "RawStringDelimiterToken",
               isOptional: true,
               tokenChoices: [
                 "RawStringDelimiter"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ],
               classification: "StringInterpolationAnchor",
               forceClassification: true),
         Child(name: "Expressions",
               kind: "TupleExprElementList",
               collectionElementName: "Expression"),
         Child(name: "RightParen",
               kind: "StringInterpolationAnchorToken",
               tokenChoices: [
                 "StringInterpolationAnchor"
               ],
               classification: "StringInterpolationAnchor",
               forceClassification: true)
       ]),

  Node(name: "StringLiteralExpr",
       nameForDiagnostics: "string literal",
       kind: "Expr",
       children: [
         Child(name: "OpenDelimiter",
               kind: "RawStringDelimiterToken",
               isOptional: true,
               tokenChoices: [
                 "RawStringDelimiter"
               ]),
         Child(name: "OpenQuote",
               kind: "Token",
               tokenChoices: [
                 "StringQuote",
                 "MultilineStringQuote"
               ]),
         Child(name: "Segments",
               kind: "StringLiteralSegments",
               collectionElementName: "Segment"),
         Child(name: "CloseQuote",
               kind: "Token",
               tokenChoices: [
                 "StringQuote",
                 "MultilineStringQuote"
               ]),
         Child(name: "CloseDelimiter",
               kind: "RawStringDelimiterToken",
               isOptional: true,
               tokenChoices: [
                 "RawStringDelimiter"
               ])
       ]),

  Node(name: "RegexLiteralExpr",
       nameForDiagnostics: "regex literal",
       kind: "Expr",
       children: [
         Child(name: "Regex",
               kind: "RegexLiteralToken",
               tokenChoices: [
                 "RegexLiteral"
               ])
       ]),

  Node(name: "KeyPathExpr",
       nameForDiagnostics: "key path",
       kind: "Expr",
       children: [
         Child(name: "Backslash",
               kind: "BackslashToken",
               tokenChoices: [
                 "Backslash"
               ]),
         Child(name: "Root",
               kind: "Type",
               isOptional: true),
         Child(name: "Components",
               kind: "KeyPathComponentList",
               collectionElementName: "KeyPathComponent")
       ]),

  Node(name: "KeyPathComponentList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "KeyPathComponent"),

  Node(name: "KeyPathComponent",
       nameForDiagnostics: "key path component",
       kind: "Syntax",
       children: [
         Child(name: "Period",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Period",
                 "PrefixPeriod"
               ]),
         Child(name: "Component",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "Property",
                       kind: "KeyPathPropertyComponent"),
                 Child(name: "Subscript",
                       kind: "KeyPathSubscriptComponent"),
                 Child(name: "Optional",
                       kind: "KeyPathOptionalComponent")
               ])
       ]),

  Node(name: "KeyPathPropertyComponent",
       nameForDiagnostics: "key path property component",
       kind: "Syntax",
       children: [
         Child(name: "Identifier",
               kind: "Token",
               tokenChoices: [
                 "Identifier",
                 "Self",
                 "CapitalSelf",
                 "DollarIdentifier",
                 "SpacedBinaryOperator",
                 "IntegerLiteral"
               ]),
         Child(name: "DeclNameArguments",
               kind: "DeclNameArguments",
               isOptional: true),
         Child(name: "GenericArgumentClause",
               kind: "GenericArgumentClause",
               isOptional: true)
       ]),

  Node(name: "KeyPathSubscriptComponent",
       nameForDiagnostics: "key path subscript component",
       kind: "Syntax",
       children: [
         Child(name: "LeftBracket",
               kind: "LeftSquareBracketToken",
               tokenChoices: [
                 "LeftSquareBracket"
               ]),
         Child(name: "ArgumentList",
               kind: "TupleExprElementList",
               collectionElementName: "Argument"),
         Child(name: "RightBracket",
               kind: "RightSquareBracketToken",
               tokenChoices: [
                 "RightSquareBracket"
               ])
       ]),

  Node(name: "KeyPathOptionalComponent",
       nameForDiagnostics: "key path optional component",
       kind: "Syntax",
       children: [
         Child(name: "QuestionOrExclamationMark",
               kind: "Token",
               tokenChoices: [
                 "PostfixQuestionMark",
                 "ExclamationMark"
               ])
       ]),

  Node(name: "OldKeyPathExpr",
       nameForDiagnostics: "key path",
       kind: "Expr",
       children: [
         Child(name: "Backslash",
               kind: "BackslashToken",
               tokenChoices: [
                 "Backslash"
               ]),
         Child(name: "RootExpr",
               kind: "Expr",
               isOptional: true,
               nodeChoices: [
                 Child(name: "IdentifierExpr",
                       kind: "IdentifierExpr"),
                 Child(name: "SpecializeExpr",
                       kind: "SpecializeExpr"),
                 Child(name: "OptionalChainingExpr",
                       kind: "OptionalChainingExpr")
               ]),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "KeyPathBaseExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Period",
               kind: "PeriodToken",
               tokenChoices: [
                 "Period"
               ])
       ]),

  Node(name: "ObjcNamePiece",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Dot",
               kind: "PeriodToken",
               isOptional: true,
               tokenChoices: [
                 "Period"
               ])
       ]),

  Node(name: "ObjcName",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "ObjcNamePiece"),

  Node(name: "ObjcKeyPathExpr",
       nameForDiagnostics: "'#keyPath' expression",
       kind: "Expr",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "KeyPath",
               kind: "PoundKeyPathToken",
               tokenChoices: [
                 "PoundKeyPath"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Name",
               kind: "ObjcName",
               collectionElementName: "NamePiece"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "ObjcSelectorExpr",
       nameForDiagnostics: "'#selector' expression",
       kind: "Expr",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundSelector",
               kind: "PoundSelectorToken",
               tokenChoices: [
                 "PoundSelector"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Kind",
               kind: "ContextualKeywordToken",
               isOptional: true,
               tokenChoices: [
                 "ContextualKeyword"
               ],
               textChoices: [
                 "getter",
                 "setter"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true,
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Name",
               kind: "Expr"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "PostfixIfConfigExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Base",
               kind: "Expr",
               isOptional: true),
         Child(name: "Config",
               kind: "IfConfigDecl")
       ]),

  Node(name: "EditorPlaceholderExpr",
       nameForDiagnostics: "editor placeholder",
       kind: "Expr",
       children: [
         Child(name: "Identifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ])
       ]),

  Node(name: "ObjectLiteralExpr",
       nameForDiagnostics: "object literal",
       kind: "Expr",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "Identifier",
               kind: "Token",
               tokenChoices: [
                 "PoundColorLiteral",
                 "PoundFileLiteral",
                 "PoundImageLiteral"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Arguments",
               kind: "TupleExprElementList",
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "YieldExprList",
       nameForDiagnostics: "yield list",
       kind: "SyntaxCollection",
       element: "YieldExprListElement",
       elementName: "Yields"),

  Node(name: "YieldExprListElement",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "Comma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

]
