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
  // attribute-list -> attribute attribute-list?
  Node(
    kind: .attributeList,
    base: .syntaxCollection,
    nameForDiagnostics: "attributes",
    elementChoices: [.attribute, .ifConfigDecl]
  ),

  // attribute -> '@' identifier '('?
  //              ( identifier
  //                | string-literal
  //                | integer-literal
  //                | availability-spec-list
  //                | specialize-attr-spec-list
  //                | implements-attr-arguments
  //                | named-attribute-string-argument
  //                | back-deploy-attr-spec-list
  //              )? ')'?
  Node(
    kind: .attribute,
    base: .syntax,
    nameForDiagnostics: "attribute",
    documentation: "An `@` attribute.",
    parserFunction: "parseAttribute",
    children: [
      Child(
        name: "AtSignToken",
        kind: .token(choices: [.token(tokenKind: "AtSignToken")]),
        description: "The `@` sign."
      ),
      Child(
        name: "AttributeName",
        kind: .node(kind: .type),
        nameForDiagnostics: "name",
        description: "The name of the attribute.",
        classification: "Attribute"
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        description: "If the attribute takes arguments, the opening parenthesis.",
        isOptional: true
      ),
      Child(
        name: "Argument",
        kind: .nodeChoices(choices: [
          Child(
            name: "ArgumentList",
            kind: .node(kind: .tupleExprElementList)
          ),
          Child(
            name: "Token",
            kind: .node(kind: .token)
          ),
          Child(
            name: "String",
            kind: .node(kind: .stringLiteralExpr)
          ),
          Child(
            name: "Availability",
            kind: .node(kind: .availabilitySpecList)
          ),
          Child(
            name: "SpecializeArguments",
            kind: .node(kind: .specializeAttributeSpecList)
          ),
          Child(
            name: "ObjCName",
            kind: .node(kind: .objCSelector)
          ),
          Child(
            name: "ImplementsArguments",
            kind: .node(kind: .implementsAttributeArguments)
          ),
          Child(
            name: "DifferentiableArguments",
            kind: .node(kind: .differentiableAttributeArguments)
          ),
          Child(
            name: "DerivativeRegistrationArguments",
            kind: .node(kind: .derivativeRegistrationAttributeArguments)
          ),
          Child(
            name: "BackDeployedArguments",
            kind: .node(kind: .backDeployedAttributeSpecList)
          ),
          Child(
            name: "ConventionArguments",
            kind: .node(kind: .conventionAttributeArguments)
          ),
          Child(
            name: "ConventionWitnessMethodArguments",
            kind: .node(kind: .conventionWitnessMethodAttributeArguments)
          ),
          Child(
            name: "OpaqueReturnTypeOfAttributeArguments",
            kind: .node(kind: .opaqueReturnTypeOfAttributeArguments)
          ),
          Child(
            name: "ExposeAttributeArguments",
            kind: .node(kind: .exposeAttributeArguments)
          ),
          Child(
            name: "OriginallyDefinedInArguments",
            kind: .node(kind: .originallyDefinedInArguments)
          ),
          Child(
            name: "UnderscorePrivateAttributeArguments",
            kind: .node(kind: .underscorePrivateAttributeArguments)
          ),
          Child(
            name: "DynamicReplacementArguments",
            kind: .node(kind: .dynamicReplacementArguments)
          ),
          Child(
            name: "UnavailableFromAsyncArguments",
            kind: .node(kind: .unavailableFromAsyncArguments)
          ),
          Child(
            name: "EffectsArguments",
            kind: .node(kind: .effectsArguments)
          ),
          Child(
            name: "DocumentationArguments",
            kind: .node(kind: .documentationAttributeArguments)
          ),
        ]),
        description: "The arguments of the attribute. In case the attribute takes multiple arguments, they are gather in the appropriate takes first.",
        isOptional: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        description: "If the attribute takes arguments, the closing parenthesis.",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .availabilityEntry,
    base: .syntax,
    nameForDiagnostics: "availability entry",
    documentation: "The availability argument for the _specialize attribute",
    children: [
      Child(
        name: "Label",
        kind: .token(choices: [.keyword(text: "availability")]),
        nameForDiagnostics: "label",
        description: "The label of the argument"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "The colon separating the label and the value"
      ),
      Child(
        name: "AvailabilityList",
        kind: .collection(kind: .availabilitySpecList, collectionElementName: "Availability")
      ),
      Child(
        name: "Semicolon",
        kind: .token(choices: [.token(tokenKind: "SemicolonToken")])
      ),
    ]
  ),

  // back-deploy-version-entry -> availability-version-restriction ','?
  Node(
    kind: .availabilityVersionRestrictionListEntry,
    base: .syntax,
    nameForDiagnostics: "version",
    documentation: "A single platform/version pair in an attribute, e.g. `iOS 10.1`.",
    children: [
      Child(
        name: "AvailabilityVersionRestriction",
        kind: .node(kind: .availabilityVersionRestriction),
        classification: "Keyword"
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "A trailing comma if the argument is followed by another argument",
        isOptional: true
      ),
    ]
  ),

  // back-deploy-version-list ->
  //   back-deploy-version-entry back-deploy-version-list?
  Node(
    kind: .availabilityVersionRestrictionList,
    base: .syntaxCollection,
    nameForDiagnostics: "version list",
    elementChoices: [.availabilityVersionRestrictionListEntry]
  ),

  // The arguments of '@backDeployed(...)'
  // back-deployed-attr-spec-list -> 'before' ':' back-deployed-version-list
  Node(
    kind: .backDeployedAttributeSpecList,
    base: .syntax,
    nameForDiagnostics: "'@backDeployed' arguments",
    documentation: "A collection of arguments for the `@backDeployed` attribute",
    children: [
      Child(
        name: "BeforeLabel",
        kind: .token(choices: [.keyword(text: "before")]),
        description: "The \"before\" label."
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "The colon separating \"before\" and the parameter list."
      ),
      Child(
        name: "VersionList",
        kind: .collection(kind: .availabilityVersionRestrictionList, collectionElementName: "Availability"),
        description: "The list of OS versions in which the declaration became ABI stable."
      ),
    ]
  ),

  // convention-attribute-arguments -> token ',' 'cType'? ':' string-literal
  Node(
    kind: .conventionAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@convention(...) arguments",
    documentation: "The arguments for the '@convention(...)'.",
    children: [
      Child(
        name: "ConventionLabel",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        description: "The convention label."
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
      Child(
        name: "CTypeLabel",
        kind: .token(choices: [.keyword(text: "cType")]),
        isOptional: true
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        isOptional: true
      ),
      Child(
        name: "CTypeString",
        kind: .node(kind: .stringLiteralExpr),
        isOptional: true
      ),
    ]
  ),

  // convention-attribute-arguments -> 'witness_method' ':' identifier
  Node(
    kind: .conventionWitnessMethodAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@convention(...) arguments for witness methods",
    documentation: "The arguments for the '@convention(witness_method: ...)'.",
    children: [
      Child(
        name: "WitnessMethodLabel",
        kind: .token(choices: [.keyword(text: "witness_method")])
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "ProtocolName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
    ]
  ),

  Node(
    kind: .declName,
    base: .syntax,
    nameForDiagnostics: "declaration name",
    children: [
      Child(
        name: "DeclBaseName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "BinaryOperatorToken"), .keyword(text: "init"), .keyword(text: "self"), .keyword(text: "Self")]),
        nameForDiagnostics: "base name",
        description: "The base name of the protocol's requirement."
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: .declNameArguments),
        nameForDiagnostics: "arguments",
        description: "The argument labels of the protocol's requirement if it is a function requirement.",
        isOptional: true
      ),
    ]
  ),

  // The argument of the derivative registration attribute
  // '@derivative(of: ...)' and the transpose registration attribute
  // '@transpose(of: ...)'.
  //
  // derivative-registration-attr-arguments ->
  //     'of' ':' func-decl-name ','? differentiability-params-clause?
  Node(
    kind: .derivativeRegistrationAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "attribute arguments",
    documentation: "The arguments for the '@derivative(of:)' and '@transpose(of:)' attributes: the 'of:' label, the original declaration name, and an optional differentiability parameter list.",
    children: [
      Child(
        name: "OfLabel",
        kind: .token(choices: [.keyword(text: "of")]),
        description: "The \"of\" label."
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "The colon separating the \"of\" label and the original declaration name."
      ),
      Child(
        name: "OriginalDeclName",
        kind: .node(kind: .qualifiedDeclName),
        description: "The referenced original declaration name."
      ),
      Child(
        name: "Period",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")]),
        description: "The period separating the original declaration name and the accessor name.",
        isOptional: true
      ),
      Child(
        name: "AccessorKind",
        kind: .token(choices: [.keyword(text: "get"), .keyword(text: "set")]),
        description: "The accessor name.",
        isOptional: true
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
      Child(
        name: "DiffParams",
        kind: .node(kind: .differentiabilityParamsClause),
        isOptional: true
      ),
    ]
  ),

  // differentiability-param-list ->
  //     differentiability-param differentiability-param-list?
  Node(
    kind: .differentiabilityParamList,
    base: .syntaxCollection,
    nameForDiagnostics: "differentiability parameters",
    elementChoices: [.differentiabilityParam]
  ),

  // differentiability-param -> ('self' | identifier | integer-literal) ','?
  Node(
    kind: .differentiabilityParam,
    base: .syntax,
    nameForDiagnostics: "differentiability parameter",
    documentation: "A differentiability parameter: either the \"self\" identifier, a function parameter name, or a function parameter index.",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Parameter",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "IntegerLiteralToken"), .keyword(text: "self")])
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  // differentiability-params-clause ->
  //     'wrt' ':' (differentiability-param | differentiability-params)
  Node(
    kind: .differentiabilityParamsClause,
    base: .syntax,
    nameForDiagnostics: "'@differentiable' argument",
    documentation: "A clause containing differentiability parameters.",
    children: [
      Child(
        name: "WrtLabel",
        kind: .token(choices: [.keyword(text: "wrt")]),
        description: "The \"wrt\" label."
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "The colon separating \"wrt\" and the parameter list."
      ),
      Child(
        name: "Parameters",
        kind: .nodeChoices(choices: [
          Child(
            name: "Parameter",
            kind: .node(kind: .differentiabilityParam)
          ),
          Child(
            name: "ParameterList",
            kind: .node(kind: .differentiabilityParams)
          ),
        ]),
        nameForDiagnostics: "parameters"
      ),
    ]
  ),

  // differentiability-params -> '(' differentiability-param-list ')'
  Node(
    kind: .differentiabilityParams,
    base: .syntax,
    nameForDiagnostics: "differentiability parameters",
    documentation: "The differentiability parameters.",
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "DiffParams",
        kind: .collection(kind: .differentiabilityParamList, collectionElementName: "DifferentiabilityParam"),
        description: "The parameters for differentiation."
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  // The argument of '@differentiable(...)'.
  // differentiable-attr-arguments ->
  //     differentiability-kind? '.'? differentiability-params-clause? ','?
  //     generic-where-clause?
  Node(
    kind: .differentiableAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "'@differentiable' arguments",
    documentation: "The arguments for the `@differentiable` attribute: an optional differentiability kind, an optional differentiability parameter clause, and an optional 'where' clause.",
    children: [
      Child(
        name: "DiffKind",
        kind: .token(choices: [.keyword(text: "_forward"), .keyword(text: "reverse"), .keyword(text: "_linear")]),
        isOptional: true
      ),
      Child(
        name: "DiffKindComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "The comma following the differentiability kind, if it exists.",
        isOptional: true
      ),
      Child(
        name: "DiffParams",
        kind: .node(kind: .differentiabilityParamsClause),
        isOptional: true
      ),
      Child(
        name: "DiffParamsComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "The comma following the differentiability parameters clause, if it exists.",
        isOptional: true
      ),
      Child(
        name: "WhereClause",
        kind: .node(kind: .genericWhereClause),
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
        name: "Label",
        kind: .token(choices: [.keyword(text: "visibility"), .keyword(text: "metadata")]),
        nameForDiagnostics: "label"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Value",
        kind: .nodeChoices(choices: [
          Child(
            name: "Token",
            kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .keyword(text: "private"), .keyword(text: "fileprivate"), .keyword(text: "internal"), .keyword(text: "public"), .keyword(text: "open")])
          ),  // Keywords can be: public, internal, private, fileprivate, open
          Child(
            name: "String",
            kind: .node(kind: .stringLiteralExpr)
          ),
        ])
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "A trailing comma if this argument is followed by another one",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .documentationAttributeArguments,
    base: .syntaxCollection,
    nameForDiagnostics: "@_documentation arguments",
    documentation: "The arguments of the '@_documentation' attribute",
    elementChoices: [.documentationAttributeArgument]
  ),

  Node(
    kind: .dynamicReplacementArguments,
    base: .syntax,
    nameForDiagnostics: "@_dynamicReplacement argument",
    documentation: "The arguments for the '@_dynamicReplacement' attribute",
    children: [
      Child(
        name: "ForLabel",
        kind: .token(choices: [.keyword(text: "for")], requiresTrailingSpace: false)
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Declname",
        kind: .node(kind: .declName)
      ),
    ]
  ),

  Node(
    kind: .effectsArguments,
    base: .syntaxCollection,
    nameForDiagnostics: "@_effects arguments",
    documentation: "The arguments of the '@_effect' attribute. These will be parsed during the SIL stage.",
    elementChoices: [.token]
  ),

  Node(
    kind: .exposeAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@_expose arguments",
    documentation: "The arguments for the '@_expose' attribute",
    children: [
      Child(
        name: "Language",
        kind: .node(kind: .token)
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
      Child(
        name: "CxxName",
        kind: .node(kind: .stringLiteralExpr),
        isOptional: true
      ),
    ]
  ),

  // The argument of '@_implements(...)'
  // implements-attr-arguments -> simple-type-identifier ','
  //                              (identifier | operator) decl-name-arguments
  Node(
    kind: .implementsAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "@_implements arguemnts",
    documentation: "The arguments for the `@_implements` attribute of the form `Type, methodName(arg1Label:arg2Label:)`",
    children: [
      Child(
        name: "Type",
        kind: .node(kind: .type),
        nameForDiagnostics: "type",
        description: "The type for which the method with this attribute implements a requirement."
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "The comma separating the type and method name"
      ),
      Child(
        name: "DeclBaseName",
        kind: .node(kind: .token),
        nameForDiagnostics: "declaration base name",
        description: "The base name of the protocol's requirement."
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: .declNameArguments),
        nameForDiagnostics: "declaration name arguments",
        description: "The argument labels of the protocol's requirement if it is a function requirement.",
        isOptional: true
      ),
    ]
  ),

  // Representation of e.g. 'exported: true,'
  // labeled-specialize-entry -> identifier ':' token ','?
  Node(
    kind: .labeledSpecializeEntry,
    base: .syntax,
    nameForDiagnostics: "attribute argument",
    documentation: "A labeled argument for the `@_specialize` attribute like `exported: true`",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Label",
        kind: .node(kind: .token),
        nameForDiagnostics: "label",
        description: "The label of the argument"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "The colon separating the label and the value"
      ),
      Child(
        name: "Value",
        kind: .node(kind: .token),
        nameForDiagnostics: "value",
        description: "The value for this argument"
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "A trailing comma if this argument is followed by another one",
        isOptional: true
      ),
    ]
  ),

  // objc-selector-piece -> identifier? ':'?
  Node(
    kind: .objCSelectorPiece,
    base: .syntax,
    nameForDiagnostics: "Objective-C selector piece",
    documentation: "A piece of an Objective-C selector. Either consisting of just an identifier for a nullary selector, an identifier and a colon for a labeled argument or just a colon for an unlabeled argument",
    children: [
      Child(
        name: "Name",
        kind: .node(kind: .token),
        nameForDiagnostics: "name",
        isOptional: true
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        isOptional: true
      ),
    ]
  ),

  // objc-selector -> objc-selector-piece objc-selector?
  Node(
    kind: .objCSelector,
    base: .syntaxCollection,
    nameForDiagnostics: "Objective-C selector",
    elementChoices: [.objCSelectorPiece]
  ),

  // opaque-return-type-of-arguments -> string-literal ',' integer-literal
  Node(
    kind: .opaqueReturnTypeOfAttributeArguments,
    base: .syntax,
    nameForDiagnostics: "opaque return type arguments",
    documentation: "The arguments for the '@_opaqueReturnTypeOf()'.",
    children: [
      Child(
        name: "MangledName",
        kind: .node(kind: .stringLiteralExpr),
        description: "The mangled name of a declaration."
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")])
      ),
      Child(
        name: "Ordinal",
        kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
        description: "The ordinal corresponding to the 'some' keyword that introduced this opaque type."
      ),
    ]
  ),

  Node(
    kind: .originallyDefinedInArguments,
    base: .syntax,
    nameForDiagnostics: "@_originallyDefinedIn arguments",
    documentation: "The arguments for the '@_originallyDefinedIn' attribute",
    children: [
      Child(
        name: "ModuleLabel",
        kind: .token(choices: [.keyword(text: "module")])
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "ModuleName",
        kind: .node(kind: .stringLiteralExpr)
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")])
      ),
      Child(
        name: "Platforms",
        kind: .collection(kind: .availabilityVersionRestrictionList, collectionElementName: "Platform")
      ),
    ]
  ),

  // An optionally qualified declaration name.
  // Currently used only for `@derivative` and `@transpose` attribute.
  // TODO(TF-1066): Use module qualified name syntax/parsing instead of custom
  // qualified name syntax/parsing.
  //
  // qualified-decl-name ->
  //     base-type? '.'? (identifier | operator) decl-name-arguments?
  // base-type ->
  //     member-type-identifier | base-type-identifier
  Node(
    kind: .qualifiedDeclName,
    base: .syntax,
    nameForDiagnostics: "declaration name",
    documentation: "An optionally qualified function declaration name (e.g. `+(_:_:)`, `A.B.C.foo(_:_:)`).",
    children: [
      Child(
        name: "BaseType",
        kind: .node(kind: .type),
        nameForDiagnostics: "base type",
        description: "The base type of the qualified name, optionally specified.",
        isOptional: true
      ),
      Child(
        name: "Dot",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")]),
        isOptional: true
      ),
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .keyword(text: "self"), .keyword(text: "Self"), .keyword(text: "init"), .token(tokenKind: "BinaryOperatorToken")]),
        nameForDiagnostics: "base name",
        description: "The base name of the referenced function."
      ),
      Child(
        name: "Arguments",
        kind: .node(kind: .declNameArguments),
        nameForDiagnostics: "arguments",
        description: "The argument labels of the referenced function, optionally specified.",
        isOptional: true
      ),
    ]
  ),

  // The argument of '@_specialize(...)'
  // specialize-attr-spec-list -> labeled-specialize-entry
  //                                  specialize-spec-attr-list?
  //                            | generic-where-clause
  //                                  specialize-spec-attr-list?
  Node(
    kind: .specializeAttributeSpecList,
    base: .syntaxCollection,
    nameForDiagnostics: "argument to '@_specialize",
    documentation: "A collection of arguments for the `@_specialize` attribute",
    elementChoices: [.labeledSpecializeEntry, .availabilityEntry, .targetFunctionEntry, .genericWhereClause]
  ),

  // Representation of e.g. 'exported: true,'
  // labeled-specialize-entry -> identifier ':' token ','?
  Node(
    kind: .targetFunctionEntry,
    base: .syntax,
    nameForDiagnostics: "attribute argument",
    documentation: "A labeled argument for the `@_specialize` attribute with a function decl value like `target: myFunc(_:)`",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Label",
        kind: .token(choices: [.keyword(text: "target")]),
        nameForDiagnostics: "label",
        description: "The label of the argument"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "The colon separating the label and the value"
      ),
      Child(
        name: "Declname",
        kind: .node(kind: .declName),
        nameForDiagnostics: "declaration name",
        description: "The value for this argument"
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "A trailing comma if this argument is followed by another one",
        isOptional: true
      ),
    ]
  ),

  Node(
    kind: .unavailableFromAsyncArguments,
    base: .syntax,
    nameForDiagnostics: "@_unavailableFromAsync argument",
    documentation: "The arguments for the '@_unavailableFromAsync' attribute",
    children: [
      Child(
        name: "MessageLabel",
        kind: .token(choices: [.keyword(text: "message")])
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Message",
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
        name: "SourceFileLabel",
        kind: .token(choices: [.keyword(text: "sourceFile")])
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Filename",
        kind: .node(kind: .stringLiteralExpr)
      ),
    ]
  ),

]
