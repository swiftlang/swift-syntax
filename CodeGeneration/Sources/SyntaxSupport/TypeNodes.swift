//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public let TYPE_NODES: [Node] = [
  // array-type -> '[' type ']'
  Node(
    name: "ArrayType",
    nameForDiagnostics: "array type",
    kind: "Type",
    children: [
      Child(
        name: "LeftSquareBracket",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "ElementType",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "RightSquareBracket",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
      ),
    ]
  ),

  // attributed-type -> type-specifier? attribute-list? type
  // type-specifier -> 'inout' | 'borrowing' | 'consuming' | '__owned' | '__shared'
  Node(
    name: "AttributedType",
    nameForDiagnostics: "type",
    kind: "Type",
    traits: [
      "WithAttributes"
    ],
    children: [
      Child(
        name: "Specifier",
        kind: .token(choices: [.keyword(text: "inout"), .keyword(text: "__shared"), .keyword(text: "__owned"), .keyword(text: "isolated"), .keyword(text: "_const"), .keyword(text: "borrowing"), .keyword(text: "consuming")]),
        isOptional: true
      ),
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        isOptional: true
      ),
      Child(
        name: "BaseType",
        kind: .node(kind: "Type")
      ),
    ]
  ),
  // class-restriction-type -> 'class'
  Node(
    name: "ClassRestrictionType",
    nameForDiagnostics: nil,
    kind: "Type",
    children: [
      Child(
        name: "ClassKeyword",
        kind: .token(choices: [.keyword(text: "class")])
      )
    ]
  ),

  // composition-typeelement-list -> composition-type-element
  //   composition-type-element-list?
  Node(
    name: "CompositionTypeElementList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "CompositionTypeElement"
  ),

  // composition-type-element -> type '&'
  Node(
    name: "CompositionTypeElement",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "Type",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "Ampersand",
        kind: .node(kind: "Token"),
        isOptional: true
      ),
    ]
  ),

  // composition-type -> composition-type-element-list
  Node(
    name: "CompositionType",
    nameForDiagnostics: "type composition",
    kind: "Type",
    children: [
      Child(
        name: "Elements",
        kind: .collection(kind: "CompositionTypeElementList", collectionElementName: "Element")
      )
    ]
  ),

  // constrained-sugar-type -> ('some'|'any') type
  Node(
    name: "ConstrainedSugarType",
    nameForDiagnostics: "type",
    kind: "Type",
    children: [
      Child(
        name: "SomeOrAnySpecifier",
        kind: .token(choices: [.keyword(text: "some"), .keyword(text: "any")])
      ),
      Child(
        name: "BaseType",
        kind: .node(kind: "Type")
      ),
    ]
  ),

  // dictionary-type -> '[' type ':' type ']'
  Node(
    name: "DictionaryType",
    nameForDiagnostics: "dictionary type",
    kind: "Type",
    children: [
      Child(
        name: "LeftSquareBracket",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "KeyType",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "key type"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "ValueType",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "value type"
      ),
      Child(
        name: "RightSquareBracket",
        kind: .token(choices: [.token(tokenKind: "RightSquareBracketToken")])
      ),
    ]
  ),

  // throwing-specifier -> 'throws' | 'rethrows'
  // function-type -> attribute-list '(' function-type-argument-list ')'
  //   type-effect-specifiers? return-clause
  Node(
    name: "FunctionType",
    nameForDiagnostics: "function type",
    kind: "Type",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Arguments",
        kind: .collection(kind: "TupleTypeElementList", collectionElementName: "Argument"),
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
      Child(
        name: "EffectSpecifiers",
        kind: .node(kind: "TypeEffectSpecifiers"),
        isOptional: true
      ),
      Child(
        name: "Output",
        kind: .node(kind: "ReturnClause")
      ),
    ]
  ),

  // generic-argument-clause -> '<' generic-argument-list '>'
  Node(
    name: "GenericArgumentClause",
    nameForDiagnostics: "generic argument clause",
    kind: "Syntax",
    children: [
      Child(
        name: "LeftAngleBracket",
        kind: .token(choices: [.token(tokenKind: "LeftAngleToken")])
      ),
      Child(
        name: "Arguments",
        kind: .collection(kind: "GenericArgumentList", collectionElementName: "Argument")
      ),
      Child(
        name: "RightAngleBracket",
        kind: .token(choices: [.token(tokenKind: "RightAngleToken")])
      ),
    ]
  ),

  // generic-argument-list -> generic-argument generic-argument-list?
  Node(
    name: "GenericArgumentList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "GenericArgument"
  ),

  // A generic argument.
  // Dictionary<Int, String>
  //            ^~~~ ^~~~~~
  Node(
    name: "GenericArgument",
    nameForDiagnostics: "generic argument",
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "ArgumentType",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  // implicitly-unwrapped-optional-type -> type '!'
  Node(
    name: "ImplicitlyUnwrappedOptionalType",
    nameForDiagnostics: "implicitly unwrapped optional type",
    kind: "Type",
    children: [
      Child(
        name: "WrappedType",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "ExclamationMark",
        kind: .token(choices: [.token(tokenKind: "ExclamationMarkToken")])
      ),
    ]
  ),

  // member-type-identifier -> type '.' identifier generic-argument-clause?
  Node(
    name: "MemberTypeIdentifier",
    nameForDiagnostics: "member type",
    kind: "Type",
    children: [
      Child(
        name: "BaseType",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "base type"
      ),
      Child(
        name: "Period",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")])
      ),
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "KeywordToken")]),
        nameForDiagnostics: "name",
        classification: "TypeIdentifier"
      ),
      Child(
        name: "GenericArgumentClause",
        kind: .node(kind: "GenericArgumentClause"),
        isOptional: true
      ),
    ]
  ),
  // metatype-type -> type '.' 'Type'
  //                | type '.' 'Protocol
  Node(
    name: "MetatypeType",
    nameForDiagnostics: "metatype",
    kind: "Type",
    children: [
      Child(
        name: "BaseType",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "base type"
      ),
      Child(
        name: "Period",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")])
      ),
      Child(
        name: "TypeOrProtocol",
        kind: .token(choices: [.keyword(text: "Type"), .keyword(text: "Protocol")])
      ),
    ]
  ),

  // named-opaque-return-type -> generic-argument-clause type
  Node(
    name: "NamedOpaqueReturnType",
    nameForDiagnostics: "named opaque return type",
    kind: "Type",
    children: [
      Child(
        name: "GenericParameters",
        kind: .node(kind: "GenericParameterClause")
      ),
      Child(
        name: "BaseType",
        kind: .node(kind: "Type")
      ),
    ]
  ),

  // optional-type -> type '?'
  Node(
    name: "OptionalType",
    nameForDiagnostics: "optional type",
    kind: "Type",
    children: [
      Child(
        name: "WrappedType",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "QuestionMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken")])
      ),
    ]
  ),

  // suppressed-type -> '~' type
  Node(
    name: "SuppressedType",
    nameForDiagnostics: "suppressed type conformance",
    kind: "Type",
    children: [
      Child(
        name: "WithoutTilde",
        kind: .token(choices: [.token(tokenKind: "PrefixOperatorToken")])
      ),
      Child(
        name: "PatternType",
        kind: .node(kind: "Type")
      ),
    ]
  ),

  // pack-expansion-type -> type '...'
  Node(
    name: "PackExpansionType",
    nameForDiagnostics: "variadic expansion",
    kind: "Type",
    children: [
      Child(
        name: "RepeatKeyword",
        kind: .token(choices: [.keyword(text: "repeat")])
      ),
      Child(
        name: "PatternType",
        kind: .node(kind: "Type")
      ),
    ]
  ),

  // pack-reference-type -> 'each' type
  Node(
    name: "PackReferenceType",
    nameForDiagnostics: "pack reference",
    kind: "Type",
    children: [
      Child(
        name: "EachKeyword",
        kind: .token(choices: [.keyword(text: "each")])
      ),
      Child(
        name: "PackType",
        kind: .node(kind: "Type")
      ),
    ]
  ),

  // simple-type-identifier -> identifier generic-argument-clause?
  Node(
    name: "SimpleTypeIdentifier",
    nameForDiagnostics: "type",
    kind: "Type",
    children: [
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "KeywordToken"), .token(tokenKind: "WildcardToken")]),
        classification: "TypeIdentifier"
      ),
      Child(
        name: "GenericArgumentClause",
        kind: .node(kind: "GenericArgumentClause"),
        isOptional: true
      ),
    ]
  ),

  // tuple-type-element-list -> tuple-type-element tuple-type-element-list?
  Node(
    name: "TupleTypeElementList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "TupleTypeElement"
  ),

  // tuple-type-element -> identifier? ':'? type-annotation ','?
  Node(
    name: "TupleTypeElement",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "InOut",
        kind: .node(kind: "InoutToken"),
        isOptional: true
      ),
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        nameForDiagnostics: "name",
        isOptional: true
      ),
      Child(
        name: "SecondName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        nameForDiagnostics: "internal name",
        isOptional: true
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        isOptional: true
      ),
      Child(
        name: "Type",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "Ellipsis",
        kind: .token(choices: [.token(tokenKind: "EllipsisToken")]),
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: "InitializerClause"),
        isOptional: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  // tuple-type -> '(' tuple-type-element-list ')'
  Node(
    name: "TupleType",
    nameForDiagnostics: "tuple type",
    kind: "Type",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Elements",
        kind: .collection(kind: "TupleTypeElementList", collectionElementName: "Element"),
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

]
