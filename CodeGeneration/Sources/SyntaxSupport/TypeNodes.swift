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
  Node(
    kind: .arrayType,
    nameForDiagnostics: "array type",
    children: [
      Child(
        name: "leftSquare",
        deprecatedName: "leftSquareBracket",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "element",
        deprecatedName: "elementType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "rightSquare",
        deprecatedName: "rightSquareBracket",
        kind: .token(choices: [.token(.rightSquare)])
      ),
    ]
  ),

  Node(
    kind: .attributedType,
    nameForDiagnostics: "type",
    traits: [
      "WithAttributes"
    ],
    children: [
      Child(
        name: "specifiers",
        kind: .collection(kind: .typeSpecifierList, collectionElementName: "Specifier", defaultsToEmpty: true),
        documentation:
          "A list of specifiers that can be attached to the type, such as `inout`, `isolated`, or `consuming`."
      ),
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true),
        documentation: "A list of attributes that can be attached to the type, such as `@escaping`."
      ),
      Child(
        name: "baseType",
        kind: .node(kind: .type),
        documentation: "The type to with the specifiers and attributes are applied."
      ),
    ]
  ),

  Node(
    kind: .classRestrictionType,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "classKeyword",
        kind: .token(choices: [.keyword(.class)])
      )
    ]
  ),

  Node(
    kind: .compositionTypeElementList,
    nameForDiagnostics: nil,
    elementChoices: [.compositionTypeElement]
  ),

  Node(
    kind: .compositionTypeElement,
    nameForDiagnostics: nil,
    children: [
      Child(
        name: "type",
        kind: .node(kind: .type)
      ),
      Child(
        name: "ampersand",
        kind: .node(kind: .token),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .compositionType,
    nameForDiagnostics: "type composition",
    children: [
      Child(
        name: "elements",
        kind: .collection(kind: .compositionTypeElementList, collectionElementName: "Element")
      )
    ]
  ),

  Node(
    kind: .someOrAnyType,
    nameForDiagnostics: "type",
    children: [
      Child(
        name: "someOrAnySpecifier",
        kind: .token(choices: [.keyword(.some), .keyword(.any)])
      ),
      Child(
        name: "constraint",
        deprecatedName: "baseType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .dictionaryType,
    nameForDiagnostics: "dictionary type",
    children: [
      Child(
        name: "leftSquare",
        deprecatedName: "leftSquareBracket",
        kind: .token(choices: [.token(.leftSquare)])
      ),
      Child(
        name: "key",
        deprecatedName: "keyType",
        kind: .node(kind: .type),
        nameForDiagnostics: "key type"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "value",
        deprecatedName: "valueType",
        kind: .node(kind: .type),
        nameForDiagnostics: "value type"
      ),
      Child(
        name: "rightSquare",
        deprecatedName: "rightSquareBracket",
        kind: .token(choices: [.token(.rightSquare)])
      ),
    ]
  ),

  Node(
    kind: .functionType,
    nameForDiagnostics: "function type",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "parameters",
        deprecatedName: "arguments",
        kind: .collection(
          kind: .tupleTypeElementList,
          collectionElementName: "Parameter",
          deprecatedCollectionElementName: "Argument"
        )
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
      Child(
        name: "effectSpecifiers",
        kind: .node(kind: .typeEffectSpecifiers),
        isOptional: true
      ),
      Child(
        name: "returnClause",
        deprecatedName: "output",
        kind: .node(kind: .returnClause)
      ),
    ]
  ),

  Node(
    kind: .genericArgumentClause,
    nameForDiagnostics: "generic argument clause",
    children: [
      Child(
        name: "leftAngle",
        deprecatedName: "leftAngleBracket",
        kind: .token(choices: [.token(.leftAngle)])
      ),
      Child(
        name: "arguments",
        kind: .collection(kind: .genericArgumentList, collectionElementName: "Argument")
      ),
      Child(
        name: "rightAngle",
        deprecatedName: "rightAngleBracket",
        kind: .token(choices: [.token(.rightAngle)])
      ),
    ]
  ),

  Node(
    kind: .genericArgumentList,
    nameForDiagnostics: nil,
    elementChoices: [.genericArgument]
  ),

  Node(
    kind: .genericArgument,
    nameForDiagnostics: "generic argument",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "argument",
        deprecatedName: "argumentType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .implicitlyUnwrappedOptionalType,
    nameForDiagnostics: "implicitly unwrapped optional type",
    children: [
      Child(
        name: "wrappedType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "exclamationMark",
        kind: .token(choices: [.token(.exclamationMark)])
      ),
    ]
  ),

  Node(
    kind: .memberType,
    nameForDiagnostics: "member type",
    children: [
      Child(
        name: "baseType",
        kind: .node(kind: .type),
        nameForDiagnostics: "base type"
      ),
      Child(
        name: "period",
        kind: .token(choices: [.token(.period)])
      ),
      Child(
        name: "name",
        kind: .token(choices: [.token(.identifier), .keyword(.self)]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "genericArgumentClause",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .metatypeType,
    nameForDiagnostics: "metatype",
    children: [
      Child(
        name: "baseType",
        kind: .node(kind: .type),
        nameForDiagnostics: "base type"
      ),
      Child(
        name: "period",
        kind: .token(choices: [.token(.period)])
      ),
      Child(
        name: "metatypeSpecifier",
        deprecatedName: "typeOrProtocol",
        kind: .token(choices: [.keyword(.Type), .keyword(.Protocol)])
      ),
    ]
  ),

  Node(
    kind: .namedOpaqueReturnType,
    nameForDiagnostics: "named opaque return type",
    children: [
      Child(
        name: "genericParameterClause",
        deprecatedName: "genericParameters",
        kind: .node(kind: .genericParameterClause),
        documentation: "The parameter clause that defines the generic parameters."
      ),
      Child(
        name: "type",
        deprecatedName: "baseType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .optionalType,
    nameForDiagnostics: "optional type",
    children: [
      Child(
        name: "wrappedType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "questionMark",
        kind: .token(choices: [.token(.postfixQuestionMark)])
      ),
    ]
  ),

  Node(
    kind: .suppressedType,
    nameForDiagnostics: "suppressed type conformance",
    children: [
      Child(
        name: "withoutTilde",
        kind: .token(choices: [.token(.prefixOperator)])
      ),
      Child(
        name: "type",
        deprecatedName: "patternType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .packExpansionType,
    nameForDiagnostics: "variadic expansion",
    children: [
      Child(
        name: "repeatKeyword",
        kind: .token(choices: [.keyword(.repeat)])
      ),
      Child(
        name: "repetitionPattern",
        deprecatedName: "patternType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .packElementType,
    nameForDiagnostics: "pack element",
    children: [
      Child(
        name: "eachKeyword",
        kind: .token(choices: [.keyword(.each)])
      ),
      Child(
        name: "pack",
        deprecatedName: "packType",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .identifierType,
    nameForDiagnostics: "type",
    children: [
      Child(
        name: "name",
        kind: .token(choices: [
          .token(.identifier),
          .keyword(.Self),
          .keyword(.Any),
          .token(.wildcard),
        ])
      ),
      Child(
        name: "genericArgumentClause",
        kind: .node(kind: .genericArgumentClause),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .tupleTypeElementList,
    nameForDiagnostics: nil,
    elementChoices: [.tupleTypeElement]
  ),

  Node(
    kind: .tupleTypeElement,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "inoutKeyword",
        deprecatedName: "inOut",
        kind: .token(choices: [.keyword(.inout)]),
        isOptional: true
      ),
      Child(
        name: "firstName",
        deprecatedName: "name",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        nameForDiagnostics: "name",
        isOptional: true
      ),
      Child(
        name: "secondName",
        kind: .token(choices: [.token(.identifier), .token(.wildcard)]),
        nameForDiagnostics: "internal name",
        isOptional: true
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        isOptional: true
      ),
      Child(
        name: "type",
        kind: .node(kind: .type)
      ),
      Child(
        name: "ellipsis",
        kind: .token(choices: [.token(.ellipsis)]),
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .tupleType,
    nameForDiagnostics: "tuple type",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "elements",
        kind: .collection(kind: .tupleTypeElementList, collectionElementName: "Element")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .lifetimeSpecifierArgument,
    experimentalFeature: .nonescapableTypes,
    nameForDiagnostics: nil,
    documentation: """
      A single argument that can be added to a lifetime specifier like `borrow`, `mutate`, `consume` or `copy`.

      ### Example
      `data` in `func foo(data: Array<Item>) -> borrow(data) ComplexReferenceType`
      """,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "parameter",
        kind: .token(choices: [.token(.identifier), .keyword(.self), .token(.integerLiteral)]),
        nameForDiagnostics: "parameter reference",
        documentation: """
          The parameter on which the lifetime of this type depends. 

          This can be an identifier referring to an external parameter name, an integer literal to refer to an unnamed
          parameter or `self` if the type's lifetime depends on the object the method is called on.
          """
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .lifetimeSpecifierArgumentList,
    experimentalFeature: .nonescapableTypes,
    nameForDiagnostics: nil,
    elementChoices: [.lifetimeSpecifierArgument]
  ),

  Node(
    kind: .lifetimeTypeSpecifier,
    experimentalFeature: .nonescapableTypes,
    nameForDiagnostics: "lifetime specifier",
    documentation: "A specifier that specifies function parameter on whose lifetime a type depends",
    children: [
      Child(
        name: "dependsOnKeyword",
        kind: .token(choices: [.keyword(.dependsOn)]),
        documentation: "lifetime dependence specifier on the return type"
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "scopedKeyword",
        kind: .token(choices: [.keyword(.scoped)]),
        documentation: "lifetime of return value is scoped to the lifetime of the original value",
        isOptional: true
      ),
      Child(
        name: "arguments",
        kind: .collection(kind: .lifetimeSpecifierArgumentList, collectionElementName: "Arguments")
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .simpleTypeSpecifier,
    nameForDiagnostics: "type specifier",
    documentation: "A specifier that can be attached to a type to eg. mark a parameter as `inout` or `consuming`",
    children: [
      Child(
        name: "specifier",
        kind: .token(choices: [
          .keyword(.inout),
          .keyword(.__shared),
          .keyword(.__owned),
          .keyword(.isolated),
          .keyword(._const),
          .keyword(.borrowing),
          .keyword(.consuming),
          .keyword(.sending),
        ]),
        documentation: "The specifier token that's attached to the type."
      )
    ]
  ),

  Node(
    kind: .typeSpecifierList,
    nameForDiagnostics: nil,
    elementChoices: [.simpleTypeSpecifier, .lifetimeTypeSpecifier]
  ),
]
