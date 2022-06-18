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

let EXPR_NODES: [Node] = [
  Node(name: "InOutExpr",
       kind: "Expr",
       children: [
         Child(name: "Ampersand",
               kind: "PrefixAmpersandToken"),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "PoundColumnExpr",
       kind: "Expr",
       children: [
         Child(name: "PoundColumn",
               kind: "PoundColumnToken")
       ]),

  Node(name: "TupleExprElementList",
       kind: "SyntaxCollection",
       element: "TupleExprElement"),

  Node(name: "ArrayElementList",
       kind: "SyntaxCollection",
       element: "ArrayElement"),

  Node(name: "DictionaryElementList",
       kind: "SyntaxCollection",
       element: "DictionaryElement"),

  Node(name: "StringLiteralSegments",
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "Segment",
       elementChoices: ["StringSegment", "ExpressionSegment"]),

  Node(name: "TryExpr",
       kind: "Expr",
       children: [
         Child(name: "TryKeyword",
               kind: "TryToken"),
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
       kind: "Expr",
       children: [
         Child(name: "AwaitKeyword",
               kind: "IdentifierToken",
               textChoices: [
                 "await"
               ],
               classification: "Keyword"),
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "DeclNameArgument",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "Token"),
         Child(name: "Colon",
               kind: "ColonToken")
       ]),

  Node(name: "DeclNameArgumentList",
       kind: "SyntaxCollection",
       element: "DeclNameArgument"),

  Node(name: "DeclNameArguments",
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Arguments",
               kind: "DeclNameArgumentList",
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "IdentifierExpr",
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
       kind: "Expr",
       children: [
         Child(name: "SuperKeyword",
               kind: "SuperToken")
       ]),

  Node(name: "NilLiteralExpr",
       kind: "Expr",
       children: [
         Child(name: "NilKeyword",
               kind: "NilToken")
       ]),

  Node(name: "DiscardAssignmentExpr",
       kind: "Expr",
       children: [
         Child(name: "Wildcard",
               kind: "WildcardToken")
       ]),

  Node(name: "AssignmentExpr",
       kind: "Expr",
       children: [
         Child(name: "AssignToken",
               kind: "EqualToken")
       ]),

  Node(name: "SequenceExpr",
       kind: "Expr",
       children: [
         Child(name: "Elements",
               kind: "ExprList",
               collectionElementName: "Element")
       ]),

  Node(name: "ExprList",
       description: "A list of expressions connected by operators. This list is containedby a `SequenceExprSyntax`.",
       kind: "SyntaxCollection",
       element: "Expr",
       elementName: "Expression"),

  Node(name: "PoundLineExpr",
       kind: "Expr",
       children: [
         Child(name: "PoundLine",
               kind: "PoundLineToken")
       ]),

  Node(name: "PoundFileExpr",
       kind: "Expr",
       children: [
         Child(name: "PoundFile",
               kind: "PoundFileToken")
       ]),

  Node(name: "PoundFileIDExpr",
       kind: "Expr",
       children: [
         Child(name: "PoundFileID",
               kind: "PoundFileIDToken")
       ]),

  Node(name: "PoundFilePathExpr",
       kind: "Expr",
       children: [
         Child(name: "PoundFilePath",
               kind: "PoundFilePathToken")
       ]),

  Node(name: "PoundFunctionExpr",
       kind: "Expr",
       children: [
         Child(name: "PoundFunction",
               kind: "PoundFunctionToken")
       ]),

  Node(name: "PoundDsohandleExpr",
       kind: "Expr",
       children: [
         Child(name: "PoundDsohandle",
               kind: "PoundDsohandleToken")
       ]),

  Node(name: "SymbolicReferenceExpr",
       kind: "Expr",
       children: [
         Child(name: "Identifier",
               kind: "IdentifierToken"),
         Child(name: "GenericArgumentClause",
               kind: "GenericArgumentClause",
               isOptional: true)
       ]),

  Node(name: "PrefixOperatorExpr",
       kind: "Expr",
       children: [
         Child(name: "OperatorToken",
               kind: "PrefixOperatorToken",
               isOptional: true),
         Child(name: "PostfixExpression",
               kind: "Expr")
       ]),

  Node(name: "BinaryOperatorExpr",
       kind: "Expr",
       children: [
         Child(name: "OperatorToken",
               kind: "BinaryOperatorToken")
       ]),

  Node(name: "ArrowExpr",
       kind: "Expr",
       children: [
         Child(name: "AsyncKeyword",
               kind: "ContextualKeywordToken",
               isOptional: true,
               textChoices: [
                 "async"
               ]),
         Child(name: "ThrowsToken",
               kind: "ThrowsToken",
               isOptional: true),
         Child(name: "ArrowToken",
               kind: "ArrowToken")
       ]),

  Node(name: "FloatLiteralExpr",
       kind: "Expr",
       children: [
         Child(name: "FloatingDigits",
               kind: "FloatingLiteralToken")
       ]),

  Node(name: "TupleExpr",
       kind: "Expr",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "ElementList",
               kind: "TupleExprElementList",
               collectionElementName: "Element"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "ArrayExpr",
       kind: "Expr",
       children: [
         Child(name: "LeftSquare",
               kind: "LeftSquareBracketToken"),
         Child(name: "Elements",
               kind: "ArrayElementList",
               collectionElementName: "Element"),
         Child(name: "RightSquare",
               kind: "RightSquareBracketToken")
       ]),

  Node(name: "DictionaryExpr",
       kind: "Expr",
       children: [
         Child(name: "LeftSquare",
               kind: "LeftSquareBracketToken"),
         Child(name: "Content",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "Colon",
                       kind: "ColonToken"),
                 Child(name: "Elements",
                       kind: "DictionaryElementList")
               ]),
         Child(name: "RightSquare",
               kind: "RightSquareBracketToken")
       ]),

  Node(name: "TupleExprElement",
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
               isOptional: true),
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "ArrayElement",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "DictionaryElement",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "KeyExpression",
               kind: "Expr"),
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "ValueExpression",
               kind: "Expr"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "IntegerLiteralExpr",
       kind: "Expr",
       children: [
         Child(name: "Digits",
               kind: "IntegerLiteralToken")
       ]),

  Node(name: "BooleanLiteralExpr",
       kind: "Expr",
       children: [
         Child(name: "BooleanLiteral",
               kind: "Token",
               tokenChoices: [
                 "True",
                 "False"
               ])
       ]),

  Node(name: "TernaryExpr",
       kind: "Expr",
       children: [
         Child(name: "ConditionExpression",
               kind: "Expr"),
         Child(name: "QuestionMark",
               kind: "InfixQuestionMarkToken"),
         Child(name: "FirstChoice",
               kind: "Expr"),
         Child(name: "ColonMark",
               kind: "ColonToken"),
         Child(name: "SecondChoice",
               kind: "Expr")
       ]),

  Node(name: "MemberAccessExpr",
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

  Node(name: "IsExpr",
       kind: "Expr",
       children: [
         Child(name: "IsTok",
               kind: "IsToken"),
         Child(name: "TypeName",
               kind: "Type")
       ]),

  Node(name: "AsExpr",
       kind: "Expr",
       children: [
         Child(name: "AsTok",
               kind: "AsToken"),
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
       kind: "Expr",
       children: [
         Child(name: "Type",
               kind: "Type")
       ]),

  Node(name: "ClosureCaptureItem",
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
               isOptional: true),
         Child(name: "AssignToken",
               kind: "EqualToken",
               isOptional: true),
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "ClosureCaptureItemList",
       kind: "SyntaxCollection",
       element: "ClosureCaptureItem"),

  Node(name: "ClosureCaptureSignature",
       kind: "Syntax",
       children: [
         Child(name: "LeftSquare",
               kind: "LeftSquareBracketToken"),
         Child(name: "Items",
               kind: "ClosureCaptureItemList",
               isOptional: true,
               collectionElementName: "Item"),
         Child(name: "RightSquare",
               kind: "RightSquareBracketToken")
       ]),

  Node(name: "ClosureParam",
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
               isOptional: true)
       ]),

  Node(name: "ClosureParamList",
       kind: "SyntaxCollection",
       element: "ClosureParam"),

  Node(name: "ClosureSignature",
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
               textChoices: [
                 "async"
               ]),
         Child(name: "ThrowsTok",
               kind: "ThrowsToken",
               isOptional: true),
         Child(name: "Output",
               kind: "ReturnClause",
               isOptional: true),
         Child(name: "InTok",
               kind: "InToken")
       ]),

  Node(name: "ClosureExpr",
       kind: "Expr",
       traits: [
         "Braced",
         "WithStatements"
       ],
       children: [
         Child(name: "LeftBrace",
               kind: "LeftBraceToken"),
         Child(name: "Signature",
               kind: "ClosureSignature",
               isOptional: true),
         Child(name: "Statements",
               kind: "CodeBlockItemList",
               collectionElementName: "Statement",
               isIndented: true),
         Child(name: "RightBrace",
               kind: "RightBraceToken",
               requiresLeadingNewline: true)
       ]),

  Node(name: "UnresolvedPatternExpr",
       kind: "Expr",
       children: [
         Child(name: "Pattern",
               kind: "Pattern")
       ]),

  Node(name: "MultipleTrailingClosureElement",
       kind: "Syntax",
       children: [
         Child(name: "Label",
               kind: "Token",
               tokenChoices: [
                 "Identifier",
                 "Wildcard"
               ]),
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "Closure",
               kind: "ClosureExpr")
       ]),

  Node(name: "MultipleTrailingClosureElementList",
       kind: "SyntaxCollection",
       element: "MultipleTrailingClosureElement"),

  Node(name: "FunctionCallExpr",
       kind: "Expr",
       children: [
         Child(name: "CalledExpression",
               kind: "Expr"),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               isOptional: true),
         Child(name: "ArgumentList",
               kind: "TupleExprElementList",
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               isOptional: true),
         Child(name: "TrailingClosure",
               kind: "ClosureExpr",
               isOptional: true),
         Child(name: "AdditionalTrailingClosures",
               kind: "MultipleTrailingClosureElementList",
               isOptional: true,
               collectionElementName: "AdditionalTrailingClosure")
       ]),

  Node(name: "SubscriptExpr",
       kind: "Expr",
       children: [
         Child(name: "CalledExpression",
               kind: "Expr"),
         Child(name: "LeftBracket",
               kind: "LeftSquareBracketToken"),
         Child(name: "ArgumentList",
               kind: "TupleExprElementList",
               collectionElementName: "Argument"),
         Child(name: "RightBracket",
               kind: "RightSquareBracketToken"),
         Child(name: "TrailingClosure",
               kind: "ClosureExpr",
               isOptional: true),
         Child(name: "AdditionalTrailingClosures",
               kind: "MultipleTrailingClosureElementList",
               isOptional: true,
               collectionElementName: "AdditionalTrailingClosure")
       ]),

  Node(name: "OptionalChainingExpr",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "QuestionMark",
               kind: "PostfixQuestionMarkToken")
       ]),

  Node(name: "ForcedValueExpr",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "ExclamationMark",
               kind: "ExclamationMarkToken")
       ]),

  Node(name: "PostfixUnaryExpr",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "OperatorToken",
               kind: "PostfixOperatorToken")
       ]),

  Node(name: "SpecializeExpr",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: "Expr"),
         Child(name: "GenericArgumentClause",
               kind: "GenericArgumentClause")
       ]),

  Node(name: "StringSegment",
       kind: "Syntax",
       children: [
         Child(name: "Content",
               kind: "StringSegmentToken")
       ]),

  Node(name: "ExpressionSegment",
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "Backslash",
               kind: "BackslashToken"),
         Child(name: "Delimiter",
               kind: "RawStringDelimiterToken",
               isOptional: true),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               classification: "StringInterpolationAnchor",
               forceClassification: true),
         Child(name: "Expressions",
               kind: "TupleExprElementList",
               collectionElementName: "Expression"),
         Child(name: "RightParen",
               kind: "StringInterpolationAnchorToken")
       ]),

  Node(name: "StringLiteralExpr",
       kind: "Expr",
       children: [
         Child(name: "OpenDelimiter",
               kind: "RawStringDelimiterToken",
               isOptional: true),
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
               isOptional: true)
       ]),

  Node(name: "RegexLiteralExpr",
       kind: "Expr",
       children: [
         Child(name: "Regex",
               kind: "RegexLiteralToken")
       ]),

  Node(name: "KeyPathExpr",
       kind: "Expr",
       children: [
         Child(name: "Backslash",
               kind: "BackslashToken"),
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
       kind: "Expr",
       children: [
         Child(name: "Period",
               kind: "PeriodToken")
       ]),

  Node(name: "ObjcNamePiece",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken"),
         Child(name: "Dot",
               kind: "PeriodToken",
               isOptional: true)
       ]),

  Node(name: "ObjcName",
       kind: "SyntaxCollection",
       element: "ObjcNamePiece"),

  Node(name: "ObjcKeyPathExpr",
       kind: "Expr",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "KeyPath",
               kind: "PoundKeyPathToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Name",
               kind: "ObjcName",
               collectionElementName: "NamePiece"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "ObjcSelectorExpr",
       kind: "Expr",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "PoundSelector",
               kind: "PoundSelectorToken"),
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Kind",
               kind: "ContextualKeywordToken",
               isOptional: true,
               textChoices: [
                 "getter",
                 "setter"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "Name",
               kind: "Expr"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

  Node(name: "PostfixIfConfigExpr",
       kind: "Expr",
       children: [
         Child(name: "Base",
               kind: "Expr",
               isOptional: true),
         Child(name: "Config",
               kind: "IfConfigDecl")
       ]),

  Node(name: "EditorPlaceholderExpr",
       kind: "Expr",
       children: [
         Child(name: "Identifier",
               kind: "IdentifierToken")
       ]),

  Node(name: "ObjectLiteralExpr",
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
               kind: "LeftParenToken"),
         Child(name: "Arguments",
               kind: "TupleExprElementList",
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),

]
