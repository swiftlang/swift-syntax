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
    kind: .arrayType,
    base: .type,
    nameForDiagnostics: "array type",
    children: [
      Child(
        name: "LeftSquareBracket",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "ElementType",
        kind: .node(kind: .type)
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
    kind: .attributedType,
    base: .type,
    nameForDiagnostics: "type",
    traits: [
      "WithAttributes"
    ],
    children: [
      Child(
        name: "Specifier",
        kind: .token(choices: [
          .keyword(text: "inout"),
          .keyword(text: "__shared"),
          .keyword(text: "__owned"),
          .keyword(text: "isolated"),
          .keyword(text: "_const"),
          .keyword(text: "borrowing"),
          .keyword(text: "consuming"),
        ]),
        isOptional: true
      ),
      Child(
        name: "Attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute"),
        isOptional: true
      ),
      Child(
        name: "BaseType",
        kind: .node(kind: .type)
      ),
    ]
  ),
  // class-restriction-type -> 'class'
  Node(
    kind: .classRestrictionType,
    base: .type,
    nameForDiagnostics: nil,
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
    kind: .compositionTypeElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.compositionTypeElement]
  ),

  // composition-type-element -> type '&'
  Node(
    kind: .compositionTypeElement,
    base: .syntax,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "Type",
        kind: .node(kind: .type)
      ),
      Child(
        name: "Ampersand",
        kind: .node(kind: .token),
        isOptional: true
      ),
    ]
  ),

  // composition-type -> composition-type-element-list
  Node(
    kind: .compositionType,
    base: .type,
    nameForDiagnostics: "type composition",
    children: [
      Child(
        name: "Elements",
        kind: .collection(kind: .compositionTypeElementList, collectionElementName: "Element")
      )
    ]
  ),

  // constrained-sugar-type -> ('some'|'any') type
  Node(
    kind: .constrainedSugarType,
    base: .type,
    nameForDiagnostics: "type",
    children: [
      Child(
        name: "SomeOrAnySpecifier",
        kind: .token(choices: [.keyword(text: "some"), .keyword(text: "any")])
      ),
      Child(
        name: "BaseType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // dictionary-type -> '[' type ':' type ']'
  Node(
    kind: .dictionaryType,
    base: .type,
    nameForDiagnostics: "dictionary type",
    children: [
      Child(
        name: "LeftSquareBracket",
        kind: .token(choices: [.token(tokenKind: "LeftSquareBracketToken")])
      ),
      Child(
        name: "KeyType",
        kind: .node(kind: .type),
        nameForDiagnostics: "key type"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "ValueType",
        kind: .node(kind: .type),
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
    kind: .functionType,
    base: .type,
    nameForDiagnostics: "function type",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Parameters",
        kind: .collection(kind: .tupleTypeElementList, collectionElementName: "Parameter"),
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
      Child(
        name: "EffectSpecifiers",
        kind: .node(kind: .typeEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "Output",
        kind: .node(kind: .returnClause)
      ),
    ]
  ),

  // generic-argument-clause -> '<' generic-argument-list '>'
  Node(
    kind: .genericArgumentClause,
    base: .syntax,
    nameForDiagnostics: "generic argument clause",
    children: [
      Child(
        name: "LeftAngleBracket",
        kind: .token(choices: [.token(tokenKind: "LeftAngleToken")])
      ),
      Child(
        name: "Arguments",
        kind: .collection(kind: .genericArgumentList, collectionElementName: "Argument")
      ),
      Child(
        name: "RightAngleBracket",
        kind: .token(choices: [.token(tokenKind: "RightAngleToken")])
      ),
    ]
  ),

  // generic-argument-list -> generic-argument generic-argument-list?
  Node(
    kind: .genericArgumentList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.genericArgument]
  ),

  // A generic argument.
  // Dictionary<Int, String>
  //            ^~~~ ^~~~~~
  Node(
    kind: .genericArgument,
    base: .syntax,
    nameForDiagnostics: "generic argument",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "ArgumentType",
        kind: .node(kind: .type)
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
    kind: .implicitlyUnwrappedOptionalType,
    base: .type,
    nameForDiagnostics: "implicitly unwrapped optional type",
    children: [
      Child(
        name: "WrappedType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "ExclamationMark",
        kind: .token(choices: [.token(tokenKind: "ExclamationMarkToken")])
      ),
    ]
  ),

  // member-type-identifier -> type '.' identifier generic-argument-clause?
  Node(
    kind: .memberTypeIdentifier,
    base: .type,
    nameForDiagnostics: "member type",
    children: [
      Child(
        name: "BaseType",
        kind: .node(kind: .type),
        nameForDiagnostics: "base type"
      ),
      Child(
        name: "Period",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")])
      ),
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .keyword(text: "self"), .keyword(text: "Self")]),
        nameForDiagnostics: "name",
        classification: "TypeIdentifier"
      ),
      Child(
        name: "GenericArgumentClause",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
    ]
  ),
  // metatype-type -> type '.' 'Type'
  //                | type '.' 'Protocol
  Node(
    kind: .metatypeType,
    base: .type,
    nameForDiagnostics: "metatype",
    children: [
      Child(
        name: "BaseType",
        kind: .node(kind: .type),
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
    kind: .namedOpaqueReturnType,
    base: .type,
    nameForDiagnostics: "named opaque return type",
    children: [
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: .genericParameterClause)
      ),
      Child(
        name: "BaseType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // optional-type -> type '?'
  Node(
    kind: .optionalType,
    base: .type,
    nameForDiagnostics: "optional type",
    children: [
      Child(
        name: "WrappedType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "QuestionMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken")])
      ),
    ]
  ),

  // suppressed-type -> '~' type
  Node(
    kind: .suppressedType,
    base: .type,
    nameForDiagnostics: "suppressed type conformance",
    children: [
      Child(
        name: "WithoutTilde",
        kind: .token(choices: [.token(tokenKind: "PrefixOperatorToken")])
      ),
      Child(
        name: "PatternType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // pack-expansion-type -> type '...'
  Node(
    kind: .packExpansionType,
    base: .type,
    nameForDiagnostics: "variadic expansion",
    children: [
      Child(
        name: "RepeatKeyword",
        kind: .token(choices: [.keyword(text: "repeat")])
      ),
      Child(
        name: "PatternType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // pack-reference-type -> 'each' type
  Node(
    kind: .packReferenceType,
    base: .type,
    nameForDiagnostics: "pack reference",
    children: [
      Child(
        name: "EachKeyword",
        kind: .token(choices: [.keyword(text: "each")])
      ),
      Child(
        name: "PackType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // simple-type-identifier -> identifier generic-argument-clause?
  Node(
    kind: .simpleTypeIdentifier,
    base: .type,
    nameForDiagnostics: "type",
    children: [
      Child(
        name: "Name",
        kind: .token(choices: [
          .token(tokenKind: "IdentifierToken"),
          .keyword(text: "self"),
          .keyword(text: "Self"),
          .keyword(text: "Any"),
          .token(tokenKind: "KeywordToken"),
          .token(tokenKind: "WildcardToken"),
        ]),
        classification: "TypeIdentifier"
      ),
      Child(
        name: "GenericArgumentClause",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
    ]
  ),

  // tuple-type-element-list -> tuple-type-element tuple-type-element-list?
  Node(
    kind: .tupleTypeElementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.tupleTypeElement]
  ),

  // tuple-type-element -> identifier? ':'? type-annotation ','?
  Node(
    kind: .tupleTypeElement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "InOut",
        kind: .token(choices: [.keyword(text: "inout")]),
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
        kind: .node(kind: .type)
      ),
      Child(
        name: "Ellipsis",
        kind: .token(choices: [.token(tokenKind: "EllipsisToken")]),
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: .initializerClause),
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
    kind: .tupleType,
    base: .type,
    nameForDiagnostics: "tuple type",
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
        kind: .collection(kind: .tupleTypeElementList, collectionElementName: "Element"),
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

]
