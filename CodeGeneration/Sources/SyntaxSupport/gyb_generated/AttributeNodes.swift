//// Automatically Generated From AttributeNodes.swift.gyb.
//// Do Not Edit Directly!
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public let ATTRIBUTE_NODES: [Node] = [
  Node(name: "TokenList",
       nameForDiagnostics: "token list",
       kind: "SyntaxCollection",
       element: "Token"),

  Node(name: "NonEmptyTokenList",
       nameForDiagnostics: "token list",
       kind: "SyntaxCollection",
       element: "Token",
       omitWhenEmpty: true),

  Node(name: "CustomAttribute",
       nameForDiagnostics: "attribute",
       description: "A custom `@` attribute.",
       kind: "Syntax",
       children: [
         Child(name: "AtSignToken",
               kind: "AtSignToken",
               description: "The `@` sign.",
               tokenChoices: [
                 "AtSign"
               ]),
         Child(name: "AttributeName",
               kind: "Type",
               description: "The name of the attribute.",
               classification: "Attribute"),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               isOptional: true,
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "ArgumentList",
               kind: "TupleExprElementList",
               isOptional: true,
               collectionElementName: "Argument"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               isOptional: true,
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "Attribute",
       nameForDiagnostics: "attribute",
       description: "An `@` attribute.",
       kind: "Syntax",
       children: [
         Child(name: "AtSignToken",
               kind: "AtSignToken",
               description: "The `@` sign.",
               tokenChoices: [
                 "AtSign"
               ]),
         Child(name: "AttributeName",
               kind: "Token",
               description: "The name of the attribute.",
               classification: "Attribute"),
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               description: "If the attribute takes arguments, the opening parenthesis.",
               isOptional: true,
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "Argument",
               kind: "Syntax",
               description: "The arguments of the attribute. In case the attributetakes multiple arguments, they are gather in theappropriate takes first.",
               isOptional: true,
               nodeChoices: [
                 Child(name: "Identifier",
                       kind: "IdentifierToken",
                       tokenChoices: [
                         "Identifier"
                       ]),
                 Child(name: "String",
                       kind: "StringLiteralToken",
                       tokenChoices: [
                         "StringLiteral"
                       ]),
                 Child(name: "Integer",
                       kind: "IntegerLiteralToken",
                       tokenChoices: [
                         "IntegerLiteral"
                       ]),
                 Child(name: "Availability",
                       kind: "AvailabilitySpecList"),
                 Child(name: "SpecializeArguments",
                       kind: "SpecializeAttributeSpecList"),
                 Child(name: "ObjCName",
                       kind: "ObjCSelector"),
                 Child(name: "ImplementsArguments",
                       kind: "ImplementsAttributeArguments"),
                 Child(name: "DifferentiableArguments",
                       kind: "DifferentiableAttributeArguments"),
                 Child(name: "DerivativeRegistrationArguments",
                       kind: "DerivativeRegistrationAttributeArguments"),
                 Child(name: "NamedAttributeString",
                       kind: "NamedAttributeStringArgument"),
                 Child(name: "BackDeployArguments",
                       kind: "BackDeployAttributeSpecList"),
                 Child(name: "ConventionArguments",
                       kind: "ConventionAttributeArguments"),
                 Child(name: "ConventionWitnessMethodArguments",
                       kind: "ConventionWitnessMethodAttributeArguments"),
                 Child(name: "TokenList",
                       kind: "TokenList",
                       collectionElementName: "Token")
               ]),
         Child(name: "RightParen",
               kind: "RightParenToken",
               description: "If the attribute takes arguments, the closing parenthesis.",
               isOptional: true,
               tokenChoices: [
                 "RightParen"
               ]),
         Child(name: "TokenList",
               kind: "TokenList",
               isOptional: true,
               collectionElementName: "Token")
       ]),

  Node(name: "AttributeList",
       nameForDiagnostics: "attributes",
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "Attribute",
       elementChoices: ["Attribute", "CustomAttribute"],
       omitWhenEmpty: true),

  Node(name: "SpecializeAttributeSpecList",
       nameForDiagnostics: "argument to '@_specialize",
       description: "A collection of arguments for the `@_specialize` attribute",
       kind: "SyntaxCollection",
       element: "Syntax",
       elementName: "SpecializeAttribute",
       elementChoices: ["LabeledSpecializeEntry", "AvailabilityEntry", "TargetFunctionEntry", "GenericWhereClause"]),

  Node(name: "AvailabilityEntry",
       nameForDiagnostics: "availability entry",
       description: "The availability argument for the _specialize attribute",
       kind: "Syntax",
       children: [
         Child(name: "Label",
               kind: "IdentifierToken",
               description: "The label of the argument",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               description: "The colon separating the label and the value",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "AvailabilityList",
               kind: "AvailabilitySpecList",
               collectionElementName: "Availability"),
         Child(name: "Semicolon",
               kind: "SemicolonToken",
               tokenChoices: [
                 "Semicolon"
               ])
       ]),

  Node(name: "LabeledSpecializeEntry",
       nameForDiagnostics: "attribute argument",
       description: "A labeled argument for the `@_specialize` attribute like`exported: true`",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Label",
               kind: "IdentifierToken",
               description: "The label of the argument",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               description: "The colon separating the label and the value",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Value",
               kind: "Token",
               description: "The value for this argument"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               description: "A trailing comma if this argument is followed by another one",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "TargetFunctionEntry",
       nameForDiagnostics: "attribute argument",
       description: "A labeled argument for the `@_specialize` attribute with a functiondecl value like`target: myFunc(_:)`",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Label",
               kind: "IdentifierToken",
               description: "The label of the argument",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               description: "The colon separating the label and the value",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Declname",
               kind: "DeclName",
               description: "The value for this argument"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               description: "A trailing comma if this argument is followed by another one",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "NamedAttributeStringArgument",
       nameForDiagnostics: "attribute argument",
       description: "The argument for the `@_dynamic_replacement` or `@_private`attribute of the form `for: \"function()\"` or `sourceFile:\"Src.swift\"`",
       kind: "Syntax",
       children: [
         Child(name: "NameTok",
               kind: "Token",
               description: "The label of the argument"),
         Child(name: "Colon",
               kind: "ColonToken",
               description: "The colon separating the label and the value",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "StringOrDeclname",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "String",
                       kind: "StringLiteralToken",
                       tokenChoices: [
                         "StringLiteral"
                       ]),
                 Child(name: "Declname",
                       kind: "DeclName")
               ])
       ]),

  Node(name: "DeclName",
       nameForDiagnostics: "declaration name",
       kind: "Syntax",
       children: [
         Child(name: "DeclBaseName",
               kind: "Syntax",
               description: "The base name of the protocol's requirement.",
               nodeChoices: [
                 Child(name: "Identifier",
                       kind: "IdentifierToken",
                       tokenChoices: [
                         "Identifier"
                       ]),
                 Child(name: "Operator",
                       kind: "PrefixOperatorToken",
                       tokenChoices: [
                         "PrefixOperator"
                       ])
               ]),
         Child(name: "DeclNameArguments",
               kind: "DeclNameArguments",
               description: "The argument labels of the protocol's requirement if itis a function requirement.",
               isOptional: true)
       ]),

  Node(name: "ImplementsAttributeArguments",
       nameForDiagnostics: "@_implements arguemnts",
       description: "The arguments for the `@_implements` attribute of the form`Type, methodName(arg1Label:arg2Label:)`",
       kind: "Syntax",
       children: [
         Child(name: "Type",
               kind: "Type",
               description: "The type for which the method with this attributeimplements a requirement."),
         Child(name: "Comma",
               kind: "CommaToken",
               description: "The comma separating the type and method name",
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "DeclBaseName",
               kind: "Token",
               description: "The base name of the protocol's requirement."),
         Child(name: "DeclNameArguments",
               kind: "DeclNameArguments",
               description: "The argument labels of the protocol's requirement if itis a function requirement.",
               isOptional: true)
       ]),

  Node(name: "ObjCSelectorPiece",
       nameForDiagnostics: "Objective-C selector piece",
       description: "A piece of an Objective-C selector. Either consisting of just anidentifier for a nullary selector, an identifier and a colon for alabeled argument or just a colon for an unlabeled argument",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "IdentifierToken",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true,
               tokenChoices: [
                 "Colon"
               ])
       ]),

  Node(name: "ObjCSelector",
       nameForDiagnostics: "Objective-C selector",
       kind: "SyntaxCollection",
       element: "ObjCSelectorPiece"),

  Node(name: "DifferentiableAttributeArguments",
       nameForDiagnostics: "'@differentiable' arguments",
       description: "The arguments for the `@differentiable` attribute: an optionaldifferentiability kind, an optional differentiability parameter clause,and an optional 'where' clause.",
       kind: "Syntax",
       children: [
         Child(name: "DiffKind",
               kind: "IdentifierToken",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "forward",
                 "reverse",
                 "linear"
               ]),
         Child(name: "DiffKindComma",
               kind: "CommaToken",
               description: "The comma following the differentiability kind, if it exists.",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "DiffParams",
               kind: "DifferentiabilityParamsClause",
               isOptional: true),
         Child(name: "DiffParamsComma",
               kind: "CommaToken",
               description: "The comma following the differentiability parameters clause,if it exists.",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "WhereClause",
               kind: "GenericWhereClause",
               isOptional: true)
       ]),

  Node(name: "DifferentiabilityParamsClause",
       nameForDiagnostics: "'@differentiable' argument",
       description: "A clause containing differentiability parameters.",
       kind: "Syntax",
       children: [
         Child(name: "WrtLabel",
               kind: "IdentifierToken",
               description: "The \"wrt\" label.",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "wrt"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               description: "The colon separating \"wrt\" and the parameter list.",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "Parameters",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "Parameter",
                       kind: "DifferentiabilityParam"),
                 Child(name: "ParameterList",
                       kind: "DifferentiabilityParams")
               ])
       ]),

  Node(name: "DifferentiabilityParams",
       nameForDiagnostics: "differentiability parameters",
       description: "The differentiability parameters.",
       kind: "Syntax",
       children: [
         Child(name: "LeftParen",
               kind: "LeftParenToken",
               tokenChoices: [
                 "LeftParen"
               ]),
         Child(name: "DiffParams",
               kind: "DifferentiabilityParamList",
               description: "The parameters for differentiation.",
               collectionElementName: "DifferentiabilityParam"),
         Child(name: "RightParen",
               kind: "RightParenToken",
               tokenChoices: [
                 "RightParen"
               ])
       ]),

  Node(name: "DifferentiabilityParamList",
       nameForDiagnostics: "differentiability parameters",
       kind: "SyntaxCollection",
       element: "DifferentiabilityParam"),

  Node(name: "DifferentiabilityParam",
       nameForDiagnostics: "differentiability parameter",
       description: "A differentiability parameter: either the \"self\" identifier, a functionparameter name, or a function parameter index.",
       kind: "Syntax",
       traits: [
         "WithTrailingComma"
       ],
       children: [
         Child(name: "Parameter",
               kind: "Syntax",
               nodeChoices: [
                 Child(name: "Self",
                       kind: "SelfToken",
                       tokenChoices: [
                         "Self"
                       ]),
                 Child(name: "Name",
                       kind: "IdentifierToken",
                       tokenChoices: [
                         "Identifier"
                       ]),
                 Child(name: "Index",
                       kind: "IntegerLiteralToken",
                       tokenChoices: [
                         "IntegerLiteral"
                       ])
               ]),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "DerivativeRegistrationAttributeArguments",
       nameForDiagnostics: "attribute arguments",
       description: "The arguments for the '@derivative(of:)' and '@transpose(of:)'attributes: the 'of:' label, the original declaration name, and anoptional differentiability parameter list.",
       kind: "Syntax",
       children: [
         Child(name: "OfLabel",
               kind: "IdentifierToken",
               description: "The \"of\" label.",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "of"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               description: "The colon separating the \"of\" label and the originaldeclaration name.",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "OriginalDeclName",
               kind: "QualifiedDeclName",
               description: "The referenced original declaration name."),
         Child(name: "Period",
               kind: "PeriodToken",
               description: "The period separating the original declaration name and theaccessor name.",
               isOptional: true,
               tokenChoices: [
                 "Period"
               ]),
         Child(name: "AccessorKind",
               kind: "IdentifierToken",
               description: "The accessor name.",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "get",
                 "set"
               ]),
         Child(name: "Comma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "DiffParams",
               kind: "DifferentiabilityParamsClause",
               isOptional: true)
       ]),

  Node(name: "QualifiedDeclName",
       nameForDiagnostics: "declaration name",
       description: "An optionally qualified function declaration name (e.g. `+(_:_:)`,`A.B.C.foo(_:_:)`).",
       kind: "Syntax",
       children: [
         Child(name: "BaseType",
               kind: "Type",
               description: "The base type of the qualified name, optionally specified.",
               isOptional: true),
         Child(name: "Dot",
               kind: "Token",
               isOptional: true,
               tokenChoices: [
                 "Period",
                 "PrefixPeriod"
               ]),
         Child(name: "Name",
               kind: "Token",
               description: "The base name of the referenced function.",
               tokenChoices: [
                 "Identifier",
                 "UnspacedBinaryOperator",
                 "SpacedBinaryOperator",
                 "PrefixOperator",
                 "PostfixOperator"
               ]),
         Child(name: "Arguments",
               kind: "DeclNameArguments",
               description: "The argument labels of the referenced function, optionallyspecified.",
               isOptional: true)
       ]),

  Node(name: "FunctionDeclName",
       nameForDiagnostics: "function declaration name",
       description: "A function declaration name (e.g. `foo(_:_:)`).",
       kind: "Syntax",
       children: [
         Child(name: "Name",
               kind: "Syntax",
               description: "The base name of the referenced function.",
               nodeChoices: [
                 Child(name: "Identifier",
                       kind: "IdentifierToken",
                       tokenChoices: [
                         "Identifier"
                       ]),
                 Child(name: "PrefixOperator",
                       kind: "PrefixOperatorToken",
                       tokenChoices: [
                         "PrefixOperator"
                       ]),
                 Child(name: "SpacedBinaryOperator",
                       kind: "SpacedBinaryOperatorToken",
                       tokenChoices: [
                         "SpacedBinaryOperator"
                       ])
               ]),
         Child(name: "Arguments",
               kind: "DeclNameArguments",
               description: "The argument labels of the referenced function, optionallyspecified.",
               isOptional: true)
       ]),

  Node(name: "BackDeployAttributeSpecList",
       nameForDiagnostics: "'@_backDeploy' arguments",
       description: "A collection of arguments for the `@_backDeploy` attribute",
       kind: "Syntax",
       children: [
         Child(name: "BeforeLabel",
               kind: "IdentifierToken",
               description: "The \"before\" label.",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "before"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               description: "The colon separating \"before\" and the parameter list.",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "VersionList",
               kind: "BackDeployVersionList",
               description: "The list of OS versions in which the declaration became ABIstable.",
               collectionElementName: "Availability")
       ]),

  Node(name: "BackDeployVersionList",
       nameForDiagnostics: "version list",
       kind: "SyntaxCollection",
       element: "BackDeployVersionArgument"),

  Node(name: "BackDeployVersionArgument",
       nameForDiagnostics: "version",
       description: "A single platform/version pair in a `@_backDeploy` attribute,e.g. `iOS 10.1`.",
       kind: "Syntax",
       children: [
         Child(name: "AvailabilityVersionRestriction",
               kind: "AvailabilityVersionRestriction",
               classification: "Keyword"),
         Child(name: "TrailingComma",
               kind: "CommaToken",
               description: "A trailing comma if the argument is followed by anotherargument",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ])
       ]),

  Node(name: "OpaqueReturnTypeOfAttributeArguments",
       nameForDiagnostics: "opaque return type arguments",
       description: "The arguments for the '@_opaqueReturnTypeOf()'.",
       kind: "Syntax",
       children: [
         Child(name: "MangledName",
               kind: "StringLiteralToken",
               description: "The mangled name of a declaration.",
               tokenChoices: [
                 "StringLiteral"
               ]),
         Child(name: "Comma",
               kind: "CommaToken",
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "Ordinal",
               kind: "IntegerLiteralToken",
               description: "The ordinal corresponding to the 'some' keyword that introduced this opaque type.",
               tokenChoices: [
                 "IntegerLiteral"
               ])
       ]),

  Node(name: "ConventionAttributeArguments",
       nameForDiagnostics: "@convention(...) arguments",
       description: "The arguments for the '@convention(...)'.",
       kind: "Syntax",
       children: [
         Child(name: "ConventionLabel",
               kind: "IdentifierToken",
               description: "The convention label.",
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "block",
                 "c",
                 "objc_method",
                 "thin",
                 "thick"
               ]),
         Child(name: "Comma",
               kind: "CommaToken",
               isOptional: true,
               tokenChoices: [
                 "Comma"
               ]),
         Child(name: "CTypeLabel",
               kind: "IdentifierToken",
               isOptional: true,
               tokenChoices: [
                 "Identifier"
               ],
               textChoices: [
                 "cType"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               isOptional: true,
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "CTypeString",
               kind: "StringLiteralToken",
               isOptional: true,
               tokenChoices: [
                 "StringLiteral"
               ])
       ]),

  Node(name: "ConventionWitnessMethodAttributeArguments",
       nameForDiagnostics: "@convention(...) arguments for witness methods",
       description: "The arguments for the '@convention(witness_method: ...)'.",
       kind: "Syntax",
       children: [
         Child(name: "WitnessMethodLabel",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ]),
         Child(name: "Colon",
               kind: "ColonToken",
               tokenChoices: [
                 "Colon"
               ]),
         Child(name: "ProtocolName",
               kind: "IdentifierToken",
               tokenChoices: [
                 "Identifier"
               ])
       ]),

]
