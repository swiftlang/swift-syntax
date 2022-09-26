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
               kind: "WhereToken",
               tokenChoices: [
                 "Where"
               ]),
         Child(name: "RequirementList",
               kind: "GenericRequirementList",
               collectionElementName: "Requirement")
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
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "SameTypeRequirement",
                       kind: "SameTypeRequirement"),
                 Child(name: "ConformanceRequirement",
                       kind: "ConformanceRequirement"),
                 Child(name: "LayoutRequirement",
                       kind: "LayoutRequirement")
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "SameTypeRequirement",
       nameForDiagnostics: "same type requirement",
       kind: "Syntax",
       children: [
         Child(name: "LeftTypeIdentifier",
               kind: "Type"),
         Child(name: "EqualityToken",
               kind: "Token",
               tokenChoices: [
                 "SpacedBinaryOperator",
                 "UnspacedBinaryOperator",
                 "PrefixOperator",
                 "PostfixOperator"
               ]),
         Child(name: "RightTypeIdentifier",
               kind: "Type")
       ]),

  Node(name: "LayoutRequirement",
       nameForDiagnostics: "layout requirement",
       kind: "Syntax",
       children: [
         Child(name: "TypeIdentifier",
               kind: "Type"),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "LayoutConstraint",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               isOptional: true,
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Size",
               kind: "IntegerLiteralToken",
               isOptional: true,
               tokenChoices: [
                 "IntegerLiteral"
               ]),
         Child(name: "Comma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "Alignment",
               kind: "IntegerLiteralToken",
               isOptional: true,
               tokenChoices: [
                 "IntegerLiteral"
               ]),
         Child(name: "RightParen",
               kind: "RightParenToken",
               isOptional: true,
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "GenericParameterList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "GenericParameter"),

  Node(name: "GenericParameter",
       nameForDiagnostics: "generic parameter",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "Name",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true,
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "InheritedType",
               kind: "Type",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
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
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "GenericParameterClause",
       nameForDiagnostics: "generic parameter clause",
       kind: "Syntax",
       children: [
         Child(name: "LeftAngleBracket",
               kind: "LeftAngleToken",
               tokenChoices: [
                 "LeftAngle"
               ]),
         Child(name: "GenericParameterList",
               kind: "GenericParameterList",
               collectionElementName: "GenericParameter"),
         Child(name: "GenericWhereClause",
               kind: "GenericWhereClause",
               isOptional: true),
         Child(name: "RightAngleBracket",
               kind: "RightAngleToken",
               tokenChoices: [
                 "RightAngle"
               ])
       ]),

  Node(name: "ConformanceRequirement",
       nameForDiagnostics: "conformance requirement",
       kind: "Syntax",
       children: [
         Child(name: "LeftTypeIdentifier",
               kind: "Type"),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "RightTypeIdentifier",
               kind: "Type")
       ]),

  Node(name: "PrimaryAssociatedTypeClause",
       nameForDiagnostics: "primary associated type clause",
       kind: "Syntax",
       children: [
         Child(name: "LeftAngleBracket",
               kind: "LeftAngleToken",
               tokenChoices: [
                 "LeftAngle"
               ]),
         Child(name: "PrimaryAssociatedTypeList",
               kind: "PrimaryAssociatedTypeList",
               collectionElementName: "PrimaryAssociatedType"),
         Child(name: "RightAngleBracket",
               kind: "RightAngleToken",
               tokenChoices: [
                 "RightAngle"
               ])
       ]),

]
