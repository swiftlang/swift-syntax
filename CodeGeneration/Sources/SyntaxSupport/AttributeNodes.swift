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
    name: "AttributeList",
    nameForDiagnostics: "attributes",
    kind: "SyntaxCollection",
    element: "Syntax",
    elementName: "Attribute",
    elementChoices: ["Attribute", "IfConfigDecl"],
    omitWhenEmpty: true
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
    name: "Attribute",
    nameForDiagnostics: "attribute",
    description: "An `@` attribute.",
    kind: "Syntax",
    parserFunction: "parseAttribute",
    children: [
      Child(
        name: "AtSignToken",
        kind: .token(choices: [.token(tokenKind: "AtSignToken")]),
        description: "The `@` sign."
      ),
      Child(
        name: "AttributeName",
        kind: .node(kind: "Type"),
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
            kind: .node(kind: "TupleExprElementList")
          ),
          Child(
            name: "Token",
            kind: .node(kind: "Token")
          ),
          Child(
            name: "String",
            kind: .node(kind: "StringLiteralExpr")
          ),
          Child(
            name: "Availability",
            kind: .node(kind: "AvailabilitySpecList")
          ),
          Child(
            name: "SpecializeArguments",
            kind: .node(kind: "SpecializeAttributeSpecList")
          ),
          Child(
            name: "ObjCName",
            kind: .node(kind: "ObjCSelector")
          ),
          Child(
            name: "ImplementsArguments",
            kind: .node(kind: "ImplementsAttributeArguments")
          ),
          Child(
            name: "DifferentiableArguments",
            kind: .node(kind: "DifferentiableAttributeArguments")
          ),
          Child(
            name: "DerivativeRegistrationArguments",
            kind: .node(kind: "DerivativeRegistrationAttributeArguments")
          ),
          Child(
            name: "BackDeployedArguments",
            kind: .node(kind: "BackDeployedAttributeSpecList")
          ),
          Child(
            name: "ConventionArguments",
            kind: .node(kind: "ConventionAttributeArguments")
          ),
          Child(
            name: "ConventionWitnessMethodArguments",
            kind: .node(kind: "ConventionWitnessMethodAttributeArguments")
          ),
          Child(
            name: "OpaqueReturnTypeOfAttributeArguments",
            kind: .node(kind: "OpaqueReturnTypeOfAttributeArguments")
          ),
          Child(
            name: "ExposeAttributeArguments",
            kind: .node(kind: "ExposeAttributeArguments")
          ),
          Child(
            name: "OriginallyDefinedInArguments",
            kind: .node(kind: "OriginallyDefinedInArguments")
          ),
          Child(
            name: "UnderscorePrivateAttributeArguments",
            kind: .node(kind: "UnderscorePrivateAttributeArguments")
          ),
          Child(
            name: "DynamicReplacementArguments",
            kind: .node(kind: "DynamicReplacementArguments")
          ),
          Child(
            name: "UnavailableFromAsyncArguments",
            kind: .node(kind: "UnavailableFromAsyncArguments")
          ),
          Child(
            name: "EffectsArguments",
            kind: .node(kind: "EffectsArguments")
          ),
          Child(
            name: "DocumentationArguments",
            kind: .node(kind: "DocumentationAttributeArguments")
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
    name: "AvailabilityEntry",
    nameForDiagnostics: "availability entry",
    description: "The availability argument for the _specialize attribute",
    kind: "Syntax",
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
        kind: .collection(kind: "AvailabilitySpecList", collectionElementName: "Availability")
      ),
      Child(
        name: "Semicolon",
        kind: .token(choices: [.token(tokenKind: "SemicolonToken")])
      ),
    ]
  ),

  // back-deploy-version-entry -> availability-version-restriction ','?
  Node(
    name: "AvailabilityVersionRestrictionListEntry",
    nameForDiagnostics: "version",
    description: "A single platform/version pair in an attribute, e.g. `iOS 10.1`.",
    kind: "Syntax",
    traits: ["WithTrailingComma"],
    children: [
      Child(
        name: "AvailabilityVersionRestriction",
        kind: .node(kind: "AvailabilityVersionRestriction"),
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
    name: "AvailabilityVersionRestrictionList",
    nameForDiagnostics: "version list",
    kind: "SyntaxCollection",
    element: "AvailabilityVersionRestrictionListEntry"
  ),

  // The arguments of '@backDeployed(...)'
  // back-deployed-attr-spec-list -> 'before' ':' back-deployed-version-list
  Node(
    name: "BackDeployedAttributeSpecList",
    nameForDiagnostics: "'@backDeployed' arguments",
    description: "A collection of arguments for the `@backDeployed` attribute",
    kind: "Syntax",
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
        kind: .collection(kind: "AvailabilityVersionRestrictionList", collectionElementName: "Availability"),
        description: "The list of OS versions in which the declaration became ABI stable."
      ),
    ]
  ),

  // convention-attribute-arguments -> token ',' 'cType'? ':' string-literal
  Node(
    name: "ConventionAttributeArguments",
    nameForDiagnostics: "@convention(...) arguments",
    description: "The arguments for the '@convention(...)'.",
    kind: "Syntax",
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
        kind: .node(kind: "StringLiteralExpr"),
        isOptional: true
      ),
    ]
  ),

  // convention-attribute-arguments -> 'witness_method' ':' identifier
  Node(
    name: "ConventionWitnessMethodAttributeArguments",
    nameForDiagnostics: "@convention(...) arguments for witness methods",
    description: "The arguments for the '@convention(witness_method: ...)'.",
    kind: "Syntax",
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
    name: "DeclName",
    nameForDiagnostics: "declaration name",
    kind: "Syntax",
    children: [
      Child(
        name: "DeclBaseName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "BinaryOperatorToken"), .keyword(text: "init"), .keyword(text: "self"), .keyword(text: "Self")]),
        nameForDiagnostics: "base name",
        description: "The base name of the protocol's requirement."
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: "DeclNameArguments"),
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
    name: "DerivativeRegistrationAttributeArguments",
    nameForDiagnostics: "attribute arguments",
    description: "The arguments for the '@derivative(of:)' and '@transpose(of:)' attributes: the 'of:' label, the original declaration name, and an optional differentiability parameter list.",
    kind: "Syntax",
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
        kind: .node(kind: "QualifiedDeclName"),
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
        kind: .node(kind: "DifferentiabilityParamsClause"),
        isOptional: true
      ),
    ]
  ),

  // differentiability-param-list ->
  //     differentiability-param differentiability-param-list?
  Node(
    name: "DifferentiabilityParamList",
    nameForDiagnostics: "differentiability parameters",
    kind: "SyntaxCollection",
    element: "DifferentiabilityParam"
  ),

  // differentiability-param -> ('self' | identifier | integer-literal) ','?
  Node(
    name: "DifferentiabilityParam",
    nameForDiagnostics: "differentiability parameter",
    description: "A differentiability parameter: either the \"self\" identifier, a function parameter name, or a function parameter index.",
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Parameter",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "IntegerLiteralToken"), .token(tokenKind: "KeywordToken")])
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
    name: "DifferentiabilityParamsClause",
    nameForDiagnostics: "'@differentiable' argument",
    description: "A clause containing differentiability parameters.",
    kind: "Syntax",
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
            kind: .node(kind: "DifferentiabilityParam")
          ),
          Child(
            name: "ParameterList",
            kind: .node(kind: "DifferentiabilityParams")
          ),
        ]),
        nameForDiagnostics: "parameters"
      ),
    ]
  ),

  // differentiability-params -> '(' differentiability-param-list ')'
  Node(
    name: "DifferentiabilityParams",
    nameForDiagnostics: "differentiability parameters",
    description: "The differentiability parameters.",
    kind: "Syntax",
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "DiffParams",
        kind: .collection(kind: "DifferentiabilityParamList", collectionElementName: "DifferentiabilityParam"),
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
    name: "DifferentiableAttributeArguments",
    nameForDiagnostics: "'@differentiable' arguments",
    description: "The arguments for the `@differentiable` attribute: an optional differentiability kind, an optional differentiability parameter clause, and an optional 'where' clause.",
    kind: "Syntax",
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
        kind: .node(kind: "DifferentiabilityParamsClause"),
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
        kind: .node(kind: "GenericWhereClause"),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "DocumentationAttributeArgument",
    nameForDiagnostics: "@_documentation argument",
    kind: "Syntax",
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
            kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "KeywordToken")])
          ),  // Keywords can be: public, internal, private, fileprivate, open
          Child(
            name: "String",
            kind: .node(kind: "StringLiteralExpr")
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
    name: "DocumentationAttributeArguments",
    nameForDiagnostics: "@_documentation arguments",
    description: "The arguments of the '@_documentation' attribute",
    kind: "SyntaxCollection",
    element: "DocumentationAttributeArgument"
  ),

  Node(
    name: "DynamicReplacementArguments",
    nameForDiagnostics: "@_dynamicReplacement argument",
    description: "The arguments for the '@_dynamicReplacement' attribute",
    kind: "Syntax",
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
        kind: .node(kind: "DeclName")
      ),
    ]
  ),

  Node(
    name: "EffectsArguments",
    nameForDiagnostics: "@_effects arguments",
    description: "The arguments of the '@_effect' attribute. These will be parsed during the SIL stage.",
    kind: "SyntaxCollection",
    element: "Token"
  ),

  Node(
    name: "ExposeAttributeArguments",
    nameForDiagnostics: "@_expose arguments",
    description: "The arguments for the '@_expose' attribute",
    kind: "Syntax",
    children: [
      Child(
        name: "Language",
        kind: .node(kind: "Token")
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
      Child(
        name: "CxxName",
        kind: .node(kind: "StringLiteralExpr"),
        isOptional: true
      ),
    ]
  ),

  // The argument of '@_implements(...)'
  // implements-attr-arguments -> simple-type-identifier ','
  //                              (identifier | operator) decl-name-arguments
  Node(
    name: "ImplementsAttributeArguments",
    nameForDiagnostics: "@_implements arguemnts",
    description: "The arguments for the `@_implements` attribute of the form `Type, methodName(arg1Label:arg2Label:)`",
    kind: "Syntax",
    children: [
      Child(
        name: "Type",
        kind: .node(kind: "Type"),
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
        kind: .node(kind: "Token"),
        nameForDiagnostics: "declaration base name",
        description: "The base name of the protocol's requirement."
      ),
      Child(
        name: "DeclNameArguments",
        kind: .node(kind: "DeclNameArguments"),
        nameForDiagnostics: "declaration name arguments",
        description: "The argument labels of the protocol's requirement if it is a function requirement.",
        isOptional: true
      ),
    ]
  ),

  // Representation of e.g. 'exported: true,'
  // labeled-specialize-entry -> identifier ':' token ','?
  Node(
    name: "LabeledSpecializeEntry",
    nameForDiagnostics: "attribute argument",
    description: "A labeled argument for the `@_specialize` attribute like `exported: true`",
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Label",
        kind: .node(kind: "Token"),
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
        kind: .node(kind: "Token"),
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
    name: "ObjCSelectorPiece",
    nameForDiagnostics: "Objective-C selector piece",
    description: "A piece of an Objective-C selector. Either consisting of just an identifier for a nullary selector, an identifier and a colon for a labeled argument or just a colon for an unlabeled argument",
    kind: "Syntax",
    children: [
      Child(
        name: "Name",
        kind: .node(kind: "Token"),
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
    name: "ObjCSelector",
    nameForDiagnostics: "Objective-C selector",
    kind: "SyntaxCollection",
    element: "ObjCSelectorPiece"
  ),

  // opaque-return-type-of-arguments -> string-literal ',' integer-literal
  Node(
    name: "OpaqueReturnTypeOfAttributeArguments",
    nameForDiagnostics: "opaque return type arguments",
    description: "The arguments for the '@_opaqueReturnTypeOf()'.",
    kind: "Syntax",
    children: [
      Child(
        name: "MangledName",
        kind: .node(kind: "StringLiteralExpr"),
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
    name: "OriginallyDefinedInArguments",
    nameForDiagnostics: "@_originallyDefinedIn arguments",
    description: "The arguments for the '@_originallyDefinedIn' attribute",
    kind: "Syntax",
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
        kind: .node(kind: "StringLiteralExpr")
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")])
      ),
      Child(
        name: "Platforms",
        kind: .collection(kind: "AvailabilityVersionRestrictionList", collectionElementName: "Platform")
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
    name: "QualifiedDeclName",
    nameForDiagnostics: "declaration name",
    description: "An optionally qualified function declaration name (e.g. `+(_:_:)`, `A.B.C.foo(_:_:)`).",
    kind: "Syntax",
    children: [
      Child(
        name: "BaseType",
        kind: .node(kind: "Type"),
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
        kind: .node(kind: "DeclNameArguments"),
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
    name: "SpecializeAttributeSpecList",
    nameForDiagnostics: "argument to '@_specialize",
    description: "A collection of arguments for the `@_specialize` attribute",
    kind: "SyntaxCollection",
    element: "Syntax",
    elementName: "SpecializeAttribute",
    elementChoices: ["LabeledSpecializeEntry", "AvailabilityEntry", "TargetFunctionEntry", "GenericWhereClause"]
  ),

  // Representation of e.g. 'exported: true,'
  // labeled-specialize-entry -> identifier ':' token ','?
  Node(
    name: "TargetFunctionEntry",
    nameForDiagnostics: "attribute argument",
    description: "A labeled argument for the `@_specialize` attribute with a function decl value like `target: myFunc(_:)`",
    kind: "Syntax",
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
        kind: .node(kind: "DeclName"),
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
    name: "UnavailableFromAsyncArguments",
    nameForDiagnostics: "@_unavailableFromAsync argument",
    description: "The arguments for the '@_unavailableFromAsync' attribute",
    kind: "Syntax",
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
        kind: .node(kind: "StringLiteralExpr")
      ),
    ]
  ),

  Node(
    name: "UnderscorePrivateAttributeArguments",
    nameForDiagnostics: "@_private argument",
    description: "The arguments for the '@_private' attribute",
    kind: "Syntax",
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
        kind: .node(kind: "StringLiteralExpr")
      ),
    ]
  ),

]
