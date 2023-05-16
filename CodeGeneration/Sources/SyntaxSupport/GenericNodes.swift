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
  // conformance-requirement -> type-identifier : type-identifier
  Node(
    kind: .conformanceRequirement,
    base: .syntax,
    nameForDiagnostics: "conformance requirement",
    children: [
      Child(
        name: "LeftTypeIdentifier",
        kind: .node(kind: .type)
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "RightTypeIdentifier",
        kind: .node(kind: .type)
      ),
    ]
  ),

  // generic-parameter-clause -> '<' generic-parameter-list generic-where-clause? '>'
  Node(
    kind: .genericParameterClause,
    base: .syntax,
    nameForDiagnostics: "generic parameter clause",
    parserFunction: "parseGenericParameters",
    children: [
      Child(
        name: "LeftAngleBracket",
        kind: .token(choices: [.token(tokenKind: "LeftAngleToken")])
      ),
      Child(
        name: "GenericParameterList",
        kind: .collection(kind: .genericParameterList, collectionElementName: "GenericParameter")
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: .genericWhereClause),
        isOptional: true
      ),
      Child(
        name: "RightAngleBracket",
        kind: .token(choices: [.token(tokenKind: "RightAngleToken")])
      ),
    ]
  ),

  Node(
    kind: .genericParameterList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.genericParameter]
  ),

  // generic-parameter -> type-name
  //                    | type-name : type-identifier
  //                    | type-name : protocol-composition-type
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
        name: "Attributes",
        kind: .collection(kind: .attributeList, collectionElementName: "Attribute"),
        isOptional: true
      ),
      Child(
        name: "Each",
        kind: .token(choices: [.keyword(text: "each")]),
        nameForDiagnostics: "parameter pack specifier",
        isOptional: true
      ),
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        isOptional: true
      ),
      Child(
        name: "InheritedType",
        kind: .node(kind: .type),
        nameForDiagnostics: "inherited type",
        isOptional: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .genericRequirementList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.genericRequirement]
  ),

  // generic-requirement ->
  //     (same-type-requirement|conformance-requirement|layout-requirement) ','?
  Node(
    kind: .genericRequirement,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Body",
        kind: .nodeChoices(choices: [
          Child(
            name: "SameTypeRequirement",
            kind: .node(kind: .sameTypeRequirement)
          ),
          Child(
            name: "ConformanceRequirement",
            kind: .node(kind: .conformanceRequirement)
          ),
          Child(
            name: "LayoutRequirement",
            kind: .node(kind: .layoutRequirement)
          ),
        ])
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  // generic-where-clause -> 'where' requirement-list
  Node(
    kind: .genericWhereClause,
    base: .syntax,
    nameForDiagnostics: "'where' clause",
    children: [
      Child(
        name: "WhereKeyword",
        kind: .token(choices: [.keyword(text: "where")])
      ),
      Child(
        name: "RequirementList",
        kind: .collection(kind: .genericRequirementList, collectionElementName: "Requirement")
      ),
    ]
  ),

  // layout-requirement -> type-name : layout-constraint
  // layout-constraint -> identifier '('? integer-literal? ','? integer-literal? ')'?
  Node(
    kind: .layoutRequirement,
    base: .syntax,
    nameForDiagnostics: "layout requirement",
    children: [
      Child(
        name: "TypeIdentifier",
        kind: .node(kind: .type),
        nameForDiagnostics: "constrained type"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "LayoutConstraint",
        kind: .token(choices: [.keyword(text: "_Trivial"), .keyword(text: "_TrivialAtMost"), .keyword(text: "_UnknownLayout"), .keyword(text: "_RefCountedObject"), .keyword(text: "_NativeRefCountedObject"), .keyword(text: "_Class"), .keyword(text: "_NativeClass")])
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        isOptional: true
      ),
      Child(
        name: "Size",
        kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
        nameForDiagnostics: "size",
        isOptional: true
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
      Child(
        name: "Alignment",
        kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
        nameForDiagnostics: "alignment",
        isOptional: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        isOptional: true
      ),
    ]
  ),

  // primary-associated-type-clause -> '<' primary-associated-type-list '>'
  Node(
    kind: .primaryAssociatedTypeClause,
    base: .syntax,
    nameForDiagnostics: "primary associated type clause",
    children: [
      Child(
        name: "LeftAngleBracket",
        kind: .token(choices: [.token(tokenKind: "LeftAngleToken")])
      ),
      Child(
        name: "PrimaryAssociatedTypeList",
        kind: .collection(kind: .primaryAssociatedTypeList, collectionElementName: "PrimaryAssociatedType")
      ),
      Child(
        name: "RightAngleBracket",
        kind: .token(choices: [.token(tokenKind: "RightAngleToken")])
      ),
    ]
  ),

  Node(
    kind: .primaryAssociatedTypeList,
    base: .syntaxCollection,
    nameForDiagnostics: nil,
    elementChoices: [.primaryAssociatedType]
  ),

  // primary-associated-type -> type-name ','?
  Node(
    kind: .primaryAssociatedType,
    base: .syntax,
    nameForDiagnostics: nil,
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  // same-type-requirement -> type-identifier == type
  Node(
    kind: .sameTypeRequirement,
    base: .syntax,
    nameForDiagnostics: "same type requirement",
    children: [
      Child(
        name: "LeftTypeIdentifier",
        kind: .node(kind: .type),
        nameForDiagnostics: "left-hand type"
      ),
      Child(
        name: "EqualityToken",
        kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "PrefixOperatorToken"), .token(tokenKind: "PostfixOperatorToken")])
      ),
      Child(
        name: "RightTypeIdentifier",
        kind: .node(kind: .type),
        nameForDiagnostics: "right-hand type"
      ),
    ]
  ),

]
