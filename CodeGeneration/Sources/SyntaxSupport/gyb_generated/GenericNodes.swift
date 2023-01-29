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

public let GENERIC_NODES: [Node] = [
  Node(name: "GenericWhereClause",
       nameForDiagnostics: "'where' clause",
       kind: "Syntax",
       children: [
         Child(name: "WhereKeyword",
               kind: .token(choices: [.keyword(text: "where")])),
         Child(name: "RequirementList",
               kind: .collection(kind: "GenericRequirementList", collectionElementName: "Requirement"))
       ]),

  Node(name: "GenericRequirementList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "GenericRequirement",
       elementName: "GenericRequirement"),

  Node(name: "GenericRequirement",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Body",
               kind: .nodeChoices(choices: [
                 Child(name: "SameTypeRequirement",
                       kind: .node(kind: "SameTypeRequirement")),
                 Child(name: "ConformanceRequirement",
                       kind: .node(kind: "ConformanceRequirement")),
                 Child(name: "LayoutRequirement",
                       kind: .node(kind: "LayoutRequirement"))
               ])),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "SameTypeRequirement",
       nameForDiagnostics: "same type requirement",
       kind: "Syntax",
       children: [
         Child(name: "LeftTypeIdentifier",
               kind: .node(kind: "Type"),
               nameForDiagnostics: "left-hand type"),
         Child(name: "EqualityToken",
               kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "PrefixOperatorToken"), .token(tokenKind: "PostfixOperatorToken")])),
         Child(name: "RightTypeIdentifier",
               kind: .node(kind: "Type"),
               nameForDiagnostics: "right-hand type")
       ]),

  Node(name: "LayoutRequirement",
       nameForDiagnostics: "layout requirement",
       kind: "Syntax",
       children: [
         Child(name: "TypeIdentifier",
               kind: .node(kind: "Type"),
               nameForDiagnostics: "constrained type"),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "LayoutConstraint",
               kind: .token(choices: [.keyword(text: "_Trivial"), .keyword(text: "_TrivialAtMost"), .keyword(text: "_UnknownLayout"), .keyword(text: "_RefCountedObject"), .keyword(text: "_NativeRefCountedObject"), .keyword(text: "_Class"), .keyword(text: "_NativeClass")])),
         Child(name: "LeftParen",
               kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
               isOptional: true),
         Child(name: "Size",
               kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
               nameForDiagnostics: "size",
               isOptional: true),
         Child(name: "Comma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true),
         Child(name: "Alignment",
               kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
               nameForDiagnostics: "alignment",
               isOptional: true),
         Child(name: "RightParen",
               kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
               isOptional: true)
       ]),

  Node(name: "GenericParameterList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "GenericParameter"),

  Node(name: "GenericParameter",
       nameForDiagnostics: "generic parameter",
       kind: "Syntax",
       traits: [
         "WithTrailingComma",
         "Attributed"
       ],
       children: [
         Child(name: "Attributes",
               kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
               isOptional: true),
         Child(name: "Name",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               nameForDiagnostics: "name"),
         Child(name: "Ellipsis",
               kind: .token(choices: [.token(tokenKind: "EllipsisToken")]),
               nameForDiagnostics: "parameter pack specifier",
               isOptional: true),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")]),
               isOptional: true),
         Child(name: "InheritedType",
               kind: .node(kind: "Type"),
               nameForDiagnostics: "inherited type",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "PrimaryAssociatedTypeList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "PrimaryAssociatedType"),

  Node(name: "PrimaryAssociatedType",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Name",
               kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
               nameForDiagnostics: "name"),
         Child(name: "TrailingComma",
               kind: .token(choices: [.token(tokenKind: "CommaToken")]),
               isOptional: true)
       ]),

  Node(name: "GenericParameterClause",
       nameForDiagnostics: "generic parameter clause",
       kind: "Syntax",
       parserFunction: "parseGenericParameters",
       children: [
         Child(name: "LeftAngleBracket",
               kind: .token(choices: [.token(tokenKind: "LeftAngleToken")])),
         Child(name: "GenericParameterList",
               kind: .collection(kind: "GenericParameterList", collectionElementName: "GenericParameter")),
         Child(name: "GenericWhereClause",
               kind: .node(kind: "GenericWhereClause"),
               isOptional: true),
         Child(name: "RightAngleBracket",
               kind: .token(choices: [.token(tokenKind: "RightAngleToken")]))
       ]),

  Node(name: "ConformanceRequirement",
       nameForDiagnostics: "conformance requirement",
       kind: "Syntax",
       children: [
         Child(name: "LeftTypeIdentifier",
               kind: .node(kind: "Type")),
         Child(name: "Colon",
               kind: .token(choices: [.token(tokenKind: "ColonToken")])),
         Child(name: "RightTypeIdentifier",
               kind: .node(kind: "Type"))
       ]),

  Node(name: "PrimaryAssociatedTypeClause",
       nameForDiagnostics: "primary associated type clause",
       kind: "Syntax",
       children: [
         Child(name: "LeftAngleBracket",
               kind: .token(choices: [.token(tokenKind: "LeftAngleToken")])),
         Child(name: "PrimaryAssociatedTypeList",
               kind: .collection(kind: "PrimaryAssociatedTypeList", collectionElementName: "PrimaryAssociatedType")),
         Child(name: "RightAngleBracket",
               kind: .token(choices: [.token(tokenKind: "RightAngleToken")]))
       ]),

]
