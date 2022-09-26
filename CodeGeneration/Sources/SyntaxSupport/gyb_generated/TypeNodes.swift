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

public let TYPE_NODES: [Node] = [
  Node(name: "SimpleTypeIdentifier",
       nameForDiagnostics: "type",
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
       nameForDiagnostics: "member type",
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
       nameForDiagnostics: nil,
       kind: "Type",
       children: [
         Child(name: "ClassKeyword",
               kind: "ClassToken",
               tokenChoices: [
                 "Class"
               ])
       ]),
  
  Node(name: "ArrayType",
       nameForDiagnostics: "array type",
       kind: "Type",
       children: [
         Child(name: "LeftSquareBracket",
               kind: "LeftSquareBracketToken",
               tokenChoices: [
                 "LeftSquareBracket"
               ]),
         Child(name: "ElementType",
               kind: "Type"),
         Child(name: "RightSquareBracket",
               kind: "RightSquareBracketToken",
               tokenChoices: [
                 "RightSquareBracket"
               ])
       ]),
  
  Node(name: "DictionaryType",
       nameForDiagnostics: "dictionary type",
       kind: "Type",
       children: [
         Child(name: "LeftSquareBracket",
               kind: "LeftSquareBracketToken",
               tokenChoices: [
                 "LeftSquareBracket"
               ]),
         Child(name: "KeyType",
               kind: "Type"),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "ValueType",
               kind: "Type"),
         Child(name: "RightSquareBracket",
               kind: "RightSquareBracketToken",
               tokenChoices: [
                 "RightSquareBracket"
               ])
       ]),
  
  Node(name: "MetatypeType",
       nameForDiagnostics: "metatype",
       kind: "Type",
       children: [
         Child(name: "BaseType",
               kind: "Type"),
         Child(name: "Period",
               kind: "PeriodToken",
               tokenChoices: [
                 "Period"
               ]),
         Child(name: "TypeOrProtocol",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "Type",
                 "Protocol"
               ])
       ]),
  
  Node(name: "OptionalType",
       nameForDiagnostics: "optional type",
       kind: "Type",
       children: [
         Child(name: "WrappedType",
               kind: "Type"),
         Child(name: "QuestionMark",
               kind: "PostfixQuestionMarkToken",
               tokenChoices: [
                 "PostfixQuestionMark"
               ])
       ]),
  
  Node(name: "ConstrainedSugarType",
       nameForDiagnostics: "type",
       kind: "Type",
       children: [
         Child(name: "SomeOrAnySpecifier",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "some",
                 "any"
               ],
               classification: "Keyword"),
         Child(name: "BaseType",
               kind: "Type")
       ]),
  
  Node(name: "ImplicitlyUnwrappedOptionalType",
       nameForDiagnostics: "implicitly unwrapped optional type",
       kind: "Type",
       children: [
         Child(name: "WrappedType",
               kind: "Type"),
         Child(name: "ExclamationMark",
               kind: "ExclamationMarkToken",
               tokenChoices: [
                 "ExclamationMark"
               ])
       ]),
  
  Node(name: "CompositionTypeElement",
       nameForDiagnostics: nil,
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
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "CompositionTypeElement"),
  
  Node(name: "CompositionType",
       nameForDiagnostics: "type composition",
       kind: "Type",
       children: [
         Child(name: "Elements",
               kind: "CompositionTypeElementList",
               collectionElementName: "Element")
       ]),
  
  Node(name: "PackExpansionType",
       nameForDiagnostics: "variadic expansion",
       kind: "Type",
       children: [
         Child(name: "PatternType",
               kind: "Type"),
         Child(name: "Ellipsis",
               kind: "EllipsisToken",
               tokenChoices: [
                 "Ellipsis"
               ])
       ]),
  
  Node(name: "TupleTypeElement",
       nameForDiagnostics: nil,
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "InOut",
               kind: "InoutToken",
               isOptional: true,
               tokenChoices: [
                 "Inout"
               ]),
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
               isOptional: true,
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Type",
               kind: "Type"),
         Child(name: "Ellipsis",
               kind: "EllipsisToken",
               isOptional: true,
               tokenChoices: [
                 "Ellipsis"
               ]),
         Child(name: "Initializer",
               kind: "InitializerClause",
               isOptional: true),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),
  
  Node(name: "TupleTypeElementList",
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "TupleTypeElement"),
  
  Node(name: "TupleType",
       nameForDiagnostics: "tuple type",
       kind: "Type",
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
               kind: "TupleTypeElementList",
               collectionElementName: "Element"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),
  
  Node(name: "FunctionType",
       nameForDiagnostics: "function type",
       kind: "Type",
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
               kind: "TupleTypeElementList",
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ]),
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
               kind: "ArrowToken",
               tokenChoices: [
                 "Arrow"
               ]),
         Child(name: "ReturnType",
               kind: "Type")
       ]),
  
  Node(name: "AttributedType",
       nameForDiagnostics: "type",
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
       nameForDiagnostics: nil,
       kind: "SyntaxCollection",
       element: "GenericArgument"),
  
  Node(name: "GenericArgument",
       nameForDiagnostics: "generic argument",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "ArgumentType",
               kind: "Type"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),
  
  Node(name: "GenericArgumentClause",
       nameForDiagnostics: "generic argument clause",
       kind: "Syntax",
       children: [
         Child(name: "LeftAngleBracket",
               kind: "LeftAngleToken",
               tokenChoices: [
                 "LeftAngle"
               ]),
         Child(name: "Arguments",
               kind: "GenericArgumentList",
               collectionElementName: "Argument"),
         Child(name: "RightAngleBracket",
               kind: "RightAngleToken",
               tokenChoices: [
                 "RightAngle"
               ])
       ]),
  
  Node(name: "NamedOpaqueReturnType",
       nameForDiagnostics: "named opaque return type",
       kind: "Type",
       children: [
         Child(name: "GenericParameters",
               kind: "GenericParameterClause"),
         Child(name: "BaseType",
               kind: "Type")
       ]),
  
]
