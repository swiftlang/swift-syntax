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

public let GENERIC_NODES: [Node] = [
  Node(
    kind: .conformanceRequirement,
    base: .syntax,
    nameForDiagnostics: "conformance requirement",
    children: [
      Child(
        name: "leftType",
        kind: .node(kind: .type)
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "rightType",
        kind: .node(kind: .type)
      ),
    ],
    childHistory: [
      [
        "leftType": .renamed(from: "leftTypeIdentifier"),
        "rightType": .renamed(from: "rightTypeIdentifier"),
      ]
    ]
  ),

  Node(
    kind: .genericParameterClause,
    base: .syntax,
    nameForDiagnostics: "generic parameter clause",
    documentation: "The parameter clause that defines the generic parameters.",
    parserFunction: "parseGenericParameters",
    children: [
      Child(
        name: "leftAngle",
        kind: .token(choices: [.token(.leftAngle)]),
        documentation: "The opening angle bracket (`<`) of the generic parameter clause."
      ),
      Child(
        name: "parameters",
        kind: .collection(
          kind: .genericParameterList,
          collectionElementName: "Parameter",
          deprecatedCollectionElementName: "GenericParameter"
        ),
        documentation: "The list of generic parameters in the clause."
      ),
      Child(
        name: "genericWhereClause",
        kind: .node(kind: .genericWhereClause),
        documentation:
          "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
        isOptional: true
      ),
      Child(
        name: "rightAngle",
        kind: .token(choices: [.token(.rightAngle)]),
        documentation: "The closing angle bracket (`>`) of the generic parameter clause."
      ),
    ],
    childHistory: [
      [
        "leftAngle": .renamed(from: "leftAngleBracket"),
        "parameters": .renamed(from: "genericParameterList"),
        "rightAngle": .renamed(from: "rightAngleBracket"),
      ]
    ]
  ),

  Node(
    kind: .genericParameterList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.genericParameter]
  ),

  Node(
    kind: .genericParameter,
    base: .syntax,
    nameForDiagnostics: "generic parameter",
    traits: [
      "WithTrailingComma",
      "WithAttributes",
    ],
    children: [
      Child(
        name: "attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute", defaultsToEmpty: true)
      ),
      Child(
        name: "specifier",
        kind: .token(choices: [
          .keyword(.each),
          .keyword(.let),
        ]),
        nameForDiagnostics: "specifier",
        isOptional: true
      ),
      Child(
        name: "name",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        isOptional: true
      ),
      Child(
        name: "inheritedType",
        kind: .node(kind: .type),
        nameForDiagnostics: "inherited type",
        isOptional: true
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ],
    childHistory: [
      [
        "specifier": .renamed(from: "eachKeyword")
      ]
    ]
  ),

  Node(
    kind: .genericRequirementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.genericRequirement]
  ),

  Node(
    kind: .genericRequirement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "requirement",
        kind: .nodeChoices(choices: [
          Child(
            name: "sameTypeRequirement",
            kind: .node(kind: .sameTypeRequirement)
          ),
          Child(
            name: "conformanceRequirement",
            kind: .node(kind: .conformanceRequirement)
          ),
          Child(
            name: "layoutRequirement",
            kind: .node(kind: .layoutRequirement)
          ),
        ])
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ],
    childHistory: [
      [
        "requirement": .renamed(from: "body")
      ]
    ]
  ),

  Node(
    kind: .genericWhereClause,
    base: .syntax,
    nameForDiagnostics: "'where' clause",
    documentation:
      "A `where` clause that places additional constraints on generic parameters like `where Element: Hashable`.",
    children: [
      Child(
        name: "whereKeyword",
        kind: .token(choices: [.keyword(.where)]),
        documentation: "The `where` keyword in the clause."
      ),
      Child(
        name: "requirements",
        kind: .collection(kind: .genericRequirementList, collectionElementName: "Requirement"),
        documentation: "The list of requirements in the clause."
      ),
    ],
    childHistory: [
      [
        "requirements": .renamed(from: "requirementList")
      ]
    ]
  ),

  Node(
    kind: .layoutRequirement,
    base: .syntax,
    nameForDiagnostics: "layout requirement",
    children: [
      Child(
        name: "type",
        kind: .node(kind: .type),
        nameForDiagnostics: "constrained type"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "layoutSpecifier",
        kind: .token(choices: [
          .keyword(._Trivial),
          .keyword(._TrivialAtMost),
          .keyword(._UnknownLayout),
          .keyword(._RefCountedObject),
          .keyword(._NativeRefCountedObject),
          .keyword(._Class),
          .keyword(._NativeClass),
          .keyword(._BridgeObject),
          .keyword(._TrivialStride),
        ])
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        isOptional: true
      ),
      Child(
        name: "size",
        kind: .token(choices: [.token(.integerLiteral)]),
        nameForDiagnostics: "size",
        isOptional: true
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
      Child(
        name: "alignment",
        kind: .token(choices: [.token(.integerLiteral)]),
        nameForDiagnostics: "alignment",
        isOptional: true
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        isOptional: true
      ),
    ],
    childHistory: [
      [
        "type": .renamed(from: "typeIdentifier"),
        "layoutSpecifier": .renamed(from: "layoutConstraint"),
      ]
    ]
  ),

  Node(
    kind: .primaryAssociatedTypeClause,
    base: .syntax,
    nameForDiagnostics: "primary associated type clause",
    children: [
      Child(
        name: "leftAngle",
        kind: .token(choices: [.token(.leftAngle)])
      ),
      Child(
        name: "primaryAssociatedTypes",
        kind: .collection(kind: .primaryAssociatedTypeList, collectionElementName: "PrimaryAssociatedType")
      ),
      Child(
        name: "rightAngle",
        kind: .token(choices: [.token(.rightAngle)])
      ),
    ],
    childHistory: [
      [
        "leftAngle": .renamed(from: "leftAngleBracket"),
        "primaryAssociatedTypes": .renamed(from: "primaryAssociatedTypeList"),
        "rightAngle": .renamed(from: "rightAngleBracket"),
      ]
    ]
  ),

  Node(
    kind: .primaryAssociatedTypeList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.primaryAssociatedType]
  ),

  Node(
    kind: .primaryAssociatedType,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "name",
        kind: .token(choices: [.token(.identifier)]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .sameTypeRequirement,
    base: .syntax,
    nameForDiagnostics: "same type requirement",
    children: [
      Child(
        name: "leftType",
        kind: .nodeChoices(choices: [
          Child(
            name: "type",
            kind: .node(kind: .type)
          ),
          Child(
            name: "expr",
            kind: .node(kind: .expr),
            experimentalFeature: .valueGenerics
          ),
        ]),
        nameForDiagnostics: "left-hand type",
        documentation:
          "The left hand side type for a same type requirement. This can either be a regular type argument or an expression for value generics."
      ),
      Child(
        name: "equal",
        kind: .token(choices: [.token(.binaryOperator), .token(.prefixOperator), .token(.postfixOperator)])
      ),
      Child(
        name: "rightType",
        kind: .nodeChoices(choices: [
          Child(
            name: "type",
            kind: .node(kind: .type)
          ),
          Child(
            name: "expr",
            kind: .node(kind: .expr),
            experimentalFeature: .valueGenerics
          ),
        ]),
        nameForDiagnostics: "right-hand type",
        documentation:
          "The right hand side type for a same type requirement. This can either be a regular type argument or an expression for value generics."
      ),
    ],
    childHistory: [
      [
        "leftType": .renamed(from: "leftTypeIdentifier"),
        "equal": .renamed(from: "equalityToken"),
        "rightType": .renamed(from: "rightTypeIdentifier"),
      ]
    ]
  ),

]
