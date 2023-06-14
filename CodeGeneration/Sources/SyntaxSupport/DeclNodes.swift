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

public let DECL_NODES: [Node] = [
  // FIXME: technically misnamed; should be "ImportPathComponent"
  Node(
    name: "AccessPathComponent",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "PrefixOperatorToken"), .token(tokenKind: "PostfixOperatorToken")]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "TrailingDot",
        kind: .token(choices: [.token(tokenKind: "PeriodToken")]),
        isOptional: true
      ),
    ]
  ),

  // FIXME: technically misnamed; should be "ImportPath"
  Node(
    name: "AccessPath",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "AccessPathComponent"
  ),

  Node(
    name: "AccessorBlock",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "Braced"
    ],
    children: [
      Child(
        name: "LeftBrace",
        kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])
      ),
      Child(
        name: "Accessors",
        kind: .collection(kind: "AccessorList", collectionElementName: "Accessor"),
        isIndented: true
      ),
      Child(
        name: "RightBrace",
        kind: .token(choices: [.token(tokenKind: "RightBraceToken")]),
        requiresLeadingNewline: true
      ),
    ]
  ),

  Node(
    name: "AccessesEffect",
    nameForDiagnostics: "accesses effect",
    kind: "Syntax",
    children: [
      Child(
        name: "AccessesKeyword",
        kind: .token(choices: [.keyword(text: "accesses")])
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "PropertyList",
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Property"),
        nameForDiagnostics: "properties"
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  Node(
    name: "InitializesEffect",
    nameForDiagnostics: "initializes effect",
    kind: "Syntax",
    children: [
      Child(
        name: "InitializesKeyword",
        kind: .token(choices: [.keyword(text: "initializes")])
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "PropertyList",
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Property"),
        nameForDiagnostics: "properties"
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  Node(
    name: "AccessorInitEffects",
    nameForDiagnostics: "init accessor effects",
    kind: "Syntax",
    children: [
      Child(
        name: "InitializesEffect",
        kind: .node(kind: "InitializesEffect"),
        isOptional: true
      ),
      Child(
        name: "AccessesEffect",
        kind: .node(kind: "AccessesEffect"),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "AccessorDecl",
    nameForDiagnostics: "accessor",
    kind: "Decl",
    traits: [
      "WithAttributes"
    ],
    parserFunction: "parseAccessorDecl",
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifier",
        kind: .node(kind: "DeclModifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "AccessorKind",
        kind: .token(choices: [.keyword(text: "get"), .keyword(text: "set"), .keyword(text: "didSet"), .keyword(text: "willSet"), .keyword(text: "unsafeAddress"), .keyword(text: "addressWithOwner"), .keyword(text: "addressWithNativeOwner"), .keyword(text: "unsafeMutableAddress"), .keyword(text: "mutableAddressWithOwner"), .keyword(text: "mutableAddressWithNativeOwner"), .keyword(text: "_read"), .keyword(text: "_modify"), .keyword(text: "init")])
      ),
      Child(
        name: "Parameter",
        kind: .node(kind: "AccessorParameter"),
        nameForDiagnostics: "parameter",
        isOptional: true
      ),
      Child(
        name: "EffectSpecifiers",
        kind: .node(kind: "AccessorEffectSpecifiers"),
        isOptional: true
      ),
      Child(
        name: "InitEffects",
        kind: .node(kind: "AccessorInitEffects"),
        isOptional: true
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "AccessorList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "AccessorDecl",
    elementsSeparatedByNewline: true
  ),

  // (value)
  Node(
    name: "AccessorParameter",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Name",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "name"
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  // actor-declaration -> attributes? access-level-modifier?
  //                      'actor' actor-name
  //                      generic-parameter-clause?
  //                      type-inheritance-clause?
  //                      generic-where-clause?
  //                     '{' actor-members '}'
  // actor-name -> identifier
  Node(
    name: "ActorDecl",
    nameForDiagnostics: "actor",
    kind: "Decl",
    traits: [
      "DeclGroup",
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "ActorKeyword",
        kind: .token(choices: [.keyword(text: "actor")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        isOptional: true
      ),
      Child(
        name: "InheritanceClause",
        kind: .node(kind: "TypeInheritanceClause"),
        nameForDiagnostics: "type inheritance clause",
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
      Child(
        name: "MemberBlock",
        kind: .node(kind: "MemberDeclBlock")
      ),
    ]
  ),

  // associatedtype-declaration -> attributes? access-level-modifier?
  //                                 'associatedtype' associatedtype-name
  //                                 inheritance-clause? type-assignment?
  //                                 generic-where-clause?
  // associatedtype-name -> identifier
  Node(
    name: "AssociatedtypeDecl",
    nameForDiagnostics: "associatedtype declaration",
    kind: "Decl",
    traits: [
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "AssociatedtypeKeyword",
        kind: .token(choices: [.keyword(text: "associatedtype")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "InheritanceClause",
        kind: .node(kind: "TypeInheritanceClause"),
        nameForDiagnostics: "inheritance clause",
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: "TypeInitializerClause"),
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
    ]
  ),

  // class-declaration -> attributes? access-level-modifier?
  //                      'class' class-name
  //                      generic-parameter-clause?
  //                      type-inheritance-clause?
  //                      generic-where-clause?
  //                     '{' class-members '}'
  // class-name -> identifier
  Node(
    name: "ClassDecl",
    nameForDiagnostics: "class",
    kind: "Decl",
    traits: [
      "DeclGroup",
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "ClassKeyword",
        kind: .token(choices: [.keyword(text: "class")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        isOptional: true
      ),
      Child(
        name: "InheritanceClause",
        kind: .node(kind: "TypeInheritanceClause"),
        nameForDiagnostics: "inheritance clause",
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
      Child(
        name: "MemberBlock",
        kind: .node(kind: "MemberDeclBlock")
      ),
    ]
  ),

  Node(
    name: "DeclModifierDetail",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Detail",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  Node(
    name: "DeclModifier",
    nameForDiagnostics: "modifier",
    kind: "Syntax",
    children: [
      Child(
        name: "Name",
        kind: .token(choices: [
          .keyword(text: "__consuming"),
          .keyword(text: "__setter_access"),
          .keyword(text: "_const"),
          .keyword(text: "_local"),
          .keyword(text: "actor"),
          .keyword(text: "async"),
          .keyword(text: "borrowing"),
          .keyword(text: "class"),
          .keyword(text: "consuming"),
          .keyword(text: "convenience"),
          .keyword(text: "distributed"),
          .keyword(text: "dynamic"),
          .keyword(text: "fileprivate"),
          .keyword(text: "final"),
          .keyword(text: "indirect"),
          .keyword(text: "infix"),
          .keyword(text: "internal"),
          .keyword(text: "isolated"),
          .keyword(text: "lazy"),
          .keyword(text: "mutating"),
          .keyword(text: "nonisolated"),
          .keyword(text: "nonmutating"),
          .keyword(text: "open"),
          .keyword(text: "optional"),
          .keyword(text: "override"),
          .keyword(text: "package"),
          .keyword(text: "postfix"),
          .keyword(text: "prefix"),
          .keyword(text: "private"),
          .keyword(text: "public"),
          .keyword(text: "reasync"),
          .keyword(text: "required"),
          .keyword(text: "setter_access"),
          .keyword(text: "static"),
          .keyword(text: "unowned"),
          .keyword(text: "weak"),
        ]),
        classification: "Attribute"
      ),
      Child(
        name: "Detail",
        kind: .node(kind: "DeclModifierDetail"),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "DeinitializerDecl",
    nameForDiagnostics: "deinitializer",
    kind: "Decl",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "DeinitKeyword",
        kind: .token(choices: [.keyword(text: "deinit")])
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "DesignatedTypeElement",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "LeadingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")])
      ),
      Child(
        name: "Name",
        kind: .node(kind: "Token")
      ),
    ]
  ),

  // designated-type-list -> (',' identifier)*
  Node(
    name: "DesignatedTypeList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "DesignatedTypeElement"
  ),

  // <#content#>
  Node(
    name: "EditorPlaceholderDecl",
    nameForDiagnostics: "editor placeholder",
    description: """
      An editor placeholder, e.g. `<#declaration#>` that is used in a position that expects a declaration.
      """,
    kind: "Decl",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        description: "If there were attributes before the editor placeholder, the ``EditorPlaceholderDecl`` will contain these.",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        description: "If there were modifiers before the editor placeholder, the `EditorPlaceholderDecl` will contain these.",
        isOptional: true
      ),
      Child(
        name: "Placeholder",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        description: """
          The actual editor placeholder that starts with `<#` and ends with `#>`.
          """
      ),
    ]
  ),

  Node(
    name: "EnumCaseParameterClause",
    nameForDiagnostics: "parameter clause",
    kind: "Syntax",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        description: "The '(' to open the parameter clause."
      ),
      Child(
        name: "ParameterList",
        kind: .collection(kind: "EnumCaseParameterList", collectionElementName: "Parameter"),
        nameForDiagnostics: "parameters",
        description: "The actual parameters.",
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        description: "The ')' to close the parameter clause."
      ),
    ]
  ),

  Node(
    name: "EnumCaseParameterList",
    nameForDiagnostics: "parameter list",
    kind: "SyntaxCollection",
    element: "EnumCaseParameter"
  ),

  Node(
    name: "EnumCaseParameter",
    nameForDiagnostics: "parameter",
    kind: "Syntax",
    traits: [
      "WithTrailingComma",
      "WithModifiers",
    ],
    parserFunction: "parseEnumCaseParameter",
    children: [
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "FirstName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        isOptional: true
      ),
      Child(
        name: "SecondName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")]),
        isOptional: true
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")]),
        description: "If the parameter has a label, the colon separating the label from the type.",
        isOptional: true
      ),
      Child(
        name: "Type",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "type",
        description: "The parameter's type."
      ),
      Child(
        name: "DefaultArgument",
        kind: .node(kind: "InitializerClause"),
        nameForDiagnostics: "default argument",
        description: "If the parameter has a default value, the initializer clause describing the default value.",
        isOptional: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "If the parameter is followed by another parameter, the comma separating them.",
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "EnumCaseDecl",
    nameForDiagnostics: "enum case",
    description: "A `case` declaration of a Swift `enum`. It can have 1 or more `EnumCaseElement`s inside, each declaring a different case of the enum.",
    kind: "Decl",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        description: "The attributes applied to the case declaration.",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        description: "The declaration modifiers applied to the case declaration.",
        isOptional: true
      ),
      Child(
        name: "CaseKeyword",
        kind: .token(choices: [.keyword(text: "case")]),
        description: "The `case` keyword for this case."
      ),
      Child(
        name: "Elements",
        kind: .collection(kind: "EnumCaseElementList", collectionElementName: "Element"),
        nameForDiagnostics: "elements",
        description: "The elements this case declares."
      ),
    ]
  ),

  Node(
    name: "EnumCaseElementList",
    nameForDiagnostics: nil,
    description: "A collection of 0 or more `EnumCaseElement`s.",
    kind: "SyntaxCollection",
    element: "EnumCaseElement"
  ),

  Node(
    name: "EnumCaseElement",
    nameForDiagnostics: nil,
    description: "An element of an enum case, containing the name of the case and, optionally, either associated values or an assignment to a raw value.",
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        description: "The name of this case."
      ),
      Child(
        name: "AssociatedValue",
        kind: .node(kind: "EnumCaseParameterClause"),
        nameForDiagnostics: "associated values",
        description: "The set of associated values of the case.",
        isOptional: true
      ),
      Child(
        name: "RawValue",
        kind: .node(kind: "InitializerClause"),
        description: "The raw value of this enum element, if present.",
        isOptional: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        description: "The trailing comma of this element, if the case has multiple elements.",
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "EnumDecl",
    nameForDiagnostics: "enum",
    description: "A Swift `enum` declaration.",
    kind: "Decl",
    traits: [
      "DeclGroup",
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        description: "The attributes applied to the enum declaration.",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        description: "The declaration modifiers applied to the enum declaration.",
        isOptional: true
      ),
      Child(
        name: "EnumKeyword",
        kind: .token(choices: [.keyword(text: "enum")]),
        description: "The `enum` keyword for this declaration."
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        description: "The name of this enum."
      ),
      Child(
        name: "GenericParameters",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        description: "The generic parameters, if any, for this enum.",
        isOptional: true
      ),
      Child(
        name: "InheritanceClause",
        kind: .node(kind: "TypeInheritanceClause"),
        nameForDiagnostics: "inheritance clause",
        description: "The inheritance clause describing conformances or raw values for this enum.",
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        description: "The `where` clause that applies to the generic parameters of this enum.",
        isOptional: true
      ),
      Child(
        name: "MemberBlock",
        kind: .node(kind: "MemberDeclBlock"),
        description: "The cases and other members of this enum."
      ),
    ]
  ),

  // extension-declaration -> attributes? access-level-modifier?
  //                            'extension' extended-type
  //                              type-inheritance-clause?
  //                            generic-where-clause?
  //                            '{' extension-members '}'
  // extension-name -> identifier
  Node(
    name: "ExtensionDecl",
    nameForDiagnostics: "extension",
    kind: "Decl",
    traits: [
      "DeclGroup",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "ExtensionKeyword",
        kind: .token(choices: [.keyword(text: "extension")])
      ),
      Child(
        name: "ExtendedType",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "InheritanceClause",
        kind: .node(kind: "TypeInheritanceClause"),
        nameForDiagnostics: "inheritance clause",
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
      Child(
        name: "MemberBlock",
        kind: .node(kind: "MemberDeclBlock")
      ),
    ]
  ),

  Node(
    name: "FunctionDecl",
    nameForDiagnostics: "function",
    kind: "Decl",
    traits: [
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "FuncKeyword",
        kind: .token(choices: [.keyword(text: "func")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "PrefixOperatorToken"), .token(tokenKind: "PostfixOperatorToken")])
      ),
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        isOptional: true
      ),
      Child(
        name: "Signature",
        kind: .node(kind: "FunctionSignature"),
        nameForDiagnostics: "function signature"
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "FunctionParameterList",
    nameForDiagnostics: "parameter list",
    kind: "SyntaxCollection",
    element: "FunctionParameter"
  ),

  // parameter ->
  // external-parameter-name? local-parameter-name ':'
  //   type '...'? '='? expression? ','?
  Node(
    name: "FunctionParameter",
    nameForDiagnostics: "parameter",
    kind: "Syntax",
    traits: [
      "WithTrailingComma",
      "WithAttributes",
      "WithModifiers",
    ],
    parserFunction: "parseFunctionParameter",
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "FirstName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")])
      ),
      // One of these two names needs be optional, we choose the second
      // name to avoid backtracking.
      Child(
        name: "SecondName",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken"), .token(tokenKind: "WildcardToken")], requiresLeadingSpace: true),
        nameForDiagnostics: "internal name",
        isOptional: true
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Type",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "type"
      ),
      Child(
        name: "Ellipsis",
        kind: .token(choices: [.token(tokenKind: "EllipsisToken")]),
        isOptional: true
      ),
      Child(
        name: "DefaultArgument",
        kind: .node(kind: "InitializerClause"),
        nameForDiagnostics: "default argument",
        isOptional: true
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  // function-signature ->
  //   '(' parameter-list? ')' function-effect-specifiers? return-clause?
  Node(
    name: "FunctionSignature",
    nameForDiagnostics: "function signature",
    kind: "Syntax",
    children: [
      Child(
        name: "Input",
        kind: .node(kind: "ParameterClause")
      ),
      Child(
        name: "EffectSpecifiers",
        kind: .node(kind: "FunctionEffectSpecifiers"),
        isOptional: true
      ),
      Child(
        name: "Output",
        kind: .node(kind: "ReturnClause"),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "IfConfigClauseList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "IfConfigClause"
  ),

  // if-config-clause ->
  //    ('#if' | '#elseif' | '#else') expr? (stmt-list | switch-case-list)
  Node(
    name: "IfConfigClause",
    nameForDiagnostics: "conditional compilation clause",
    kind: "Syntax",
    children: [
      Child(
        name: "PoundKeyword",
        kind: .token(choices: [.token(tokenKind: "PoundIfToken"), .token(tokenKind: "PoundElseifToken"), .token(tokenKind: "PoundElseToken")]),
        classification: "BuildConfigId",
        requiresLeadingNewline: true
      ),
      Child(
        name: "Condition",
        kind: .node(kind: "Expr"),
        nameForDiagnostics: "condition",
        isOptional: true,
        classification: "BuildConfigId"
      ),
      Child(
        name: "Elements",
        kind: .nodeChoices(choices: [
          Child(
            name: "Statements",
            kind: .node(kind: "CodeBlockItemList")
          ),
          Child(
            name: "SwitchCases",
            kind: .node(kind: "SwitchCaseList")
          ),
          Child(
            name: "Decls",
            kind: .node(kind: "MemberDeclList")
          ),
          Child(
            name: "PostfixExpression",
            kind: .node(kind: "Expr")
          ),
          Child(
            name: "Attributes",
            kind: .node(kind: "AttributeList")
          ),
        ]),
        isOptional: true
      ),
    ]
  ),

  // if-config-decl -> '#if' expr stmt-list else-if-directive-clause-list
  //   else-clause? '#endif'
  Node(
    name: "IfConfigDecl",
    nameForDiagnostics: "conditional compilation block",
    kind: "Decl",
    children: [
      Child(
        name: "Clauses",
        kind: .collection(kind: "IfConfigClauseList", collectionElementName: "Clause")
      ),
      Child(
        name: "PoundEndif",
        kind: .token(choices: [.token(tokenKind: "PoundEndifToken")]),
        classification: "BuildConfigId",
        requiresLeadingNewline: true
      ),
    ]
  ),

  Node(
    name: "ImportDecl",
    nameForDiagnostics: "import",
    kind: "Decl",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "ImportTok",
        kind: .token(choices: [.keyword(text: "import")])
      ),
      Child(
        name: "ImportKind",
        kind: .token(choices: [.keyword(text: "typealias"), .keyword(text: "struct"), .keyword(text: "class"), .keyword(text: "enum"), .keyword(text: "protocol"), .keyword(text: "var"), .keyword(text: "let"), .keyword(text: "func"), .keyword(text: "inout")]),
        isOptional: true
      ),
      Child(
        name: "Path",
        kind: .collection(kind: "AccessPath", collectionElementName: "PathComponent")
      ),
    ]
  ),

  Node(
    name: "InheritedTypeList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "InheritedType"
  ),

  Node(
    name: "InheritedType",
    nameForDiagnostics: "inherited type",
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "TypeName",
        kind: .node(kind: "Type")
      ),
      Child(
        name: "TrailingComma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")]),
        isOptional: true
      ),
    ]
  ),

  // initializer -> '=' expr
  Node(
    name: "InitializerClause",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "Equal",
        kind: .token(choices: [.token(tokenKind: "EqualToken")])
      ),
      Child(
        name: "Value",
        kind: .node(kind: "Expr")
      ),
    ]
  ),

  Node(
    name: "InitializerDecl",
    nameForDiagnostics: "initializer",
    description: """
      An initializer declaration like the following.

      ```swift
      init(someParameter: Int) {
      }
      ```

      The body is optional because this node also represents initializer requirements inside protocols.
      """,
    kind: "Decl",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        description: "Attributes that are attached to the initializer.",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        description: "Modifiers attached to the initializer",
        isOptional: true
      ),
      Child(
        name: "InitKeyword",
        kind: .token(choices: [.keyword(text: "init")]),
        description: "The init keyword"
      ),
      Child(
        name: "OptionalMark",
        kind: .token(choices: [.token(tokenKind: "PostfixQuestionMarkToken"), .token(tokenKind: "InfixQuestionMarkToken"), .token(tokenKind: "ExclamationMarkToken")]),
        description: "If the initializer is failable, a question mark to indicate that.",
        isOptional: true
      ),
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        description: "Generic parameters of the initializer.",
        isOptional: true
      ),
      Child(
        name: "Signature",
        kind: .node(kind: "FunctionSignature"),
        nameForDiagnostics: "function signature",
        description: "The arguments of the initializer. While the function signature allows specifying an return clause, doing so is not semantically valid."
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        description: "If the initializer had generic parameters, a where clause that can restrict those",
        isOptional: true
      ),
      Child(
        name: "Body",
        kind: .node(kind: "CodeBlock"),
        description: "The initializer’s body. Missing if the initialier is a requirement of a protocol declaration.",
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "MacroDecl",
    nameForDiagnostics: "macro",
    kind: "Decl",
    traits: [
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "MacroKeyword",
        kind: .token(choices: [.keyword(text: "macro")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        isOptional: true
      ),
      Child(
        name: "Signature",
        kind: .node(kind: "FunctionSignature"),
        nameForDiagnostics: "macro signature"
      ),
      Child(
        name: "Definition",
        kind: .node(kind: "InitializerClause"),
        nameForDiagnostics: "macro definition",
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
    ]
  ),

  // e.g., "#embed("filename.txt")"
  Node(
    name: "MacroExpansionDecl",
    nameForDiagnostics: "macro expansion",
    kind: "Decl",
    traits: [
      "FreestandingMacroExpansion",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "PoundToken",
        kind: .token(choices: [.token(tokenKind: "PoundToken")]),
        description: "The `#` sign."
      ),
      Child(
        name: "Macro",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "GenericArguments",
        kind: .node(kind: "GenericArgumentClause"),
        isOptional: true
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")]),
        isOptional: true
      ),
      Child(
        name: "ArgumentList",
        kind: .collection(kind: "TupleExprElementList", collectionElementName: "Argument")
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")]),
        isOptional: true
      ),
      Child(
        name: "TrailingClosure",
        kind: .node(kind: "ClosureExpr"),
        isOptional: true
      ),
      Child(
        name: "AdditionalTrailingClosures",
        kind: .collection(kind: "MultipleTrailingClosureElementList", collectionElementName: "AdditionalTrailingClosure"),
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "MemberDeclBlock",
    nameForDiagnostics: "member block",
    kind: "Syntax",
    traits: [
      "Braced"
    ],
    parserFunction: "parseMemberDeclList",
    children: [
      Child(
        name: "LeftBrace",
        kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])
      ),
      Child(
        name: "Members",
        kind: .collection(kind: "MemberDeclList", collectionElementName: "Member"),
        isIndented: true
      ),
      Child(
        name: "RightBrace",
        kind: .token(choices: [.token(tokenKind: "RightBraceToken")]),
        requiresLeadingNewline: true
      ),
    ]
  ),

  // member-decl = decl ';'?
  Node(
    name: "MemberDeclListItem",
    nameForDiagnostics: nil,
    description: "A member declaration of a type consisting of a declaration and an optional semicolon;",
    kind: "Syntax",
    children: [
      Child(
        name: "Decl",
        kind: .node(kind: "Decl"),
        description: "The declaration of the type member."
      ),
      Child(
        name: "Semicolon",
        kind: .token(choices: [.token(tokenKind: "SemicolonToken")]),
        description: "An optional trailing semicolon.",
        isOptional: true
      ),
    ],
    omitWhenEmpty: true
  ),

  // member-decl-list = member-decl member-decl-list?
  Node(
    name: "MemberDeclList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "MemberDeclListItem",
    elementsSeparatedByNewline: true
  ),

  // declaration-modifier -> access-level-modifier
  //                       | mutation-modifier
  //                       | 'class'
  //                       | 'convenience'
  //                       | 'distributed'
  //                       | 'dynamic'
  //                       | 'final'
  //                       | 'infix'
  //                       | 'isolated'
  //                       | 'lazy'
  //                       | 'nonisolated'
  //                       | 'optional'
  //                       | 'override'
  //                       | 'postfix'
  //                       | 'prefix'
  //                       | 'required'
  //                       | 'static'
  //                       | 'unowned'
  //                       | 'unowned(safe)'
  //                       | 'unowned(unsafe)'
  //                       | 'weak'
  // mutation-modifier -> 'mutating' | 'nonmutating'
  Node(
    name: "ModifierList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "DeclModifier",
    elementName: "Modifier",
    omitWhenEmpty: true
  ),

  // operator-decl -> attribute? modifiers? 'operator' operator
  Node(
    name: "OperatorDecl",
    nameForDiagnostics: "operator declaration",
    description: "A Swift `operator` declaration.",
    kind: "Decl",
    traits: [
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        description: "The attributes applied to the 'operator' declaration.",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        description: "The declaration modifiers applied to the 'operator' declaration.",
        isOptional: true,
        classification: "Attribute"
      ),
      Child(
        name: "OperatorKeyword",
        kind: .token(choices: [.keyword(text: "operator")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "BinaryOperatorToken"), .token(tokenKind: "PrefixOperatorToken"), .token(tokenKind: "PostfixOperatorToken")]),
        classification: "OperatorIdentifier"
      ),
      Child(
        name: "OperatorPrecedenceAndTypes",
        kind: .node(kind: "OperatorPrecedenceAndTypes"),
        description: "Optionally specify a precedence group and designated types.",
        isOptional: true
      ),
    ]
  ),

  // infix-operator-group -> ':' identifier designated-type-list?
  Node(
    name: "OperatorPrecedenceAndTypes",
    nameForDiagnostics: nil,
    description: "A clause to specify precedence group in infix operator declarations, and designated types in any operator declaration.",
    kind: "Syntax",
    children: [
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "PrecedenceGroup",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        nameForDiagnostics: "precedence group",
        description: "The precedence group for this operator"
      ),
      Child(
        name: "DesignatedTypes",
        kind: .collection(kind: "DesignatedTypeList", collectionElementName: "DesignatedTypeElement"),
        description: "The designated types associated with this operator."
      ),
    ]
  ),

  Node(
    name: "ParameterClause",
    nameForDiagnostics: "parameter clause",
    kind: "Syntax",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "ParameterList",
        kind: .collection(kind: "FunctionParameterList", collectionElementName: "Parameter"),
        nameForDiagnostics: "parameters",
        isIndented: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  Node(
    name: "PatternBindingList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "PatternBinding"
  ),

  // Pattern: Type = Value { get {} },
  Node(
    name: "PatternBinding",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: [
      "WithTrailingComma"
    ],
    children: [
      Child(
        name: "Pattern",
        kind: .node(kind: "Pattern")
      ),
      Child(
        name: "TypeAnnotation",
        kind: .node(kind: "TypeAnnotation"),
        nameForDiagnostics: "type annotation",
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: "InitializerClause"),
        isOptional: true
      ),
      Child(
        name: "Accessor",
        kind: .nodeChoices(choices: [
          Child(
            name: "Accessors",
            kind: .node(kind: "AccessorBlock")
          ),
          Child(
            name: "Getter",
            kind: .node(kind: "CodeBlock")
          ),
        ]),
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
    name: "PoundSourceLocationArgs",
    nameForDiagnostics: "'#sourceLocation' arguments",
    kind: "Syntax",
    children: [
      Child(
        name: "FileArgLabel",
        kind: .token(choices: [.keyword(text: "file")])
      ),
      Child(
        name: "FileArgColon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "FileName",
        kind: .node(kind: "StringLiteralExpr"),
        nameForDiagnostics: "file name"
      ),
      Child(
        name: "Comma",
        kind: .token(choices: [.token(tokenKind: "CommaToken")])
      ),
      Child(
        name: "LineArgLabel",
        kind: .token(choices: [.keyword(text: "line")])
      ),
      Child(
        name: "LineArgColon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "LineNumber",
        kind: .token(choices: [.token(tokenKind: "IntegerLiteralToken")]),
        nameForDiagnostics: "line number"
      ),
    ]
  ),

  Node(
    name: "PoundSourceLocation",
    nameForDiagnostics: "'#sourceLocation' directive",
    kind: "Decl",
    traits: [
      "Parenthesized"
    ],
    children: [
      Child(
        name: "PoundSourceLocation",
        kind: .token(choices: [.token(tokenKind: "PoundSourceLocationToken")])
      ),
      Child(
        name: "LeftParen",
        kind: .token(choices: [.token(tokenKind: "LeftParenToken")])
      ),
      Child(
        name: "Args",
        kind: .node(kind: "PoundSourceLocationArgs"),
        nameForDiagnostics: "arguments",
        isOptional: true
      ),
      Child(
        name: "RightParen",
        kind: .token(choices: [.token(tokenKind: "RightParenToken")])
      ),
    ]
  ),

  // precedence-group-assignment ->
  //     'assignment' ':' ('true' | 'false')
  Node(
    name: "PrecedenceGroupAssignment",
    nameForDiagnostics: "'assignment' property of precedencegroup",
    description: "Specifies the precedence of an operator when used in an operation that includes optional chaining.",
    kind: "Syntax",
    children: [
      Child(
        name: "AssignmentKeyword",
        kind: .token(choices: [.keyword(text: "assignment")])
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Flag",
        kind: .token(choices: [.keyword(text: "true"), .keyword(text: "false")]),
        description: "When true, an operator in the corresponding precedence group uses the same grouping rules during optional chaining as the assignment operators from the standard library. Otherwise, operators in the precedence group follows the same optional chaining rules as operators that don't perform assignment."
      ),
    ]
  ),

  // precedence-group-associativity ->
  //     'associativity' ':' ('left' | 'right' | 'none')
  Node(
    name: "PrecedenceGroupAssociativity",
    nameForDiagnostics: "'associativity' property of precedencegroup",
    description: "Specifies how a sequence of operators with the same precedence level are grouped together in the absence of grouping parentheses.",
    kind: "Syntax",
    children: [
      Child(
        name: "AssociativityKeyword",
        kind: .token(choices: [.keyword(text: "associativity")]),
        classification: "Keyword"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "Value",
        kind: .token(choices: [.keyword(text: "left"), .keyword(text: "right"), .keyword(text: "none")]),
        description: "Operators that are `left`-associative group left-to-right. Operators that are `right`-associative group right-to-left. Operators that are specified with an associativity of `none` don't associate at all"
      ),
    ]
  ),
  // precedence-group-attribute-list ->
  //     (precedence-group-relation | precedence-group-assignment |
  //      precedence-group-associativity )*
  Node(
    name: "PrecedenceGroupAttributeList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "Syntax",
    elementName: "PrecedenceGroupAttribute",
    elementChoices: ["PrecedenceGroupRelation", "PrecedenceGroupAssignment", "PrecedenceGroupAssociativity"]
  ),

  // precedence-group-decl -> attributes? modifiers? 'precedencegroup'
  //                            identifier '{' precedence-group-attribute-list
  //                            '}'
  Node(
    name: "PrecedenceGroupDecl",
    nameForDiagnostics: "precedencegroup",
    description: "A Swift `precedencegroup` declaration.",
    kind: "Decl",
    traits: [
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        description: "The attributes applied to the 'precedencegroup' declaration.",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        description: "The declaration modifiers applied to the 'precedencegroup' declaration.",
        isOptional: true
      ),
      Child(
        name: "PrecedencegroupKeyword",
        kind: .token(choices: [.keyword(text: "precedencegroup")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")]),
        description: "The name of this precedence group."
      ),
      Child(
        name: "LeftBrace",
        kind: .token(choices: [.token(tokenKind: "LeftBraceToken")])
      ),
      Child(
        name: "GroupAttributes",
        kind: .collection(kind: "PrecedenceGroupAttributeList", collectionElementName: "GroupAttribute"),
        description: "The characteristics of this precedence group."
      ),
      Child(
        name: "RightBrace",
        kind: .token(choices: [.token(tokenKind: "RightBraceToken")])
      ),
    ]
  ),

  Node(
    name: "PrecedenceGroupNameElement",
    nameForDiagnostics: nil,
    kind: "Syntax",
    traits: ["WithTrailingComma"],
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

  // precedence-group-name-list ->
  //    identifier (',' identifier)*
  Node(
    name: "PrecedenceGroupNameList",
    nameForDiagnostics: nil,
    kind: "SyntaxCollection",
    element: "PrecedenceGroupNameElement"
  ),

  // precedence-group-relation ->
  //     ('higherThan' | 'lowerThan') ':' precedence-group-name-list
  Node(
    name: "PrecedenceGroupRelation",
    nameForDiagnostics: "'relation' property of precedencegroup",
    description: "Specify the new precedence group's relation to existing precedence groups.",
    kind: "Syntax",
    children: [
      Child(
        name: "HigherThanOrLowerThan",
        kind: .token(choices: [.keyword(text: "higherThan"), .keyword(text: "lowerThan")]),
        description: "The relation to specified other precedence groups.",
        classification: "Keyword"
      ),
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "OtherNames",
        kind: .collection(kind: "PrecedenceGroupNameList", collectionElementName: "OtherName"),
        description: "The name of other precedence group to which this precedence group relates."
      ),
    ]
  ),

  Node(
    name: "ProtocolDecl",
    nameForDiagnostics: "protocol",
    kind: "Decl",
    traits: [
      "DeclGroup",
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "ProtocolKeyword",
        kind: .token(choices: [.keyword(text: "protocol")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "PrimaryAssociatedTypeClause",
        kind: .node(kind: "PrimaryAssociatedTypeClause"),
        nameForDiagnostics: "primary associated type clause",
        isOptional: true
      ),
      Child(
        name: "InheritanceClause",
        kind: .node(kind: "TypeInheritanceClause"),
        nameForDiagnostics: "inheritance clause",
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
      Child(
        name: "MemberBlock",
        kind: .node(kind: "MemberDeclBlock")
      ),
    ]
  ),

  // return-clause ->
  //   '->' type
  Node(
    name: "ReturnClause",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "Arrow",
        kind: .token(choices: [.token(tokenKind: "ArrowToken")])
      ),
      Child(
        name: "ReturnType",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "return type"
      ),
    ]
  ),

  // source-file = code-block-item-list eof
  Node(
    name: "SourceFile",
    nameForDiagnostics: "source file",
    kind: "Syntax",
    traits: [
      "WithStatements"
    ],
    parserFunction: "parseSourceFile",
    children: [
      Child(
        name: "Statements",
        kind: .collection(kind: "CodeBlockItemList", collectionElementName: "Statement")
      ),
      Child(
        name: "EOFToken",
        kind: .node(kind: "EOFToken")
      ),
    ]
  ),

  // struct-declaration -> attributes? access-level-modifier?
  //                         'struct' struct-name
  //                         generic-parameter-clause?
  //                           type-inheritance-clause?
  //                         generic-where-clause?
  //                         '{' struct-members '}'
  // struct-name -> identifier
  Node(
    name: "StructDecl",
    nameForDiagnostics: "struct",
    kind: "Decl",
    traits: [
      "DeclGroup",
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "StructKeyword",
        kind: .token(choices: [.keyword(text: "struct")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        isOptional: true
      ),
      Child(
        name: "InheritanceClause",
        kind: .node(kind: "TypeInheritanceClause"),
        nameForDiagnostics: "type inheritance clause",
        isOptional: true
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
      Child(
        name: "MemberBlock",
        kind: .node(kind: "MemberDeclBlock")
      ),
    ]
  ),

  Node(
    name: "SubscriptDecl",
    nameForDiagnostics: "subscript",
    kind: "Decl",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "SubscriptKeyword",
        kind: .token(choices: [.keyword(text: "subscript")])
      ),
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        isOptional: true
      ),
      Child(
        name: "Indices",
        kind: .node(kind: "ParameterClause")
      ),
      Child(
        name: "Result",
        kind: .node(kind: "ReturnClause")
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
      Child(
        name: "Accessor",
        kind: .nodeChoices(choices: [
          Child(
            name: "Accessors",
            kind: .node(kind: "AccessorBlock")
          ),
          Child(
            name: "Getter",
            kind: .node(kind: "CodeBlock")
          ),
        ]),
        isOptional: true
      ),
    ]
  ),

  // type-inheritance-clause -> ':' type
  Node(
    name: "TypeInheritanceClause",
    nameForDiagnostics: "inheritance clause",
    kind: "Syntax",
    children: [
      Child(
        name: "Colon",
        kind: .token(choices: [.token(tokenKind: "ColonToken")])
      ),
      Child(
        name: "InheritedTypeCollection",
        kind: .collection(kind: "InheritedTypeList", collectionElementName: "InheritedType")
      ),
    ]
  ),

  // type-assignment -> '=' type
  Node(
    name: "TypeInitializerClause",
    nameForDiagnostics: nil,
    kind: "Syntax",
    children: [
      Child(
        name: "Equal",
        kind: .token(choices: [.token(tokenKind: "EqualToken")])
      ),
      Child(
        name: "Value",
        kind: .node(kind: "Type"),
        nameForDiagnostics: "type"
      ),
    ]
  ),

  // typealias-declaration -> attributes? access-level-modifier? 'typealias'
  //                            typealias-name generic-parameter-clause?
  //                            type-assignment
  // typealias-name -> identifier
  Node(
    name: "TypealiasDecl",
    nameForDiagnostics: "typealias declaration",
    kind: "Decl",
    traits: [
      "IdentifiedDecl",
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "TypealiasKeyword",
        kind: .token(choices: [.keyword(text: "typealias")])
      ),
      Child(
        name: "Identifier",
        kind: .token(choices: [.token(tokenKind: "IdentifierToken")])
      ),
      Child(
        name: "GenericParameterClause",
        kind: .node(kind: "GenericParameterClause"),
        nameForDiagnostics: "generic parameter clause",
        isOptional: true
      ),
      Child(
        name: "Initializer",
        kind: .node(kind: "TypeInitializerClause")
      ),
      Child(
        name: "GenericWhereClause",
        kind: .node(kind: "GenericWhereClause"),
        nameForDiagnostics: "generic where clause",
        isOptional: true
      ),
    ]
  ),

  Node(
    name: "VariableDecl",
    nameForDiagnostics: "variable",
    kind: "Decl",
    traits: [
      "WithAttributes",
      "WithModifiers",
    ],
    children: [
      Child(
        name: "Attributes",
        kind: .collection(kind: "AttributeList", collectionElementName: "Attribute"),
        nameForDiagnostics: "attributes",
        isOptional: true
      ),
      Child(
        name: "Modifiers",
        kind: .collection(kind: "ModifierList", collectionElementName: "Modifier"),
        nameForDiagnostics: "modifiers",
        isOptional: true
      ),
      Child(
        name: "BindingKeyword",
        kind: .token(choices: [.keyword(text: "let"), .keyword(text: "var"), .keyword(text: "inout")])
      ),
      Child(
        name: "Bindings",
        kind: .collection(kind: "PatternBindingList", collectionElementName: "Binding")
      ),
    ]
  ),

]
