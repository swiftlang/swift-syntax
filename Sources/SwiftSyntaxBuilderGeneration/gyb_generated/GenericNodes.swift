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

let GENERIC_NODES: [Node] = [
  Node(name: "GenericWhereClause",
       kind: "Syntax",
       children: [
         Child(name: "WhereKeyword",
               kind: "WhereToken"),
         Child(name: "RequirementList",
               kind: "GenericRequirementList",
               collectionElementName: "Requirement")
       ]),

  Node(name: "GenericRequirementList",
       kind: "SyntaxCollection",
       element: "GenericRequirement",
       elementName: "GenericRequirement"),

  Node(name: "GenericRequirement",
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
                       kind: "ConformanceRequirement")
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "SameTypeRequirement",
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

  Node(name: "GenericParameterList",
       kind: "SyntaxCollection",
       element: "GenericParameter"),

  Node(name: "GenericParameter",
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
               kind: "IdentifierToken"),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "InheritedType",
               kind: "Type",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "PrimaryAssociatedTypeList",
       kind: "SyntaxCollection",
       element: "PrimaryAssociatedType"),

  Node(name: "PrimaryAssociatedType",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Name",
               kind: "IdentifierToken"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),

  Node(name: "GenericParameterClause",
       kind: "Syntax",
       children: [
         Child(name: "LeftAngleBracket",
               kind: "LeftAngleToken"),
         Child(name: "GenericParameterList",
               kind: "GenericParameterList",
               collectionElementName: "GenericParameter"),
         Child(name: "RightAngleBracket",
               kind: "RightAngleToken")
       ]),

  Node(name: "ConformanceRequirement",
       kind: "Syntax",
       children: [
         Child(name: "LeftTypeIdentifier",
               kind: "Type"),
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "RightTypeIdentifier",
               kind: "Type")
       ]),

  Node(name: "PrimaryAssociatedTypeClause",
       kind: "Syntax",
       children: [
         Child(name: "LeftAngleBracket",
               kind: "LeftAngleToken"),
         Child(name: "PrimaryAssociatedTypeList",
               kind: "PrimaryAssociatedTypeList",
               collectionElementName: "PrimaryAssociatedType"),
         Child(name: "RightAngleBracket",
               kind: "RightAngleToken")
       ]),

]
