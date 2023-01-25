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
               kind: .token(choices: [.token(tokenKind: "PrefixAmpersandToken")])),
         Child(name: "Expression",
               kind: .node(kind: "Expr"))
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
               kind: .token(choices: [.keyword(text: "try")])),
         Child(name: "QuestionOrExclamationMark",
               kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")]),
               isOptional: true),
         Child(name: "Expression",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "AwaitExpr",
       nameForDiagnostics: "'await' expression",
       kind: "Expr",
       children: [
         Child(name: "AwaitKeyword",
               kind: .token(choices: [.keyword(text: "await")])),
         Child(name: "Expression",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "MoveExpr",
       nameForDiagnostics: "'_move' expression",
       kind: "Expr",
       children: [
         Child(name: "MoveKeyword",
               kind: .token(choices: [.keyword(text: "_move")])),
         Child(name: "Expression",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "BorrowExpr",
       nameForDiagnostics: "'_borrow' expression",
       kind: "Expr",
       children: [
         Child(name: "BorrowKeyword",
               kind: .token(choices: [.keyword(text: "_borrow")])),
         Child(name: "Expression",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "DeclNameArgument",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: .node(kind: "Token")),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")]))
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
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")])),
         Child(name: "Arguments",
               kind: .collection(kind: "DeclNameArgumentList", collectionElementName: "Argument")),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]))
       ]),

  Node(name: "IdentifierExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "KeywordToken"), .token(tokenKind: "DollarIdentifierToken"), .token(tokenKind: "BinaryOperatorToken")])),
         Child(name: "DeclNameArguments",
               kind: .node(kind: "DeclNameArguments"),
               isOptional: true)
       ]),

  Node(name: "SuperRefExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "SuperKeyword",
               kind: .token(choices: [.keyword(text: "super")]))
       ]),

  Node(name: "NilLiteralExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "NilKeyword",
               kind: .token(choices: [.keyword(text: "nil")]))
       ]),

  Node(name: "DiscardAssignmentExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Wildcard",
               kind: .token(choices: [.token(tokenKind: "WildcardToken")]))
       ]),

  Node(name: "AssignmentExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "AssignToken",
               kind: .token(choices: [.token(tokenKind: "EqualToken")]))
       ]),

  Node(name: "PackExpansionExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "RepeatKeyword",
               kind: .token(choices: [.keyword(text: "repeat")])),
         Child(name: "PatternExpr",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "PackElementExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "EachKeyword",
               kind: .token(choices: [.keyword(text: "each")])),
         Child(name: "PackRefExpr",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "SequenceExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Elements",
               kind: .collection(kind: "ExprList", collectionElementName: "Element"))
       ]),

  Node(name: "ExprList",
       nameForDiagnostics: nil,
       description: "A list of expressions connected by operators. This list is contained by a `SequenceExprSyntax`.",
       kind: "SyntaxCollection",
       element: "Expr",
       elementName: "Expression"),

  Node(name: "PrefixOperatorExpr",
       nameForDiagnostics: "prefix operator expression",
       kind: "Expr",
       children: [
         Child(name: "OperatorToken",
               kind: .token(choices: [.token(tokenKind: "PrefixOperatorToken")]),
               isOptional: true),
         Child(name: "PostfixExpression",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "BinaryOperatorExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "OperatorToken",
               kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken")]))
       ]),

  Node(name: "ArrowExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "EffectSpecifiers",
               kind: .node(kind: "TypeEffectSpecifiers"),
               isOptional: true),
         Child(name: "ArrowToken",
               kind: .token(choices: [.token(tokenKind: "ArrowToken")]))
       ]),

  Node(name: "InfixOperatorExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "LeftOperand",
               kind: .node(kind: "Expr")),
         Child(name: "OperatorOperand",
               kind: .node(kind: "Expr")),
         Child(name: "RightOperand",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "FloatLiteralExpr",
       nameForDiagnostics: "floating literal",
       kind: "Expr",
       children: [
         Child(name: "FloatingDigits",
               kind: .token(choices: [.token(tokenKind: "FloatingLiteralToken")]))
       ]),

  Node(name: "TupleExpr",
       nameForDiagnostics: "tuple",
       kind: "Expr",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")])),
         Child(name: "ElementList",
               kind: .collection(kind: "TupleExprElementList", collectionElementName: "Element"),
               isIndented: true),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]))
       ]),

  Node(name: "ArrayExpr",
       nameForDiagnostics: "array",
       kind: "Expr",
       children: [
         Child(name: "LeftSquare",
               kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])),
         Child(name: "Elements",
               kind: .collection(kind: "ArrayElementList", collectionElementName: "Element"),
               isIndented: true),
         Child(name: "RightSquare",
               kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")]))
       ]),

  Node(name: "DictionaryExpr",
       nameForDiagnostics: "dictionary",
       kind: "Expr",
       children: [
         Child(name: "LeftSquare",
               kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])),
         Child(name: "Content",
               kind: .nodeChoices(choices: [
                 Child(name: "Colon",
                       kind: .token(choices: [.token(tokenKind: "ColonToken")])),
                 Child(name: "Elements",
                       kind: .node(kind: "DictionaryElementList"))
               ]),
               isIndented: true),
         Child(name: "RightSquare",
               kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")]))
       ]),

  Node(name: "TupleExprElement",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Label",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
               isOptional: true),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")]),
               isOptional: true),
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "ArrayElement",
       nameForDiagnostics: "array element",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "DictionaryElement",
       nameForDiagnostics: "dictionary element",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "KeyExpression",
               kind: .node(kind: "Expr")),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "ValueExpression",
               kind: .node(kind: "Expr"),
               isIndented: true),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "IntegerLiteralExpr",
       nameForDiagnostics: "integer literal",
       kind: "Expr",
       children: [
         Child(name: "Digits",
               kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]))
       ]),

  Node(name: "BooleanLiteralExpr",
       nameForDiagnostics: "bool literal",
       kind: "Expr",
       children: [
         Child(name: "BooleanLiteral",
               kind: .token(choices: [.keyword(text: "true"), .keyword(text: "false")]))
       ]),

  Node(name: "UnresolvedTernaryExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "QuestionMark",
               kind: .token(choices: [.token(tokenKind: "InfixQuestionMarkToken")])),
         Child(name: "FirstChoice",
               kind: .node(kind: "Expr")),
         Child(name: "ColonMark",
               kind: .token(choices: [.token(tokenKind: "ColonToken")]))
       ]),

  Node(name: "TernaryExpr",
       nameForDiagnostics: "ternay expression",
       kind: "Expr",
       children: [
         Child(name: "ConditionExpression",
               kind: .node(kind: "Expr")),
         Child(name: "QuestionMark",
               kind: .token(choices: [.token(tokenKind: "InfixQuestionMarkToken")])),
         Child(name: "FirstChoice",
               kind: .node(kind: "Expr")),
         Child(name: "ColonMark",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "SecondChoice",
               kind: .node(kind: "Expr"))
       ]),

  Node(name: "MemberAccessExpr",
       nameForDiagnostics: "member access",
       kind: "Expr",
       children: [
         Child(name: "Base",
               kind: .node(kind: "Expr"),
               isOptional: true),
         Child(name: "Dot",
               kind: .token(choices: [.token(tokenKind: "PeriodToken")])),
         Child(name: "Name",
               kind: .node(kind: "Token")),
         Child(name: "DeclNameArguments",
               kind: .node(kind: "DeclNameArguments"),
               isOptional: true)
       ]),

  Node(name: "UnresolvedIsExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "IsTok",
               kind: .token(choices: [.keyword(text: "is")]))
       ]),

  Node(name: "IsExpr",
       nameForDiagnostics: "'is' expression",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "IsTok",
               kind: .token(choices: [.keyword(text: "is")])),
         Child(name: "TypeName",
               kind: .node(kind: "Type"))
       ]),

  Node(name: "UnresolvedAsExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "AsTok",
               kind: .token(choices: [.keyword(text: "as")])),
         Child(name: "QuestionOrExclamationMark",
               kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")]),
               isOptional: true)
       ]),

  Node(name: "AsExpr",
       nameForDiagnostics: "'as' expression",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "AsTok",
               kind: .token(choices: [.keyword(text: "as")])),
         Child(name: "QuestionOrExclamationMark",
               kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")]),
               isOptional: true),
         Child(name: "TypeName",
               kind: .node(kind: "Type"))
       ]),

  Node(name: "TypeExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Type",
               kind: .node(kind: "Type"))
       ]),

  Node(name: "ClosureCaptureItemSpecifier",
       nameForDiagnostics: "closure capture specifier",
       kind: "Syntax",
       children: [
         Child(name: "Specifier",
               kind: .token(choices: [.keyword(text: "weak"), .keyword(text: "unowned")])),
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
               isOptional: true),
         Child(name: "Detail",
               kind: .token(choices: [.keyword(text: "safe"), .keyword(text: "unsafe")]),
               isOptional: true),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
               isOptional: true)
       ]),

  Node(name: "ClosureCaptureItem",
       nameForDiagnostics: "closure capture item",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Specifier",
               kind: .node(kind: "ClosureCaptureItemSpecifier"),
               isOptional: true),
         Child(name: "Name",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               isOptional: true),
         Child(name: "AssignToken",
               kind: .token(choices: [.token(tokenKind: "EqualToken")]),
               isOptional: true),
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
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
               kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])),
         Child(name: "Items",
               kind: .collection(kind: "ClosureCaptureItemList", collectionElementName: "Item"),
               isOptional: true),
         Child(name: "RightSquare",
               kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")]))
       ]),

  Node(name: "ClosureParam",
       nameForDiagnostics: "closure parameter",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Name",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")])),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "ClosureParamList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "ClosureParam"),

  Node(name: "ClosureSignature",
       nameForDiagnostics: "closure signature",
       kind: "Syntax",
       traits: [
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               isOptional: true),
         Child(name: "Capture",
               kind: .node(kind: "ClosureCaptureSignature"),
               isOptional: true),
         Child(name: "Input",
               kind: .nodeChoices(choices: [
                 Child(name: "SimpleInput",
                       kind: .node(kind: "ClosureParamList")),
                 Child(name: "Input",
                       kind: .node(kind: "ParameterClause"))
               ]),
               isOptional: true),
         Child(name: "EffectSpecifiers",
               kind: .node(kind: "TypeEffectSpecifiers"),
               isOptional: true),
         Child(name: "Output",
               kind: .node(kind: "ReturnClause"),
               isOptional: true),
         Child(name: "InTok",
               kind: .token(choices: [.keyword(text: "in")]))
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
               kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])),
         Child(name: "Signature",
               kind: .node(kind: "ClosureSignature"),
               isOptional: true),
         Child(name: "Statements",
               kind: .collection(kind: "CodeBlockItemList", collectionElementName: "Statement"),
               isIndented: true),
         Child(name: "RightBrace",
               kind: .token(choices: [.token(tokenKind: "RightBraceToken")]),
               requiresLeadingNewline: true)
       ]),

  Node(name: "UnresolvedPatternExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Pattern",
               kind: .node(kind: "Pattern"))
       ]),

  Node(name: "MultipleTrailingClosureElement",
       nameForDiagnostics: "trailing closure",
       kind: "Syntax",
       children: [
         Child(name: "Label",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")])),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "Closure",
               kind: .node(kind: "ClosureExpr"))
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
               kind: .node(kind: "Expr")),
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
               isOptional: true),
         Child(name: "ArgumentList",
               kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument"),
               isIndented: true),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
               isOptional: true),
         Child(name: "TrailingClosure",
               kind: .node(kind: "ClosureExpr"),
               isOptional: true),
         Child(name: "AdditionalTrailingClosures",
               kind: .collection(kind: "MultipleTrailingClosureElementList", collectionElementName: "AdditionalTrailingClosure"),
               isOptional: true)
       ]),

  Node(name: "SubscriptExpr",
       nameForDiagnostics: "subscript",
       kind: "Expr",
       children: [
         Child(name: "CalledExpression",
               kind: .node(kind: "Expr")),
         Child(name: "LeftBracket",
               kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])),
         Child(name: "ArgumentList",
               kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument")),
         Child(name: "RightBracket",
               kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])),
         Child(name: "TrailingClosure",
               kind: .node(kind: "ClosureExpr"),
               isOptional: true),
         Child(name: "AdditionalTrailingClosures",
               kind: .collection(kind: "MultipleTrailingClosureElementList", collectionElementName: "AdditionalTrailingClosure"),
               isOptional: true)
       ]),

  Node(name: "OptionalChainingExpr",
       nameForDiagnostics: "optional chaining",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "QuestionMark",
               kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken")]))
       ]),

  Node(name: "ForcedValueExpr",
       nameForDiagnostics: "force unwrap",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "ExclamationMark",
               kind: .token(choices: [.token(tokenKind: "ExclamationMarkToken")]))
       ]),

  Node(name: "PostfixUnaryExpr",
       nameForDiagnostics: "postfix expression",
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "OperatorToken",
               kind: .token(choices: [.token(tokenKind: "PostfixOperatorToken")]))
       ]),

  Node(name: "SpecializeExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Expression",
               kind: .node(kind: "Expr")),
         Child(name: "GenericArgumentClause",
               kind: .node(kind: "GenericArgumentClause"))
       ]),

  Node(name: "StringSegment",
       nameForDiagnostics: nil,
       kind: "Syntax",
       children: [
         Child(name: "Content",
               kind: .token(choices: [.token(tokenKind: "StringSegmentToken")]))
       ]),

  Node(name: "ExpressionSegment",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "Backslash",
               kind: .token(choices: [.token(tokenKind: "BackslashToken")])),
         Child(name: "Delimiter",
               kind: .token(choices: [.token(tokenKind: "RawStringDelimiterToken")]),
               isOptional: true),
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
               classification: "StringInterpolationAnchor",
               forceClassification: true),
         Child(name: "Expressions",
               kind: .collection(kind: "TupleExprElementList", collectionElementName: "Expression")),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
               classification: "StringInterpolationAnchor",
               forceClassification: true)
       ]),

  Node(name: "StringLiteralExpr",
       nameForDiagnostics: "string literal",
       kind: "Expr",
       children: [
         Child(name: "OpenDelimiter",
               kind: .token(choices: [.token(tokenKind: "RawStringDelimiterToken")]),
               isOptional: true),
         Child(name: "OpenQuote",
               kind: .token(choices: [.token(tokenKind: "StringQuoteToken"), .token(tokenKind: "MultilineStringQuoteToken"), .token(tokenKind: "SingleQuoteToken")])),
         Child(name: "Segments",
               kind: .collection(kind: "StringLiteralSegments", collectionElementName: "Segment")),
         Child(name: "CloseQuote",
               kind: .token(choices: [.token(tokenKind: "StringQuoteToken"), .token(tokenKind: "MultilineStringQuoteToken"), .token(tokenKind: "SingleQuoteToken")])),
         Child(name: "CloseDelimiter",
               kind: .token(choices: [.token(tokenKind: "RawStringDelimiterToken")]),
               isOptional: true)
       ]),

  Node(name: "RegexLiteralExpr",
       nameForDiagnostics: "regex literal",
       kind: "Expr",
       children: [
         Child(name: "Regex",
               kind: .token(choices: [.token(tokenKind: "RegexLiteralToken")]))
       ]),

  Node(name: "KeyPathExpr",
       nameForDiagnostics: "key path",
       kind: "Expr",
       children: [
         Child(name: "Backslash",
               kind: .token(choices: [.token(tokenKind: "BackslashToken")])),
         Child(name: "Root",
               kind: .node(kind: "Type"),
               isOptional: true),
         Child(name: "Components",
               kind: .collection(kind: "KeyPathComponentList", collectionElementName: "KeyPathComponent"))
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
               kind: .token(choices: [.token(tokenKind: "PeriodToken")]),
               isOptional: true),
         Child(name: "Component",
               kind: .nodeChoices(choices: [
                 Child(name: "Property",
                       kind: .node(kind: "KeyPathPropertyComponent")),
                 Child(name: "Subscript",
                       kind: .node(kind: "KeyPathSubscriptComponent")),
                 Child(name: "Optional",
                       kind: .node(kind: "KeyPathOptionalComponent"))
               ]))
       ]),

  Node(name: "KeyPathPropertyComponent",
       nameForDiagnostics: "key path property component",
       kind: "Syntax",
       children: [
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "KeywordToken"), .token(tokenKind: "DollarIdentifierToken"), .token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "IntegerLiteralToken")])),
         Child(name: "DeclNameArguments",
               kind: .node(kind: "DeclNameArguments"),
               isOptional: true),
         Child(name: "GenericArgumentClause",
               kind: .node(kind: "GenericArgumentClause"),
               isOptional: true)
       ]),

  Node(name: "KeyPathSubscriptComponent",
       nameForDiagnostics: "key path subscript component",
       kind: "Syntax",
       children: [
         Child(name: "LeftBracket",
               kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])),
         Child(name: "ArgumentList",
               kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument")),
         Child(name: "RightBracket",
               kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")]))
       ]),

  Node(name: "KeyPathOptionalComponent",
       nameForDiagnostics: "key path optional component",
       kind: "Syntax",
       children: [
         Child(name: "QuestionOrExclamationMark",
               kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")]))
       ]),

  Node(name: "MacroExpansionExpr",
       nameForDiagnostics: "macro expansion",
       kind: "Expr",
       traits: [
         "FreestandingMacroExpansion"
       ],
       children: [
         Child(name: "PoundToken",
               kind: .token(choices: [.token(tokenKind: "PoundToken")]),
               description: "The `#` sign."),
         Child(name: "Macro",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")])),
         Child(name: "GenericArguments",
               kind: .node(kind: "GenericArgumentClause"),
               isOptional: true),
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
               isOptional: true),
         Child(name: "ArgumentList",
               kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument")),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
               isOptional: true),
         Child(name: "TrailingClosure",
               kind: .node(kind: "ClosureExpr"),
               isOptional: true),
         Child(name: "AdditionalTrailingClosures",
               kind: .collection(kind: "MultipleTrailingClosureElementList", collectionElementName: "AdditionalTrailingClosure"),
               isOptional: true)
       ]),

  Node(name: "PostfixIfConfigExpr",
       nameForDiagnostics: nil,
       kind: "Expr",
       children: [
         Child(name: "Base",
               kind: .node(kind: "Expr"),
               isOptional: true),
         Child(name: "Config",
               kind: .node(kind: "IfConfigDecl"))
       ]),

  Node(name: "EditorPlaceholderExpr",
       nameForDiagnostics: "editor placeholder",
       kind: "Expr",
       children: [
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]))
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
               kind: .node(kind: "Expr")),
         Child(name: "Comma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

]
