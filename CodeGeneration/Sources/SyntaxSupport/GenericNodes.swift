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
    name: "ConformanceRequirement",
    nameForDiagnostics: "conformance requirement",
    kind: "Syntax",
    children: [
      Child(
        name: "LeftTypeIdentifier",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "RightTypeIdentifier",
        kind: .node(kind: "Type")
      ),
    ]
  ),

  // generic-parameter-clause -> '<' generic-parameter-list generic-where-clause? '>'
  Node(
    name: "GenericParameterClause",
    nameForDiagnostics: "generic parameter clause",
    kind: "Syntax",
    parserFunction: "parseGenericParameters",
    children: [
      Child(
        name: "LeftAngleBracket",
        kind: .token(choices: [.token(tokenKind: "LeftAngleToken")])
      ),
      Child(
        name: "GenericParameterList",
        kind: .collection(kind: "GenericParameterList", collectionElementName: "GenericParameter")
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        isOptional: true
      ),
      Child(
        name: "RightAngleBracket",
        kind: .token(choices: [.token(tokenKind: "RightAngleToken")])
      ),
    ]
  ),

  Node(
    name: "GenericParameterList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "GenericParameter"
  ),

  // generic-parameter -> type-name
  //                    | type-name : type-identifier
  //                    | type-name : protocol-composition-type
  Node(
    name: "GenericParameter",
    nameForDiagnostics: "generic parameter",
    kind: "Syntax",
    traits: [
      "WithTrailingComma",
      "WithAttributes",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
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
        kind: .node(kind: "Type"),
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
    name: "GenericRequirementList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "GenericRequirement",
    elementName: "GenericRequirement"
  ),

  // generic-requirement ->
  //     (same-type-requirement|conformance-requirement|layout-requirement) ','?
  Node(
    name: "GenericRequirement",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Body",
        kind: .nodeChoices(choices: [
          Child(
            name: "SameTypeRequirement",
            kind: .node(kind: "SameTypeRequirement")
          ),
          Child(
            name: "ConformanceRequirement",
            kind: .node(kind: "ConformanceRequirement")
          ),
          Child(
            name: "LayoutRequirement",
            kind: .node(kind: "LayoutRequirement")
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
    name: "GenericWhereClause",
    nameForDiagnostics: "'where' clause",
    kind: "Syntax",
    children: [
      Child(
        name: "WhereKeyword",
        kind: .token(choices: [.keyword(text: "where")])
      ),
      Child(
        name: "RequirementList",
        kind: .collection(kind: "GenericRequirementList", collectionElementName: "Requirement")
      ),
    ]
  ),

  // layout-requirement -> type-name : layout-constraint
  // layout-constraint -> identifier '('? integer-literal? ','? integer-literal? ')'?
  Node(
    name: "LayoutRequirement",
    nameForDiagnostics: "layout requirement",
    kind: "Syntax",
    children: [
      Child(
        name: "TypeIdentifier",
        kind: .node(kind: "Type"),
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
    name: "PrimaryAssociatedTypeClause",
    nameForDiagnostics: "primary associated type clause",
    kind: "Syntax",
    children: [
      Child(
        name: "LeftAngleBracket",
        kind: .token(choices: [.token(tokenKind: "LeftAngleToken")])
      ),
      Child(
        name: "PrimaryAssociatedTypeList",
        kind: .collection(kind: "PrimaryAssociatedTypeList", collectionElementName: "PrimaryAssociatedType")
      ),
      Child(
        name: "RightAngleBracket",
        kind: .token(choices: [.token(tokenKind: "RightAngleToken")])
      ),
    ]
  ),

  Node(
    name: "PrimaryAssociatedTypeList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "PrimaryAssociatedType"
  ),

  // primary-associated-type -> type-name ','?
  Node(
    name: "PrimaryAssociatedType",
    nameForDiagnostics: nil,
    kind: "Syntax",
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
    name: "SameTypeRequirement",
    nameForDiagnostics: "same type requirement",
    kind: "Syntax",
    children: [
      Child(
        name: "LeftTypeIdentifier",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "left-hand type"
      ),
      Child(
        name: "EqualityToken",
        kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "PrefixOperatorToken"), .token(tokenKind: "PostfixOperatorToken")])
      ),
      Child(
        name: "RightTypeIdentifier",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "right-hand type"
      ),
    ]
  ),

]
