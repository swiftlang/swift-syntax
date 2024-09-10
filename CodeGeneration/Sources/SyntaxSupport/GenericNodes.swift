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
    nameForDiagnostics: "conformance requirement",
    children: [
      Child(
        name: "leftType",
        deprecatedName: "leftTypeIdentifier",
        kind: .node(kind: .type)
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "rightType",
        deprecatedName: "rightTypeIdentifier",
        kind: .node(kind: .type)
      ),
    ]
  ),

  Node(
    kind: .genericParameterClause,
    nameForDiagnostics: "generic parameter clause",
    documentation: "The parameter clause that defines the generic parameters.",
    parserFunction: "parseGenericParameters",
    children: [
      Child(
        name: "leftAngle",
        deprecatedName: "leftAngleBracket",
        kind: .token(choices: [.token(.leftAngle)]),
        documentation: "The opening angle bracket (`<`) of the generic parameter clause."
      ),
      Child(
        name: "parameters",
        deprecatedName: "genericParameterList",
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
        deprecatedName: "rightAngleBracket",
        kind: .token(choices: [.token(.rightAngle)]),
        documentation: "The closing angle bracket (`>`) of the generic parameter clause."
      ),
    ]
  ),

  Node(
    kind: .genericParameterList,
    nameForDiagnostics: nil,
    elementChoices: [.genericParameter]
  ),

  Node(
    kind: .genericParameter,
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
        deprecatedName: "eachKeyword",
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
    ]
  ),

  Node(
    kind: .genericRequirementList,
    nameForDiagnostics: nil,
    elementChoices: [.genericRequirement]
  ),

  Node(
    kind: .genericRequirement,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "requirement",
        deprecatedName: "body",
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
    ]
  ),

  Node(
    kind: .genericWhereClause,
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
        deprecatedName: "requirementList",
        kind: .collection(kind: .genericRequirementList, collectionElementName: "Requirement"),
        documentation: "The list of requirements in the clause."
      ),
    ]
  ),

  Node(
    kind: .layoutRequirement,
    nameForDiagnostics: "layout requirement",
    children: [
      Child(
        name: "type",
        deprecatedName: "typeIdentifier",
        kind: .node(kind: .type),
        nameForDiagnostics: "constrained type"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "layoutSpecifier",
        deprecatedName: "layoutConstraint",
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
    ]
  ),

  Node(
    kind: .primaryAssociatedTypeClause,
    nameForDiagnostics: "primary associated type clause",
    children: [
      Child(
        name: "leftAngle",
        deprecatedName: "leftAngleBracket",
        kind: .token(choices: [.token(.leftAngle)])
      ),
      Child(
        name: "primaryAssociatedTypes",
        deprecatedName: "primaryAssociatedTypeList",
        kind: .collection(kind: .primaryAssociatedTypeList, collectionElementName: "PrimaryAssociatedType")
      ),
      Child(
        name: "rightAngle",
        deprecatedName: "rightAngleBracket",
        kind: .token(choices: [.token(.rightAngle)])
      ),
    ]
  ),

  Node(
    kind: .primaryAssociatedTypeList,
    nameForDiagnostics: nil,
    elementChoices: [.primaryAssociatedType]
  ),

  Node(
    kind: .primaryAssociatedType,
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
    nameForDiagnostics: "same type requirement",
    children: [
      Child(
        name: "leftType",
        deprecatedName: "leftTypeIdentifier",
        kind: .node(kind: .type),
        nameForDiagnostics: "left-hand type"
      ),
      Child(
        name: "equal",
        deprecatedName: "equalityToken",
        kind: .token(choices: [.token(.binaryOperator), .token(.prefixOperator), .token(.postfixOperator)])
      ),
      Child(
        name: "rightType",
        deprecatedName: "rightTypeIdentifier",
        kind: .node(kind: .type),
        nameForDiagnostics: "right-hand type"
      ),
    ]
  ),

]
