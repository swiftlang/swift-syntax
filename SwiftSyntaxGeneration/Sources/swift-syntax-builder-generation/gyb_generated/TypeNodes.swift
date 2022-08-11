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

let TYPE_NODES: [Node] = [
  Node(name: "SimpleTypeIdentifier",
       kind: "Type",
       children: [
         Child(name: "Name",
               kind: "Token",
               tokenChoices: [
                 "Identifier",
                 "CapitalSelf",
                 "Any"
               ],
               classification: "TypeIdentifier"),
         Child(name: "GenericArgumentClause",
               kind: "GenericArgumentClause",
               isOptional: true)
       ]),
  
  Node(name: "MemberTypeIdentifier",
       kind: "Type",
       children: [
         Child(name: "BaseType",
               kind: "Type"),
         Child(name: "Period",
               kind: "Token",
               tokenChoices: [
                 "Period",
                 "PrefixPeriod"
               ]),
         Child(name: "Name",
               kind: "Token",
               tokenChoices: [
                 "Identifier",
                 "CapitalSelf",
                 "Any"
               ],
               classification: "TypeIdentifier"),
         Child(name: "GenericArgumentClause",
               kind: "GenericArgumentClause",
               isOptional: true)
       ]),
  
  Node(name: "ClassRestrictionType",
       kind: "Type",
       children: [
         Child(name: "ClassKeyword",
               kind: "ClassToken")
       ]),
  
  Node(name: "ArrayType",
       kind: "Type",
       children: [
         Child(name: "LeftSquareBracket",
               kind: "LeftSquareBracketToken"),
         Child(name: "ElementType",
               kind: "Type"),
         Child(name: "RightSquareBracket",
               kind: "RightSquareBracketToken")
       ]),
  
  Node(name: "DictionaryType",
       kind: "Type",
       children: [
         Child(name: "LeftSquareBracket",
               kind: "LeftSquareBracketToken"),
         Child(name: "KeyType",
               kind: "Type"),
         Child(name: "Colon",
               kind: "ColonToken"),
         Child(name: "ValueType",
               kind: "Type"),
         Child(name: "RightSquareBracket",
               kind: "RightSquareBracketToken")
       ]),
  
  Node(name: "MetatypeType",
       kind: "Type",
       children: [
         Child(name: "BaseType",
               kind: "Type"),
         Child(name: "Period",
               kind: "PeriodToken"),
         Child(name: "TypeOrProtocol",
               kind: "IdentifierToken",
               textChoices: [
                 "Type",
                 "Protocol"
               ])
       ]),
  
  Node(name: "OptionalType",
       kind: "Type",
       children: [
         Child(name: "WrappedType",
               kind: "Type"),
         Child(name: "QuestionMark",
               kind: "PostfixQuestionMarkToken")
       ]),
  
  Node(name: "ConstrainedSugarType",
       kind: "Type",
       children: [
         Child(name: "SomeOrAnySpecifier",
               kind: "IdentifierToken",
               textChoices: [
                 "some",
                 "any"
               ],
               classification: "Keyword"),
         Child(name: "BaseType",
               kind: "Type")
       ]),
  
  Node(name: "ImplicitlyUnwrappedOptionalType",
       kind: "Type",
       children: [
         Child(name: "WrappedType",
               kind: "Type"),
         Child(name: "ExclamationMark",
               kind: "ExclamationMarkToken")
       ]),
  
  Node(name: "CompositionTypeElement",
       kind: "Syntax",
       children: [
         Child(name: "Type",
               kind: "Type"),
         Child(name: "Ampersand",
               kind: "Token",
               isOptional: true,
               textChoices: [
                 "&"
               ])
       ]),
  
  Node(name: "CompositionTypeElementList",
       kind: "SyntaxCollection",
       element: "CompositionTypeElement"),
  
  Node(name: "CompositionType",
       kind: "Type",
       children: [
         Child(name: "Elements",
               kind: "CompositionTypeElementList",
               collectionElementName: "Element")
       ]),
  
  Node(name: "TupleTypeElement",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "InOut",
               kind: "InoutToken",
               isOptional: true),
         Child(name: "Name",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Identifier",
                 "Wildcard"
               ]),
         Child(name: "SecondName",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Identifier",
                 "Wildcard"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true),
         Child(name: "Type",
               kind: "Type"),
         Child(name: "Ellipsis",
               kind: "EllipsisToken",
               isOptional: true),
         Child(name: "Initializer",
               kind: "InitializerClause",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),
  
  Node(name: "TupleTypeElementList",
       kind: "SyntaxCollection",
       element: "TupleTypeElement"),
  
  Node(name: "TupleType",
       kind: "Type",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Elements",
               kind: "TupleTypeElementList",
               collectionElementName: "Element"),
         Child(name: "RightParen",
               kind: "RightParenToken")
       ]),
  
  Node(name: "FunctionType",
       kind: "Type",
       traits: [
         "Parenthesized"
       ],
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken"),
         Child(name: "Arguments",
               kind: "TupleTypeElementList",
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken"),
         Child(name: "AsyncKeyword",
               kind: "ContextualKeyworkToken",
               isOptional: true,
               textChoices: [
                 "async"
               ]),
         Child(name: "ThrowsOrRethrowsKeyword",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Throws",
                 "Rethrows",
                 "Throw"
               ]),
         Child(name: "Arrow",
               kind: "ArrowToken"),
         Child(name: "ReturnType",
               kind: "Type")
       ]),
  
  Node(name: "AttributedType",
       kind: "Type",
       children: [
         Child(name: "Specifier",
               kind: "Token",
               isOptional: true,
               textChoices: [
                 "inout",
                 "__shared",
                 "__owned"
               ]),
         Child(name: "Attributes",
               kind: "AttributeList",
               isOptional: true,
               collectionElementName: "Attribute"),
         Child(name: "BaseType",
               kind: "Type")
       ]),
  
  Node(name: "GenericArgumentList",
       kind: "SyntaxCollection",
       element: "GenericArgument"),
  
  Node(name: "GenericArgument",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "ArgumentType",
               kind: "Type"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true)
       ]),
  
  Node(name: "GenericArgumentClause",
       kind: "Syntax",
       children: [
         Child(name: "LeftAngleBracket",
               kind: "LeftAngleToken"),
         Child(name: "Arguments",
               kind: "GenericArgumentList",
               collectionElementName: "Argument"),
         Child(name: "RightAngleBracket",
               kind: "RightAngleToken")
       ]),
  
]
