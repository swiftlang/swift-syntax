//// Automatically Generated From PatternNodes.swift.gyb.
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

public let PATTERN_NODES: [Node] = [
  Node(name: "TypeAnnotation",
       nameForDiagnostics: "type annotation",
       kind: "Syntax",
       children: [
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Type",
               kind: "Type")
       ]),

  Node(name: "EnumCasePattern",
       nameForDiagnostics: "enum case pattern",
       kind: "Pattern",
       children: [
         Child(name: "Type",
               kind: "Type",
               isOptional: true),
         Child(name: "Period",
               kind: "PeriodToken",
               tokenChoices: [
                 "Period"
               ]),
         Child(name: "CaseName",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "AssociatedTuple",
               kind: "TuplePattern",
               isOptional: true)
       ]),

  Node(name: "IsTypePattern",
       nameForDiagnostics: "'is' pattern",
       kind: "Pattern",
       children: [
         Child(name: "IsKeyword",
               kind: "IsToken",
               tokenChoices: [
                 "Is"
               ]),
         Child(name: "Type",
               kind: "Type")
       ]),

  Node(name: "OptionalPattern",
       nameForDiagnostics: "optional pattern",
       kind: "Pattern",
       children: [
         Child(name: "SubPattern",
               kind: "Pattern"),
         Child(name: "QuestionMark",
               kind: "PostfixQuestionMarkToken",
               tokenChoices: [
                 "PostfixQuestionMark"
               ])
       ]),

  Node(name: "IdentifierPattern",
       nameForDiagnostics: "pattern",
       kind: "Pattern",
       children: [
         Child(name: "Identifier",
               kind: "Token",
               tokenChoices: [
                 "Self",
                 "Identifier"
               ])
       ]),

  Node(name: "AsTypePattern",
       nameForDiagnostics: "'as' pattern",
       kind: "Pattern",
       children: [
         Child(name: "Pattern",
               kind: "Pattern"),
         Child(name: "AsKeyword",
               kind: "AsToken",
               tokenChoices: [
                 "As"
               ]),
         Child(name: "Type",
               kind: "Type")
       ]),

  Node(name: "TuplePattern",
       nameForDiagnostics: "tuple pattern",
       kind: "Pattern",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Elements",
               kind: "TuplePatternElementList",
               collectionElementName: "Element"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "WildcardPattern",
       nameForDiagnostics: "wildcard pattern",
       kind: "Pattern",
       children: [
         Child(name: "Wildcard",
               kind: "WildcardToken",
               tokenChoices: [
                 "Wildcard"
               ]),
         Child(name: "TypeAnnotation",
               kind: "TypeAnnotation",
               isOptional: true)
       ]),

  Node(name: "TuplePatternElement",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "LabelName",
               kind: "IdentifierToken",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "LabelColon",
               kind: "ColonToken",
               isOptional: true,
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Pattern",
               kind: "Pattern"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "ExpressionPattern",
       nameForDiagnostics: "pattern",
       kind: "Pattern",
       children: [
         Child(name: "Expression",
               kind: "Expr")
       ]),

  Node(name: "TuplePatternElementList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "TuplePatternElement"),

  Node(name: "ValueBindingPattern",
       nameForDiagnostics: "value binding pattern",
       kind: "Pattern",
       children: [
         Child(name: "LetOrVarKeyword",
               kind: "Token",
               tokenChoices: [
                 "Let",
                 "Var"
               ]),
         Child(name: "ValuePattern",
               kind: "Pattern")
       ]),

]
