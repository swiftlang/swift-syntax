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
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "Type",
               kind: .node(kind: "Type"))
       ]),

  Node(name: "IsTypePattern",
       nameForDiagnostics: "'is' pattern",
       kind: "Pattern",
       children: [
         Child(name: "IsKeyword",
               kind: .token(choices: [.keyword(text: "is")])),
         Child(name: "Type",
               kind: .node(kind: "Type"))
       ]),

  Node(name: "IdentifierPattern",
       nameForDiagnostics: "pattern",
       kind: "Pattern",
       children: [
         Child(name: "Identifier",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "KeywordToken")]))
       ]),

  Node(name: "TuplePattern",
       nameForDiagnostics: "tuple pattern",
       kind: "Pattern",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")])),
         Child(name: "Elements",
               kind: .collection(kind: "TuplePatternElementList", collectionElementName: "Element")),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]))
       ]),

  Node(name: "WildcardPattern",
       nameForDiagnostics: "wildcard pattern",
       kind: "Pattern",
       children: [
         Child(name: "Wildcard",
               kind: .token(choices: [.token(tokenKind: "WildcardToken")])),
         Child(name: "TypeAnnotation",
               kind: .node(kind: "TypeAnnotation"),
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
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               nameForDiagnostics: "label",
               isOptional: true),
         Child(name: "LabelColon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")]),
               isOptional: true),
         Child(name: "Pattern",
               kind: .node(kind: "Pattern")),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "ExpressionPattern",
       nameForDiagnostics: "pattern",
       kind: "Pattern",
       children: [
         Child(name: "Expression",
               kind: .node(kind: "Expr"))
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
               kind: .token(choices: [.keyword(text: "let"), .keyword(text: "var")])),
         Child(name: "ValuePattern",
               kind: .node(kind: "Pattern"))
       ]),

]
