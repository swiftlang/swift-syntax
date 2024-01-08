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

public let ATTRIBUTE_NODES: [Node] = [
  Node(
    kind: .attributeList,
    base: .syntaxCollection,
    nameForDiagnostics: "attributes",
    documentation: """
      A list of attributes that can be attached to a declaration.

      An element in this collection can either be an attribute itself or an ``IfConfigDeclSyntax``
      that contains attributes. This is because attributes can be added conditional on compilcation
      conditions, for example.

      ```swift
      #if !DISABLE_DEPRECATIONS
      @available(*, deprecated)
      #endif
      func myFunction() {}
      ```
      """,
    elementChoices: [.attribute, .ifConfigDecl]
  ),

  Node(
    kind: .attribute,
    base: .syntax,
    nameForDiagnostics: "attribute",
    documentation: "An `@` attribute.",
    parserFunction: "parseAttribute",
    children: [
      Child(
        name: "atSign",
        deprecatedName: "atSignToken",
        kind: .token(choices: [.token(.atSign)]),
        documentation: "The `@` sign."
      ),
      Child(
        name: "attributeName",
        kind: .node(kind: .type),
        nameForDiagnostics: "name",
        documentation: "The name of the attribute."
      ),
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)]),
        documentation: "If the attribute takes arguments, the opening parenthesis.",
        isOptional: true
      ),
      Child(
        name: "arguments",
        deprecatedName: "argument",
        kind: .nodeChoices(choices: [
          Child(
            name: "argumentList",
            kind: .node(kind: .labeledExprList)
          ),
          Child(
            name: "token",
            kind: .node(kind: .token)
          ),
          Child(
            name: "string",
            kind: .node(kind: .stringLiteralExpr)
          ),
          Child(
            name: "availability",
            kind: .node(kind: .availabilityArgumentList)
          ),
          Child(
            name: "specializeArguments",
            kind: .node(kind: .specializeAttributeArgumentList)
          ),
          Child(
            name: "objCName",
            kind: .node(kind: .objCSelectorPieceList)
          ),
          Child(
            name: "implementsArguments",
            kind: .node(kind: .implementsAttributeArguments)
          ),
          Child(
            name: "differentiableArguments",
            kind: .node(kind: .differentiableAttributeArguments)
          ),
          Child(
            name: "derivativeRegistrationArguments",
            kind: .node(kind: .derivativeAttributeArguments)
          ),
          Child(
            name: "backDeployedArguments",
            kind: .node(kind: .backDeployedAttributeArguments)
          ),
          Child(
            name: "conventionArguments",
            kind: .node(kind: .conventionAttributeArguments)
          ),
          Child(
            name: "conventionWitnessMethodArguments",
            kind: .node(kind: .conventionWitnessMethodAttributeArguments)
          ),
          Child(
            name: "opaqueReturnTypeOfAttributeArguments",
            kind: .node(kind: .opaqueReturnTypeOfAttributeArguments)
          ),
          Child(
            name: "exposeAttributeArguments",
            kind: .node(kind: .exposeAttributeArguments)
          ),
          Child(
            name: "originallyDefinedInArguments",
            kind: .node(kind: .originallyDefinedInAttributeArguments)
          ),
          Child(
            name: "underscorePrivateAttributeArguments",
            kind: .node(kind: .underscorePrivateAttributeArguments)
          ),
          Child(
            name: "dynamicReplacementArguments",
            kind: .node(kind: .dynamicReplacementAttributeArguments)
          ),
          Child(
            name: "unavailableFromAsyncArguments",
            kind: .node(kind: .unavailableFromAsyncAttributeArguments)
          ),
          Child(
            name: "effectsArguments",
            kind: .node(kind: .effectsAttributeArgumentList)
          ),
          Child(
            name: "documentationArguments",
            kind: .node(kind: .documentationAttributeArgumentList)
          ),
        ]),
        documentation: """
          The arguments of the attribute.

          In case of user-defined attributes, such as macros, property wrappers or result builders,
          this is always either an `argumentList` of type ``LabeledExprListSyntax`` or `nil`.
          """,
        isOptional: true
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)]),
        documentation: "If the attribute takes arguments, the closing parenthesis.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .specializeAvailabilityArgument,
    base: .syntax,
    nameForDiagnostics: "availability entry",
    documentation: "The availability argument for the _specialize attribute",
    children: [
      Child(
        name: "availabilityLabel",
        deprecatedName: "label",
        kind: .token(choices: [.keyword(.availability)]),
        nameForDiagnostics: "label",
        documentation: "The label of the argument"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating the label and the value"
      ),
      Child(
        name: "availabilityArguments",
        deprecatedName: "availabilityList",
        kind: .collection(kind: .availabilityArgumentList, collectionElementName: "AvailabilityArgument", deprecatedCollectionElementName: "Availability")
      ),
      Child(
        name: "semicolon",
        kind: .token(choices: [.token(.semicolon)])
      ),
    ]
  ),

  Node(
    kind: .platformVersionItem,
    base: .syntax,
    nameForDiagnostics: "version",
    documentation: "A single platform/version pair in an attribute, e.g. `iOS 10.1`.",
    traits: ["WithTrailingComma"],
    children: [
      Child(
        name: "platformVersion",
        deprecatedName: "availabilityVersionRestriction",
        kind: .node(kind: .platformVersion)
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "A trailing comma if the argument is followed by another argument",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .platformVersionItemList,
    base: .syntaxCollection,
    nameForDiagnostics: "version list",
    elementChoices: [.platformVersionItem]
  ),

  Node(
    kind: .backDeployedAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "'@backDeployed' arguments",
    documentation: "A collection of arguments for the `@backDeployed` attribute",
    children: [
      Child(
        name: "beforeLabel",
        kind: .token(choices: [.keyword(.before)]),
        documentation: "The \"before\" label."
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating \"before\" and the parameter list."
      ),
      Child(
        name: "platforms",
        deprecatedName: "versionList",
        kind: .collection(kind: .platformVersionItemList, collectionElementName: "Platform", deprecatedCollectionElementName: "Availability"),
        documentation: "The list of OS versions in which the declaration became ABI stable."
      ),
    ]
  ),

  Node(
    kind: .conventionAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@convention(...) arguments",
    documentation: "The arguments for the '@convention(...)'.",
    children: [
      Child(
        name: "conventionLabel",
        kind: .token(choices: [.token(.identifier)]),
        documentation: "The convention label."
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
      Child(
        name: "cTypeLabel",
        kind: .token(choices: [.keyword(.cType)]),
        isOptional: true
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        isOptional: true
      ),
      Child(
        name: "cTypeString",
        kind: .node(kind: .stringLiteralExpr),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .conventionWitnessMethodAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@convention(...) arguments for witness methods",
    documentation: "The arguments for the '@convention(witness_method: ...)'.",
    children: [
      Child(
        name: "witnessMethodLabel",
        kind: .token(choices: [.keyword(.witness_method)])
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "protocolName",
        kind: .token(choices: [.token(.identifier)])
      ),
    ]
  ),

  Node(
    kind: .derivativeAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "attribute arguments",
    documentation:
      "The arguments for the '@derivative(of:)' and '@transpose(of:)' attributes: the 'of:' label, the original declaration name, and an optional differentiability parameter list.",
    children: [
      Child(
        name: "ofLabel",
        kind: .token(choices: [.keyword(.of)]),
        documentation: "The \"of\" label."
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating the \"of\" label and the original declaration name."
      ),
      Child(
        name: "originalDeclName",
        kind: .node(kind: .expr),
        documentation: "The referenced original declaration name."
      ),
      Child(
        name: "period",
        kind: .token(choices: [.token(.period)]),
        documentation: "The period separating the original declaration name and the accessor name.",
        isOptional: true
      ),
      Child(
        name: "accessorSpecifier",
        deprecatedName: "accessorKind",
        kind: .token(choices: [.keyword(.get), .keyword(.set)]),
        documentation: "The accessor name.",
        isOptional: true
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
      Child(
        name: "arguments",
        deprecatedName: "diffParams",
        kind: .node(kind: .differentiabilityWithRespectToArgument),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .differentiabilityArgumentList,
    base: .syntaxCollection,
    nameForDiagnostics: "differentiability parameters",
    elementChoices: [.differentiabilityArgument]
  ),

  Node(
    kind: .differentiabilityArgument,
    base: .syntax,
    nameForDiagnostics: "differentiability argument",
    documentation: "A differentiability argument: either the \"self\" identifier, a function parameter name, or a function parameter index.",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "argument",
        deprecatedName: "parameter",
        kind: .token(choices: [.token(.identifier), .token(.integerLiteral), .keyword(.self)])
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .differentiabilityWithRespectToArgument,
    base: .syntax,
    nameForDiagnostics: "'@differentiable' argument",
    documentation: "A clause containing differentiability parameters.",
    children: [
      Child(
        name: "wrtLabel",
        kind: .token(choices: [.keyword(.wrt)]),
        documentation: "The \"wrt\" label."
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating \"wrt\" and the parameter list."
      ),
      Child(
        name: "arguments",
        deprecatedName: "parameters",
        kind: .nodeChoices(choices: [
          Child(
            name: "argument",
            deprecatedName: "parameter",
            kind: .node(kind: .differentiabilityArgument)
          ),
          Child(
            name: "argumentList",
            deprecatedName: "parameterList",
            kind: .node(kind: .differentiabilityArguments)
          ),
        ]),
        nameForDiagnostics: "arguments"
      ),
    ]
  ),

  Node(
    kind: .differentiabilityArguments,
    base: .syntax,
    nameForDiagnostics: "differentiability arguments",
    documentation: "The differentiability arguments.",
    children: [
      Child(
        name: "leftParen",
        kind: .token(choices: [.token(.leftParen)])
      ),
      Child(
        name: "arguments",
        deprecatedName: "differentiabilityParameters",
        kind: .collection(kind: .differentiabilityArgumentList, collectionElementName: "Argument"),
        documentation: "The parameters for differentiation."
      ),
      Child(
        name: "rightParen",
        kind: .token(choices: [.token(.rightParen)])
      ),
    ]
  ),

  Node(
    kind: .differentiableAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "'@differentiable' arguments",
    documentation:
      "The arguments for the `@differentiable` attribute: an optional differentiability kind, an optional differentiability parameter clause, and an optional 'where' clause.",
    children: [
      Child(
        name: "kindSpecifier",
        deprecatedName: "diffKind",
        kind: .token(choices: [.keyword(._forward), .keyword(.reverse), .keyword(._linear)]),
        isOptional: true
      ),
      Child(
        name: "kindSpecifierComma",
        deprecatedName: "diffKindComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "The comma following the differentiability kind, if it exists.",
        isOptional: true
      ),
      Child(
        name: "arguments",
        deprecatedName: "diffParams",
        kind: .node(kind: .differentiabilityWithRespectToArgument),
        isOptional: true
      ),
      Child(
        name: "argumentsComma",
        deprecatedName: "diffParamsComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "The comma following the differentiability arguments clause, if it exists.",
        isOptional: true
      ),
      Child(
        name: "genericWhereClause",
        deprecatedName: "whereClause",
        kind: .node(kind: .genericWhereClause),
        documentation: "A `where` clause that places additional constraints on generic parameters like `where T: Differentiable`.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .documentationAttributeArgument,
    base: .syntax,
    nameForDiagnostics: "@_documentation argument",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "label",
        kind: .token(choices: [.keyword(.visibility), .keyword(.metadata)]),
        nameForDiagnostics: "label"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "value",
        kind: .nodeChoices(choices: [
          Child(
            name: "token",
            kind: .token(choices: [
              .token(.identifier),
              .keyword(.private),
              .keyword(.fileprivate),
              .keyword(.internal),
              .keyword(.public),
              .keyword(.open),
            ])
          ),
          Child(
            name: "string",
            kind: .node(kind: .stringLiteralExpr)
          ),
        ])
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "A trailing comma if this argument is followed by another one",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .documentationAttributeArgumentList,
    base: .syntaxCollection,
    nameForDiagnostics: "@_documentation arguments",
    documentation: "The arguments of the '@_documentation' attribute",
    elementChoices: [.documentationAttributeArgument]
  ),

  Node(
    kind: .dynamicReplacementAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@_dynamicReplacement argument",
    documentation: "The arguments for the '@_dynamicReplacement' attribute",
    children: [
      Child(
        name: "forLabel",
        kind: .token(choices: [.keyword(.for)], requiresTrailingSpace: false)
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "declName",
        deprecatedName: "declname",
        kind: .node(kind: .declReferenceExpr)
      ),
    ]
  ),

  Node(
    kind: .effectsAttributeArgumentList,
    base: .syntaxCollection,
    nameForDiagnostics: "@_effects arguments",
    documentation: "The arguments of the '@_effects' attribute. These will be parsed during the SIL stage.",
    elementChoices: [.token]
  ),

  Node(
    kind: .exposeAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@_expose arguments",
    documentation: "The arguments for the '@_expose' attribute",
    children: [
      Child(
        name: "language",
        kind: .node(kind: .token)
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)]),
        isOptional: true
      ),
      Child(
        name: "cxxName",
        kind: .node(kind: .stringLiteralExpr),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .implementsAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@_implements arguemnts",
    documentation: "The arguments for the `@_implements` attribute of the form `Type, methodName(arg1Label:arg2Label:)`",
    children: [
      Child(
        name: "type",
        kind: .node(kind: .type),
        nameForDiagnostics: "type",
        documentation: "The type for which the method with this attribute implements a requirement."
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "The comma separating the type and method name"
      ),
      Child(
        name: "declName",
        deprecatedName: "declname",
        kind: .node(kind: .declReferenceExpr),
        nameForDiagnostics: "declaration name",
        documentation: "The value for this argument"
      ),
    ]
  ),

  Node(
    kind: .labeledSpecializeArgument,
    base: .syntax,
    nameForDiagnostics: "attribute argument",
    documentation: "A labeled argument for the `@_specialize` attribute like `exported: true`",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "label",
        kind: .token(choices: [
          .keyword(.target),
          .keyword(.availability),
          .keyword(.exported),
          .keyword(.kind),
          .keyword(.spi),
          .keyword(.spiModule),
        ]),
        nameForDiagnostics: "label",
        documentation: "The label of the argument"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating the label and the value"
      ),
      Child(
        name: "value",
        kind: .node(kind: .token),
        nameForDiagnostics: "value",
        documentation: "The value for this argument"
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "A trailing comma if this argument is followed by another one",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .objCSelectorPiece,
    base: .syntax,
    nameForDiagnostics: "Objective-C selector piece",
    documentation:
      "A piece of an Objective-C selector. Either consisting of just an identifier for a nullary selector, an identifier and a colon for a labeled argument or just a colon for an unlabeled argument",
    children: [
      Child(
        name: "name",
        kind: .node(kind: .token),
        nameForDiagnostics: "name",
        isOptional: true
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .objCSelectorPieceList,
    base: .syntaxCollection,
    nameForDiagnostics: "Objective-C selector",
    elementChoices: [.objCSelectorPiece]
  ),

  Node(
    kind: .opaqueReturnTypeOfAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "opaque return type arguments",
    documentation: "The arguments for the '@_opaqueReturnTypeOf()'.",
    children: [
      Child(
        name: "mangledName",
        kind: .node(kind: .stringLiteralExpr),
        documentation: "The mangled name of a declaration."
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)])
      ),
      Child(
        name: "ordinal",
        kind: .token(choices: [.token(.integerLiteral)]),
        documentation: "The ordinal corresponding to the 'some' keyword that introduced this opaque type."
      ),
    ]
  ),

  Node(
    kind: .originallyDefinedInAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@_originallyDefinedIn arguments",
    documentation: "The arguments for the '@_originallyDefinedIn' attribute",
    children: [
      Child(
        name: "moduleLabel",
        kind: .token(choices: [.keyword(.module)])
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "moduleName",
        kind: .node(kind: .stringLiteralExpr)
      ),
      Child(
        name: "comma",
        kind: .token(choices: [.token(.comma)])
      ),
      Child(
        name: "platforms",
        kind: .collection(kind: .platformVersionItemList, collectionElementName: "Platform")
      ),
    ]
  ),

  Node(
    kind: .specializeAttributeArgumentList,
    base: .syntaxCollection,
    nameForDiagnostics: "argument to '@_specialize",
    documentation: "A collection of arguments for the `@_specialize` attribute",
    elementChoices: [.labeledSpecializeArgument, .specializeAvailabilityArgument, .specializeTargetFunctionArgument, .genericWhereClause]
  ),

  Node(
    kind: .specializeTargetFunctionArgument,
    base: .syntax,
    nameForDiagnostics: "attribute argument",
    documentation: "A labeled argument for the `@_specialize` attribute with a function decl value like `target: myFunc(_:)`",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "targetLabel",
        deprecatedName: "label",
        kind: .token(choices: [.keyword(.target)]),
        nameForDiagnostics: "label",
        documentation: "The label of the argument"
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)]),
        documentation: "The colon separating the label and the value"
      ),
      Child(
        name: "declName",
        deprecatedName: "declname",
        kind: .node(kind: .declReferenceExpr),
        nameForDiagnostics: "declaration name",
        documentation: "The value for this argument"
      ),
      Child(
        name: "trailingComma",
        kind: .token(choices: [.token(.comma)]),
        documentation: "A trailing comma if this argument is followed by another one",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .unavailableFromAsyncAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@_unavailableFromAsync argument",
    documentation: "The arguments for the '@_unavailableFromAsync' attribute",
    children: [
      Child(
        name: "messageLabel",
        kind: .token(choices: [.keyword(.message)])
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "message",
        kind: .node(kind: .stringLiteralExpr)
      ),
    ]
  ),

  Node(
    kind: .underscorePrivateAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@_private argument",
    documentation: "The arguments for the '@_private' attribute",
    children: [
      Child(
        name: "sourceFileLabel",
        kind: .token(choices: [.keyword(.sourceFile)])
      ),
      Child(
        name: "colon",
        kind: .token(choices: [.token(.colon)])
      ),
      Child(
        name: "filename",
        kind: .node(kind: .stringLiteralExpr)
      ),
    ]
  ),

]
